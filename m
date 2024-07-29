Return-Path: <linux-wireless+bounces-10622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FE93FC4A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2BA1F2210C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E85028C;
	Mon, 29 Jul 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILCJfscX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985E161321
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273636; cv=none; b=u+lfs6MPXIWH2URsO1/rPen10tGsPinYFkuohPcnLX3dJmKytz1QqbQSEG3elPKpOUd9YJXN9p7syypJ44fOdsBt9+tnL/4vxpxgXks13wAXpWCovROAnQ+dYa/mQ6wG+07lk71bZqrx22DhC6cARkZO26cSF6jzwnEuOkqeCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273636; c=relaxed/simple;
	bh=5bSxELDkHoVsOyj+1uOnBnnYjGzeUq5kTa+rehS95u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxRntopSD1nKUhWBHdRffUaWRUfeMInqu0GOeWUOY+ct68f+8rk40wE2Eg8f9Zwk3O0An8UaOuWErt/IKOqti8gAYq6lDaK7Y+MERf0XpX9YIXiVKQ4vVkITZfwJ869x9Qqcn5L2A8y52s2p4sSevtxcUK/etty3L8a3w340tXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILCJfscX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273634; x=1753809634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bSxELDkHoVsOyj+1uOnBnnYjGzeUq5kTa+rehS95u0=;
  b=ILCJfscXGxPqUfsJe/pYu4cFiZ0wbwwLo++JKXotdBymhnSzzDkSJmY7
   ZEU1xf3F2cuInWirPRgHV4X4ehF1wzYiu8RJoLD4q4WZtlXsX84sNR9M9
   3xv2iPsnJmsghCG66MYqpz0jhBZ3fUDhM8b4cNFn8m0VHC6I6Be6+77RP
   ydHIk/prsrwKDOmTiBZ1Cr8e/q7ihGmRuUQz+UG+auyoQQogdAb34/8DL
   6k/+AtPBffSlx1mQhnthikKDv2VRhbTnSBN/OXKasD1mc+jme1PdzLgs4
   FdZUMlwRO23ezstDOCSUvqaAL310V/oKQzFUvMs93icT/lccr4r0NoCso
   A==;
X-CSE-ConnectionGUID: xlQPFuBCRhuqyltdyec6zA==
X-CSE-MsgGUID: MAlWoPo2Q8GCldSL77VvAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445565"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:34 -0700
X-CSE-ConnectionGUID: mE0hoXZRSYSh/l2mWhX4Qg==
X-CSE-MsgGUID: NW+wwS41ToiTBteo/UEs6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288263"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: mvm: add support for new REDUCE_TXPOWER_CMD versions
Date: Mon, 29 Jul 2024 20:20:03 +0300
Message-Id: <20240729201718.7ec1527be98c.I52dede6532bc61041c441caee5273734f14a1d78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

New API versions are coming up for this command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 54 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 24 +++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 37 +++++++++----
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 4c9d28327efc..df0680eae30c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -441,6 +441,60 @@ struct iwl_dev_tx_power_cmd_v3_v8 {
 	};
 };
 
+/**
+ * struct iwl_dev_tx_power_cmd_v9 - TX power reduction cmd
+ * @reserved: reserved (padding)
+ * @per_chain: per chain restrictions
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved1: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ */
+struct iwl_dev_tx_power_cmd_v9 {
+	__le16 reserved;
+	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V1];
+	u8 per_chain_restriction_changed;
+	u8 reserved1[3];
+	__le32 timer_period;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_9 */
+
+/**
+ * struct iwl_dev_tx_power_cmd_v10 - TX power reduction cmd
+ * @per_chain: per chain restrictions
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ * @flags: reduce power flags.
+ */
+struct iwl_dev_tx_power_cmd_v10 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 per_chain_restriction_changed;
+	u8 reserved;
+	__le32 timer_period;
+	__le32 flags;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_10 */
+
+/*
+ * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
+ * @common: common part of the command
+ * @v9: version 9 part of the command
+ * @v10: version 10 part of the command
+ */
+struct iwl_dev_tx_power_cmd {
+	struct iwl_dev_tx_power_common common;
+	union {
+		struct iwl_dev_tx_power_cmd_v9 v9;
+		struct iwl_dev_tx_power_cmd_v10 v10;
+	};
+} __packed; /* TX_REDUCED_POWER_API_S_VER_9_VER10 */
+
 #define IWL_NUM_GEO_PROFILES		3
 #define IWL_NUM_GEO_PROFILES_V3		8
 #define IWL_NUM_BANDS_PER_CHAIN_V1	2
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4c0847446e22..e279fd409b6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -866,13 +866,27 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	struct iwl_dev_tx_power_cmd_v3_v8 cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
 	};
