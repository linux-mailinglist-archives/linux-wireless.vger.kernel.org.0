Return-Path: <linux-wireless+bounces-25106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5774AFF192
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 21:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F15A07D7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D223E334;
	Wed,  9 Jul 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwcjsMjt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B2238C2C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088464; cv=none; b=ZUYJzwd2hsXJ8xlHyp7Fe5g7Vfnx80dIRHPxAN8kvPsg/OOY7gEDJMF5Fi2QGUrXSlSrU+kd+9T5qr8MkbR2VsvBanUVuJgzFKaccPcNqFFjj0uype/7I9cforEkzb9clTDF6j1bj1eKAzaHhu7LgZEOKa3SGdlbcymTYUVR0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088464; c=relaxed/simple;
	bh=qbKedVhodGXYmX26Mf840ot0eRVZax6nojW0xckFMNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeqBoCwI3pFtx4/e8MJMQOywpl10ofTeCF+Q+7U4ttO2pTGuJsgQRq8PNvKp/hx9Q3Uhl85/14FJwE3d2QnfACrD5J27nEJlxTguOy5ASB/EF0xrJtdXLoTLUuuBWaeEm4Zglw8tjrOTFqS3nxHZcXAMHKrwAOCn4OHE0W40w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwcjsMjt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752088462; x=1783624462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qbKedVhodGXYmX26Mf840ot0eRVZax6nojW0xckFMNs=;
  b=YwcjsMjtXn68oY3TgcYw/4fxWIjcn0x5iirt2+Lvu9PKr91LksZ0mho1
   7rHKqNdsLzn8hiHBfgswqdWJ9lYAkbD+5WmnSNr0uiucTtKkmvlhG1Fd6
   9NfynkvTTNasCWiO3lCgoRwBIl0pBXzVJNfckqAJPGGPViSMHJJ16ZLmh
   c4BXGzPY12sBOQG6YNmrdysd0epa1hNzy/37h0HnN/rcnakSLRClTreMX
   Omqd2ebBxNv68ttdenHvFqEjZR+fxsWLVHXRObJeNLf8dHBy7n3rG8z3F
   N7HFaWwwCpu0PN6yVpaSSM+UnvMjH/BNsz8YfSy/gD6+mLXwHXXHasp3s
   Q==;
X-CSE-ConnectionGUID: oTIegyYUSq2LTv80X3yDSQ==
X-CSE-MsgGUID: UL3zWeFzSRmcmocyMuxUDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58026789"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58026789"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 12:14:21 -0700
X-CSE-ConnectionGUID: y+nW3bK/TJydvRITSJmVWg==
X-CSE-MsgGUID: jGw4u2ipQJ+4bzTb5OWlDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160115955"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 12:14:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v4] wifi: iwlwifi: mvm/fw: Avoid -Wflex-array-member-not-at-end warnings
Date: Wed,  9 Jul 2025 22:14:00 +0300
Message-Id: <20250709221008.815aacb43067.I6da02c2a12a5ed1e6d317045a6995d132850a455@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

We have a flexible struct iwl_tx_cmd_v6 in the middle of a few structs,
but those don't even need the flexible part.

So, we add iwl_tx_cmd_v6_params, that will contain everything except the
flexible array and use this one for the containing structs.

Also, as part of the refactoring remove unused flex array `payload`.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://msgid.link/aCUOQ6wdD1jQjO36@kspp
[use iwl_tx_cmd_v6_params as described in the changed commit message]
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
Changes in v4:
 - Used a new struct instead of __struct_group
