Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37E83D13FB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhGUPkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 11:40:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57889 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhGUPko (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 11:40:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626884481; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xivyOk+hKKSvQ+Ksp85zN3EOG+/H1Vfn01O+OUvP2XA=; b=tyjXQoH4+2ei8eKT9z6XZLqp7OSTMUhMfFQGsORH3ik8pbj37H2COMJG9bk5vtXjrGwtF5IQ
 /AEPf6CMZYZky1yiVlO7/3RrbwcT+u8z1codOKfE6gcxhMh1s5zGS/7Ap5dHzraqZWZXIc3u
 3v+6rgkXUkX0KSDPvXGd8seAa2o=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60f84980e81205dd0a5b99b6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 16:21:20
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 609A2C433D3; Wed, 21 Jul 2021 16:21:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C46AC433F1;
        Wed, 21 Jul 2021 16:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C46AC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/3] ath11k: add separate APIs for monitor mode
Date:   Wed, 21 Jul 2021 19:20:52 +0300
Message-Id: <20210721162053.46290-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721162053.46290-1-jouni@codeaurora.org>
References: <20210721162053.46290-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Add separate APIs for monitor_vdev_create/monitor_vdev_delete
and monitor_vdev_start/monitor_vdev_stop.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Co-developed-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 313 ++++++++++++++++++++++++-
 2 files changed, 312 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6a6cabdd3e30..3cddab695031 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -488,7 +488,8 @@ struct ath11k {
 	u32 chan_tx_pwr;
 	u32 num_stations;
 	u32 max_num_stations;
-	bool monitor_present;
+	bool monitor_conf_enabled;
+	bool monitor_started;
 	/* To synchronize concurrent synchronous mac80211 callback operations,
 	 * concurrent debugfs configuration and concurrent FW statistics events.
 	 */
@@ -563,6 +564,7 @@ struct ath11k {
 	struct ath11k_per_peer_tx_stats cached_stats;
 	u32 last_ppdu_id;
 	u32 cached_ppdu_id;
+	int monitor_vdev_id;
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct ath11k_debug debug;
 #endif
@@ -571,6 +573,7 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	bool monitor_vdev_created;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3fd9a79801cb..e446817ac8b0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -745,14 +745,314 @@ static inline int ath11k_mac_vdev_setup_sync(struct ath11k *ar)
 	return ar->last_wmi_vdev_start_status ? -EINVAL : 0;
 }
 
-static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
+static void
+ath11k_mac_get_any_chandef_iter(struct ieee80211_hw *hw,
+				struct ieee80211_chanctx_conf *conf,
+				void *data)
 {
-	/* mac80211 requires this op to be present and that's why
-	 * there's an empty function, this can be extended when
-	 * required.
-	 */
+	struct cfg80211_chan_def **def = data;
+
+	*def = &conf->def;
+}
+
+static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
+					 struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_channel *channel;
+	struct wmi_vdev_start_req_arg arg = {};
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	channel = chandef->chan;
+
+	arg.vdev_id = vdev_id;
+	arg.channel.freq = channel->center_freq;
+	arg.channel.band_center_freq1 = chandef->center_freq1;
+	arg.channel.band_center_freq2 = chandef->center_freq2;
+
+	arg.channel.mode = ath11k_phymodes[chandef->chan->band][chandef->width];
+	arg.channel.chan_radar =
+			!!(channel->flags & IEEE80211_CHAN_RADAR);
+
+	arg.channel.min_power = 0;
+	arg.channel.max_power = channel->max_power * 2;
+	arg.channel.max_reg_power = channel->max_reg_power * 2;
+	arg.channel.max_antenna_gain = channel->max_antenna_gain * 2;
+
+	arg.pref_tx_streams = ar->num_tx_chains;
+	arg.pref_rx_streams = ar->num_rx_chains;
+
+	arg.channel.passive = !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
+
+	reinit_completion(&ar->vdev_setup_done);
+	reinit_completion(&ar->vdev_delete_done);
 
+	ret = ath11k_wmi_vdev_start(ar, &arg, false);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to request monitor vdev %i start: %d\n",
+			    vdev_id, ret);
+		return ret;
+	}
+	ret = ath11k_mac_vdev_setup_sync(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to synchronize setup for monitor vdev %i start: %d\n",
+			    vdev_id, ret);
+		return ret;
+	}
+	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
+			    vdev_id, ret);
+		goto vdev_stop;
+	}
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i started\n",
+		   vdev_id);
 	return 0;
