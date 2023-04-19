Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8266E7711
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjDSKCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjDSKCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58845469F
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:18 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isYwCPMa6ROKGAa/ykodg/rXP/XQz4M6UJ99QdSwiwU=;
        b=O8b4/TfZYSSsC2fPyglJ97fJe7n965PTlXyqmX88hXf5udLQXje0zFqJEkOFAaiMphLO1c
        tYqKQuYkgaDvGAASKjAF97qpeFwMxrMnHmOKMa+FnaNARPnmrKG4WuFgi0WUBm9UyBZY0O
        KamUPuxvlPju5xGA4mjtwRL+76pTfMnVK2wfDc+tvfOk2/IbGz7XNFUfCie1TNJeNLuCoG
        LbTNXJarSXa9js3fPkOqtG1wtyAeOCYA7qBR2KjOTjtAe0T2RWWGVU35a/GnF067AJi73S
        X25FNhs9skSZFc2xlqJIBycEwPknetwf31Gt0dS1ntX+x2tfKd7S/wyTuT+l0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isYwCPMa6ROKGAa/ykodg/rXP/XQz4M6UJ99QdSwiwU=;
        b=TwM5jXc9UbzLSRHqWk1yhfjEWlvyudPuQJS1l1pjzm/C9y93vsXaDvJp2tBw/1q/mbgyIf
        HrKj/Vxxmz/CibDA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 15/18] wifi: rtl8xxxu: Remove usage of ieee80211_get_tx_rate()
Date:   Wed, 19 Apr 2023 12:01:42 +0200
Message-Id: <20230419100145.159191-16-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
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
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 27 +++----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index f5b6ff3351e5a..b60f90ea5187b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5180,21 +5180,14 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
@@ -5253,24 +5246,17 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
@@ -5334,22 +5320,15 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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

