Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6C51EA8D
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiEGWui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 May 2022 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEGWug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 May 2022 18:50:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBC6450
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 15:46:44 -0700 (PDT)
X-UUID: 5936b367d76a48a3974a78aa02e0c70d-20220508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f0c54953-51e1-40e8-a998-ac692d495848,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:a9b89416-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 5936b367d76a48a3974a78aa02e0c70d-20220508
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1044424186; Sun, 08 May 2022 06:46:38 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 8 May 2022 06:46:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 8 May 2022 06:46:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 8 May 2022 06:46:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: rework fw_util debugfs knob
Date:   Sun, 8 May 2022 06:45:37 +0800
Message-ID: <7a47e6fb793030daf592a4e2fcd9cee71d8daf77.1651963443.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Improve error handlings and add MCU program counters for debug.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 25 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 11 +++++---
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 875f17ff33a9..2725b1b80634 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -460,7 +460,7 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 
 	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, val);
 	if (ret)
-		return ret;
+		goto out;
 
 	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++) {
 		if (debug == DEBUG_RPT_RX)
@@ -470,7 +470,7 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 
 		ret = mt7915_mcu_fw_dbg_ctrl(dev, debug, val);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* WM CPU info record control */
@@ -479,7 +479,11 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
 
-	return 0;
+out:
+	if (ret)
+		dev->fw_debug_wm = 0;
+
+	return ret;
 }
 
 static int
@@ -505,10 +509,15 @@ mt7915_fw_debug_wa_set(void *data, u64 val)
 
 	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+				MCU_WA_PARAM_PDMA_RX, !!dev->fw_debug_wa, 0);
+out:
+	if (ret)
+		dev->fw_debug_wa = 0;
 
-	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_PDMA_RX,
-				 !!dev->fw_debug_wa, 0);
+	return ret;
 }
 
 static int
@@ -588,6 +597,8 @@ mt7915_fw_util_wm_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
+	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WM_MCU_PC));
+
 	if (dev->fw_debug_wm) {
 		seq_printf(file, "Busy: %u%%  Peak busy: %u%%\n",
 			   mt76_rr(dev, MT_CPU_UTIL_BUSY_PCT),
@@ -607,6 +618,8 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
+	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WA_MCU_PC));
+
 	if (dev->fw_debug_wa)
 		return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
 					 MCU_WA_PARAM_CPU_UTIL, 0, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 7415118f6399..f9479319fb62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -987,10 +987,6 @@ enum offs_rev {
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
-#define MT_HW_BOUND			0x70010020
-#define MT_HW_REV			0x70010204
-#define MT_WF_SUBSYS_RST		0x70002600
-
 #define MT_TOP_WFSYS_WAKEUP		MT_TOP(0x1a4)
 #define MT_TOP_WFSYS_WAKEUP_MASK	BIT(0)
 
@@ -1052,6 +1048,10 @@ enum offs_rev {
 #define MT_MCU_BUS_DBG_TIMEOUT_CK_EN_MASK BIT(3)
 #define MT_MCU_BUS_DBG_TIMEOUT_EN_MASK	BIT(2)
 
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_REV			0x70010204
+#define MT_WF_SUBSYS_RST		0x70002600
+
 /* PCIE MAC */
 #define MT_PCIE_MAC_BASE		0x74030000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
@@ -1060,6 +1060,9 @@ enum offs_rev {
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

