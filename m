Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92E20F5F5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgF3NmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbgF3Nl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 09:41:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE1C061755
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:41:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so18864634wmh.4
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FQQJEuVqrAix0cOKR4IXpsosSegOmXSx3SlCBPr9T1I=;
        b=yKu/Q7cEBsoSw6Jwv09ejDFXbSmucyMf2NiM0wAKwvYFcWh31yrsN5RTXZeYiC9lp3
         bS9SqXgnlNJMppQywaMx4E3UMCUqrJA3fk6EW2cBVRzSfrvIuVLMCzAroFurekRvjt58
         56iACt+mCcI3YSEf3XTcGgAWGgH7gs+oyMd3ocl6sP9mkI5CUkTCbZnyoh5gwuzDB/et
         W34w4duwsIdo1tsOZNUxdU+PDRWq3GIyBleAbi4UKGzOdUDjAaqJ7WTCOBNe0hAL1fY7
         +L42pdQDKrxaZpvoY8sNWRCV9pww6eV8c9Ph00S2VTYr0LcKffp+agrKXEzllvNNCR7G
         GR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FQQJEuVqrAix0cOKR4IXpsosSegOmXSx3SlCBPr9T1I=;
        b=kKoOVy1KlqDlhTQGdfRoGVCREKDc82MRr6SCu3gW7P7rQXYTFtTHg47shQkDw6qYM/
         5W9IRrA0dmsIDHLXWJHEeGsqJxh1oMVNb6Py3nzgalr3mRumhlIG32aVSTFYZW7Mejkw
         1gTJZWv42Sbpt8ilCTsgJ9nytcBQatqcrcvayTTZT8FAZWuZyDBAFOnsdGH9/L1GMftx
         ZZQUD8NDTq5ZLhOluCUoE8+qraxZqJt2+Xbmb/5edQDR5/Nhf7OvTf3bdiYfP3CBdwVD
         5sEbCLxmKtDDB/Co5Hrb1Dk+qmgN8mz89Ex7mMZ7jnvY1k2XBMWBd+/sGczTGSYufwhI
         z3MA==
X-Gm-Message-State: AOAM532FiWnnki1KT0lCGcyatSISJetWRheIM9Xhtk/1K9M2NtfrdOKk
        YsSMh5ioRKpAgaYqIpm8LrDvjA==
X-Google-Smtp-Source: ABdhPJzI3ALH8ZVeHTAh/6Yk57YaXIS4crsEPlPG+R3c96ExGUc8g8CHaosJF+UkGG2qqfLHNQ4ykA==
X-Received: by 2002:a1c:1d1:: with SMTP id 200mr21520399wmb.11.1593524515285;
        Tue, 30 Jun 2020 06:41:55 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id l18sm3803411wrm.52.2020.06.30.06.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:41:54 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/4] wcn36xx: Add TX ack support
Date:   Tue, 30 Jun 2020 15:46:59 +0200
Message-Id: <1593524821-32115-2-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The controller is capable of reporting TX indication which can be used
to report TX ack. It was only partially implemented.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c     | 57 ++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/wcn36xx/main.c    |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c     |  4 +--
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 20 +++++++----
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 5 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index bab30f7..6307923 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -334,6 +334,7 @@ void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status)
 	spin_lock_irqsave(&wcn->dxe_lock, flags);
 	skb = wcn->tx_ack_skb;
 	wcn->tx_ack_skb = NULL;
+	del_timer(&wcn->tx_ack_timer);
 	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
 
 	if (!skb) {
@@ -345,6 +346,8 @@ void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status)
 
 	if (status == 1)
 		info->flags |= IEEE80211_TX_STAT_ACK;
+	else
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
 
 	wcn36xx_dbg(WCN36XX_DBG_DXE, "dxe tx ack status: %d\n", status);
 
@@ -352,6 +355,32 @@ void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status)
 	ieee80211_wake_queues(wcn->hw);
 }
 
+static void wcn36xx_dxe_tx_timer(struct timer_list *t)
+{
+	struct wcn36xx *wcn = from_timer(wcn, t, tx_ack_timer);
+	struct ieee80211_tx_info *info;
+	unsigned long flags;
+	struct sk_buff *skb;
+
+	/* TX Timeout */
+	wcn36xx_dbg(WCN36XX_DBG_DXE, "TX timeout\n");
+
+	spin_lock_irqsave(&wcn->dxe_lock, flags);
+	skb = wcn->tx_ack_skb;
+	wcn->tx_ack_skb = NULL;
+	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
+
+	if (!skb)
+		return;
+
+	info = IEEE80211_SKB_CB(skb);
+	info->flags &= ~IEEE80211_TX_STAT_ACK;
+	info->flags &= ~IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+
+	ieee80211_tx_status_irqsafe(wcn->hw, skb);
+	ieee80211_wake_queues(wcn->hw);
+}
+
 static void reap_tx_dxes(struct wcn36xx *wcn, struct wcn36xx_dxe_ch *ch)
 {
 	struct wcn36xx_dxe_ctl *ctl;
@@ -397,6 +426,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, void *dev)
 {
 	struct wcn36xx *wcn = (struct wcn36xx *)dev;
 	int int_src, int_reason;
+	bool transmitted = false;
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_INT_SRC_RAW_REG, &int_src);
 
