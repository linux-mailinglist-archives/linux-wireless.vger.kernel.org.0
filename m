Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B352EADD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiETLc5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiETLcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 07:32:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223825931B
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M+zVxmYxrdJKojj2h9SFomSp0uT1956G2CnkOBpqzTg=;
        t=1653046368; x=1654255968; b=TfIfx14i89d6kA7vdHwM4aVm3iSUK7K1zLEbtB/iBp+IUA0
        QSSZnQZUVXaNJl7OOpJohajCU4VrUKyhAxRJaAsoC0oEM0YqJ4/zXnDtFRE43dFtGA0q2xhvoRNje
        E5NiIrgV7kQDLlIubc2peMxNvYoRtLNrTIXFvDdT8tt9ihbdth1V9DZ1Q+3JUOYuIVfYVT+W3Nd9y
        v8MTrpQwKpvnBzQ+wjd2bcpWwVHJpToSj3BdLNLrZ8aAdzrM3DopaM9IRwiQ3AfXkXzqRwiwNqhdu
        IRovIjl0SznAAzy9UjFA2R3wr5rgwEzeitUCUfLM7S3uGh23/R7v1iRO02pRKOTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ns0s9-00HJjx-6w;
        Fri, 20 May 2022 13:32:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] mac80211: move some future per-link data to bss_conf
Date:   Fri, 20 May 2022 13:32:40 +0200
Message-Id: <20220520132938.2c090fa4784e.Id725e31fd8bb9bfd214284c41467d9bd6e2efe80@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520113242.129546-1-johannes@sipsolutions.net>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
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

To add MLD, reuse the bss_conf structure later for per-link
information, so move some things into it that are per link.

