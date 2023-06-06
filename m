Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDC723A73
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjFFHve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbjFFHuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C510C0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037562; x=1717573562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1netjZiN/1OcgGsT9bryJOm0nzX4csbBGhAVMC2ELk=;
  b=iefJhHia8e4JrkCChSytPLp5QZ4PMNCpasdJjKqB1h2exQlkl3ukxVXF
   SSQMhR4RXDU4vTkDxuhdQrfnQv0D9jA7lcz9/yqyIX552nnP42RqQFbIz
   +laMrb7p14IB4p+47PWLBwLqKalL60GsMIcAAIBWxE5EpGvMDGuL7aC5j
   eSjGKQMPcwb+SUOw81ONyOitSghH6Q2BrENeXTgzcaLYD6423AAvnkQO3
   3+W7Lgbt1EqIpg9KDNGmPdXjALPkjriTQ79Nqr3ietYkOiHCnA/ZtULB+
   SEV6EX6cefWqMuexGa4y9wMiQuFuAgE9lF2Z8+MDi6BKWDO4CIgSCEol+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419125"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516434"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516434"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/13] wifi: iwlwifi: fw: don't use constant size with efi.get_variable
Date:   Tue,  6 Jun 2023 10:43:09 +0300
Message-Id: <20230606103519.ef95a8055a50.Iae5389baaf0a9a3c89469f7502275ee119d378b6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Use efi.get_variable() with NULL pointer for data in order to
obtain entry size and then call it again with the correct size
to get the entry itself.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 143 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h |  13 +-
 2 files changed, 74 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 1666ef3a482e..488b9fb79743 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -17,38 +17,53 @@
 				  0xb2, 0xec, 0xf5, 0xa3,	\
 				  0x59, 0x4f, 0x4a, 0xea)
 
-void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
+static void *iwl_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
+				   unsigned long *data_size)
 {
-	void *data;
-	unsigned long package_size;
 	efi_status_t status;
+	void *data;
 
-	*len = 0;
+	if (!data_size)
+		return ERR_PTR(-EINVAL);
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return ERR_PTR(-ENODEV);
 
-	/*
-	 * TODO: we hardcode a maximum length here, because reading
-	 * from the UEFI is not working.  To implement this properly,
-	 * we have to call efivar_entry_size().
-	 */
-	package_size = IWL_HARDCODED_PNVM_SIZE;
+	/* first call with NULL data to get the exact entry size */
+	*data_size = 0;
+	status = efi.get_variable(name, guid, NULL, data_size, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL || !*data_size)
+		return ERR_PTR(-EIO);
 
-	data = kmalloc(package_size, GFP_KERNEL);
+	data = kmalloc(*data_size, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	status = efi.get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_VAR_GUID,
-				  NULL, &package_size, data);
+	status = efi.get_variable(name, guid, NULL, data_size, data);
 	if (status != EFI_SUCCESS) {
-		IWL_DEBUG_FW(trans,
-			     "PNVM UEFI variable not found 0x%lx (len %lu)\n",
-			     status, package_size);
 		kfree(data);
 		return ERR_PTR(-ENOENT);
 	}
 
+	return data;
+}
+
+void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
+{
+	unsigned long package_size;
+	void *data;
+
+	*len = 0;
+
+	data = iwl_uefi_get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_VAR_GUID,
+				     &package_size);
+	if (IS_ERR(data)) {
+		IWL_DEBUG_FW(trans,
+			     "PNVM UEFI variable not found 0x%lx (len %lu)\n",
+			     PTR_ERR(data), package_size);
+		return data;
+	}
+
 	IWL_DEBUG_FW(trans, "Read PNVM from UEFI with size %lu\n", package_size);
 	*len = package_size;
 