Changes in v3:
 - Rebase on top of commit e4248670c0ae ("wifi: iwlwifi: use normal
   versioning convention for iwl_tx_cmd")

Changes in v2:
 - Update changelog text - mention removal of flex array `payload`.
   (Kees)
 - Fix kernel-doc block. (Johannes).
 - Add RB tag.
 - Link: https://lore.kernel.org/linux-hardening/aAv7RiLsmXq5d0ge@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-9G-GHufhXKeYft@kspp/

 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 33 ++++---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 16 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 11 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 89 ++++++++++---------
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   | 22 ++---
 6 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
index 58d5a6ef633e..08edd1d99992 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
@@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
  */
 struct iwl_tdls_channel_switch_frame {
 	__le32 switch_time_offset;
-	struct iwl_tx_cmd_v6 tx_cmd;
+	struct iwl_tx_cmd_v6_params tx_cmd;
 	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
 } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
 
@@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
 	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
 
 	__le32 pti_req_data_offset;
-	struct iwl_tx_cmd_v6 pti_req_tx_cmd;
+	struct iwl_tx_cmd_v6_params pti_req_tx_cmd;
 	u8 pti_req_template[];
 } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 62bd35a8f680..26d2013905ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -181,8 +181,8 @@ enum iwl_tx_offload_assist_flags_pos {
 
 /* TODO: complete documentation for try_cnt and btkill_cnt */
 /**
- * struct iwl_tx_cmd_v6 - TX command struct to FW
- * ( TX_CMD = 0x1c )
+ * struct iwl_tx_cmd_v6_params - parameters of the TX
+ *
  * @len: in bytes of the payload, see below for details
  * @offload_assist: TX offload configuration
  * @tx_flags: combination of TX_CMD_FLG_*, see &enum iwl_tx_flags
@@ -205,8 +205,6 @@ enum iwl_tx_offload_assist_flags_pos {
  * @tid_tspec: TID/tspec
  * @pm_frame_timeout: PM TX frame timeout
  * @reserved4: reserved
- * @payload: payload (same as @hdr)
- * @hdr: 802.11 header (same as @payload)
  *
  * The byte count (both len and next_frame_len) includes MAC header
  * (24/26/30/32 bytes)
@@ -217,11 +215,8 @@ enum iwl_tx_offload_assist_flags_pos {
  * It does not include post-MAC padding, i.e.,
  * MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.
  * Range of len: 14-2342 bytes.
- *
- * After the struct fields the MAC header is placed, plus any padding,
- * and then the actial payload.
  */
-struct iwl_tx_cmd_v6 {
+struct iwl_tx_cmd_v6_params {
 	__le16 len;
 	__le16 offload_assist;
 	__le32 tx_flags;
@@ -245,10 +240,20 @@ struct iwl_tx_cmd_v6 {
 	u8 tid_tspec;
 	__le16 pm_frame_timeout;
 	__le16 reserved4;
-	union {
-		DECLARE_FLEX_ARRAY(u8, payload);
-		DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
-	};
+} __packed; /* TX_CMD_API_S_VER_6 */
+
+/**
+ * struct iwl_tx_cmd_v6 - TX command struct to FW
+ * ( TX_CMD = 0x1c )
+ * @params: parameters of the TX, see &struct iwl_tx_cmd_v6_tx_params
+ * @hdr: 802.11 header
+ *
+ * After &params, the MAC header is placed, plus any padding,
+ * and then the actual payload.
+ */
+struct iwl_tx_cmd_v6 {
+	struct iwl_tx_cmd_v6_params params;
+	struct ieee80211_hdr hdr[];
 } __packed; /* TX_CMD_API_S_VER_6 */
 
 struct iwl_dram_sec_info {
@@ -748,7 +753,7 @@ struct iwl_compressed_ba_notif {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v6 {
-	struct iwl_tx_cmd_v6 tx;
+	struct iwl_tx_cmd_v6_params tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
@@ -767,7 +772,7 @@ struct iwl_mac_beacon_cmd_v6 {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v7 {
-	struct iwl_tx_cmd_v6 tx;
+	struct iwl_tx_cmd_v6_params tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9098a36530cc..5908fd4bfb67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -976,7 +976,7 @@ u8 iwl_mvm_mac_ctxt_get_beacon_rate(struct iwl_mvm *mvm,
 static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct sk_buff *beacon,
-				    struct iwl_tx_cmd_v6 *tx)
+				    struct iwl_tx_cmd_v6_params *tx_params)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_tx_info *info;
@@ -986,30 +986,30 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 	info = IEEE80211_SKB_CB(beacon);
 
 	/* Set up TX command fields */
-	tx->len = cpu_to_le16((u16)beacon->len);
-	tx->sta_id = mvmvif->deflink.bcast_sta.sta_id;
-	tx->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
+	tx_params->len = cpu_to_le16((u16)beacon->len);
+	tx_params->sta_id = mvmvif->deflink.bcast_sta.sta_id;
+	tx_params->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
 	tx_flags = TX_CMD_FLG_SEQ_CTL | TX_CMD_FLG_TSF;
 	tx_flags |=
 		iwl_mvm_bt_coex_tx_prio(mvm, (void *)beacon->data, info, 0) <<
 						TX_CMD_FLG_BT_PRIO_POS;
-	tx->tx_flags = cpu_to_le32(tx_flags);
+	tx_params->tx_flags = cpu_to_le32(tx_flags);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_BEACON_ANT_SELECTION)) {
 		iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
 
-		tx->rate_n_flags =
+		tx_params->rate_n_flags =
 			cpu_to_le32(BIT(mvm->mgmt_last_antenna_idx) <<
 				    RATE_MCS_ANT_POS);
 	}
 
 	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
-	tx->rate_n_flags |=
+	tx_params->rate_n_flags |=
 		cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate));
 	if (rate == IWL_FIRST_CCK_RATE)
-		tx->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK_V1);
+		tx_params->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK_V1);
 
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f0d459766365..7548d2e1f1c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1837,9 +1837,10 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta);
 int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb);
 void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