+	struct iwl_dev_tx_power_cmd cmd_v9_v10 = {
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
+	};
 	__le16 *per_chain;
 	int ret;
 	u16 len = 0;
 	u32 n_subbands;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
+	void *cmd_data = &cmd;
 
-	if (cmd_ver >= 7) {
+	if (cmd_ver == 10) {
+		len = sizeof(cmd_v9_v10.v10);
+		n_subbands = IWL_NUM_SUB_BANDS_V2;
+		per_chain = &cmd_v9_v10.v10.per_chain[0][0][0];
+		cmd_v9_v10.v10.flags =
+			cpu_to_le32(mvm->fwrt.reduced_power_flags);
+	} else if (cmd_ver == 9) {
+		len = sizeof(cmd_v9_v10.v9);
+		n_subbands = IWL_NUM_SUB_BANDS_V1;
+		per_chain = &cmd_v9_v10.v9.per_chain[0][0];
+	} else if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
 		per_chain = cmd.v7.per_chain[0][0];
@@ -902,8 +916,10 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	/* all structs have the same common part, add its length */
 	len += sizeof(cmd.common);
 
-	/* all structs have the same per_band part, add its length */
-	len += sizeof(cmd.per_band);
+	if (cmd_ver < 9)
+		len += sizeof(cmd.per_band);
+	else
+		cmd_data = &cmd_v9_v10;
 
 	ret = iwl_sar_fill_profile(&mvm->fwrt, per_chain,
 				   IWL_NUM_CHAIN_TABLES,
@@ -916,7 +932,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	iwl_mei_set_power_limit(per_chain);
 
 	IWL_DEBUG_RADIO(mvm, "Sending REDUCE_TX_POWER_CMD per chain\n");
-	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, cmd_data);
 }
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f0b290aa6bec..f48f445e006c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1484,15 +1484,29 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
 		.common.mac_context_id =
 			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
-		.common.pwr_restriction = cpu_to_le16(8 * tx_power),
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
-
-	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
-		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
-
-	if (cmd_ver == 8)
+	struct iwl_dev_tx_power_cmd cmd_v9_v10;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
+	u16 u_tx_power = tx_power == IWL_DEFAULT_MAX_TX_POWER ?
+		IWL_DEV_MAX_TX_POWER : 8 * tx_power;
+	void *cmd_data = &cmd;
+
+	cmd.common.pwr_restriction = cpu_to_le16(u_tx_power);
+
+	if (cmd_ver > 8) {
+		/* Those fields sit on the same place for v9 and v10 */
+		cmd_v9_v10.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC);
+		cmd_v9_v10.common.mac_context_id =
+			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id);
+		cmd_v9_v10.common.pwr_restriction = cpu_to_le16(u_tx_power);
+		cmd_data = &cmd_v9_v10;
+	}
+
+	if (cmd_ver == 10)
+		len = sizeof(cmd_v9_v10.v10);
+	else if (cmd_ver == 9)
+		len = sizeof(cmd_v9_v10.v9);
+	else if (cmd_ver == 8)
 		len = sizeof(cmd.v8);
 	else if (cmd_ver == 7)
 		len = sizeof(cmd.v7);
@@ -1510,10 +1524,11 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	/* all structs have the same common part, add its length */
 	len += sizeof(cmd.common);
 
-	/* all structs have the same per_band part, add its length */
-	len += sizeof(cmd.per_band);
+	if (cmd_ver < 9)
+		len += sizeof(cmd.per_band);
+
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, cmd_data);
 
-	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
 static void iwl_mvm_post_csa_tx(void *data, struct ieee80211_sta *sta)
-- 
2.34.1


