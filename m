Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5943334F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJSKPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhJSKPa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D4961374;
        Tue, 19 Oct 2021 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638397;
        bh=UtyRD+YgDOBURt12u6jiTenbZBbgK4PPniul/n7gnH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpJ3HKWuu9Hgm1UFqB0YUeyQb6z1XOZABaEi7wgSt0JR2gM/RbapWTIZhBZBwi6rv
         +g8nac6wAjZen9Xfrz/stP5eM0tjd0eA8AKb9r7M26I+aT8WWObYregowRFj/ZNvRO
         ixbta4R1k/kCYzEhZltL3HuERQAXjbkuq9secAgA47cvWQjDV6wAOuqrsSlge4GffV
         18rhICQ9U7NJhrDv12kCJFG0IDExLrx6okTXa2rGOYphPQmORaIc9l9ATN7aOwo/be
         nnaKwEpC4qlzrGhT69PiCDKisjgGVebgYg/UvQgfxFPJZDGYZFI5JJabjkRziV6NUs
         fwCkw3GJ0D0lA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 08/10] mt76: mt7921: add sta stats accounting in mt7921_mac_add_txs_skb
Date:   Tue, 19 Oct 2021 12:12:30 +0200
Message-Id: <5c3f18c8325f75e900c6a0ab3c0bcbc79cea936f.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add ethtool stats to mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 17 +++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h  |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8a5b92b1e055..d45c54f92b9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -951,14 +951,16 @@ static bool
 mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 		       __le32 *txs_data)
 {
+	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
+	struct mt76_sta_stats *stats = &msta->stats;
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_tx_info *info;
 	struct rate_info rate = {};
 	struct sk_buff_head list;
+	u32 txrate, txs, mode;
 	struct sk_buff *skb;
 	bool cck = false;
-	u32 txrate, txs;
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
@@ -984,7 +986,13 @@ mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
 	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
 
-	switch (FIELD_GET(MT_TX_RATE_MODE, txrate)) {
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
 	case MT_PHY_TYPE_CCK:
 		cck = true;
 		fallthrough;
@@ -1027,19 +1035,24 @@ mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 	default:
 		goto out;
 	}
+	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
 		break;
 	case IEEE80211_STA_RX_BW_80:
 		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
 		break;
 	default:
 		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
 		break;
 	}
 	wcid->rate = rate;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 86c741569a9b..9347859a291c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -104,6 +104,7 @@ struct mt7921_sta {
 
 	unsigned long last_txs;
 	unsigned long ampdu_state;
+	struct mt76_sta_stats stats;
 
 	struct mt7921_sta_key_conf bip;
 };
-- 
2.31.1

