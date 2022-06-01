from easyexplore.data_import_export import DataImporter
#from happy_learning.feature_engineer import FeatureEngineer
from happy_learning.genetic_algorithm import GeneticAlgorithm
from typing import List

import boto3
import io
import json
import numpy as np
import os
import pandas as pd

S3_INPUT_BUCKET: str = 's3://gfb-ml-ops-training'
S3_MODEL_BUCKET: str = 's3://gfb-ml-ops-model'
S3_PROCESSOR_FOLDER: str = 'processing'
S3_TRAINING_DATA_FOLDER: str = 'training_data'
TRAINING_FILE_NAME: str = 'training_data.csv'
PROCESSOR_FILE_NAME: str = 'processor.json'
REGION: str = 'eu-central-1'


def main():
    """
    Run modeling
    """
    _s3_resource = boto3.resource('s3')
    _training_data_file_path: str = os.path.join(S3_MODEL_BUCKET, S3_TRAINING_DATA_FOLDER, TRAINING_FILE_NAME)
    _df: pd.DataFrame = DataImporter(file_path=_training_data_file_path, as_data_frame=True, use_dask=False, sep=';', cloud='aws').file()
    _processor_file_path: str = os.path.join(S3_PROCESSOR_FOLDER, PROCESSOR_FILE_NAME)
    _processor: dict = json.loads(_s3_resource.Bucket(S3_MODEL_BUCKET.split('//')[1]).Object(_processor_file_path).get()['Body'].read())
    print('Start modeling using evolutionary algorithm ...')
    _ga: GeneticAlgorithm = GeneticAlgorithm(mode='model', target=_processor.get('target_feature'), features=_processor.get('predictors'), df=_df, models=['cat'], max_generations=2, pop_size=10, cloud='aws', verbose=True, mlflow_log=False, output_file_path=S3_OUTPUT_BUCKET)
    _ga.optimize()
    print('Finished modeling')


if __name__ == '__main__':
    main()
