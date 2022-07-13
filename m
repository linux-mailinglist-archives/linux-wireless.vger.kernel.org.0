Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73525573341
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiGMJpq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiGMJpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2ADA5A9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hXd9YIbKCZW4fFqPcZ5aKLZFogFj1AoANhWpIFp7RuE=;
        t=1657705514; x=1658915114; b=BZ0RVAhkAMsenIGgXSC1t/jtsApEnW02RZGFx7xzOg/Wzpj
        3LNhPY4urHqCF6cRO/IqHMgfejOJNOYbKzHPeAuLVps5ZbqXFvT4IZPv6QTpgkJLZwLEKSTHLTAnP
        A4HTJp2xD/64sjNmLMgf6koWHvRMsC8OBw0jSyMgtIpeeVPEh5JNXxDcubbumOua1CIROT7IVRzlR
        bLrEaHDZbSfCY5CV/fPqYS+wgQHaF9RxLSmv5jKwNs+OiIsdD11PfZTi5M3b3DxXBg/oRW+AAAAV+
        MhS+oWsDeTKnMj4JYcRs4SWxss143s2kLM1gYjQZw0c06fJ1Yher2siItbgs4f8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvg-00EgvB-CZ;
        Wed, 13 Jul 2022 11:45:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/76] wifi: mac80211: move ps setting to vif config
Date:   Wed, 13 Jul 2022 11:44:13 +0200
Message-Id: <20220713114425.6707ffb6bc89.I9b0183a466e0a6e41179e8aade5e08d6192c297a@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Johannes Berg <johannes.berg@intel.com>

This really shouldn't be in a per-link config, we don't want
to let anyone control it that way (if anything, link powersave
could be forced through APIs to activate/deactivate a link),
and we don't support powersave in software with devices that
can do MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c                | 2 +-
 drivers/net/wireless/ath/ath11k/mac.c                | 2 +-
 drivers/net/wireless/ath/wcn36xx/main.c              | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 2 +-
 drivers/net/wireless/silabs/wfx/sta.c                | 6 +++---
 drivers/net/wireless/ti/wlcore/main.c                | 4 ++--
 include/net/mac80211.h                               | 6 +++---
 net/mac80211/main.c                                  | 1 +
 net/mac80211/mlme.c                                  | 7 +++----
 net/mac80211/trace.h                                 | 4 ++--
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3d111d6447f0..b18f32261d15 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6252,7 +6252,7 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_PS) {
-		arvif->ps = vif->bss_conf.ps;
+		arvif->ps = vif->cfg.ps;
 
 		ret = ath10k_config_ps(ar);
 		if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 17dbc7d9cf29..1cf1e1f18dba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3292,7 +3292,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_PS &&
 	    ar->ab->hw_params.supports_sta_ps) {
-		arvif->ps = vif->bss_conf.ps;
+		arvif->ps = vif->cfg.ps;
 
 		ret = ath11k_mac_config_ps(ar);
 		if (ret)
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ace8641909bd..dc59cafd29e3 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -385,7 +385,7 @@ static void wcn36xx_change_ps(struct wcn36xx *wcn, bool enable)
 	list_for_each_entry(tmp, &wcn->vif_list, list) {
 		vif = wcn36xx_priv_to_vif(tmp);
 		if (enable && !wcn->sw_scan) {
-			if (vif->bss_conf.ps) /* ps allowed ? */
+			if (vif->cfg.ps) /* ps allowed ? */
 				wcn36xx_pmc_enter_bmps_state(wcn, vif);
 		} else {
 			wcn36xx_pmc_exit_bmps_state(wcn, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index b49f265a421f..f5744162d0d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -359,7 +359,7 @@ static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 
 	cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_SAVE_ENA_MSK);
 
-	if (!vif->bss_conf.ps || !mvmvif->pm_enabled)
+	if (!vif->cfg.ps || !mvmvif->pm_enabled)
 		return;
 
 	if (iwl_mvm_vif_low_latency(mvmvif) && vif->p2p &&
@@ -890,7 +890,7 @@ static int iwl_mvm_power_set_ba(struct iwl_mvm *mvm,
 
 	mvmvif->bf_data.ba_enabled = !(!mvmvif->pm_enabled ||
 				       mvm->ps_disabled ||
-				       !vif->bss_conf.ps ||
+				       !vif->cfg.ps ||
 				       iwl_mvm_vif_low_latency(mvmvif));
 
 	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 303975f9e2b5..a79043f30775 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1861,7 +1861,7 @@ static bool rs_tpc_allowed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int index = rate->index;
 	bool cam = (iwlmvm_mod_params.power_scheme == IWL_POWER_SCHEME_CAM);
 	bool sta_ps_disabled = (vif->type == NL80211_IFTYPE_STATION &&
-				!vif->bss_conf.ps);
+				!vif->cfg.ps);
 
 	IWL_DEBUG_RATE(mvm, "cam: %d sta_ps_disabled %d\n",
 		       cam, sta_ps_disabled);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index d3da54e6670b..389f8c61939d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -193,7 +193,7 @@ int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
 			      */
 	} req = {
 		.bss_idx = mvif->idx,
-		.ps_state = vif->bss_conf.ps ? 2 : 0,
+		.ps_state = vif->cfg.ps ? 2 : 0,
 	};
 
 	if (vif->type != NL80211_IFTYPE_STATION)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 3b5b475b0875..976686075dd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -972,7 +972,7 @@ int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		.ps = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
 			.len = cpu_to_le16(sizeof(struct ps_tlv)),
-			.ps_state = vif->bss_conf.ps ? 2 : 0,
+			.ps_state = vif->cfg.ps ? 2 : 0,
 		},
 	};
 
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 0378144795ca..47fd887ce6fe 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -175,7 +175,7 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			/* It is useless to enable PS if channels are the same. */
 			if (enable_ps)
 				*enable_ps = false;
-			if (vif->cfg.assoc && vif->bss_conf.ps)
+			if (vif->cfg.assoc && vif->cfg.ps)
 				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
 			return -1;
 		}