-			struct iwl_tx_cmd_v6 *tx_cmd,
+			struct iwl_tx_cmd_v6_params *tx_cmd_params,
 			struct ieee80211_tx_info *info, u8 sta_id);
-void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd_v6 *tx_cmd,
+void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm,
+			     struct iwl_tx_cmd_v6_params *tx_cmd_params,
 			    struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta, __le16 fc);
 void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
@@ -1870,12 +1871,12 @@ int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
 void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm);
 
 static inline void iwl_mvm_set_tx_cmd_ccmp(struct ieee80211_tx_info *info,
-					   struct iwl_tx_cmd_v6 *tx_cmd)
+					   struct iwl_tx_cmd_v6_params *tx_cmd_params)
 {
 	struct ieee80211_key_conf *keyconf = info->control.hw_key;
 
-	tx_cmd->sec_ctl = TX_CMD_SEC_CCM;
-	memcpy(tx_cmd->key, keyconf->key, keyconf->keylen);
+	tx_cmd_params->sec_ctl = TX_CMD_SEC_CCM;
+	memcpy(tx_cmd_params->key, keyconf->key, keyconf->keylen);
 }
 
 static inline void iwl_mvm_wait_for_async_handlers(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ac2cf1b8ce23..068ba4a28969 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -148,12 +148,12 @@ static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
  * Sets most of the Tx cmd's fields
  */
 void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
-			struct iwl_tx_cmd_v6 *tx_cmd,
+			struct iwl_tx_cmd_v6_params *tx_cmd_params,
 			struct ieee80211_tx_info *info, u8 sta_id)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
-	u32 tx_flags = le32_to_cpu(tx_cmd->tx_flags);
+	u32 tx_flags = le32_to_cpu(tx_cmd_params->tx_flags);
 	u32 len = skb->len + FCS_LEN;
 	bool amsdu = false;
 	u8 ac;
