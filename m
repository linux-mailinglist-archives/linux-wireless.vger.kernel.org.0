Return-Path: <linux-wireless+bounces-2620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1E83F477
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CF9284721
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD2CA4E;
	Sun, 28 Jan 2024 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nzn2SkQQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC71C129
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424910; cv=none; b=SMzsZwnMKH8oXrAoH+uIaO5YiW/BC7zSNvH+1W+65sBZ0RxYY4JXBtis2PXQnThxAqYpwlP9ysywHp8K9+r7ATl6/ZfUs0Gj1jve24YInlFUPVQvRWS7FIN/Fe8dMFc+R9ouoIqNkUFSn8ls0lwRf9q3RYZmO/G5gwE4W8vgkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424910; c=relaxed/simple;
	bh=9nBb8n87j1zivUmJziGspHsDrxZC+svUYU7tsi1Y2JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6VTVHRaJOTmmexZMbBfuUcm4ciO+TPVeAKR0f2HMgBTNl5m8580fbfdRfSh/VCic2pHCADd4giEQ88hzhZr13UpsA3eKHsnvs0a4ECTMgCN2+Eo3aHbTNg3sCzB1c31NXRtGztOD3X/cPS1G9Oi2qCgOtMIoaBNjyUsgQIzrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nzn2SkQQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424909; x=1737960909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nBb8n87j1zivUmJziGspHsDrxZC+svUYU7tsi1Y2JE=;
  b=Nzn2SkQQVlea/tBvL+bV8Tz0Z8SKixURONAvtucj6j4WXZzB4l4InyEu
   kv1I+VxBjoXoF2GNmQZXtBWY7afI8UPsUaqtG8Dgdjp8z4j/ml9hNJO1P
   V9spkSfWXh33ahaxSXptAm+WaV3wpxW0TxvuC6CaINmP798i+W9vtWVlt
   p4TDFqN1wOEqireu0dNl6IraeAT7AcqjaKfvHRXHQxaRXiaLuwxdl2aIS
   IQgPI08gaEAu5LUjlkdtRKimKWsCNhp+cXMsFYPZpDHBrNP9xdEIIPVyz
   nCErlktKKgXNMyBfluFC+/HpeXMJTjU4uPqY/lzUSnA60xrzpn3P1r4+t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217700"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833392"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: cleanup uefi variables loading
Date: Sun, 28 Jan 2024 08:54:00 +0200
Message-Id: <20240128084842.454f32c4bcfe.I4835fe657475ac28ef6aef4d292fac63c6ce9a34@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Extract the logic that is common to all variables loading
to a function.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 128 ++++++++-----------
 1 file changed, 51 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 2964c5fb11e9..9c432d7b3674 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -76,6 +76,42 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
+static
+void *iwl_uefi_get_verified_variable(struct iwl_trans *trans,
+				     efi_char16_t *uefi_var_name,
+				     char *var_name,
+				     unsigned int expected_size,
+				     unsigned long *size)
+{
+	void *var;
+	unsigned long var_size;
+
+	var = iwl_uefi_get_variable(uefi_var_name, &IWL_EFI_VAR_GUID,
+				    &var_size);
+
+	if (IS_ERR(var)) {
+		IWL_DEBUG_RADIO(trans,
+				"%s UEFI variable not found 0x%lx\n", var_name,
+				PTR_ERR(var));
+		return var;
+	}
+
+	if (var_size < expected_size) {
+		IWL_DEBUG_RADIO(trans,
+				"Invalid %s UEFI variable len (%lu)\n",
+				var_name, var_size);
+		kfree(var);
+		return ERR_PTR(-EINVAL);
+	}
+
+	IWL_DEBUG_RADIO(trans, "%s from UEFI with size %lu\n", var_name,
+			var_size);
+
+	if (size)
+		*size = var_size;
+	return var;
+}
+
 int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data)
 {
@@ -230,26 +266,13 @@ u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 	unsigned long package_size;
 	u8 *data;
 
-	package = iwl_uefi_get_variable(IWL_UEFI_REDUCED_POWER_NAME,
-					&IWL_EFI_VAR_GUID, &package_size);
-
-	if (IS_ERR(package)) {
-		IWL_DEBUG_FW(trans,
-			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
-			     PTR_ERR(package), package_size);
+	package = iwl_uefi_get_verified_variable(trans,
+						 IWL_UEFI_REDUCED_POWER_NAME,
+						 "Reduced Power",
+						 sizeof(*package),
+						 &package_size);
+	if (IS_ERR(package))
 		return ERR_CAST(package);
-	}
-
-	if (package_size < sizeof(*package)) {
-		IWL_DEBUG_FW(trans,
-			     "Invalid Reduced Power UEFI variable len (%lu)\n",
-			     package_size);
-		kfree(package);
-		return ERR_PTR(-EINVAL);
-	}
-
-	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
-		     package_size);
 
 	IWL_DEBUG_FW(trans, "rev %d, total_size %d, n_skus %d\n",
 		     package->rev, package->total_size, package->n_skus);