Most transformations were done with the following spatch:

    @@
    expression sdata;
    identifier var = { chanctx_conf, mu_mimo_owner, csa_active, color_change_active, color_change_color };
    @@
    -sdata->vif.var
    +sdata->vif.bss_conf.var

    @@
    struct ieee80211_vif *vif;
    identifier var = { chanctx_conf, mu_mimo_owner, csa_active, color_change_active, color_change_color };
    @@
    -vif->var
    +vif->bss_conf.var

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c      |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  8 ++--
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         | 12 +++---
 drivers/net/wireless/ath/ath11k/wmi.c         |  4 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  4 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++---
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 drivers/net/wireless/mac80211_hwsim.c         | 22 ++++++----
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 10 ++---
 drivers/net/wireless/ti/wlcore/main.c         |  2 +-
 include/net/mac80211.h                        | 40 +++++++++---------
 net/mac80211/airtime.c                        |  2 +-
 net/mac80211/cfg.c                            | 40 +++++++++---------
 net/mac80211/chan.c                           | 37 ++++++++--------
 net/mac80211/driver-ops.h                     |  2 +-
 net/mac80211/ethtool.c                        |  2 +-
 net/mac80211/ibss.c                           |  8 ++--
 net/mac80211/ieee80211_i.h                    |  6 +--
 net/mac80211/iface.c                          |  8 ++--
 net/mac80211/main.c                           |  4 +-
 net/mac80211/mesh.c                           | 12 +++---
 net/mac80211/mlme.c                           | 42 +++++++++----------
 net/mac80211/ocb.c                            |  2 +-
 net/mac80211/offchannel.c                     |  4 +-
 net/mac80211/rate.c                           |  4 +-
 net/mac80211/rx.c                             |  2 +-
 net/mac80211/sta_info.c                       |  2 +-
 net/mac80211/tdls.c                           |  4 +-
 net/mac80211/tx.c                             | 28 ++++++-------
 net/mac80211/util.c                           | 16 +++----
 net/mac80211/vht.c                            |  4 +-
 45 files changed, 195 insertions(+), 190 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 771252dd6d4e..fe34fcc00af0 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3840,7 +3840,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 	switch (txrate.flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
 		if (arsta->arvif && arsta->arvif->vif)
-			conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
+			conf = rcu_dereference(arsta->arvif->vif->bss_conf.chanctx_conf);
 		if (conf && conf->def.chan->band == NL80211_BAND_5GHZ)
 			arsta->tx_info.status.rates[0].idx = rate_idx - 4;
 		break;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3570a5895ea8..6407f509e91b 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -659,7 +659,7 @@ int ath10k_mac_vif_chan(struct ieee80211_vif *vif,
 	struct ieee80211_chanctx_conf *conf;
 
 	rcu_read_lock();
-	conf = rcu_dereference(vif->chanctx_conf);
+	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (!conf) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -2028,7 +2028,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return;
 
-	if (!vif->csa_active)
+	if (!vif->bss_conf.csa_active)
 		return;
 
 	if (!arvif->is_up)
@@ -8798,7 +8798,7 @@ ath10k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 {
 	struct ath10k_mac_change_chanctx_arg *arg = data;
 
-	if (rcu_access_pointer(vif->chanctx_conf) != arg->ctx)
+	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != arg->ctx)
 		return;
 
 	arg->n_vifs++;
@@ -8811,7 +8811,7 @@ ath10k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 	struct ath10k_mac_change_chanctx_arg *arg = data;
 	struct ieee80211_chanctx_conf *ctx;
 
-	ctx = rcu_access_pointer(vif->chanctx_conf);
+	ctx = rcu_access_pointer(vif->bss_conf.chanctx_conf);
 	if (ctx != arg->ctx)
 		return;
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 7efbe03fbca8..876410a47d1d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -205,7 +205,7 @@ static int ath10k_wmi_tlv_event_bcn_tx_status(struct ath10k *ar,
 	}
 
 	arvif = ath10k_get_arvif(ar, vdev_id);
-	if (arvif && arvif->is_up && arvif->vif->csa_active)
+	if (arvif && arvif->is_up && arvif->vif->bss_conf.csa_active)
 		ieee80211_queue_work(ar->hw, &arvif->ap_csa_work);
 
 	kfree(tb);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cd438f76f284..af19cab24c76 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3882,7 +3882,7 @@ void ath10k_wmi_event_host_swba(struct ath10k *ar, struct sk_buff *skb)
 		 * Once CSA counter is completed stop sending beacons until
 		 * actual channel switch is done
 		 */
-		if (arvif->vif->csa_active &&
+		if (arvif->vif->bss_conf.csa_active &&
 		    ieee80211_beacon_cntdwn_is_complete(arvif->vif)) {
 			ieee80211_csa_finish(arvif->vif);
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ee1590b16eff..f6ae3b308ac8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -505,7 +505,7 @@ static int ath11k_mac_vif_chan(struct ieee80211_vif *vif,
 	struct ieee80211_chanctx_conf *conf;
 
 	rcu_read_lock();
-	conf = rcu_dereference(vif->chanctx_conf);
+	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (!conf) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -1398,10 +1398,10 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
 
-	if (!vif->color_change_active && !arvif->bcca_zero_sent)
+	if (!vif->bss_conf.color_change_active && !arvif->bcca_zero_sent)
 		return;
 
-	if (vif->color_change_active && ieee80211_beacon_cntdwn_is_complete(vif)) {
+	if (vif->bss_conf.color_change_active && ieee80211_beacon_cntdwn_is_complete(vif)) {
 		arvif->bcca_zero_sent = true;
 		ieee80211_color_change_finish(vif);
 		return;
@@ -1409,7 +1409,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 
 	arvif->bcca_zero_sent = false;
 
-	if (vif->color_change_active)
+	if (vif->bss_conf.color_change_active)
 		ieee80211_beacon_update_cntdwn(vif);
 	ath11k_mac_setup_bcn_tmpl(arvif);
 }
@@ -6848,7 +6848,7 @@ ath11k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 {
 	struct ath11k_mac_change_chanctx_arg *arg = data;
 
-	if (rcu_access_pointer(vif->chanctx_conf) != arg->ctx)
+	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != arg->ctx)
 		return;
 
 	arg->n_vifs++;
@@ -6861,7 +6861,7 @@ ath11k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 	struct ath11k_mac_change_chanctx_arg *arg = data;
 	struct ieee80211_chanctx_conf *ctx;
 
-	ctx = rcu_access_pointer(vif->chanctx_conf);
+	ctx = rcu_access_pointer(vif->bss_conf.chanctx_conf);
 	if (ctx != arg->ctx)
 		return;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 84d1c7054013..ebfe5d8a32fe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1700,7 +1700,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	cmd->vdev_id = vdev_id;
 	cmd->tim_ie_offset = offs->tim_offset;
 
-	if (vif->csa_active) {
+	if (vif->bss_conf.csa_active) {
 		cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
 		cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
 	}
@@ -7475,7 +7475,7 @@ ath11k_wmi_process_csa_switch_count_event(struct ath11k_base *ab,
 			continue;
 		}
 
-		if (arvif->is_up && arvif->vif->csa_active)
+		if (arvif->is_up && arvif->vif->bss_conf.csa_active)
 			ieee80211_csa_finish(arvif->vif);
 	}
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 72e2e71aac0e..8b1b966bcef1 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -362,7 +362,7 @@ static void ath9k_set_tsfadjust(struct ath_softc *sc,
 
 bool ath9k_csa_is_finished(struct ath_softc *sc, struct ieee80211_vif *vif)
 {
-	if (!vif || !vif->csa_active)
+	if (!vif || !vif->bss_conf.csa_active)
 		return false;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(vif))
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index c745897aa3d6..468bc934d848 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -511,7 +511,7 @@ bool ath9k_htc_csa_is_finished(struct ath9k_htc_priv *priv)
 	struct ieee80211_vif *vif;
 
 	vif = priv->csa_vif;
-	if (!vif || !vif->csa_active)
+	if (!vif || !vif->bss_conf.csa_active)
 		return false;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(vif))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 9b194cb8d65e..ed2a0678ccb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -106,7 +106,7 @@ iwl_get_coex_type(struct iwl_mvm *mvm, const struct ieee80211_vif *vif)
 
 	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 
 	if (!chanctx_conf ||
 	     chanctx_conf->def.chan->band != NL80211_BAND_2GHZ) {
@@ -283,7 +283,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		return;
 	}
 
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 
 	/* If channel context is invalid or not on 2.4GHz .. */
 	if ((!chanctx_conf ||
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 61f9136a333d..8edc8646a23a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -731,7 +731,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	rcu_read_lock();
-	ctx = rcu_dereference(vif->chanctx_conf);
+	ctx = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (WARN_ON(!ctx)) {
 		rcu_read_unlock();
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 7d9faeffd154..78d8b37eb71a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -234,7 +234,7 @@ static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
 	}
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		pos += scnprintf(buf+pos, bufsz-pos,
 				 "idle rx chains %d, active rx chains: %d\n",
@@ -597,7 +597,7 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 	mutex_lock(&mvm->mutex);
 	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	/* make sure the channel context is assigned */
 	if (!chanctx_conf) {
 		rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 9729680476fd..18663af584d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -398,7 +398,7 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	}
 
 	rcu_read_lock();
-	pctx = rcu_dereference(vif->chanctx_conf);
+	pctx = rcu_dereference(vif->bss_conf.chanctx_conf);
 	/* Copy the ctx to unlock the rcu and send the phy ctxt. We don't care
 	 * about changes in the ctx after releasing the lock because the driver
 	 * is still protected by the mutex. */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 56fa20596f16..7756ac0faf3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -481,7 +481,7 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 		eth_broadcast_addr(cmd->bssid_addr);
 
 	rcu_read_lock();
-	chanctx = rcu_dereference(vif->chanctx_conf);
+	chanctx = rcu_dereference(vif->bss_conf.chanctx_conf);
 	iwl_mvm_ack_rates(mvm, vif, chanctx ? chanctx->def.chan->band
 					    : NL80211_BAND_2GHZ,
 			  &cck_ack_rates, &ofdm_ack_rates);
@@ -934,7 +934,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 	/* Enable FILS on PSC channels only */
 	rcu_read_lock();
-	ctx = rcu_dereference(vif->chanctx_conf);
+	ctx = rcu_dereference(vif->bss_conf.chanctx_conf);
 	channel = ieee80211_frequency_to_channel(ctx->def.chan->center_freq);
 	WARN_ON(channel == 0);
 	if (cfg80211_channel_is_psc(ctx->def.chan) &&
@@ -1335,7 +1335,7 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 
 	csa_vif = rcu_dereference_protected(mvm->csa_vif,
 					    lockdep_is_held(&mvm->mutex));
-	if (unlikely(csa_vif && csa_vif->csa_active))
+	if (unlikely(csa_vif && csa_vif->bss_conf.csa_active))
 		iwl_mvm_csa_count_down(mvm, csa_vif, mvm->ap_last_beacon_gp2,
 				       (status == TX_STATUS_SUCCESS));
 
@@ -1558,7 +1558,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 		csa_vif = rcu_dereference(mvm->csa_vif);
-		if (WARN_ON(!csa_vif || !csa_vif->csa_active ||
+		if (WARN_ON(!csa_vif || !csa_vif->bss_conf.csa_active ||
 			    csa_vif != vif))
 			goto out_unlock;
 
@@ -1587,7 +1587,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 		 */
 		if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 					    CHANNEL_SWITCH_ERROR_NOTIF,
-					    0) && !vif->csa_active) {
+					    0) && !vif->bss_conf.csa_active) {
 			IWL_DEBUG_INFO(mvm, "Channel Switch was canceled\n");
 			iwl_mvm_cancel_channel_switch(mvm, vif, mac_id);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb9bd2165355..c5626ff83805 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1768,7 +1768,7 @@ static int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm,
 static void iwl_mvm_mu_mimo_iface_iterator(void *_data, u8 *mac,
 					   struct ieee80211_vif *vif)
 {
-	if (vif->mu_mimo_owner) {
+	if (vif->bss_conf.mu_mimo_owner) {
 		struct iwl_mu_group_mgmt_notif *notif = _data;
 
 		/*
@@ -1965,7 +1965,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return;
@@ -2337,7 +2337,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		 * However, on HW restart we should restore this data.
 		 */
 		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		    (changes & BSS_CHANGED_MU_GROUPS) && vif->mu_mimo_owner) {
+		    (changes & BSS_CHANGED_MU_GROUPS) && vif->bss_conf.mu_mimo_owner) {
 			ret = iwl_mvm_update_mu_groups(mvm, vif);
 			if (ret)
 				IWL_ERR(mvm,
@@ -4004,7 +4004,7 @@ static void iwl_mvm_ftm_responder_chanctx_iter(void *_data, u8 *mac,
 {
 	struct iwl_mvm_ftm_responder_iter_data *data = _data;
 
-	if (rcu_access_pointer(vif->chanctx_conf) == data->ctx &&
+	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) == data->ctx &&
 	    vif->type == NL80211_IFTYPE_AP && vif->bss_conf.ftmr_params)
 		data->responder = true;
 }
@@ -4631,7 +4631,7 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 		csa_vif =
 			rcu_dereference_protected(mvm->csa_vif,
 						  lockdep_is_held(&mvm->mutex));
-		if (WARN_ONCE(csa_vif && csa_vif->csa_active,
+		if (WARN_ONCE(csa_vif && csa_vif->bss_conf.csa_active,
 			      "Another CSA is already in progress")) {
 			ret = -EBUSY;
 			goto out_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index b9bd81242b21..afdf3bb523e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -283,7 +283,7 @@ static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
 	bool radar_detect = false;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	WARN_ON(!chanctx_conf);
 	if (chanctx_conf) {
 		chan = chanctx_conf->def.chan;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 974eeecc9153..303975f9e2b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1980,7 +1980,7 @@ static bool rs_tpc_perform(struct iwl_mvm *mvm,
 #endif
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf))
 		band = NUM_NL80211_BANDS;
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index bf04326e35ff..d2ebf31bf534 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -380,7 +380,7 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 			   type == TDLS_MOVE_CH) {
 			/* we need to return to base channel */
 			struct ieee80211_chanctx_conf *chanctx =
-					rcu_dereference(vif->chanctx_conf);
+					rcu_dereference(vif->bss_conf.chanctx_conf);
 
 			if (WARN_ON_ONCE(!chanctx)) {
 				rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 6edf2b79db43..b8c2fe639220 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -123,7 +123,7 @@ static void iwl_mvm_csa_noa_start(struct iwl_mvm *mvm)
 	rcu_read_lock();
 
 	csa_vif = rcu_dereference(mvm->csa_vif);
-	if (!csa_vif || !csa_vif->csa_active)
+	if (!csa_vif || !csa_vif->bss_conf.csa_active)
 		goto out_unlock;
 
 	IWL_DEBUG_TE(mvm, "CSA NOA started\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 8125bb76f59e..f9e08b339e0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1959,7 +1959,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 
 		if (mvmsta->vif)
 			chanctx_conf =
-				rcu_dereference(mvmsta->vif->chanctx_conf);
+				rcu_dereference(mvmsta->vif->bss_conf.chanctx_conf);
 
 		if (WARN_ON_ONCE(!chanctx_conf))
 			goto out;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 2f746eb64507..53333e6ebdc2 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -889,7 +889,7 @@ static void hwsim_send_ps_poll(void *dat, u8 *mac, struct ieee80211_vif *vif)
 
 	rcu_read_lock();
 	mac80211_hwsim_tx_frame(data->hw, skb,
-				rcu_dereference(vif->chanctx_conf)->def.chan);
+				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan);
 	rcu_read_unlock();
 }
 
@@ -922,7 +922,7 @@ static void hwsim_send_nullfunc(struct mac80211_hwsim_data *data, u8 *mac,
 
 	rcu_read_lock();
 	mac80211_hwsim_tx_frame(data->hw, skb,
-				rcu_dereference(vif->chanctx_conf)->def.chan);
+				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan);
 	rcu_read_unlock();
 }
 
@@ -1465,11 +1465,11 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 {
 	struct tx_iter_data *data = _data;
 
-	if (!vif->chanctx_conf)
+	if (!vif->bss_conf.chanctx_conf)
 		return;
 
 	if (!hwsim_chans_compat(data->channel,
-				rcu_dereference(vif->chanctx_conf)->def.chan))
+				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan))
 		return;
 
 	data->receive = true;
@@ -1687,7 +1687,11 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	} else if (txi->hw_queue == 4) {
 		channel = data->tmp_chan;
 	} else {
-		chanctx_conf = rcu_dereference(txi->control.vif->chanctx_conf);
+		struct ieee80211_bss_conf *bss_conf;
+
+		bss_conf = &txi->control.vif->bss_conf;
+
+		chanctx_conf = rcu_dereference(bss_conf->chanctx_conf);
 		if (chanctx_conf) {
 			channel = chanctx_conf->def.chan;
 			confbw = chanctx_conf->def.width;
@@ -1936,14 +1940,14 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	}
 
 	mac80211_hwsim_tx_frame(hw, skb,
-				rcu_dereference(vif->chanctx_conf)->def.chan);
+				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan);
 
 	while ((skb = ieee80211_get_buffered_bc(hw, vif)) != NULL) {
 		mac80211_hwsim_tx_frame(hw, skb,
-				rcu_dereference(vif->chanctx_conf)->def.chan);
+				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan);
 	}
 
-	if (vif->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
+	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
 		ieee80211_csa_finish(vif);
 }
 
@@ -2205,7 +2209,7 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 		struct ieee80211_chanctx_conf *chanctx_conf;
 
 		rcu_read_lock();
-		chanctx_conf = rcu_dereference(vif->chanctx_conf);
+		chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 
 		if (!WARN_ON(!chanctx_conf))
 			confbw = chanctx_conf->def.width;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 18b5de55334c..5f75a8945a6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1459,7 +1459,7 @@ EXPORT_SYMBOL_GPL(mt76_get_sar_power);
 static void
 __mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
+	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
 		ieee80211_csa_finish(vif);
 }
 
@@ -1481,7 +1481,7 @@ __mt76_csa_check(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt76_dev *dev = priv;
 
-	if (!vif->csa_active)
+	if (!vif->bss_conf.csa_active)
 		return;
 
 	dev->csa_complete |= ieee80211_beacon_cntdwn_is_complete(vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 97e2a85cb728..8fb6c9d735dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -363,7 +363,7 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->csa_active)
+	if (vif->bss_conf.csa_active)
 		ieee80211_csa_finish(vif);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b7e2b365356c..1b3d6634a72e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -322,7 +322,7 @@ int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (vif->csa_active)
+	if (vif->bss_conf.csa_active)
 		ieee80211_csa_finish(vif);
 }
 
@@ -409,7 +409,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 static void
 mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (!vif->color_change_active)
+	if (!vif->bss_conf.color_change_active)
 		return;
 
 	ieee80211_color_change_finish(vif);
@@ -1818,7 +1818,7 @@ mt7915_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
 	if (!offs->cntdwn_counter_offs[0])
 		return;
 
-	sub_tag = vif->csa_active ? BSS_INFO_BCN_CSA : BSS_INFO_BCN_BCC;
+	sub_tag = vif->bss_conf.csa_active ? BSS_INFO_BCN_CSA : BSS_INFO_BCN_BCC;
 	tlv = mt7915_mcu_add_nested_subtlv(rskb, sub_tag, sizeof(*info),
 					   &bcn->sub_ntlv, &bcn->len);
 	info = (struct bss_info_bcn_cntdwn *)tlv;
@@ -1903,9 +1903,9 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (offs->cntdwn_counter_offs[0]) {
 		u16 offset = offs->cntdwn_counter_offs[0];
 
-		if (vif->csa_active)
+		if (vif->bss_conf.csa_active)
 			cont->csa_ofs = cpu_to_le16(offset - 4);
-		if (vif->color_change_active)
+		if (vif->bss_conf.color_change_active)
 			cont->bcc_ofs = cpu_to_le16(offset - 3);
 	}
 
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 6959efa4bfa9..21a9e3b0cbac 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4675,7 +4675,7 @@ static void wlcore_op_change_chanctx(struct ieee80211_hw *hw,
 		struct ieee80211_vif *vif = wl12xx_wlvif_to_vif(wlvif);
 
 		rcu_read_lock();
-		if (rcu_access_pointer(vif->chanctx_conf) != ctx) {
+		if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != ctx) {
 			rcu_read_unlock();
 			continue;
 		}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5c9e97eca739..e3ded46f70ac 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -636,6 +636,19 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @csa_active: marks whether a channel switch is going on. Internally it is
+ *	write-protected by sdata_lock and local->mtx so holding either is fine
+ *	for read access.
+ * @mu_mimo_owner: indicates interface owns MU-MIMO capability
+ * @chanctx_conf: The channel context this interface is assigned to, or %NULL
+ *	when it is not assigned. This pointer is RCU-protected due to the TX
+ *	path needing to access it; even though the netdev carrier will always
+ *	be off when it is %NULL there can still be races and packets could be
+ *	processed after it switches back to %NULL.
+ * @color_change_active: marks whether a color change is ongoing. Internally it is
+ *	write-protected by sdata_lock and local->mtx so holding either is fine
+ *	for read access.
+ * @color_change_color: the bss color that will be used after the change.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -711,6 +724,13 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+
+	bool csa_active;
+	bool mu_mimo_owner;
+	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
+
+	bool color_change_active;
+	u8 color_change_color;
 };
 
 /**
@@ -1713,10 +1733,6 @@ enum ieee80211_offload_flags {
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
- * @csa_active: marks whether a channel switch is going on. Internally it is
- *	write-protected by sdata_lock and local->mtx so holding either is fine
- *	for read access.
- * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @driver_flags: flags/capabilities the driver has for this interface,
  *	these need to be set (or cleared) when the interface is added
  *	or, if supported by the driver, the interface type is changed
@@ -1728,11 +1744,6 @@ enum ieee80211_offload_flags {
  *	restrictions.
  * @hw_queue: hardware queue for each AC
  * @cab_queue: content-after-beacon (DTIM beacon really) queue, AP mode only
- * @chanctx_conf: The channel context this interface is assigned to, or %NULL
- *	when it is not assigned. This pointer is RCU-protected due to the TX
- *	path needing to access it; even though the netdev carrier will always
- *	be off when it is %NULL there can still be races and packets could be
- *	processed after it switches back to %NULL.
  * @debugfs_dir: debugfs dentry, can be used by drivers to create own per
  *	interface debug files. Note that it will be NULL for the virtual
  *	monitor interface (if that is requested.)
@@ -1747,10 +1758,6 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
- * @color_change_active: marks whether a color change is ongoing. Internally it is
- *	write-protected by sdata_lock and local->mtx so holding either is fine
- *	for read access.
- * @color_change_color: the bss color that will be used after the change.
  * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
  */
 struct ieee80211_vif {
@@ -1758,16 +1765,12 @@ struct ieee80211_vif {
 	struct ieee80211_bss_conf bss_conf;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
-	bool csa_active;
-	bool mu_mimo_owner;
 
 	u8 cab_queue;
 	u8 hw_queue[IEEE80211_NUM_ACS];
 
 	struct ieee80211_txq *txq;
 
-	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
-
 	u32 driver_flags;
 	u32 offload_flags;
 
@@ -1780,9 +1783,6 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
-	bool color_change_active;
-	u8 color_change_color;
-
 	struct ieee80211_vif *mbssid_tx_vif;
 
 	/* must be last */
diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 4bab1683652d..0190ff21e002 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -637,7 +637,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 
 	len += 38; /* Ethernet header length */
 
-	conf = rcu_dereference(vif->chanctx_conf);
+	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (conf) {
 		band = conf->def.chan->band;
 		shift = ieee80211_chandef_get_shift(&conf->def);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c8499392ee4a..5915772713e1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -53,7 +53,7 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 				params->vht_mumimo_follow_addr);
 	}
 
-	sdata->vif.mu_mimo_owner = mu_mimo_groups || mu_mimo_follow;
+	sdata->vif.bss_conf.mu_mimo_owner = mu_mimo_groups || mu_mimo_follow;
 }
 
 static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
@@ -1308,7 +1308,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	/* don't allow changing the beacon while a countdown is in place - offset
 	 * of channel switch counter may change
 	 */
-	if (sdata->vif.csa_active || sdata->vif.color_change_active)
+	if (sdata->vif.bss_conf.csa_active || sdata->vif.bss_conf.color_change_active)
 		return -EBUSY;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1366,7 +1366,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
@@ -3065,7 +3065,7 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 	 * to send something, and if we're an AP we have to be able to do
 	 * so at a basic rate so that all clients can receive it.
 	 */
-	if (rcu_access_pointer(sdata->vif.chanctx_conf) &&
+	if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) &&
 	    sdata->vif.bss_conf.chandef.chan) {
 		u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 		enum nl80211_band band = sdata->vif.bss_conf.chandef.chan->band;
@@ -3372,7 +3372,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 					&sdata->csa_chandef))
 		return -EINVAL;
 
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 
 	err = ieee80211_set_after_csa_beacon(sdata, &changed);
 	if (err)
@@ -3416,7 +3416,7 @@ void ieee80211_csa_finalize_work(struct work_struct *work)
 	mutex_lock(&local->chanctx_mtx);
 
 	/* AP might have been stopped while waiting for the lock. */
-	if (!sdata->vif.csa_active)
+	if (!sdata->vif.bss_conf.csa_active)
 		goto unlock;
 
 	if (!ieee80211_sdata_running(sdata))
@@ -3568,7 +3568,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 {
-	sdata->vif.color_change_active = false;
+	sdata->vif.bss_conf.color_change_active = false;
 
 	ieee80211_free_next_beacon(sdata);
 
@@ -3601,11 +3601,11 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		return -EINVAL;
 
 	/* don't allow another channel switch if one is already active. */
-	if (sdata->vif.csa_active)
+	if (sdata->vif.bss_conf.csa_active)
 		return -EBUSY;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		err = -EBUSY;
@@ -3644,7 +3644,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	/* if there is a color change in progress, abort it */
-	if (sdata->vif.color_change_active)
+	if (sdata->vif.bss_conf.color_change_active)
 		ieee80211_color_change_abort(sdata);
 
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
@@ -3655,7 +3655,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata->csa_chandef = params->chandef;
 	sdata->csa_block_tx = params->block_tx;
-	sdata->vif.csa_active = true;
+	sdata->vif.bss_conf.csa_active = true;
 
 	if (sdata->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
@@ -3824,7 +3824,7 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
@@ -3907,7 +3907,7 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	int ret = -ENODATA;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf) {
 		*chandef = sdata->vif.bss_conf.chandef;
 		ret = 0;
@@ -4403,7 +4403,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 	sdata_assert_lock(sdata);
 	lockdep_assert_held(&local->mtx);
 
-	sdata->vif.color_change_active = false;
+	sdata->vif.bss_conf.color_change_active = false;
 
 	err = ieee80211_set_after_color_change_beacon(sdata, &changed);
 	if (err) {
@@ -4412,7 +4412,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 	}
 
 	ieee80211_color_change_bss_config_notify(sdata,
-						 sdata->vif.color_change_color,
+						 sdata->vif.bss_conf.color_change_color,
 						 1, changed);
 	cfg80211_color_change_notify(sdata->dev);
 
@@ -4430,7 +4430,7 @@ void ieee80211_color_change_finalize_work(struct work_struct *work)
 	mutex_lock(&local->mtx);
 
 	/* AP might have been stopped while waiting for the lock. */
-	if (!sdata->vif.color_change_active)
+	if (!sdata->vif.bss_conf.color_change_active)
 		goto unlock;
 
 	if (!ieee80211_sdata_running(sdata))
@@ -4458,7 +4458,7 @@ ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
-	if (sdata->vif.color_change_active || sdata->vif.csa_active)
+	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active)
 		return;
 
 	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap);
@@ -4484,7 +4484,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	/* don't allow another color change if one is already active or if csa
 	 * is active
 	 */
-	if (sdata->vif.color_change_active || sdata->vif.csa_active) {
+	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active) {
 		err = -EBUSY;
 		goto out;
 	}
@@ -4493,8 +4493,8 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	sdata->vif.color_change_active = true;
-	sdata->vif.color_change_color = params->color;
+	sdata->vif.bss_conf.color_change_active = true;
+	sdata->vif.bss_conf.color_change_color = params->color;
 
 	cfg80211_color_change_started_notify(sdata->dev, params->count);
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e3452445b363..8bcdddaf066d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -72,7 +72,7 @@ ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local __maybe_unused = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf)
 		return NULL;
@@ -260,7 +260,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		if (rcu_access_pointer(sdata->vif.chanctx_conf) != conf)
+		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
 			continue;
 
 		switch (vif->type) {
@@ -298,7 +298,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
-	if (sdata && rcu_access_pointer(sdata->vif.chanctx_conf) == conf)
+	if (sdata && rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == conf)
 		max_bw = max(max_bw, conf->def.width);
 
 	rcu_read_unlock();
@@ -368,7 +368,7 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sta->sdata))
 			continue;
 
-		if (rcu_access_pointer(sta->sdata->vif.chanctx_conf) !=
+		if (rcu_access_pointer(sta->sdata->vif.bss_conf.chanctx_conf) !=
 		    &ctx->conf)
 			continue;
 
@@ -533,7 +533,7 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(sdata))
 			continue;
-		if (rcu_access_pointer(sdata->vif.chanctx_conf) != conf)
+		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
 			continue;
 		if (!sdata->radar_required)
 			continue;
@@ -689,7 +689,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
-		if (rcu_access_pointer(sdata->vif.chanctx_conf) != conf)
+		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
 			continue;
 		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
@@ -759,7 +759,7 @@ static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
 		return -ENOTSUPP;
 
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 
 	if (conf) {
@@ -781,7 +781,7 @@ static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
 	}
 
 out:
-	rcu_assign_pointer(sdata->vif.chanctx_conf, conf);
+	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, conf);
 
 	sdata->vif.bss_conf.idle = !conf;
 
@@ -825,7 +825,7 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		if (rcu_access_pointer(sdata->vif.chanctx_conf) !=
+		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) !=
 						&chanctx->conf)
 			continue;
 
@@ -874,7 +874,7 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 	/* Disable SMPS for the monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.chanctx_conf) == &chanctx->conf)
+	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &chanctx->conf)
 		rx_chains_dynamic = rx_chains_static = local->rx_chains;
 
 	rcu_read_unlock();
@@ -917,7 +917,7 @@ __ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 	 * channel context pointer for a while, possibly pointing
 	 * to a channel context that has already been freed.
 	 */
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	WARN_ON(!conf);
 
@@ -925,7 +925,7 @@ __ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 		conf = NULL;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-		rcu_assign_pointer(vlan->vif.chanctx_conf, conf);
+		rcu_assign_pointer(vlan->vif.bss_conf.chanctx_conf, conf);
 }
 
 void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
@@ -1173,7 +1173,7 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	}
 
 	list_move(&sdata->assigned_chanctx_list, &new_ctx->assigned_vifs);
-	rcu_assign_pointer(sdata->vif.chanctx_conf, &new_ctx->conf);
+	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, &new_ctx->conf);
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
 		__ieee80211_vif_copy_chanctx_to_vlans(sdata, false);
@@ -1515,7 +1515,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			if (!ieee80211_vif_has_in_place_reservation(sdata))
 				continue;
 
-			rcu_assign_pointer(sdata->vif.chanctx_conf, &ctx->conf);
+			rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf,
+					   &ctx->conf);
 
 			if (sdata->vif.type == NL80211_IFTYPE_AP)
 				__ieee80211_vif_copy_chanctx_to_vlans(sdata,
@@ -1634,7 +1635,7 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf)
 		return;
@@ -1812,7 +1813,7 @@ int ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		ret = -EINVAL;
@@ -1882,9 +1883,9 @@ void ieee80211_vif_vlan_copy_chanctx(struct ieee80211_sub_if_data *sdata)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	conf = rcu_dereference_protected(ap->vif.chanctx_conf,
+	conf = rcu_dereference_protected(ap->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
-	rcu_assign_pointer(sdata->vif.chanctx_conf, conf);
+	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, conf);
 	mutex_unlock(&local->chanctx_mtx);
 }
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 4e2fc1a08681..fd2882348211 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -165,7 +165,7 @@ static inline void drv_bss_info_changed(struct ieee80211_local *local,
 	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
 			 sdata->vif.type == NL80211_IFTYPE_NAN ||
 			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
-			  !sdata->vif.mu_mimo_owner &&
+			  !sdata->vif.bss_conf.mu_mimo_owner &&
 			  !(changed & BSS_CHANGED_TXPOWER))))
 		return;
 
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 31cd3c1ac07f..e7a41db9e659 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -150,7 +150,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	survey.filled = 0;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		channel = chanctx_conf->def.chan;
 	else
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 14c04fd48b7a..aebae1f4d288 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -622,7 +622,7 @@ ieee80211_ibss_add_sta(struct ieee80211_sub_if_data *sdata, const u8 *bssid,
 	}
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON_ONCE(!chanctx_conf))
 		return NULL;
 	band = chanctx_conf->def.chan->band;