@@ -173,7 +173,7 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	if (ieee80211_is_data_qos(fc)) {
 		u8 *qc = ieee80211_get_qos_ctl(hdr);
-		tx_cmd->tid_tspec = qc[0] & 0xf;
+		tx_cmd_params->tid_tspec = qc[0] & 0xf;
 		tx_flags &= ~TX_CMD_FLG_SEQ_CTL;
 		amsdu = *qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 	} else if (ieee80211_is_back_req(fc)) {
@@ -182,17 +182,17 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 		u16 ssn = le16_to_cpu(bar->start_seq_num);
 
 		tx_flags |= TX_CMD_FLG_ACK | TX_CMD_FLG_BAR;
-		tx_cmd->tid_tspec = (control &
+		tx_cmd_params->tid_tspec = (control &
 				     IEEE80211_BAR_CTRL_TID_INFO_MASK) >>
 			IEEE80211_BAR_CTRL_TID_INFO_SHIFT;
-		WARN_ON_ONCE(tx_cmd->tid_tspec >= IWL_MAX_TID_COUNT);
-		iwl_mvm_bar_check_trigger(mvm, bar->ra, tx_cmd->tid_tspec,
+		WARN_ON_ONCE(tx_cmd_params->tid_tspec >= IWL_MAX_TID_COUNT);
+		iwl_mvm_bar_check_trigger(mvm, bar->ra, tx_cmd_params->tid_tspec,
 					  ssn);
 	} else {
 		if (ieee80211_is_data(fc))
-			tx_cmd->tid_tspec = IWL_TID_NON_QOS;
+			tx_cmd_params->tid_tspec = IWL_TID_NON_QOS;
 		else
-			tx_cmd->tid_tspec = IWL_MAX_TID_COUNT;
+			tx_cmd_params->tid_tspec = IWL_MAX_TID_COUNT;
 
 		if (info->flags & IEEE80211_TX_CTL_ASSIGN_SEQ)
 			tx_flags |= TX_CMD_FLG_SEQ_CTL;
@@ -201,8 +201,8 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	}
 
 	/* Default to 0 (BE) when tid_spec is set to IWL_MAX_TID_COUNT */
-	if (tx_cmd->tid_tspec < IWL_MAX_TID_COUNT)
-		ac = tid_to_mac80211_ac[tx_cmd->tid_tspec];
+	if (tx_cmd_params->tid_tspec < IWL_MAX_TID_COUNT)
+		ac = tid_to_mac80211_ac[tx_cmd_params->tid_tspec];
 	else
 		ac = tid_to_mac80211_ac[0];
 
@@ -211,20 +211,20 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	if (ieee80211_is_mgmt(fc)) {
 		if (ieee80211_is_assoc_req(fc) || ieee80211_is_reassoc_req(fc))
-			tx_cmd->pm_frame_timeout = cpu_to_le16(PM_FRAME_ASSOC);
+			tx_cmd_params->pm_frame_timeout = cpu_to_le16(PM_FRAME_ASSOC);
 		else if (ieee80211_is_action(fc))
-			tx_cmd->pm_frame_timeout = cpu_to_le16(PM_FRAME_NONE);
+			tx_cmd_params->pm_frame_timeout = cpu_to_le16(PM_FRAME_NONE);
 		else
-			tx_cmd->pm_frame_timeout = cpu_to_le16(PM_FRAME_MGMT);
+			tx_cmd_params->pm_frame_timeout = cpu_to_le16(PM_FRAME_MGMT);
 
 		/* The spec allows Action frames in A-MPDU, we don't support
 		 * it
 		 */
 		WARN_ON_ONCE(info->flags & IEEE80211_TX_CTL_AMPDU);
 	} else if (info->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) {
-		tx_cmd->pm_frame_timeout = cpu_to_le16(PM_FRAME_MGMT);
+		tx_cmd_params->pm_frame_timeout = cpu_to_le16(PM_FRAME_MGMT);
 	} else {
-		tx_cmd->pm_frame_timeout = cpu_to_le16(PM_FRAME_NONE);
+		tx_cmd_params->pm_frame_timeout = cpu_to_le16(PM_FRAME_NONE);
 	}
 
 	if (ieee80211_is_data(fc) && len > mvm->rts_threshold &&
@@ -236,13 +236,13 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	    ieee80211_action_contains_tpc(skb))
 		tx_flags |= TX_CMD_FLG_WRITE_TX_POWER;
 
-	tx_cmd->tx_flags = cpu_to_le32(tx_flags);
+	tx_cmd_params->tx_flags = cpu_to_le32(tx_flags);
 	/* Total # bytes to be transmitted - PCIe code will adjust for A-MSDU */
-	tx_cmd->len = cpu_to_le16((u16)skb->len);
-	tx_cmd->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
-	tx_cmd->sta_id = sta_id;
+	tx_cmd_params->len = cpu_to_le16((u16)skb->len);
+	tx_cmd_params->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
+	tx_cmd_params->sta_id = sta_id;
 
-	tx_cmd->offload_assist =
+	tx_cmd_params->offload_assist =
 		cpu_to_le16(iwl_mvm_tx_csum(mvm, skb, info, amsdu));
 }
 
@@ -395,22 +395,23 @@ static __le32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
 /*
  * Sets the fields in the Tx cmd that are rate related
  */
-void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd_v6 *tx_cmd,
+void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm,
+			    struct iwl_tx_cmd_v6_params *tx_cmd_params,
 			    struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta, __le16 fc)
 {
 	/* Set retry limit on RTS packets */
-	tx_cmd->rts_retry_limit = IWL_RTS_DFAULT_RETRY_LIMIT;
+	tx_cmd_params->rts_retry_limit = IWL_RTS_DFAULT_RETRY_LIMIT;
 
 	/* Set retry limit on DATA packets and Probe Responses*/
 	if (ieee80211_is_probe_resp(fc)) {
-		tx_cmd->data_retry_limit = IWL_MGMT_DFAULT_RETRY_LIMIT;
-		tx_cmd->rts_retry_limit =
-			min(tx_cmd->data_retry_limit, tx_cmd->rts_retry_limit);
+		tx_cmd_params->data_retry_limit = IWL_MGMT_DFAULT_RETRY_LIMIT;
+		tx_cmd_params->rts_retry_limit =
+			min(tx_cmd_params->data_retry_limit, tx_cmd_params->rts_retry_limit);
 	} else if (ieee80211_is_back_req(fc)) {
-		tx_cmd->data_retry_limit = IWL_BAR_DFAULT_RETRY_LIMIT;
+		tx_cmd_params->data_retry_limit = IWL_BAR_DFAULT_RETRY_LIMIT;
 	} else {
-		tx_cmd->data_retry_limit = IWL_DEFAULT_TX_RETRY;
+		tx_cmd_params->data_retry_limit = IWL_DEFAULT_TX_RETRY;
 	}
 
 	/*
@@ -423,17 +424,17 @@ void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd_v6 *tx_cmd,
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 		if (mvmsta->sta_state >= IEEE80211_STA_AUTHORIZED) {
-			tx_cmd->initial_rate_index = 0;
-			tx_cmd->tx_flags |= cpu_to_le32(TX_CMD_FLG_STA_RATE);
+			tx_cmd_params->initial_rate_index = 0;
+			tx_cmd_params->tx_flags |= cpu_to_le32(TX_CMD_FLG_STA_RATE);
 			return;
 		}
 	} else if (ieee80211_is_back_req(fc)) {
-		tx_cmd->tx_flags |=
+		tx_cmd_params->tx_flags |=
 			cpu_to_le32(TX_CMD_FLG_ACK | TX_CMD_FLG_BAR);
 	}
 
 	/* Set the rate in the TX cmd */
-	tx_cmd->rate_n_flags = iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc);
+	tx_cmd_params->rate_n_flags = iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc);
 }
 
 static inline void iwl_mvm_set_tx_cmd_pn(struct ieee80211_tx_info *info,
@@ -458,7 +459,7 @@ static inline void iwl_mvm_set_tx_cmd_pn(struct ieee80211_tx_info *info,
  */
 static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 				      struct ieee80211_tx_info *info,
-				      struct iwl_tx_cmd_v6 *tx_cmd,
+				      struct iwl_tx_cmd_v6_params *tx_cmd_params,
 				      struct sk_buff *skb_frag,
 				      int hdrlen)
 {
@@ -469,26 +470,26 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 
 	switch (keyconf->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
-		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd);
+		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd_params);
 		iwl_mvm_set_tx_cmd_pn(info, crypto_hdr);
 		break;
 
 	case WLAN_CIPHER_SUITE_TKIP:
-		tx_cmd->sec_ctl = TX_CMD_SEC_TKIP;
+		tx_cmd_params->sec_ctl = TX_CMD_SEC_TKIP;
 		pn = atomic64_inc_return(&keyconf->tx_pn);
 		ieee80211_tkip_add_iv(crypto_hdr, keyconf, pn);
-		ieee80211_get_tkip_p2k(keyconf, skb_frag, tx_cmd->key);
+		ieee80211_get_tkip_p2k(keyconf, skb_frag, tx_cmd_params->key);
 		break;
 
 	case WLAN_CIPHER_SUITE_WEP104:
-		tx_cmd->sec_ctl |= TX_CMD_SEC_KEY128;
+		tx_cmd_params->sec_ctl |= TX_CMD_SEC_KEY128;
 		fallthrough;
 	case WLAN_CIPHER_SUITE_WEP40:
-		tx_cmd->sec_ctl |= TX_CMD_SEC_WEP |
+		tx_cmd_params->sec_ctl |= TX_CMD_SEC_WEP |
 			((keyconf->keyidx << TX_CMD_SEC_WEP_KEY_IDX_POS) &
 			  TX_CMD_SEC_WEP_KEY_IDX_MSK);
 
-		memcpy(&tx_cmd->key[3], keyconf->key, keyconf->keylen);
+		memcpy(&tx_cmd_params->key[3], keyconf->key, keyconf->keylen);
 		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
@@ -501,12 +502,12 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 		 * one.
 		 * Need to handle this.
 		 */
-		tx_cmd->sec_ctl |= type | TX_CMD_SEC_KEY_FROM_TABLE;
-		tx_cmd->key[0] = keyconf->hw_key_idx;
+		tx_cmd_params->sec_ctl |= type | TX_CMD_SEC_KEY_FROM_TABLE;
+		tx_cmd_params->key[0] = keyconf->hw_key_idx;
 		iwl_mvm_set_tx_cmd_pn(info, crypto_hdr);
 		break;
 	default:
-		tx_cmd->sec_ctl |= TX_CMD_SEC_EXT;
+		tx_cmd_params->sec_ctl |= TX_CMD_SEC_EXT;
 	}
 }
 