@@ -185,31 +200,24 @@ u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 {
 	struct pnvm_sku_package *package;
 	unsigned long package_size;
-	efi_status_t status;
 	u8 *data;
 
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
-		return ERR_PTR(-ENODEV);
-
-	/*
-	 * TODO: we hardcode a maximum length here, because reading
-	 * from the UEFI is not working.  To implement this properly,
-	 * we have to call efivar_entry_size().
-	 */
-	package_size = IWL_HARDCODED_REDUCE_POWER_SIZE;
+	package = iwl_uefi_get_variable(IWL_UEFI_REDUCED_POWER_NAME,
+					&IWL_EFI_VAR_GUID, &package_size);
 
-	package = kmalloc(package_size, GFP_KERNEL);
-	if (!package)
-		return ERR_PTR(-ENOMEM);
-
-	status = efi.get_variable(IWL_UEFI_REDUCED_POWER_NAME, &IWL_EFI_VAR_GUID,
-				  NULL, &package_size, package);
-	if (status != EFI_SUCCESS) {
+	if (IS_ERR(package)) {
 		IWL_DEBUG_FW(trans,
 			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
-			     status, package_size);
+			     PTR_ERR(package), package_size);
+		return ERR_CAST(package);
+	}
+
+	if (package_size < sizeof(*package)) {
+		IWL_DEBUG_FW(trans,
+			     "Invalid Reduced Power UEFI variable len (%lu)\n",
+			     package_size);
 		kfree(package);
-		return ERR_PTR(-ENOENT);
+		return ERR_PTR(-EINVAL);
 	}
 
 	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
@@ -220,8 +228,11 @@ u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 
 	*len = package_size - sizeof(*package);
 	data = kmemdup(package->data, *len, GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		kfree(package);
 		return ERR_PTR(-ENOMEM);
+	}
+
 	kfree(package);
 
 	return data;
@@ -245,31 +256,27 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 {
 	struct uefi_cnv_common_step_data *data;
 	unsigned long package_size;
-	efi_status_t status;
 	int ret;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
-		return;
+	data = iwl_uefi_get_variable(IWL_UEFI_STEP_NAME, &IWL_EFI_VAR_GUID,
+				     &package_size);
 
-	/* TODO: we hardcode a maximum length here, because reading
-	 * from the UEFI is not working.  To implement this properly,
-	 * we have to call efivar_entry_size().
-	 */
-	package_size = IWL_HARDCODED_STEP_SIZE;
-
-	data = kmalloc(package_size, GFP_KERNEL);
-	if (!data)
+	if (IS_ERR(data)) {
+		IWL_DEBUG_FW(trans,
+			     "STEP UEFI variable not found 0x%lx\n",
+			     PTR_ERR(data));
 		return;
+	}
 
-	status = efi.get_variable(IWL_UEFI_STEP_NAME, &IWL_EFI_VAR_GUID,
-				  NULL, &package_size, data);
-	if (status != EFI_SUCCESS) {
+	if (package_size < sizeof(*data)) {
 		IWL_DEBUG_FW(trans,
-			     "STEP UEFI variable not found 0x%lx\n", status);
-		goto out_free;
+			     "Invalid STEP table UEFI variable len (%lu)\n",
+			     package_size);
+		kfree(data);
+		return;
 	}
 
 	IWL_DEBUG_FW(trans, "Read STEP from UEFI with size %lu\n",
@@ -279,7 +286,6 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 	if (ret < 0)
 		IWL_DEBUG_FW(trans, "Cannot read STEP tables. rev is invalid\n");
 
-out_free:
 	kfree(data);
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_step_table);
@@ -322,29 +328,26 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 {
 	struct uefi_cnv_wlan_sgom_data *data;
 	unsigned long package_size;
-	efi_status_t status;
 	int ret;
 
-	if (!fwrt->geo_enabled ||
-	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+	if (!fwrt->geo_enabled)
 		return;
 
-	/* TODO: we hardcode a maximum length here, because reading
-	 * from the UEFI is not working.  To implement this properly,
-	 * we have to call efivar_entry_size().
-	 */
-	package_size = IWL_HARDCODED_SGOM_SIZE;
-
-	data = kmalloc(package_size, GFP_KERNEL);
-	if (!data)
+	data = iwl_uefi_get_variable(IWL_UEFI_SGOM_NAME, &IWL_EFI_VAR_GUID,
+				     &package_size);
+	if (IS_ERR(data)) {
+		IWL_DEBUG_FW(trans,
+			     "SGOM UEFI variable not found 0x%lx\n",
+			     PTR_ERR(data));
 		return;
+	}
 
-	status = efi.get_variable(IWL_UEFI_SGOM_NAME, &IWL_EFI_VAR_GUID,
-				  NULL, &package_size, data);
-	if (status != EFI_SUCCESS) {
+	if (package_size < sizeof(*data)) {
 		IWL_DEBUG_FW(trans,
-			     "SGOM UEFI variable not found 0x%lx\n", status);
-		goto out_free;
+			     "Invalid SGOM table UEFI variable len (%lu)\n",
+			     package_size);
+		kfree(data);
+		return;
 	}
 
 	IWL_DEBUG_FW(trans, "Read SGOM from UEFI with size %lu\n",
@@ -354,9 +357,7 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 	if (ret < 0)
 		IWL_DEBUG_FW(trans, "Cannot read SGOM tables. rev is invalid\n");
 
-out_free:
 	kfree(data);
-
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_sgom_table);
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 10bed372e67c..dc7ccf49d92d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -10,16 +10,7 @@
 #define IWL_UEFI_SGOM_NAME		L"UefiCnvWlanSarGeoOffsetMapping"
 #define IWL_UEFI_STEP_NAME		L"UefiCnvCommonSTEP"
 
-/*
- * TODO: we have these hardcoded values that the caller must pass,
- * because reading from the UEFI is not working.  To implement this
- * properly, we have to change iwl_pnvm_get_from_uefi() to call
- * efivar_entry_size() and return the value to the caller instead.
- */
-#define IWL_HARDCODED_PNVM_SIZE		4096
-#define IWL_HARDCODED_REDUCE_POWER_SIZE	32768
-#define IWL_HARDCODED_SGOM_SIZE		339
-#define IWL_HARDCODED_STEP_SIZE		6
+#define IWL_SGOM_MAP_SIZE		339
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -31,7 +22,7 @@ struct pnvm_sku_package {
 
 struct uefi_cnv_wlan_sgom_data {
 	u8 revision;
-	u8 offset_map[IWL_HARDCODED_SGOM_SIZE - 1];
+	u8 offset_map[IWL_SGOM_MAP_SIZE - 1];
 } __packed;
 
 struct uefi_cnv_common_step_data {
-- 
2.38.1

