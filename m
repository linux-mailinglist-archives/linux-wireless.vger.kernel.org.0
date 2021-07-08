Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CA3BF4C0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 06:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGHEb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 00:31:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41958 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229482AbhGHEb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 00:31:56 -0400
X-UUID: 1a4875dc8a244ec7a676a107f5ed1763-20210708
X-UUID: 1a4875dc8a244ec7a676a107f5ed1763-20210708
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2084035200; Thu, 08 Jul 2021 12:29:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Jul 2021 12:29:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Jul 2021 12:29:08 +0800
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
Subject: [PATCH 1/2] mt76: mt7921: fix mgmt frame using unexpected bitrate
Date:   Thu, 8 Jul 2021 12:29:05 +0800
Message-ID: <1625718546-14969-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
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

The patch also fixed up the hw_value in ieee80211_rate for MT7921
hardware.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 19 +++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 21 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 14 +++++++++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index a9ce10b98827..ee57f268c29c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -24,6 +24,21 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
+struct ieee80211_rate mt7921_rates[] = {
+	MT7921_CCK_RATE(0, 10),
+	MT7921_CCK_RATE(1, 20),
+	MT7921_CCK_RATE(2, 55),
+	MT7921_CCK_RATE(3, 110),
+	MT7921_OFDM_RATE(11, 60),
+	MT7921_OFDM_RATE(15, 90),
+	MT7921_OFDM_RATE(10, 120),
+	MT7921_OFDM_RATE(14, 180),
+	MT7921_OFDM_RATE(9,  240),
+	MT7921_OFDM_RATE(13, 360),
+	MT7921_OFDM_RATE(8,  480),
+	MT7921_OFDM_RATE(12, 540),
+};
+
 static void
 mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
@@ -227,8 +242,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7921_set_stream_he_caps(&dev->phy);
 
-	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
-				   ARRAY_SIZE(mt76_rates));
+	ret = mt76_register_device(&dev->mt76, true, mt7921_rates,
+				   ARRAY_SIZE(mt7921_rates));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7fe2e3a50428..76985a6b3be5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -749,6 +749,22 @@ static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
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
+	rate = &mt7921_rates[offset + i];
+
+	return rate->hw_value;
+}
+
 void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon)
@@ -815,10 +831,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
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
index 2d8bd6bfc820..6ef69f5e8f42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -45,6 +45,19 @@
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
+#define MT7921_CCK_RATE(_idx, _rate) {				\
+	.bitrate = _rate,					\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
+	.hw_value = (MT_PHY_TYPE_CCK << 6) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 6) | (4 + _idx),	\
+}
+
+#define MT7921_OFDM_RATE(_idx, _rate) {				\
+	.bitrate = _rate,					\
+	.hw_value = (MT_PHY_TYPE_OFDM << 6) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 6) | (_idx),	\
+}
+
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
@@ -241,6 +254,7 @@ static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
 
 extern const struct ieee80211_ops mt7921_ops;
 extern struct pci_driver mt7921_pci_driver;
+extern struct ieee80211_rate mt7921_rates[12];
 
 u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
 
-- 
2.25.1

