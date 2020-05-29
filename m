Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFB1E760C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE2Gjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34998 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbgE2Gjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYgA-000jvb-9I; Fri, 29 May 2020 09:39:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:24 +0300
Message-Id: <iwlwifi.20200529092401.c3242ff3ba5c.Icb48c8d61bede5dda7ef267bff10e4798e9dc77b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/11] iwlwifi: acpi: support device specific method (DSM)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

ACPI Device Specific Method (DSM) allows standardized feature
configuration through the ACPI interface without the namespace
pollution of the usual mechanism (ACPI method for each feature).
Add generic function for evaluating DSM objects and function for
evaluating a DSM with no arguments and a single int return value.
also implement the required backport for UUID.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 99 +++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 22 +++++
 2 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e2184ba4d8b5..dc769b580431 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -58,44 +58,121 @@
  *
  *****************************************************************************/
 
+#include <linux/uuid.h>
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "acpi.h"
 #include "fw/runtime.h"
 
-void *iwl_acpi_get_object(struct device *dev, acpi_string method)
+static const guid_t intel_wifi_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
+						0xA5, 0xB3, 0x1F, 0x73,
+						0x8E, 0x28, 0x5A, 0xDE);
+
+static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
+			       acpi_handle *ret_handle)
 {
 	acpi_handle root_handle;
-	acpi_handle handle;
-	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
 	acpi_status status;
 
 	root_handle = ACPI_HANDLE(dev);
 	if (!root_handle) {
 		IWL_DEBUG_DEV_RADIO(dev,
-				    "Could not retrieve root port ACPI handle\n");
-		return ERR_PTR(-ENOENT);
+				    "ACPI: Could not retrieve root port handle\n");
+		return -ENOENT;
 	}
 
-	/* Get the method's handle */
-	status = acpi_get_handle(root_handle, method, &handle);
+	status = acpi_get_handle(root_handle, method, ret_handle);
 	if (ACPI_FAILURE(status)) {
-		IWL_DEBUG_DEV_RADIO(dev, "%s method not found\n", method);
-		return ERR_PTR(-ENOENT);
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: %s method not found\n", method);
+		return -ENOENT;
 	}
+	return 0;
+}
+
+void *iwl_acpi_get_object(struct device *dev, acpi_string method)
+{
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_handle handle;
+	acpi_status status;
+	int ret;
+
+	ret = iwl_acpi_get_handle(dev, method, &handle);
+	if (ret)
+		return ERR_PTR(-ENOENT);
 
 	/* Call the method with no arguments */
 	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
 	if (ACPI_FAILURE(status)) {
-		IWL_DEBUG_DEV_RADIO(dev, "%s invocation failed (0x%x)\n",
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: %s method invocation failed (status: 0x%x)\n",
 				    method, status);
 		return ERR_PTR(-ENOENT);
 	}
-
 	return buf.pointer;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_object);
 
+/**
+* Generic function for evaluating a method defined in the device specific
+* method (DSM) interface. The returned acpi object must be freed by calling
+* function.
+*/
+void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
+			      union acpi_object *args)
+{
+	union acpi_object *obj;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_wifi_guid, rev, func,
+				args);
+	if (!obj) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: DSM method invocation failed (rev: %d, func:%d)\n",
+				    rev, func);
+		return ERR_PTR(-ENOENT);
+	}
+	return obj;
+}
+
+/**
+ * Evaluate a DSM with no arguments and a single u8 return value (inside a
+ * buffer object), verify and return that value.
+ */
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
+{
+	union acpi_object *obj;
+	int ret;
+
+	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL);
+	if (IS_ERR(obj))
+		return -ENOENT;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: DSM method did not return a valid object, type=%d\n",
+				    obj->type);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (obj->buffer.length != sizeof(u8)) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: DSM method returned invalid buffer, length=%d\n",
+				    obj->buffer.length);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = obj->buffer.pointer[0];
+	IWL_DEBUG_DEV_RADIO(dev,
+			    "ACPI: DSM method evaluated: func=%d, ret=%d\n",
+			    func, ret);
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u8);
+
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
 					 int data_size, int *tbl_rev)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 6a646dc524e1..0ada9eddb8b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -127,12 +127,23 @@ struct iwl_geo_profile {
 	u8 values[ACPI_GEO_TABLE_SIZE];
 };
 
+enum iwl_dsm_funcs_rev_0 {
+	DSM_FUNC_QUERY = 0,
+	DSM_FUNC_DISABLE_SRD = 1,
+	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
+};
+
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
 
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
 
+void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
+			      union acpi_object *args);
+
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func);
+
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
 					 int data_size, int *tbl_rev);
@@ -192,6 +203,17 @@ static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
 	return ERR_PTR(-ENOENT);
 }
 
+static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
+					    int func, union acpi_object *args)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+static inline int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func)
+{
+	return -ENOENT;
+}
+
 static inline union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 						       union acpi_object *data,
 						       int data_size,
-- 
2.26.2

