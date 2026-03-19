Return-Path: <linux-wireless+bounces-33473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIxRGgPCu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A42C8ACF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D9731CF132
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18EF3AF64F;
	Thu, 19 Mar 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXurD/wO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2C3B47CE
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911398; cv=none; b=tSEd8CmvQJS9VdizMnOLZIqWfsha+kleKXAAra+abw6ptH+xTDLjP6BEm/puz8IoOCvbNxaA+kysbE2D+ZupWLzjMo4+c41M751Ddp0fL/pVAcTk9wsJ1OB5T402UBx/V7IPsWAgV2xymetcS11Gv0Diq00PYOFDRTHrayTMnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911398; c=relaxed/simple;
	bh=5iSYZq3LU7EnQBmKIbSz1I6oXJCBjO591EtzZ3HAU8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgTF5cca2TPuTcBiUQkMco4UMWpfshqAuZXvATJAaMLIXXS55BcWXHptcNGTMi9VMJ29KbkcAr35h5kadVoLEW5N7G6AAFke7W3zgrTqzh0JHPyylepC1iYe8rqjq09bEwoHD2r1L/DIbyoZmIOIzDPJfHl4cZnHY0cx4hMn5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXurD/wO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911394; x=1805447394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5iSYZq3LU7EnQBmKIbSz1I6oXJCBjO591EtzZ3HAU8M=;
  b=LXurD/wO2k+r2MNPD9wiuPD79kQbjwxqKT5QF/3lfqhYcGsmp64d0DU+
   YBt1OqjRk3AdIWUmW7putU2bft3VkSHNZk8kGs9GSawKWmWB6M0OVQPO/
   2HTI1VTEwpQBDTmyI32hpZjDfNWlQSx1CDchlyCsEIJ+OT63Lc7ZhNYxG
   nT7p8KRUq6kLXxDgt916+bmhydgTSecCg8T0MH8aCQXLF3hfbTDVh8E/1
   jQNkY+gOplVhhzaWqp6vcnQQh4Pu2ck2A5IYy16EcSZ9pMniII3czNR7d
   RoGQgUH/PFTk0KS3F6yEoPAHZKY51kbvUSRCFGGI+HufIksnqHot4wAov
   g==;
X-CSE-ConnectionGUID: /t9+ZhunSOCUWLtJcsrKrA==
X-CSE-MsgGUID: a6AK4ySMRFe92NE6ph32hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992728"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:52 -0700
X-CSE-ConnectionGUID: fSxOQDDxRoOM0I4skI3ANg==
X-CSE-MsgGUID: 4qEL1n+MTrahXjU7DgpsRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387150"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: bring iwl_fill_ppag_table to the iwlmvm
Date: Thu, 19 Mar 2026 11:09:22 +0200
Message-Id: <20260319110722.1f9b38ff7d22.I5c7482c074d63cd18533ac83289cc0b26c1be3d2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33473-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 032A42C8ACF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

iwl_fill_ppag_table fills a command that is sent to the firmware. This
command has several versions and handling those different versions is
the responsibility of the op_mode.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 126 -----------------
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   4 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 129 +++++++++++++++++-
 3 files changed, 128 insertions(+), 131 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 5793c267daf7..9e834cc1b054 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -304,132 +304,6 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_sar_fill_profile);
 
