Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9F7E96E7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjKMHHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjKMHHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FDC7
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:31 -0800 (PST)
X-UUID: 4d19ddb081f311ee8051498923ad61e6-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0HCmua+yxuFFSNPGmmWV8wqLP15fWKKUDACJzzv4Pzk=;
        b=rOQh4TZ250AbNixUR2iA+1dGLb+m+MrQ6aE8UIb9gDM7uONcc5NUe7zk3daiS/dDF9f8cR/hB8agNhZLhbynFTUjbhf1yWnHsGToO9pdm/+rcFYsd/iGn1cvkDo01Dxvho9Itvwssdut1Thcrg83ZXliPhnGntbz4IdW5SElBeA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ca458a95-685a-4cd2-abde-79a5162c411b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:55d45295-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4d19ddb081f311ee8051498923ad61e6-20231113
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1688694455; Mon, 13 Nov 2023 15:07:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:25 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/8] wifi: mt76: mt7996: rework register offsets for mt7992
Date:   Mon, 13 Nov 2023 15:06:15 +0800
Message-ID: <20231113070619.19964-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231113070619.19964-1-shayne.chen@mediatek.com>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Add mt7992_offs to differentiate registers that share the same
definitions with mt7996 chipsets but have differnet offsets.
This is a preliminary patch for mt7992 chipsets support.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 59 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  | 76 +++++++++++++------
 2 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 739d7f53d347..b1119f62c946 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -30,6 +30,58 @@ static const struct __base mt7996_reg_base[] = {
 	[WF_RATE_BASE]		= { { 0x820ee000, 0x820fe000, 0x830ee000 } },
 };
 
