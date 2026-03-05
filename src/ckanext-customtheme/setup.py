from setuptools import find_packages, setup


setup(
    name="ckanext-customtheme",
    version="0.1.0",
    description="Custom theme extension for CKAN template and CSS overrides",
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[],
    entry_points="""
        [ckan.plugins]
        customtheme=ckanext.customtheme.plugin:CustomThemePlugin
    """,
)
