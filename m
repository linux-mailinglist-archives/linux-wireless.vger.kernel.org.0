Return-Path: <linux-wireless+bounces-22845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36477AB29C8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B211E3A5B9A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289825D1F7;
	Sun, 11 May 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdOLyJT/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8225D55D
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982425; cv=none; b=WbVhhNt45Qa78KBB1TfJjsk1pJGK+pEDtR7TBAIm4adJVa5zA5hoe9pQpPVP1yfZalsf1vGeTrCfpF+9ckxf3zFnetZBNr+kPeIa35yh/fmUdFIgd2PJF9KSldI53nzAQuWOxF4hEJ1sBbK/iWGjucyUfI9gPkAEPAr4qkr2GB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982425; c=relaxed/simple;
	bh=Sq8zVe6dHX2w6h/QKNNXfHBZXxQDFeqw6iZ4/hN+Gi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HK+ra4ABxWYQQZA38jFXla99CMHiAe4U5hxRQO2UEB2XBrgxSbfywxuqKbSJHtdKft6CgSgP7cXE1gQwDLUmz6F4afs+vraMLKRVdgn1FPj/hC8N9imqKxMRbeS0quiV4sV2HNDfcEyoEhgYxENMJPLf/4HxBbzpMFfyve6Qj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdOLyJT/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982424; x=1778518424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sq8zVe6dHX2w6h/QKNNXfHBZXxQDFeqw6iZ4/hN+Gi4=;
  b=IdOLyJT/X6m4uhtoioW+symI3LpE3qKCTchESr/nvw8mtyEuApsRITgQ
   Ybub9NWyCX/GWnpqfpjtLXsL/8/4VGeDIBXzRDtMs2qMBXbr3MNdSFhHe
   efGU6x+EfO8mAJ80gsBawPRnLBZZ0M8bDBiRSLdbA/wrshUA+rh/cmpUS
   bvrMFT8aUPVtN8Y3TOOqxEnlwEYpPkr4btmfdK8bFaKuArwHIKJBzTvjj
   tvuqbIy1QiLnp9g11AJIB0iYJS1143dydIXphKew/Ufpwbq/jA+j+3Iin
   YacmWkv6vSw+PWLA9LrK1i/oUYZio/JyiYP9jEuVKyElrn87UMBC2gtny
   g==;
X-CSE-ConnectionGUID: kMzXH5iBR8aKyFFj5i/kPg==
X-CSE-MsgGUID: g344n22ERNe/1sI8nOG66g==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582688"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582688"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:44 -0700
X-CSE-ConnectionGUID: 5C8ZgLZmRrmSwO/CGTSDyg==
X-CSE-MsgGUID: JiUxsTriT9Cuf3v8H7UDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655052"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: use normal versioning convention for iwl_tx_cmd
Date: Sun, 11 May 2025 19:53:12 +0300
Message-Id: <20250511195137.806e40c8f767.Ibc0e95e43a6fa6d47f72823bf804314d5db84618@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We have iwl_tx_cmd for devices older than 22000, iwl_tx_cmd_gen2 for
22000 devices, and iwl_tx_cmd_gen3 ax210 and up.

But the convention for all other APIs is to have the latest version
without any prefix and the older ones - with a _vX prefix,
where X is the highest version that this struct support.

The  term 'gen' was introduced as the name of the (back then) new
transport, and should not be used as a device name (for that we have the
actual names: 22000, ax210, etc.)

Now as a new transport, called 'gen3', is going to be written and it can
be confused with this API.

Move iwl_tx_cmd to use the regular versioning convention.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  6 ++---
 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  6 ++---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 18 +++++++--------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  6 ++---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 16 +++++++-------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 22 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 16 +++++++-------
 10 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index d43adb6f9220..1c86a858aaab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022, 2024 Intel Corporation
+ * Copyright (C) 2018-2022, 2024-2025 Intel Corporation
  */
 #ifndef __iwl_fw_api_commands_h__
 #define __iwl_fw_api_commands_h__