+static const u32 mt7996_offs[] = {
+	[MIB_RVSR0]		= 0x720,
+	[MIB_RVSR1]		= 0x724,
+	[MIB_BTSCR5]		= 0x788,
+	[MIB_BTSCR6]		= 0x798,
+	[MIB_RSCR1]		= 0x7ac,
+	[MIB_RSCR27]		= 0x954,
+	[MIB_RSCR28]		= 0x958,
+	[MIB_RSCR29]		= 0x95c,
+	[MIB_RSCR30]		= 0x960,
+	[MIB_RSCR31]		= 0x964,
+	[MIB_RSCR33]		= 0x96c,
+	[MIB_RSCR35]		= 0x974,
+	[MIB_RSCR36]		= 0x978,
+	[MIB_BSCR0]		= 0x9cc,
+	[MIB_BSCR1]		= 0x9d0,
+	[MIB_BSCR2]		= 0x9d4,
+	[MIB_BSCR3]		= 0x9d8,
+	[MIB_BSCR4]		= 0x9dc,
+	[MIB_BSCR5]		= 0x9e0,
+	[MIB_BSCR6]		= 0x9e4,
+	[MIB_BSCR7]		= 0x9e8,
+	[MIB_BSCR17]		= 0xa10,
+	[MIB_TRDR1]		= 0xa28,
+};
+
+static const u32 mt7992_offs[] = {
+	[MIB_RVSR0]		= 0x760,
+	[MIB_RVSR1]		= 0x764,
+	[MIB_BTSCR5]		= 0x7c8,
+	[MIB_BTSCR6]		= 0x7d8,
+	[MIB_RSCR1]		= 0x7f0,
+	[MIB_RSCR27]		= 0x998,
+	[MIB_RSCR28]		= 0x99c,
+	[MIB_RSCR29]		= 0x9a0,
+	[MIB_RSCR30]		= 0x9a4,
+	[MIB_RSCR31]		= 0x9a8,
+	[MIB_RSCR33]		= 0x9b0,
+	[MIB_RSCR35]		= 0x9b8,
+	[MIB_RSCR36]		= 0x9bc,
+	[MIB_BSCR0]		= 0xac8,
+	[MIB_BSCR1]		= 0xacc,
+	[MIB_BSCR2]		= 0xad0,
+	[MIB_BSCR3]		= 0xad4,
+	[MIB_BSCR4]		= 0xad8,
+	[MIB_BSCR5]		= 0xadc,
+	[MIB_BSCR6]		= 0xae0,
+	[MIB_BSCR7]		= 0xae4,
+	[MIB_BSCR17]		= 0xb0c,
+	[MIB_TRDR1]		= 0xb24,
+};
+
 static const struct __map mt7996_reg_map[] = {
 	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
 	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
@@ -382,6 +434,13 @@ static int mt7996_mmio_init(struct mt76_dev *mdev,
 	switch (device_id) {
 	case 0x7990:
 		dev->reg.base = mt7996_reg_base;
+		dev->reg.offs_rev = mt7996_offs;
+		dev->reg.map = mt7996_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
+		break;
+	case 0x7992:
+		dev->reg.base = mt7996_reg_base;
+		dev->reg.offs_rev = mt7992_offs;
 		dev->reg.map = mt7996_reg_map;
 		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 6623a6ba12d6..21637e3aae42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -19,6 +19,7 @@ struct __base {
 /* used to differentiate between generations */
 struct mt7996_reg_desc {
 	const struct __base *base;
+	const u32 *offs_rev;
 	const struct __map *map;
 	u32 map_size;
 };
@@ -39,6 +40,35 @@ enum base_rev {
 
 #define __BASE(_id, _band)			(dev->reg.base[(_id)].band_base[(_band)])
 
+enum offs_rev {
+	MIB_RVSR0,
+	MIB_RVSR1,
+	MIB_BTSCR5,
+	MIB_BTSCR6,
+	MIB_RSCR1,
+	MIB_RSCR27,
+	MIB_RSCR28,
+	MIB_RSCR29,
+	MIB_RSCR30,
+	MIB_RSCR31,
+	MIB_RSCR33,
+	MIB_RSCR35,
+	MIB_RSCR36,
+	MIB_BSCR0,
+	MIB_BSCR1,
+	MIB_BSCR2,
+	MIB_BSCR3,
+	MIB_BSCR4,
+	MIB_BSCR5,
+	MIB_BSCR6,
+	MIB_BSCR7,
+	MIB_BSCR17,
+	MIB_TRDR1,
+	__MT_OFFS_MAX,
+};
+
+#define __OFFS(id)			(dev->reg.offs_rev[(id)])
+
 /* RRO TOP */
 #define MT_RRO_TOP_BASE				0xA000
 #define MT_RRO_TOP(ofs)				(MT_RRO_TOP_BASE + (ofs))
@@ -178,32 +208,32 @@ enum base_rev {
 #define MT_WF_MIB_BASE(_band)			__BASE(WF_MIB_BASE, (_band))
 #define MT_WF_MIB(_band, ofs)			(MT_WF_MIB_BASE(_band) + (ofs))
 
-#define MT_MIB_BSCR0(_band)			MT_WF_MIB(_band, 0x9cc)
-#define MT_MIB_BSCR1(_band)			MT_WF_MIB(_band, 0x9d0)
-#define MT_MIB_BSCR2(_band)			MT_WF_MIB(_band, 0x9d4)
-#define MT_MIB_BSCR3(_band)			MT_WF_MIB(_band, 0x9d8)
-#define MT_MIB_BSCR4(_band)			MT_WF_MIB(_band, 0x9dc)
-#define MT_MIB_BSCR5(_band)			MT_WF_MIB(_band, 0x9e0)
-#define MT_MIB_BSCR6(_band)			MT_WF_MIB(_band, 0x9e4)
-#define MT_MIB_BSCR7(_band)			MT_WF_MIB(_band, 0x9e8)
-#define MT_MIB_BSCR17(_band)			MT_WF_MIB(_band, 0xa10)
+#define MT_MIB_BSCR0(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR0))
+#define MT_MIB_BSCR1(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR1))
+#define MT_MIB_BSCR2(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR2))
+#define MT_MIB_BSCR3(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR3))
+#define MT_MIB_BSCR4(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR4))
+#define MT_MIB_BSCR5(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR5))
+#define MT_MIB_BSCR6(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR6))
+#define MT_MIB_BSCR7(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR7))
+#define MT_MIB_BSCR17(_band)			MT_WF_MIB(_band, __OFFS(MIB_BSCR17))
 
 #define MT_MIB_TSCR5(_band)			MT_WF_MIB(_band, 0x6c4)
 #define MT_MIB_TSCR6(_band)			MT_WF_MIB(_band, 0x6c8)
 #define MT_MIB_TSCR7(_band)			MT_WF_MIB(_band, 0x6d0)
 
-#define MT_MIB_RSCR1(_band)			MT_WF_MIB(_band, 0x7ac)
+#define MT_MIB_RSCR1(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR1))
 /* rx mpdu counter, full 32 bits */
-#define MT_MIB_RSCR31(_band)			MT_WF_MIB(_band, 0x964)
-#define MT_MIB_RSCR33(_band)			MT_WF_MIB(_band, 0x96c)
+#define MT_MIB_RSCR31(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR31))
+#define MT_MIB_RSCR33(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR33))
 
 #define MT_MIB_SDR6(_band)			MT_WF_MIB(_band, 0x020)
 #define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_RVSR0(_band)			MT_WF_MIB(_band, 0x720)
+#define MT_MIB_RVSR0(_band)			MT_WF_MIB(_band, __OFFS(MIB_RVSR0))
 
-#define MT_MIB_RSCR35(_band)			MT_WF_MIB(_band, 0x974)
-#define MT_MIB_RSCR36(_band)			MT_WF_MIB(_band, 0x978)
+#define MT_MIB_RSCR35(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR35))
+#define MT_MIB_RSCR36(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR36))
 
 /* tx ampdu cnt, full 32 bits */
 #define MT_MIB_TSCR0(_band)			MT_WF_MIB(_band, 0x6b0)
@@ -216,16 +246,16 @@ enum base_rev {
 #define MT_MIB_TSCR4(_band)			MT_WF_MIB(_band, 0x6c0)
 
 /* rx ampdu count, 32-bit */
-#define MT_MIB_RSCR27(_band)			MT_WF_MIB(_band, 0x954)
+#define MT_MIB_RSCR27(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR27))
 
 /* rx ampdu bytes count, 32-bit */
-#define MT_MIB_RSCR28(_band)			MT_WF_MIB(_band, 0x958)
+#define MT_MIB_RSCR28(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR28))
 
 /* rx ampdu valid subframe count */
-#define MT_MIB_RSCR29(_band)			MT_WF_MIB(_band, 0x95c)
+#define MT_MIB_RSCR29(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR29))
 
 /* rx ampdu valid subframe bytes count, 32bits */
-#define MT_MIB_RSCR30(_band)			MT_WF_MIB(_band, 0x960)
+#define MT_MIB_RSCR30(_band)			MT_WF_MIB(_band, __OFFS(MIB_RSCR30))
 
 /* remaining windows protected stats */
 #define MT_MIB_SDR27(_band)			MT_WF_MIB(_band, 0x080)
@@ -234,18 +264,18 @@ enum base_rev {
 #define MT_MIB_SDR28(_band)			MT_WF_MIB(_band, 0x084)
 #define MT_MIB_SDR28_TX_RWP_NEED_CNT		GENMASK(15, 0)
 
-#define MT_MIB_RVSR1(_band)			MT_WF_MIB(_band, 0x724)
+#define MT_MIB_RVSR1(_band)			MT_WF_MIB(_band, __OFFS(MIB_RVSR1))
 
 /* rx blockack count, 32 bits */
 #define MT_MIB_TSCR1(_band)			MT_WF_MIB(_band, 0x6b4)
 
 #define MT_MIB_BTSCR0(_band)			MT_WF_MIB(_band, 0x5e0)
-#define MT_MIB_BTSCR5(_band)			MT_WF_MIB(_band, 0x788)
-#define MT_MIB_BTSCR6(_band)			MT_WF_MIB(_band, 0x798)
+#define MT_MIB_BTSCR5(_band)			MT_WF_MIB(_band, __OFFS(MIB_BTSCR5))
+#define MT_MIB_BTSCR6(_band)			MT_WF_MIB(_band, __OFFS(MIB_BTSCR6))
 
 #define MT_MIB_BFTFCR(_band)			MT_WF_MIB(_band, 0x5d0)
 
-#define MT_TX_AGG_CNT(_band, n)			MT_WF_MIB(_band, 0xa28 + ((n) << 2))
+#define MT_TX_AGG_CNT(_band, n)			MT_WF_MIB(_band, __OFFS(MIB_TRDR1) + ((n) << 2))
 #define MT_MIB_ARNG(_band, n)			MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)		(((val) >> ((n) << 4)) & GENMASK(9, 0))
 
-- 
2.39.2

