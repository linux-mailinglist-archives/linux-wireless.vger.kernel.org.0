Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8773C77B4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhGMUS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 16:18:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38884 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230376AbhGMUS5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 16:18:57 -0400
X-UUID: 869872a735d144bba5ed26c3b9fca599-20210714
X-UUID: 869872a735d144bba5ed26c3b9fca599-20210714
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2087119862; Wed, 14 Jul 2021 04:16:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 04:16:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 04:16:02 +0800
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
Subject: [PATCH v3 1/4] mt76: fix mt76_rates for the multiple devices
Date:   Wed, 14 Jul 2021 04:15:58 +0800
Message-ID: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

PHY offset in either .hw_value or .hw_value_short for mt7615, mt7663,
mt7915 and mt7921 device all start at bit 6, not 8.

Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: splitted out from the patch ("mt76: mt7921: fix mgmt frame using unexpected bitrate")
    to cover more devices which have the same issue.
v3: no change.
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 24 +++++++++----------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
 .../net/wireless/mediatek/mt76/mt7603/init.c  | 19 +++++++++++++--
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 16 ++++++-------
 4 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d03aedc3286b..20b2423efc19 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -84,18 +84,18 @@ static const struct ieee80211_tpt_blink mt76_tpt_blink[] = {
 };
 
 struct ieee80211_rate mt76_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
-	OFDM_RATE(11, 60),
-	OFDM_RATE(15, 90),
-	OFDM_RATE(10, 120),
-	OFDM_RATE(14, 180),
-	OFDM_RATE(9,  240),
-	OFDM_RATE(13, 360),
-	OFDM_RATE(8,  480),
-	OFDM_RATE(12, 540),
+	CCK_RATE(0, 10, 6),
+	CCK_RATE(1, 20, 6),
+	CCK_RATE(2, 55, 6),
+	CCK_RATE(3, 110, 6),
+	OFDM_RATE(11, 60, 6),
+	OFDM_RATE(15, 90, 6),
+	OFDM_RATE(10, 120, 6),
+	OFDM_RATE(14, 180, 6),
+	OFDM_RATE(9,  240, 6),
+	OFDM_RATE(13, 360, 6),
+	OFDM_RATE(8,  480, 6),
+	OFDM_RATE(12, 540, 6),
 };
 EXPORT_SYMBOL_GPL(mt76_rates);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 25c5ceef5257..e51ab917296d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -755,17 +755,17 @@ enum mt76_phy_type {
 	MT_PHY_TYPE_HE_MU,
 };
 
-#define CCK_RATE(_idx, _rate) {					\
+#define CCK_RATE(_idx, _rate, _offset) {			\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
+	.hw_value = (MT_PHY_TYPE_CCK << (_offset)) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << (_offset)) | (4 + _idx),	\
 }
 
-#define OFDM_RATE(_idx, _rate) {				\
+#define OFDM_RATE(_idx, _rate, _offset) {			\
 	.bitrate = _rate,					\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
+	.hw_value = (MT_PHY_TYPE_OFDM << (_offset)) | (_idx),	\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << (_offset)) | (_idx), \
 }
 
 extern struct ieee80211_rate mt76_rates[12];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 031d39a48a55..59f684b08c55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -304,6 +304,21 @@ mt7603_init_hardware(struct mt7603_dev *dev)
 	return 0;
 }
 
+static struct ieee80211_rate mt7603_rates[] = {
+	CCK_RATE(0, 10, 8),
+	CCK_RATE(1, 20, 8),
+	CCK_RATE(2, 55, 8),
+	CCK_RATE(3, 110, 8),
+	OFDM_RATE(11, 60, 8),
+	OFDM_RATE(15, 90, 8),
+	OFDM_RATE(10, 120, 8),
+	OFDM_RATE(14, 180, 8),
+	OFDM_RATE(9,  240, 8),
+	OFDM_RATE(13, 360, 8),
+	OFDM_RATE(8,  480, 8),
+	OFDM_RATE(12, 540, 8),
+};
+
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = 1,
@@ -541,8 +556,8 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	wiphy->reg_notifier = mt7603_regd_notifier;
 
-	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
-				   ARRAY_SIZE(mt76_rates));
+	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
+				   ARRAY_SIZE(mt7603_rates));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ccdbab341271..70a62bf16425 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -19,14 +19,14 @@ struct ieee80211_rate mt76x02_rates[] = {
 	MT76x02_CCK_RATE(1, 20),
 	MT76x02_CCK_RATE(2, 55),
 	MT76x02_CCK_RATE(3, 110),
-	OFDM_RATE(0, 60),
-	OFDM_RATE(1, 90),
-	OFDM_RATE(2, 120),
-	OFDM_RATE(3, 180),
-	OFDM_RATE(4, 240),
-	OFDM_RATE(5, 360),
-	OFDM_RATE(6, 480),
-	OFDM_RATE(7, 540),
+	OFDM_RATE(0, 60, 8),
+	OFDM_RATE(1, 90, 8),
+	OFDM_RATE(2, 120, 8),
+	OFDM_RATE(3, 180, 8),
+	OFDM_RATE(4, 240, 8),
+	OFDM_RATE(5, 360, 8),
+	OFDM_RATE(6, 480, 8),
+	OFDM_RATE(7, 540, 8),
 };
 EXPORT_SYMBOL_GPL(mt76x02_rates);
 
-- 
2.25.1

