Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBDC404C78
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhIIL5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 07:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245516AbhIILzF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 07:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36AC613B5;
        Thu,  9 Sep 2021 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631187906;
        bh=GOI0nxE8w2Eym8ed3E1suqYbAwtANJs4mkix9EPI6fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lafob8CSrs1EI3YY0dQpLdG44PveSu11IjYrdKEdFd2j2JmOt5M0UsqEYx0hsZNbL
         JRDdYTatfBvoucbTmm3FFCz2RUGzUMypPHK+zMYkErOCuTR19LiRKjJbvXNtnILqRD
         k/lM3wgrUlpRBL7hxNv5Hr3UK0cDKFJOv5VEAadjscpendfp14FAwEPanFkSHLY+Bi
         FcpDItbH1xKoYnL7BfA19v2qZvMdYMOTsPfYawSzcfqZEFyec1vd8vs+cmr44ipoZG
         e90jeufX0B/Nw408/vAKlMsy1xSS0NTuacdR44zLkY8SylfDyWdoRqR9Xu2Bv6FFkQ
         Qb7RKu3eXbFfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Chiu <chris.chiu@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 184/252] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
Date:   Thu,  9 Sep 2021 07:39:58 -0400
Message-Id: <20210909114106.141462-184-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

[ Upstream commit 95a581ab3592082c60a08090aabe09ac7d0bd650 ]

The TX A-MPDU aggregation is not handled in the driver since the
ieee80211_start_tx_ba_session has never been started properly.
Start and stop the TX BA session by tracking the TX aggregation
status of each TID. Fix the ampdu_action and the tx descriptor
accordingly with the given TID.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20210804151325.86600-1-chris.chiu@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.30.2

