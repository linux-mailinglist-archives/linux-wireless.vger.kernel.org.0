Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDC6E770D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjDSKCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjDSKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52541AF2A
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:16 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EL/hQrBU1J3AnBilD9aGI5UduLscs6bMKX/YjQcXFzM=;
        b=XyjTBiPL3JjPTqt06Wx2sFTJJlFYtgVTQLNRfsx9O+HJ/Ot3zUOrxJg5WhxxQkvDtj8Bpi
        MTgWZ/sLjpMPBrvjSzWYfCwhXxARoxl1OOxZANNCUVsVf2s9hzRJkSoN1azrg6DV7OnO48
        zo3dvqTaobYchY4ltnzKYEfsBhCz8BH/YMXt+S/g+t1mzsGGlpP2BLu0Rs+r2A9yIuqcjq
        KywcGPGdt7lzM5HtXbbN4YrJqIt6DkUB1QXkQBHN4ehGPmsihmZwjT/Y+7pxhWFrw/R2uF
        BXLc3OK0zBLpRxn4wQcU39OoDKwzhC9qZVB/pG85zSo1J7id3jyzn/W0bjFUEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EL/hQrBU1J3AnBilD9aGI5UduLscs6bMKX/YjQcXFzM=;
        b=BRy8adwA/u6PWfirFe/2YUEOOhQ00TgD6nGF6//MjPNMK5uahTaunsYW/JrpFU0zYiji7V
        PfgwVQs1p94k/4AA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 11/18] wifi: rtl8xxxu: Put the macid in txdesc
Date:   Wed, 19 Apr 2023 12:01:38 +0200
Message-Id: <20230419100145.159191-12-martin.kaistra@linutronix.de>
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

Add a parameter macid to fill_txdesc(), implement setting it for the
gen2 version.
This is used to tell the HW who the recipient of the packet is, so that
the appropriate data rate can be selected.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  8 +++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 28 +++++++++++++++----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index fb8ba97566c23..88ce369d33808 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1926,7 +1926,7 @@ struct rtl8xxxu_fileops {
 			     struct ieee80211_tx_info *tx_info,
 			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
 			     bool short_preamble, bool ampdu_enable,
-			     u32 rts_rate);
+			     u32 rts_rate, u8 macid);
 	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
 	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, struct rtl8723au_phy_stats *phy_stats);
 	int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
@@ -2060,17 +2060,17 @@ void rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
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
index d0c7d3a191f1a..4a41e1e3cdeaa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3918,6 +3918,18 @@ static void rtl8xxxu_release_macid(struct rtl8xxxu_priv *priv, u8 macid)
 	clear_bit(macid, priv->mac_id_map);
 }
 
+static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
+				    struct ieee80211_sta *sta)
+{
+	struct rtl8xxxu_sta_info *sta_info;
+
+	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION || !sta)
+		return 0;
+
+	sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	return sta_info->macid;
+}
+
 static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5161,7 +5173,8 @@ void
 rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5233,7 +5246,8 @@ void
 rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5257,6 +5271,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
 			 __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
 
+	tx_desc40->txdw1 |= cpu_to_le32(macid << TXDESC40_MACID_SHIFT);
+
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	tx_desc40->txdw4 = cpu_to_le32(rate);
@@ -5308,7 +5324,8 @@ void
 rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			struct ieee80211_tx_info *tx_info,
 			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
-			bool short_preamble, bool ampdu_enable, u32 rts_rate)
+			bool short_preamble, bool ampdu_enable, u32 rts_rate,
+			u8 macid)
 {
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -5407,6 +5424,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	u16 pktlen = skb->len;
 	u16 rate_flag = tx_info->control.rates[0].flags;
 	int tx_desc_size = priv->fops->tx_desc_size;
+	u8 macid;
 	int ret;
 	bool ampdu_enable, sgi = false, short_preamble = false;
 
@@ -5506,9 +5524,9 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	else
 		rts_rate = 0;
 
-
+	macid = rtl8xxxu_get_macid(priv, sta);
 	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
-				ampdu_enable, rts_rate);
+				ampdu_enable, rts_rate, macid);
 
 	rtl8xxxu_calc_tx_desc_csum(tx_desc);
 
-- 
2.30.2