@@ -283,32 +306,15 @@ static int iwl_uefi_step_parse(struct uefi_cnv_common_step_data *common_step_dat
 void iwl_uefi_get_step_table(struct iwl_trans *trans)
 {
 	struct uefi_cnv_common_step_data *data;
-	unsigned long package_size;
 	int ret;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
-	data = iwl_uefi_get_variable(IWL_UEFI_STEP_NAME, &IWL_EFI_VAR_GUID,
-				     &package_size);
-
-	if (IS_ERR(data)) {
-		IWL_DEBUG_FW(trans,
-			     "STEP UEFI variable not found 0x%lx\n",
-			     PTR_ERR(data));
-		return;
-	}
-
-	if (package_size < sizeof(*data)) {
-		IWL_DEBUG_FW(trans,
-			     "Invalid STEP table UEFI variable len (%lu)\n",
-			     package_size);
-		kfree(data);
+	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_STEP_NAME,
+					      "STEP", sizeof(*data), NULL);
+	if (IS_ERR(data))
 		return;
-	}
-
-	IWL_DEBUG_FW(trans, "Read STEP from UEFI with size %lu\n",
-		     package_size);
 
 	ret = iwl_uefi_step_parse(data, trans);
 	if (ret < 0)
@@ -355,31 +361,15 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 			     struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_wlan_sgom_data *data;
-	unsigned long package_size;
 	int ret;
 
 	if (!fwrt->geo_enabled)
 		return;
 
-	data = iwl_uefi_get_variable(IWL_UEFI_SGOM_NAME, &IWL_EFI_VAR_GUID,
-				     &package_size);
-	if (IS_ERR(data)) {
-		IWL_DEBUG_FW(trans,
-			     "SGOM UEFI variable not found 0x%lx\n",
-			     PTR_ERR(data));
+	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_SGOM_NAME,
+					      "SGOM", sizeof(*data), NULL);
+	if (IS_ERR(data))
 		return;
-	}
-
-	if (package_size < sizeof(*data)) {
-		IWL_DEBUG_FW(trans,
-			     "Invalid SGOM table UEFI variable len (%lu)\n",
-			     package_size);
-		kfree(data);
-		return;
-	}
-
-	IWL_DEBUG_FW(trans, "Read SGOM from UEFI with size %lu\n",
-		     package_size);
 
 	ret = iwl_uefi_sgom_parse(data, fwrt);
 	if (ret < 0)
@@ -404,28 +394,12 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_wlan_uats_data *data;
-	unsigned long package_size;
 	int ret;
 
-	data = iwl_uefi_get_variable(IWL_UEFI_UATS_NAME, &IWL_EFI_VAR_GUID,
-				     &package_size);
-	if (IS_ERR(data)) {
-		IWL_DEBUG_FW(trans,
-			     "UATS UEFI variable not found 0x%lx\n",
-			     PTR_ERR(data));
+	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_UATS_NAME,
+					      "UATS", sizeof(*data), NULL);
+	if (IS_ERR(data))
 		return -EINVAL;
-	}
-
-	if (package_size < sizeof(*data)) {
-		IWL_DEBUG_FW(trans,
-			     "Invalid UATS table UEFI variable len (%lu)\n",
-			     package_size);
-		kfree(data);
-		return -EINVAL;
-	}
-
-	IWL_DEBUG_FW(trans, "Read UATS from UEFI with size %lu\n",
-		     package_size);
 
 	ret = iwl_uefi_uats_parse(data, fwrt);
 	if (ret < 0) {
-- 
2.34.1