@@ -923,7 +923,7 @@ ieee80211_rx_mgmt_spectrum_mgmt(struct ieee80211_sub_if_data *sdata,
 	if (len < required_len)
 		return;
 
-	if (!sdata->vif.csa_active)
+	if (!sdata->vif.bss_conf.csa_active)
 		ieee80211_ibss_process_chanswitch(sdata, elems, false);
 }
 
@@ -1143,7 +1143,7 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 		goto put_bss;
 
 	/* process channel switch */
-	if (sdata->vif.csa_active ||
+	if (sdata->vif.bss_conf.csa_active ||
 	    ieee80211_ibss_process_chanswitch(sdata, elems, true))
 		goto put_bss;
 
@@ -1220,7 +1220,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON_ONCE(!chanctx_conf)) {
 		rcu_read_unlock();
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1cf331572de1..5a1347727b4a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1076,7 +1076,7 @@ ieee80211_vif_get_shift(struct ieee80211_vif *vif)
 	int shift = 0;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->chanctx_conf);
+	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		shift = ieee80211_chandef_get_shift(&chanctx_conf->def);
 	rcu_read_unlock();
@@ -1527,7 +1527,7 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
 	if (!chanctx_conf) {
 		rcu_read_unlock();
@@ -2224,7 +2224,7 @@ static inline void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		kfree_skb(skb);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fb8d102fca48..9e0e71ca8068 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -51,7 +51,7 @@ bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 	int power;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return false;
@@ -275,7 +275,7 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 			 * will not add another interface while any channel
 			 * switch is active.
 			 */
-			if (nsdata->vif.csa_active)
+			if (nsdata->vif.bss_conf.csa_active)
 				return -EBUSY;
 
 			/*
@@ -450,7 +450,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	cancel_work_sync(&sdata->recalc_smps);
 	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->u.mgd.csa_waiting_bcn = false;
 	if (sdata->csa_block_tx) {
@@ -502,7 +502,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		mutex_lock(&local->mtx);
 		list_del(&sdata->u.vlan.list);
 		mutex_unlock(&local->mtx);
-		RCU_INIT_POINTER(sdata->vif.chanctx_conf, NULL);
+		RCU_INIT_POINTER(sdata->vif.bss_conf.chanctx_conf, NULL);
 		/* see comment in the default case below */
 		ieee80211_free_keys(sdata, true);
 		/* no need to tell driver */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4f3e93c0819b..ebde131efcaa 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -147,7 +147,7 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (!rcu_access_pointer(sdata->vif.chanctx_conf))
+		if (!rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf))
 			continue;
 		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
