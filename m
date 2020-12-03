Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B32CD4A3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgLCLdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 06:33:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54762 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgLCLdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 06:33:05 -0500
X-UUID: f504ff3665d7482b807e00ce5fd13013-20201203
X-UUID: f504ff3665d7482b807e00ce5fd13013-20201203
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1947520699; Thu, 03 Dec 2020 19:32:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Dec 2020 19:32:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Dec 2020 19:32:15 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix "defined but not used" compiler warning
Date:   Thu, 3 Dec 2020 19:32:10 +0800
Message-ID: <20201203113210.16354-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If CONFIG_NL80211_TESTMODE is not set, the following compiler warning
appears:

warning: 'mt7915_mac_tx_rate_val' defined but not used [-Wunused-function]

Since mt7915_mac_tx_rate_val() is only used by
mt7915_mac_write_txwi_tm(), merge them to get rid of this warning.

Fixes: 3ac860a ("mt76: mt7915: implement testmode tx support")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 68 ++++++++-----------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d93d5ba..21005be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -600,51 +600,16 @@ void mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 }
 #endif
 
-static u16
-mt7915_mac_tx_rate_val(struct mt76_phy *mphy, u8 mode, u8 rate_idx,
-		       u8 nss, u8 stbc, u8 *bw)
-{
-	u16 rateval = 0;
-
-	switch (mphy->chandef.width) {
-	case NL80211_CHAN_WIDTH_40:
-		*bw = 1;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		*bw = 2;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_160:
-		*bw = 3;
-		break;
-	default:
-		*bw = 0;
-		break;
-	}
-
-	if (mode == MT_PHY_TYPE_HT || mode == MT_PHY_TYPE_HT_GF)
-		nss = 1 + (rate_idx >> 3);
-
-	if (stbc && nss == 1) {
-		nss++;
-		rateval |= MT_TX_RATE_STBC;
-	}
-
-	rateval |= FIELD_PREP(MT_TX_RATE_IDX, rate_idx) |
-		   FIELD_PREP(MT_TX_RATE_MODE, mode) |
-		   FIELD_PREP(MT_TX_RATE_NSS, nss - 1);
-
-	return rateval;
-}
-
 static void
 mt7915_mac_write_txwi_tm(struct mt7915_dev *dev, struct mt76_phy *mphy,
 			 __le32 *txwi, struct sk_buff *skb)
 {
 #ifdef CONFIG_NL80211_TESTMODE
 	struct mt76_testmode_data *td = &dev->mt76.test;
+	u8 rate_idx = td->tx_rate_idx;
+	u8 nss = td->tx_rate_nss;
 	u8 bw, mode;
-	u16 rateval;
+	u16 rateval = 0;
 	u32 val;
 
 	if (skb != dev->mt76.test.tx_skb)
@@ -655,6 +620,7 @@ mt7915_mac_write_txwi_tm(struct mt7915_dev *dev, struct mt76_phy *mphy,
 		mode = MT_PHY_TYPE_CCK;
 		break;
 	case MT76_TM_TX_MODE_HT:
+		nss = 1 + (rate_idx >> 3);
 		mode = MT_PHY_TYPE_HT;
 		break;
 	case MT76_TM_TX_MODE_VHT:
@@ -678,8 +644,30 @@ mt7915_mac_write_txwi_tm(struct mt7915_dev *dev, struct mt76_phy *mphy,
 		break;
 	}
 
-	rateval = mt7915_mac_tx_rate_val(mphy, mode, td->tx_rate_idx,
-					 td->tx_rate_nss, td->tx_rate_stbc, &bw);
+	switch (mphy->chandef.width) {
+	case NL80211_CHAN_WIDTH_40:
+		bw = 1;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		bw = 2;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		bw = 3;
+		break;
+	default:
+		bw = 0;
+		break;
+	}
+
+	if (td->tx_rate_stbc && nss == 1) {
+		nss++;
+		rateval |= MT_TX_RATE_STBC;
+	}
+
+	rateval |= FIELD_PREP(MT_TX_RATE_IDX, rate_idx) |
+		   FIELD_PREP(MT_TX_RATE_MODE, mode) |
+		   FIELD_PREP(MT_TX_RATE_NSS, nss - 1);
 
 	txwi[2] |= cpu_to_le32(MT_TXD2_FIX_RATE);
 
-- 
2.17.1

