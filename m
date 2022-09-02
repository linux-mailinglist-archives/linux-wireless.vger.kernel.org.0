Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C075AB42A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiIBOvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiIBOvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9443F8B9A2
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qucHCufpAW8CUBkqsg1eeBnd6Rluv32pCX273kTnC1A=;
        t=1662127989; x=1663337589; b=BoLklS2pHavACsuZX2SbCgT0/sAAVmW2UvDwHApwhvbWmiZ
        IS3qNjXpmOIft366NU9QFRM/ht3Qco7owRQinqxgTXwTfQQNe+dVI8yHKkg0+DGDekktTtI3ngeoT
        r4LR7nW0vm0SwU2uRfPChtLmKdxPyxz3bOZRgpW7OWCb4+CVQPLMEzaLwG9w8Bir9nMVc8q4OTLA/
        aRNwWhYlYqMbuLjHirFH92Gsx81pwnPrgnxJdwVA9JB7uyEmOPS1+U8jnAVfXDPbCTlk/WutsI+/b
        pvRIG4qLR0VcJt/5ojsSQpGJSsxPkc+H2Hd6mEbWnhQ1qRKZErRwB/mVrQZLds0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pv-006Ch3-1d;
        Fri, 02 Sep 2022 16:13:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 09/27] wifi: mac80211: make smps_mode per-link
Date:   Fri,  2 Sep 2022 16:12:41 +0200
Message-Id: <20220902161143.f0635cc662ee.I95aa5896e81c80a6bb017f72c6c126c7b3af56e0@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The SMPS power save mode needs to be per-link rather than being shared
for all links. As such, move it into struct ieee80211_link_sta.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c                |  6 +++---
 drivers/net/wireless/ath/ath11k/mac.c                |  6 +++---
 drivers/net/wireless/ath/ath9k/xmit.c                |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c        |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c         |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c          |  6 +++---
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c         | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c       |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c          |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c         |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  4 ++--
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c     |  2 +-
 include/net/mac80211.h                               |  4 ++--
 net/mac80211/he.c                                    |  4 ++--
 net/mac80211/ht.c                                    |  7 ++++---
 net/mac80211/rc80211_minstrel_ht.c                   |  6 +++---
 net/mac80211/rx.c                                    |  4 ++--
 net/mac80211/sta_info.c                              |  3 ++-
 21 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 23381a9db6ae..e086db920a82 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8520,7 +8520,7 @@ static void ath10k_sta_rc_update(struct ieee80211_hw *hw,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
 		   sta->addr, changed, sta->deflink.bandwidth,
 		   sta->deflink.rx_nss,
-		   sta->smps_mode);
+		   sta->deflink.smps_mode);
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
 		bw = WMI_PEER_CHWIDTH_20MHZ;
