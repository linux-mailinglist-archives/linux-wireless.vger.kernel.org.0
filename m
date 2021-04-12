Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2835B9E3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhDLFk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 01:40:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55412 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229581AbhDLFk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 01:40:57 -0400
X-UUID: f61b0618225044268ea27c21d35cfd5a-20210412
X-UUID: f61b0618225044268ea27c21d35cfd5a-20210412
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 526371402; Mon, 12 Apr 2021 13:40:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 13:40:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 13:40:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7915: fix rate setting of tx descriptor in testmode
Date:   Mon, 12 Apr 2021 13:39:54 +0800
Message-ID: <20210412053954.23544-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210412053954.23544-1-shayne.chen@mediatek.com>
References: <20210412053954.23544-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix ofdm rate index and ldpc setting in rate setting field of tx
descriptor.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3f3bfea..f99c269 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -661,19 +661,18 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 {
 #ifdef CONFIG_NL80211_TESTMODE
 	struct mt76_testmode_data *td = &phy->mt76->test;
+	const struct ieee80211_rate *r;
+	u8 bw, mode, nss = td->tx_rate_nss;
 	u8 rate_idx = td->tx_rate_idx;
-	u8 nss = td->tx_rate_nss;
-	u8 bw, mode;
 	u16 rateval = 0;
 	u32 val;
+	bool cck = false;
+	int band;
 
 	if (skb != phy->mt76->test.tx_skb)
 		return;
 
 	switch (td->tx_rate_mode) {
-	case MT76_TM_TX_MODE_CCK:
-		mode = MT_PHY_TYPE_CCK;
-		break;
 	case MT76_TM_TX_MODE_HT:
 		nss = 1 + (rate_idx >> 3);
 		mode = MT_PHY_TYPE_HT;
@@ -693,7 +692,20 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 	case MT76_TM_TX_MODE_HE_MU:
 		mode = MT_PHY_TYPE_HE_MU;
 		break;
+	case MT76_TM_TX_MODE_CCK:
+		cck = true;
+		fallthrough;
 	case MT76_TM_TX_MODE_OFDM:
+		band = phy->mt76->chandef.chan->band;
+		if (band == NL80211_BAND_2GHZ && !cck)
+			rate_idx += 4;
+
+		r = &phy->mt76->hw->wiphy->bands[band]->bitrates[rate_idx];
+		val = cck ? r->hw_value_short : r->hw_value;
+
+		mode = val >> 8;
+		rate_idx = val & 0xff;
+		break;
 	default:
 		mode = MT_PHY_TYPE_OFDM;
 		break;
@@ -748,9 +760,10 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 	if (mode >= MT_PHY_TYPE_HE_SU)
 		val |= FIELD_PREP(MT_TXD6_HELTF, td->tx_ltf);
 
-	if (td->tx_rate_ldpc || bw > 0)
+	if (td->tx_rate_ldpc || (bw > 0 && mode >= MT_PHY_TYPE_HE_SU))
 		val |= MT_TXD6_LDPC;
 
+	txwi[3] &= ~cpu_to_le32(MT_TXD3_SN_VALID);
 	txwi[6] |= cpu_to_le32(val);
 	txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
 					  phy->test.spe_idx));
-- 
2.18.0

