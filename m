Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520A83A4EEA
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFLMpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 08:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhFLMpI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 08:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9835A61287;
        Sat, 12 Jun 2021 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623501789;
        bh=lt4C8nGFs3CpkI5JtS/RSQOW5Rg8bNc7FP1rB2r0/YI=;
        h=From:To:Cc:Subject:Date:From;
        b=fVEOtzhbJ3UtxpUWOdXoFfSL1Trg7+PbRDWHTYG/sjME6Rh2vpuiPWs3RHSsRMIGb
         Qe9FR1z5hiVzLU/4zvh8gn8vM3ZprN6BbPbi0TR9l7rrmHb6qYJXpXq4NX+KEryxlK
         wiO6t6SASY/qtAFEvdch0jFrJqL9mE/tC4VkQhgCzeoBRhfvoCpmM9YGOquf0PFWAN
         Ka38YGQRuSmAxPsWCDNH+t70OEK4USTrV7wm/JrIox6CAa1aJdJMmtdg8D4Cfi4BCb
         Z9+LROxh9vfbBI7KvEMk3JJ5oBK/1SBtKmUL/o2pzlvIpThkQF8Y/uAhQTm9LX7H33
         8p7XXzluI2olA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: improve code readability for mt7921_update_txs
Date:   Sat, 12 Jun 2021 14:43:03 +0200
Message-Id: <a2e7a0fb19f3842de99014b6d7284cdcfd46730b.1623501708.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7921_update_txs routine in order to improve code readability
for tx timestamp parsing/configuration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 47 +++++++------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index fb4de73df701..4a120b77e6c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -13,26 +13,6 @@
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
 
-unsigned long
-mt7921_next_txs_set(struct mt7921_dev *dev, struct mt76_wcid *wcid,
-		    u32 timeout)
-{
-	struct mt7921_sta *msta;
-
-	msta = container_of(wcid, struct mt7921_sta, wcid);
-	msta->next_txs_ts = jiffies + msecs_to_jiffies(timeout);
-	return msta->next_txs_ts;
-}
-
-bool
-mt7921_next_txs_timeout(struct mt7921_dev *dev, struct mt76_wcid *wcid)
-{
-	struct mt7921_sta *msta;
-
-	msta = container_of(wcid, struct mt7921_sta, wcid);
-	return time_is_before_jiffies(msta->next_txs_ts);
-}
-
 static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 					    u16 idx, bool unicast)
 {
@@ -739,6 +719,23 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 	txwi[7] |= cpu_to_le32(val);
 }
 
+static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
+{
+	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
+	u32 pid, frame_type = FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]);
+
+	if (!(frame_type & (IEEE80211_FTYPE_DATA >> 2)))
+		return;
+
+	if (time_is_after_eq_jiffies(msta->next_txs_ts))
+		return;
+
+	msta->next_txs_ts = jiffies + msecs_to_jiffies(250);
+	pid = mt76_get_next_pkt_id(wcid);
+	txwi[5] |= cpu_to_le32(MT_TXD5_TX_STATUS_MCU |
+			       FIELD_PREP(MT_TXD5_PID, pid));
+}
+
 void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon)
@@ -816,15 +813,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 
-	if ((FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]) &
-		(IEEE80211_FTYPE_DATA >> 2)) &&
-		mt7921_next_txs_timeout(dev, wcid)) {
-		u8 pid = mt76_get_next_pkt_id(wcid);
-
-		mt7921_next_txs_set(dev, wcid, 250);
-		val = MT_TXD5_TX_STATUS_MCU | FIELD_PREP(MT_TXD5_PID, pid);
-		txwi[5] |= cpu_to_le32(val);
-	}
+	mt7921_update_txs(wcid, txwi);
 }
 
 static void
-- 
2.31.1

