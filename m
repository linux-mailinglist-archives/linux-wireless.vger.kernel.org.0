Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2E3C62C4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhGLSnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 14:43:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43916 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230477AbhGLSnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 14:43:11 -0400
X-UUID: e6bdb243373b49309f6c8178b9d47241-20210713
X-UUID: e6bdb243373b49309f6c8178b9d47241-20210713
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1582882414; Tue, 13 Jul 2021 02:40:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 02:40:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 02:40:18 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/2] mt76: mt7921: fix mgmt frame using unexpected bitrate
Date:   Tue, 13 Jul 2021 02:40:12 +0800
Message-ID: <197a513340ed939c17e0feb4e2e1040cd46d5eb9.1626114777.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a9586764e6cd94bb91e0a9addf9319bb95dfe4db.1626114777.git.objelf@gmail.com>
References: <a9586764e6cd94bb91e0a9addf9319bb95dfe4db.1626114777.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the current driver mgmt frame is not respecting the basic rates field
provided by the AP and then unconditionally is using the lowest (1 or 6
Mbps) rate.

For example, if the AP only supported basic rate {24, 36, 48, 54} Mbps,
mt7921 cannot send mgmt frame with the rate not in the group. So,
instead, we pick up the lowest basic rate the AP can support to send.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 v2: 1. introduce another patch ("mt76: fix mt76_rates for the multiple devices")
	for those devices which have the same issue.
     2. drop the own mt7921_rates, the unused macro and variable.
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 22 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 --
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7fe2e3a50428..a5cbc567b924 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -749,13 +749,28 @@ static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
 			       FIELD_PREP(MT_TXD5_PID, pid));
 }
 
+static u16
+mt7921_default_basic_rates(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt76_phy *mphy = &dev->mphy;
+	struct ieee80211_rate *rate;
+	int i, offset = 0;
+
+	if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+		offset = 4;
+
+	i = ffs(vif->bss_conf.basic_rates) - 1;
+	rate = &mt76_rates[offset + i];
+
+	return rate->hw_value;
+}
+
 void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_phy *mphy = &dev->mphy;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
@@ -815,10 +830,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			rate = MT7921_5G_RATE_DEFAULT;
-		else
-			rate = MT7921_2G_RATE_DEFAULT;
+		rate = mt7921_default_basic_rates(dev, vif);
 
 		val = MT_TXD6_FIXED_BW |
 		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2d8bd6bfc820..be16d528a923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -38,8 +38,6 @@
 
 #define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
-#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
 #define MT7921_SKU_RATE_NUM		161
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
-- 
2.25.1