@@ -188,8 +188,8 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			return 30;
 	}
 	if (enable_ps)
-		*enable_ps = vif->bss_conf.ps;
-	if (vif->cfg.assoc && vif->bss_conf.ps)
+		*enable_ps = vif->cfg.ps;
+	if (vif->cfg.assoc && vif->cfg.ps)
 		return conf->dynamic_ps_timeout;
 	else
 		return -1;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index a1923ef52d55..d1200080f165 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4481,7 +4481,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 	}
 
 	if (changed & BSS_CHANGED_PS) {
-		if ((bss_conf->ps) &&
+		if (vif->cfg.ps &&
 		    test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags) &&
 		    !test_bit(WLVIF_FLAG_IN_PS, &wlvif->flags)) {
 			int ps_mode;
@@ -4501,7 +4501,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 			if (ret < 0)
 				wl1271_warning("enter %s ps failed %d",
 					       ps_mode_str, ret);
-		} else if (!bss_conf->ps &&
+		} else if (!vif->cfg.ps &&
 			   test_bit(WLVIF_FLAG_IN_PS, &wlvif->flags)) {
 			wl1271_debug(DEBUG_PSM, "auto ps disabled");
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f917f7d7614e..210b49c6cd50 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -578,8 +578,6 @@ struct ieee80211_fils_discovery {
  * @cqm_rssi_high: Connection quality monitor RSSI upper threshold.
  * @cqm_rssi_hyst: Connection quality monitor RSSI hysteresis
  * @qos: This is a QoS-enabled BSS.
- * @ps: power-save mode (STA only). This flag is NOT affected by
- *	offchannel/dynamic_ps operations.
  * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
  * @txpower: TX power in dBm.  INT_MIN means not configured.
  * @txpower_type: TX power adjustment used to control per packet Transmit
@@ -673,7 +671,6 @@ struct ieee80211_bss_conf {
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_mu_group_data mu_group;
 	bool qos;
-	bool ps;
 	bool hidden_ssid;
 	int txpower;
 	enum nl80211_tx_power_setting txpower_type;
@@ -1715,6 +1712,8 @@ enum ieee80211_offload_flags {
  * @assoc: association status
  * @ibss_joined: indicates whether this station is part of an IBSS or not
  * @ibss_creator: indicates if a new IBSS network is being created
+ * @ps: power-save mode (STA only). This flag is NOT affected by
+ *	offchannel/dynamic_ps operations.
  * @aid: association ID number, valid only when @assoc is true
  * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
  *	may filter ARP queries targeted for other addresses than listed here.
@@ -1734,6 +1733,7 @@ struct ieee80211_vif_cfg {
 	/* association related data */
 	bool assoc, ibss_joined;
 	bool ibss_creator;
+	bool ps;
 	u16 aid;
 
 	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 191f4d35ef60..1258e506377e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -202,6 +202,7 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 
 #define BSS_CHANGED_VIF_CFG_FLAGS (BSS_CHANGED_ASSOC |\
 				   BSS_CHANGED_IDLE |\
+				   BSS_CHANGED_PS |\
 				   BSS_CHANGED_IBSS |\
 				   BSS_CHANGED_ARP_FILTER |\
 				   BSS_CHANGED_SSID)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f994945039cd..1035d6d433b1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1868,10 +1868,9 @@ void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata)
 {
 	bool ps_allowed = ieee80211_powersave_allowed(sdata);
 
-	if (sdata->vif.bss_conf.ps != ps_allowed) {
-		sdata->vif.bss_conf.ps = ps_allowed;
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  BSS_CHANGED_PS);
+	if (sdata->vif.cfg.ps != ps_allowed) {
+		sdata->vif.cfg.ps = ps_allowed;
+		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_PS);
 	}
 }
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 6aa06fba5b50..751f08b47d0c 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -413,6 +413,7 @@ TRACE_EVENT(drv_vif_cfg_changed,
 		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
 		__field(int, s1g)
 		__field(bool, idle)
+		__field(bool, ps)
 	),
 
 	TP_fast_assign(
@@ -423,6 +424,7 @@ TRACE_EVENT(drv_vif_cfg_changed,
 		__entry->assoc = sdata->vif.cfg.assoc;
 		__entry->ibss_joined = sdata->vif.cfg.ibss_joined;
 		__entry->ibss_creator = sdata->vif.cfg.ibss_creator;
+		__entry->ps = sdata->vif.cfg.ps;
 
 		__entry->arp_addr_cnt = sdata->vif.cfg.arp_addr_cnt;
 		memcpy(__get_dynamic_array(arp_addr_list),
@@ -475,7 +477,6 @@ TRACE_EVENT(drv_link_info_changed,
 		__field(u32, channel_cfreq1)
 		__field(u32, channel_cfreq1_offset)
 		__field(bool, qos)
-		__field(bool, ps)
 		__field(bool, hidden_ssid)
 		__field(int, txpower)
 		__field(u8, p2p_oppps_ctwindow)
@@ -506,7 +507,6 @@ TRACE_EVENT(drv_link_info_changed,
 		__entry->channel_cfreq1 = link_conf->chandef.center_freq1;
 		__entry->channel_cfreq1_offset = link_conf->chandef.freq1_offset;
 		__entry->qos = link_conf->qos;
-		__entry->ps = link_conf->ps;
 		__entry->hidden_ssid = link_conf->hidden_ssid;
 		__entry->txpower = link_conf->txpower;
 		__entry->p2p_oppps_ctwindow = link_conf->p2p_noa_attr.oppps_ctwindow;
-- 
2.36.1