@@ -284,7 +284,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 			 * Then we can have a race...
 			 */
 			cancel_work_sync(&sdata->u.mgd.csa_connection_drop_work);
-			if (sdata->vif.csa_active) {
+			if (sdata->vif.bss_conf.csa_active) {
 				sdata_lock(sdata);
 				ieee80211_sta_connection_lost(sdata,
 							      WLAN_REASON_UNSPECIFIED,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5275f4f32a78..dceb08f8bf7f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -399,7 +399,7 @@ static int mesh_add_ds_params_ie(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -455,7 +455,7 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	u8 *pos;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -527,7 +527,7 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	u8 *pos;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -820,7 +820,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 
 	sdata = container_of(ifmsh, struct ieee80211_sub_if_data, u.mesh);
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
@@ -1357,7 +1357,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 					      rx_status);
 
 		if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
-		    !sdata->vif.csa_active)
+		    !sdata->vif.bss_conf.csa_active)
 			ieee80211_mesh_process_chnswitch(sdata, elems, true);
 	}
 
@@ -1488,7 +1488,7 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 
 	ifmsh->pre_value = pre_value;
 
-	if (!sdata->vif.csa_active &&
+	if (!sdata->vif.bss_conf.csa_active &&
 	    !ieee80211_mesh_process_chnswitch(sdata, elems, false)) {
 		mcsa_dbg(sdata, "Failed to process CSA action frame");
 		goto free;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e0a9b7d63071..c526af66ff8d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -624,7 +624,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_sub_if_data *other;
 
 		list_for_each_entry_rcu(other, &local->interfaces, list) {
-			if (other->vif.mu_mimo_owner) {
+			if (other->vif.bss_conf.mu_mimo_owner) {
 				disable_mu_mimo = true;
 				break;
 			}
@@ -632,7 +632,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		if (disable_mu_mimo)
 			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 		else
-			sdata->vif.mu_mimo_owner = true;
+			sdata->vif.bss_conf.mu_mimo_owner = true;
 	}
 
 	mask = IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
@@ -664,7 +664,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	bool reg_cap = false;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!WARN_ON_ONCE(!chanctx_conf))
 		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
 						  &chanctx_conf->def,
@@ -705,7 +705,7 @@ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 	bool reg_cap = false;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!WARN_ON_ONCE(!chanctx_conf))
 		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
 						  &chanctx_conf->def,
@@ -766,7 +766,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	sdata_assert_lock(sdata);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -1229,7 +1229,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	if (!ifmgd->associated)
 		goto out;
 
-	if (!sdata->vif.csa_active)
+	if (!sdata->vif.bss_conf.csa_active)
 		goto out;
 
 	/*
@@ -1289,7 +1289,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 
 	sdata_assert_lock(sdata);
 
-	WARN_ON(!sdata->vif.csa_active);
+	WARN_ON(!sdata->vif.bss_conf.csa_active);
 
 	if (sdata->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
@@ -1297,7 +1297,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 		sdata->csa_block_tx = false;
 	}
 
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 	ifmgd->csa_waiting_bcn = false;
 	/*
 	 * If the CSA IE is still present on the beacon after the switch,
@@ -1361,7 +1361,7 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	sdata->csa_block_tx = false;
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 
 	mutex_unlock(&local->mtx);
 
@@ -1412,13 +1412,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (res < 0)
 		goto lock_and_drop_connection;
 
-	if (beacon && sdata->vif.csa_active && !ifmgd->csa_waiting_bcn) {
+	if (beacon && sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn) {
 		if (res)
 			ieee80211_sta_abort_chanswitch(sdata);
 		else
 			drv_channel_switch_rx_beacon(sdata, &ch_switch);
 		return;
-	} else if (sdata->vif.csa_active || res) {
+	} else if (sdata->vif.bss_conf.csa_active || res) {
 		/* disregard subsequent announcements if already processing */
 		return;
 	}