+
+vdev_stop:
+	reinit_completion(&ar->vdev_setup_done);
+
+	ret = ath11k_wmi_vdev_stop(ar, vdev_id);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to stop monitor vdev %i after start failure: %d\n",
+			    vdev_id, ret);
+		return ret;
+	}
+
+	ret = ath11k_mac_vdev_setup_sync(ar);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to synchronize setup for vdev %i stop: %d\n",
+			    vdev_id, ret);
+	return ret;
+}
+
+static int ath11k_mac_monitor_vdev_stop(struct ath11k *ar)
+{
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	reinit_completion(&ar->vdev_setup_done);
+
+	ret = ath11k_wmi_vdev_stop(ar, ar->monitor_vdev_id);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to request monitor vdev %i stop: %d\n",
+			    ar->monitor_vdev_id, ret);
+
+	ret = ath11k_mac_vdev_setup_sync(ar);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to synchronize monitor vdev %i stop: %d\n",
+			    ar->monitor_vdev_id, ret);
+
+	ret = ath11k_wmi_vdev_down(ar, ar->monitor_vdev_id);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to put down monitor vdev %i: %d\n",
+			    ar->monitor_vdev_id, ret);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i stopped\n",
+		   ar->monitor_vdev_id);
+	return ret;
+}
+
+static int ath11k_mac_monitor_vdev_create(struct ath11k *ar)
+{
+	struct ath11k_pdev *pdev = ar->pdev;
+	struct vdev_create_params param = {};
+	int bit, ret;
+	u8 tmp_addr[6] = {0};
+	u16 nss;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->monitor_vdev_created)
+		return 0;
+
+	if (ar->ab->free_vdev_map == 0) {
+		ath11k_warn(ar->ab, "failed to find free vdev id for monitor vdev\n");
+		return -ENOMEM;
+	}
+
+	bit = __ffs64(ar->ab->free_vdev_map);
+
+	ar->monitor_vdev_id = bit;
+
+	param.if_id = ar->monitor_vdev_id;
+	param.type = WMI_VDEV_TYPE_MONITOR;
+	param.subtype = WMI_VDEV_SUBTYPE_NONE;
+	param.pdev_id = pdev->pdev_id;
+
+	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
+		param.chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
+		param.chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
+	}
+	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) {
+		param.chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
+		param.chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
+	}
+
+	ret = ath11k_wmi_vdev_create(ar, tmp_addr, &param);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to request monitor vdev %i creation: %d\n",
+			    ar->monitor_vdev_id, ret);
+		ar->monitor_vdev_id = -1;
+		return ret;
+	}
+
+	nss = get_num_chains(ar->cfg_tx_chainmask) ? : 1;
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, ar->monitor_vdev_id,
+					    WMI_VDEV_PARAM_NSS, nss);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set vdev %d chainmask 0x%x, nss %d :%d\n",
+			    ar->monitor_vdev_id, ar->cfg_tx_chainmask, nss, ret);
+		goto err_vdev_del;
+	}
+
+	ret = ath11k_mac_txpower_recalc(ar);
+	if (ret)
+		goto err_vdev_del;
+
+	ar->allocated_vdev_map |= 1LL << ar->monitor_vdev_id;
+	ar->ab->free_vdev_map &= ~(1LL << ar->monitor_vdev_id);
+	ar->num_created_vdevs++;
+	ar->monitor_vdev_created = true;
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %d created\n",
+		   ar->monitor_vdev_id);
+
+	return 0;
+
+err_vdev_del:
+	ath11k_wmi_vdev_delete(ar, ar->monitor_vdev_id);
+	ar->monitor_vdev_id = -1;
+	return ret;
+}
+
+static int ath11k_mac_monitor_vdev_delete(struct ath11k *ar)
+{
+	int ret;
+	unsigned long time_left;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!ar->monitor_vdev_created)
+		return 0;
+
+	reinit_completion(&ar->vdev_delete_done);
+
+	ret = ath11k_wmi_vdev_delete(ar, ar->monitor_vdev_id);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to request wmi monitor vdev %i removal: %d\n",
+			    ar->monitor_vdev_id, ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
+						ATH11K_VDEV_DELETE_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath11k_warn(ar->ab, "Timeout in receiving vdev delete response\n");
+	} else {
+		ar->allocated_vdev_map &= ~(1LL << ar->monitor_vdev_id);
+		ar->ab->free_vdev_map |= 1LL << (ar->monitor_vdev_id);
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %d deleted\n",
+			   ar->monitor_vdev_id);
+		ar->num_created_vdevs--;
+		ar->monitor_vdev_id = -1;
+		ar->monitor_vdev_created = false;
+	}
+
+	return ret;
+}
+
+static int ath11k_mac_monitor_start(struct ath11k *ar)
+{
+	struct cfg80211_chan_def *chandef = NULL;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->monitor_started)
+		return 0;
+
+	ieee80211_iter_chan_contexts_atomic(ar->hw,
+					    ath11k_mac_get_any_chandef_iter,
+					    &chandef);
+	if (!chandef)
+		return 0;
+
+	ret = ath11k_mac_monitor_vdev_start(ar, ar->monitor_vdev_id, chandef);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to start monitor vdev: %d\n", ret);
+		ath11k_mac_monitor_vdev_delete(ar);
+		return ret;
+	}
+
+	ar->monitor_started = true;
+	ar->num_started_vdevs++;
+	ret = ath11k_dp_tx_htt_monitor_mode_ring_config(ar, false);
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor started ret %d\n", ret);
+
+	return ret;
+}
+
+static int ath11k_mac_monitor_stop(struct ath11k *ar)
+{
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!ar->monitor_started)
+		return 0;
+
+	ret = ath11k_mac_monitor_vdev_stop(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to stop monitor vdev: %d\n", ret);
+		return ret;
+	}
+
+	ar->monitor_started = false;
+	ar->num_started_vdevs--;
+	ret = ath11k_dp_tx_htt_monitor_mode_ring_config(ar, true);
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor stopped ret %d\n", ret);
+	return ret;
+}
+
+static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct ath11k *ar = hw->priv;
+	struct ieee80211_conf *conf = &hw->conf;
+	int ret = 0;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		ar->monitor_conf_enabled = conf->flags & IEEE80211_CONF_MONITOR;
+		if (ar->monitor_conf_enabled) {
+			if (ar->monitor_vdev_created)
+				goto exit;
+			ret = ath11k_mac_monitor_vdev_create(ar);
+			if (ret)
+				goto exit;
+			ret = ath11k_mac_monitor_start(ar);
+			if (ret)
+				goto err_mon_del;
+		} else {
+			if (!ar->monitor_vdev_created)
+				goto exit;
+			ret = ath11k_mac_monitor_stop(ar);
+			if (ret)
+				goto exit;
+			ath11k_mac_monitor_vdev_delete(ar);
+		}
+	}
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+
+err_mon_del:
+	ath11k_mac_monitor_vdev_delete(ar);
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
 }
 
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
@@ -6772,6 +7072,9 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
 		skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
 		clear_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
+		ar->monitor_vdev_id = -1;
+		ar->monitor_vdev_created = false;
+		ar->monitor_started = false;
 	}
 
 	return 0;
-- 
2.25.1

