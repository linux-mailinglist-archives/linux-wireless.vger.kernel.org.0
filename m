Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1006D6D86
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjDDUDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDDUDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 16:03:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80DE64
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 13:03:47 -0700 (PDT)
X-UUID: c8babccad32311edb6b9f13eb10bd0fe-20230405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hOt3NxYO91tjFo7kwMLgCUum/AlzeZOtHW5fxlSPoqo=;
        b=HBKAg9KZaBafXwoTZG/fB1kf5xvx7y5GJTMiBdFKIitKd+N2ymACBpohYVICfBKrVlVgtLbhyTZZpUFlTVRTfbvHZaQ8lrIT/FC5AtdAOIMv0ZyTkPOG4P+rxMZ4JyuKHlacmp6EGZJRWYP9ZkHPm0UCLFKL+/zTIlEt4anZp7E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c7bae02c-735c-410c-ba35-3773cb8da286,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:3afa5d2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c8babccad32311edb6b9f13eb10bd0fe-20230405
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1833532866; Wed, 05 Apr 2023 04:03:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 5 Apr 2023 04:03:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 5 Apr 2023 04:03:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7996: add full system reset knobs into debugfs
Date:   Wed, 5 Apr 2023 04:03:31 +0800
Message-ID: <cb71efc424029e909866e1c86cce712dbf2cc9ef.1680638324.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6756ddde5aaaf29db4f62264bab7f28bb539b26f.1680638324.git.ryder.lee@mediatek.com>
References: <6756ddde5aaaf29db4f62264bab7f28bb539b26f.1680638324.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add testing points into debugfs to trigger firmware assert and enable
full system recovery. Also rename knob "fw_ser" to a clear-cut name
"sys_recovery".

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 149 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  16 ++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  28 ++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  13 ++
 5 files changed, 177 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 40a99e0caded..755e6502fd0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1221,6 +1221,7 @@ enum {
 	MCU_UNI_CMD_VOW = 0x37,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
+	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 9c5e9ac1c335..513ab4ba41c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -48,12 +48,12 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7996_implicit_txbf_get,
 
 /* test knob of system error recovery */
 static ssize_t
-mt7996_fw_ser_set(struct file *file, const char __user *user_buf,
-		  size_t count, loff_t *ppos)
+mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
+			size_t count, loff_t *ppos)
 {
 	struct mt7996_phy *phy = file->private_data;
 	struct mt7996_dev *dev = phy->dev;
-	u8 band_idx = phy->mt76->band_idx;
+	bool band = phy->mt76->band_idx;
 	char buf[16];
 	int ret = 0;
 	u16 val;
@@ -73,17 +73,47 @@ mt7996_fw_ser_set(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 
 	switch (val) {
-	case SER_SET_RECOVER_L1:
-	case SER_SET_RECOVER_L2:
-	case SER_SET_RECOVER_L3_RX_ABORT:
-	case SER_SET_RECOVER_L3_TX_ABORT:
-	case SER_SET_RECOVER_L3_TX_DISABLE:
-	case SER_SET_RECOVER_L3_BF:
-		ret = mt7996_mcu_set_ser(dev, SER_ENABLE, BIT(val), band_idx);
+	/*
+	 * 0: grab firmware current SER state.
+	 * 1: trigger & enable system error L1 recovery.
+	 * 2: trigger & enable system error L2 recovery.
+	 * 3: trigger & enable system error L3 rx abort.
+	 * 4: trigger & enable system error L3 tx abort
+	 * 5: trigger & enable system error L3 tx disable.
+	 * 6: trigger & enable system error L3 bf recovery.
+	 * 7: trigger & enable system error L4 mdp recovery.
+	 * 8: trigger & enable system error full recovery.
+	 * 9: trigger firmware crash.
+	 */
+	case UNI_CMD_SER_QUERY:
+		ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_QUERY, 0, band);
+		break;
+	case UNI_CMD_SER_SET_RECOVER_L1:
+	case UNI_CMD_SER_SET_RECOVER_L2:
+	case UNI_CMD_SER_SET_RECOVER_L3_RX_ABORT:
+	case UNI_CMD_SER_SET_RECOVER_L3_TX_ABORT:
+	case UNI_CMD_SER_SET_RECOVER_L3_TX_DISABLE:
+	case UNI_CMD_SER_SET_RECOVER_L3_BF:
+	case UNI_CMD_SER_SET_RECOVER_L4_MDP:
+		ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_SET, BIT(val), band);
 		if (ret)
 			return ret;
 
-		ret = mt7996_mcu_set_ser(dev, SER_RECOVER, val, band_idx);
+		ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_TRIGGER, val, band);
+		break;
+
+	/* enable full chip reset */
+	case UNI_CMD_SER_SET_RECOVER_FULL:
+		mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
+		dev->recovery.state |= MT_MCU_CMD_WDT_MASK;
+		mt7996_reset(dev);
+		break;
+
+	/* WARNING: trigger firmware crash */
+	case UNI_CMD_SER_SET_SYSTEM_ASSERT:
+		ret = mt7996_mcu_trigger_assert(dev);
+		if (ret)
+			return ret;
 		break;
 	default:
 		break;
@@ -92,9 +122,97 @@ mt7996_fw_ser_set(struct file *file, const char __user *user_buf,
 	return ret ? ret : count;
 }
 
