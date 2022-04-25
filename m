Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9250D79B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 05:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiDYDiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 23:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiDYDhr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 23:37:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2557F2CCB0
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 20:34:42 -0700 (PDT)
X-UUID: 971d914d3922417cab059766f4e0a2d2-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:761f809e-3136-412f-97aa-9a9c0b316cc6,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:88
X-CID-INFO: VERSION:1.1.4,REQID:761f809e-3136-412f-97aa-9a9c0b316cc6,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:88
X-CID-META: VersionHash:faefae9,CLOUDID:ec6bf7ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:8b2039894e15,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 971d914d3922417cab059766f4e0a2d2-20220425
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1302526460; Mon, 25 Apr 2022 11:34:36 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Apr 2022 11:34:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 11:34:33 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 25 Apr 2022 11:34:32 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "lian . chen" <lian.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: dump SER stats through debugfs
Date:   Mon, 25 Apr 2022 11:34:29 +0800
Message-ID: <fe715dbd6cd43651b50172acf58bb1eab66584da.1650857049.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Grab status of system recovery from firmware.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2:
 - merge fw_ser_stats into fw_ser
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 95 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 18 +++-
 4 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index dece0a6..cbfed7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -45,34 +45,109 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
 			 mt7915_implicit_txbf_set, "%lld\n");
 
 /* test knob of system layer 1/2 error recovery */
-static int mt7915_ser_trigger_set(void *data, u64 val)
+static ssize_t mt7915_fw_ser_set(struct file *file,
+				 const char __user *user_buf,
+				 size_t count, loff_t *ppos)
 {
 	enum {
+		SER_QUERY = 0,
 		SER_SET_RECOVER_L1 = 1,
 		SER_SET_RECOVER_L2,
 		SER_ENABLE = 2,
 		SER_RECOVER
 	};
-	struct mt7915_dev *dev = data;
-	int ret = 0;
+	struct mt7915_dev *dev = file->private_data;
+	char buf[16];
+	u16 val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (kstrtou16(buf, 0, &val))
+		return -EINVAL;
 
 	switch (val) {
+	case SER_QUERY:
+		/* grab firmware SER stats */
+		mt7915_mcu_set_ser(dev, 0, 0, 0);
+		break;
 	case SER_SET_RECOVER_L1:
 	case SER_SET_RECOVER_L2:
-		ret = mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), 0);
-		if (ret)
-			return ret;
+		mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), 0);
 
-		return mt7915_mcu_set_ser(dev, SER_RECOVER, val, 0);
+		mt7915_mcu_set_ser(dev, SER_RECOVER, val, 0);
 	default:
 		break;
 	}
 
+	return count;
+}
+
+static ssize_t
+mt7915_fw_ser_get(struct file *file,
+		  char __user *user_buf,
+		  size_t count, loff_t *ppos)
+{
+	struct mt7915_dev *dev = file->private_data;
+	char *buff;
+	int desc = 0;
+	ssize_t ret;
+	static const size_t bufsz = 400;
+
+	buff = kmalloc(bufsz, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_STATUS        = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_SER_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_PLE_ERR       = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_PLE_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_PLE_ERR_1     = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_PLE1_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_PLE_ERR_AMSDU = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_PLE_AMSDU_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_PSE_ERR       = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_PSE_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_PSE_ERR_1     = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_PSE1_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR6_B0 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR6_BN0_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR6_B1 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR6_BN1_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR7_B0 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN0_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR7_B1 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN1_STATS));
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	kfree(buff);
 	return ret;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_ser_trigger, NULL,
-			 mt7915_ser_trigger_set, "%lld\n");
+static const struct file_operations mt7915_fw_ser_ops = {
+	.write = mt7915_fw_ser_set,
+	.read = mt7915_fw_ser_get,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
 
 static int
 mt7915_radar_trigger(void *data, u64 val)
@@ -884,6 +959,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
 			    &mt7915_xmit_queues_fops);
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
+	debugfs_create_file("fw_ser", 0600, dir, dev, &mt7915_fw_ser_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
@@ -897,7 +973,6 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_rate_txpower_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
-	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
 	if (!dev->dbdc_support || phy->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ee2956c..d4af707 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2471,10 +2471,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	/* force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
-	if (is_mt7915(&dev->mt76))
-		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-	else
-		mt76_wr(dev, MT_SWDEF_MODE_MT7916, MT_SWDEF_NORMAL_MODE);
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
 
 	ret = mt7915_driver_own(dev, 0);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 89ea285..cd4dfd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -22,6 +22,7 @@ static const u32 mt7915_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x77ffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c3fffff,
+	[SWDEF_BASE_ADDR]	= 0x41f200,
 };
 
 static const u32 mt7916_reg[] = {
@@ -36,6 +37,7 @@ static const u32 mt7916_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
+	[SWDEF_BASE_ADDR]	= 0x411400,
 };
 
 static const u32 mt7986_reg[] = {
@@ -50,6 +52,7 @@ static const u32 mt7986_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0x27000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
+	[SWDEF_BASE_ADDR]	= 0x411400,
 };
 
 static const u32 mt7915_offs[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index bb0dec8..8e77c28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -30,6 +30,7 @@ enum reg_rev {
 	WFDMA_EXT_CSR_ADDR,
 	CBTOP1_PHY_END,
 	INFRA_MCU_ADDR_END,
+	SWDEF_BASE_ADDR,
 	__MT_REG_MAX,
 };
 
@@ -929,12 +930,25 @@ enum offs_rev {
 #define MT_ADIE_TYPE_MASK		BIT(1)
 
 /* FW MODE SYNC */
-#define MT_SWDEF_MODE			0x41f23c
-#define MT_SWDEF_MODE_MT7916		0x41143c
+#define MT_SWDEF_BASE			__REG(SWDEF_BASE_ADDR)
+
+#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
+#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
 #define MT_SWDEF_NORMAL_MODE		0
 #define MT_SWDEF_ICAP_MODE		1
 #define MT_SWDEF_SPECTRUM_MODE		2
 
+#define MT_SWDEF_SER_STATS		MT_SWDEF(0x040)
+#define MT_SWDEF_PLE_STATS		MT_SWDEF(0x044)
+#define MT_SWDEF_PLE1_STATS		MT_SWDEF(0x048)
+#define MT_SWDEF_PLE_AMSDU_STATS	MT_SWDEF(0x04C)
+#define MT_SWDEF_PSE_STATS		MT_SWDEF(0x050)
+#define MT_SWDEF_PSE1_STATS		MT_SWDEF(0x054)
+#define MT_SWDEF_LAMC_WISR6_BN0_STATS	MT_SWDEF(0x058)
+#define MT_SWDEF_LAMC_WISR6_BN1_STATS	MT_SWDEF(0x05C)
+#define MT_SWDEF_LAMC_WISR7_BN0_STATS	MT_SWDEF(0x060)
+#define MT_SWDEF_LAMC_WISR7_BN1_STATS	MT_SWDEF(0x064)
+
 #define MT_DIC_CMD_REG_BASE		0x41f000
 #define MT_DIC_CMD_REG(ofs)		(MT_DIC_CMD_REG_BASE + (ofs))
 #define MT_DIC_CMD_REG_CMD		MT_DIC_CMD_REG(0x10)
-- 
2.18.0