@@ -636,11 +637,11 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	tx_cmd = (struct iwl_tx_cmd_v6 *)dev_cmd->payload;
 
 	if (info->control.hw_key)
-		iwl_mvm_set_tx_cmd_crypto(mvm, info, tx_cmd, skb, hdrlen);
+		iwl_mvm_set_tx_cmd_crypto(mvm, info, &tx_cmd->params, skb, hdrlen);
 
-	iwl_mvm_set_tx_cmd(mvm, skb, tx_cmd, info, sta_id);
+	iwl_mvm_set_tx_cmd(mvm, skb, &tx_cmd->params, info, sta_id);
 
-	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
+	iwl_mvm_set_tx_cmd_rate(mvm, &tx_cmd->params, info, sta, hdr->frame_control);
 
 	/* Copy MAC header from skb into command buffer */
 	iwl_mvm_copy_hdr(tx_cmd->hdr, hdr, hdrlen, addr3_override);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 3af6e3b3640d..560e973e213b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -1964,7 +1964,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	 * have in the MPDU by themselves, but that we duplicate into
 	 * all the different MSDUs inside the A-MSDU.
 	 */
-	le16_add_cpu(&tx_cmd->len, -snap_ip_tcp_hdrlen);
+	le16_add_cpu(&tx_cmd->params.len, -snap_ip_tcp_hdrlen);
 
 	tso_start(skb, &tso);
 
