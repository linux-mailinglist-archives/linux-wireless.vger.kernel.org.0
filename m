Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2721F2417CA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHKIBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgHKIBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 04:01:22 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F6C06174A
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 01:01:22 -0700 (PDT)
Received: from [149.224.185.155] (helo=bertha9.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5PDh-0002ig-36; Tue, 11 Aug 2020 10:01:17 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V4 2/5] mac80211: rename csa counters to countdown counters
Date:   Tue, 11 Aug 2020 10:01:04 +0200
Message-Id: <20200811080107.3615705-2-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811080107.3615705-1-john@phrozen.org>
References: <20200811080107.3615705-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We want to reuse the functions and structs for other counters such as BSS
color change. Rename them to more generic names.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath10k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  4 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  6 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/mac80211_hwsim.c         |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 10 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  8 +-
 include/net/mac80211.h                        | 35 +++++----
 net/mac80211/cfg.c                            | 14 ++--
 net/mac80211/ibss.c                           |  4 +-
 net/mac80211/ieee80211_i.h                    |  6 +-
 net/mac80211/main.c                           |  2 +-
 net/mac80211/mesh.c                           |  4 +-
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/tx.c                             | 73 ++++++++++---------
 19 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3c0c33a9f30c..b37902222517 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2019,8 +2019,8 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 	if (!arvif->is_up)
 		return;
 