@@ -1471,7 +1471,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 
 	mutex_lock(&local->mtx);
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		sdata_info(sdata,
@@ -1504,7 +1504,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	}
 	mutex_unlock(&local->chanctx_mtx);
 
-	sdata->vif.csa_active = true;
+	sdata->vif.bss_conf.csa_active = true;
 	sdata->csa_chandef = csa_ie.chandef;
 	sdata->csa_block_tx = csa_ie.mode;
 	ifmgd->csa_ignored_same_chan = false;
@@ -1543,7 +1543,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	 * send a deauthentication frame. Those two fields will be
 	 * reset when the disconnection worker runs.
 	 */
-	sdata->vif.csa_active = true;
+	sdata->vif.bss_conf.csa_active = true;
 	sdata->csa_block_tx = csa_ie.mode;
 
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
@@ -2447,7 +2447,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.mu_group.position, 0,
 	       sizeof(sdata->vif.bss_conf.mu_group.position));
 	changed |= BSS_CHANGED_MU_GROUPS;
-	sdata->vif.mu_mimo_owner = false;
+	sdata->vif.bss_conf.mu_mimo_owner = false;
 
 	sdata->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
@@ -2482,7 +2482,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	mutex_lock(&local->mtx);
 	ieee80211_vif_release_channel(sdata);
 
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 	ifmgd->csa_waiting_bcn = false;
 	ifmgd->csa_ignored_same_chan = false;
 	if (sdata->csa_block_tx) {
@@ -2808,7 +2808,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 			       tx, frame_buf);
 	mutex_lock(&local->mtx);
