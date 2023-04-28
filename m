Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59566F1B2A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjD1PJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbjD1PIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E986270C
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM9Ne/BJXvqFSmUSdYC1YSLRWLYqtdDWcH2FcfL/mL4=;
        b=WFtena35lWSa20Pn5JqE8eQ+Cg4E28WrEmnEP9BjxvEimqvy06CvGdm7e6tDcspk76MZnF
        NaI6MUjBsMLvjCF5B/rqtNBSlGA29Ai1Z5zcnj/H3j1meHdbkdWLgPCHyxtB8EG+mCWTnl
        ypzM1r1m4OgCs54r9XxUIyVqz/8dz7tyUW1daAeDl25Y27WQGHCQonzlD+85ORWmhj1/43
        SPYO6tGcJpCW2Mw0oy6k4OqqtkvOdLjxN0e38KTmRg4b8HKKceIiFtHZbxCTeTcumX5ADU
        c3JFhRPFi3z+9JLcie24TJaOgo7HzMrxD8A8jnCO3JwzdwH8WRS/UC2Z5gK9tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM9Ne/BJXvqFSmUSdYC1YSLRWLYqtdDWcH2FcfL/mL4=;
        b=9B9fiY/QmOWn59evwY62j4tmqgJuh6qotDqhBfTK7jPC5AS1LVawZ/j/+M9NLhWQXXdn0g
        PQfZPFmC0sosTmCg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 16/18] wifi: rtl8xxxu: Remove usage of tx_info->control.rates[0].flags
Date:   Fri, 28 Apr 2023 17:08:31 +0200
Message-Id: <20230428150833.218605-17-martin.kaistra@linutronix.de>
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

As this driver uses HAS_RATE_CONTROL, rate_flags will not be provided by
mac80211.

Stop using tx_info->control.rates[0].flags and ieee80211_get_rts_cts_rate()
and use rts_threshold and bss_conf.use_cts_prot instead to determine
when to use RTS and CTS.

Send RTS with 24M rate like the vendor drivers. Also set this RTS rate
for ampdu_enable = true, because we also enable RTS for these frames.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a2cc9177fba49..aa430a912d822 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5255,7 +5255,6 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
@@ -5296,10 +5295,10 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
 	tx_desc->txdw4 |= cpu_to_le32(rts_rate << TXDESC32_RTS_RATE_SHIFT);
-	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
+	if (ampdu_enable || tx_info->control.use_rts) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_RTS_CTS_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
-	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
+	} else if (tx_info->control.use_cts_prot) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_CTS_SELF_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
 	}
@@ -5322,7 +5321,6 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	tx_desc40 = (struct rtl8xxxu_txdesc40 *)tx_desc32;
@@ -5363,13 +5361,14 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		tx_desc40->txdw5 |= cpu_to_le32(TXDESC40_SHORT_PREAMBLE);
 
 	tx_desc40->txdw4 |= cpu_to_le32(rts_rate << TXDESC40_RTS_RATE_SHIFT);
+
 	/*
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
-	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
+	if (ampdu_enable || tx_info->control.use_rts) {
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_RTS_CTS_ENABLE);
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_HW_RTS_ENABLE);
-	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
+	} else if (tx_info->control.use_cts_prot) {
 		/*
 		 * For some reason the vendor driver doesn't set
 		 * TXDESC40_HW_RTS_ENABLE for CTS to SELF
@@ -5396,7 +5395,6 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
@@ -5451,10 +5449,10 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
 	tx_desc->txdw4 |= cpu_to_le32(rts_rate << TXDESC32_RTS_RATE_SHIFT);
-	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
+	if (ampdu_enable || tx_info->control.use_rts) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_RTS_CTS_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
-	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
+	} else if (tx_info->control.use_cts_prot) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_CTS_SELF_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
 	}
@@ -5478,7 +5476,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	struct device *dev = &priv->udev->dev;
 	u32 queue, rts_rate;
 	u16 pktlen = skb->len;
-	u16 rate_flag = tx_info->control.rates[0].flags;
 	int tx_desc_size = priv->fops->tx_desc_size;
 	u8 macid;
 	int ret;
@@ -5563,20 +5560,23 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (rate_flag & IEEE80211_TX_RC_SHORT_GI ||
-	    (ieee80211_is_data_qos(hdr->frame_control) &&
-	     sta && sta->deflink.ht_cap.cap &
-	     (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20)))
+	if (ieee80211_is_data_qos(hdr->frame_control) &&
+	    sta && sta->deflink.ht_cap.cap &
+	    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
 		sgi = true;
 
-	if (rate_flag & IEEE80211_TX_RC_USE_SHORT_PREAMBLE ||
-	    (sta && vif && vif->bss_conf.use_short_preamble))
+	if (sta && vif && vif->bss_conf.use_short_preamble)
 		short_preamble = true;
 
-	if (rate_flag & IEEE80211_TX_RC_USE_RTS_CTS)
-		rts_rate = ieee80211_get_rts_cts_rate(hw, tx_info)->hw_value;
-	else if (rate_flag & IEEE80211_TX_RC_USE_CTS_PROTECT)
-		rts_rate = ieee80211_get_rts_cts_rate(hw, tx_info)->hw_value;
+	if (skb->len > hw->wiphy->rts_threshold)
+		tx_info->control.use_rts = true;
+
+	if (sta && vif && vif->bss_conf.use_cts_prot)
+		tx_info->control.use_cts_prot = true;
+
+	if (ampdu_enable || tx_info->control.use_rts ||
+	    tx_info->control.use_cts_prot)
+		rts_rate = DESC_RATE_24M;
 	else
 		rts_rate = 0;
 
-- 
2.30.2

