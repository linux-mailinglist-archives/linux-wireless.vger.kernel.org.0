Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84524E2EFC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 18:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbiCURYn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351792AbiCURYm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 13:24:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD186137F49
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647883393; x=1679419393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YQKQf/q1VFKNqEmJY4SY1dpx0WYaoeOu+AAHoj016lw=;
  b=mavDIv3LMx7BORRAlzH0BKvO+CARau4YhZBhfa1poEwnXhLu9y8q2WMu
   i3V+spLb/C48kp9soydTnkLyTSmFfAJ0Fz5A7DU73k1S9sQWzHIoQpNjB
   2lw1ZL71YFe3t+W3iVygycBMQeIZNzlb8jQO0I/zViN1dyiG43SttHacM
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 10:23:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:23:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 10:23:11 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 03:17:23 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH v4 1/3] nl80211: Extended ROC support for 40-80 MHz bandwidth
Date:   Mon, 21 Mar 2022 15:46:35 +0530
Message-ID: <1647857797-19749-2-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
References: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace struct ieee80211_channel with struct cfg80211_chan_def in
remain on channel apis, because the channel width information is
needed to handle centre frequency of 80MHz, and it is available
in cfg80211_chan_def. Also, add SUPPORTS_EXT_REMAIN_ON_CHAN feature
flag check before driver ops call.