-static const struct file_operations mt7996_fw_ser_ops = {
-	.write = mt7996_fw_ser_set,
-	/* TODO: ser read */
+static ssize_t
+mt7996_sys_recovery_get(struct file *file, char __user *user_buf,
+			size_t count, loff_t *ppos)
+{
+	struct mt7996_phy *phy = file->private_data;
+	struct mt7996_dev *dev = phy->dev;
+	char *buff;
+	int desc = 0;
+	ssize_t ret;
+	static const size_t bufsz = 1024;
+
+	buff = kmalloc(bufsz, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
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
+			  "7: trigger system error L4 mdp recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "8: trigger system error full recovery\n");
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "9: trigger firmware crash\n");
+
+	/* SER statistics */
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "\nlet's dump firmware SER statistics...\n");
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
+			  "::E  R , SER_LMAC_WISR6_B2 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR6_BN2_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR7_B0 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN0_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR7_B1 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN1_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "::E  R , SER_LMAC_WISR7_B2 = 0x%08x\n",
+			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN2_STATS));
+	desc += scnprintf(buff + desc, bufsz - desc,
+			  "\nSYS_RESET_COUNT: WM %d, WA %d\n",
+			  dev->recovery.wm_reset_count,
+			  dev->recovery.wa_reset_count);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	kfree(buff);
+	return ret;
+}
+
+static const struct file_operations mt7996_sys_recovery_ops = {
+	.write = mt7996_sys_recovery_set,
+	.read = mt7996_sys_recovery_get,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -674,6 +792,8 @@ int mt7996_init_debugfs(struct mt7996_phy *phy)
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
 			    &mt7996_xmit_queues_fops);
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7996_tx_stats_fops);
+	debugfs_create_file("sys_recovery", 0600, dir, phy,
+			    &mt7996_sys_recovery_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
@@ -684,7 +804,6 @@ int mt7996_init_debugfs(struct mt7996_phy *phy)
 			    &fops_implicit_txbf);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7996_twt_stats);
-	debugfs_create_file("fw_ser", 0600, dir, phy, &mt7996_fw_ser_ops);
 	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
 
 	if (phy->mt76->cap.has_5ghz) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a48522025867..1d44347a5fa7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3739,6 +3739,22 @@ int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set)
 	return 0;
 }
 
+int mt7996_mcu_trigger_assert(struct mt7996_dev *dev)
+{
+	struct {
+		__le16 tag;
+		__le16 len;
+		u8 enable;
+		u8 rsv[3];
+	} __packed req = {
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.enable = true,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(ASSERT_DUMP),
+				 &req, sizeof(req), false);
+}
+
 int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index dd0c5ac52703..6f92b9a7d86d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -648,23 +648,21 @@ enum {
 };
 
 enum {
-	UNI_CMD_SER_QUERY = 0x0,
-	UNI_CMD_SER_SET = 0x2,
-	UNI_CMD_SER_TRIGGER = 0x3,
-};
-
-enum {
-	SER_QUERY,
+	UNI_CMD_SER_QUERY,
 	/* recovery */
-	SER_SET_RECOVER_L1,
-	SER_SET_RECOVER_L2,
-	SER_SET_RECOVER_L3_RX_ABORT,
-	SER_SET_RECOVER_L3_TX_ABORT,
-	SER_SET_RECOVER_L3_TX_DISABLE,
-	SER_SET_RECOVER_L3_BF,
+	UNI_CMD_SER_SET_RECOVER_L1,
+	UNI_CMD_SER_SET_RECOVER_L2,
+	UNI_CMD_SER_SET_RECOVER_L3_RX_ABORT,
+	UNI_CMD_SER_SET_RECOVER_L3_TX_ABORT,
+	UNI_CMD_SER_SET_RECOVER_L3_TX_DISABLE,
+	UNI_CMD_SER_SET_RECOVER_L3_BF,
+	UNI_CMD_SER_SET_RECOVER_L4_MDP,
+	UNI_CMD_SER_SET_RECOVER_FULL,
+	UNI_CMD_SER_SET_SYSTEM_ASSERT,
 	/* action */
-	SER_ENABLE = 2,
-	SER_RECOVER
+	UNI_CMD_SER_ENABLE = 1,
+	UNI_CMD_SER_SET,
+	UNI_CMD_SER_TRIGGER
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 5ba74b49d65d..fb9b8dec9189 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -480,6 +480,19 @@ enum base_rev {
 #define MT_SWDEF_MODE				MT_SWDEF(0x3c)
 #define MT_SWDEF_NORMAL_MODE			0
 
+#define MT_SWDEF_SER_STATS			MT_SWDEF(0x040)
+#define MT_SWDEF_PLE_STATS			MT_SWDEF(0x044)
+#define MT_SWDEF_PLE1_STATS			MT_SWDEF(0x048)
+#define MT_SWDEF_PLE_AMSDU_STATS		MT_SWDEF(0x04c)
+#define MT_SWDEF_PSE_STATS			MT_SWDEF(0x050)
+#define MT_SWDEF_PSE1_STATS			MT_SWDEF(0x054)
+#define MT_SWDEF_LAMC_WISR6_BN0_STATS		MT_SWDEF(0x058)
+#define MT_SWDEF_LAMC_WISR6_BN1_STATS		MT_SWDEF(0x05c)
+#define MT_SWDEF_LAMC_WISR6_BN2_STATS		MT_SWDEF(0x060)
+#define MT_SWDEF_LAMC_WISR7_BN0_STATS		MT_SWDEF(0x064)
+#define MT_SWDEF_LAMC_WISR7_BN1_STATS		MT_SWDEF(0x068)
+#define MT_SWDEF_LAMC_WISR7_BN2_STATS		MT_SWDEF(0x06c)
+
 /* LED */
 #define MT_LED_TOP_BASE				0x18013000
 #define MT_LED_PHYS(_n)				(MT_LED_TOP_BASE + (_n))
-- 
2.18.0