@@ -145,8 +145,8 @@ enum iwl_legacy_cmds {
 	REMOVE_STA = 0x19,
 
 	/**
-	 * @TX_CMD: uses &struct iwl_tx_cmd or &struct iwl_tx_cmd_gen2 or
-	 *	&struct iwl_tx_cmd_gen3,
+	 * @TX_CMD: uses &struct iwl_tx_cmd_v6 or &struct iwl_tx_cmd_v9 or
+	 *	&struct iwl_tx_cmd,
 	 *	response in &struct iwl_tx_resp or
 	 *	&struct iwl_tx_resp_v3
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
index cfa6532a3cdd..58d5a6ef633e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2024-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
  */
 struct iwl_tdls_channel_switch_frame {
 	__le32 switch_time_offset;
-	struct iwl_tx_cmd tx_cmd;
+	struct iwl_tx_cmd_v6 tx_cmd;
 	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
 } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
 
@@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
 	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
 
 	__le32 pti_req_data_offset;
-	struct iwl_tx_cmd pti_req_tx_cmd;
+	struct iwl_tx_cmd_v6 pti_req_tx_cmd;
 	u8 pti_req_template[];
 } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 67355ac243c5..557832563f89 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -151,7 +151,7 @@ enum iwl_tx_cmd_sec_ctrl {
 #define IWL_LOW_RETRY_LIMIT			7
 
 /**
- * enum iwl_tx_offload_assist_flags_pos -  set %iwl_tx_cmd offload_assist values
+ * enum iwl_tx_offload_assist_flags_pos -  set %iwl_tx_cmd_v6 offload_assist values
  * @TX_CMD_OFFLD_IP_HDR: offset to start of IP header (in words)
  *	from mac header end. For normal case it is 4 words for SNAP.
  *	note: tx_cmd, mac header and pad are not counted in the offset.
@@ -181,7 +181,7 @@ enum iwl_tx_offload_assist_flags_pos {
 
 /* TODO: complete documentation for try_cnt and btkill_cnt */
 /**
- * struct iwl_tx_cmd - TX command struct to FW
+ * struct iwl_tx_cmd_v6 - TX command struct to FW
  * ( TX_CMD = 0x1c )
  * @len: in bytes of the payload, see below for details
  * @offload_assist: TX offload configuration
@@ -221,7 +221,7 @@ enum iwl_tx_offload_assist_flags_pos {
  * After the struct fields the MAC header is placed, plus any padding,
  * and then the actial payload.
  */
-struct iwl_tx_cmd {
+struct iwl_tx_cmd_v6 {
 	__le16 len;
 	__le16 offload_assist;
 	__le32 tx_flags;
@@ -258,7 +258,7 @@ struct iwl_dram_sec_info {
 } __packed; /* DRAM_SEC_INFO_API_S_VER_1 */
 
 /**
- * struct iwl_tx_cmd_gen2 - TX command struct to FW for 22000 devices
+ * struct iwl_tx_cmd_v9 - TX command struct to FW for 22000 devices
  * ( TX_CMD = 0x1c )
  * @len: in bytes of the payload, see below for details
  * @offload_assist: TX offload configuration
@@ -268,7 +268,7 @@ struct iwl_dram_sec_info {
  *	cleared. Combination of RATE_MCS_*
  * @hdr: 802.11 header
  */
-struct iwl_tx_cmd_gen2 {
+struct iwl_tx_cmd_v9 {
 	__le16 len;
 	__le16 offload_assist;
 	__le32 flags;
@@ -279,7 +279,7 @@ struct iwl_tx_cmd_gen2 {
 	       TX_CMD_API_S_VER_9 */
 
 /**
- * struct iwl_tx_cmd_gen3 - TX command struct to FW for AX210+ devices
+ * struct iwl_tx_cmd - TX command struct to FW for AX210+ devices
  * ( TX_CMD = 0x1c )
  * @len: in bytes of the payload, see below for details
  * @flags: combination of &enum iwl_tx_cmd_flags
@@ -290,7 +290,7 @@ struct iwl_tx_cmd_gen2 {
  * @reserved: reserved
  * @hdr: 802.11 header
  */
-struct iwl_tx_cmd_gen3 {
+struct iwl_tx_cmd {
 	__le16 len;
 	__le16 flags;
 	__le32 offload_assist;
@@ -748,7 +748,7 @@ struct iwl_compressed_ba_notif {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v6 {
-	struct iwl_tx_cmd tx;
+	struct iwl_tx_cmd_v6 tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
@@ -767,7 +767,7 @@ struct iwl_mac_beacon_cmd_v6 {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v7 {
-	struct iwl_tx_cmd tx;
+	struct iwl_tx_cmd_v6 tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index b8165ee2b1e8..51bedd09dc69 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -287,13 +287,13 @@ int iwl_trans_init(struct iwl_trans *trans)
 		return -EINVAL;
 
 	if (!trans->mac_cfg->gen2) {
-		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
 		txcmd_align = sizeof(void *);
 	} else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_gen2);
+		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
 		txcmd_align = 64;
 	} else {
-		txcmd_size = sizeof(struct iwl_tx_cmd_gen3);
+		txcmd_size = sizeof(struct iwl_tx_cmd);
 		txcmd_align = 128;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 4d4d3308a90d..3b4b575aadaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -488,7 +488,7 @@ static __le32 iwl_mld_get_tx_rate_n_flags(struct iwl_mld *mld,
 }
 
 static void
-iwl_mld_fill_tx_cmd_hdr(struct iwl_tx_cmd_gen3 *tx_cmd,
+iwl_mld_fill_tx_cmd_hdr(struct iwl_tx_cmd *tx_cmd,
 			struct sk_buff *skb, bool amsdu)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -534,7 +534,7 @@ iwl_mld_fill_tx_cmd(struct iwl_mld *mld, struct sk_buff *skb,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct iwl_mld_sta *mld_sta = sta ? iwl_mld_sta_from_mac80211(sta) :
 					    NULL;
-	struct iwl_tx_cmd_gen3 *tx_cmd;
+	struct iwl_tx_cmd *tx_cmd;
 	bool amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
 		     (*ieee80211_get_qos_ctl(hdr) &
 		      IEEE80211_QOS_CTL_A_MSDU_PRESENT);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 7a103163b31c..9098a36530cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -976,7 +976,7 @@ u8 iwl_mvm_mac_ctxt_get_beacon_rate(struct iwl_mvm *mvm,
 static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct sk_buff *beacon,
-				    struct iwl_tx_cmd *tx)
+				    struct iwl_tx_cmd_v6 *tx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_tx_info *info;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 37a0e0c54507..d8940df7b068 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1837,9 +1837,9 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta);
 int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb);
 void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
-			struct iwl_tx_cmd *tx_cmd,
+			struct iwl_tx_cmd_v6 *tx_cmd,
 			struct ieee80211_tx_info *info, u8 sta_id);
-void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
+void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd_v6 *tx_cmd,
 			    struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta, __le16 fc);
 void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
@@ -1870,7 +1870,7 @@ int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
 void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm);
 
 static inline void iwl_mvm_set_tx_cmd_ccmp(struct ieee80211_tx_info *info,
-					   struct iwl_tx_cmd *tx_cmd)
+					   struct iwl_tx_cmd_v6 *tx_cmd)
 {
 	struct ieee80211_key_conf *keyconf = info->control.hw_key;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index a8a2c77e5696..ac2cf1b8ce23 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -148,7 +148,7 @@ static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
  * Sets most of the Tx cmd's fields
  */
 void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
-			struct iwl_tx_cmd *tx_cmd,
+			struct iwl_tx_cmd_v6 *tx_cmd,
 			struct ieee80211_tx_info *info, u8 sta_id)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -395,7 +395,7 @@ static __le32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
 /*
  * Sets the fields in the Tx cmd that are rate related
  */
-void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
+void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd_v6 *tx_cmd,
 			    struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta, __le16 fc)
 {
@@ -458,7 +458,7 @@ static inline void iwl_mvm_set_tx_cmd_pn(struct ieee80211_tx_info *info,
  */
 static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 				      struct ieee80211_tx_info *info,
-				      struct iwl_tx_cmd *tx_cmd,
+				      struct iwl_tx_cmd_v6 *tx_cmd,
 				      struct sk_buff *skb_frag,
 				      int hdrlen)
 {
@@ -556,7 +556,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct iwl_device_tx_cmd *dev_cmd;
-	struct iwl_tx_cmd *tx_cmd;
+	struct iwl_tx_cmd_v6 *tx_cmd;
 
 	dev_cmd = iwl_trans_alloc_tx_cmd(mvm->trans);
 
@@ -600,7 +600,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 		if (mvm->trans->mac_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_AX210) {
-			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
+			struct iwl_tx_cmd *cmd = (void *)dev_cmd->payload;
 			u32 offload_assist = iwl_mvm_tx_csum(mvm, skb,
 							     info, amsdu);
 
@@ -615,7 +615,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			cmd->flags = cpu_to_le16(flags);
 			cmd->rate_n_flags = rate_n_flags;
 		} else {
-			struct iwl_tx_cmd_gen2 *cmd = (void *)dev_cmd->payload;
+			struct iwl_tx_cmd_v9 *cmd = (void *)dev_cmd->payload;
 			u16 offload_assist = iwl_mvm_tx_csum(mvm, skb,
 							     info, amsdu);
 
@@ -633,7 +633,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		goto out;
 	}
 
-	tx_cmd = (struct iwl_tx_cmd *)dev_cmd->payload;
+	tx_cmd = (struct iwl_tx_cmd_v6 *)dev_cmd->payload;
 
 	if (info->control.hw_key)
 		iwl_mvm_set_tx_cmd_crypto(mvm, info, tx_cmd, skb, hdrlen);
@@ -1174,7 +1174,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 		seq_number &= IEEE80211_SCTL_SEQ;
 
 		if (!iwl_mvm_has_new_tx_api(mvm)) {
-			struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+			struct iwl_tx_cmd_v6 *tx_cmd = (void *)dev_cmd->payload;
 
 			hdr->seq_ctrl &= cpu_to_le16(IEEE80211_SCTL_FRAG);
 			hdr->seq_ctrl |= cpu_to_le16(seq_number);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index ceb730baa494..53a02b45de5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -163,7 +163,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 				    struct iwl_device_tx_cmd *dev_cmd)
 {
 #ifdef CONFIG_INET
-	struct iwl_tx_cmd_gen2 *tx_cmd = (void *)dev_cmd->payload;
+	struct iwl_tx_cmd_v9 *tx_cmd = (void *)dev_cmd->payload;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
@@ -490,21 +490,21 @@ struct iwl_tfh_tfd *iwl_txq_gen2_build_tfd(struct iwl_trans *trans,
 	bool amsdu;
 
 	/* There must be data left over for TB1 or this code must be changed */
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen2) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_v9) < IWL_FIRST_TB_SIZE);
 	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd_gen2, dram_info) >
+		     offsetofend(struct iwl_tx_cmd_v9, dram_info) >
 		     IWL_FIRST_TB_SIZE);
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen3) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd) < IWL_FIRST_TB_SIZE);
 	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd_gen3, dram_info) >
+		     offsetofend(struct iwl_tx_cmd, dram_info) >
 		     IWL_FIRST_TB_SIZE);
 
 	memset(tfd, 0, sizeof(*tfd));
 
 	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		len = sizeof(struct iwl_tx_cmd_gen2);
