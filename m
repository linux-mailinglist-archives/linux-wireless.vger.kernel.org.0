Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471F7D3B1A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjJWPmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWPmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C75FF
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:07 -0700 (PDT)
X-UUID: b415755471ba11ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=stmi25xuVDzWXRhvXZrk+UdqX0tsHpkAhcr5H2PGC9A=;
        b=dEwdPB8uMJDn5h3Q18ySuA68j8ESzD0FBZyunXnuWB0iU6Kz7seSQmwubHnJCyPegkCDFY1Y1O64jc6NgClHFgosFHKZys6n4m4IheZopn/rPlJUZQCIrcOyqy9TMfMJur9YzyPH1rMajDrTwnlNHQIJa61LihJxWwRHUPPulxA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d6dbcb06-c00f-4f8a-a7ac-dd0e44cf11ca,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:c495abfb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b415755471ba11ee8051498923ad61e6-20231023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2037309528; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 07/11] wifi: mt76: mt7996: adjust WFDMA settings to improve performance
Date:   Mon, 23 Oct 2023 23:38:50 +0800
Message-ID: <20231023153854.10708-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Refactor and update dma prefetch parts and also split band 1 traffic to
PCIe 1 to enhance throughput.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 70 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  9 +++
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 373cc84893d6..3514f395a017 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -99,38 +99,49 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 	MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7996_TXQ_FWDL);
 }
 
+static u32 __mt7996_dma_prefetch_base(u16 *base, u8 depth)
+{
+	u32 ret = *base << 16 | depth;
+
+	*base = *base + (depth << 4);
+
+	return ret;
+}
+
 static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 {
-#define PREFETCH(_base, _depth)	((_base) << 16 | (_depth))
+	u16 base = 0;
+
+#define PREFETCH(_depth)	(__mt7996_dma_prefetch_base(&base, (_depth)))
 	/* prefetch SRAM wrapping boundary for tx/rx ring. */
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x0, 0x2));
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x20, 0x2));
-	mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x40, 0x4));
-	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0x80, 0x4));
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0xc0, 0x2));
-	mt76_wr(dev, MT_TXQ_EXT_CTRL(2) + ofs, PREFETCH(0xe0, 0x4));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x120, 0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x140, 0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x160, 0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2_WA) + ofs, PREFETCH(0x180, 0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x1a0, 0x10));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2) + ofs, PREFETCH(0x2a0, 0x10));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x8));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0x8));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(2) + ofs, PREFETCH(0x8));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2_WA) + ofs, PREFETCH(0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x10));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2) + ofs, PREFETCH(0x10));
 
 	if (dev->has_rro) {
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND0) + ofs,
-			PREFETCH(0x3a0, 0x10));
+			PREFETCH(0x10));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND2) + ofs,
-			PREFETCH(0x4a0, 0x10));
+			PREFETCH(0x10));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND0) + ofs,
-			PREFETCH(0x5a0, 0x4));
+			PREFETCH(0x4));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND1) + ofs,
-			PREFETCH(0x5e0, 0x4));
+			PREFETCH(0x4));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND2) + ofs,
-			PREFETCH(0x620, 0x4));
+			PREFETCH(0x4));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND0) + ofs,
-			PREFETCH(0x660, 0x4));
+			PREFETCH(0x4));
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND2) + ofs,
-			PREFETCH(0x6a0, 0x4));
+			PREFETCH(0x4));
 	}
 #undef PREFETCH
 
@@ -295,6 +306,12 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT1,
 		 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
 
+	/* WFDMA rx threshold */
+	mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_45_TH, 0xc000c);
+	mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_67_TH, 0x10008);
+	mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_89_TH, 0x10008);
+	mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_RRO_TH, 0x20);
+
 	if (dev->hif2) {
 		/* GLO_CFG_EXT0 */
 		mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
@@ -306,7 +323,18 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 			 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
 
 		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
-			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
+			 MT_WFDMA_HOST_CONFIG_PDMA_BAND |
+			 MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
+
+		/* AXI read outstanding number */
+		mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL,
+			 MT_WFDMA_AXI_R2A_CTRL_OUTSTAND_MASK, 0x14);
+
+		/* WFDMA rx threshold */
+		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_45_TH + hif1_ofs, 0xc000c);
+		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_67_TH + hif1_ofs, 0x10008);
+		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_89_TH + hif1_ofs, 0x10008);
+		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_RRO_TH + hif1_ofs, 0x20);
 	}
 
 	if (dev->hif2) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index e9edba830aff..6102df912741 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -379,6 +379,11 @@ enum base_rev {
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO		BIT(27)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 
+#define MT_WFDMA0_PAUSE_RX_Q_45_TH		MT_WFDMA0(0x268)
+#define MT_WFDMA0_PAUSE_RX_Q_67_TH		MT_WFDMA0(0x26c)
+#define MT_WFDMA0_PAUSE_RX_Q_89_TH		MT_WFDMA0(0x270)
+#define MT_WFDMA0_PAUSE_RX_Q_RRO_TH		MT_WFDMA0(0x27c)
+
 #define WF_WFDMA0_GLO_CFG_EXT0			MT_WFDMA0(0x2b0)
 #define WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD	BIT(18)
 #define WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE	BIT(14)
@@ -401,10 +406,14 @@ enum base_rev {
 
 #define MT_WFDMA_HOST_CONFIG			MT_WFDMA_EXT_CSR(0x30)
 #define MT_WFDMA_HOST_CONFIG_PDMA_BAND		BIT(0)
+#define MT_WFDMA_HOST_CONFIG_BAND2_PCIE1	BIT(22)
 
 #define MT_WFDMA_EXT_CSR_HIF_MISC		MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY		BIT(0)
 
+#define MT_WFDMA_AXI_R2A_CTRL			MT_WFDMA_EXT_CSR(0x500)
+#define MT_WFDMA_AXI_R2A_CTRL_OUTSTAND_MASK	GENMASK(4, 0)
+
 #define MT_PCIE_RECOG_ID			0xd7090
 #define MT_PCIE_RECOG_ID_MASK			GENMASK(30, 0)
 #define MT_PCIE_RECOG_ID_SEM			BIT(31)
-- 
2.39.2

