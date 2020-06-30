Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40A20F5F9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgF3NmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbgF3NmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 09:42:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA9C061755
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:42:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so20246108wrn.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fx9nae/6WzpXryyNcZSeFEglCrL7UJrEuIEv78+aKLY=;
        b=mLSj87stl2FXjYzeleYKc05BOBQ2FHGqw8cdzUMOFesOy6jXKrwu6HaPCKsqhzSDDM
         gIopOKjOpvmQ5iYuGPqvlWMxOJOT8D54a5m8LeHNGUXO6Fm9OFPTyfms//CYzsri6MW3
         L3MhzRSoCF6bq5Sl6+7SUVjkh4nrKx+8WOG3Tis3/0lS32cAtCYeqH+g8Fp/3lF8frZS
         Jt8Q8R9ghUGiS696BNVe8ctwlbPglO+WmPj/S1l6e9AiN1oKOOxDtwF49C62gAlKLDls
         jUhz5NYp3DGfW6qqE3pOTrJK3G0bAoAQyHbfaBdZOz6h0dyRLK8riIY/uM3Uj7LJ08CO
         oD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fx9nae/6WzpXryyNcZSeFEglCrL7UJrEuIEv78+aKLY=;
        b=KIPmfzU36xoxq/7+LNeH+bTwM7wcInhBDGIwDNqwkszVicbs0/xusFFZQGsgBF2iJM
         DYLDXP9jWOtE0YTx2Wa4b7eGiGs5J9sHK5TQNW+4GxX9rb9eKYqfar2+8QmJeuMI/adw
         Rrq41kC5LMp5AFI4G/lJ00rzf/8WDQWfroe4wZ9z0CdE4c30/tyGIkwJRPSD+rAScJge
         t/ssCSmX2Scf02Ym6GKwTSnHgQqQuErracsz78nmCJtPV+ij/Xsqr+6r6ZkdR/T/jBoV
         bdBvsm17+t+g1Hj72+p6ZuP+9IWCmFnoIad9mPiuh8JppGjPLRdnIBKVxXk+v0L/beah
         TMHA==
X-Gm-Message-State: AOAM530uU8oViKexwEzEjg9uSUkqVgj5nIExxjS8hUymYdf9ykt17PSW
        qq2faA7NA7yCPP7J+qKjq2N5BHhOenLOZQ==
X-Google-Smtp-Source: ABdhPJxksvSM092blY5OBSpaoI5kaDjJm6TH3JPa1e8Yzc/I6p6abK+dbnDZtujVH4XJn0k8/5HLhQ==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr21431321wrm.72.1593524520849;
        Tue, 30 Jun 2020 06:42:00 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id l18sm3803411wrm.52.2020.06.30.06.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:42:00 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 4/4] wcn36xx: Fix software-driven scan
Date:   Tue, 30 Jun 2020 15:47:01 +0200
Message-Id: <1593524821-32115-4-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For software-driven scan, rely on mac80211 software scan instead
of internal driver implementation. The internal implementation
cause connection trouble since it keeps the antenna busy during
the entire scan duration, moreover it's only a passive scanning
(no probe request). Therefore, let mac80211 manages sw scan.

Note: we fallback to software scan if firmware does not report
scan offload support or if we need to scan the 5Ghz band (currently
not supported by the offload scan...).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 162 +++++++++++++++--------------
 drivers/net/wireless/ath/wcn36xx/smd.c     |  23 +++-
 drivers/net/wireless/ath/wcn36xx/smd.h     |   8 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c    |  11 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   6 +-
 5 files changed, 117 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c19648f..78a4164 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -354,8 +354,6 @@ static void wcn36xx_stop(struct ieee80211_hw *hw)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac stop\n");
 