-static bool iwl_ppag_value_valid(struct iwl_fw_runtime *fwrt, int chain,
-				 int subband)
-{
-	s8 ppag_val = fwrt->ppag_chains[chain].subbands[subband];
-
-	if ((subband == 0 &&
-	     (ppag_val > IWL_PPAG_MAX_LB || ppag_val < IWL_PPAG_MIN_LB)) ||
-	    (subband != 0 &&
-	     (ppag_val > IWL_PPAG_MAX_HB || ppag_val < IWL_PPAG_MIN_HB))) {
-		IWL_DEBUG_RADIO(fwrt, "Invalid PPAG value: %d\n", ppag_val);
-		return false;
-	}
-	return true;
-}
-
-/* Utility function for iwlmvm and iwlxvt */
-int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
-			union iwl_ppag_table_cmd *cmd, int *cmd_size)
-{
-	u8 cmd_ver;
-	int i, j, num_sub_bands;
-	s8 *gain;
-	bool send_ppag_always;
-
-	/* many firmware images for JF lie about this */
-	if (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id) ==
-	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
-		return -EOPNOTSUPP;
-
-	if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
-		IWL_DEBUG_RADIO(fwrt,
-				"PPAG capability not supported by FW, command not sent.\n");
-		return -EINVAL;
-	}
-
-	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
-					WIDE_ID(PHY_OPS_GROUP,
-						PER_PLATFORM_ANT_GAIN_CMD), 1);
-	/*
-	 * Starting from ver 4, driver needs to send the PPAG CMD regardless
-	 * if PPAG is enabled/disabled or valid/invalid.
-	 */
-	send_ppag_always = cmd_ver > 3;
-
-	/* Don't send PPAG if it is disabled */
-	if (!send_ppag_always && !fwrt->ppag_flags) {
-		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
-		return -EINVAL;
-	}
-
-	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
-	if (cmd_ver == 1) {
-		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-		gain = cmd->v1.gain[0];
-		*cmd_size = sizeof(cmd->v1);
-		cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V1_MASK);
-		if (fwrt->ppag_bios_rev >= 1) {
-			/* in this case FW supports revision 0 */
-			IWL_DEBUG_RADIO(fwrt,
-					"PPAG table rev is %d, send truncated table\n",
-					fwrt->ppag_bios_rev);
-		}
-	} else if (cmd_ver == 5) {
-		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = cmd->v5.gain[0];
-		*cmd_size = sizeof(cmd->v5);
-		cmd->v5.flags = cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
-		if (fwrt->ppag_bios_rev == 0) {
-			/* in this case FW supports revisions 1,2 or 3 */
-			IWL_DEBUG_RADIO(fwrt,
-					"PPAG table rev is 0, send padded table\n");
-		}
-	} else if (cmd_ver == 7) {
-		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = cmd->v7.gain[0];
-		*cmd_size = sizeof(cmd->v7);
-		cmd->v7.ppag_config_info.hdr.table_source =
-			fwrt->ppag_bios_source;
-		cmd->v7.ppag_config_info.hdr.table_revision =
-			fwrt->ppag_bios_rev;
-		cmd->v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
-	} else {
-		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
-		return -EINVAL;
-	}
-
-	/* ppag mode */
-	IWL_DEBUG_RADIO(fwrt,
-			"PPAG MODE bits were read from bios: %d\n",
-			fwrt->ppag_flags);
-
-	if (cmd_ver == 1 &&
-	    !fw_has_capa(&fwrt->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
-		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
-		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
-	} else {
-		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
-	}
-
-	/* The 'flags' field is the same in v1 and v5 so we can just
-	 * use v1 to access it.
-	 */
-	IWL_DEBUG_RADIO(fwrt,
-			"PPAG MODE bits going to be sent: %d\n",
-			(cmd_ver < 7) ? le32_to_cpu(cmd->v1.flags) :
-					le32_to_cpu(cmd->v7.ppag_config_info.value));
-
-	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
-		for (j = 0; j < num_sub_bands; j++) {
-			if (!send_ppag_always &&
-			    !iwl_ppag_value_valid(fwrt, i, j))
-				return -EINVAL;
-
-			gain[i * num_sub_bands + j] =
-				fwrt->ppag_chains[i].subbands[j];
-			IWL_DEBUG_RADIO(fwrt,
-					"PPAG table: chain[%d] band[%d]: gain = %d\n",
-					i, j, gain[i * num_sub_bands + j]);
-		}
-	}
-
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_fill_ppag_table);
-
 bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 {
 	if (!dmi_check_system(dmi_ppag_approved_list)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 1489031687b7..8e04b0e2d507 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -190,10 +190,6 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 			 __le16 *per_chain, u32 n_tables, u32 n_subbands,
 			 int prof_a, int prof_b);
 
-int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
-			union iwl_ppag_table_cmd *cmd,
-			int *cmd_size);
-
 bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
 bool iwl_is_tas_approved(void);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f5e5c10cc581..d46715abd7a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1034,12 +1034,139 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
