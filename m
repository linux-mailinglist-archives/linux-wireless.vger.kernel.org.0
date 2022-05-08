Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFE51EBE9
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 07:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiEHF3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 01:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiEHF2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 01:28:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA5658F
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 22:25:01 -0700 (PDT)
X-UUID: bde6419bb1484ba7a6f7d9b1013e2b57-20220508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:766b8ed6-3049-4957-8e30-62a91c3341e6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:1a909916-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: bde6419bb1484ba7a6f7d9b1013e2b57-20220508
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 766018376; Sun, 08 May 2022 13:24:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 8 May 2022 13:24:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 May 2022 13:24:56 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7915: add more statistics from fw_util debugfs knobs
Date:   Sun, 8 May 2022 13:24:54 +0800
Message-ID: <b3957480ad74444b7170f3f9f124bd043e1a0ce8.1651983999.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <210119c0737d72aa049c113dac48e22a4d84d689.1651983999.git.ryder.lee@mediatek.com>
References: <210119c0737d72aa049c113dac48e22a4d84d689.1651983999.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Print out exception state and program counters of WA/WM MCUs.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   | 14 ++++++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 656f3ffccf4b..6edbbce92926 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -597,6 +597,12 @@ mt7915_fw_util_wm_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
+	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WM_MCU_PC));
+	seq_printf(file, "Exception state: 0x%x\n",
+		   is_mt7915(&dev->mt76) ?
+		   mt76_get_field(dev, MT_FW_EXCEPTION, GENMASK(15, 8)) :
+		   mt76_get_field(dev, MT_FW_EXCEPTION, GENMASK(7, 0)));
+
 	if (dev->fw.debug_wm) {
 		seq_printf(file, "Busy: %u%%  Peak busy: %u%%\n",
 			   mt76_rr(dev, MT_CPU_UTIL_BUSY_PCT),
@@ -616,6 +622,8 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
+	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WA_MCU_PC));
+
 	if (dev->fw.debug_wa)
 		return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
 					 MCU_WA_PARAM_CPU_UTIL, 0, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3c55d4cebbf2..d95c32c7bd53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -22,6 +22,7 @@ static const u32 mt7915_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x77ffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c3fffff,
+	[FW_EXCEPTION_ADDR]	= 0x219848,
 	[SWDEF_BASE_ADDR]	= 0x41f200,
 };
 
@@ -37,6 +38,7 @@ static const u32 mt7916_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
+	[FW_EXCEPTION_ADDR]	= 0x022050bc,
 	[SWDEF_BASE_ADDR]	= 0x411400,
 };
 
@@ -52,6 +54,7 @@ static const u32 mt7986_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0x27000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
+	[FW_EXCEPTION_ADDR]	= 0x02204ffc,
 	[SWDEF_BASE_ADDR]	= 0x411400,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 7415118f6399..eb8891c53e9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -30,6 +30,7 @@ enum reg_rev {
 	WFDMA_EXT_CSR_ADDR,
 	CBTOP1_PHY_END,
 	INFRA_MCU_ADDR_END,
+	FW_EXCEPTION_ADDR,
 	SWDEF_BASE_ADDR,
 	__MT_REG_MAX,
 };
@@ -922,6 +923,8 @@ enum offs_rev {
 #define MT_ADIE_TYPE_MASK		BIT(1)
 
 /* FW MODE SYNC */
+#define MT_FW_EXCEPTION		__REG(FW_EXCEPTION_ADDR)
+
 #define MT_SWDEF_BASE			__REG(SWDEF_BASE_ADDR)
 
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
@@ -987,10 +990,6 @@ enum offs_rev {
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
-#define MT_HW_BOUND			0x70010020
-#define MT_HW_REV			0x70010204
-#define MT_WF_SUBSYS_RST		0x70002600
-
 #define MT_TOP_WFSYS_WAKEUP		MT_TOP(0x1a4)
 #define MT_TOP_WFSYS_WAKEUP_MASK	BIT(0)
 
@@ -1052,6 +1051,10 @@ enum offs_rev {
 #define MT_MCU_BUS_DBG_TIMEOUT_CK_EN_MASK BIT(3)
 #define MT_MCU_BUS_DBG_TIMEOUT_EN_MASK	BIT(2)
 
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_REV			0x70010204
+#define MT_WF_SUBSYS_RST		0x70002600
+
 /* PCIE MAC */
 #define MT_PCIE_MAC_BASE		0x74030000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
@@ -1060,6 +1063,9 @@ enum offs_rev {
 #define MT_PCIE1_MAC_INT_ENABLE		0x74020188
 #define MT_PCIE1_MAC_INT_ENABLE_MT7916	0x74090188
 
+#define MT_WM_MCU_PC			0x7c060204
+#define MT_WA_MCU_PC			0x7c06020c
+
 /* PP TOP */
 #define MT_WF_PP_TOP_BASE		0x820cc000
 #define MT_WF_PP_TOP(ofs)		(MT_WF_PP_TOP_BASE + (ofs))
-- 
2.29.2

