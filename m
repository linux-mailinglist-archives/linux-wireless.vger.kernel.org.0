Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BF4E73F6
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 14:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbiCYNKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 09:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiCYNKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 09:10:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A3B1AF38
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ZEsq4x0vleYO2yFrFgOiBA4lgZuCYpfuer8dFVFGXXM=; t=1648213748; x=1649423348; 
        b=K7w6RYPT+O7K0fJ4RS8WWU3isthLFUnSnjPvTCQ4sXpDY/wqM2sheFww3t271o7v7K5L6KLimWo
        wa8Lq5zzGEiGGO7HXIjC7et19I2gX6xEJMoNFEi8RiOYRkff5/PJoR7ol3oxZflgCeT8er7rQkIFn
        PfqWAcwZLnDJx9/gIRALfskiTo5rfTLCgJrnSjK22isOmmk1v+bi4XXcrpvMK56gZIEUW2mlBVhH1
        NQYINeXq11kQoD5UwxSR8mBRqH5Iovj9IK3Bev5zkVHyRwiP1TmVdz/BVtpUNH/f4iBBJNVH93p14
        Hn4B/54nI5Hy1qrv/WNEaDzMlT9eUz7/pzxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXjgf-000Kxd-LB;
        Fri, 25 Mar 2022 14:09:05 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC PATCH] mac80211: mlme: Handle Puncturing information received from the AP
Date:   Fri, 25 Mar 2022 14:09:00 +0100
Message-Id: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
X-Mailer: git-send-email 2.35.1
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Handle the Puncturing info received from the AP
in the EHT Operation IE in beacons.
If the info changed and is valid - update the driver.
If the info is invalid:
 - During association: disable EHT connection for the AP.
 - After association: disconnect.

type=feature
ticket=none

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
RFC because I wanted you to see it now, and I didn't change all
the drivers yet
---
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/mac80211_hwsim.c         |   6 +-
 include/net/mac80211.h                        |   6 +-
 net/mac80211/driver-ops.h                     |   4 +-
 net/mac80211/ieee80211_i.h                    |   2 +-
 net/mac80211/main.c                           |   2 +-
 net/mac80211/mlme.c                           | 199 +++++++++++++++++-
 net/mac80211/util.c                           |   3 +
 10 files changed, 218 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index abb8696ba294..2045d027bfd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2021-2022 Intel Corporation
  */
 #ifndef __iwl_agn_h__
 #define __iwl_agn_h__
@@ -92,7 +92,7 @@ int iwlagn_mac_config(struct ieee80211_hw *hw, u32 changed);
 void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf,
-			     u32 changes);
+			     u64 changes);
 void iwlagn_config_ht40(struct ieee80211_conf *conf,
 			struct iwl_rxon_context *ctx);
 void iwl_set_rxon_ht(struct iwl_priv *priv, struct iwl_ht_config *ht_conf);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 70338bc7bb54..23295fa602b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2022 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
  *****************************************************************************/
 
@@ -1383,7 +1383,7 @@ static void iwlagn_chain_noise_reset(struct iwl_priv *priv)
 void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf,
-			     u32 changes)
+			     u64 changes)
 {
 	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
 	struct iwl_rxon_context *ctx = iwl_rxon_ctx_from_vif(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 784d91281c02..37d9ff01ad7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2192,7 +2192,7 @@ static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *bss_conf,
-					     u32 changes)
+					     u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -2632,7 +2632,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
-				     u32 changes)
+				     u64 changes)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 28bfa7b7b73c..a6c991453c50 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2097,15 +2097,15 @@ static void mac80211_hwsim_bcn_en_iter(void *data, u8 *mac,
 static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 					    struct ieee80211_vif *vif,
 					    struct ieee80211_bss_conf *info,
-					    u32 changed)
+					    u64 changed)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct mac80211_hwsim_data *data = hw->priv;
 
 	hwsim_check_magic(vif);
 