@@ -8554,7 +8554,7 @@ static void ath10k_sta_rc_update(struct ieee80211_hw *hw,
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
 		smps = WMI_PEER_SMPS_PS_NONE;
 
-		switch (sta->smps_mode) {
+		switch (sta->deflink.smps_mode) {
 		case IEEE80211_SMPS_AUTOMATIC:
 		case IEEE80211_SMPS_OFF:
 			smps = WMI_PEER_SMPS_PS_NONE;
@@ -8567,7 +8567,7 @@ static void ath10k_sta_rc_update(struct ieee80211_hw *hw,
 			break;
 		case IEEE80211_SMPS_NUM_MODES:
 			ath10k_warn(ar, "Invalid smps %d in sta rc update for %pM\n",
-				    sta->smps_mode, sta->addr);
+				    sta->deflink.smps_mode, sta->addr);
 			smps = WMI_PEER_SMPS_PS_NONE;
 			break;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7e91e347c9ff..f5bf53d6af7e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4701,7 +4701,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
 		   sta->addr, changed, sta->deflink.bandwidth,
 		   sta->deflink.rx_nss,
-		   sta->smps_mode);
+		   sta->deflink.smps_mode);
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -4737,7 +4737,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
 		smps = WMI_PEER_SMPS_PS_NONE;
 
-		switch (sta->smps_mode) {
+		switch (sta->deflink.smps_mode) {
 		case IEEE80211_SMPS_AUTOMATIC:
 		case IEEE80211_SMPS_OFF:
 			smps = WMI_PEER_SMPS_PS_NONE;
@@ -4750,7 +4750,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 			break;
 		default:
 			ath11k_warn(ar->ab, "Invalid smps %d in sta rc update for %pM\n",
-				    sta->smps_mode, sta->addr);
+				    sta->deflink.smps_mode, sta->addr);
 			smps = WMI_PEER_SMPS_PS_NONE;
 			break;
 		}
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index ba16a7f3e23d..ba271a10d4ab 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2160,7 +2160,7 @@ static void setup_frame_info(struct ieee80211_hw *hw,
 		fi->keyix = an->ps_key;
 	else
 		fi->keyix = ATH9K_TXKEYIX_INVALID;
-	fi->dyn_smps = sta && sta->smps_mode == IEEE80211_SMPS_DYNAMIC;
+	fi->dyn_smps = sta && sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC;
 	fi->keytype = keytype;
 	fi->framelen = framelen;
 	fi->tx_power = txpower;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index c62f299b9e0a..290e2c966ecb 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -1167,7 +1167,7 @@ il4965_rs_switch_to_mimo2(struct il_priv *il, struct il_lq_sta *lq_sta,
 	if (!conf_is_ht(conf) || !sta->deflink.ht_cap.ht_supported)
 		return -1;
 
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		return -1;
 
 	/* Need both Tx chains/antennas to support MIMO */
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 04d27a26260b..341c17fe2af4 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -1870,15 +1870,15 @@ il_set_ht_add_station(struct il_priv *il, u8 idx, struct ieee80211_sta *sta)
 		goto done;
 
 	D_ASSOC("spatial multiplexing power save mode: %s\n",
-		(sta->smps_mode == IEEE80211_SMPS_STATIC) ? "static" :
-		(sta->smps_mode == IEEE80211_SMPS_DYNAMIC) ? "dynamic" :
+		(sta->deflink.smps_mode == IEEE80211_SMPS_STATIC) ? "static" :
+		(sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC) ? "dynamic" :
 		"disabled");
 
 	sta_flags = il->stations[idx].sta.station_flags;
 
 	sta_flags &= ~(STA_FLG_RTS_MIMO_PROT_MSK | STA_FLG_MIMO_DIS_MSK);
 
-	switch (sta->smps_mode) {
+	switch (sta->deflink.smps_mode) {
 	case IEEE80211_SMPS_STATIC:
 		sta_flags |= STA_FLG_MIMO_DIS_MSK;
 		break;
@@ -1888,7 +1888,7 @@ il_set_ht_add_station(struct il_priv *il, u8 idx, struct ieee80211_sta *sta)
 	case IEEE80211_SMPS_OFF:
 		break;
 	default:
-		IL_WARN("Invalid MIMO PS mode %d\n", sta->smps_mode);
+		IL_WARN("Invalid MIMO PS mode %d\n", sta->deflink.smps_mode);
 		break;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index baffa1cbe8fc..687c906a9d72 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 - 2020 Intel Corporation
+ * Copyright (C) 2019 - 2020, 2022 Intel Corporation
  *****************************************************************************/
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
@@ -1242,7 +1242,7 @@ static int rs_switch_to_mimo2(struct iwl_priv *priv,
 	if (!conf_is_ht(conf) || !sta->deflink.ht_cap.ht_supported)
 		return -1;
 
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		return -1;
 
 	/* Need both Tx chains/antennas to support MIMO */
@@ -1297,7 +1297,7 @@ static int rs_switch_to_mimo3(struct iwl_priv *priv,
 	if (!conf_is_ht(conf) || !sta->deflink.ht_cap.ht_supported)
 		return -1;
 
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		return -1;
 
 	/* Need both Tx chains/antennas to support MIMO */
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index 476068c0abb7..cef43cf80620 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2022 Intel Corporation. All rights reserved.
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -161,12 +161,12 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *priv,
 
 	IWL_DEBUG_INFO(priv, "STA %pM SM PS mode: %s\n",
 			sta->addr,
-			(sta->smps_mode == IEEE80211_SMPS_STATIC) ?
+			(sta->deflink.smps_mode == IEEE80211_SMPS_STATIC) ?
 			"static" :
-			(sta->smps_mode == IEEE80211_SMPS_DYNAMIC) ?
+			(sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC) ?
 			"dynamic" : "disabled");
 
-	switch (sta->smps_mode) {
+	switch (sta->deflink.smps_mode) {
 	case IEEE80211_SMPS_STATIC:
 		*flags |= STA_FLG_MIMO_DIS_MSK;
 		break;
@@ -176,7 +176,7 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *priv,
 	case IEEE80211_SMPS_OFF:
 		break;
 	default:
-		IWL_WARN(priv, "Invalid MIMO PS mode %d\n", sta->smps_mode);
+		IWL_WARN(priv, "Invalid MIMO PS mode %d\n", sta->deflink.smps_mode);
 		break;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index d8c3d7ff4f44..752d44d96163 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -143,7 +143,7 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 	};
 
 	/* the station support only a single receive chain */
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		max_nss = 1;
 
 	for (i = 0; i < max_nss && i < IWL_TLC_NSS_MAX; i++) {
@@ -205,7 +205,7 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 	u8 nss = sta->deflink.rx_nss;
 
 	/* the station support only a single receive chain */
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		nss = 1;
 
 	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
@@ -270,7 +270,7 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
 
 		/* the station support only a single receive chain */
-		if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+		if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
 				0;
 		else
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a79043f30775..814a5e8f3666 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -138,7 +138,7 @@ static bool rs_mimo_allow(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	if (!sta->deflink.ht_cap.ht_supported)
 		return false;
 
-	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
 		return false;
 
 	if (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) < 2)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ff0d3b3df140..cc92706b3d16 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -116,7 +116,7 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		break;
 	}
 
-	switch (sta->smps_mode) {
+	switch (sta->deflink.smps_mode) {
 	case IEEE80211_SMPS_AUTOMATIC:
 	case IEEE80211_SMPS_NUM_MODES:
 		WARN_ON(1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 051715ed90dd..ca50feb0b3a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -658,7 +658,7 @@ mt7603_sta_rate_tbl_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7603_wtbl_set_rates(dev, msta, NULL, msta->rates);
 	msta->rate_probe = false;
 	mt7603_wtbl_set_smps(dev, msta,
-			     sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
+			     sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC);
 	spin_unlock_bh(&dev->mt76.lock);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 9b17bd97ec09..5c4ca93bcf91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -896,7 +896,7 @@ void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
 					     wtbl_tlv, sta_wtbl);
 	smps = (struct wtbl_smps *)tlv;
-	smps->smps = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
+	smps->smps = (sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_smps_tlv);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index de30cf5e2d2f..93d96739f802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -404,7 +404,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 		txwi->rate |= cpu_to_le16(MT_RXWI_RATE_LDPC);
 	if ((info->flags & IEEE80211_TX_CTL_STBC) && nss == 1)
 		txwi->rate |= cpu_to_le16(MT_RXWI_RATE_STBC);
-	if (nss > 1 && sta && sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+	if (nss > 1 && sta && sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC)
 		txwi_flags |= MT_TXWI_FLAGS_MMPS;
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
 		txwi->ack_ctl |= MT_TXWI_ACK_CTL_REQ;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f83067961945..1081b893f319 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1304,7 +1304,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 			ra->phy = *phy;
 		break;
 	case RATE_PARAM_MMPS_UPDATE:
-		ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->smps_mode);
+		ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->deflink.smps_mode);
 		break;
 	default:
 		break;
@@ -1459,7 +1459,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	ra->channel = chandef->chan->hw_value;
 	ra->bw = sta->deflink.bandwidth;
 	ra->phy.bw = sta->deflink.bandwidth;
-	ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->smps_mode);
+	ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->deflink.smps_mode);
 
 	if (supp_rate) {
 		supp_rate &= mask->control[band].legacy;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 4d06038afd83..98df0aef8168 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -318,7 +318,7 @@ static void rt2x00queue_create_tx_descriptor_ht(struct rt2x00_dev *rt2x00dev,
 		 * when using more then one tx stream (>MCS7).
 		 */
 		if (sta && txdesc->u.ht.mcs > 7 &&
-		    sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+		    sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC)
 			__set_bit(ENTRY_TXD_HT_MIMO_PS, &txdesc->flags);
 	} else {
 		txdesc->u.ht.mcs = rt2x00_get_rate_mcs(hwrate->mcs);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ffd0ebbff294..d4e1d73d88cc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2136,6 +2136,7 @@ struct ieee80211_sta_txpwr {
  *	in ieee80211_sta. For MLO Link STA this addr can be same or different
  *	from addr in ieee80211_sta (representing MLD STA addr)
  * @link_id: the link ID for this link STA (0 for deflink)
+ * @smps_mode: current SMPS mode (off, static or dynamic)
  * @supp_rates: Bitmap of supported rates
  * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
  * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
@@ -2153,6 +2154,7 @@ struct ieee80211_sta_txpwr {
 struct ieee80211_link_sta {
 	u8 addr[ETH_ALEN];
 	u8 link_id;
+	enum ieee80211_smps_mode smps_mode;
 
 	u32 supp_rates[NUM_NL80211_BANDS];
 	struct ieee80211_sta_ht_cap ht_cap;
@@ -2191,7 +2193,6 @@ struct ieee80211_link_sta {
  *	if wme is supported. The bits order is like in
  *	IEEE80211_WMM_IE_STA_QOSINFO_AC_*.
  * @max_sp: max Service Period. Only valid if wme is supported.
- * @smps_mode: current SMPS mode (off, static or dynamic)
  * @rates: rate control selection table
  * @tdls: indicates whether the STA is a TDLS peer
  * @tdls_initiator: indicates the STA is an initiator of the TDLS link. Only
@@ -2226,7 +2227,6 @@ struct ieee80211_sta {
 	bool wme;
 	u8 uapsd_queues;
 	u8 max_sp;
-	enum ieee80211_smps_mode smps_mode;
 	struct ieee80211_sta_rates __rcu *rates;
 	bool tdls;
 	bool tdls_initiator;
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index d9228fd3f77a..e73899fd4bbb 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -31,9 +31,9 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 			break;
 		}
 
-		sta->sta.smps_mode = smps_mode;
+		link_sta->pub->smps_mode = smps_mode;
 	} else {
-		sta->sta.smps_mode = IEEE80211_SMPS_OFF;
+		link_sta->pub->smps_mode = IEEE80211_SMPS_OFF;
 	}
 
 	switch (le16_get_bits(he_6ghz_capa->capa,
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 8c24817cd497..12a233ba5031 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -299,12 +299,13 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 			break;
 		}
 
-		if (smps_mode != sta->sta.smps_mode)
+		if (smps_mode != link_sta->pub->smps_mode)
 			changed = true;
-		sta->sta.smps_mode = smps_mode;
+		link_sta->pub->smps_mode = smps_mode;
 	} else {
-		sta->sta.smps_mode = IEEE80211_SMPS_OFF;
+		link_sta->pub->smps_mode = IEEE80211_SMPS_OFF;
 	}
+
 	return changed;
 }
 
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 5f27e6746762..8c41a545a8b7 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2010-2013 Felix Fietkau <nbd@openwrt.org>
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2022 Intel Corporation
  */
 #include <linux/netdevice.h>
 #include <linux/types.h>
@@ -1478,7 +1478,7 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	 *  - for fallback rates, to increase chances of getting through
 	 */
 	if (offset > 0 ||
-	    (mi->sta->smps_mode == IEEE80211_SMPS_DYNAMIC &&
+	    (mi->sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC &&
 	     group->streams > 1)) {
 		ratetbl->rate[offset].count = ratetbl->rate[offset].count_rts;
 		flags |= IEEE80211_TX_RC_USE_RTS_CTS;
@@ -1779,7 +1779,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 		nss = minstrel_mcs_groups[i].streams;
 
 		/* Mark MCS > 7 as unsupported if STA is in static SMPS mode */
-		if (sta->smps_mode == IEEE80211_SMPS_STATIC && nss > 1)
+		if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC && nss > 1)
 			continue;
 
 		/* HT rate */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 38622446ea8a..af5b8f62164a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3405,9 +3405,9 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			}
 
 			/* if no change do nothing */
-			if (rx->sta->sta.smps_mode == smps_mode)
+			if (rx->link_sta->pub->smps_mode == smps_mode)
 				goto handled;
-			rx->sta->sta.smps_mode = smps_mode;
+			rx->link_sta->pub->smps_mode = smps_mode;
 			sta_opmode.smps_mode =
 				ieee80211_smps_mode_to_smps_mode(smps_mode);
 			sta_opmode.changed = STA_OPMODE_SMPS_MODE_CHANGED;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4944d929def6..815ab0cee503 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -475,6 +475,8 @@ static void sta_info_add_link(struct sta_info *sta,
 	link_sta->link_id = link_id;
 	rcu_assign_pointer(sta->link[link_id], link_info);
 	rcu_assign_pointer(sta->sta.link[link_id], link_sta);
+
+	link_sta->smps_mode = IEEE80211_SMPS_OFF;
 }
 
 static struct sta_info *
@@ -628,7 +630,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	sta->sta.smps_mode = IEEE80211_SMPS_OFF;
 	sta->sta.max_rc_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
 
 	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
-- 
2.37.2