-	if (!ieee80211_csa_is_complete(vif)) {
-		ieee80211_csa_update_counter(vif);
+	if (!ieee80211_beacon_cntdwn_is_complete(vif)) {
+		ieee80211_beacon_update_cntdwn(vif);
 
 		ret = ath10k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index a81a1ab2de19..b661d4ec5d52 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3878,7 +3878,7 @@ void ath10k_wmi_event_host_swba(struct ath10k *ar, struct sk_buff *skb)
 		 * actual channel switch is done
 		 */
 		if (arvif->vif->csa_active &&
-		    ieee80211_csa_is_complete(arvif->vif)) {
+		    ieee80211_beacon_cntdwn_is_complete(arvif->vif)) {
 			ieee80211_csa_finish(arvif->vif);
 			continue;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8e3437a65673..9fffa37f1e2e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1593,8 +1593,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 	cmd->vdev_id = vdev_id;
 	cmd->tim_ie_offset = offs->tim_offset;
-	cmd->csa_switch_count_offset = offs->csa_counter_offs[0];
-	cmd->ext_csa_switch_count_offset = offs->csa_counter_offs[1];
+	cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
+	cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
 	cmd->buf_len = bcn->len;
 
 	ptr = skb->data + sizeof(*cmd);
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index e36f947e19fc..4daaf9b67d5f 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -365,7 +365,7 @@ bool ath9k_csa_is_finished(struct ath_softc *sc, struct ieee80211_vif *vif)
 	if (!vif || !vif->csa_active)
 		return false;
 
-	if (!ieee80211_csa_is_complete(vif))
+	if (!ieee80211_beacon_cntdwn_is_complete(vif))
 		return false;
 
 	ieee80211_csa_finish(vif);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index f20c839aeda2..c745897aa3d6 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -514,7 +514,7 @@ bool ath9k_htc_csa_is_finished(struct ath9k_htc_priv *priv)
 	if (!vif || !vif->csa_active)
 		return false;
 
-	if (!ieee80211_csa_is_complete(vif))
+	if (!ieee80211_beacon_cntdwn_is_complete(vif))
 		return false;
 
 	ieee80211_csa_finish(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b78992e341d5..81bc05d70267 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1300,8 +1300,8 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 
 	mvmvif->csa_countdown = true;
 
-	if (!ieee80211_csa_is_complete(csa_vif)) {
-		int c = ieee80211_csa_update_counter(csa_vif);
+	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
+		int c = ieee80211_beacon_update_cntdwn(csa_vif);
 
 		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif);
 		if (csa_vif->p2p &&
@@ -1543,7 +1543,7 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 
 	if (notif->csa_counter != IWL_PROBE_RESP_DATA_NO_CSA &&
 	    notif->csa_counter >= 1)
-		ieee80211_csa_set_counter(vif, notif->csa_counter);
+		ieee80211_beacon_set_cntdwn(vif, notif->csa_counter);
 }
 
 void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 1babc4bb5194..8abb57012240 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -172,7 +172,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 	 * So we just do nothing here and the switch
 	 * will be performed on the last TBTT.
 	 */
-	if (!ieee80211_csa_is_complete(csa_vif)) {
+	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
 		IWL_WARN(mvm, "CSA NOA started too early\n");
 		goto out_unlock;
 	}
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 9dd9d73f4484..dce3bc9c9f84 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1699,7 +1699,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 				rcu_dereference(vif->chanctx_conf)->def.chan);
 	}
 
-	if (vif->csa_active && ieee80211_csa_is_complete(vif))
+	if (vif->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
 		ieee80211_csa_finish(vif);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3d4bf72700a5..fbfb991ebd90 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1095,7 +1095,7 @@ EXPORT_SYMBOL_GPL(mt76_get_txpower);
 static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->csa_active && ieee80211_csa_is_complete(vif))
+	if (vif->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
 		ieee80211_csa_finish(vif);
 }
 
@@ -1120,7 +1120,7 @@ __mt76_csa_check(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!vif->csa_active)
 		return;
 
-	dev->csa_complete |= ieee80211_csa_is_complete(vif);
+	dev->csa_complete |= ieee80211_beacon_cntdwn_is_complete(vif);
 }
 
 void mt76_csa_check(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d0cbb283982f..084982eb6abd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -650,12 +650,12 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
-	if (offs.csa_counter_offs[0]) {
+	if (offs.cntdwn_counter_offs[0]) {
 		u16 csa_offs;
 
-		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
+		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
 		req.csa_ie_pos = cpu_to_le16(csa_offs);
-		req.csa_cnt = skb->data[offs.csa_counter_offs[0]];
+		req.csa_cnt = skb->data[offs.cntdwn_counter_offs[0]];
 	}
 	dev_kfree_skb(skb);
 
@@ -1713,10 +1713,10 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
 
-	if (offs.csa_counter_offs[0]) {
+	if (offs.cntdwn_counter_offs[0]) {
 		u16 csa_offs;
 
-		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
+		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
 		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
 	}
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index eaed5ef05401..ac8ec257da03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2282,7 +2282,7 @@ mt7915_mcu_beacon_csa(struct sk_buff *rskb, struct sk_buff *skb,
 		      struct bss_info_bcn *bcn,
 		      struct ieee80211_mutable_offsets *offs)
 {
-	if (offs->csa_counter_offs[0]) {
+	if (offs->cntdwn_counter_offs[0]) {
 		struct tlv *tlv;
 		struct bss_info_bcn_csa *csa;
 
@@ -2290,7 +2290,7 @@ mt7915_mcu_beacon_csa(struct sk_buff *rskb, struct sk_buff *skb,
 						   sizeof(*csa), &bcn->sub_ntlv,
 						   &bcn->len);
 		csa = (struct bss_info_bcn_csa *)tlv;
-		csa->cnt = skb->data[offs->csa_counter_offs[0]];
+		csa->cnt = skb->data[offs->cntdwn_counter_offs[0]];
 	}
 }
 
@@ -2312,8 +2312,8 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
 	cont->pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	cont->tim_ofs = cpu_to_le16(offs->tim_offset);
 
-	if (offs->csa_counter_offs[0])
-		cont->csa_ofs = cpu_to_le16(offs->csa_counter_offs[0] - 4);
+	if (offs->cntdwn_counter_offs[0])
+		cont->csa_ofs = cpu_to_le16(offs->cntdwn_counter_offs[0] - 4);
 
 	buf = (u8 *)tlv + sizeof(*cont);
 	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 66e2bfd165e8..ec148b3e9c41 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3736,7 +3736,7 @@ enum ieee80211_reconfig_type {
  *	decremented, and when they reach 1 the driver must call
  *	ieee80211_csa_finish(). Drivers which use ieee80211_beacon_get()
  *	get the csa counter decremented by mac80211, but must check if it is
- *	1 using ieee80211_csa_is_complete() after the beacon has been
+ *	1 using ieee80211_beacon_counter_is_complete() after the beacon has been
  *	transmitted and then call ieee80211_csa_finish().
  *	If the CSA count starts as zero or 1, this function will not be called,
  *	since there won't be any time to beacon before the switch anyway.
@@ -4763,21 +4763,21 @@ void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
  */
 void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
 
-#define IEEE80211_MAX_CSA_COUNTERS_NUM 2
+#define IEEE80211_MAX_CNTDWN_COUNTERS_NUM 2
 
 /**
  * struct ieee80211_mutable_offsets - mutable beacon offsets
  * @tim_offset: position of TIM element
  * @tim_length: size of TIM element
- * @csa_counter_offs: array of IEEE80211_MAX_CSA_COUNTERS_NUM offsets
- *	to CSA counters.  This array can contain zero values which
+ * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
+ *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
-	u16 csa_counter_offs[IEEE80211_MAX_CSA_COUNTERS_NUM];
+	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 };
 
 /**
@@ -4846,31 +4846,31 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
 }
 
 /**
- * ieee80211_csa_update_counter - request mac80211 to decrement the csa counter
+ * ieee80211_beacon_update_cntdwn - request mac80211 to decrement the beacon countdown
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  *
- * The csa counter should be updated after each beacon transmission.
+ * The beacon counter should be updated after each beacon transmission.
  * This function is called implicitly when
  * ieee80211_beacon_get/ieee80211_beacon_get_tim are called, however if the
  * beacon frames are generated by the device, the driver should call this
- * function after each beacon transmission to sync mac80211's csa counters.
+ * function after each beacon transmission to sync mac80211's beacon countdown.
  *
- * Return: new csa counter value
+ * Return: new countdown value
  */
-u8 ieee80211_csa_update_counter(struct ieee80211_vif *vif);
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif);
 
 /**
- * ieee80211_csa_set_counter - request mac80211 to set csa counter
+ * ieee80211_beacon_set_cntdwn - request mac80211 to set beacon countdown
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @counter: the new value for the counter
  *
- * The csa counter can be changed by the device, this API should be
+ * The beacon countdown can be changed by the device, this API should be
  * used by the device driver to update csa counter in mac80211.
  *
- * It should never be used together with ieee80211_csa_update_counter(),
+ * It should never be used together with ieee80211_beacon_update_cntdwn(),
  * as it will cause a race condition around the counter value.
  */
-void ieee80211_csa_set_counter(struct ieee80211_vif *vif, u8 counter);
+void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter);
 
 /**
  * ieee80211_csa_finish - notify mac80211 about channel switch
@@ -4883,13 +4883,12 @@ void ieee80211_csa_set_counter(struct ieee80211_vif *vif, u8 counter);
 void ieee80211_csa_finish(struct ieee80211_vif *vif);
 
 /**
- * ieee80211_csa_is_complete - find out if counters reached 1
+ * ieee80211_beacon_cntdwn_is_complete - find out if countdown reached 1
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  *
- * This function returns whether the channel switch counters reached zero.
+ * This function returns whether the countdown reached zero.
  */
-bool ieee80211_csa_is_complete(struct ieee80211_vif *vif);
-
+bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif);
 
 /**
  * ieee80211_proberesp_get - retrieve a Probe Response template
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87fddd84c621..b4e39e31a985 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -826,9 +826,9 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	memcpy(new->data, resp, resp_len);
 
 	if (csa)
-		memcpy(new->csa_counter_offsets, csa->counter_offsets_presp,
+		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_presp,
 		       csa->n_counter_offsets_presp *
-		       sizeof(new->csa_counter_offsets[0]));
+		       sizeof(new->cntdwn_counter_offsets[0]));
 
 	rcu_assign_pointer(sdata->u.ap.probe_resp, new);
 	if (old)
@@ -926,10 +926,10 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->tail_len = new_tail_len;
 
 	if (csa) {
-		new->csa_current_counter = csa->count;
-		memcpy(new->csa_counter_offsets, csa->counter_offsets_beacon,
+		new->cntdwn_current_counter = csa->count;
+		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
 		       csa->n_counter_offsets_beacon *
-		       sizeof(new->csa_counter_offsets[0]));
+		       sizeof(new->cntdwn_counter_offsets[0]));
 	}
 
 	/* copy in head */
@@ -3186,9 +3186,9 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 			break;
 
 		if ((params->n_counter_offsets_beacon >
-		     IEEE80211_MAX_CSA_COUNTERS_NUM) ||
+		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
-		     IEEE80211_MAX_CSA_COUNTERS_NUM))
+		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM))
 			return -EINVAL;
 
 		csa.counter_offsets_beacon = params->counter_offsets_beacon;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 53632c2f5217..c0963969a465 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -145,9 +145,9 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 		*pos++ = csa_settings->block_tx ? 1 : 0;
 		*pos++ = ieee80211_frequency_to_channel(
 				csa_settings->chandef.chan->center_freq);