-	wiphy_dbg(hw->wiphy, "%s(changed=0x%x vif->addr=%pM)\n",
-		  __func__, changed, vif->addr);
+	wiphy_dbg(hw->wiphy, "%s(changed=0x%llx vif->addr=%pM)\n",
+		  __func__, (unsigned long long)changed, vif->addr);
 
 	if (changed & BSS_CHANGED_BSSID) {
 		wiphy_dbg(hw->wiphy, "%s: BSSID changed: %pM\n",
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb862ea8..b2b0bcfab957 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -320,6 +320,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
+ * @BSS_CHANGED_EHT_PUNCTURING: Puncturing bitmap changed.
  *
  */
 enum ieee80211_bss_change {
@@ -355,6 +356,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
+	BSS_CHANGED_EHT_PUNCTURING	= 1ULL<<32,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -637,6 +639,7 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @eht_puncturing: bitmap to indicate which channels are punctured in this BSS
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -712,6 +715,7 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+	u16 eht_puncturing;
 };
 
 /**
@@ -3989,7 +3993,7 @@ struct ieee80211_ops {
 	void (*bss_info_changed)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info,
-				 u32 changed);
+				 u64 changed);
 
 	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 4e2fc1a08681..46797a6cabd6 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2019, 2021 Intel Corporation
+* Copyright (C) 2018 - 2019, 2021 - 2022 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -150,7 +150,7 @@ static inline int drv_config(struct ieee80211_local *local, u32 changed)
 static inline void drv_bss_info_changed(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_bss_conf *info,
-					u32 changed)
+					u64 changed)
 {
 	might_sleep();
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d4a7ba4a8202..76d31c11bf31 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1812,7 +1812,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 int ieee80211_hw_config(struct ieee80211_local *local, u32 changed);
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx);
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				      u32 changed);
+				      u64 changed);
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a48a32f87897..832923005c5e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -200,7 +200,7 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 }
 
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				      u32 changed)
+				      u64 changed)
 {
 	struct ieee80211_local *local = sdata->local;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1b30c724ca8d..51d5a1cbdd88 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -88,6 +88,117 @@ MODULE_PARM_DESC(probe_wait_ms,
  */
 #define IEEE80211_SIGNAL_AVE_MIN_COUNT	4
 
+struct ieee80211_per_bw_puncturing_values {
+	u8 len;
+	const u16 *valid_values;
+};
+
+static const u16 puncturing_values_80mhz[] = {
+	0x8, 0x4, 0x2, 0x1
+};
+
+static const u16 puncturing_values_160mhz[] = {
+	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
+};
+
+static const u16 puncturing_values_320mhz[] = {
+	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
+	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
+	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
+};
+
+#define IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
+	[IEEE80211_EHT_OPER_CHAN_WIDTH_ ## _bw ## MHZ - IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ] = \
+	{ \
+		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
+		.valid_values = puncturing_values_ ## _bw ## mhz \
+	}
+
+static const struct ieee80211_per_bw_puncturing_values per_bw_puncturing[] = {
+	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(80),
+	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(160),
+	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(320)
+};
+
+static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap, u8 bw)
+{
+	int i;
+
+	if (bw < IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ)
+		*bitmap = 0;
+
+	if (!*bitmap)
+		return true;
+
+	/* Convert the bw to an array index */
+	bw -= IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ;
+	for (i = 0; i < per_bw_puncturing[bw].len; i++)
+		if (per_bw_puncturing[bw].valid_values[i] == *bitmap)
+			return true;
+
+	return false;
+}
+
+/*
+ * Extract from the given disabled subchannel bitmap (raw format
+ * from the EHT Operation Element) the bits for the subchannel
+ * we're using right now.
+ */
+static u16
+ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
+				 struct cfg80211_chan_def *chandef, u16 bitmap)
+{
+	int sta_center_freq = ieee80211_channel_to_frequency(eht_oper->ccfs,
+							     chandef->chan->band);
+	u32 center_freq = chandef->chan->center_freq;
+	u8 sta_bw = 20 * BIT(u8_get_bits(eht_oper->chan_width,
+					 IEEE80211_EHT_OPER_CHAN_WIDTH));
+	u8 bw = 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
+	int sta_start_freq = sta_center_freq - sta_bw / 2;
+	int start_freq = center_freq - bw / 2;
+	u16 shift = (start_freq - sta_start_freq) / 20;
+	u16 mask = BIT(sta_bw / 20) - 1;
+
+	return (bitmap >> shift) & mask;
+}
+
+/*
+ * Handle the puncturing bitmap, possibly downgrading bandwidth to get a
+ * valid bitmap.
+ */
+static void
+ieee80211_handle_puncturing_bitmap(struct ieee80211_sub_if_data *sdata,
+				   const struct ieee80211_eht_operation *eht_oper,
+				   u16 bitmap, u64 *changed)
+{
+	struct cfg80211_chan_def *chandef = &sdata->vif.bss_conf.chandef;
+	u16 extracted;
+	u64 _changed = 0;
+
+	if (!changed)
+		changed = &_changed;
+
+	while (chandef->width > NL80211_CHAN_WIDTH_40) {
+		extracted =
+			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
+							 bitmap);
+
+		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
+							      chandef->width))
+			break;
+		sdata->u.mgd.flags |= ieee80211_chandef_downgrade(chandef);
+		*changed |= BSS_CHANGED_BANDWIDTH;
+	}
+
+	if (chandef->width == NL80211_CHAN_WIDTH_40)
+		extracted = 0;
+
+	if (sdata->vif.bss_conf.eht_puncturing != extracted) {
+		sdata->vif.bss_conf.eht_puncturing = extracted;
+		*changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+}
+
 /*
  * We can have multiple work items (and connection probing)
  * scheduling this timer, but we need to take care to only
@@ -3608,6 +3719,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 							    sta);
 
 			bss_conf->eht_support = sta->sta.eht_cap.has_eht;
+			changed |= BSS_CHANGED_EHT_PUNCTURING;
 		} else {
 			bss_conf->eht_support = false;
 		}
@@ -4100,6 +4212,41 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
 	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
 }
 
+static bool ieee80211_config_puncturing(struct ieee80211_sub_if_data *sdata,
+					const struct ieee80211_eht_operation *eht_oper,
+					u64 *changed)
+{
+	u16 bitmap, extracted;
+	u8 bw;
+
+	if (!u8_get_bits(eht_oper->present_bm,
+			 IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
+		bitmap = 0;
+	else
+		bitmap = get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
+
+	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
+						     &sdata->vif.bss_conf.chandef,
+						     bitmap);
+
+	/* accept if there are no changes */
+	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
+	    extracted == sdata->vif.bss_conf.eht_puncturing)
+		return true;
+
+	bw = u8_get_bits(eht_oper->chan_width, IEEE80211_EHT_OPER_CHAN_WIDTH);
+
+	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw)) {
+		sdata_info(sdata,
+			   "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
+			    sdata->u.mgd.associated->bssid, bitmap, bw);
+		return false;
+	}
+
+	ieee80211_handle_puncturing_bitmap(sdata, eht_oper, bitmap, changed);
+	return true;
+}
+
 static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