@@ -2007,7 +2007,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
 					hdr_tb_phys, hdr_tb_len);
 		/* add this subframe's headers' length to the tx_cmd */
-		le16_add_cpu(&tx_cmd->len, pos_hdr - subf_hdrs_start);
+		le16_add_cpu(&tx_cmd->params.len, pos_hdr - subf_hdrs_start);
 
 		/* prepare the start_hdr for the next subframe */
 		start_hdr = pos_hdr;
@@ -2075,11 +2075,11 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 	__le16 bc_ent;
 	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
 	struct iwl_tx_cmd_v6 *tx_cmd = (void *)dev_cmd->payload;
-	u8 sta_id = tx_cmd->sta_id;
+	u8 sta_id = tx_cmd->params.sta_id;
 
 	scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
 
-	sec_ctl = tx_cmd->sec_ctl;
+	sec_ctl = tx_cmd->params.sec_ctl;
 
 	switch (sec_ctl & TX_CMD_SEC_MSK) {
 	case TX_CMD_SEC_CCM:
@@ -2186,10 +2186,10 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	tb0_phys = iwl_txq_get_first_tb_dma(txq, txq->write_ptr);
 	scratch_phys = tb0_phys + sizeof(struct iwl_cmd_header) +
-		       offsetof(struct iwl_tx_cmd_v6, scratch);
+		       offsetof(struct iwl_tx_cmd_v6_params, scratch);
 
-	tx_cmd->dram_lsb_ptr = cpu_to_le32(scratch_phys);
-	tx_cmd->dram_msb_ptr = iwl_get_dma_hi_addr(scratch_phys);
+	tx_cmd->params.dram_lsb_ptr = cpu_to_le32(scratch_phys);
+	tx_cmd->params.dram_msb_ptr = iwl_get_dma_hi_addr(scratch_phys);
 
 	/* Set up first empty entry in queue's array of Tx/cmd buffers */
 	out_meta = &txq->entries[txq->write_ptr].meta;
@@ -2211,7 +2211,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		tb1_len = ALIGN(len, 4);
 		/* Tell NIC about any 2-byte padding after MAC header */
 		if (tb1_len != len)
-			tx_cmd->tx_flags |= cpu_to_le32(TX_CMD_FLG_MH_PAD);
+			tx_cmd->params.tx_flags |= cpu_to_le32(TX_CMD_FLG_MH_PAD);
 	} else {
 		tb1_len = len;
 	}
@@ -2226,7 +2226,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	/* there must be data left over for TB1 or this code must be changed */
 	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_v6) < IWL_FIRST_TB_SIZE);
 	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd_v6, scratch) >
+		     offsetofend(struct iwl_tx_cmd_v6_params, scratch) >
 		     IWL_FIRST_TB_SIZE);
 
 	/* map the data for TB1 */
@@ -2272,7 +2272,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
 	/* Set up entry for this TFD in Tx byte-count array */
-	iwl_txq_gen1_update_byte_cnt_tbl(trans, txq, le16_to_cpu(tx_cmd->len),
+	iwl_txq_gen1_update_byte_cnt_tbl(trans, txq, le16_to_cpu(tx_cmd->params.len),
 					 iwl_txq_gen1_tfd_get_num_tbs(tfd));
 
 	wait_write_ptr = ieee80211_has_morefrags(fc);
@@ -2324,7 +2324,7 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
 
 	if (txq_id != trans->conf.cmd_queue)
-		sta_id = tx_cmd->sta_id;
+		sta_id = tx_cmd->params.sta_id;
 
 	bc_ent = cpu_to_le16(1 | (sta_id << 12));
 
-- 
2.34.1