+		len = sizeof(struct iwl_tx_cmd_v9);
 	else
-		len = sizeof(struct iwl_tx_cmd_gen3);
+		len = sizeof(struct iwl_tx_cmd);
 
 	amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
 			(*ieee80211_get_qos_ctl(hdr) &
@@ -781,15 +781,15 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	}
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
+		struct iwl_tx_cmd *tx_cmd =
 			(void *)dev_cmd->payload;
 
-		cmd_len = le16_to_cpu(tx_cmd_gen3->len);
+		cmd_len = le16_to_cpu(tx_cmd->len);
 	} else {
-		struct iwl_tx_cmd_gen2 *tx_cmd_gen2 =
+		struct iwl_tx_cmd_v9 *tx_cmd_v9 =
 			(void *)dev_cmd->payload;
 
-		cmd_len = le16_to_cpu(tx_cmd_gen2->len);
+		cmd_len = le16_to_cpu(tx_cmd_v9->len);
 	}
 
 	/* Set up entry for this TFD in Tx byte-count array */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 715e1154faf5..d5ba4f3fd223 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1910,7 +1910,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   u16 tb1_len)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+	struct iwl_tx_cmd_v6 *tx_cmd = (void *)dev_cmd->payload;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
@@ -2072,7 +2072,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
 	__le16 bc_ent;
 	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+	struct iwl_tx_cmd_v6 *tx_cmd = (void *)dev_cmd->payload;
 	u8 sta_id = tx_cmd->sta_id;
 
 	scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
