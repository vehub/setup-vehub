# setup-vehub

You can find more details About veHub on https://vehub.vector.com/docs/

This action sets up the veHub CLI to be used in subsequent steps in your workflow.

You can find more details on how to use the CLI here: [vehub.vector.com/docs/cli/](https://vehub.vector.com/docs/cli/).

## Usage

Example usage:

```yaml
# ...
steps:
  - name: Setup veHub CLI
    uses: vehub/setup-vehub@v1

  - name: Check installation
    run: vehub --version
    
  - name: List project spaces
    run: vehub space list
    env:
      VEHUB_TOKEN: ${{ secrets.VEHUB_TOKEN }}
```

## Limitations

The action is currently supported on Linux and Windows runners. 
However, the CLI is also available for macOS. Open a ticket if you need support for this.