@@ -434,8 +464,10 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, void *dev)
 			    int_reason);
 
 		if (int_reason & (WCN36XX_CH_STAT_INT_DONE_MASK |
-				  WCN36XX_CH_STAT_INT_ED_MASK))
+				  WCN36XX_CH_STAT_INT_ED_MASK)) {
 			reap_tx_dxes(wcn, &wcn->dxe_tx_h_ch);
+			transmitted = true;
+		}
 	}
 
 	if (int_src & WCN36XX_INT_MASK_CHAN_TX_L) {
@@ -473,9 +505,27 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, void *dev)
 			    int_reason);
 
 		if (int_reason & (WCN36XX_CH_STAT_INT_DONE_MASK |
-				  WCN36XX_CH_STAT_INT_ED_MASK))
+				  WCN36XX_CH_STAT_INT_ED_MASK)) {
 			reap_tx_dxes(wcn, &wcn->dxe_tx_l_ch);
+			transmitted = true;
+		}
+	}
+
+	spin_lock(&wcn->dxe_lock);
+	if (wcn->tx_ack_skb && transmitted) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(wcn->tx_ack_skb);
+
+		/* TX complete, no need to wait for 802.11 ack indication */
+		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS &&
+		    info->flags & IEEE80211_TX_CTL_NO_ACK) {
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+			del_timer(&wcn->tx_ack_timer);
+			ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
+			wcn->tx_ack_skb = NULL;
+			ieee80211_wake_queues(wcn->hw);
+		}
 	}
+	spin_unlock(&wcn->dxe_lock);
 
 	return IRQ_HANDLED;
 }
@@ -916,6 +966,8 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 	if (ret < 0)
 		goto out_err_irq;
 
+	timer_setup(&wcn->tx_ack_timer, wcn36xx_dxe_tx_timer, 0);
+
 	return 0;
 
 out_err_irq:
@@ -934,6 +986,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 {
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
+	del_timer(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index af32bd6..c19648f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1175,6 +1175,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	ieee80211_hw_set(wcn->hw, SIGNAL_DBM);
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
 
 	wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 		BIT(NL80211_IFTYPE_AP) |
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 0ad605f..3fc2d46 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
 	WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
 	WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
-	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
-	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
+	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
+	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
 	WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
 	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
 	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index a690237..274cf58 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -191,9 +191,10 @@ static void wcn36xx_set_tx_data(struct wcn36xx_tx_bd *bd,
 		bd->dpu_sign = __vif_priv->self_ucast_dpu_sign;
 	}
 
-	if (ieee80211_is_nullfunc(hdr->frame_control) ||
-	   (sta_priv && !sta_priv->is_data_encrypted))
+	if (ieee80211_is_any_nullfunc(hdr->frame_control) ||
+	   (sta_priv && !sta_priv->is_data_encrypted)) {
 		bd->dpu_ne = 1;
+	}
 
 	if (bcast) {
 		bd->ub = 1;
@@ -287,9 +288,9 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 
 	bd.dpu_rf = WCN36XX_BMU_WQ_TX;
 
-	bd.tx_comp = !!(info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS);
-	if (bd.tx_comp) {
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
 		wcn36xx_dbg(WCN36XX_DBG_DXE, "TX_ACK status requested\n");
+
 		spin_lock_irqsave(&wcn->dxe_lock, flags);
 		if (wcn->tx_ack_skb) {
 			spin_unlock_irqrestore(&wcn->dxe_lock, flags);
@@ -302,10 +303,15 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 
 		/* Only one at a time is supported by fw. Stop the TX queues
 		 * until the ack status gets back.
-		 *
-		 * TODO: Add watchdog in case FW does not answer
 		 */
 		ieee80211_stop_queues(wcn->hw);
+
+		/* TX watchdog if no TX irq or ack indication received  */
+		mod_timer(&wcn->tx_ack_timer, jiffies + HZ / 10);
+
+		/* Request ack indication from the firmware */
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+			bd.tx_comp = 1;
 	}
 
 	/* Data frames served first*/
@@ -319,7 +325,7 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 	bd.tx_bd_sign = 0xbdbdbdbd;
 
 	ret = wcn36xx_dxe_tx_frame(wcn, vif_priv, &bd, skb, is_low);
-	if (ret && bd.tx_comp) {
+	if (ret && (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)) {
 		/* If the skb has not been transmitted,
 		 * don't keep a reference to it.
 		 */
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index a58f313..2d89849 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -245,6 +245,7 @@ struct wcn36xx {
 	struct wcn36xx_dxe_mem_pool data_mem_pool;
 
 	struct sk_buff		*tx_ack_skb;
+	struct timer_list	tx_ack_timer;
 
 	/* RF module */
 	unsigned		rf_id;
-- 
2.7.4

