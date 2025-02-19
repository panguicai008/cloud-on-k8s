// Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
// or more contributor license agreements. Licensed under the Elastic License 2.0;
// you may not use this file except in compliance with the Elastic License 2.0.

package license

import ulog "github.com/elastic/cloud-on-k8s/v2/pkg/utils/log"

var log = ulog.Log.WithName("license")

const (
	// FileName is the name used in the license secret to point to the license data.
	FileName = "license"
)