Co-developed-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c              |  3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  5 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              | 10 +++-
 drivers/net/wireless/ath/ath9k/main.c              |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        | 13 +++--
 drivers/net/wireless/ath/wil6210/p2p.c             | 27 +++++++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 10 +++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  3 +-
 drivers/net/wireless/mac80211_hwsim.c              |  3 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 10 +++-
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |  4 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |  3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 17 ++++--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |  3 +-
 drivers/net/wireless/ti/wlcore/main.c              |  3 +-
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |  4 +-
 include/net/cfg80211.h                             | 17 +++---
 include/net/mac80211.h                             |  5 +-
 net/mac80211/debugfs.c                             |  1 +
 net/mac80211/driver-ops.h                          |  6 +-
 net/mac80211/ieee80211_i.h                         |  4 +-
 net/mac80211/offchannel.c                          | 64 ++++++++++++++--------
 net/mac80211/trace.h                               |  9 ++-
 net/wireless/nl80211.c                             | 27 ++++-----
 net/wireless/rdev-ops.h                            |  6 +-
 net/wireless/trace.h                               | 44 +++++++--------
 29 files changed, 192 insertions(+), 121 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 1f73fbf..c8662aa 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7828,12 +7828,13 @@ static int ath10k_conf_tx(struct ieee80211_hw *hw,
 
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
index bd11838..0505028 100644
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
@@ -3185,7 +3186,7 @@ static int ath6kl_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 {
 	struct ath6kl_vif *vif = ath6kl_vif_from_wdev(wdev);
 	struct ath6kl *ar = ath6kl_priv(vif->ndev);
-	struct ieee80211_channel *chan = params->chan;
+	struct ieee80211_channel *chan = params->chandef.chan;
 	const u8 *buf = params->buf;
 	size_t len = params->len;
 	unsigned int wait = params->wait;
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index bd1ef63..640d1e7 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -508,6 +508,7 @@ static int ath6kl_wmi_remain_on_chnl_event_rx(struct wmi *wmi, u8 *datap,
 	u32 dur;
 	struct ieee80211_channel *chan;
 	struct ath6kl *ar = wmi->parent_dev;
+	struct cfg80211_chan_def chandef;
 	u32 id;
 
 	if (len < sizeof(*ev))
@@ -526,7 +527,8 @@ static int ath6kl_wmi_remain_on_chnl_event_rx(struct wmi *wmi, u8 *datap,
 		return -EINVAL;
 	}
 	id = vif->last_roc_id;
-	cfg80211_ready_on_channel(&vif->wdev, id, chan,
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
+	cfg80211_ready_on_channel(&vif->wdev, id, &chandef,
 				  dur, GFP_ATOMIC);
 
 	return 0;
@@ -541,6 +543,7 @@ static int ath6kl_wmi_cancel_remain_on_chnl_event_rx(struct wmi *wmi,
 	u32 dur;
 	struct ieee80211_channel *chan;
 	struct ath6kl *ar = wmi->parent_dev;
+	struct cfg80211_chan_def chandef;
 	u32 id;
 
 	if (len < sizeof(*ev))
@@ -559,13 +562,16 @@ static int ath6kl_wmi_cancel_remain_on_chnl_event_rx(struct wmi *wmi,
 			   freq);
 		return -EINVAL;
 	}
+
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
+
 	if (vif->last_cancel_roc_id &&
 	    vif->last_cancel_roc_id + 1 == vif->last_roc_id)
 		id = vif->last_cancel_roc_id; /* event for cancel command */
 	else
 		id = vif->last_roc_id; /* timeout on uncanceled r-o-c */
 	vif->last_cancel_roc_id = 0;
-	cfg80211_remain_on_channel_expired(&vif->wdev, id, chan, GFP_ATOMIC);
+	cfg80211_remain_on_channel_expired(&vif->wdev, id, &chandef, GFP_ATOMIC);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 98090e4..990f13b 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2468,11 +2468,13 @@ static void ath9k_cancel_hw_scan(struct ieee80211_hw *hw,
 
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
index 764d1d1..45bcf45 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1443,7 +1443,7 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	bool tx_status;
 
 	wil_dbg_misc(wil, "mgmt_tx: channel %d offchan %d, wait %d\n",
-		     params->chan ? params->chan->hw_value : -1,
+		     params->chandef.chan ? params->chandef.chan->hw_value : -1,
 		     params->offchan,
 		     params->wait);
 
@@ -1452,7 +1452,7 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	 * mgmt_tx or listen on a channel other than active one.
 	 */
 
-	if (params->chan && params->chan->hw_value == 0) {
+	if (params->chandef.chan && params->chandef.chan->hw_value == 0) {
 		wil_err(wil, "invalid channel\n");
 		return -EINVAL;
 	}
@@ -1464,7 +1464,7 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		goto out;
 	}
 
-	if (!params->chan || params->chan->hw_value == vif->channel) {
+	if (!params->chandef.chan || params->chandef.chan->hw_value == vif->channel) {
 		wil_dbg_misc(wil,
 			     "send WMI_SW_TX_REQ_CMDID for on-channel\n");
 		rc = wmi_mgmt_tx(vif, buf, len);
@@ -1474,12 +1474,12 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (params->offchan == 0) {
 		wil_err(wil,
 			"invalid channel params: current %d requested %d, off-channel not allowed\n",
-			vif->channel, params->chan->hw_value);
+			vif->channel, params->chandef.chan->hw_value);
 		return -EBUSY;
 	}
 
 	/* use the wmi_mgmt_tx_ext only on AP mode and off-channel */
-	rc = wmi_mgmt_tx_ext(vif, buf, len, params->chan->hw_value,
+	rc = wmi_mgmt_tx_ext(vif, buf, len, params->chandef.chan->hw_value,
 			     params->wait);
 
 out:
@@ -1736,11 +1736,12 @@ static int wil_cfg80211_set_default_key(struct wiphy *wiphy,
 
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
diff --git a/drivers/net/wireless/ath/wil6210/p2p.c b/drivers/net/wireless/ath/wil6210/p2p.c
index f26bf04..6fd624f 100644
--- a/drivers/net/wireless/ath/wil6210/p2p.c
+++ b/drivers/net/wireless/ath/wil6210/p2p.c
@@ -128,6 +128,7 @@ int wil_p2p_listen(struct wil6210_priv *wil, struct wireless_dev *wdev,
 {
 	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	struct wil_p2p_info *p2p = &vif->p2p;
+	struct cfg80211_chan_def chandef;
 	int rc;
 
 	if (!chan)
@@ -166,7 +167,8 @@ int wil_p2p_listen(struct wil6210_priv *wil, struct wireless_dev *wdev,
 	if (vif->mid == 0)
 		wil->radio_wdev = wdev;
 
-	cfg80211_ready_on_channel(wdev, *cookie, chan, duration,
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
+	cfg80211_ready_on_channel(wdev, *cookie, &chandef, duration,
 				  GFP_KERNEL);
 
 out:
@@ -197,6 +199,7 @@ int wil_p2p_cancel_listen(struct wil6210_vif *vif, u64 cookie)
 {
 	struct wil6210_priv *wil = vif_to_wil(vif);
 	struct wil_p2p_info *p2p = &vif->p2p;
+	struct cfg80211_chan_def chandef;
 	u8 started;
 
 	mutex_lock(&wil->mutex);
@@ -218,9 +221,12 @@ int wil_p2p_cancel_listen(struct wil6210_vif *vif, u64 cookie)
 	}
 
 	mutex_lock(&wil->vif_mutex);
+
+	cfg80211_chandef_create(&chandef, &p2p->listen_chan, NL80211_CHAN_HT20);
+
 	cfg80211_remain_on_channel_expired(vif_to_radio_wdev(wil, vif),
 					   p2p->cookie,
-					   &p2p->listen_chan,
+					   &chandef,
 					   GFP_KERNEL);
 	if (vif->mid == 0)
 		wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
@@ -235,6 +241,7 @@ void wil_p2p_listen_expired(struct work_struct *work)
 	struct wil6210_vif *vif = container_of(p2p,
 			struct wil6210_vif, p2p);
 	struct wil6210_priv *wil = vif_to_wil(vif);
+	struct cfg80211_chan_def chandef;
 	u8 started;
 
 	wil_dbg_misc(wil, "p2p_listen_expired\n");
@@ -247,9 +254,12 @@ void wil_p2p_listen_expired(struct work_struct *work)
 		return;
 
 	mutex_lock(&wil->vif_mutex);
+
+	cfg80211_chandef_create(&chandef, &p2p->listen_chan, NL80211_CHAN_HT20);
+
 	cfg80211_remain_on_channel_expired(vif_to_radio_wdev(wil, vif),
 					   p2p->cookie,
-					   &p2p->listen_chan,
+					   &chandef,
 					   GFP_KERNEL);
 	if (vif->mid == 0)
 		wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
@@ -295,6 +305,7 @@ void wil_p2p_delayed_listen_work(struct work_struct *work)
 	struct wil6210_vif *vif = container_of(p2p,
 			struct wil6210_vif, p2p);
 	struct wil6210_priv *wil = vif_to_wil(vif);
+	struct cfg80211_chan_def chandef;
 	int rc;
 
 	mutex_lock(&wil->mutex);
@@ -313,17 +324,19 @@ void wil_p2p_delayed_listen_work(struct work_struct *work)
 
 	rc = wil_p2p_start_listen(vif);
 
+	cfg80211_chandef_create(&chandef, &p2p->listen_chan, NL80211_CHAN_HT20);
+
 	mutex_lock(&wil->vif_mutex);
 	if (rc) {
 		cfg80211_remain_on_channel_expired(p2p->pending_listen_wdev,
 						   p2p->cookie,
-						   &p2p->listen_chan,
+						   &chandef,
 						   GFP_KERNEL);
 		if (vif->mid == 0)
 			wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
 	} else {
 		cfg80211_ready_on_channel(p2p->pending_listen_wdev, p2p->cookie,
-					  &p2p->listen_chan,
+					  &chandef,
 					  p2p->listen_duration, GFP_KERNEL);
 		if (vif->mid == 0)
 			wil->radio_wdev = p2p->pending_listen_wdev;
@@ -339,6 +352,7 @@ void wil_p2p_stop_radio_operations(struct wil6210_priv *wil)
 {
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
 	struct wil_p2p_info *p2p = &vif->p2p;
+	struct cfg80211_chan_def chandef;
 	struct cfg80211_scan_info info = {
 		.aborted = true,
 	};
@@ -367,10 +381,11 @@ void wil_p2p_stop_radio_operations(struct wil6210_priv *wil)
 		cfg80211_scan_done(vif->scan_request, &info);
 		vif->scan_request = NULL;
 	} else {
+		cfg80211_chandef_create(&chandef, &p2p->listen_chan, NL80211_CHAN_HT20);
 		/* listen */
 		cfg80211_remain_on_channel_expired(wil->radio_wdev,
 						   p2p->cookie,
-						   &p2p->listen_chan,
+						   &chandef,
 						   GFP_KERNEL);
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fb72777..a852135 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5109,7 +5109,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       struct cfg80211_mgmt_tx_params *params, u64 *cookie)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
-	struct ieee80211_channel *chan = params->chan;
+	struct ieee80211_channel *chan = params->chandef.chan;
 	struct brcmf_pub *drvr = cfg->pub;
 	const u8 *buf = params->buf;
 	size_t len = params->len;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 4735063..bfa26779 100644
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
@@ -993,7 +994,7 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
 	*cookie = p2p->remain_on_channel_cookie;
-	cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
+	cfg80211_ready_on_channel(wdev, *cookie, chandef, duration, GFP_KERNEL);
 
 exit:
 	return err;
@@ -1014,6 +1015,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
+	struct cfg80211_chan_def chandef;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
@@ -1026,9 +1028,11 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 			complete(&p2p->wait_next_af);
 		}
 
+		cfg80211_chandef_create(&chandef, &p2p->remain_on_channel,
+					NL80211_CHAN_HT20);
 		cfg80211_remain_on_channel_expired(&ifp->vif->wdev,
 						   p2p->remain_on_channel_cookie,
-						   &p2p->remain_on_channel,
+						   &chandef,
 						   GFP_KERNEL);
 	}
 	return 0;
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
index 897e3b9..b3644dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3874,7 +3874,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 
 static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
-		       struct ieee80211_channel *channel,
+		       struct cfg80211_chan_def *chandefcfg,
 		       int duration,
 		       enum ieee80211_roc_type type)
 {
@@ -3882,6 +3882,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct cfg80211_chan_def chandef;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	struct ieee80211_channel *channel = chandefcfg->chan;
 	bool band_change_removal;
 	int ret, i;
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 23219f3..1d0c684 100644
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
index 6f23ec3..9008c11 100644
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
@@ -318,7 +319,7 @@ mwifiex_cfg80211_remain_on_channel(struct wiphy *wiphy,
 		priv->roc_cfg.cookie = *cookie;
 		priv->roc_cfg.chan = *chan;
 
-		cfg80211_ready_on_channel(wdev, *cookie, chan,
+		cfg80211_ready_on_channel(wdev, *cookie, chandef,
 					  duration, GFP_ATOMIC);
 
 		mwifiex_dbg(priv->adapter, INFO,
@@ -336,6 +337,7 @@ mwifiex_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
 					  struct wireless_dev *wdev, u64 cookie)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
+	struct cfg80211_chan_def chandef;
 	int ret;
 
 	if (cookie != priv->roc_cfg.cookie)
@@ -345,8 +347,10 @@ mwifiex_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
 					 &priv->roc_cfg.chan, 0);
 
 	if (!ret) {
+		cfg80211_chandef_create(&chandef, &priv->roc_cfg.chan,
+					NL80211_CHAN_HT20);
 		cfg80211_remain_on_channel_expired(wdev, cookie,
-						   &priv->roc_cfg.chan,
+						   &chandef,
 						   GFP_ATOMIC);
 
 		memset(&priv->roc_cfg, 0, sizeof(struct mwifiex_roc_cfg));
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 68c6326..b13883e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -705,6 +705,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 	u16 ctrl, reason_code;
 	u8 ibss_sta_addr[ETH_ALEN];
 	struct mwifiex_sta_node *sta_ptr;
+	struct cfg80211_chan_def chandef;
 
 	switch (eventcause) {
 	case EVENT_DUMMY_HOST_WAKEUP_SIGNAL:
@@ -1007,9 +1008,10 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
+		cfg80211_chandef_create(&chandef, &priv->roc_cfg.chan, NL80211_CHAN_HT20);
 		cfg80211_remain_on_channel_expired(&priv->wdev,
 						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
+						   &chandef,
 						   GFP_ATOMIC);
 
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 2e25d72..7d79331 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -113,6 +113,7 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 	struct mwifiex_sta_node *node;
 	u8 *deauth_mac;
 	struct host_cmd_ds_11n_batimeout *ba_timeout;
+	struct cfg80211_chan_def chandef;
 	u16 ctrl;
 
 	switch (eventcause) {
@@ -322,9 +323,10 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: uap: Remain on channel expired\n");
+		cfg80211_chandef_create(&chandef, &priv->roc_cfg.chan, NL80211_CHAN_HT20);
 		cfg80211_remain_on_channel_expired(&priv->wdev,
 						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
+						   &chandef,
 						   GFP_ATOMIC);
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 890d9b0..1bfdc4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1130,11 +1130,12 @@ mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
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
index dc4bfe7..cedaf5f 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1051,24 +1051,28 @@ static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
 	struct wilc_vif *vif = data;
 	struct wilc_priv *priv = &vif->priv;
 	struct wilc_wfi_p2p_listen_params *params = &priv->remain_on_ch_params;
+	struct cfg80211_chan_def chandef;
 
 	if (cookie != params->listen_cookie)
 		return;
 
 	priv->p2p_listen_state = false;
 
+	cfg80211_chandef_create(&chandef, params->listen_ch, NL80211_CHAN_HT20);
+
 	cfg80211_remain_on_channel_expired(&priv->wdev, params->listen_cookie,
-					   params->listen_ch, GFP_KERNEL);
+					   &chandef, GFP_KERNEL);
 }
 
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
@@ -1094,7 +1098,7 @@ static int remain_on_channel(struct wiphy *wiphy,
 	priv->p2p_listen_state = true;
 	priv->remain_on_ch_params.listen_duration = duration;
 
-	cfg80211_ready_on_channel(wdev, *cookie, chan, duration, GFP_KERNEL);
+	cfg80211_ready_on_channel(wdev, *cookie, chandef, duration, GFP_KERNEL);
 	mod_timer(&vif->hif_drv->remain_on_ch_timer,
 		  jiffies + msecs_to_jiffies(duration + 1000));
 
@@ -1119,7 +1123,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 		   struct cfg80211_mgmt_tx_params *params,
 		   u64 *cookie)
 {
-	struct ieee80211_channel *chan = params->chan;
+	struct ieee80211_channel *chan = params->chandef.chan;
 	unsigned int wait = params->wait;
 	const u8 *buf = params->buf;
 	size_t len = params->len;
@@ -1205,6 +1209,7 @@ static int mgmt_tx_cancel_wait(struct wiphy *wiphy,
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct host_if_drv *wfi_drv = priv->hif_drv;
+	struct cfg80211_chan_def chandef;
 
 	wfi_drv->p2p_timeout = jiffies;
 
@@ -1213,9 +1218,11 @@ static int mgmt_tx_cancel_wait(struct wiphy *wiphy,
 
 		params = &priv->remain_on_ch_params;
 
+		cfg80211_chandef_create(&chandef, params->listen_ch, NL80211_CHAN_HT20);
+
 		cfg80211_remain_on_channel_expired(wdev,
 						   params->listen_cookie,
-						   params->listen_ch,
+						   &chandef,
 						   GFP_KERNEL);
 	}
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index e70c1c7f..019d07c 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1758,11 +1758,12 @@ void rsi_roc_timeout(struct timer_list *t)
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
 
diff --git a/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h b/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
index 993a7b3..af75a55 100644
--- a/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
+++ b/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
@@ -111,7 +111,7 @@ bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter);
 #define rtw_cfg80211_rx_mgmt(adapter, freq, sig_dbm, buf, len, gfp) cfg80211_rx_mgmt((adapter)->rtw_wdev, freq, sig_dbm, buf, len, 0)
 #define rtw_cfg80211_send_rx_assoc(adapter, bss, buf, len) cfg80211_send_rx_assoc((adapter)->pnetdev, bss, buf, len)
 #define rtw_cfg80211_mgmt_tx_status(adapter, cookie, buf, len, ack, gfp) cfg80211_mgmt_tx_status((adapter)->rtw_wdev, cookie, buf, len, ack, gfp)
-#define rtw_cfg80211_ready_on_channel(adapter, cookie, chan, channel_type, duration, gfp)  cfg80211_ready_on_channel((adapter)->rtw_wdev, cookie, chan, duration, gfp)
-#define rtw_cfg80211_remain_on_channel_expired(adapter, cookie, chan, chan_type, gfp) cfg80211_remain_on_channel_expired((adapter)->rtw_wdev, cookie, chan, gfp)
+#define rtw_cfg80211_ready_on_channel(adapter, cookie, chandef, channel_type, duration, gfp)  cfg80211_ready_on_channel((adapter)->rtw_wdev, cookie, chandef, duration, gfp)
+#define rtw_cfg80211_remain_on_channel_expired(adapter, cookie, chandef, chan_type, gfp) cfg80211_remain_on_channel_expired((adapter)->rtw_wdev, cookie, chandef, gfp)
 
 #endif /* __IOCTL_CFG80211_H__ */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 423f97b..6fe8348 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3238,9 +3238,9 @@ struct cfg80211_update_ft_ies_params {
  * @dont_wait_for_ack: tells the low level not to wait for an ack
  * @n_csa_offsets: length of csa_offsets array
  * @csa_offsets: array of all the csa offsets in the frame
+ * @chandef: channel definition
  */
 struct cfg80211_mgmt_tx_params {
-	struct ieee80211_channel *chan;
 	bool offchan;
 	unsigned int wait;
 	const u8 *buf;
@@ -3249,6 +3249,7 @@ struct cfg80211_mgmt_tx_params {
 	bool dont_wait_for_ack;
 	int n_csa_offsets;
 	const u16 *csa_offsets;
+	struct cfg80211_chan_def chandef;
 };
 
 /**
@@ -4235,7 +4236,7 @@ struct cfg80211_ops {
 
 	int	(*remain_on_channel)(struct wiphy *wiphy,
 				     struct wireless_dev *wdev,
-				     struct ieee80211_channel *chan,
+				     struct cfg80211_chan_def *chandef,
 				     unsigned int duration,
 				     u64 *cookie);
 	int	(*cancel_remain_on_channel)(struct wiphy *wiphy,
@@ -7338,35 +7339,35 @@ void cfg80211_disconnected(struct net_device *dev, u16 reason,
  * cfg80211_ready_on_channel - notification of remain_on_channel start
  * @wdev: wireless device
  * @cookie: the request cookie
- * @chan: The current channel (from remain_on_channel request)
+ * @chandef: chandef for the current channel (from remain_on_channel request)
  * @duration: Duration in milliseconds that the driver intents to remain on the
  *	channel
  * @gfp: allocation flags
  */
 void cfg80211_ready_on_channel(struct wireless_dev *wdev, u64 cookie,
-			       struct ieee80211_channel *chan,
+			       struct cfg80211_chan_def *chandef,
 			       unsigned int duration, gfp_t gfp);
 
 /**
  * cfg80211_remain_on_channel_expired - remain_on_channel duration expired
  * @wdev: wireless device
  * @cookie: the request cookie
- * @chan: The current channel (from remain_on_channel request)
+ * @chandef: chandef for the current channel
  * @gfp: allocation flags
  */
 void cfg80211_remain_on_channel_expired(struct wireless_dev *wdev, u64 cookie,
-					struct ieee80211_channel *chan,
+					struct cfg80211_chan_def *chandef,
 					gfp_t gfp);
 
 /**
  * cfg80211_tx_mgmt_expired - tx_mgmt duration expired
  * @wdev: wireless device
  * @cookie: the requested cookie
- * @chan: The current channel (from tx_mgmt request)
+ * @chandef: chandef for the current channel (from tx_mgmt request)
  * @gfp: allocation flags
  */
 void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
-			      struct ieee80211_channel *chan, gfp_t gfp);
+			      struct cfg80211_chan_def *chandef, gfp_t gfp);
 
 /**
  * cfg80211_sinfo_alloc_tid_stats - allocate per-tid statistics.
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index dd757f0..177679d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2422,6 +2422,8 @@ struct ieee80211_txq {
  *	usage and 802.11 frames with %RX_FLAG_ONLY_MONITOR set for monitor to
  *	the stack.
  *
+ * @IEEE80211_HW_SUPPORTS_EXT_REMAIN_ON_CHAN: Hardware supports extended remain
+ *	on channel for bandwidth higher than 20MHz.
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2477,6 +2479,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
+	IEEE80211_HW_SUPPORTS_EXT_REMAIN_ON_CHAN,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
@@ -4118,7 +4121,7 @@ struct ieee80211_ops {
 
 	int (*remain_on_channel)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
-				 struct ieee80211_channel *chan,
+				 struct cfg80211_chan_def *chandef,
 				 int duration,
 				 enum ieee80211_roc_type type);
 	int (*cancel_remain_on_channel)(struct ieee80211_hw *hw,
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 8dbfe32..a355fe4 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -504,6 +504,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
 	FLAG(SUPPORTS_RX_DECAP_OFFLOAD),
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
+	FLAG(SUPPORTS_EXT_REMAIN_ON_CHAN),
 #undef FLAG
 };
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c336267..8babc13 100644
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
index 482c98e..115e68a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -337,7 +337,7 @@ struct ieee80211_roc_work {
 
 	struct ieee80211_sub_if_data *sdata;
 
-	struct ieee80211_channel *chan;
+	struct cfg80211_chan_def chandef;
 
 	bool started, abort, hw_begun, notified;
 	bool on_channel;
@@ -1907,7 +1907,7 @@ void ieee80211_start_next_roc(struct ieee80211_local *local);
 void ieee80211_roc_purge(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata);
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *chan,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie);
 int ieee80211_cancel_remain_on_channel(struct wiphy *wiphy,
 				       struct wireless_dev *wdev, u64 cookie);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 853c9a3..fa5c06c 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -178,12 +178,13 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
 
 	if (!roc->mgmt_tx_cookie)
 		cfg80211_remain_on_channel_expired(&roc->sdata->wdev,
-						   roc->cookie, roc->chan,
+						   roc->cookie,
+						   &roc->chandef,
 						   GFP_KERNEL);
 	else
 		cfg80211_tx_mgmt_expired(&roc->sdata->wdev,
 					 roc->mgmt_tx_cookie,
-					 roc->chan, GFP_KERNEL);
+					 &roc->chandef, GFP_KERNEL);
 
 	list_del(&roc->list);
 	kfree(roc);
@@ -235,21 +236,24 @@ static bool ieee80211_recalc_sw_work(struct ieee80211_local *local,
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
+					  &roc->chandef, roc->req_duration,
 					  GFP_KERNEL);
 	}
 
@@ -311,7 +315,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 	list_for_each_entry(tmp, &local->roc_list, list) {
 		if (tmp == roc)
 			continue;
-		if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+		if (tmp->sdata != roc->sdata ||
+		    cfg80211_chandef_identical(&tmp->chandef, &roc->chandef))
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
@@ -331,7 +337,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 			 */
 			list_for_each_entry(tmp, &local->roc_list, list) {
 				if (tmp->sdata != roc->sdata ||
-				    tmp->chan != roc->chan)
+				    cfg80211_chandef_identical(&tmp->chandef,
+							       &roc->chandef))
 					break;
 				tmp->started = true;
 				tmp->abort = true;
@@ -342,7 +349,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 
 		/* we'll notify about the start once the HW calls back */
 		list_for_each_entry(tmp, &local->roc_list, list) {
-			if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+			if (tmp->sdata != roc->sdata ||
+			    cfg80211_chandef_identical(&tmp->chandef, &roc->chandef))
 				break;
 			tmp->started = true;
 		}
@@ -352,7 +360,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		 * treat it as though the ROC operation started properly, so
 		 * other ROC operations won't interfere with this one.
 		 */
-		roc->on_channel = roc->chan == local->_oper_chandef.chan &&
+		roc->on_channel = roc->chandef.chan == local->_oper_chandef.chan &&
 				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_5 &&
 				  local->_oper_chandef.width != NL80211_CHAN_WIDTH_10;
 
@@ -362,7 +370,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		if (!roc->on_channel) {
 			ieee80211_offchannel_stop_vifs(local);
 
-			local->tmp_channel = roc->chan;
+			local->tmp_channel = roc->chandef.chan;
 			ieee80211_hw_config(local, 0);
 		}
 
@@ -371,7 +379,8 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 
 		/* tell userspace or send frame(s) */
 		list_for_each_entry(tmp, &local->roc_list, list) {
-			if (tmp->sdata != roc->sdata || tmp->chan != roc->chan)
+			if (tmp->sdata != roc->sdata ||
+			    cfg80211_chandef_identical(&tmp->chandef, &roc->chandef))
 				break;
 
 			tmp->on_channel = roc->on_channel;
@@ -526,12 +535,13 @@ ieee80211_coalesce_hw_started_roc(struct ieee80211_local *local,
 
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
 
@@ -560,7 +570,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 	if (!duration)
 		duration = 10;
 
-	roc->chan = channel;
+	roc->chandef = *chandef;
 	roc->duration = duration;
 	roc->req_duration = duration;
 	roc->frame = txskb;
@@ -590,7 +600,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 			/* otherwise actually kick it off here
 			 * (for error handling)
 			 */
-			ret = drv_remain_on_channel(local, sdata, channel,
+			ret = drv_remain_on_channel(local, sdata, chandef,
 						    duration, type);
 			if (ret) {
 				kfree(roc);
@@ -606,7 +616,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 	/* otherwise handle queueing */
 
 	list_for_each_entry(tmp, &local->roc_list, list) {
-		if (tmp->chan != channel || tmp->sdata != sdata)
+		if (tmp->chandef.chan != channel || tmp->sdata != sdata)
 			continue;
 
 		/*
@@ -668,7 +678,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 }
 
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
-				struct ieee80211_channel *chan,
+				struct cfg80211_chan_def *chandef,
 				unsigned int duration, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
@@ -676,9 +686,13 @@ int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 	int ret;
 
 	mutex_lock(&local->mtx);
-	ret = ieee80211_start_roc_work(local, sdata, chan,
-				       duration, cookie, NULL,
-				       IEEE80211_ROC_TYPE_NORMAL);
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_EXT_REMAIN_ON_CHAN))
+		goto err;
+
+	ret = ieee80211_start_roc_work(local, sdata, chandef, duration,
+				       cookie, NULL, IEEE80211_ROC_TYPE_NORMAL);
+err:
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
@@ -835,7 +850,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	/* configurations requiring offchan cannot work if no channel has been
 	 * specified
 	 */
-	if (need_offchan && !params->chan)
+	if (need_offchan && !params->chandef.chan)
 		return -EINVAL;
 
 	mutex_lock(&local->mtx);
@@ -848,10 +863,10 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 
 		if (chanctx_conf) {
-			need_offchan = params->chan &&
-				       (params->chan !=
+			need_offchan = params->chandef.chan &&
+				       (params->chandef.chan !=
 					chanctx_conf->def.chan);
-		} else if (!params->chan) {
+		} else if (!params->chandef.chan) {
 			ret = -EINVAL;
 			rcu_read_unlock();
 			goto out_unlock;
@@ -935,8 +950,9 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		IEEE80211_SKB_CB(skb)->hw_queue =
 			local->hw.offchannel_tx_hw_queue;
 
+	chandef = params->chandef;
 	/* This will handle all kinds of coalescing and immediate TX */
-	ret = ieee80211_start_roc_work(local, sdata, params->chan,
+	ret = ieee80211_start_roc_work(local, sdata, &chandef,
 				       params->wait, cookie, skb,
 				       IEEE80211_ROC_TYPE_MGMT_TX);
 	if (ret)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9e8381b..720e56c 100644
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
@@ -1244,8 +1244,7 @@ TRACE_EVENT(drv_remain_on_channel,
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
-		__entry->center_freq = chan->center_freq;
-		__entry->freq_offset = chan->freq_offset;
+		CHANDEF_ASSIGN(chandef);
 		__entry->duration = duration;
 		__entry->type = type;
 	),
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a27b3b5..ee8e7f2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11486,7 +11486,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 		goto free_msg;
 	}
 
-	err = rdev_remain_on_channel(rdev, wdev, chandef.chan,
+	err = rdev_remain_on_channel(rdev, wdev, &chandef,
 				     duration, &cookie);
 
 	if (err)
@@ -11704,7 +11704,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	params.chan = chandef.chan;
+	params.chandef = chandef;
 	err = cfg80211_mlme_mgmt_tx(rdev, wdev, &params, &cookie);
 	if (err)
 		goto free_msg;
@@ -16993,10 +16993,11 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 static void nl80211_send_remain_on_chan_event(
 	int cmd, struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev, u64 cookie,
-	struct ieee80211_channel *chan,
+	struct cfg80211_chan_def *chandef,
 	unsigned int duration, gfp_t gfp)
 {
 	struct sk_buff *msg;
+	struct ieee80211_channel *chan = chandef->chan;
 	void *hdr;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
@@ -17036,42 +17037,42 @@ static void nl80211_send_remain_on_chan_event(
 }
 
 void cfg80211_ready_on_channel(struct wireless_dev *wdev, u64 cookie,
-			       struct ieee80211_channel *chan,
+			       struct cfg80211_chan_def *chandef,
 			       unsigned int duration, gfp_t gfp)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	trace_cfg80211_ready_on_channel(wdev, cookie, chan, duration);
+	trace_cfg80211_ready_on_channel(wdev, cookie, chandef, duration);
 	nl80211_send_remain_on_chan_event(NL80211_CMD_REMAIN_ON_CHANNEL,
-					  rdev, wdev, cookie, chan,
+					  rdev, wdev, cookie, chandef,
 					  duration, gfp);
 }
 EXPORT_SYMBOL(cfg80211_ready_on_channel);
 
 void cfg80211_remain_on_channel_expired(struct wireless_dev *wdev, u64 cookie,
-					struct ieee80211_channel *chan,
+					struct cfg80211_chan_def *chandef,
 					gfp_t gfp)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	trace_cfg80211_ready_on_channel_expired(wdev, cookie, chan);
+	trace_cfg80211_ready_on_channel_expired(wdev, cookie, chandef);
 	nl80211_send_remain_on_chan_event(NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL,
-					  rdev, wdev, cookie, chan, 0, gfp);
+					  rdev, wdev, cookie, chandef, 0, gfp);
 }
 EXPORT_SYMBOL(cfg80211_remain_on_channel_expired);
 
 void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
-					struct ieee80211_channel *chan,
-					gfp_t gfp)
+			      struct cfg80211_chan_def *chandef,
+			      gfp_t gfp)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	trace_cfg80211_tx_mgmt_expired(wdev, cookie, chan);
+	trace_cfg80211_tx_mgmt_expired(wdev, cookie, chandef);
 	nl80211_send_remain_on_chan_event(NL80211_CMD_FRAME_WAIT_CANCEL,
-					  rdev, wdev, cookie, chan, 0, gfp);
+					  rdev, wdev, cookie, chandef, 0, gfp);
 }
 EXPORT_SYMBOL(cfg80211_tx_mgmt_expired);
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index cc1efec..e0fd09b 100644
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
index ad6c16a..c08399e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1913,9 +1913,9 @@ DEFINE_EVENT(rdev_pmksa, rdev_del_pmksa,
 
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
@@ -1925,7 +1925,7 @@ TRACE_EVENT(rdev_remain_on_channel,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
-		CHAN_ASSIGN(chan);
+		CHAN_ASSIGN(chandef->chan);
 		__entry->duration = duration;
 	),
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT ", duration: %u",
@@ -1982,7 +1982,7 @@ TRACE_EVENT(rdev_mgmt_tx,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
-		CHAN_ASSIGN(params->chan);
+		CHAN_ASSIGN(params->chandef.chan);
 		__entry->offchan = params->offchan;
 		__entry->wait = params->wait;
 		__entry->no_cck = params->no_cck;
@@ -2812,60 +2812,60 @@ TRACE_EVENT(cfg80211_michael_mic_failure,
 
 TRACE_EVENT(cfg80211_ready_on_channel,
 	TP_PROTO(struct wireless_dev *wdev, u64 cookie,
-		 struct ieee80211_channel *chan,
+		 struct cfg80211_chan_def *chandef,
 		 unsigned int duration),
-	TP_ARGS(wdev, cookie, chan, duration),
+	TP_ARGS(wdev, cookie, chandef, duration),
 	TP_STRUCT__entry(
 		WDEV_ENTRY
 		__field(u64, cookie)
-		CHAN_ENTRY
+		CHAN_DEF_ENTRY
 		__field(unsigned int, duration)
 	),
 	TP_fast_assign(
 		WDEV_ASSIGN;
 		__entry->cookie = cookie;
-		CHAN_ASSIGN(chan);
+		CHAN_DEF_ASSIGN(chandef);
 		__entry->duration = duration;
 	),
-	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_PR_FMT ", duration: %u",
-		  WDEV_PR_ARG, __entry->cookie, CHAN_PR_ARG,
+	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_DEF_PR_FMT ", duration: %u",
+		  WDEV_PR_ARG, __entry->cookie, CHAN_DEF_PR_ARG,
 		  __entry->duration)
 );
 
 TRACE_EVENT(cfg80211_ready_on_channel_expired,
 	TP_PROTO(struct wireless_dev *wdev, u64 cookie,
-		 struct ieee80211_channel *chan),
-	TP_ARGS(wdev, cookie, chan),
+		 struct cfg80211_chan_def *chandef),
+	TP_ARGS(wdev, cookie, chandef),
 	TP_STRUCT__entry(
 		WDEV_ENTRY
 		__field(u64, cookie)
-		CHAN_ENTRY
+		CHAN_DEF_ENTRY
 	),
 	TP_fast_assign(
 		WDEV_ASSIGN;
 		__entry->cookie = cookie;
-		CHAN_ASSIGN(chan);
+		CHAN_DEF_ASSIGN(chandef);
 	),
-	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_PR_FMT,
-		  WDEV_PR_ARG, __entry->cookie, CHAN_PR_ARG)
+	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_DEF_PR_FMT,
+		  WDEV_PR_ARG, __entry->cookie, CHAN_DEF_PR_ARG)
 );
 
 TRACE_EVENT(cfg80211_tx_mgmt_expired,
 	TP_PROTO(struct wireless_dev *wdev, u64 cookie,
-		 struct ieee80211_channel *chan),
-	TP_ARGS(wdev, cookie, chan),
+		 struct cfg80211_chan_def *chandef),
+	TP_ARGS(wdev, cookie, chandef),
 	TP_STRUCT__entry(
 		WDEV_ENTRY
 		__field(u64, cookie)
-		CHAN_ENTRY
+		CHAN_DEF_ENTRY
 	),
 	TP_fast_assign(
 		WDEV_ASSIGN;
 		__entry->cookie = cookie;
-		CHAN_ASSIGN(chan);
+		CHAN_DEF_ASSIGN(chandef);
 	),
-	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_PR_FMT,
-		  WDEV_PR_ARG, __entry->cookie, CHAN_PR_ARG)
+	TP_printk(WDEV_PR_FMT ", cookie: %llu, " CHAN_DEF_PR_FMT,
+		  WDEV_PR_ARG, __entry->cookie, CHAN_DEF_PR_ARG)
 );
 
 TRACE_EVENT(cfg80211_new_sta,
-- 
2.7.4

