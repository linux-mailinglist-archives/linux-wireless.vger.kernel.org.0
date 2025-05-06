Return-Path: <linux-wireless+bounces-22679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C558AACE35
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9827B89BA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4881FC0EA;
	Tue,  6 May 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gc87nbfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE020AF9C
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560485; cv=none; b=eKFQD//tKcmvxHViMS4QWV+BDi/GB7TXgmSF2uzUk/NKweG54SUR+EyS4wY/dv6K8C/iUuJDRB2PawzrypHVkOB9UuCq4W4W4IueGB9aezrkyCvOi0DmRbJbGJlTnt8WufSJ5FkbpgUChNp+C4r2eJiaW0CbVda4gvmRCCm3pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560485; c=relaxed/simple;
	bh=BCC9SD4/ZLHiTUN39sVgcdLsoLrV57NfX7yRYnkEJIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qugnq2ZtxVC0iOWefKnyl2vkZHzPNsJe3SRorGBD/ZmZ/azcRT9AtR4TMyfdG8219BoX8XmRBaE9q+uRKN/xbkk1x1+uT55tXTyvQD0zL0WeWTi8+jGBJ4WlY9s1e+YN+jPdSaJlapzZc6d6dmtNAekFM6hFb2lmeHr5Nf6Wjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gc87nbfW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560484; x=1778096484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCC9SD4/ZLHiTUN39sVgcdLsoLrV57NfX7yRYnkEJIw=;
  b=gc87nbfWxboJv/7qrFtkKdXO1oDbdOiNL7FrnNaxekWSoFyLwEcRTDp7
   fJRT3l7wx9z/RsQeDUk1x3DqEueYdXO/c71m2hMu94WATyCkZ/PoyNVgg
   LKPBU4moS19hlt5xL1RF4cRfL8d5/kQvoKshtDg0yK/Bkj+sMg1HDV8IL
   Omqb7Rc5xIT2oJof94k/pCz9FVfeXegtvNJKykD4IWAiEoQjwi6nk8g0N
   VS843BEBTTuW4Wbo2GmoZ7MrVatU2eknLIzLcq5GfiGcEHoyZuEhEFnOf
   FEaHviQNt9jAtjAN1UBGAlkBu+P920JGCenLU4Ln2cSCZnT6jaSTT+flg
   w==;
X-CSE-ConnectionGUID: h8fiWpQwR56xCc9jTP8TdQ==
X-CSE-MsgGUID: uY7zHYT8T1647nUw0PQiOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961627"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961627"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:23 -0700
X-CSE-ConnectionGUID: /AmdWThKSVm+T71P71YZCQ==
X-CSE-MsgGUID: YRVJ7sSeRSGJV3nbDLfECg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465429"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: Add a new version for mac config command
Date: Tue,  6 May 2025 22:40:51 +0300
Message-Id: <20250506194102.3407967-5-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Add a new version of mac configuration command
which includes UHR support indication.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Message-Id: <20250506223834.42006c1a6277.I3c189fcdf45fe84cf1cfa8a35e5f4ab919b3284b@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 50 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 35 +++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 46 ++++++++++++-----
 3 files changed, 100 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 58690bb6577d..53b7340ef8a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -310,9 +310,42 @@ enum iwl_mac_config_filter_flags {
 	MAC_CFG_FILTER_ACCEPT_PROBE_REQ		= BIT(5),
 }; /* MAC_FILTER_FLAGS_MASK_E_VER_1 */
 
