Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405B4AD203
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 08:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiBHHQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 02:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiBHHQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 02:16:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D63C0401EF
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 23:16:30 -0800 (PST)
X-UUID: 29509e581f8c4e67a53b4cd68c94f363-20220208
X-UUID: 29509e581f8c4e67a53b4cd68c94f363-20220208
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1092626711; Tue, 08 Feb 2022 15:16:27 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 8 Feb 2022 15:16:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Feb
 2022 15:16:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 8 Feb 2022 15:16:22 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: Fix channel state update error issue
Date:   Tue, 8 Feb 2022 15:16:15 +0800
Message-ID: <41371866a1ad861988303f043ff21016a4ef0a01.1644304381.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Fix channel state update error issue due to wrong
register access for mt7916.

Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 15 +++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 11 ++++++++---
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3c38031..b693868 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1845,12 +1845,17 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy)
 {
-	mt76_set(dev, MT_WF_PHY_RXTD12(ext_phy),
+	u32 reg;
+
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RXTD12(ext_phy) :
+		MT_WF_PHY_RXTD12_MT7916(ext_phy);
+	mt76_set(dev, reg,
 		 MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY |
 		 MT_WF_PHY_RXTD12_IRPI_SW_CLR);
 
-	mt76_set(dev, MT_WF_PHY_RX_CTRL1(ext_phy),
-		 FIELD_PREP(MT_WF_PHY_RX_CTRL1_IPI_EN, 0x5));
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RX_CTRL1(ext_phy) :
+		MT_WF_PHY_RX_CTRL1_MT7916(ext_phy);
+	mt76_set(dev, reg, FIELD_PREP(MT_WF_PHY_RX_CTRL1_IPI_EN, 0x5));
 }
 
 static u8
@@ -1862,7 +1867,9 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 	int nss, i;
 
 	for (nss = 0; nss < hweight8(phy->mt76->chainmask); nss++) {
-		u32 reg = MT_WF_IRPI(nss + (idx << dev->dbdc_support));
+		u32 reg = is_mt7915(&dev->mt76) ?
+			MT_WF_IRPI_NSS(0, nss + (idx << dev->dbdc_support)) :
+			MT_WF_IRPI_NSS_MT7916(idx, nss);
 
 		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
 			val = mt76_rr(dev, reg);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 94837ed..94f9ac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3079,7 +3079,7 @@ int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 	if (ret)
 		return ret;
 
-	res = (struct mt7915_mcu_mib *)(skb->data + 20);
+	res = (struct mt7915_mcu_mib *)(skb->data);
 
 	if (chan_switch)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 6a0f681..e380fd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -761,18 +761,23 @@ enum offs_rev {
 #define MT_WF_PP_TOP_RXQ_WFDMA_CF_5	MT_WF_PP_TOP(0x0e8)
 #define MT_WF_PP_TOP_RXQ_QID6_WFDMA_HIF_SEL_MASK	BIT(6)
 
-#define MT_WF_IRPI_BASE			0x83006000
-#define MT_WF_IRPI(ofs)			(MT_WF_IRPI_BASE + ((ofs) << 16))
+#define MT_WF_IRPI_BASE			0x83000000
+#define MT_WF_IRPI(ofs)			(MT_WF_IRPI_BASE + (ofs))
 
-/* PHY: band 0(0x83080000), band 1(0x83090000) */
+#define MT_WF_IRPI_NSS(phy, nss)	MT_WF_IRPI(0x6000 + ((phy) << 20) + ((nss) << 16))
+#define MT_WF_IRPI_NSS_MT7916(phy, nss)	MT_WF_IRPI(0x1000 + ((phy) << 20) + ((nss) << 16))
+
+/* PHY */
 #define MT_WF_PHY_BASE			0x83080000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
 #define MT_WF_PHY_RX_CTRL1(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 16))
+#define MT_WF_PHY_RX_CTRL1_MT7916(_phy)	MT_WF_PHY(0x2004 + ((_phy) << 20))
 #define MT_WF_PHY_RX_CTRL1_IPI_EN	GENMASK(2, 0)
 #define MT_WF_PHY_RX_CTRL1_STSCNT_EN	GENMASK(11, 9)
 
 #define MT_WF_PHY_RXTD12(_phy)		MT_WF_PHY(0x8230 + ((_phy) << 16))
+#define MT_WF_PHY_RXTD12_MT7916(_phy)	MT_WF_PHY(0x8230 + ((_phy) << 20))
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
-- 
2.18.0

