Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB322C2E9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgGXKPh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgGXKPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 06:15:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F807C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so2708727wrs.8
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+NZI24h/qHWQCCjOsGwSFpRmwVY2/CMFNAa9dHrpy8=;
        b=XdU8POTSeQgLtDBvoZfg4w10dwv9rmhKNZ6PqYGg2YxkYHPZIbOby8BuSPJiUUGULy
         ErEm9KK3Wvs/KzoN6RbYISwJ3+GcjfLyDBVaXrozQkosVjscAy1x+QPiWIfsaZ8/C+JP
         KVpUN1Tk936CMOgR0xKyifpY5HFD079s9ltxz4x6Toim8YE1A3KHUzEs02XfuuigoWvv
         aj5p+WpainC5ghaLhrs68TuvfhfTIC5TV5ouSL0sYe1wpPIqSVAfQxA7O5idcreE2t84
         8ZFqceq2bE4aqO9qAuL08RFYzyK0yYYyeg42mb+oDva5Pu6cqtDHyYizbFvEvCeqEDmH
         gPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+NZI24h/qHWQCCjOsGwSFpRmwVY2/CMFNAa9dHrpy8=;
        b=RYp3zM6cyhjxMCDMUHx7nbLgWD3uE7m17DkzsgqTopoux1E67EMph35XtuKVxT4gD+
         Ui0McboaIe575VA+P92I95lT9/LeljIy7RoLkh3uEhafJDUZwzgqq1vIO2sXDZCcxGQO
         d4ip7zv8vVzKDGEBVy8Yl/kEiP0MVqewobymmHFkVsv8kYI6a88SnErS1wsUt8tkb2Mk
         3Vah/Dyx3zSEXXfZulz1hRN07Q/VS2hWV92l35VAGMtrRTyTMiTDudGLti75FSMrbcfl
         jpyj/26t/OOQ6KvlzL6wFtOzwa481w0z/8iAdtQNIxEy9ZM3SgmYJyADiVS/TLdtl20D
         jkmQ==
X-Gm-Message-State: AOAM530ujwoiVjBZZhRn+MKSmYIljsTUgg4k31ndqG91tssazislfbkL
        RMhO+F120YYzSfQFz1zFMT/p5ldyZSg=
X-Google-Smtp-Source: ABdhPJxwTkW6f+NYsx6erXGd6f2jNXoai52lmLMUbjQbZ5tFoZU/FUHBmnQlun8KbVS1EQn31Ng3Sg==
X-Received: by 2002:a5d:69d2:: with SMTP id s18mr7836815wrw.408.1595585735025;
        Fri, 24 Jul 2020 03:15:35 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id d18sm774714wrj.8.2020.07.24.03.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:15:34 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 5/6] wcn36xx: Fix software-driven scan
Date:   Fri, 24 Jul 2020 12:20:51 +0200
Message-Id: <1595586052-16081-6-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For software-driven scan, rely on mac80211 software scan instead
of internal driver implementation. The internal implementation
cause connection trouble since it keep the antenna busy during
the entire scan duration, moreover it's only a passive scanning
(no probe request). Therefore, let mac80211 manages sw scan.

Note: we fallback to software scan if firmware does not report
scan offload support or if we need to scan the 5Ghz band (currently
not supported by the offload scan...).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 161 +++++++++++++++--------------
 drivers/net/wireless/ath/wcn36xx/smd.c     |  23 ++++-
 drivers/net/wireless/ath/wcn36xx/smd.h     |   8 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c    |  11 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   6 +-
 5 files changed, 116 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c19648f..0f6ebc7 100644
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
@@ -392,24 +415,29 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
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
+			 * simply stop the scan session and exit PS mode.
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
@@ -614,55 +642,26 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -674,12 +673,6 @@ static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_unlock(&wcn->scan_lock);
 
-	if (!get_feat_caps(wcn->fw_feat_caps, SCAN_OFFLOAD)) {
-		/* legacy manual/sw scan */
-		schedule_work(&wcn->scan_work);
-		return 0;
-	}
-
 	return wcn36xx_smd_start_hw_scan(wcn, vif, &hw_req->req);
 }
 
@@ -696,16 +689,32 @@ static void wcn36xx_cancel_hw_scan(struct ieee80211_hw *hw,
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
@@ -1151,6 +1160,8 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.set_key		= wcn36xx_set_key,
 	.hw_scan		= wcn36xx_hw_scan,
 	.cancel_hw_scan		= wcn36xx_cancel_hw_scan,
+	.sw_scan_start		= wcn36xx_sw_scan_start,
+	.sw_scan_complete	= wcn36xx_sw_scan_complete,
 	.bss_info_changed	= wcn36xx_bss_info_changed,
 	.set_rts_threshold	= wcn36xx_set_rts_threshold,
 	.sta_add		= wcn36xx_sta_add,
@@ -1329,8 +1340,6 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}
 
-	INIT_WORK(&wcn->scan_work, wcn36xx_hw_scan_worker);
-
 	wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
 	if (IS_ERR(wcn->smd_channel)) {
 		wcn36xx_err("failed to open WLAN_CTRL channel\n");
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 908cc6c..218f702 100644
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

