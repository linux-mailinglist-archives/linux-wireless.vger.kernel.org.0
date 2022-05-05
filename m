Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C921651B878
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 09:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiEEHMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbiEEHM3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 03:12:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184545046
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 00:08:46 -0700 (PDT)
X-UUID: e8f4cfd0a18b428db76041d5b7866ce8-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7b5df06d-8d02-4246-a49a-3ee393018f79,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:aca94616-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: e8f4cfd0a18b428db76041d5b7866ce8-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1773263779; Thu, 05 May 2022 15:08:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 15:08:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 5 May 2022 15:08:38 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7915: reowrk SER debugfs knob
Date:   Thu, 5 May 2022 15:08:34 +0800
Message-ID: <40f31a4550ff357468798a5950a62ceec396cbeb.1651722608.git.ryder.lee@mediatek.com>
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

1. get status of system recovery from firmware.
2. add more recovery points.
3. make knob per phy.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 106 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  14 +++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   3 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  18 ++-
 5 files changed, 126 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index dece0a6e00b3..875f17ff33a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -44,35 +44,113 @@ mt7915_implicit_txbf_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
 			 mt7915_implicit_txbf_set, "%lld\n");
 
-/* test knob of system layer 1/2 error recovery */
-static int mt7915_ser_trigger_set(void *data, u64 val)
+/* test knob of system error recovery */
+static ssize_t
+mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
+		  size_t count, loff_t *ppos)
 {
-	enum {
-		SER_SET_RECOVER_L1 = 1,
-		SER_SET_RECOVER_L2,
-		SER_ENABLE = 2,
-		SER_RECOVER
-	};
-	struct mt7915_dev *dev = data;
+	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	char buf[16];
 	int ret = 0;
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
+		ret = mt7915_mcu_set_ser(dev, 0, 0, ext_phy);
+		break;
 	case SER_SET_RECOVER_L1:
 	case SER_SET_RECOVER_L2:
-		ret = mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), 0);
+	case SER_SET_RECOVER_L3_RX_ABORT:
+	case SER_SET_RECOVER_L3_TX_ABORT:
+	case SER_SET_RECOVER_L3_TX_DISABLE:
+	case SER_SET_RECOVER_L3_BF:
+		ret = mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), ext_phy);
 		if (ret)
 			return ret;
 
-		return mt7915_mcu_set_ser(dev, SER_RECOVER, val, 0);
+		ret = mt7915_mcu_set_ser(dev, SER_RECOVER, val, ext_phy);
+		break;
 	default:
 		break;
 	}
 
+	return ret ? ret : count;
+}
+
+static ssize_t
+mt7915_fw_ser_get(struct file *file, char __user *user_buf,
+		  size_t count, loff_t *ppos)
+{
+	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_dev *dev = phy->dev;
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
@@ -884,6 +962,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
 			    &mt7915_xmit_queues_fops);
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
+	debugfs_create_file("fw_ser", 0600, dir, phy, &mt7915_fw_ser_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
@@ -897,7 +976,6 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_rate_txpower_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
-	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
 	if (!dev->dbdc_support || phy->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a10973e04a42..46fa93c2bc48 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 064d33e33738..0c40e4469937 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -463,6 +463,20 @@ enum {
 	MURU_GET_TXC_TX_STATS = 151,
 };
 
+enum {
+	SER_QUERY,
+	/* recovery */
+	SER_SET_RECOVER_L1,
+	SER_SET_RECOVER_L2,
+	SER_SET_RECOVER_L3_RX_ABORT,
+	SER_SET_RECOVER_L3_TX_ABORT,
+	SER_SET_RECOVER_L3_TX_DISABLE,
+	SER_SET_RECOVER_L3_BF,
+	/* action */
+	SER_ENABLE = 2,
+	SER_RECOVER
+};
+
 #define MT7915_BSS_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct bss_info_omac) +	\
 					 sizeof(struct bss_info_basic) +\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 5062e0d8cae4..229d40826c9b 100644
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
index e5f93c40591c..1a7f95223be1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -30,6 +30,7 @@ enum reg_rev {
 	WFDMA_EXT_CSR_ADDR,
 	CBTOP1_PHY_END,
 	INFRA_MCU_ADDR_END,
+	SWDEF_BASE_ADDR,
 	__MT_REG_MAX,
 };
 
@@ -913,12 +914,25 @@ enum offs_rev {
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
2.29.2

