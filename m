Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62D6F1B28
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbjD1PJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346292AbjD1PIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4103AAC
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNZqeiSuoZTWfQZrQecCzZuOcm7D0BfWnngMawY/Rok=;
        b=dwogQ2x1aW/u+DLKa22csR9hkuYrpFmoHTx7gg83t+g7mNAgVmQcN3kLLf3EgeNm7kvXX9
        ktUjkMj8BAOCdPgf2wUw1vLXSEZQW50TEjLYu138lpkfA/ci7oSdMHN/2GclZcJ7ErgP71
        30eiS8/0MUr9ODKEZSZ2AAumaPa9Dn+4e9/HmevAmHQxsnjsgdU4mH6jU02gUbfWdLu8hc
        5JgZHZgcKeaZixZe/FG1KAV5JDspRjcQaD9Z8ZIk7bccLZwr+sUC1qLStH9x4ApNtSdgZF
        Hl30JpkeW7vhUQYdSSji+LVKjibjyuA9IhfwMSO11uLTTOpzZCsS0INWZ7NRPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNZqeiSuoZTWfQZrQecCzZuOcm7D0BfWnngMawY/Rok=;
        b=5VBnEsk0INTbOBbFOxIA5SluFCLA0ASQHOjwNjzKNFCn7G7zrJh/2mtiOgnJtaM2WHuCvH
        xdpqDjxPywGgvhBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 15/18] wifi: rtl8xxxu: Remove usage of ieee80211_get_tx_rate()
Date:   Fri, 28 Apr 2023 17:08:30 +0200
Message-Id: <20230428150833.218605-16-martin.kaistra@linutronix.de>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As this driver uses HAS_RATE_CONTROL, tx_rates will not be provided by
mac80211.

For some frames c->control.rates[0].idx is negative, which means
ieee80211_get_tx_rate() will print a warning and return NULL.

Only management frames have USE_DRIVER_RATE set, so for all others the
rate info of txdesc is ignored anyway.

Remove call to ieee80211_get_tx_rate() and send management frames with
1M (rate info = 0).

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 27 +++----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9e9d172a37f1e..a2cc9177fba49 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5250,21 +5250,14 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			bool short_preamble, bool ampdu_enable, u32 rts_rate,
 			u8 macid)
 {
-	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
-	u32 rate;
+	u32 rate = 0;
 	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
-	if (rate_flags & IEEE80211_TX_RC_MCS &&
-	    !ieee80211_is_mgmt(hdr->frame_control))
-		rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
-	else
-		rate = tx_rate->hw_value;
-
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
 		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
 			 __func__, rate, le16_to_cpu(tx_desc->pkt_size));
@@ -5323,24 +5316,17 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			bool short_preamble, bool ampdu_enable, u32 rts_rate,
 			u8 macid)
 {
-	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct rtl8xxxu_txdesc40 *tx_desc40;
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
-	u32 rate;
+	u32 rate = 0;
 	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	tx_desc40 = (struct rtl8xxxu_txdesc40 *)tx_desc32;
 
-	if (rate_flags & IEEE80211_TX_RC_MCS &&
-	    !ieee80211_is_mgmt(hdr->frame_control))
-		rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
-	else
-		rate = tx_rate->hw_value;
-
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
 		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
 			 __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
@@ -5404,22 +5390,15 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			bool short_preamble, bool ampdu_enable, u32 rts_rate,
 			u8 macid)
 {
-	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
-	u32 rate;
+	u32 rate = 0;
 	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
-	if (rate_flags & IEEE80211_TX_RC_MCS &&
-	    !ieee80211_is_mgmt(hdr->frame_control))
-		rate = tx_info->control.rates[0].idx + DESC_RATE_MCS0;
-	else
-		rate = tx_rate->hw_value;
-
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	if (ieee80211_is_data(hdr->frame_control)) {
-- 
2.30.2

