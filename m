Return-Path: <linux-wireless+bounces-7208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3388BC808
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F531C212BC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0901140369;
	Mon,  6 May 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3c/9DqT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE184DFA
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979104; cv=none; b=PG0+vDEe1MxCjFt1K6fqLLxBIAL8mroJ7lO0SHP3C+MsjJ9wvWQ3bktZC7heF1RxkU4/rIsgwxFLFEXaeHjhV49N7oezQUe3tNhjtM94aiN0I0ZMnM+TJn2b13fihhXpvtW9ZdCoT2YthV5lpSoqZm/xzfr5RuuKp91Abq2jHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979104; c=relaxed/simple;
	bh=jRVwnHxKIwZHdZWVps26pPuLu5rVFlQanT1/nnl7FaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtOWOtHS8xcl62x7ciTUxGr1kGdlAp0p1OzzhqLIChaxuEpASBdk5HeF8ia1yuHP5K2z1wPh7dLcoNgvbYJK9BDLWMx2XZKppwPwcJzm7HcHbS1TdObY4yTxotgHCP342+AuycOdN/bdeCj4h15rAo5TH3725zyeCWZQTsqkUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3c/9DqT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979104; x=1746515104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRVwnHxKIwZHdZWVps26pPuLu5rVFlQanT1/nnl7FaA=;
  b=H3c/9DqTkyyNjVeKKMY1QB3iqEKbvypm/J+KUGCNCfRMXDFEPfWmaPJI
   Ip9JtzBJUGnBjlApRXN0qyHPDAM5HhJre0cUsXzKZcNJZdxO675EzQrLn
   fx/SXJSPfW3HCeI3qt1iJqyocjV91+XzKLegK5JNS4qfuddYSFQS1LxGv
   HaPilMr/zI259Ac6TZaG5MLI7HxouIq38peJIU4f46frwMsl9pj1KBdeg
   4Ygu7y+nR9VgpiVFo/ei2aWJrH5lOXlkI2C3PE2yVmXIxcWHQxWaHUCEq
   TlJB/aPEqeKUCox6Y87HnXwk1yPuKmjDI/azk5Nm2e2IOi85aFAZaBI+s
   w==;
X-CSE-ConnectionGUID: EhWtTNMRQE+F35PX1SSuMQ==
X-CSE-MsgGUID: wsua3YY+QhqLwlHEqeI86w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638243"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638243"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:49 -0700
X-CSE-ConnectionGUID: vMktc04KQ0aFJY38zgpbfQ==
X-CSE-MsgGUID: gFXadkw6SDeDZPwf/hUNgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264958"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: align UATS naming with firmware
Date: Mon,  6 May 2024 10:04:15 +0300
Message-Id: <20240506095953.b0dfe17d5f44.I8f5f5a831c7b934ce3140f838315827c018103bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware has different names for this, which is confusing
as even the convention of having the firmware name in a comment
after the struct definition wasn't met here. Fix the naming,
but keep UATS in some of it since that's the BIOS name.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |  9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index c9c0329f5778..a08497a04733 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -46,9 +46,9 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	SAR_OFFSET_MAPPING_TABLE_CMD = 0x4,
 
 	/**
-	 * @UATS_TABLE_CMD: &struct iwl_uats_table_cmd
+	 * @MCC_ALLOWED_AP_TYPE_CMD: &struct iwl_mcc_allowed_ap_type_cmd
 	 */
-	UATS_TABLE_CMD = 0x5,
+	MCC_ALLOWED_AP_TYPE_CMD = 0x5,
 
 	/**
 	 * @PNVM_INIT_COMPLETE_NTFY: &struct iwl_pnvm_init_complete_ntfy
@@ -701,13 +701,13 @@ struct iwl_pnvm_init_complete_ntfy {
 #define UATS_TABLE_COL_SIZE	13
 
 /**
- * struct iwl_uats_table_cmd - struct for UATS_TABLE_CMD
+ * struct iwl_mcc_allowed_ap_type_cmd - struct for MCC_ALLOWED_AP_TYPE_CMD
  * @offset_map: mapping a mcc to UHB AP type support (UATS) allowed
  * @reserved: reserved
  */
-struct iwl_uats_table_cmd {
+struct iwl_mcc_allowed_ap_type_cmd {
 	u8 offset_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
 	__le16 reserved;
-} __packed; /* UATS_TABLE_CMD_S_VER_1 */
+} __packed; /* MCC_ALLOWED_AP_TYPE_CMD_API_S_VER_1 */
 
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 4204e999bbf2..9122f9a1260a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -182,7 +182,7 @@ struct iwl_fw_runtime {
 	u8 ppag_ver;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
-	struct iwl_uats_table_cmd uats_table;
+	struct iwl_mcc_allowed_ap_type_cmd uats_table;
 	u8 uefi_tables_lock_status;
 	bool uats_enabled;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 74b299139391..e7f5978ef2d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -494,7 +494,7 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 	int ret;
 	struct iwl_host_cmd cmd = {
 		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
-			      UATS_TABLE_CMD),
+			      MCC_ALLOWED_AP_TYPE_CMD),
 		.flags = 0,
 		.data[0] = &mvm->fwrt.uats_table,
 		.len[0] =  sizeof(mvm->fwrt.uats_table),
@@ -516,7 +516,7 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver != 1) {
 		IWL_DEBUG_RADIO(mvm,
-				"UATS_TABLE_CMD ver %d not supported\n",
+				"MCC_ALLOWED_AP_TYPE_CMD ver %d not supported\n",
 				cmd_ver);
 		return;
 	}
@@ -529,9 +529,10 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret < 0)
-		IWL_ERR(mvm, "failed to send UATS_TABLE_CMD (%d)\n", ret);
+		IWL_ERR(mvm, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
+			ret);
 	else
-		IWL_DEBUG_RADIO(mvm, "UATS_TABLE_CMD sent to FW\n");
+		IWL_DEBUG_RADIO(mvm, "MCC_ALLOWED_AP_TYPE_CMD sent to FW\n");
 }
 
 static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
-- 
2.34.1


