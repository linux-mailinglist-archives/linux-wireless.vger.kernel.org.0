Return-Path: <linux-wireless+bounces-27317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B4B5730B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F45165064
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6752EFDB6;
	Mon, 15 Sep 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7rcNbI5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941012EFDA8
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925309; cv=none; b=ES7qt8UoR0TChWs1xGtYKuts9jYXdfyLQo34bzUdtqfPGRI7Aw6m14cOntNB7BywWx7Z22Mndq2Y5G/rnp3DLD8DiJ9ZfmYiW0vZpDkj/4BaBM+CJrPrjqJJnHyBxVSP3u0tKbUJVwOQxbaUqVOchEQZ7HyVSurgQ8ecEqpL0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925309; c=relaxed/simple;
	bh=NSGIInGhAGiYUbWmEwI7oHCcZPlb/mGzEBm98Ik4Nyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ukogf5I2zotmC8L5O/HC1J6p3N7t0bti5T9z1u4fT3EGMYb5zl7RO5LstrJybl+OCbIpRE2LLvqND1UFA+Qnjf4t/Y39PHja1SZMBKmMGXZaR7xdyAMWK05HU5tZSh/UrPikfuLvVgVr83gwFs2uqNxDrcdxCOa6t5LI/WK4WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7rcNbI5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925308; x=1789461308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSGIInGhAGiYUbWmEwI7oHCcZPlb/mGzEBm98Ik4Nyw=;
  b=Q7rcNbI5979B/lk61IcS/LMtTKtMt0yCNIiOUbscYAdySZZAyXHcFUuT
   jrZuOnsRiXvLoYtS2YUY3aOvNYcmfChK7zI8CO6+3GjdukQlaUxnjO77I
   tpxT8u1a7d0uo/fzV0fesM4allXR4ob9C70B1a6ShIoxwQi3P1d35+Jxc
   G4/tmHhgfnwQYrf7yJ+AzTWKiS/Ire6gvVr3EERlZPH9VRtDRpyI1IOmb
   FdfwnW+JP3PTJgl+Vc84k0lswtyy9jrZ7Qg6RPffgdyEz72Xcn3WlrhTj
   BoN7pLuWy/0x+9MgwMJ3R7zCDb2p59S0otgZI0kuvrz/MJmRf7B5hzh8s
   g==;
X-CSE-ConnectionGUID: ITKmS3m2RUCfPrBgbdlmAA==
X-CSE-MsgGUID: 3iiY5o49RBKZq7PRB90opQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213076"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213076"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:07 -0700
X-CSE-ConnectionGUID: 2VKaU01FQY2h9Fy0CAfPew==
X-CSE-MsgGUID: pb/Xq3smSo6dOGlsj78e5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569880"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/11] wifi: iwlwifi: iwlmld is always used for wifi7 devices
Date: Mon, 15 Sep 2025 11:34:26 +0300
Message-Id: <20250915113137.45ab33fcdc00.Ia3a40b687b75c872cf7e7a19331a014bccf5f2d6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlmld is used since API 97 and for wifi7 devices.
Since APIs < 97 are no longer supported on such devices,
we can remove the API check and always load iwlmld for the wifi7
devices.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 607fcea6f4ef..7d58e294618d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -179,7 +179,8 @@ static inline char iwl_drv_get_step(int step)
 
 static bool iwl_drv_is_wifi7_supported(struct iwl_trans *trans)
 {
-	return CSR_HW_RFID_TYPE(trans->info.hw_rf_id) >= IWL_CFG_RF_TYPE_FM;
+	return trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
+	       CSR_HW_RFID_TYPE(trans->info.hw_rf_id) >= IWL_CFG_RF_TYPE_FM;
 }
 
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
@@ -427,7 +428,6 @@ struct iwl_firmware_pieces {
 	size_t dbg_trigger_tlv_len[FW_DBG_TRIGGER_MAX];
 	struct iwl_fw_dbg_mem_seg_tlv *dbg_mem_tlv;
 	size_t n_mem_tlv;
-	u32 major;
 };
 
 static void alloc_sec_data(struct iwl_firmware_pieces *pieces,
@@ -1069,19 +1069,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			break;
 		case IWL_UCODE_TLV_FW_VERSION: {
 			const __le32 *ptr = (const void *)tlv_data;
-			u32 minor;
+			u32 major, minor;
 			u8 local_comp;
 
 			if (tlv_len != sizeof(u32) * 3)
 				goto invalid_tlv_len;
 
-			pieces->major = le32_to_cpup(ptr++);
+			major = le32_to_cpup(ptr++);
 			minor = le32_to_cpup(ptr++);
 			local_comp = le32_to_cpup(ptr);
 
 			snprintf(drv->fw.fw_version,
 				 sizeof(drv->fw.fw_version),
-				 "%u.%08x.%u %s", pieces->major, minor,
+				 "%u.%08x.%u %s", major, minor,
 				 local_comp, iwl_reduced_fw_name(drv));
 			break;
 			}
@@ -1589,8 +1589,6 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
 	}
 }
 
-#define IWL_MLD_SUPPORTED_FW_VERSION 97
-
 /*
  * iwl_req_fw_callback - callback when firmware was loaded
  *
@@ -1859,12 +1857,10 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	}
 
 #if IS_ENABLED(CONFIG_IWLMLD)
-	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION &&
-	    iwl_drv_is_wifi7_supported(drv->trans))
+	if (iwl_drv_is_wifi7_supported(drv->trans))
 		op = &iwlwifi_opmode_table[MLD_OP_MODE];
 #else
-	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION &&
-	    iwl_drv_is_wifi7_supported(drv->trans)) {
+	if (iwl_drv_is_wifi7_supported(drv->trans)) {
 		IWL_ERR(drv,
 			"IWLMLD needs to be compiled to support this firmware\n");
 		mutex_unlock(&iwlwifi_opmode_table_mtx);
-- 
2.34.1


