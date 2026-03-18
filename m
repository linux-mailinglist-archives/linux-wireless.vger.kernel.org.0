Return-Path: <linux-wireless+bounces-33426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELUXFEcRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C010E2C2BC6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1887231585B7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2436F438;
	Wed, 18 Mar 2026 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT0HswiR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D243371D08
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867287; cv=none; b=Kx1434PSNzJT9Rbnkv0GP/Ud9o+LnVnYFNGOZsu1y9KYl1YuzI7J9SwJBDCZ6HeyOHiViTRKq4t1BfFVCfTfA32BXRaFQmHXp5zQ/4TlaKq6/82Lwpwy7e68h5uwL+5W9PFEipGef/Mg9zAO89asqmXn/7SDzbN3d6cNH8Am4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867287; c=relaxed/simple;
	bh=4bjDSYDRf7fMC7BVagZfUpfI/p5Pb7FlxkYpmBJQ8NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBmlyhYyCLvU2CMMw4SsUKcUPsPcN2up2WSuy1vDpzj/TiK+BzNLZBvZ3rK9qbOmob25M2E4YSvfUkVogYgPotNGRDAHGIxuzvJbX6JAIVJKEDJpO9xHvMSSqLG0f4A4XsOXmgt27sYTgWRFcAWwpXaeGDvLclkAAfwB4tucWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT0HswiR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867284; x=1805403284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bjDSYDRf7fMC7BVagZfUpfI/p5Pb7FlxkYpmBJQ8NQ=;
  b=HT0HswiRQb7UKr6iJQP/WVQBJ3li4KK33LQjn5vimqAlXXnySr0+jXjL
   z94BhN6kaZD8XbJUiyUF1MajThmg91gaPKu5+5AojW6HNFzWc0o+OCgKg
   8qM5zfz3p1CpJHgV+pFkbW7yD2TImcZhPC0Gv0bMpLFQMnOiswyiHUf90
   IQSsYAbQG+F2FWrM/w/E2gX+MZPZY7PSwD6mnkg3tTkidU3xvNCw6sVHO
   qGN2kmSJlDBuI3KcumFBN1Z9HzR3VdKd0u2OPrjTZWd5+1nxiY4Cv2Y1k
   JZO8NDhpW9QFSNwJB/as81zlYLRsOTCNFw8vbMbCixyATWSOOqHUAby0i
   Q==;
X-CSE-ConnectionGUID: jZclxbxHS6CN8ZydZhWJZw==
X-CSE-MsgGUID: XIoSTWAlQmii3XFQF43gqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010008"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010008"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:43 -0700
X-CSE-ConnectionGUID: NKn0/W09Tn2MKK+1KQ5omg==
X-CSE-MsgGUID: eZlmK2H9S9qOm8qRdHygCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793850"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2
Date: Wed, 18 Mar 2026 22:54:16 +0200
Message-Id: <20260318225236.b839655712c5.I3dfca54bd19d6bd5f7ca385ea63be086ece9c1d0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33426-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C010E2C2BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

There is a new version of this command to indicate which AP type in
UNII-9 is supported per country.