-	sdata->vif.csa_active = false;
+	sdata->vif.bss_conf.csa_active = false;
 	ifmgd->csa_waiting_bcn = false;
 	if (sdata->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
@@ -2948,7 +2948,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		eth_zero_addr(sdata->u.mgd.bssid);
 		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
-		sdata->vif.mu_mimo_owner = false;
+		sdata->vif.bss_conf.mu_mimo_owner = false;
 
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_vif_release_channel(sdata);
@@ -4134,7 +4134,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return;
@@ -4803,7 +4803,7 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 		from_timer(sdata, t, u.mgd.bcn_mon_timer);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (sdata->vif.csa_active && !ifmgd->csa_waiting_bcn)
+	if (sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn)
 		return;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
@@ -4823,7 +4823,7 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	struct sta_info *sta;
 	unsigned long timeout;
 
-	if (sdata->vif.csa_active && !ifmgd->csa_waiting_bcn)
+	if (sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn)
 		return;
 
 	sta = sta_info_get(sdata, ifmgd->bssid);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index f97cb4c453d3..de8f5dd0fbaf 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -59,7 +59,7 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	ocb_dbg(sdata, "Adding new OCB station %pM\n", addr);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON_ONCE(!chanctx_conf)) {
 		rcu_read_unlock();
 		return;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index c5d2ab9df1e7..b62d382433f9 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -845,7 +845,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		struct ieee80211_chanctx_conf *chanctx_conf;
 
 		rcu_read_lock();
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
 		if (chanctx_conf) {
 			need_offchan = params->chan &&
@@ -876,7 +876,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	data = skb_put_data(skb, params->buf, params->len);
 
 	/* Update CSA counters */
-	if (sdata->vif.csa_active &&
+	if (sdata->vif.bss_conf.csa_active &&
 	    (sdata->vif.type == NL80211_IFTYPE_AP ||
 	     sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
 	     sdata->vif.type == NL80211_IFTYPE_ADHOC) &&
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index ae9700e0a1a5..887bcb09bada 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -43,7 +43,7 @@ void rate_control_rate_init(struct sta_info *sta)
 
 	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(sta->sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sta->sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return;
@@ -100,7 +100,7 @@ void rate_control_rate_update(struct ieee80211_local *local,
 	if (ref && ref->ops->rate_update) {
 		rcu_read_lock();
 
-		chanctx_conf = rcu_dereference(sta->sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sta->sdata->vif.bss_conf.chanctx_conf);
 		if (WARN_ON(!chanctx_conf)) {
 			rcu_read_unlock();
 			return;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a9f4e90ad893..9a179a18aafc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3167,7 +3167,7 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
 		return;
 
-	if (rx->sdata->vif.csa_active)
+	if (rx->sdata->vif.bss_conf.csa_active)
 		return;
 
 	baselen = mgmt->u.beacon.variable - rx->skb->data;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e04a0905e941..7eeb6919d2b7 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1467,7 +1467,7 @@ static void ieee80211_send_null_response(struct sta_info *sta, int tid,
 	skb->dev = sdata->dev;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		kfree_skb(skb);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 4e2d22e47429..1902bcffb21b 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1254,7 +1254,7 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (conf) {
 		width = conf->def.width;
@@ -1372,7 +1372,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 	switch (oper) {
 	case NL80211_TDLS_ENABLE_LINK:
-		if (sdata->vif.csa_active) {
+		if (sdata->vif.bss_conf.csa_active) {
 			tdls_dbg(sdata, "TDLS: disallow link during CSA\n");
 			ret = -EBUSY;
 			break;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 37fe72bb5ab0..e5edc6fd21c0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -57,7 +57,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 		return 0;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(tx->sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(tx->sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf) {
 		shift = ieee80211_chandef_get_shift(&chanctx_conf->def);
 		rate_flags = ieee80211_chandef_rate_flags(&chanctx_conf->def);
@@ -2345,12 +2345,12 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!chanctx_conf) {
 		tmp_sdata = rcu_dereference(local->monitor_sdata);
 		if (tmp_sdata)
 			chanctx_conf =
-				rcu_dereference(tmp_sdata->vif.chanctx_conf);
+				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
 	if (chanctx_conf)
@@ -2599,7 +2599,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		}
 		ap_sdata = container_of(sdata->bss, struct ieee80211_sub_if_data,
 					u.ap);
-		chanctx_conf = rcu_dereference(ap_sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(ap_sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2610,7 +2610,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		fallthrough;
 	case NL80211_IFTYPE_AP:
 		if (sdata->vif.type == NL80211_IFTYPE_AP)
-			chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+			chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2689,7 +2689,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 						skb->data + ETH_ALEN);
 
 		}
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2732,7 +2732,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			memcpy(hdr.addr3, skb->data, ETH_ALEN);
 			hdrlen = 24;
 		}
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2745,7 +2745,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
 		eth_broadcast_addr(hdr.addr3);
 		hdrlen = 24;
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2758,7 +2758,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
 		memcpy(hdr.addr3, sdata->u.ibss.bssid, ETH_ALEN);
 		hdrlen = 24;
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (!chanctx_conf) {
 			ret = -ENOTCONN;
 			goto free;
@@ -2981,7 +2981,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 		goto out;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		goto out;
@@ -4604,7 +4604,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 	sdata = vif_to_sdata(info->control.vif);
 
 	if (info->control.flags & IEEE80211_TX_INTCFL_NEED_TXPROCESSING) {
-		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 		if (unlikely(!chanctx_conf)) {
 			dev_kfree_skb(skb);
 			return true;
@@ -4808,7 +4808,7 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 
 	bcn_offsets = beacon->cntdwn_counter_offsets;
 	count = beacon->cntdwn_current_counter;
-	if (sdata->vif.csa_active)
+	if (sdata->vif.bss_conf.csa_active)
 		max_count = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
 
 	for (i = 0; i < max_count; ++i) {
@@ -5119,7 +5119,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	rcu_read_lock();
 
 	sdata = vif_to_sdata(vif);
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
 	if (!ieee80211_sdata_running(sdata) || !chanctx_conf)
 		goto out;
@@ -5536,7 +5536,7 @@ ieee80211_get_buffered_bc(struct ieee80211_hw *hw,
 	sdata = vif_to_sdata(vif);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 
 	if (!chanctx_conf)
 		goto out;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9e6c4dcef280..48d8f0aad69f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1566,7 +1566,7 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		center_freq = chanctx_conf->def.chan->center_freq;
 
@@ -1613,7 +1613,7 @@ void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 	memset(&qparam, 0, sizeof(qparam));
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	use_11b = (chanctx_conf &&
 		   chanctx_conf->def.chan->band == NL80211_BAND_2GHZ) &&
 		 !(sdata->flags & IEEE80211_SDATA_OPERATING_GMODE);
@@ -2264,7 +2264,7 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 		return;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (conf) {
 		ctx = container_of(conf, struct ieee80211_chanctx, conf);
@@ -2523,7 +2523,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			  BSS_CHANGED_TXPOWER |
 			  BSS_CHANGED_MCAST_RATE;
 
-		if (sdata->vif.mu_mimo_owner)
+		if (sdata->vif.bss_conf.mu_mimo_owner)
 			changed |= BSS_CHANGED_MU_GROUPS;
 
 		switch (sdata->vif.type) {
@@ -2806,8 +2806,8 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	chanctx_conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
-					lockdep_is_held(&local->chanctx_mtx));
+	chanctx_conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+						 lockdep_is_held(&local->chanctx_mtx));
 
 	/*
 	 * This function can be called from a work, thus it may be possible
@@ -2832,8 +2832,8 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	chanctx_conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
-					lockdep_is_held(&local->chanctx_mtx));
+	chanctx_conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+						 lockdep_is_held(&local->chanctx_mtx));
 
 	if (WARN_ON_ONCE(!chanctx_conf))
 		goto unlock;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index ff26e0c4787b..bb4685895f49 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -649,7 +649,7 @@ void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 
-	if (!sdata->vif.mu_mimo_owner)
+	if (!sdata->vif.bss_conf.mu_mimo_owner)
 		return;
 
 	if (!memcmp(mgmt->u.action.u.vht_group_notif.position,
@@ -673,7 +673,7 @@ void ieee80211_update_mu_groups(struct ieee80211_vif *vif,
 {
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 
-	if (WARN_ON_ONCE(!vif->mu_mimo_owner))
+	if (WARN_ON_ONCE(!vif->bss_conf.mu_mimo_owner))
 		return;
 
 	memcpy(bss_conf->mu_group.membership, membership, WLAN_MEMBERSHIP_LEN);
-- 
2.36.1

