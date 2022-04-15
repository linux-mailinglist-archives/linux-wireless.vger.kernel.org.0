Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B9502561
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiDOGRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Apr 2022 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiDOGRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Apr 2022 02:17:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781053C492
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 23:14:53 -0700 (PDT)
X-UUID: 92d0064d55554472a13182e1f1e5a045-20220415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:dddddf8a-f101-48f7-9d69-2e7b9806084a,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:103
X-CID-INFO: VERSION:1.1.4,REQID:dddddf8a-f101-48f7-9d69-2e7b9806084a,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:103
X-CID-META: VersionHash:faefae9,CLOUDID:27a83aa9-d103-4e36-82b9-b0e86991b3df,C
        OID:961720e55576,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 92d0064d55554472a13182e1f1e5a045-20220415
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1203422980; Fri, 15 Apr 2022 14:14:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 15 Apr 2022 14:14:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 14:14:48 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: add debugfs knob for RF registers read/write
Date:   Fri, 15 Apr 2022 14:14:44 +0800
Message-ID: <20220415061444.30720-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add RF registers read/write support for debugging RF issues, which
should be processed by mcu commands.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: add dev_kfree_skb()
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 82 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 30 +++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 3 files changed, 116 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index dece0a6e..275ff49e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -867,6 +867,85 @@ mt7915_twt_stats(struct seq_file *s, void *data)
 	return 0;
 }
 
+static ssize_t
+mt7915_rf_regidx_read(struct file *file, char __user *userbuf,
+		      size_t count, loff_t *ppos)
+{
+	struct mt7915_dev *dev = file->private_data;
+	int ret, len = 14;
+	char *buf;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = snprintf(buf, len, "%u 0x%08x\n", dev->rf_sel, dev->rf_ofs);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+mt7915_rf_regidx_write(struct file *file, const char __user *userbuf,
+		       size_t count, loff_t *ppos)
+{
+	struct mt7915_dev *dev = file->private_data;
+	char buf[13];
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = '\0';
+
+	if (sscanf(buf, "%hhu 0x%x", &dev->rf_sel, &dev->rf_ofs) != 2) {
+		dev_warn(dev->mt76.dev,
+			 "format: <rf_sel> 0x<rf_ofs>\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations fops_rf_regidx = {
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+	.read = mt7915_rf_regidx_read,
+	.write = mt7915_rf_regidx_write,
+	.owner = THIS_MODULE,
+};
+
+static int
+mt7915_rf_regval_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+	u32 regval;
+	int ret;
+
+	ret = mt7915_mcu_rf_regval(dev, dev->rf_sel, dev->rf_ofs, &regval, false);
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpu(regval);
+
+	return 0;
+}
+
+static int
+mt7915_rf_regval_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	return mt7915_mcu_rf_regval(dev, dev->rf_sel, dev->rf_ofs,
+				    (u32 *)&val, true);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7915_rf_regval_get,
+			 mt7915_rf_regval_set, "0x%08llx\n");
+
 int mt7915_init_debugfs(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
@@ -898,6 +977,9 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
 				    mt7915_twt_stats);
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
+	debugfs_create_file("rf_regidx", 0600, dir, dev, &fops_rf_regidx);
+	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
+
 	if (!dev->dbdc_support || phy->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ec93a924..183ab554 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3677,3 +3677,33 @@ int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TWT_AGRT_UPDATE),
 				 &req, sizeof(req), true);
 }
+
+int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u8 rf_sel,
+			 u32 rf_offset, u32 *val, bool set)
+{
+	struct {
+		__le32 idx;
+		__le32 ofs;
+		__le32 data;
+	} __packed req = {
+		.idx = cpu_to_le32(dev->rf_sel),
+		.ofs = cpu_to_le32(dev->rf_ofs),
+		.data = set ? cpu_to_le32(*val) : 0,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	if (set)
+		return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_REG_ACCESS),
+					 &req, sizeof(req), false);
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(RF_REG_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpu(*(__le32 *)(skb->data + 8));
+	dev_kfree_skb(skb);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ca129e5e..ccff5043 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -312,6 +312,8 @@ struct mt7915_dev {
 	u8 fw_debug_wm;
 	u8 fw_debug_wa;
 	u8 fw_debug_bin;
+	u8 rf_sel;
+	u32 rf_ofs;
 
 	struct dentry *debugfs_dir;
 	struct rchan *relay_fwlog;
@@ -507,6 +509,8 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 				     struct cfg80211_chan_def *chandef);
+int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u8 rf_sel,
+			 u32 rf_offset, u32 *val, bool set);
 int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
-- 
2.25.1

