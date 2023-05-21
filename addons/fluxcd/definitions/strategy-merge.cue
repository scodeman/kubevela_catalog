"kustomize-strategy-merge": {
	attributes: {
		podDisruptive: false
	}
	description: "A list of strategic merge to kustomize config"
	labels: {
		"ui-hidden": "true"
	}
	type: "trait"
	annotations: {
		 "addon.oam.dev/ignore-without-component": "fluxcd-kustomize-controller"
  }
}

template: {
	patch: {
		spec: {
			if context.name == "helm" {
			postRenderers: [{ kustomize: patchesStrategicMerge: parameter.patchesStrategicMerge }]
			}
			if context.name != "helm" {
			patches: parameter.patchesStrategicMerge	
			}	
		}
	}

	parameter: {
		// +usage=a list of strategicmerge, defined as inline yaml objects.
		patchesStrategicMerge: [...#nestedmap]
	}

	#nestedmap: {
		...
	}
}
