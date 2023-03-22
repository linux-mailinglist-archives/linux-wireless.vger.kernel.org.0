Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971606C524D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCVRUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVRUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5A64878
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:20:05 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rEFuip4v1d188Bjjcxe0IQxzOTKr9KSDLiru8530+s=;
        b=hj0bETAcoVfQrbaS12GeDo6hCRx30aUXmcZqedWETN6EPa3RjB91UA3+7U74HeVqdgb4On
        3wULmCaaXBP03qy6c3+cb9irSTDu/ZWSAe0IdVQrke1+Gc4wt1jTEIIbHlC40rWA9f2cRF
        wYJeWd+XEwitsg1IPoRKkM5mpFyO76R/oj05mbAG1oQO8RlTifWnkAV2zeSW/fXF05ukBo
        1PjKstvGw1xpdojKZiNxgo+VvVxMqfa5gFivMIUV+GZhUc0A9W+CcP/EEY00iQ8atCPDhp
        VqcKlsrR53RWHITqm3XfcXenqlf9LQFP/3yBSfXvDaPiNR709ztuE+2ZBieAcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rEFuip4v1d188Bjjcxe0IQxzOTKr9KSDLiru8530+s=;
        b=jAnuGGMbPDkl8Pi04B4ur+slRkCe+Stw1a+oohyy3heFToxOk18+gy6/BBWTzZcG0gCPex
        CPk95uFwod6fP5DQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 11/14] wifi: rtl8xxxu: Put the macid in txdesc
Date:   Wed, 22 Mar 2023 18:19:02 +0100
Message-Id: <20230322171905.492855-12-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a parameter macid to fill_txdesc(), implement setting it for the
gen2 version.
This is used to tell the HW who the recipient of the packet is, so that
the appropriate data rate can be selected.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  8 ++++----
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index e78e0bbd23354..20304b0bd68a3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1917,7 +1917,7 @@ struct rtl8xxxu_fileops {
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
-			     u32 rts_rate);
+			     u32 rts_rate, u8 macid);
 	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
 	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, struct rtl8723au_phy_stats *phy_stats);
 	int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
@@ -2046,17 +2046,17 @@ void rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
-			     u32 rts_rate);
+			     u32 rts_rate, u8 macid);
 void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
-			     u32 rts_rate);
+			     u32 rts_rate, u8 macid);
 void rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
-			     u32 rts_rate);
+			     u32 rts_rate, u8 macid);
 void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
 			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
 void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d74a3c6452507..c232de1d47173 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5152,7 +5152,8 @@ void
 rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5224,7 +5225,8 @@ void
 rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5248,6 +5250,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
 			 __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
 
+	tx_desc40->txdw1 |= cpu_to_le32(macid << TXDESC40_MACID_SHIFT);
+
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	tx_desc40->txdw4 = cpu_to_le32(rate);
@@ -5299,7 +5303,8 @@ void
 rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5398,6 +5403,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	u16 pktlen = skb->len;
 	u16 rate_flag = tx_info->control.rates[0].flags;
 	int tx_desc_size = priv->fops->tx_desc_size;
+	u8 macid = 0;
 	int ret;
 	bool ampdu_enable, sgi = false, short_preamble = false;
 
@@ -5497,9 +5503,11 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	else
 		rts_rate = 0;
 
+	if (vif->type == NL80211_IFTYPE_AP && sta)
+		macid = sta->aid + 1;
 
 	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
-				ampdu_enable, rts_rate);
+				ampdu_enable, rts_rate, macid);
 
 	rtl8xxxu_calc_tx_desc_csum(tx_desc);
 
-- 
2.30.2