This adds support for a new UEFI table that will include that data to be
filled in the new AP type table.
Rename the uats_table field in firmware_runtime structure since it
includes now the UATS and the new UNEB table coming from UEFI.
For the same reason, rename iwl_mld_init_uats.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 14 ++++++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  8 ++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 36 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 11 ++++++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  2 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 32 ++++++++++++++---
 .../wireless/intel/iwlwifi/mld/regulatory.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 24 +++++++------
 8 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index bd6bf931866f..25c860a05b0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -701,13 +701,23 @@ struct iwl_pnvm_init_complete_ntfy {
 #define UATS_TABLE_COL_SIZE	13
 
 /**
- * struct iwl_mcc_allowed_ap_type_cmd - struct for MCC_ALLOWED_AP_TYPE_CMD
+ * struct iwl_mcc_allowed_ap_type_cmd_v1 - struct for MCC_ALLOWED_AP_TYPE_CMD
  * @mcc_to_ap_type_map: mapping an MCC to 6 GHz AP type support (UATS)
  * @reserved: reserved
  */
-struct iwl_mcc_allowed_ap_type_cmd {
+struct iwl_mcc_allowed_ap_type_cmd_v1 {
 	u8 mcc_to_ap_type_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
 	__le16 reserved;
 } __packed; /* MCC_ALLOWED_AP_TYPE_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_mcc_allowed_ap_type_cmd - struct for MCC_ALLOWED_AP_TYPE_CMD
+ * @mcc_to_ap_type_map: mapping an MCC to 6 GHz AP type support (UATS)
+ * @mcc_to_ap_type_unii9_map: mapping an MCC to UNII-9 AP type support allowed
+ */
+struct iwl_mcc_allowed_ap_type_cmd {
+	u8 mcc_to_ap_type_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
+	u8 mcc_to_ap_type_unii9_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
+} __packed; /* MCC_ALLOWED_AP_TYPE_CMD_API_S_VER_2 */
+
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index ff186fb2e0da..411e75b45530 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -106,8 +106,8 @@ struct iwl_txf_iter_data {
  * @cur_fw_img: current firmware image, must be maintained by
  *	the driver by calling &iwl_fw_set_current_image()
  * @dump: debug dump data
- * @uats_table: AP type table
- * @uats_valid: is AP type table valid
+ * @ap_type_cmd: AP type tables (for enablement on 6 GHz)
+ * @ap_type_cmd_valid: if &ap_type_cmd is valid
  * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
  *	0: Unlocked, 1 and 2: Locked.
  *	Only read the UEFI variables if locked.
@@ -213,8 +213,8 @@ struct iwl_fw_runtime {
 	u8 ppag_bios_source;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
-	struct iwl_mcc_allowed_ap_type_cmd uats_table;
-	bool uats_valid;
+	struct iwl_mcc_allowed_ap_type_cmd ap_type_cmd;
+	bool ap_type_cmd_valid;
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
 	enum bios_source dsm_source;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index a7ba86e06c09..d4e1ab1f7c84 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -402,11 +402,11 @@ static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
 	if (uats_data->revision != 1)
 		return -EINVAL;
 
-	memcpy(fwrt->uats_table.mcc_to_ap_type_map,
+	memcpy(fwrt->ap_type_cmd.mcc_to_ap_type_map,
 	       uats_data->mcc_to_ap_type_map,
-	       sizeof(fwrt->uats_table.mcc_to_ap_type_map));
+	       sizeof(fwrt->ap_type_cmd.mcc_to_ap_type_map));
 
-	fwrt->uats_valid = true;
+	fwrt->ap_type_cmd_valid = true;
 
 	return 0;
 }
@@ -429,6 +429,36 @@ void iwl_uefi_get_uats_table(struct iwl_trans *trans,
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
 
+void iwl_uefi_get_uneb_table(struct iwl_trans *trans,
+			     struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_wlan_uneb_data *data;
+
+	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_UNEB_NAME,
+					      "UNEB", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return;
+
+	if (data->revision != 1) {
+		IWL_DEBUG_RADIO(fwrt,
+				"Cannot read UNEB table. rev is invalid\n");
+		goto out;
+	}
+
+	BUILD_BUG_ON(sizeof(data->mcc_to_ap_type_map) !=
+		     sizeof(fwrt->ap_type_cmd.mcc_to_ap_type_unii9_map));
+
+	memcpy(fwrt->ap_type_cmd.mcc_to_ap_type_unii9_map,
+	       data->mcc_to_ap_type_map,
+	       sizeof(fwrt->ap_type_cmd.mcc_to_ap_type_unii9_map));
+
+	fwrt->ap_type_cmd_valid = true;
+
+out:
+	kfree(data);
+}
+IWL_EXPORT_SYMBOL(iwl_uefi_get_uneb_table);
+
 static void iwl_uefi_set_sar_profile(struct iwl_fw_runtime *fwrt,
 				     struct uefi_sar_profile *uefi_sar_prof,
 				     u8 prof_index, bool enabled)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 349ac1505ad7..99170a72c3f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -25,6 +25,7 @@
 #define IWL_UEFI_PUNCTURING_NAME	L"UefiCnvWlanPuncturing"
 #define IWL_UEFI_DSBR_NAME		L"UefiCnvCommonDSBR"
 #define IWL_UEFI_WPFC_NAME		L"WPFC"
+#define IWL_UEFI_UNEB_NAME		L"CnvUefiWlanUNEB"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -63,6 +64,9 @@ struct uefi_cnv_wlan_uats_data {
 	u8 mcc_to_ap_type_map[IWL_UATS_MAP_SIZE - 1];
 } __packed;
 
+/* UNEB's layout is identical to UATS's */
+#define uefi_cnv_wlan_uneb_data uefi_cnv_wlan_uats_data
+
 struct uefi_cnv_common_step_data {
 	u8 revision;
 	u8 step_mode;
@@ -274,6 +278,8 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
 void iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			     struct iwl_fw_runtime *fwrt);
+void iwl_uefi_get_uneb_table(struct iwl_trans *trans,
+			     struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt);
@@ -373,6 +379,11 @@ iwl_uefi_get_uats_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
 {
 }
 
+static inline void
+iwl_uefi_get_uneb_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
+{
+}
+
 static inline
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 19da521a4bab..7b1fb84a641c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -513,7 +513,7 @@ static int iwl_mld_config_fw(struct iwl_mld *mld)
 		return ret;
 
 	iwl_mld_init_tas(mld);
-	iwl_mld_init_uats(mld);
+	iwl_mld_init_ap_type_tables(mld);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 6ab5a3410353..d1a55b565898 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -64,6 +64,7 @@ void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 	}
 
 	iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
+	iwl_uefi_get_uneb_table(mld->trans, &mld->fwrt);
 
 	iwl_bios_get_phy_filters(&mld->fwrt);
 }
@@ -352,21 +353,42 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 				ret);
 }
 
