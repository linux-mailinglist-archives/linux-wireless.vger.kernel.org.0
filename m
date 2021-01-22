Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66958300380
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 13:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhAVMx7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 07:53:59 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:41630 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726997AbhAVMxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 07:53:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l2vvg-003vnH-GS; Fri, 22 Jan 2021 14:52:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Jan 2021 14:52:36 +0200
Message-Id: <iwlwifi.20210122144849.5757092adcd6.Ic24524627b899c9a01af38107a62a626bdf5ae3a@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122125242.107146-1-luca@coelho.fi>
References: <20210122125242.107146-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 1/7] iwlwifi: mvm: fix the return type for DSM functions 1 and 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matt Chen <matt.chen@intel.com>

The return type value of functions 1 and 2 were considered to be an
integer inside a buffer, but they can also be only an integer, without
the buffer.  Fix the code in iwl_acpi_get_dsm_u8() to handle it as a
single integer value, as well as packed inside a buffer.

Signed-off-by: Matt Chen <matt.chen@intel.com>
Fixes: 9db93491f29e ("iwlwifi: acpi: support device specific method (DSM)")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 65 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  7 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 25 ++++----
 3 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 15248b064380..d8b7776a8dde 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -80,19 +80,45 @@ static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
 }
 
 /*
- * Evaluate a DSM with no arguments and a single u8 return value (inside a
- * buffer object), verify and return that value.
+ * Generic function to evaluate a DSM with no arguments
+ * and an integer return value,
+ * (as an integer object or inside a buffer object),
+ * verify and assign the value in the "value" parameter.
+ * return 0 in success and the appropriate errno otherwise.
  */
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
+static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
+				    u64 *value, size_t expected_size)
 {
 	union acpi_object *obj;
-	int ret;
+	int ret = 0;
 
 	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL);
-	if (IS_ERR(obj))
+	if (IS_ERR(obj)) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "Failed to get  DSM object. func= %d\n",
+				    func);
 		return -ENOENT;
+	}
+
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		*value = obj->integer.value;
+	} else if (obj->type == ACPI_TYPE_BUFFER) {
+		__le64 le_value = 0;
 
-	if (obj->type != ACPI_TYPE_BUFFER) {
+		if (WARN_ON_ONCE(expected_size > sizeof(le_value)))
+			return -EINVAL;
+
+		/* if the buffer size doesn't match the expected size */
+		if (obj->buffer.length != expected_size)
+			IWL_DEBUG_DEV_RADIO(dev,
+					    "ACPI: DSM invalid buffer size, padding or truncating (%d)\n",
+					    obj->buffer.length);
+
+		 /* assuming LE from Intel BIOS spec */
+		memcpy(&le_value, obj->buffer.pointer,
+		       min_t(size_t, expected_size, (size_t)obj->buffer.length));
+		*value = le64_to_cpu(le_value);
+	} else {
 		IWL_DEBUG_DEV_RADIO(dev,
 				    "ACPI: DSM method did not return a valid object, type=%d\n",
 				    obj->type);
@@ -100,15 +126,6 @@ int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
 		goto out;
 	}
 
-	if (obj->buffer.length != sizeof(u8)) {
-		IWL_DEBUG_DEV_RADIO(dev,
-				    "ACPI: DSM method returned invalid buffer, length=%d\n",
-				    obj->buffer.length);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = obj->buffer.pointer[0];
 	IWL_DEBUG_DEV_RADIO(dev,
 			    "ACPI: DSM method evaluated: func=%d, ret=%d\n",
 			    func, ret);
@@ -116,6 +133,24 @@ int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
 	ACPI_FREE(obj);
 	return ret;
 }
+
+/*
+ * Evaluate a DSM with no arguments and a u8 return value,
+ */
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value)
+{
+	int ret;
+	u64 val;
+
+	ret = iwl_acpi_get_dsm_integer(dev, rev, func, &val, sizeof(u8));
+
+	if (ret < 0)
+		return ret;
+
+	/* cast val (u64) to be u8 */
+	*value = (u8)val;
+	return 0;
+}
 IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u8);
 
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 042dd247d387..1cce30d1ef55 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_fw_acpi__
 #define __iwl_fw_acpi__
@@ -99,7 +99,7 @@ struct iwl_fw_runtime;
 
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
 
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func);
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value);
 
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
@@ -159,7 +159,8 @@ static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
 	return ERR_PTR(-ENOENT);
 }
 
-static inline int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
+static inline
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0637eb1cff4e..313e9f106f46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1090,20 +1090,22 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 
 static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
 {
+	u8 value;
+
 	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_ENABLE_INDONESIA_5G2);
+				      DSM_FUNC_ENABLE_INDONESIA_5G2, &value);
 
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm,
 				"Failed to evaluate DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
 				ret);
 
-	else if (ret >= DSM_VALUE_INDONESIA_MAX)
+	else if (value >= DSM_VALUE_INDONESIA_MAX)
 		IWL_DEBUG_RADIO(mvm,
-				"DSM function ENABLE_INDONESIA_5G2 return invalid value, ret=%d\n",
-				ret);
+				"DSM function ENABLE_INDONESIA_5G2 return invalid value, value=%d\n",
+				value);
 
-	else if (ret == DSM_VALUE_INDONESIA_ENABLE) {
+	else if (value == DSM_VALUE_INDONESIA_ENABLE) {
 		IWL_DEBUG_RADIO(mvm,
 				"Evaluated DSM function ENABLE_INDONESIA_5G2: Enabling 5g2\n");
 		return DSM_VALUE_INDONESIA_ENABLE;
@@ -1114,25 +1116,26 @@ static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
 
 static u8 iwl_mvm_eval_dsm_disable_srd(struct iwl_mvm *mvm)
 {
+	u8 value;
 	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_DISABLE_SRD);
+				      DSM_FUNC_DISABLE_SRD, &value);
 
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm,
 				"Failed to evaluate DSM function DISABLE_SRD, ret=%d\n",
 				ret);
 
-	else if (ret >= DSM_VALUE_SRD_MAX)
+	else if (value >= DSM_VALUE_SRD_MAX)
 		IWL_DEBUG_RADIO(mvm,
-				"DSM function DISABLE_SRD return invalid value, ret=%d\n",
-				ret);
+				"DSM function DISABLE_SRD return invalid value, value=%d\n",
+				value);
 
-	else if (ret == DSM_VALUE_SRD_PASSIVE) {
+	else if (value == DSM_VALUE_SRD_PASSIVE) {
 		IWL_DEBUG_RADIO(mvm,
 				"Evaluated DSM function DISABLE_SRD: setting SRD to passive\n");
 		return DSM_VALUE_SRD_PASSIVE;
 
-	} else if (ret == DSM_VALUE_SRD_DISABLE) {
+	} else if (value == DSM_VALUE_SRD_DISABLE) {
 		IWL_DEBUG_RADIO(mvm,
 				"Evaluated DSM function DISABLE_SRD: disabling SRD\n");
 		return DSM_VALUE_SRD_DISABLE;
-- 
2.29.2