-	cancel_work_sync(&wcn->scan_work);
-
 	mutex_lock(&wcn->scan_lock);
 	if (wcn->scan_req) {
 		struct cfg80211_scan_info scan_info = {
@@ -378,12 +376,37 @@ static void wcn36xx_stop(struct ieee80211_hw *hw)
 	kfree(wcn->hal_buf);
 }
 
-static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
+static void wcn36xx_change_ps(struct wcn36xx *wcn, bool enable)
 {
-	struct wcn36xx *wcn = hw->priv;
 	struct ieee80211_vif *vif = NULL;
 	struct wcn36xx_vif *tmp;
 
+	list_for_each_entry(tmp, &wcn->vif_list, list) {
+		vif = wcn36xx_priv_to_vif(tmp);
+		if (enable && !wcn->sw_scan) {
+			if (vif->bss_conf.ps) /* ps allowed ? */
+				wcn36xx_pmc_enter_bmps_state(wcn, vif);
+		} else {
+			wcn36xx_pmc_exit_bmps_state(wcn, vif);
+		}
+	}
+}
+
+static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
+{
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *tmp;
+
+	list_for_each_entry(tmp, &wcn->vif_list, list) {
+		vif = wcn36xx_priv_to_vif(tmp);
+		wcn36xx_smd_switch_channel(wcn, vif, ch);
+	}
+}
+
+static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct wcn36xx *wcn = hw->priv;
+
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac config changed 0x%08x\n", changed);
 
 	mutex_lock(&wcn->conf_mutex);
@@ -392,24 +415,30 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 		int ch = WCN36XX_HW_CHANNEL(wcn);
 		wcn36xx_dbg(WCN36XX_DBG_MAC, "wcn36xx_config channel switch=%d\n",
 			    ch);
-		list_for_each_entry(tmp, &wcn->vif_list, list) {
-			vif = wcn36xx_priv_to_vif(tmp);
-			wcn36xx_smd_switch_channel(wcn, vif, ch);
-		}
-	}
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		list_for_each_entry(tmp, &wcn->vif_list, list) {
-			vif = wcn36xx_priv_to_vif(tmp);
-			if (hw->conf.flags & IEEE80211_CONF_PS) {
-				if (vif->bss_conf.ps) /* ps allowed ? */
-					wcn36xx_pmc_enter_bmps_state(wcn, vif);
-			} else {
-				wcn36xx_pmc_exit_bmps_state(wcn, vif);
-			}
+		if (wcn->sw_scan_opchannel == ch) {
+			/* If channel is the initial operating channel, we may
+			 * want to receive/transmit regular data packets, then
+			 * simply stop the scan session and return into
+			 * operating mode.
+			 */
+			wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
+						wcn->sw_scan_vif, ch);
+		} else if (wcn->sw_scan) {
+			/* A scan is ongoing, do not change the operating
+			 * channel, but start a scan session on the channel.
+			 */
+			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
+					      wcn->sw_scan_vif);
+			wcn36xx_smd_start_scan(wcn, ch);
+		} else {
+			wcn36xx_change_opchannel(wcn, ch);
 		}
 	}
 
+	if (changed & IEEE80211_CONF_CHANGE_PS)
+		wcn36xx_change_ps(wcn, hw->conf.flags & IEEE80211_CONF_PS);
+
 	mutex_unlock(&wcn->conf_mutex);
 
 	return 0;
@@ -614,55 +643,26 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return ret;
 }
 
-static void wcn36xx_hw_scan_worker(struct work_struct *work)
+static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   struct ieee80211_scan_request *hw_req)
 {
-	struct wcn36xx *wcn = container_of(work, struct wcn36xx, scan_work);
-	struct cfg80211_scan_request *req = wcn->scan_req;
-	u8 channels[WCN36XX_HAL_PNO_MAX_NETW_CHANNELS_EX];
-	struct cfg80211_scan_info scan_info = {};
-	bool aborted = false;
+	struct wcn36xx *wcn = hw->priv;
 	int i;
 
-	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac80211 scan %d channels worker\n", req->n_channels);
-
-	for (i = 0; i < req->n_channels; i++)
-		channels[i] = req->channels[i]->hw_value;
-
-	wcn36xx_smd_update_scan_params(wcn, channels, req->n_channels);
-
-	wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN);
-	for (i = 0; i < req->n_channels; i++) {
-		mutex_lock(&wcn->scan_lock);
-		aborted = wcn->scan_aborted;
-		mutex_unlock(&wcn->scan_lock);
-
-		if (aborted)
-			break;
-
-		wcn->scan_freq = req->channels[i]->center_freq;
-		wcn->scan_band = req->channels[i]->band;
-
-		wcn36xx_smd_start_scan(wcn, req->channels[i]->hw_value);
-		msleep(30);
-		wcn36xx_smd_end_scan(wcn, req->channels[i]->hw_value);
-
-		wcn->scan_freq = 0;
+	if (!get_feat_caps(wcn->fw_feat_caps, SCAN_OFFLOAD)) {
+		/* fallback to mac80211 software scan */
+		return 1;
 	}
-	wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN);
 
