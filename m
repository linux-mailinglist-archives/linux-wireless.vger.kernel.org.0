Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E8622057
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKHXaF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 18:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKHXaC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 18:30:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE674E02
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:30:00 -0800 (PST)
X-UUID: b0db58b586644eb9b49726cc692a26d3-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Cm6aeQXtOIew7s/6XKyXKoAR6/e/hUbX5UAYzfJ20yc=;
        b=FK+ZVnYqxrnkyxPIs9NF3h+liBXpb5oUCKWCIpu0HFNB+H3hSbwwPU6Uu6zUudbPDi9Ec4Ty6Jav8ovUicpJEMbzSUDMpduppThitOPuhADjx7HJq12mESGTm7jqC4LjwZa5aSntHAlF8BfiTjV4rcDdF9M7DHHehBAZ4VUd7Zw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:20184d8f-2e00-4c31-ab1d-57f82ba6e07b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:20184d8f-2e00-4c31-ab1d-57f82ba6e07b,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:882f11f4-a19e-4b45-8bfe-6a73c93611e9,B
        ulkID:22110907295458MXR5Z5,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b0db58b586644eb9b49726cc692a26d3-20221109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1495026887; Wed, 09 Nov 2022 07:29:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 9 Nov 2022 07:29:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 9 Nov 2022 07:29:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/4] wifi: mt76: mt7915: add full system reset into debugfs
Date:   Wed, 9 Nov 2022 07:29:43 +0800
Message-ID: <186725198fc5d409928ef15058fa6a26e54ce13f.1667949443.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667949443.git.ryder.lee@mediatek.com>
References: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667949443.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Trigger firmware crash and enable full system recovery through debugfs.
This also renames knob "fw_ser" to a clear-cut name "sys_recovery".

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - print out the text for what the various values that can be written to this debugfs file do.
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 81 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  4 +
 5 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e1d15394a621..10af98ea5ea8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -46,8 +46,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
 
 /* test knob of system error recovery */
 static ssize_t
-mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
-		  size_t count, loff_t *ppos)
+mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
+			size_t count, loff_t *ppos)
 {
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
@@ -71,8 +71,18 @@ mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 
 	switch (val) {
+	/*
+	 * 0: grab firmware current SER state.
+	 * 1: trigger & enable system error L1 recovery.
+	 * 2: trigger & enable system error L2 recovery.
+	 * 3: trigger & enable system error L3 rx abort.
+	 * 4: trigger & enable system error L3 tx abort
+	 * 5: trigger & enable system error L3 tx disable.
+	 * 6: trigger & enable system error L3 bf recovery.
+	 * 7: trigger & enable system error full recovery.
+	 * 8: trigger firmware crash.
+	 */
 	case SER_QUERY:
-		/* grab firmware SER stats */
 		ret = mt7915_mcu_set_ser(dev, 0, 0, ext_phy);
 		break;
 	case SER_SET_RECOVER_L1:
@@ -87,6 +97,23 @@ mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
 
 		ret = mt7915_mcu_set_ser(dev, SER_RECOVER, val, ext_phy);
 		break;
+
+	/* enable full chip reset */
+	case SER_SET_RECOVER_FULL:
+		mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
+		ret = mt7915_mcu_set_ser(dev, 1, 3, ext_phy);
+		if (ret)
+			return ret;
+
+		dev->recovery.state |= MT_MCU_CMD_WDT_MASK;
+		mt7915_reset(dev);
+		break;
+
+	/* WARNING: trigger firmware crash */
+	case SER_SET_SYSTEM_ASSERT:
+		mt76_wr(dev, MT_MCU_WM_CIRQ_EINT_MASK_CLR_ADDR, BIT(18));
+		mt76_wr(dev, MT_MCU_WM_CIRQ_EINT_SOFT_ADDR, BIT(18));
+		break;
 	default:
 		break;
 	}
@@ -95,20 +122,45 @@ mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
 }
 
 static ssize_t
