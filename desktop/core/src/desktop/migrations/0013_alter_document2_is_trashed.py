# Generated by Django 3.2.4 on 2021-07-07 00:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('desktop', '0012_connector_interface'),
    ]

    operations = [
        migrations.AlterField(
            model_name='document2',
            name='is_trashed',
            field=models.BooleanField(db_index=True, default=False, null=True, verbose_name='True if trashed'),
        ),
    ]