-	scan_info.aborted = aborted;
-	ieee80211_scan_completed(wcn->hw, &scan_info);
-
-	mutex_lock(&wcn->scan_lock);
-	wcn->scan_req = NULL;
-	mutex_unlock(&wcn->scan_lock);
-}
+	/* For unknown reason, the hardware offloaded scan only works with
+	 * 2.4Ghz channels, fallback to software scan in other cases.
+	 */
+	for (i = 0; i < hw_req->req.n_channels; i++) {
+		if (hw_req->req.channels[i]->band != NL80211_BAND_2GHZ)
+			return 1;
+	}
 
-static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
-			   struct ieee80211_vif *vif,
-			   struct ieee80211_scan_request *hw_req)
-{
-	struct wcn36xx *wcn = hw->priv;
 	mutex_lock(&wcn->scan_lock);
 	if (wcn->scan_req) {
 		mutex_unlock(&wcn->scan_lock);
@@ -674,12 +674,6 @@ static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_unlock(&wcn->scan_lock);
 
-	if (!get_feat_caps(wcn->fw_feat_caps, SCAN_OFFLOAD)) {
-		/* legacy manual/sw scan */
-		schedule_work(&wcn->scan_work);
-		return 0;
-	}
-
 	return wcn36xx_smd_start_hw_scan(wcn, vif, &hw_req->req);
 }
 
@@ -696,16 +690,32 @@ static void wcn36xx_cancel_hw_scan(struct ieee80211_hw *hw,
 		/* ieee80211_scan_completed will be called on FW scan
 		 * indication */
 		wcn36xx_smd_stop_hw_scan(wcn);
-	} else {
-		struct cfg80211_scan_info scan_info = {
-			.aborted = true,
-		};
-
-		cancel_work_sync(&wcn->scan_work);
-		ieee80211_scan_completed(wcn->hw, &scan_info);
 	}
 }
 
+static void wcn36xx_sw_scan_start(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  const u8 *mac_addr)
+{
+	struct wcn36xx *wcn = hw->priv;
+
+	wcn->sw_scan = true;
+	wcn->sw_scan_vif = vif;
+	wcn->sw_scan_opchannel = WCN36XX_HW_CHANNEL(wcn);
+}
+
+static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct wcn36xx *wcn = hw->priv;
+
+	/* ensure that any scan session is finished */
+	wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN, wcn->sw_scan_vif,
+				wcn->sw_scan_opchannel);
+	wcn->sw_scan = false;
+	wcn->sw_scan_opchannel = 0;
+}
+
 static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 					 enum nl80211_band band)
 {
@@ -1151,6 +1161,8 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.set_key		= wcn36xx_set_key,
 	.hw_scan		= wcn36xx_hw_scan,
 	.cancel_hw_scan		= wcn36xx_cancel_hw_scan,
+	.sw_scan_start		= wcn36xx_sw_scan_start,
+	.sw_scan_complete	= wcn36xx_sw_scan_complete,
 	.bss_info_changed	= wcn36xx_bss_info_changed,
 	.set_rts_threshold	= wcn36xx_set_rts_threshold,
 	.sta_add		= wcn36xx_sta_add,
@@ -1329,8 +1341,6 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}
 
-	INIT_WORK(&wcn->scan_work, wcn36xx_hw_scan_worker);
-
 	wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
 	if (IS_ERR(wcn->smd_channel)) {
 		wcn36xx_err("failed to open WLAN_CTRL channel\n");
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3fc2d46..e58b038 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -517,8 +517,10 @@ int wcn36xx_smd_stop(struct wcn36xx *wcn)
 	return ret;
 }
 