@@ -2111,7 +2111,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct ieee80211_hdr *hdr;
-	struct iwl_tx_cmd *tx_cmd = (struct iwl_tx_cmd *)dev_cmd->payload;
+	struct iwl_tx_cmd_v6 *tx_cmd = (struct iwl_tx_cmd_v6 *)dev_cmd->payload;
 	struct iwl_cmd_meta *out_meta;
 	struct iwl_txq *txq;
 	dma_addr_t tb0_phys, tb1_phys, scratch_phys;
@@ -2184,7 +2184,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	tb0_phys = iwl_txq_get_first_tb_dma(txq, txq->write_ptr);
 	scratch_phys = tb0_phys + sizeof(struct iwl_cmd_header) +
-		       offsetof(struct iwl_tx_cmd, scratch);
+		       offsetof(struct iwl_tx_cmd_v6, scratch);
 
 	tx_cmd->dram_lsb_ptr = cpu_to_le32(scratch_phys);
 	tx_cmd->dram_msb_ptr = iwl_get_dma_hi_addr(scratch_phys);
@@ -2199,7 +2199,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	 * (This calculation modifies the TX command, so do it before the
 	 * setup of the first TB)
 	 */
-	len = sizeof(struct iwl_tx_cmd) + sizeof(struct iwl_cmd_header) +
+	len = sizeof(struct iwl_tx_cmd_v6) + sizeof(struct iwl_cmd_header) +
 	      hdr_len - IWL_FIRST_TB_SIZE;
 	/* do not align A-MSDU to dword as the subframe header aligns it */
 	amsdu = ieee80211_is_data_qos(fc) &&
@@ -2222,9 +2222,9 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			       IWL_FIRST_TB_SIZE, true);
 
 	/* there must be data left over for TB1 or this code must be changed */
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_v6) < IWL_FIRST_TB_SIZE);
 	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd, scratch) >
+		     offsetofend(struct iwl_tx_cmd_v6, scratch) >
 		     IWL_FIRST_TB_SIZE);
 
 	/* map the data for TB1 */
@@ -2317,7 +2317,7 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 	u8 sta_id = 0;
 	__le16 bc_ent;
 	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+	struct iwl_tx_cmd_v6 *tx_cmd = (void *)dev_cmd->payload;
 
 	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
 
-- 
2.34.1


