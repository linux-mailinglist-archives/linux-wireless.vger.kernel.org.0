Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9276F0324
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjD0JK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243394AbjD0JJ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB401A6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:54 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZUE+fZMfCgtQCa0QYvotX6fC2cZWTl7a++qVDuVO/U=;
        b=vzOR3/JlhiQAob9MJQqHz82037I6P2rcHw8DvKRpDo6idM+7Iw/ERLDQgev9WOgibpM2Ae
        tC6NkFAPUztae2KQ9gw3rzR7pNF6EjUxZK6c2IMyyVwZQ1a9fJwImKYbfQL2r6OdXLcUVp
        1XS3/pCzteboQQ51NMibwQ0vzaWW0YBxSKvTM+HAZheLqim6RMs/Q4slzoSRxNkvM343PY
        JCvDMIuDxHcFW/XO9kpm1w8vUQEigni1zIWrmAViFXwaTOHD6WBabtPQR4VKhpXqoLVb+f
        Fhdq/nLdgneu+Uq2ftwCN3UbzRo36HCOviSEhAYadepNlLr0wkr02c0P7+EtFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZUE+fZMfCgtQCa0QYvotX6fC2cZWTl7a++qVDuVO/U=;
        b=zbqzPGJYMuZ3KNh+Y3y+lQ5JlXOvZq0uif7EcCN9T1rmy6magAl2NJzThrgkz6ArnWL3NT
        6Fz4ka6RYuV9cgCg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 16/18] wifi: rtl8xxxu: Remove usage of tx_info->control.rates[0].flags
Date:   Thu, 27 Apr 2023 11:09:20 +0200
Message-Id: <20230427090922.165088-17-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index c8a6d5fce23cf..a2343df78e920 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5254,7 +5254,6 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
@@ -5295,10 +5294,10 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
@@ -5321,7 +5320,6 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	tx_desc40 = (struct rtl8xxxu_txdesc40 *)tx_desc32;
@@ -5362,13 +5360,14 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
@@ -5395,7 +5394,6 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	u8 *qc = ieee80211_get_qos_ctl(hdr);
 	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate = 0;
-	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
 
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
@@ -5450,10 +5448,10 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
@@ -5477,7 +5475,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	struct device *dev = &priv->udev->dev;
 	u32 queue, rts_rate;
 	u16 pktlen = skb->len;
-	u16 rate_flag = tx_info->control.rates[0].flags;
 	int tx_desc_size = priv->fops->tx_desc_size;
 	u8 macid;
 	int ret;
@@ -5562,20 +5559,23 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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