@@ -4113,7 +4260,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
 	struct sta_info *sta;
-	u32 changed = 0;
+	u64 changed = 0;
 	bool erp_valid;
 	u8 erp_value = 0;
 	u32 ncrc = 0;
@@ -4360,7 +4507,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 				elems->vht_cap_elem, elems->ht_operation,
 				elems->vht_operation, elems->he_operation,
 				elems->eht_operation,
-				elems->s1g_oper, bssid, &changed)) {
+				elems->s1g_oper, bssid, (u32 *)&changed)) {
 		mutex_unlock(&local->sta_mtx);
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
@@ -4386,6 +4533,21 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					       elems->pwr_constr_elem,
 					       elems->cisco_dtpc_elem);
 
+	if (elems->eht_operation &&
+	    !(ifmgd->flags & IEEE80211_STA_DISABLE_EHT)) {
+		if (!ieee80211_config_puncturing(sdata, elems->eht_operation,
+						 &changed)) {
+			ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
+					       WLAN_REASON_DEAUTH_LEAVING,
+					       true, deauth_buf);
+			ieee80211_report_disconnect(sdata, deauth_buf,
+						    sizeof(deauth_buf), true,
+						    WLAN_REASON_DEAUTH_LEAVING,
+						    false);
+			goto free;
+		}
+	}
+
 	ieee80211_bss_info_change_notify(sdata, changed);
 free:
 	kfree(elems);
@@ -6189,6 +6351,39 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		assoc_data->timeout = jiffies;
 		assoc_data->timeout_started = true;
 	}
+
+	sdata->vif.bss_conf.eht_puncturing = 0;
+	if (beacon_ies) {
+		const struct element *elem =
+			cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION,
+					       beacon_ies->data, beacon_ies->len);
+		const struct ieee80211_eht_operation *eht_oper;
+
+		eht_oper = (const void *)(elem->data + 1);
+
+		/*
+		 * The length should include one byte for the EID
+		 * and 2 for the disabled subchannel bitmap
+		 */
+		if (elem &&
+		    elem->datalen >= sizeof(*eht_oper) + 1 + 2 &&
+		    eht_oper->present_bm &
+				IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT) {
+			u8 bw = u8_get_bits(eht_oper->chan_width,
+					    IEEE80211_EHT_OPER_CHAN_WIDTH);
+			u16 bitmap;
+
+			bitmap = get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
+
+			if (ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw))
+				ieee80211_handle_puncturing_bitmap(sdata,
+								   eht_oper,
+								   bitmap,
+								   NULL);
+			else
+				ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		}
+	}
 	rcu_read_unlock();
 
 	run_again(sdata, assoc_data->timeout);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 682a164f795a..18786213bd16 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2540,6 +2540,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			    sdata->vif.bss_conf.protected_keep_alive)
 				changed |= BSS_CHANGED_KEEP_ALIVE;
 
+			if (sdata->vif.bss_conf.eht_puncturing)
+				changed |= BSS_CHANGED_EHT_PUNCTURING;
+
 			sdata_lock(sdata);
 			ieee80211_bss_info_change_notify(sdata, changed);
 			sdata_unlock(sdata);
-- 
2.35.1

