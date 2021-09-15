Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357C040BD2D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhIOB0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:26:47 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:51734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhIOB0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:26:47 -0400
X-UUID: b276f7e25bf4407ea644c7e593cf9075-20210914
X-UUID: b276f7e25bf4407ea644c7e593cf9075-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1847978925; Tue, 14 Sep 2021 18:25:25 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:34 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:34 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 10/16] mt76: mt7921: use physical addr to unify register access
Date:   Wed, 15 Sep 2021 09:14:43 +0800
Message-ID: <856edf387e8e7f444d0eaf95ffac0616571146d1.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use physical address to unify the register access and reorder the
entries in fixed_map table to accelerate the address lookup for
MT7921e.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 19 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 22 +++++++++----------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index be24241fb8e6..f31c4aef8b27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -85,6 +85,14 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
 		u32 mapped;
 		u32 size;
 	} fixed_map[] = {
+		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
 		{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
 		{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure register) */
 		{ 0x40000000, 0x70000, 0x10000}, /* WF_UMAC_SYSRAM */
@@ -99,22 +107,15 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
 		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
 		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
 		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
 		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
 		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
 		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
 		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
 		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
 		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
 		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
 		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
 		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
 		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 26fb11823762..cb6069024320 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -14,7 +14,7 @@
 #define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
 #define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
 
-#define MT_PLE_BASE			0x8000
+#define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
 #define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
@@ -26,7 +26,7 @@
 					       ((n) << 2))
 #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
 
-#define MT_MDP_BASE			0xf000
+#define MT_MDP_BASE			0x820cd000
 #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
 
 #define MT_MDP_DCR0			MT_MDP(0x000)
@@ -49,7 +49,7 @@
 #define MT_MDP_TO_WM			1
 
 /* TMAC: band 0(0x21000), band 1(0xa1000) */
-#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
 #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
 
 #define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
@@ -74,7 +74,7 @@
 #define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
 #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
 
-#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
 #define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
 
 #define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
@@ -82,7 +82,7 @@
 #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
 
 /* LPON: band 0(0x24200), band 1(0xa4200) */
-#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
 #define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
 
 #define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
@@ -93,7 +93,7 @@
 #define MT_LPON_TCR_SW_WRITE		BIT(0)
 
 /* MIB: band 0(0x24800), band 1(0xa4800) */
-#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
 #define MT_MIB_SCR1(_band)		MT_WF_MIB(_band, 0x004)
@@ -142,7 +142,7 @@
 #define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
-#define MT_WTBLON_TOP_BASE		0x34000
+#define MT_WTBLON_TOP_BASE		0x820d4000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
 #define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
@@ -152,7 +152,7 @@
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
 
-#define MT_WTBL_BASE			0x38000
+#define MT_WTBL_BASE			0x820d8000
 #define MT_WTBL_LMAC_ID			GENMASK(14, 8)
 #define MT_WTBL_LMAC_DW			GENMASK(7, 2)
 #define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
@@ -160,7 +160,7 @@
 					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
 
 /* AGG: band 0(0x20800), band 1(0xa0800) */
-#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
 #define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
 
 #define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
@@ -191,7 +191,7 @@
 #define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
 
 /* ARB: band 0(0x20c00), band 1(0xa0c00) */
-#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
 #define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
 
 #define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
@@ -201,7 +201,7 @@
 #define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
 
 /* RMAC: band 0(0x21400), band 1(0xa1400) */
-#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
 #define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
 
 #define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
-- 
2.25.1