-void iwl_mld_init_uats(struct iwl_mld *mld)
+void iwl_mld_init_ap_type_tables(struct iwl_mld *mld)
 {
 	int ret;
 	struct iwl_host_cmd cmd = {
 		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
 			      MCC_ALLOWED_AP_TYPE_CMD),
-		.data[0] = &mld->fwrt.uats_table,
-		.len[0] =  sizeof(mld->fwrt.uats_table),
+		.data[0] = &mld->fwrt.ap_type_cmd,
+		.len[0] =  sizeof(mld->fwrt.ap_type_cmd),
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 
-	if (!mld->fwrt.uats_valid)
+	if (!mld->fwrt.ap_type_cmd_valid)
 		return;
 
-	ret = iwl_mld_send_cmd(mld, &cmd);
+	if (iwl_fw_lookup_cmd_ver(mld->fw, cmd.id, 1) == 1) {
+		struct iwl_mcc_allowed_ap_type_cmd_v1 *cmd_v1 =
+			kzalloc(sizeof(*cmd_v1), GFP_KERNEL);
+
+		if (!cmd_v1)
+			return;
+
+		BUILD_BUG_ON(sizeof(mld->fwrt.ap_type_cmd.mcc_to_ap_type_map) !=
+			     sizeof(cmd_v1->mcc_to_ap_type_map));
+
+		memcpy(cmd_v1->mcc_to_ap_type_map,
+		       mld->fwrt.ap_type_cmd.mcc_to_ap_type_map,
+		       sizeof(mld->fwrt.ap_type_cmd.mcc_to_ap_type_map));
+
+		cmd.data[0] = cmd_v1;
+		cmd.len[0] = sizeof(*cmd_v1);
+		ret = iwl_mld_send_cmd(mld, &cmd);
+		kfree(cmd_v1);
+	} else {
+		ret = iwl_mld_send_cmd(mld, &cmd);
+	}
+
 	if (ret)
 		IWL_ERR(mld, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
 			ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
index 3b01c645adda..5498c19789f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
@@ -9,7 +9,7 @@
 
 void iwl_mld_get_bios_tables(struct iwl_mld *mld);
 void iwl_mld_configure_lari(struct iwl_mld *mld);
-void iwl_mld_init_uats(struct iwl_mld *mld);
+void iwl_mld_init_ap_type_tables(struct iwl_mld *mld);
 void iwl_mld_init_tas(struct iwl_mld *mld);
 
 int iwl_mld_init_ppag(struct iwl_mld *mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 43cf94c9a36b..f5e5c10cc581 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -459,23 +459,18 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 
 static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 {
+	int cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
+			     MCC_ALLOWED_AP_TYPE_CMD);
+	struct iwl_mcc_allowed_ap_type_cmd_v1 cmd = {};
 	u8 cmd_ver;
 	int ret;
-	struct iwl_host_cmd cmd = {
-		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
-			      MCC_ALLOWED_AP_TYPE_CMD),
-		.flags = 0,
-		.data[0] = &mvm->fwrt.uats_table,
-		.len[0] =  sizeof(mvm->fwrt.uats_table),
-		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
-	};
 
 	if (mvm->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
 		return;
 	}
 
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver != 1) {
 		IWL_DEBUG_RADIO(mvm,
@@ -486,10 +481,17 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 
 	iwl_uefi_get_uats_table(mvm->trans, &mvm->fwrt);
 
-	if (!mvm->fwrt.uats_valid)
+	if (!mvm->fwrt.ap_type_cmd_valid)
 		return;
 
-	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	BUILD_BUG_ON(sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map) !=
+		     sizeof(cmd.mcc_to_ap_type_map));
+
+	memcpy(cmd.mcc_to_ap_type_map,
+	       mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map,
+	       sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map));
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
 			ret);
-- 
2.34.1


