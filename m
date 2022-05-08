Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7951EBEA
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiEHF3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 01:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiEHF2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 01:28:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CF65C0
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 22:25:01 -0700 (PDT)
X-UUID: 3b1ae48295404b5890ac7e89fae4398c-20220508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:33f148e4-48a2-4ce9-b235-9beff264479d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:0240f9b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3b1ae48295404b5890ac7e89fae4398c-20220508
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 728484064; Sun, 08 May 2022 13:24:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 8 May 2022 13:24:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 May 2022 13:24:55 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: improve error handling for fw_debug knobs
Date:   Sun, 8 May 2022 13:24:53 +0800
Message-ID: <210119c0737d72aa049c113dac48e22a4d84d689.1651983999.git.ryder.lee@mediatek.com>
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

In case fw.debug_wm/wa might be unavailable.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2:
- add exception state and split original patch into two pieces.
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 53 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  9 ++--
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 875f17ff33a9..656f3ffccf4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -447,20 +447,20 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 	bool tx, rx, en;
 	int ret;
 
-	dev->fw_debug_wm = val ? MCU_FW_LOG_TO_HOST : 0;
+	dev->fw.debug_wm = val ? MCU_FW_LOG_TO_HOST : 0;
 
-	if (dev->fw_debug_bin)
+	if (dev->fw.debug_bin)
 		val = 16;
 	else
-		val = dev->fw_debug_wm;
+		val = dev->fw.debug_wm;
 
-	tx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(1));
-	rx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(2));
-	en = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(0));
+	tx = dev->fw.debug_wm || (dev->fw.debug_bin & BIT(1));
+	rx = dev->fw.debug_wm || (dev->fw.debug_bin & BIT(2));
+	en = dev->fw.debug_wm || (dev->fw.debug_bin & BIT(0));
 
 	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, val);
 	if (ret)
-		return ret;
+		goto out;
 
 	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++) {
 		if (debug == DEBUG_RPT_RX)
@@ -470,16 +470,20 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 
 		ret = mt7915_mcu_fw_dbg_ctrl(dev, debug, val);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* WM CPU info record control */
 	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
-	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw_debug_wm);
+	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
 
-	return 0;
+out:
+	if (ret)
+		dev->fw.debug_wm = 0;
+
+	return ret;
 }
 
 static int
@@ -487,7 +491,7 @@ mt7915_fw_debug_wm_get(void *data, u64 *val)
 {
 	struct mt7915_dev *dev = data;
 
-	*val = dev->fw_debug_wm;
+	*val = dev->fw.debug_wm;
 
 	return 0;
 }
@@ -501,14 +505,19 @@ mt7915_fw_debug_wa_set(void *data, u64 val)
 	struct mt7915_dev *dev = data;
 	int ret;
 
-	dev->fw_debug_wa = val ? MCU_FW_LOG_TO_HOST : 0;
+	dev->fw.debug_wa = val ? MCU_FW_LOG_TO_HOST : 0;
+
+	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw.debug_wa);
+	if (ret)
+		goto out;
 
-	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
+	ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+				MCU_WA_PARAM_PDMA_RX, !!dev->fw.debug_wa, 0);
+out:
 	if (ret)
-		return ret;
+		dev->fw.debug_wa = 0;
 
-	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_PDMA_RX,
-				 !!dev->fw_debug_wa, 0);
+	return ret;
 }
 
 static int
@@ -516,7 +525,7 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
 {
 	struct mt7915_dev *dev = data;
 
-	*val = dev->fw_debug_wa;
+	*val = dev->fw.debug_wa;
 
 	return 0;
 }
@@ -563,11 +572,11 @@ mt7915_fw_debug_bin_set(void *data, u64 val)
 	if (!dev->relay_fwlog)
 		return -ENOMEM;
 
-	dev->fw_debug_bin = val;
+	dev->fw.debug_bin = val;
 
 	relay_reset(dev->relay_fwlog);
 
-	return mt7915_fw_debug_wm_set(dev, dev->fw_debug_wm);
+	return mt7915_fw_debug_wm_set(dev, dev->fw.debug_wm);
 }
 
 static int
@@ -575,7 +584,7 @@ mt7915_fw_debug_bin_get(void *data, u64 *val)
 {
 	struct mt7915_dev *dev = data;
 
-	*val = dev->fw_debug_bin;
+	*val = dev->fw.debug_bin;
 
 	return 0;
 }
@@ -588,7 +597,7 @@ mt7915_fw_util_wm_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
-	if (dev->fw_debug_wm) {
+	if (dev->fw.debug_wm) {
 		seq_printf(file, "Busy: %u%%  Peak busy: %u%%\n",
 			   mt76_rr(dev, MT_CPU_UTIL_BUSY_PCT),
 			   mt76_rr(dev, MT_CPU_UTIL_PEAK_BUSY_PCT));
@@ -607,7 +616,7 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 {
 	struct mt7915_dev *dev = file->private;
 
-	if (dev->fw_debug_wa)
+	if (dev->fw.debug_wa)
 		return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
 					 MCU_WA_PARAM_CPU_UTIL, 0, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 42e195dded01..72be5bceeb50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -311,15 +311,18 @@ struct mt7915_dev {
 	bool flash_mode;
 	bool muru_debug;
 	bool ibf;
-	u8 fw_debug_wm;
-	u8 fw_debug_wa;
-	u8 fw_debug_bin;
 
 	struct dentry *debugfs_dir;
 	struct rchan *relay_fwlog;
 
 	void *cal;
 
+	struct {
+		u8 debug_wm;
+		u8 debug_wa;
+		u8 debug_bin;
+	} fw;
+
 	struct {
 		u8 table_mask;
 		u8 n_agrt;
-- 
2.29.2

