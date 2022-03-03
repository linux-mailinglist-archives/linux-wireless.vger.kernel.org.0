Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2614CBC21
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiCCLHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 06:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCCLHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 06:07:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785F17C422
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 03:07:06 -0800 (PST)
X-UUID: 633e1467999f4817912af847f6e30a9d-20220303
X-UUID: 633e1467999f4817912af847f6e30a9d-20220303
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 869205311; Thu, 03 Mar 2022 19:07:00 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Mar 2022 19:06:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 19:06:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 19:06:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: fix beamforming mib stats
Date:   Thu, 3 Mar 2022 19:05:34 +0800
Message-ID: <20220303110535.30640-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220303110535.30640-1-shayne.chen@mediatek.com>
References: <20220303110535.30640-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of beamforming mib counters are moved to different offsets
or registers in newer chipsets.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 73 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 28 +++++--
 3 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index aecf7eb..2fc884c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2189,15 +2189,6 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_SDR31(phy->band_idx));
 	mib->rx_ba_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
-	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
-
-	if (is_mt7915(&dev->mt76))
-		cnt = mt76_rr(dev, MT_MIB_SDR33(phy->band_idx));
-	mib->tx_pkt_ibf_cnt += is_mt7915(&dev->mt76) ?
-		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK, cnt) :
-		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK_MT7916, cnt);
-
 	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(phy->band_idx));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
@@ -2210,24 +2201,10 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_DR11(phy->band_idx));
 	mib->tx_su_acked_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(phy->band_idx));
-	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
-	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
-
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(phy->band_idx));
-	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
-	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
-	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
-	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
-
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(phy->band_idx));
-	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
-	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
-	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
-
-	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(phy->band_idx));
-	mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
-	mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
+	cnt = mt76_rr(dev, MT_ETBF_PAR_RPT0(phy->band_idx));
+	mib->tx_bf_rx_fb_bw += FIELD_GET(MT_ETBF_PAR_RPT0_FB_BW, cnt);
+	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_PAR_RPT0_FB_NC, cnt);
+	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_PAR_RPT0_FB_NR, cnt);
 
 	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
 		cnt = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
@@ -2256,6 +2233,26 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 			dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
 			dev->mt76.aggr_stats[aggr1++] += val >> 16;
 		}
+
+		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
+		mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
+
+		cnt = mt76_rr(dev, MT_MIB_SDR33(phy->band_idx));
+		mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT, cnt);
+
+		cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(phy->band_idx));
+		mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
+		mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
+
+		cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(phy->band_idx));
+		mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
+		mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
+
+		cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(phy->band_idx));
+		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
+		mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
+		mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
+		mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
 	} else {
 		for (i = 0; i < 2; i++) {
 			/* rts count */
@@ -2284,6 +2281,28 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
 			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
 		}
+
+		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
+		mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT, cnt);
+		mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT, cnt);
+		mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
+		mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
+
+		cnt = mt76_rr(dev, MT_MIB_BFCR7(phy->band_idx));
+		mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_MIB_BFCR7_BFEE_TX_FB_CPL, cnt);
+
+		cnt = mt76_rr(dev, MT_MIB_BFCR2(phy->band_idx));
+		mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_MIB_BFCR2_BFEE_TX_FB_TRIG, cnt);
+
+		cnt = mt76_rr(dev, MT_MIB_BFCR0(phy->band_idx));
+		mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_VHT, cnt);
+		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_VHT, cnt);
+		mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_HT, cnt);
+		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_HT, cnt);
+
+		cnt = mt76_rr(dev, MT_MIB_BFCR1(phy->band_idx));
+		mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_MIB_BFCR1_RX_FB_HE, cnt);
+		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR1_RX_FB_HE, cnt);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 1b14bba..5062e0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -122,6 +122,7 @@ static const u32 mt7915_offs[] = {
 	[PLE_PG_HIF_GROUP]	= 0x110,
 	[PLE_HIF_PG_INFO]	= 0x114,
 	[AC_OFFSET]		= 0x040,
+	[ETBF_PAR_RPT0]		= 0x068,
 };
 
 static const u32 mt7916_offs[] = {
@@ -194,6 +195,7 @@ static const u32 mt7916_offs[] = {
 	[PLE_PG_HIF_GROUP]	= 0x00c,
 	[PLE_HIF_PG_INFO]	= 0x388,
 	[AC_OFFSET]		= 0x080,
+	[ETBF_PAR_RPT0]		= 0x100,
 };
 
 static const struct __map mt7915_reg_map[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 8fe24ab..e5f93c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -103,6 +103,7 @@ enum offs_rev {
 	PLE_PG_HIF_GROUP,
 	PLE_HIF_PG_INFO,
 	AC_OFFSET,
+	ETBF_PAR_RPT0,
 	__MT_OFFS_MAX,
 };
 
@@ -223,10 +224,10 @@ enum offs_rev {
 #define MT_ETBF_TX_FB_CPL		GENMASK(31, 16)
 #define MT_ETBF_TX_FB_TRI		GENMASK(15, 0)
 
-#define MT_ETBF_RX_FB_CONT(_band)	MT_WF_ETBF(_band, 0x068)
-#define MT_ETBF_RX_FB_BW		GENMASK(7, 6)
-#define MT_ETBF_RX_FB_NC		GENMASK(5, 3)
-#define MT_ETBF_RX_FB_NR		GENMASK(2, 0)
+#define MT_ETBF_PAR_RPT0(_band)		MT_WF_ETBF(_band, __OFFS(ETBF_PAR_RPT0))
+#define MT_ETBF_PAR_RPT0_FB_BW		GENMASK(7, 6)
+#define MT_ETBF_PAR_RPT0_FB_NC		GENMASK(5, 3)
+#define MT_ETBF_PAR_RPT0_FB_NR		GENMASK(2, 0)
 
 #define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x0f0)
 #define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
@@ -367,11 +368,11 @@ enum offs_rev {
 #define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR31))
 
 #define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR32))
-#define MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR32_TX_PKT_EBF_CNT	GENMASK(15, 0)
+#define MT_MIB_SDR32_TX_PKT_IBF_CNT	GENMASK(31, 16)
 
 #define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x088)
-#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
-#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK_MT7916	GENMASK(31, 16)
+#define MT_MIB_SDR33_TX_PKT_IBF_CNT	GENMASK(15, 0)
 
 #define MT_MIB_SDRMUBF(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDRMUBF))
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
@@ -401,6 +402,19 @@ enum offs_rev {
 						  ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
+#define MT_MIB_BFCR0(_band)		MT_WF_MIB(_band, 0x7b0)
+#define MT_MIB_BFCR0_RX_FB_HT		GENMASK(15, 0)
+#define MT_MIB_BFCR0_RX_FB_VHT		GENMASK(31, 16)
+
+#define MT_MIB_BFCR1(_band)		MT_WF_MIB(_band, 0x7b4)
+#define MT_MIB_BFCR1_RX_FB_HE		GENMASK(15, 0)
+
+#define MT_MIB_BFCR2(_band)		MT_WF_MIB(_band, 0x7b8)
+#define MT_MIB_BFCR2_BFEE_TX_FB_TRIG	GENMASK(15, 0)
+
+#define MT_MIB_BFCR7(_band)		MT_WF_MIB(_band, 0x7cc)
+#define MT_MIB_BFCR7_BFEE_TX_FB_CPL	GENMASK(15, 0)
+
 /* WTBLON TOP */
 #define MT_WTBLON_TOP_BASE		0x820d4000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
-- 
2.25.1