-		presp->csa_counter_offsets[0] = (pos - presp->head);
+		presp->cntdwn_counter_offsets[0] = (pos - presp->head);
 		*pos++ = csa_settings->count;
-		presp->csa_current_counter = csa_settings->count;
+		presp->cntdwn_current_counter = csa_settings->count;
 	}
 
 	/* put the remaining rates in WLAN_EID_EXT_SUPP_RATES */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0b1eaec6649f..6bf879660a93 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -259,15 +259,15 @@ struct beacon_data {
 	u8 *head, *tail;
 	int head_len, tail_len;
 	struct ieee80211_meshconf_ie *meshconf;
-	u16 csa_counter_offsets[IEEE80211_MAX_CSA_COUNTERS_NUM];
-	u8 csa_current_counter;
+	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+	u8 cntdwn_current_counter;
 	struct rcu_head rcu_head;
 };
 
 struct probe_resp {
 	struct rcu_head rcu_head;
 	int len;
-	u16 csa_counter_offsets[IEEE80211_MAX_CSA_COUNTERS_NUM];
+	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 data[];
 };
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b4a2efe8e83a..523380aed92e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1168,7 +1168,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 	}
 
-	local->hw.wiphy->max_num_csa_counters = IEEE80211_MAX_CSA_COUNTERS_NUM;
+	local->hw.wiphy->max_num_csa_counters = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
 
 	/*
 	 * We use the number of queues for feature tests (QoS, HT) internally
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 7ecd801a943b..5ae003324426 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -864,8 +864,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		*pos++ = 0x0;
 		*pos++ = ieee80211_frequency_to_channel(
 				csa->settings.chandef.chan->center_freq);
-		bcn->csa_current_counter = csa->settings.count;
-		bcn->csa_counter_offsets[0] = hdr_len + 6;
+		bcn->cntdwn_current_counter = csa->settings.count;
+		bcn->cntdwn_counter_offsets[0] = hdr_len + 6;
 		*pos++ = csa->settings.count;
 		*pos++ = WLAN_EID_CHAN_SWITCH_PARAM;
 		*pos++ = 6;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index f470d1a7ce9b..1ac7b8c374c9 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -916,7 +916,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		if (beacon)
 			for (i = 0; i < params->n_csa_offsets; i++)
 				data[params->csa_offsets[i]] =
-					beacon->csa_current_counter;
+					beacon->cntdwn_current_counter;
 
 		rcu_read_unlock();
 	}
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dca01d7e6e3e..d2136007e2eb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4538,14 +4538,14 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static void ieee80211_set_csa(struct ieee80211_sub_if_data *sdata,
-			      struct beacon_data *beacon)
+static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
+					struct beacon_data *beacon)
 {
 	struct probe_resp *resp;
 	u8 *beacon_data;
 	size_t beacon_data_len;
 	int i;
-	u8 count = beacon->csa_current_counter;
+	u8 count = beacon->cntdwn_current_counter;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
@@ -4565,36 +4565,36 @@ static void ieee80211_set_csa(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_read_lock();
-	for (i = 0; i < IEEE80211_MAX_CSA_COUNTERS_NUM; ++i) {
+	for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; ++i) {
 		resp = rcu_dereference(sdata->u.ap.probe_resp);
 
-		if (beacon->csa_counter_offsets[i]) {
-			if (WARN_ON_ONCE(beacon->csa_counter_offsets[i] >=
+		if (beacon->cntdwn_counter_offsets[i]) {
+			if (WARN_ON_ONCE(beacon->cntdwn_counter_offsets[i] >=
 					 beacon_data_len)) {
 				rcu_read_unlock();
 				return;
 			}
 
-			beacon_data[beacon->csa_counter_offsets[i]] = count;
+			beacon_data[beacon->cntdwn_counter_offsets[i]] = count;
 		}
 
 		if (sdata->vif.type == NL80211_IFTYPE_AP && resp)
-			resp->data[resp->csa_counter_offsets[i]] = count;
+			resp->data[resp->cntdwn_counter_offsets[i]] = count;
 	}
 	rcu_read_unlock();
 }
 
-static u8 __ieee80211_csa_update_counter(struct beacon_data *beacon)
+static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
 {
-	beacon->csa_current_counter--;
+	beacon->cntdwn_current_counter--;
 
 	/* the counter should never reach 0 */