+/**
+ * struct iwl_mac_wifi_gen_support_v2 - parameters of iwl_mac_config_cmd
+ *	with support up to eht as in version 2 of the command
+ *
+ * @he_support: does this MAC support HE
+ * @he_ap_support: HE AP enabled, "pseudo HE", no trigger frame handling
+ * @eht_support: does this MAC support EHT. Requires he_support
+ */
+struct iwl_mac_wifi_gen_support_v2 {
+	__le16 he_support;
+	__le16 he_ap_support;
+	__le32 eht_support;
+} __packed;
+
+/**
+ * struct iwl_mac_wifi_gen_support - parameters of iwl_mac_config_cmd
+ *	with support up to uhr as in version 3 of the command
+ * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
+ *
+ * @he_support: does this MAC support HE
+ * @he_ap_support: HE AP enabled, "pseudo HE", no trigger frame handling
+ * @eht_support: does this MAC support EHT. Requires he_support
+ * @uhr_support: does this MAC support UHR. Requires eht_support
+ * @reserved: reserved for alignment and to match version 2's size
+ */
+struct iwl_mac_wifi_gen_support {
+	u8 he_support;
+	u8 he_ap_support;
+	u8 eht_support;
+	u8 uhr_support;
+	__le32 reserved;
+} __packed;
+
 /**
  * struct iwl_mac_config_cmd - command structure to configure MAC contexts in
- *	MLD API
+ *	MLD API for versions 2 and 3
  * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
  *
  * @id_and_color: ID and color of the MAC
@@ -321,9 +354,8 @@ enum iwl_mac_config_filter_flags {
  * @local_mld_addr: mld address
  * @reserved_for_local_mld_addr: reserved
  * @filter_flags: combination of &enum iwl_mac_config_filter_flags
- * @he_support: does this MAC support HE
- * @he_ap_support: HE AP enabled, "pseudo HE", no trigger frame handling
- * @eht_support: does this MAC support EHT. Requires he_support
+ * @wifi_gen_v2: he/eht parameters as in cmd version 2
+ * @wifi_gen: he/eht/uhr parameters as in cmd version 3
  * @nic_not_ack_enabled: mark that the NIC doesn't support receiving
  *	ACK-enabled AGG, (i.e. both BACK and non-BACK frames in single AGG).
  *	If the NIC is not ACK_ENABLED it may use the EOF-bit in first non-0
@@ -332,7 +364,6 @@ enum iwl_mac_config_filter_flags {
  * @p2p_dev: mac data for p2p device
  */
 struct iwl_mac_config_cmd {
-	/* COMMON_INDEX_HDR_API_S_VER_1 */
 	__le32 id_and_color;
 	__le32 action;
 	/* MAC_CONTEXT_TYPE_API_E */
@@ -340,16 +371,17 @@ struct iwl_mac_config_cmd {
 	u8 local_mld_addr[6];
 	__le16 reserved_for_local_mld_addr;
 	__le32 filter_flags;
-	__le16 he_support;
-	__le16 he_ap_support;
-	__le32 eht_support;
+	union {
+		struct iwl_mac_wifi_gen_support_v2 wifi_gen_v2;
+		struct iwl_mac_wifi_gen_support wifi_gen;
+	};
 	__le32 nic_not_ack_enabled;
 	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_2 */
 	union {
 		struct iwl_mac_client_data client;
 		struct iwl_mac_p2p_dev_data p2p_dev;
 	};
-} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_2 */
+} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_2_VER_3 */
 
 /**
  * enum iwl_link_ctx_modify_flags - indicate to the fw what fields are being
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 47b5b31b5b91..c083ba416d40 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -103,6 +103,24 @@ static bool iwl_mld_is_nic_ack_enabled(struct iwl_mld *mld,
 			       IEEE80211_HE_MAC_CAP2_ACK_EN);
 }
 
+static void iwl_mld_set_he_support(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct iwl_mac_config_cmd *cmd,
+				   int cmd_ver)
+{
+	if (vif->type == NL80211_IFTYPE_AP) {
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.he_ap_support = cpu_to_le16(1);
+		else
+			cmd->wifi_gen.he_ap_support = 1;
+	} else {
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.he_support = cpu_to_le16(1);
+		else
+			cmd->wifi_gen.he_support = 1;
+	}
+}
+
 /* fill the common part for all interface types */
 static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 					struct ieee80211_vif *vif,