+static bool iwl_mvm_ppag_value_valid(struct iwl_fw_runtime *fwrt, int chain,
+				     int subband)
+{
+	s8 ppag_val = fwrt->ppag_chains[chain].subbands[subband];
+
+	if ((subband == 0 &&
+	     (ppag_val > IWL_PPAG_MAX_LB || ppag_val < IWL_PPAG_MIN_LB)) ||
+	    (subband != 0 &&
+	     (ppag_val > IWL_PPAG_MAX_HB || ppag_val < IWL_PPAG_MIN_HB))) {
+		IWL_DEBUG_RADIO(fwrt, "Invalid PPAG value: %d\n", ppag_val);
+		return false;
+	}
+	return true;
+}
+
+static int iwl_mvm_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+				   union iwl_ppag_table_cmd *cmd,
+				   int *cmd_size)
+{
+	u8 cmd_ver;
+	int i, j, num_sub_bands;
+	s8 *gain;
+	bool send_ppag_always;
+
+	/* many firmware images for JF lie about this */
+	if (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id) ==
+	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
+		return -EOPNOTSUPP;
+
+	if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
+		IWL_DEBUG_RADIO(fwrt,
+				"PPAG capability not supported by FW, command not sent.\n");
+		return -EINVAL;
+	}
+
+	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD), 1);
+	/*
+	 * Starting from ver 4, driver needs to send the PPAG CMD regardless
+	 * if PPAG is enabled/disabled or valid/invalid.
+	 */
+	send_ppag_always = cmd_ver > 3;
+
+	/* Don't send PPAG if it is disabled */
+	if (!send_ppag_always && !fwrt->ppag_flags) {
+		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
+		return -EINVAL;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
+	if (cmd_ver == 1) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
+		gain = cmd->v1.gain[0];
+		*cmd_size = sizeof(cmd->v1);
+		cmd->v1.flags =
+			cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V1_MASK);
+		if (fwrt->ppag_bios_rev >= 1) {
+			/* in this case FW supports revision 0 */
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table rev is %d, send truncated table\n",
+					fwrt->ppag_bios_rev);
+		}
+	} else if (cmd_ver == 5) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = cmd->v5.gain[0];
+		*cmd_size = sizeof(cmd->v5);
+		cmd->v5.flags =
+			cpu_to_le32(fwrt->ppag_flags & IWL_PPAG_CMD_V5_MASK);
+		if (fwrt->ppag_bios_rev == 0) {
+			/* in this case FW supports revisions 1,2 or 3 */
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table rev is 0, send padded table\n");
+		}
+	} else if (cmd_ver == 7) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = cmd->v7.gain[0];
+		*cmd_size = sizeof(cmd->v7);
+		cmd->v7.ppag_config_info.hdr.table_source =
+			fwrt->ppag_bios_source;
+		cmd->v7.ppag_config_info.hdr.table_revision =
+			fwrt->ppag_bios_rev;
+		cmd->v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
+	} else {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
+		return -EINVAL;
+	}
+
+	/* ppag mode */
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits were read from bios: %d\n",
+			fwrt->ppag_flags);
+
+	if (cmd_ver == 1 &&
+	    !fw_has_capa(&fwrt->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
+	} else {
+		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
+	}
+
+	/* The 'flags' field is the same in v1 and v5 so we can just
+	 * use v1 to access it.
+	 */
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits going to be sent: %d\n",
+			(cmd_ver < 7) ? le32_to_cpu(cmd->v1.flags) :
+					le32_to_cpu(cmd->v7.ppag_config_info.value));
+
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
+			if (!send_ppag_always &&
+			    !iwl_mvm_ppag_value_valid(fwrt, i, j))
+				return -EINVAL;
+
+			gain[i * num_sub_bands + j] =
+				fwrt->ppag_chains[i].subbands[j];
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table: chain[%d] band[%d]: gain = %d\n",
+					i, j, gain[i * num_sub_bands + j]);
+		}
+	}
+
+	return 0;
+}
+
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
 	union iwl_ppag_table_cmd cmd;
 	int ret, cmd_size;
 
-	ret = iwl_fill_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
+	ret = iwl_mvm_fill_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
 	/* Not supporting PPAG table is a valid scenario */
 	if (ret < 0)
 		return 0;
-- 
2.34.1