-	WARN_ON_ONCE(!beacon->csa_current_counter);
+	WARN_ON_ONCE(!beacon->cntdwn_current_counter);
 
-	return beacon->csa_current_counter;
+	return beacon->cntdwn_current_counter;
 }
 
-u8 ieee80211_csa_update_counter(struct ieee80211_vif *vif)
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct beacon_data *beacon = NULL;
@@ -4612,15 +4612,15 @@ u8 ieee80211_csa_update_counter(struct ieee80211_vif *vif)
 	if (!beacon)
 		goto unlock;
 
-	count = __ieee80211_csa_update_counter(beacon);
+	count = __ieee80211_beacon_update_cntdwn(beacon);
 
 unlock:
 	rcu_read_unlock();
 	return count;
 }
-EXPORT_SYMBOL(ieee80211_csa_update_counter);
+EXPORT_SYMBOL(ieee80211_beacon_update_cntdwn);
 
-void ieee80211_csa_set_counter(struct ieee80211_vif *vif, u8 counter)
+void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct beacon_data *beacon = NULL;
@@ -4637,15 +4637,15 @@ void ieee80211_csa_set_counter(struct ieee80211_vif *vif, u8 counter)
 	if (!beacon)
 		goto unlock;
 
-	if (counter < beacon->csa_current_counter)
-		beacon->csa_current_counter = counter;
+	if (counter < beacon->cntdwn_current_counter)
+		beacon->cntdwn_current_counter = counter;
 
 unlock:
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(ieee80211_csa_set_counter);
+EXPORT_SYMBOL(ieee80211_beacon_set_cntdwn);
 