@@ -112,6 +130,9 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct ieee80211_bss_conf *link_conf;
 	unsigned int link_id;
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw,
+					    WIDE_ID(MAC_CONF_GROUP,
+						    MAC_CONFIG_CMD), 0);
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -138,12 +159,11 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 	 * and enable both when we have MLO.
 	 */
 	if (ieee80211_vif_is_mld(vif)) {
-		if (vif->type == NL80211_IFTYPE_AP)
-			cmd->he_ap_support = cpu_to_le16(1);
+		iwl_mld_set_he_support(mld, vif, cmd, cmd_ver);
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.eht_support = cpu_to_le32(1);
 		else
-			cmd->he_support = cpu_to_le16(1);
-
-		cmd->eht_support = cpu_to_le32(1);
+			cmd->wifi_gen.eht_support = 1;
 		return;
 	}
 
@@ -151,10 +171,7 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 		if (!link_conf->he_support)
 			continue;
 
-		if (vif->type == NL80211_IFTYPE_AP)
-			cmd->he_ap_support = cpu_to_le16(1);
-		else
-			cmd->he_support = cpu_to_le16(1);
+		iwl_mld_set_he_support(mld, vif, cmd, cmd_ver);
 
 		/* EHT, if supported, was already set above */
 		break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index bb7851042177..81ca9ff67be9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -1,17 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2024 Intel Corporation
+ * Copyright (C) 2022 - 2025 Intel Corporation
  */
 #include "mvm.h"
 
 static void iwl_mvm_mld_set_he_support(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
-				       struct iwl_mac_config_cmd *cmd)
+				       struct iwl_mac_config_cmd *cmd,
+				       int cmd_ver)
 {
-	if (vif->type == NL80211_IFTYPE_AP)
-		cmd->he_ap_support = cpu_to_le16(1);
-	else
-		cmd->he_support = cpu_to_le16(1);
+	if (vif->type == NL80211_IFTYPE_AP) {
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.he_ap_support = cpu_to_le16(1);
+		else
+			cmd->wifi_gen.he_ap_support = 1;
+	} else {
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.he_support = cpu_to_le16(1);
+		else
+			cmd->wifi_gen.he_support = 1;
+	}
 }
 
 static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
@@ -22,6 +30,12 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_bss_conf *link_conf;
 	unsigned int link_id;
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					    WIDE_ID(MAC_CONF_GROUP,
+						    MAC_CONFIG_CMD), 0);
+
+	if (WARN_ON(cmd_ver < 1 && cmd_ver > 3))
+		return;
 
 	cmd->id_and_color = cpu_to_le32(mvmvif->id);
 	cmd->action = cpu_to_le32(action);
@@ -30,8 +44,8 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	memcpy(cmd->local_mld_addr, vif->addr, ETH_ALEN);
 
-	cmd->he_support = 0;
-	cmd->eht_support = 0;
+	cmd->wifi_gen_v2.he_support = 0;
+	cmd->wifi_gen_v2.eht_support = 0;
 
 	/* should be set by specific context type handler */
 	cmd->filter_flags = 0;
@@ -51,8 +65,11 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	 * and enable both when we have MLO.
 	 */
 	if (ieee80211_vif_is_mld(vif)) {
-		iwl_mvm_mld_set_he_support(mvm, vif, cmd);
-		cmd->eht_support = cpu_to_le32(1);
+		iwl_mvm_mld_set_he_support(mvm, vif, cmd, cmd_ver);
+		if (cmd_ver == 2)
+			cmd->wifi_gen_v2.eht_support = cpu_to_le32(1);
+		else
+			cmd->wifi_gen.eht_support = 1;
 		return;
 	}
 
@@ -63,16 +80,19 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 			continue;
 
 		if (link_conf->he_support)
-			iwl_mvm_mld_set_he_support(mvm, vif, cmd);
+			iwl_mvm_mld_set_he_support(mvm, vif, cmd, cmd_ver);
 
-		/* it's not reasonable to have EHT without HE and FW API doesn't
+		/* It's not reasonable to have EHT without HE and FW API doesn't
 		 * support it. Ignore EHT in this case.
 		 */
 		if (!link_conf->he_support && link_conf->eht_support)
 			continue;
 
 		if (link_conf->eht_support) {
-			cmd->eht_support = cpu_to_le32(1);
+			if (cmd_ver == 2)
+				cmd->wifi_gen_v2.eht_support = cpu_to_le32(1);
+			else
+				cmd->wifi_gen.eht_support = 1;
 			break;
 		}
 	}
-- 
2.34.1


