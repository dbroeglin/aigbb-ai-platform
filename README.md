# DevContainer Template for AI work

This is a template for working on Development Containers or GitHub Codespaces with Python and Jupyter Notebooks that I use when working on AI Development projects.

Feedback and bug reports are very welcome! Please open an GitHub issue if you find something that needs fixing or improvement.

## Usage

WIP

```
azd up
```

The following commands will allow public access to the ML workspace:
```
source <(azd env get-values)
az extension add --name ml
az ml workspace update --name $WORKSPACE_HUB_NAME --resource-group $AZURE_RESOURCE_GROUP_NAME --public-network-access Enabled
```

## Cleanup


```
azd down --purge --force
```