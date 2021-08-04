Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F419F3E03F4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhHDPNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 11:13:52 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:58698
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237114AbhHDPNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 11:13:51 -0400
Received: from localhost.localdomain (111-240-142-2.dynamic-ip.hinet.net [111.240.142.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C3D1E3F0FC;
        Wed,  4 Aug 2021 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628090018;
        bh=2gLssv6zfXEbS3M1XEEg2CclWAXeqhmsLnOeaUBQ4dw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Rq9p9eYkWFrpXHPeddwWgMU2pwPLCvrvEWC3LAER+1QJbA6Q1cT2MkiHfS8s8sd83
         pnStAIY3TQgINh0IS8bJy5PSAK6n5NZ7jF8N9YZ8eWc0EhTPgw2biULxU7gQGds63A
         0EUXqZ6DgWw4ky+2Sc6k18PkrwgFWgI/P+S1J+Ww2WOOx6yUurOri5UViC+6MMn3vy
         6+wcyRhcCSJgPFe8jzqwXKQTR4m5esXT8qfIoKOZ/QOHdsNyq7j22aVX5bLumQ0Fal
         VfWXz7ADN81Pz9eXmBOcv/V/qzqhSkwcw4OLevZuwpi6ydSjITFeZ4bcGhuJVQMtso
         DEv07sn4I7jAA==
From:   chris.chiu@canonical.com
To:     jes.sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
Date:   Wed,  4 Aug 2021 23:13:25 +0800
Message-Id: <20210804151325.86600-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

The TX A-MPDU aggregation is not handled in the driver since the
ieee80211_start_tx_ba_session has never been started properly.
Start and stop the TX BA session by tracking the TX aggregation
status of each TID. Fix the ampdu_action and the tx descriptor
accordingly with the given TID.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

Changelog:
  v2:
   - use data type BITMAP for tx_aggr_started instead of bool array

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 ++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 33 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 01735776345a..7ddce3c3f0c4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1378,6 +1378,8 @@ struct rtl8xxxu_priv {
 	u8 no_pape:1;
 	u8 int_buf[USB_INTR_CONTENT_LENGTH];
 	u8 rssi_level;
+	DECLARE_BITMAP(tx_aggr_started, IEEE80211_NUM_TIDS);
+	DECLARE_BITMAP(tid_tx_operational, IEEE80211_NUM_TIDS);
 	/*
 	 * Only one virtual interface permitted because only STA mode
 	 * is supported and no iface_combinations are provided.
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ac1061caacd6..3285a91efb91 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4805,6 +4805,8 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
+	u8 *qc = ieee80211_get_qos_ctl(hdr);
+	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate;
 	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
@@ -4828,7 +4830,7 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 
 	tx_desc->txdw3 = cpu_to_le32((u32)seq_number << TXDESC32_SEQ_SHIFT);
 
-	if (ampdu_enable)
+	if (ampdu_enable && test_bit(tid, priv->tid_tx_operational))
 		tx_desc->txdw1 |= cpu_to_le32(TXDESC32_AGG_ENABLE);
 	else
 		tx_desc->txdw1 |= cpu_to_le32(TXDESC32_AGG_BREAK);
@@ -4876,6 +4878,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct rtl8xxxu_txdesc40 *tx_desc40;
+	u8 *qc = ieee80211_get_qos_ctl(hdr);
+	u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate;
 	u16 rate_flags = tx_info->control.rates[0].flags;
 	u16 seq_number;
@@ -4902,7 +4906,7 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 
 	tx_desc40->txdw9 = cpu_to_le32((u32)seq_number << TXDESC40_SEQ_SHIFT);
 
-	if (ampdu_enable)
+	if (ampdu_enable && test_bit(tid, priv->tid_tx_operational))
 		tx_desc40->txdw2 |= cpu_to_le32(TXDESC40_AGG_ENABLE);
 	else
 		tx_desc40->txdw2 |= cpu_to_le32(TXDESC40_AGG_BREAK);
@@ -5015,12 +5019,19 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	if (ieee80211_is_data_qos(hdr->frame_control) && sta) {
 		if (sta->ht_cap.ht_supported) {
 			u32 ampdu, val32;
+			u8 *qc = ieee80211_get_qos_ctl(hdr);
+			u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 
 			ampdu = (u32)sta->ht_cap.ampdu_density;
 			val32 = ampdu << TXDESC_AMPDU_DENSITY_SHIFT;
 			tx_desc->txdw2 |= cpu_to_le32(val32);
 
 			ampdu_enable = true;
+
+			if (!test_bit(tid, priv->tx_aggr_started) &&
+			    !(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+				if (!ieee80211_start_tx_ba_session(sta, tid, 0))
+					set_bit(tid, priv->tx_aggr_started);
 		}
 	}
 
@@ -6096,6 +6107,7 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct device *dev = &priv->udev->dev;
 	u8 ampdu_factor, ampdu_density;
 	struct ieee80211_sta *sta = params->sta;
+	u16 tid = params->tid;
 	enum ieee80211_ampdu_mlme_action action = params->action;
 
 	switch (action) {
@@ -6108,17 +6120,20 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		dev_dbg(dev,
 			"Changed HT: ampdu_factor %02x, ampdu_density %02x\n",
 			ampdu_factor, ampdu_density);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
-		dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP_FLUSH\n", __func__);
-		rtl8xxxu_set_ampdu_factor(priv, 0);
-		rtl8xxxu_set_ampdu_min_space(priv, 0);
-		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP_FLUSH_CONT\n",
-			 __func__);
+		dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP\n", __func__);
 		rtl8xxxu_set_ampdu_factor(priv, 0);
 		rtl8xxxu_set_ampdu_min_space(priv, 0);
+		clear_bit(tid, priv->tx_aggr_started);
+		clear_bit(tid, priv->tid_tx_operational);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_OPERATIONAL\n", __func__);
+		set_bit(tid, priv->tid_tx_operational);
 		break;
 	case IEEE80211_AMPDU_RX_START:
 		dev_dbg(dev, "%s: IEEE80211_AMPDU_RX_START\n", __func__);
-- 
2.20.1

