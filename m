Return-Path: <linux-wireless+bounces-26742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A7AB396E4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C32F7B5B76
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C02EA480;
	Thu, 28 Aug 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5K2xxCU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8122E0934
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369623; cv=none; b=GkFsGle2pAyDQNIIIF4eqZescn0CqVSJfaalcgbmRS8/A/K+m0/HI4Tj9jj/ixGGY02BNGckO75XDM6yjHcoWC3RqjHDHIMlrgdKjlnSWIDOnCwcwCFSK0fHYCs5xKBeWksduVlGicolnd6GfoOGjR6rZf+zARdd+UAq9sdrm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369623; c=relaxed/simple;
	bh=GLijPc2vSt/mPYIeUj8BsmEA+d3HNSdIK8griklH0K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jtq6xyiXxBIVDRXvK701wK4WT584DrucY4P2j038QwnsXceMTVqo5cP3wKTUr0NrSH1OtoQmZC+h5l9F5zU4G3qS7/bfVsrPr9rLishMvN0guU2TmbnVm2c92smHX0o7gSmCdqdn02zMz+/ZXuGf6h7pV97iLxycTRhfnJAVmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5K2xxCU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369622; x=1787905622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GLijPc2vSt/mPYIeUj8BsmEA+d3HNSdIK8griklH0K8=;
  b=O5K2xxCUJpuBHZgZ44qgFkd0JcW+eAEGt1eoMnVQu0C7i/z6dWnm/i2K
   QD7nJR58yZioDSpy+LCbNqMOAHQ/bzbpP/0qe9l0AhkMMWJRQmO6PLQhj
   2vDJIRD2aAyHEVRPaUwXSoHWCsLPjJ6CBID9QvHdPKmFa/atSLaU2zhmk
   q44dxL1aX/dnFmZUAIZ4hHvmU/0jaMZegl+om4JPY2eruqriLLn8W6Sx+
   WtY3kbeziFWNB0AWhSMXiHt2yBq6FeNsCCr5JcpSvQxQDZJBqnYV1JOUQ
   66qduDTw4z7YOjCRLoKx2hXnJtFsFK7zrI5AKP7SD4/zstOnuC5FrYQJm
   g==;
X-CSE-ConnectionGUID: jboHUpo5R+qXYM0Z73SwbA==
X-CSE-MsgGUID: 8DgNx6VNQgSPh8kdBs25fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003372"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003372"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:48 -0700
X-CSE-ConnectionGUID: LpJTiUrBQlSVe4D+UCpFrA==
X-CSE-MsgGUID: pGfo9mtiTmaJYd7P/J5dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224530"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: carefully select the PNVM source
Date: Thu, 28 Aug 2025 11:25:59 +0300
Message-Id: <20250828111032.7e75d33e3c28.I87fbcd25bbee733d2612206b76c2d8593d0cbd39@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

For newer device, and from API 100 (core 97), the PNVM should be taken
from the .ucode file, and not from an external .pnvm file.

In the current logic, if the PNVM doesn't exist in the .ucode file, we
fallback to fetching the .ucode file. This is wrong and hides bugs.

This fallback was needed for (a) old devices and (b) for newer
devices with an old API.

Since we no longer support those old APIs, (b) is not longer relevant.
We can, according to the device, select the right PNVM source
and fail if we couldn't find the PNVM there.

Add clear logic to select the expected PNVM source, and print an error
if we couldn't get the PNVM from there.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 69 +++++++++++++++++---
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 0421a84a44a8..f297e82d63d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -266,17 +266,60 @@ static u8 *iwl_pnvm_get_from_fs(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
+/**
+ * enum iwl_pnvm_source - different PNVM possible sources
+ *
+ * @IWL_PNVM_SOURCE_NONE: No PNVM.
+ * @IWL_PNVM_SOURCE_BIOS: PNVM should be read from BIOS.
+ * @IWL_PNVM_SOURCE_EXTERNAL: read .pnvm external file
+ * @IWL_PNVM_SOURCE_EMBEDDED: PNVM is embedded in the .ucode file.
+ */
+enum iwl_pnvm_source {
+	IWL_PNVM_SOURCE_NONE,
+	IWL_PNVM_SOURCE_BIOS,
+	IWL_PNVM_SOURCE_EXTERNAL,
+	IWL_PNVM_SOURCE_EMBEDDED
+};
+
+static enum iwl_pnvm_source iwl_select_pnvm_source(struct iwl_trans *trans,
+						   bool intel_sku)
+{
+
+	/* Get PNVM from BIOS for non-Intel SKU */
+	if (!intel_sku)
+		return IWL_PNVM_SOURCE_BIOS;
+
+	/* Before those devices, PNVM didn't exist at all */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return IWL_PNVM_SOURCE_NONE;
+
+	/* After those devices, we moved to embedded PNVM */
+	if (trans->mac_cfg->device_family > IWL_DEVICE_FAMILY_AX210)
+		return IWL_PNVM_SOURCE_EMBEDDED;
+
+	/* For IWL_DEVICE_FAMILY_AX210, depends on the CRF */
+	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_GF)
+		return IWL_PNVM_SOURCE_EXTERNAL;
+
+	return IWL_PNVM_SOURCE_NONE;
+}
+
 static const u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 				    __le32 sku_id[3], const struct iwl_fw *fw)
 {
 	struct pnvm_sku_package *package;
+	enum iwl_pnvm_source pnvm_src =
+		iwl_select_pnvm_source(trans_p, sku_id[2] == 0);
+	u8 *image = NULL;
 
-	/* Get PNVM from BIOS for non-Intel SKU */
-	if (sku_id[2]) {
+	IWL_DEBUG_FW(trans_p, "PNVM source %d\n", pnvm_src);
+
+	if (pnvm_src == IWL_PNVM_SOURCE_NONE)
+		return NULL;
+
+	if (pnvm_src == IWL_PNVM_SOURCE_BIOS) {
 		package = iwl_uefi_get_pnvm(trans_p, len);
 		if (!IS_ERR_OR_NULL(package)) {
-			u8 *image = NULL;
-
 			if (*len >= sizeof(*package)) {
 				/* we need only the data */
 				*len -= sizeof(*package);
@@ -291,16 +334,26 @@ static const u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 			if (image)
 				return image;
 		}
+
+		/* PNVM doesn't exist in BIOS. Find the fallback source */
+		pnvm_src = iwl_select_pnvm_source(trans_p, true);
+		IWL_DEBUG_FW(trans_p, "PNVM in BIOS doesn't exist, try %d\n",
+			     pnvm_src);
 	}
 
-	if (fw->pnvm_data) {
-		*len = fw->pnvm_size;
+	if (pnvm_src == IWL_PNVM_SOURCE_EXTERNAL) {
+		image = iwl_pnvm_get_from_fs(trans_p, len);
+		if (image)
+			return image;
+	}
 
+	if (pnvm_src == IWL_PNVM_SOURCE_EMBEDDED && fw->pnvm_data) {
+		*len = fw->pnvm_size;
 		return fw->pnvm_data;
 	}
 
-	/* If it's not available, or for Intel SKU, try from the filesystem */
-	return iwl_pnvm_get_from_fs(trans_p, len);
+	IWL_ERR(trans_p, "Couldn't get PNVM from required source: %d\n", pnvm_src);
+	return NULL;
 }
 
 static void
-- 
2.34.1