-bool ieee80211_csa_is_complete(struct ieee80211_vif *vif)
+bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct beacon_data *beacon = NULL;
@@ -4688,20 +4688,21 @@ bool ieee80211_csa_is_complete(struct ieee80211_vif *vif)
 		goto out;
 	}
 
-	if (!beacon->csa_counter_offsets[0])
+	if (!beacon->cntdwn_counter_offsets[0])
 		goto out;
 
-	if (WARN_ON_ONCE(beacon->csa_counter_offsets[0] > beacon_data_len))
+	if (WARN_ON_ONCE(beacon->cntdwn_counter_offsets[0] > beacon_data_len))
 		goto out;
 
-	if (beacon_data[beacon->csa_counter_offsets[0]] == 1)
+	if (beacon_data[beacon->cntdwn_counter_offsets[0]] == 1)
 		ret = true;
+
  out:
 	rcu_read_unlock();
 
 	return ret;
 }
-EXPORT_SYMBOL(ieee80211_csa_is_complete);
+EXPORT_SYMBOL(ieee80211_beacon_cntdwn_is_complete);
 
 static int ieee80211_beacon_protect(struct sk_buff *skb,
 				    struct ieee80211_local *local,
@@ -4761,11 +4762,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ap->beacon);
 		if (beacon) {
-			if (beacon->csa_counter_offsets[0]) {
+			if (beacon->cntdwn_counter_offsets[0]) {
 				if (!is_template)
-					__ieee80211_csa_update_counter(beacon);
+					ieee80211_beacon_update_cntdwn(vif);
 
-				ieee80211_set_csa(sdata, beacon);
+				ieee80211_set_beacon_cntdwn(sdata, beacon);
 			}
 
 			/*
@@ -4809,11 +4810,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
-		if (beacon->csa_counter_offsets[0]) {
+		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
-				__ieee80211_csa_update_counter(beacon);
+				__ieee80211_beacon_update_cntdwn(beacon);
 
-			ieee80211_set_csa(sdata, beacon);
+			ieee80211_set_beacon_cntdwn(sdata, beacon);
 		}
 
 		skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
@@ -4833,16 +4834,16 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
-		if (beacon->csa_counter_offsets[0]) {
+		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
 				/* TODO: For mesh csa_counter is in TU, so
 				 * decrementing it by one isn't correct, but
 				 * for now we leave it consistent with overall
 				 * mac80211's behavior.
 				 */
-				__ieee80211_csa_update_counter(beacon);
+				__ieee80211_beacon_update_cntdwn(beacon);
 
-			ieee80211_set_csa(sdata, beacon);
+			ieee80211_set_beacon_cntdwn(sdata, beacon);
 		}
 
 		if (ifmsh->sync_ops)
@@ -4874,13 +4875,13 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	if (offs && beacon) {
 		int i;
 
-		for (i = 0; i < IEEE80211_MAX_CSA_COUNTERS_NUM; i++) {
-			u16 csa_off = beacon->csa_counter_offsets[i];
+		for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; i++) {
+			u16 csa_off = beacon->cntdwn_counter_offsets[i];
 
 			if (!csa_off)
 				continue;
 
-			offs->csa_counter_offs[i] = csa_off_base + csa_off;
+			offs->cntdwn_counter_offs[i] = csa_off_base + csa_off;
 		}
 	}
 
-- 
2.25.1