-int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode)
+int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
+			  struct ieee80211_vif *vif)
 {
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	struct wcn36xx_hal_init_scan_req_msg msg_body;
 	int ret;
 
@@ -526,6 +528,13 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode)
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_INIT_SCAN_REQ);
 
 	msg_body.mode = mode;
+	if (vif_priv->bss_index != WCN36XX_HAL_BSS_INVALID_IDX) {
+		/* Notify BSSID with null DATA packet */
+		msg_body.frame_type = 2;
+		msg_body.notify = 1;
+		msg_body.scan_entry.bss_index[0] = vif_priv->bss_index;
+		msg_body.scan_entry.active_bss_count = 1;
+	}
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
@@ -607,8 +616,10 @@ int wcn36xx_smd_end_scan(struct wcn36xx *wcn, u8 scan_channel)
 }
 
 int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
-			    enum wcn36xx_hal_sys_mode mode)
+			    enum wcn36xx_hal_sys_mode mode,
+			    struct ieee80211_vif *vif, u8 channel)
 {
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	struct wcn36xx_hal_finish_scan_req_msg msg_body;
 	int ret;
 
@@ -616,6 +627,14 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FINISH_SCAN_REQ);
 
 	msg_body.mode = mode;
+	if (vif_priv->bss_index != WCN36XX_HAL_BSS_INVALID_IDX) {
+		/* Notify BSSID with null data packet */
+		msg_body.notify = 1;
+		msg_body.frame_type = 2;
+		msg_body.oper_channel = channel;
+		msg_body.scan_entry.bss_index[0] = vif_priv->bss_index;
+		msg_body.scan_entry.active_bss_count = 1;
+	}
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 68c59df..ffe8b0c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -59,11 +59,13 @@ void wcn36xx_smd_close(struct wcn36xx *wcn);
 int wcn36xx_smd_load_nv(struct wcn36xx *wcn);
 int wcn36xx_smd_start(struct wcn36xx *wcn);
 int wcn36xx_smd_stop(struct wcn36xx *wcn);
-int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode);
 int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel);
 int wcn36xx_smd_end_scan(struct wcn36xx *wcn, u8 scan_channel);
-int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
-			    enum wcn36xx_hal_sys_mode mode);
+int wcn36xx_smd_finish_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
+			    struct ieee80211_vif *vif, u8 channel);
+int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
+			  struct ieee80211_vif *vif);
+
 int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn, u8 *channels, size_t channel_count);
 int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			      struct cfg80211_scan_request *req);
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index dcc2ec0..c9cf3db 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -49,15 +49,8 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	fc = __le16_to_cpu(hdr->frame_control);
 	sn = IEEE80211_SEQ_TO_SN(__le16_to_cpu(hdr->seq_ctrl));
 
-	/* When scanning associate beacons to this */
-	if (ieee80211_is_beacon(hdr->frame_control) && wcn->scan_freq) {
-		status.freq = wcn->scan_freq;
-		status.band = wcn->scan_band;
-	} else {
-		status.freq = WCN36XX_CENTER_FREQ(wcn);
-		status.band = WCN36XX_BAND(wcn);
-	}
-
+	status.freq = WCN36XX_CENTER_FREQ(wcn);
+	status.band = WCN36XX_BAND(wcn);
 	status.mactime = 10;
 	status.signal = -get_rssi0(bd);
 	status.antenna = 1;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 2d89849..3221fed 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -223,10 +223,10 @@ struct wcn36xx {
 	spinlock_t		hal_ind_lock;
 	struct list_head	hal_ind_queue;
 
-	struct work_struct	scan_work;
 	struct cfg80211_scan_request *scan_req;
-	int			scan_freq;
-	int			scan_band;
+	bool			sw_scan;
+	u8			sw_scan_opchannel;
+	struct ieee80211_vif	*sw_scan_vif;
 	struct mutex		scan_lock;
 	bool			scan_aborted;
 
-- 
2.7.4

