Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCEE43773F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhJVMlz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 08:41:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52910 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232495AbhJVMly (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 08:41:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634906377; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3C40W8P7lgashJSjwBkbZqBPS1J6Tm+NF6xKlFLB9ks=; b=S15u0+M87N9b3WPivSHoBrRVqQF9AZxssgA3UnAdjwnDgpHffPr3Pdj6+ZVqAhmXh4kdDBoP
 cdNKNb1o+W/tZK+rSaxNEgikVmzQLosA8Ws1E7n2LlGnAqw6l8iNYYHq1HBy71B+NT5ngwBP
 vCD+vlU+5OMi9jUH6mDu+zwka20=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6172b0f414914866fa34b9f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Oct 2021 12:39:16
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1595C43619; Fri, 22 Oct 2021 12:39:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1321DC43460;
        Fri, 22 Oct 2021 12:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1321DC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH v3 1/3] nl80211: Extended ROC support for 40-80 MHz bandwidth
Date:   Fri, 22 Oct 2021 18:07:05 +0530
Message-Id: <1634906227-22028-2-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace struct ieee80211_channel with struct cfg80211_chan_def
in remain on channel apis, because the channel width information is needed
to handle centre frequency of 80MHz, and it is available in
cfg80211_chan_def.

Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c              |  3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  3 +-
 drivers/net/wireless/ath/ath9k/main.c              |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  3 +-
 drivers/net/wireless/mac80211_hwsim.c              |  3 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |  3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  3 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |  3 +-
 drivers/net/wireless/ti/wlcore/main.c              |  3 +-
 include/net/cfg80211.h                             |  2 +-
 include/net/mac80211.h                             |  2 +-
 net/mac80211/driver-ops.h                          |  6 +--
 net/mac80211/ieee80211_i.h                         |  4 +-
 net/mac80211/offchannel.c                          | 56 ++++++++++++++--------
 net/mac80211/trace.h                               | 11 +++--
 net/wireless/nl80211.c                             |  2 +-
 net/wireless/rdev-ops.h                            |  6 +--
 net/wireless/trace.h                               |  6 +--
 22 files changed, 82 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c272b29..e652e21 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7805,12 +7805,13 @@ static int ath10k_conf_tx(struct ieee80211_hw *hw,
 
 static int ath10k_remain_on_channel(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    struct ieee80211_channel *chan,
+				    struct cfg80211_chan_def *chandef,
 				    int duration,
 				    enum ieee80211_roc_type type)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_channel *chan = chandef->chan;
 	struct wmi_start_scan_arg arg;
 	int ret = 0;
 	u32 scan_time_msec;
diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index fefdc67..4a2c132 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3023,12 +3023,13 @@ static int ath6kl_change_station(struct wiphy *wiphy, struct net_device *dev,
 
 static int ath6kl_remain_on_channel(struct wiphy *wiphy,
 				    struct wireless_dev *wdev,
-				    struct ieee80211_channel *chan,
+				    struct cfg80211_chan_def *chandef,
 				    unsigned int duration,
 				    u64 *cookie)
 {
 	struct ath6kl_vif *vif = ath6kl_vif_from_wdev(wdev);
 	struct ath6kl *ar = ath6kl_priv(vif->ndev);
+	struct ieee80211_channel *chan = chandef->chan;
 	u32 id;
 
 	/* TODO: if already pending or ongoing remain-on-channel,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 1398315..8f0fc64 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2466,11 +2466,13 @@ static void ath9k_cancel_hw_scan(struct ieee80211_hw *hw,
 
 static int ath9k_remain_on_channel(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_channel *chan, int duration,
+				   struct cfg80211_chan_def *chandef,
+				   int duration,
 				   enum ieee80211_roc_type type)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	struct ieee80211_channel *chan = chandef->chan;
 	int ret = 0;
 
 	mutex_lock(&sc->mutex);
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 1ff2679..9ed172f 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1734,11 +1734,12 @@ static int wil_cfg80211_set_default_key(struct wiphy *wiphy,
 
 static int wil_remain_on_channel(struct wiphy *wiphy,
 				 struct wireless_dev *wdev,
-				 struct ieee80211_channel *chan,
+				 struct cfg80211_chan_def *chandef,
 				 unsigned int duration,
 				 u64 *cookie)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct ieee80211_channel *chan = chandef->chan;
 	int rc;
 
 	wil_dbg_misc(wil,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 9ac0d8c..e9cd84e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -972,10 +972,11 @@ brcmf_p2p_discover_listen(struct brcmf_p2p_info *p2p, u16 channel, u32 duration)
  * @cookie: cookie.
  */
 int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *channel,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct ieee80211_channel *channel = chandef->chan;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
 	s32 err;
 	u16 channel_nr;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index d2ecee5..1646e6e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -156,7 +156,7 @@ int brcmf_p2p_scan_prep(struct wiphy *wiphy,
 			struct cfg80211_scan_request *request,
 			struct brcmf_cfg80211_vif *vif);
 int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *channel,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie);
 int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 				     const struct brcmf_event_msg *e,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 70ebecb..09a775a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3792,7 +3792,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 
 static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
-		       struct ieee80211_channel *channel,
+		       struct cfg80211_chan_def *chandefcfg,
 		       int duration,
 		       enum ieee80211_roc_type type)
 {
@@ -3800,6 +3800,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct cfg80211_chan_def chandef;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	struct ieee80211_channel *channel = chandefcfg->chan;
 	bool band_change_removal;
 	int ret, i;
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ffa894f..9692b58 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2475,11 +2475,12 @@ static void hw_roc_done(struct work_struct *work)
 
 static int mac80211_hwsim_roc(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
-			      struct ieee80211_channel *chan,
+			      struct cfg80211_chan_def *chandef,
 			      int duration,
 			      enum ieee80211_roc_type type)
 {
 	struct mac80211_hwsim_data *hwsim = hw->priv;
+	struct ieee80211_channel *chan = chandef->chan;
 
 	mutex_lock(&hwsim->mutex);
 	if (WARN_ON(hwsim->tmp_chan || hwsim->hw_scan_request)) {
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 0961f4a..aee8338 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -292,10 +292,11 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 static int
 mwifiex_cfg80211_remain_on_channel(struct wiphy *wiphy,
 				   struct wireless_dev *wdev,
-				   struct ieee80211_channel *chan,
+				   struct cfg80211_chan_def *chandef,
 				   unsigned int duration, u64 *cookie)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
+	struct ieee80211_channel *chan = chandef->chan;
 	int ret;
 
 	if (!chan || !cookie) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index dada43d..e517268 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1128,11 +1128,12 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 static int mt7615_remain_on_channel(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
-				    struct ieee80211_channel *chan,
+				    struct cfg80211_chan_def *chandef,
 				    int duration,
 				    enum ieee80211_roc_type type)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	struct ieee80211_channel *chan = chandef->chan;
 	int err;
 
 	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 96973ec..75e097b 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1060,12 +1060,13 @@ static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
 
 static int remain_on_channel(struct wiphy *wiphy,
 			     struct wireless_dev *wdev,
-			     struct ieee80211_channel *chan,
+			     struct cfg80211_chan_def *chandef,
 			     unsigned int duration, u64 *cookie)
 {
 	int ret = 0;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
+	struct ieee80211_channel *chan = chandef->chan;
 	u64 id;
 
 	if (wdev->iftype == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index b66975f..0284676 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1788,11 +1788,12 @@ void rsi_roc_timeout(struct timer_list *t)
 }
 
 static int rsi_mac80211_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_channel *chan, int duration,
+			    struct cfg80211_chan_def *chandef, int duration,
 			    enum ieee80211_roc_type type)
 {
 	struct rsi_hw *adapter = (struct rsi_hw *)hw->priv;
 	struct rsi_common *common = (struct rsi_common *)adapter->priv;
+	struct ieee80211_channel *chan = chandef->chan;
 	int status = 0;
 
 	rsi_dbg(INFO_ZONE, "***** Remain on channel *****\n");
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 5669f17..48f2d42 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5640,13 +5640,14 @@ static void wlcore_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 static int wlcore_op_remain_on_channel(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
-				       struct ieee80211_channel *chan,
+				       struct cfg80211_chan_def *chandef,
 				       int duration,
 				       enum ieee80211_roc_type type)
 {
 	struct wl12xx_vif *wlvif = wl12xx_vif_to_data(vif);
 	struct wl1271 *wl = hw->priv;
 	int channel, active_roc, ret = 0;
+	struct ieee80211_channel *chan = chandef->chan;
 
 	channel = ieee80211_frequency_to_channel(chan->center_freq);
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd842..c0a3146 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4181,7 +4181,7 @@ struct cfg80211_ops {
 
 	int	(*remain_on_channel)(struct wiphy *wiphy,
 				     struct wireless_dev *wdev,
-				     struct ieee80211_channel *chan,
+				     struct cfg80211_chan_def *chandef,
 				     unsigned int duration,
 				     u64 *cookie);
 	int	(*cancel_remain_on_channel)(struct wiphy *wiphy,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af0fc13..13bbab7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4107,7 +4107,7 @@ struct ieee80211_ops {
 
 	int (*remain_on_channel)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_channel *chan,
+				 struct cfg80211_chan_def *chandef,
 				 int duration,
 				 enum ieee80211_roc_type type);
 	int (*cancel_remain_on_channel)(struct ieee80211_hw *hw,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index cd3731c..dff861c 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -675,7 +675,7 @@ static inline int drv_get_antenna(struct ieee80211_local *local,
 
 static inline int drv_remain_on_channel(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
-					struct ieee80211_channel *chan,
+					struct cfg80211_chan_def *chandef,
 					unsigned int duration,
 					enum ieee80211_roc_type type)
 {
@@ -683,9 +683,9 @@ static inline int drv_remain_on_channel(struct ieee80211_local *local,
 
 	might_sleep();
 
-	trace_drv_remain_on_channel(local, sdata, chan, duration, type);
+	trace_drv_remain_on_channel(local, sdata, chandef, duration, type);
 	ret = local->ops->remain_on_channel(&local->hw, &sdata->vif,
-					    chan, duration, type);
+					    chandef, duration, type);
 	trace_drv_return_int(local, ret);
 
 	return ret;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 159af6c..8c2a8a8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -337,7 +337,7 @@ struct ieee80211_roc_work {
 
 	struct ieee80211_sub_if_data *sdata;
 
-	struct ieee80211_channel *chan;
+	struct cfg80211_chan_def chandef;
 
 	bool started, abort, hw_begun, notified;
 	bool on_channel;
@@ -1886,7 +1886,7 @@ void ieee80211_start_next_roc(struct ieee80211_local *local);
 void ieee80211_roc_purge(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata);
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *chan,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie);
 int ieee80211_cancel_remain_on_channel(struct wiphy *wiphy,
 				       struct wireless_dev *wdev, u64 cookie);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 853c9a3..4e1d010 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -178,12 +178,13 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
 
 	if (!roc->mgmt_tx_cookie)
 		cfg80211_remain_on_channel_expired(&roc->sdata->wdev,
-						   roc->cookie, roc->chan,
+						   roc->cookie,
+						   roc->chandef.chan,
 						   GFP_KERNEL);
 	else
 		cfg80211_tx_mgmt_expired(&roc->sdata->wdev,
 					 roc->mgmt_tx_cookie,
-					 roc->chan, GFP_KERNEL);
+					 roc->chandef.chan, GFP_KERNEL);
 
 	list_del(&roc->list);
 	kfree(roc);
@@ -211,6 +212,7 @@ static unsigned long ieee80211_end_finished_rocs(struct ieee80211_local *local,
 		 * ROC session before the actual requested time. In such a case
 		 * end the ROC session (disregarding the remaining time).
 		 */
+
 		if (roc->abort || roc->hw_begun || remaining <= 0)
 			ieee80211_roc_notify_destroy(roc);
 		else
@@ -235,21 +237,24 @@ static bool ieee80211_recalc_sw_work(struct ieee80211_local *local,
 static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 					 unsigned long start_time)
 {
+	enum nl80211_band band;
+
 	if (WARN_ON(roc->notified))
 		return;
 
+	band = roc->chandef.chan->band;
 	roc->start_time = start_time;
 	roc->started = true;
 
 	if (roc->mgmt_tx_cookie) {
 		if (!WARN_ON(!roc->frame)) {
 			ieee80211_tx_skb_tid_band(roc->sdata, roc->frame, 7,
-						  roc->chan->band);
+						  band);
 			roc->frame = NULL;
 		}
 	} else {
 		cfg80211_ready_on_channel(&roc->sdata->wdev, roc->cookie,
-					  roc->chan, roc->req_duration,
+					  roc->chandef.chan, roc->req_duration,
 					  GFP_KERNEL);
 	}
 
@@ -311,7 +316,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 	list_for_each_entry(tmp, &local->roc_list, list) {
 		if (tmp == roc)
 			continue;
-		if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+		if (tmp->sdata != roc->sdata || tmp->chandef.chan != roc->chandef.chan)
 			break;
 		max_dur = max(tmp->duration, max_dur);
 		min_dur = min(tmp->duration, min_dur);
@@ -319,7 +324,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 	}
 
 	if (local->ops->remain_on_channel) {
-		int ret = drv_remain_on_channel(local, roc->sdata, roc->chan,
+		int ret = drv_remain_on_channel(local, roc->sdata,
+						&roc->chandef,
 						max_dur, type);
 
 		if (ret) {
@@ -331,7 +337,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 			 */
 			list_for_each_entry(tmp, &local->roc_list, list) {
 				if (tmp->sdata != roc->sdata ||
-				    tmp->chan != roc->chan)
+				    tmp->chandef.chan != roc->chandef.chan)
 					break;
 				tmp->started = true;
 				tmp->abort = true;
@@ -342,7 +348,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 
 		/* we'll notify about the start once the HW calls back */
 		list_for_each_entry(tmp, &local->roc_list, list) {
-			if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+			if (tmp->sdata != roc->sdata ||
+			    tmp->chandef.chan != roc->chandef.chan)
 				break;
 			tmp->started = true;
 		}
@@ -352,7 +359,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		 * treat it as though the ROC operation started properly, so
 		 * other ROC operations won't interfere with this one.
 		 */
-		roc->on_channel = roc->chan == local->_oper_chandef.chan &&
+		roc->on_channel = roc->chandef.chan == local->_oper_chandef.chan &&
 				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_5 &&
 				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_10;
 
@@ -362,7 +369,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		if (!roc->on_channel) {
 			ieee80211_offchannel_stop_vifs(local);
 
-			local->tmp_channel = roc->chan;
+			local->tmp_channel = roc->chandef.chan;
 			ieee80211_hw_config(local, 0);
 		}
 
@@ -371,7 +378,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 
 		/* tell userspace or send frame(s) */
 		list_for_each_entry(tmp, &local->roc_list, list) {
-			if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+			if (tmp->sdata != roc->sdata ||
+			    tmp->chandef.chan != roc->chandef.chan)
 				break;
 
 			tmp->on_channel = roc->on_channel;
@@ -526,12 +534,13 @@ ieee80211_coalesce_hw_started_roc(struct ieee80211_local *local,
 
 static int ieee80211_start_roc_work(struct ieee80211_local *local,
 				    struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_channel *channel,
+				    struct cfg80211_chan_def *chandef,
 				    unsigned int duration, u64 *cookie,
 				    struct sk_buff *txskb,
 				    enum ieee80211_roc_type type)
 {
 	struct ieee80211_roc_work *roc, *tmp;
+	struct ieee80211_channel *channel = chandef->chan;
 	bool queued = false, combine_started = true;
 	int ret;
 
@@ -560,7 +569,10 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 	if (!duration)
 		duration = 10;
 
-	roc->chan = channel;
+	roc->chandef.chan = chandef->chan;
+	roc->chandef.width = chandef->width;
+	roc->chandef.center_freq1 = chandef->center_freq1;
+	roc->chandef.center_freq2 = chandef->center_freq2;
 	roc->duration = duration;
 	roc->req_duration = duration;
 	roc->frame = txskb;
@@ -590,7 +602,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 			/* otherwise actually kick it off here
 			 * (for error handling)
 			 */
-			ret = drv_remain_on_channel(local, sdata, channel,
+			ret = drv_remain_on_channel(local, sdata, chandef,
 						    duration, type);
 			if (ret) {
 				kfree(roc);
@@ -606,7 +618,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 	/* otherwise handle queueing */
 
 	list_for_each_entry(tmp, &local->roc_list, list) {
-		if (tmp->chan != channel || tmp->sdata != sdata)
+		if (tmp->chandef.chan != channel || tmp->sdata != sdata)
 			continue;
 
 		/*
@@ -668,7 +680,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 }
 
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *chan,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
@@ -676,9 +688,11 @@ int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 	int ret;
 
 	mutex_lock(&local->mtx);
-	ret = ieee80211_start_roc_work(local, sdata, chan,
-				       duration, cookie, NULL,
-				       IEEE80211_ROC_TYPE_NORMAL);
+	if (chandef) {
+		ret = ieee80211_start_roc_work(local, sdata, chandef,
+					       duration, cookie, NULL,
+					       IEEE80211_ROC_TYPE_NORMAL);
+	}
 	mutex_unlock(&local->mtx);
 
 	return ret;
@@ -766,6 +780,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
+	struct cfg80211_chan_def chandef;
 	struct sk_buff *skb;
 	struct sta_info *sta;
 	const struct ieee80211_mgmt *mgmt = (void *)params->buf;
@@ -935,8 +950,9 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		IEEE80211_SKB_CB(skb)->hw_queue =
 			local->hw.offchannel_tx_hw_queue;
 
+	chandef.chan = params->chan;
 	/* This will handle all kinds of coalescing and immediate TX */
-	ret = ieee80211_start_roc_work(local, sdata, params->chan,
+	ret = ieee80211_start_roc_work(local, sdata, &chandef,
 				       params->wait, cookie, skb,
 				       IEEE80211_ROC_TYPE_MGMT_TX);
 	if (ret)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9e8381b..2a18c85 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1226,17 +1226,17 @@ TRACE_EVENT(drv_get_antenna,
 TRACE_EVENT(drv_remain_on_channel,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 struct ieee80211_channel *chan,
+		 struct cfg80211_chan_def *chandef,
 		 unsigned int duration,
 		 enum ieee80211_roc_type type),
 
-	TP_ARGS(local, sdata, chan, duration, type),
+	TP_ARGS(local, sdata, chandef, duration, type),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
+		CHANDEF_ENTRY
 		__field(int, center_freq)
-		__field(int, freq_offset)
 		__field(unsigned int, duration)
 		__field(u32, type)
 	),
@@ -1244,8 +1244,9 @@ TRACE_EVENT(drv_remain_on_channel,
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
-		__entry->center_freq = chan->center_freq;
-		__entry->freq_offset = chan->freq_offset;
+		CHANDEF_ASSIGN(chandef);
+		__entry->center_freq = chandef->chan->center_freq;
+		__entry->freq_offset = chandef->chan->freq_offset;
 		__entry->duration = duration;
 		__entry->type = type;
 	),
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bf7cd47..c71c24c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11282,7 +11282,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 		goto free_msg;
 	}
 
-	err = rdev_remain_on_channel(rdev, wdev, chandef.chan,
+	err = rdev_remain_on_channel(rdev, wdev, &chandef,
 				     duration, &cookie);
 
 	if (err)
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ce6bf21..07bc258 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -710,12 +710,12 @@ static inline int rdev_flush_pmksa(struct cfg80211_registered_device *rdev,
 static inline int
 rdev_remain_on_channel(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev,
-		       struct ieee80211_channel *chan,
+		       struct cfg80211_chan_def *chandef,
 		       unsigned int duration, u64 *cookie)
 {
 	int ret;
-	trace_rdev_remain_on_channel(&rdev->wiphy, wdev, chan, duration);
-	ret = rdev->ops->remain_on_channel(&rdev->wiphy, wdev, chan,
+	trace_rdev_remain_on_channel(&rdev->wiphy, wdev, chandef, duration);
+	ret = rdev->ops->remain_on_channel(&rdev->wiphy, wdev, chandef,
 					   duration, cookie);
 	trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	return ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 19b78d4..26b8f70 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1900,9 +1900,9 @@ DEFINE_EVENT(rdev_pmksa, rdev_del_pmksa,
 
 TRACE_EVENT(rdev_remain_on_channel,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
-		 struct ieee80211_channel *chan,
+		 struct cfg80211_chan_def *chandef,
 		 unsigned int duration),
-	TP_ARGS(wiphy, wdev, chan, duration),
+	TP_ARGS(wiphy, wdev, chandef, duration),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
@@ -1912,7 +1912,7 @@ TRACE_EVENT(rdev_remain_on_channel,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
-		CHAN_ASSIGN(chan);
+		CHAN_ASSIGN(chandef->chan);
 		__entry->duration = duration;
 	),
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT ", duration: %u",
-- 
2.7.4