-mt7915_fw_ser_get(struct file *file, char __user *user_buf,
-		  size_t count, loff_t *ppos)
+mt7915_sys_recovery_get(struct file *file, char __user *user_buf,
+			size_t count, loff_t *ppos)
 {
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
 	char *buff;
 	int desc = 0;
 	ssize_t ret;
-	static const size_t bufsz = 400;
+	static const size_t bufsz = 1024;
 
 	buff = kmalloc(bufsz, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
 
+	/* HELP */
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "Please echo the correct value ...\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "0: grab firmware transient SER state\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "1: trigger system error L1 recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "2: trigger system error L2 recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "3: trigger system error L3 rx abort\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "4: trigger system error L3 tx abort\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "5: trigger system error L3 tx disable\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "6: trigger system error L3 bf recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "7: trigger system error full recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "8: trigger firmware crash\n");
+
+	/* SER statistics */
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "\nlet's dump firmware SER statistics...\n");
 	desc += scnprintf(buff + desc, bufsz - desc,
 			  "::E  R , SER_STATUS        = 0x%08x\n",
 			  mt76_rr(dev, MT_SWDEF_SER_STATS));
@@ -139,15 +191,19 @@ mt7915_fw_ser_get(struct file *file, char __user *user_buf,
 	desc += scnprintf(buff + desc, bufsz - desc,
 			  "::E  R , SER_LMAC_WISR7_B1 = 0x%08x\n",
 			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN1_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "\nSYS_RESET_COUNT: WM %d, WA %d\n",
+			  dev->recovery.wm_reset_count,
+			  dev->recovery.wa_reset_count);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
 	kfree(buff);
 	return ret;
 }
 
-static const struct file_operations mt7915_fw_ser_ops = {
-	.write = mt7915_fw_ser_set,
-	.read = mt7915_fw_ser_get,
+static const struct file_operations mt7915_sys_recovery_ops = {
+	.write = mt7915_sys_recovery_set,
+	.read = mt7915_sys_recovery_get,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -598,10 +654,6 @@ mt7915_fw_util_wm_show(struct seq_file *file, void *data)
 	struct mt7915_dev *dev = file->private;
 
 	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WM_MCU_PC));
-	seq_printf(file, "Exception state: 0x%x\n",
-		   is_mt7915(&dev->mt76) ?
-		   (u32)mt76_get_field(dev, MT_FW_EXCEPTION, GENMASK(15, 8)) :
-		   (u32)mt76_get_field(dev, MT_FW_EXCEPTION, GENMASK(7, 0)));
 
 	if (dev->fw.debug_wm) {
 		seq_printf(file, "Busy: %u%%  Peak busy: %u%%\n",
@@ -1010,7 +1062,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
 			    &mt7915_xmit_queues_fops);
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
-	debugfs_create_file("fw_ser", 0600, dir, phy, &mt7915_fw_ser_ops);
+	debugfs_create_file("sys_recovery", 0600, dir, phy,
+			    &mt7915_sys_recovery_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 69ce3b39aa53..c8e69644c552 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1503,6 +1503,11 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		mt76_clear(dev, MT_WFDMA0_MCU_HOST_INT_ENA,
 			   MT_MCU_CMD_WDT_MASK);
 
+		if (READ_ONCE(dev->recovery.state) & MT_MCU_CMD_WA_WDT)
+			dev->recovery.wa_reset_count++;
+		else
+			dev->recovery.wm_reset_count++;
+
 		mt7915_mac_full_reset(dev);
 
 		/* enable mcu irq */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 87cd1bfff3e6..5a8c57a1421f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -448,6 +448,8 @@ enum {
 	SER_SET_RECOVER_L3_TX_ABORT,
 	SER_SET_RECOVER_L3_TX_DISABLE,
 	SER_SET_RECOVER_L3_BF,
+	SER_SET_RECOVER_FULL,
+	SER_SET_SYSTEM_ASSERT,
 	/* action */
 	SER_ENABLE = 2,
 	SER_RECOVER
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 49caf7b21a20..96ef06511552 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -306,6 +306,8 @@ struct mt7915_dev {
 
 	struct {
 		u32 state;
+		u32 wa_reset_count;
+		u32 wm_reset_count;
 		bool hw_full_reset:1;
 		bool hw_init_done:1;
 		bool restart:1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 9120380d74c6..d7756cb0d29b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -711,6 +711,8 @@ enum offs_rev {
 #define MT_MCU_CMD_NORMAL_STATE		BIT(5)
 #define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
 
+#define MT_MCU_CMD_WA_WDT		BIT(31)
+#define MT_MCU_CMD_WM_WDT		BIT(30)
 #define MT_MCU_CMD_WDT_MASK		GENMASK(31, 30)
 
 /* TOP RGU */
@@ -1129,5 +1131,7 @@ enum offs_rev {
 #define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
 #define MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x80)
 #define MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR		MT_MCU_WM_CIRQ(0xc0)
+#define MT_MCU_WM_CIRQ_EINT_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x108)
+#define MT_MCU_WM_CIRQ_EINT_SOFT_ADDR		MT_MCU_WM_CIRQ(0x118)
 
 #endif
-- 
2.36.1

