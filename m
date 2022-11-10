Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE449623EC5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiKJJhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 04:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKJJhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 04:37:09 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7A6A754
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 01:37:02 -0800 (PST)
X-UUID: b4a095dc503f432cad0c8fd19546cb40-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bJTRas+H6ceooynBZ1QevBWBMt47uc7+2PZHmzXG91A=;
        b=pRgAsf+7BTcv1/e8TtJtp6ADU++QkkYuD2+6ievoNNs93Bkf7v+uRyCkHYA9qis3qcXulh1uv8iAUwxn60KESsrJEV0MprwHn263kMXTRrrNauAzLShf485bb0sIoSHJrbv1ySde1Bjf0IfUj6buuCnZpxAPcL7JlDgbk/FS9+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:7134da34-8846-4da2-b34e-df04af394d10,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:a752e950-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
X-UUID: b4a095dc503f432cad0c8fd19546cb40-20221110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1735765774; Thu, 10 Nov 2022 17:36:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 17:36:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 17:36:51 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
Date:   Thu, 10 Nov 2022 17:35:25 +0800
Message-ID: <20221110093525.29649-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221110093525.29649-1-shayne.chen@mediatek.com>
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add MediaTek new mac80211 driver mt7996 for Wi-Fi 7 (802.11be) devices.
The driver first supports Filogic 680 PCI device, which is a Wi-Fi 7
chipset supporting concurrent tri-band operation at 6 GHz, 5 GHz, and
2.4 GHz with 4x4 antennas on each band.

Currently, mt7996 only supports tri-band HE or older mode.
EHT mode and more variants of Filogic 680 support will be introduced
in further patches.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Co-developed-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt7996/Kconfig |   12 +
 .../wireless/mediatek/mt76/mt7996/Makefile    |    6 +
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  851 ++++
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  360 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |  229 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.h    |   75 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2468 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 1325 +++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3428 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  662 ++++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  516 +++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
 18 files changed, 12288 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 9ff43f1fc50d..d7f90a0eb21e 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -34,3 +34,4 @@ source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7615/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7915/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7921/Kconfig"
+source "drivers/net/wireless/mediatek/mt76/mt7996/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index c78ae4b89761..84c99b7e57f9 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_MT7603E) += mt7603/
 obj-$(CONFIG_MT7615_COMMON) += mt7615/
 obj-$(CONFIG_MT7915E) += mt7915/
 obj-$(CONFIG_MT7921_COMMON) += mt7921/
+obj-$(CONFIG_MT7996E) += mt7996/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
new file mode 100644
index 000000000000..5c5fc569e6d5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+config MT7996E
+	tristate "MediaTek MT7996 (PCIe) support"
+	select MT76_CONNAC_LIB
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7996-based wireless PCIe devices,
+	  which support concurrent tri-band operation at 6GHz, 5GHz,
+	  and 2.4GHz IEEE 802.11be 4x4:4SS 4096-QAM, 320MHz channels.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
new file mode 100644
index 000000000000..bcb9a3c53149
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: ISC
+
+obj-$(CONFIG_MT7996E) += mt7996e.o
+
+mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
+	     debugfs.o mmio.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
new file mode 100644
index 000000000000..0a122264a858
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/relay.h>
+#include "mt7996.h"
+#include "eeprom.h"
+#include "mcu.h"
+#include "mac.h"
+
+#define FW_BIN_LOG_MAGIC	0x44d9c99a
+
+/** global debugfs **/
+
+struct hw_queue_map {
+	const char *name;
+	u8 index;
+	u8 pid;
+	u8 qid;
+};
+
+static int
+mt7996_implicit_txbf_set(void *data, u64 val)
+{
+	struct mt7996_dev *dev = data;
+
+	/* The existing connected stations shall reconnect to apply
+	 * new implicit txbf configuration.
+	 */
+	dev->ibf = !!val;
+
+	return mt7996_mcu_set_txbf(dev, BF_HW_EN_UPDATE);
+}
+
+static int
+mt7996_implicit_txbf_get(void *data, u64 *val)
+{
+	struct mt7996_dev *dev = data;
+
+	*val = dev->ibf;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7996_implicit_txbf_get,
+			 mt7996_implicit_txbf_set, "%lld\n");
+
+/* test knob of system error recovery */
+static ssize_t
+mt7996_fw_ser_set(struct file *file, const char __user *user_buf,
+		  size_t count, loff_t *ppos)
+{
+	struct mt7996_phy *phy = file->private_data;
+	struct mt7996_dev *dev = phy->dev;
+	u8 band_idx = phy->mt76->band_idx;
+	char buf[16];
+	int ret = 0;
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
+
+	switch (val) {
+	case SER_SET_RECOVER_L1:
+	case SER_SET_RECOVER_L2:
+	case SER_SET_RECOVER_L3_RX_ABORT:
+	case SER_SET_RECOVER_L3_TX_ABORT:
+	case SER_SET_RECOVER_L3_TX_DISABLE:
+	case SER_SET_RECOVER_L3_BF:
+		ret = mt7996_mcu_set_ser(dev, SER_ENABLE, BIT(val), band_idx);
+		if (ret)
+			return ret;
+
+		ret = mt7996_mcu_set_ser(dev, SER_RECOVER, val, band_idx);
+		break;
+	default:
+		break;
+	}
+
+	return ret ? ret : count;
+}
+
+static const struct file_operations mt7996_fw_ser_ops = {
+	.write = mt7996_fw_ser_set,
+	/* TODO: ser read */
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
+static int
+mt7996_radar_trigger(void *data, u64 val)
+{
+	struct mt7996_dev *dev = data;
+
+	if (val > MT_RX_SEL2)
+		return -EINVAL;
+
+	return mt7996_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE,
+				  val, 0, 0);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
+			 mt7996_radar_trigger, "%lld\n");
+
+static int
+mt7996_rdd_monitor(struct seq_file *s, void *data)
+{
+	struct mt7996_dev *dev = dev_get_drvdata(s->private);
+	struct cfg80211_chan_def *chandef = &dev->rdd2_chandef;
+	const char *bw;
+	int ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (!cfg80211_chandef_valid(chandef)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!dev->rdd2_phy) {
+		seq_puts(s, "not running\n");
+		goto out;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		bw = "40";
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		bw = "80";
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		bw = "160";
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		bw = "80P80";
+		break;
+	default:
+		bw = "20";
+		break;
+	}
+
+	seq_printf(s, "channel %d (%d MHz) width %s MHz center1: %d MHz\n",
+		   chandef->chan->hw_value, chandef->chan->center_freq,
+		   bw, chandef->center_freq1);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7996_fw_debug_wm_set(void *data, u64 val)
+{
+	struct mt7996_dev *dev = data;
+	enum {
+		DEBUG_TXCMD = 62,
+		DEBUG_CMD_RPT_TX,
+		DEBUG_CMD_RPT_TRIG,
+		DEBUG_SPL,
+		DEBUG_RPT_RX,
+		DEBUG_RPT_RA = 68,
+	} debug;
+	bool tx, rx, en;
+	int ret;
+
+	dev->fw_debug_wm = val ? MCU_FW_LOG_TO_HOST : 0;
+
+	if (dev->fw_debug_bin)
+		val = MCU_FW_LOG_RELAY;
+	else
+		val = dev->fw_debug_wm;
+
+	tx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(1));
+	rx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(2));
+	en = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(0));
+
+	ret = mt7996_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, val);
+	if (ret)
+		return ret;
+
+	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RA; debug++) {
+		if (debug == 67)
+			continue;
+
+		if (debug == DEBUG_RPT_RX)
+			val = en && rx;
+		else
+			val = en && tx;
+
+		ret = mt7996_mcu_fw_dbg_ctrl(dev, debug, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+mt7996_fw_debug_wm_get(void *data, u64 *val)
+{
+	struct mt7996_dev *dev = data;
+
+	*val = dev->fw_debug_wm;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wm, mt7996_fw_debug_wm_get,
+			 mt7996_fw_debug_wm_set, "%lld\n");
+
+static int
+mt7996_fw_debug_wa_set(void *data, u64 val)
+{
+	struct mt7996_dev *dev = data;
+	int ret;
+
+	dev->fw_debug_wa = val ? MCU_FW_LOG_TO_HOST : 0;
+
+	ret = mt7996_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
+	if (ret)
+		return ret;
+
+	return mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_PDMA_RX,
+				 !!dev->fw_debug_wa, 0);
+}
+
+static int
+mt7996_fw_debug_wa_get(void *data, u64 *val)
+{
+	struct mt7996_dev *dev = data;
+
+	*val = dev->fw_debug_wa;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7996_fw_debug_wa_get,
+			 mt7996_fw_debug_wa_set, "%lld\n");
+
+static struct dentry *
+create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
+		   struct rchan_buf *buf, int *is_global)
+{
+	struct dentry *f;
+
+	f = debugfs_create_file("fwlog_data", mode, parent, buf,
+				&relay_file_operations);
+	if (IS_ERR(f))
+		return NULL;
+
+	*is_global = 1;
+
+	return f;
+}
+
+static int
+remove_buf_file_cb(struct dentry *f)
+{
+	debugfs_remove(f);
+
+	return 0;
+}
+
+static int
+mt7996_fw_debug_bin_set(void *data, u64 val)
+{
+	static struct rchan_callbacks relay_cb = {
+		.create_buf_file = create_buf_file_cb,
+		.remove_buf_file = remove_buf_file_cb,
+	};
+	struct mt7996_dev *dev = data;
+
+	if (!dev->relay_fwlog)
+		dev->relay_fwlog = relay_open("fwlog_data", dev->debugfs_dir,
+					      1500, 512, &relay_cb, NULL);
+	if (!dev->relay_fwlog)
+		return -ENOMEM;
+
+	dev->fw_debug_bin = val;
+
+	relay_reset(dev->relay_fwlog);
+
+	return mt7996_fw_debug_wm_set(dev, dev->fw_debug_wm);
+}
+
+static int
+mt7996_fw_debug_bin_get(void *data, u64 *val)
+{
+	struct mt7996_dev *dev = data;
+
+	*val = dev->fw_debug_bin;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_bin, mt7996_fw_debug_bin_get,
+			 mt7996_fw_debug_bin_set, "%lld\n");
+
+static int
+mt7996_fw_util_wa_show(struct seq_file *file, void *data)
+{
+	struct mt7996_dev *dev = file->private;
+
+	if (dev->fw_debug_wa)
+		return mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
+					 MCU_WA_PARAM_CPU_UTIL, 0, 0);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_fw_util_wa);
+
+static void
+mt7996_ampdu_stat_read_phy(struct mt7996_phy *phy, struct seq_file *file)
+{
+	struct mt7996_dev *dev = phy->dev;
+	int bound[15], range[8], i;
+	u8 band_idx = phy->mt76->band_idx;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(band_idx, i));
+
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 2], i % 2) + 1;
+
+	seq_printf(file, "\nPhy %s, Phy band %d\n",
+		   wiphy_name(phy->mt76->hw->wiphy), band_idx);
+
+	seq_printf(file, "Length: %8d | ", bound[0]);
+	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
+		seq_printf(file, "%3d -%3d | ",
+			   bound[i] + 1, bound[i + 1]);
+
+	seq_puts(file, "\nCount:  ");
+	for (i = 0; i < ARRAY_SIZE(bound); i++)
+		seq_printf(file, "%8d | ", phy->mt76->aggr_stats[i]);
+	seq_puts(file, "\n");
+
+	seq_printf(file, "BA miss count: %d\n", phy->mib.ba_miss_cnt);
+}
+
+static void
+mt7996_txbf_stat_read_phy(struct mt7996_phy *phy, struct seq_file *s)
+{
+	static const char * const bw[] = {
+		"BW20", "BW40", "BW80", "BW160"
+	};
+	struct mib_stats *mib = &phy->mib;
+
+	/* Tx Beamformer monitor */
+	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
+
+	seq_printf(s, "iBF: %d, eBF: %d\n",
+		   mib->tx_bf_ibf_ppdu_cnt,
+		   mib->tx_bf_ebf_ppdu_cnt);
+
+	/* Tx Beamformer Rx feedback monitor */
+	seq_puts(s, "Tx Beamformer Rx feedback statistics: ");
+
+	seq_printf(s, "All: %d, HE: %d, VHT: %d, HT: %d, ",
+		   mib->tx_bf_rx_fb_all_cnt,
+		   mib->tx_bf_rx_fb_he_cnt,
+		   mib->tx_bf_rx_fb_vht_cnt,
+		   mib->tx_bf_rx_fb_ht_cnt);
+
+	seq_printf(s, "%s, NC: %d, NR: %d\n",
+		   bw[mib->tx_bf_rx_fb_bw],
+		   mib->tx_bf_rx_fb_nc_cnt,
+		   mib->tx_bf_rx_fb_nr_cnt);
+
+	/* Tx Beamformee Rx NDPA & Tx feedback report */
+	seq_printf(s, "Tx Beamformee successful feedback frames: %d\n",
+		   mib->tx_bf_fb_cpl_cnt);
+	seq_printf(s, "Tx Beamformee feedback triggered counts: %d\n",
+		   mib->tx_bf_fb_trig_cnt);
+
+	/* Tx SU & MU counters */
+	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
+		   mib->tx_mu_bf_cnt);
+	seq_printf(s, "Tx multi-user MPDU counts: %d\n", mib->tx_mu_mpdu_cnt);
+	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n",
+		   mib->tx_mu_acked_mpdu_cnt);
+	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
+		   mib->tx_su_acked_mpdu_cnt);
+
+	seq_puts(s, "\n");
+}
+
+static int
+mt7996_tx_stats_show(struct seq_file *file, void *data)
+{
+	struct mt7996_phy *phy = file->private;
+	struct mt7996_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	int i;
+	u32 attempts, success, per;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7996_mac_update_stats(phy);
+	mt7996_ampdu_stat_read_phy(phy, file);
+
+	attempts = mib->tx_mpdu_attempts_cnt;
+	success = mib->tx_mpdu_success_cnt;
+	per = attempts ? 100 - success * 100 / attempts : 100;
+	seq_printf(file, "Tx attempts: %8u (MPDUs)\n", attempts);
+	seq_printf(file, "Tx success: %8u (MPDUs)\n", success);
+	seq_printf(file, "Tx PER: %u%%\n", per);
+
+	mt7996_txbf_stat_read_phy(phy, file);
+
+	/* Tx amsdu info */
+	seq_puts(file, "Tx MSDU statistics:\n");
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %8d ",
+			   i + 1, mib->tx_amsdu[i]);
+		if (mib->tx_amsdu_cnt)
+			seq_printf(file, "(%3d%%)\n",
+				   mib->tx_amsdu[i] * 100 / mib->tx_amsdu_cnt);
+		else
+			seq_puts(file, "\n");
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_tx_stats);
+
+static void
+mt7996_hw_queue_read(struct seq_file *s, u32 size,
+		     const struct hw_queue_map *map)
+{
+	struct mt7996_phy *phy = s->private;
+	struct mt7996_dev *dev = phy->dev;
+	u32 i, val;
+
+	val = mt76_rr(dev, MT_FL_Q_EMPTY);
+	for (i = 0; i < size; i++) {
+		u32 ctrl, head, tail, queued;
+
+		if (val & BIT(map[i].index))
+			continue;
+
+		ctrl = BIT(31) | (map[i].pid << 10) | (map[i].qid << 24);
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl);
+
+		head = mt76_get_field(dev, MT_FL_Q2_CTRL,
+				      GENMASK(11, 0));
+		tail = mt76_get_field(dev, MT_FL_Q2_CTRL,
+				      GENMASK(27, 16));
+		queued = mt76_get_field(dev, MT_FL_Q3_CTRL,
+					GENMASK(11, 0));
+
+		seq_printf(s, "\t%s: ", map[i].name);
+		seq_printf(s, "queued:0x%03x head:0x%03x tail:0x%03x\n",
+			   queued, head, tail);
+	}
+}
+
+static void
+mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = msta->vif->phy->dev;
+	struct seq_file *s = data;
+	u8 ac;
+
+	for (ac = 0; ac < 4; ac++) {
+		u32 qlen, ctrl, val;
+		u32 idx = msta->wcid.idx >> 5;
+		u8 offs = msta->wcid.idx & GENMASK(4, 0);
+
+		ctrl = BIT(31) | BIT(11) | (ac << 24);
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(ac, idx));
+
+		if (val & BIT(offs))
+			continue;
+
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
+		qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
+				      GENMASK(11, 0));
+		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
+			   sta->addr, msta->wcid.idx,
+			   msta->vif->mt76.wmm_idx, ac, qlen);
+	}
+}
+
+static int
+mt7996_hw_queues_show(struct seq_file *file, void *data)
+{
+	struct mt7996_phy *phy = file->private;
+	struct mt7996_dev *dev = phy->dev;
+	static const struct hw_queue_map ple_queue_map[] = {
+		{ "CPU_Q0",  0,  1, MT_CTX0	      },
+		{ "CPU_Q1",  1,  1, MT_CTX0 + 1	      },
+		{ "CPU_Q2",  2,  1, MT_CTX0 + 2	      },
+		{ "CPU_Q3",  3,  1, MT_CTX0 + 3	      },
+		{ "ALTX_Q0", 8,  2, MT_LMAC_ALTX0     },
+		{ "BMC_Q0",  9,  2, MT_LMAC_BMC0      },
+		{ "BCN_Q0",  10, 2, MT_LMAC_BCN0      },
+		{ "PSMP_Q0", 11, 2, MT_LMAC_PSMP0     },
+		{ "ALTX_Q1", 12, 2, MT_LMAC_ALTX0 + 4 },
+		{ "BMC_Q1",  13, 2, MT_LMAC_BMC0  + 4 },
+		{ "BCN_Q1",  14, 2, MT_LMAC_BCN0  + 4 },
+		{ "PSMP_Q1", 15, 2, MT_LMAC_PSMP0 + 4 },
+	};
+	static const struct hw_queue_map pse_queue_map[] = {
+		{ "CPU Q0",  0,  1, MT_CTX0	      },
+		{ "CPU Q1",  1,  1, MT_CTX0 + 1	      },
+		{ "CPU Q2",  2,  1, MT_CTX0 + 2	      },
+		{ "CPU Q3",  3,  1, MT_CTX0 + 3	      },
+		{ "HIF_Q0",  8,  0, MT_HIF0	      },
+		{ "HIF_Q1",  9,  0, MT_HIF0 + 1	      },
+		{ "HIF_Q2",  10, 0, MT_HIF0 + 2	      },
+		{ "HIF_Q3",  11, 0, MT_HIF0 + 3	      },
+		{ "HIF_Q4",  12, 0, MT_HIF0 + 4	      },
+		{ "HIF_Q5",  13, 0, MT_HIF0 + 5	      },
+		{ "LMAC_Q",  16, 2, 0		      },
+		{ "MDP_TXQ", 17, 2, 1		      },
+		{ "MDP_RXQ", 18, 2, 2		      },
+		{ "SEC_TXQ", 19, 2, 3		      },
+		{ "SEC_RXQ", 20, 2, 4		      },
+	};
+	u32 val, head, tail;
+
+	/* ple queue */
+	val = mt76_rr(dev, MT_PLE_FREEPG_CNT);
+	head = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(11, 0));
+	tail = mt76_get_field(dev, MT_PLE_FREEPG_HEAD_TAIL, GENMASK(27, 16));
+	seq_puts(file, "PLE page info:\n");
+	seq_printf(file,
+		   "\tTotal free page: 0x%08x head: 0x%03x tail: 0x%03x\n",
+		   val, head, tail);
+
+	val = mt76_rr(dev, MT_PLE_PG_HIF_GROUP);
+	head = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(11, 0));
+	tail = mt76_get_field(dev, MT_PLE_HIF_PG_INFO, GENMASK(27, 16));
+	seq_printf(file, "\tHIF free page: 0x%03x res: 0x%03x used: 0x%03x\n",
+		   val, head, tail);
+
+	seq_puts(file, "PLE non-empty queue info:\n");
+	mt7996_hw_queue_read(file, ARRAY_SIZE(ple_queue_map),
+			     &ple_queue_map[0]);
+
+	/* iterate per-sta ple queue */
+	ieee80211_iterate_stations_atomic(phy->mt76->hw,
+					  mt7996_sta_hw_queue_read, file);
+	/* pse queue */
+	seq_puts(file, "PSE non-empty queue info:\n");
+	mt7996_hw_queue_read(file, ARRAY_SIZE(pse_queue_map),
+			     &pse_queue_map[0]);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_hw_queues);
+
+static int
+mt7996_xmit_queues_show(struct seq_file *file, void *data)
+{
+	struct mt7996_phy *phy = file->private;
+	struct mt7996_dev *dev = phy->dev;
+	struct {
+		struct mt76_queue *q;
+		char *queue;
+	} queue_map[] = {
+		{ phy->mt76->q_tx[MT_TXQ_BE],	 "   MAIN"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM],	 "  MCUWM"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_WA],	 "  MCUWA"  },
+		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWDL" },
+	};
+	int i;
+
+	seq_puts(file, "     queue | hw-queued |      head |      tail |\n");
+	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
+		struct mt76_queue *q = queue_map[i].q;
+
+		if (!q)
+			continue;
+
+		seq_printf(file, "   %s | %9d | %9d | %9d |\n",
+			   queue_map[i].queue, q->queued, q->head,
+			   q->tail);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_xmit_queues);
+
+static int
+mt7996_twt_stats(struct seq_file *s, void *data)
+{
+	struct mt7996_dev *dev = dev_get_drvdata(s->private);
+	struct mt7996_twt_flow *iter;
+
+	rcu_read_lock();
+
+	seq_puts(s, "     wcid |       id |    flags |      exp | mantissa");
+	seq_puts(s, " | duration |            tsf |\n");
+	list_for_each_entry_rcu(iter, &dev->twt_list, list)
+		seq_printf(s,
+			   "%9d | %8d | %5c%c%c%c | %8d | %8d | %8d | %14lld |\n",
+			   iter->wcid, iter->id,
+			   iter->sched ? 's' : 'u',
+			   iter->protection ? 'p' : '-',
+			   iter->trigger ? 't' : '-',
+			   iter->flowtype ? '-' : 'a',
+			   iter->exp, iter->mantissa,
+			   iter->duration, iter->tsf);
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/* The index of RF registers use the generic regidx, combined with two parts:
+ * WF selection [31:24] and offset [23:0].
+ */
+static int
+mt7996_rf_regval_get(void *data, u64 *val)
+{
+	struct mt7996_dev *dev = data;
+	u32 regval;
+	int ret;
+
+	ret = mt7996_mcu_rf_regval(dev, dev->mt76.debugfs_reg, &regval, false);
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpu(regval);
+
+	return 0;
+}
+
+static int
+mt7996_rf_regval_set(void *data, u64 val)
+{
+	struct mt7996_dev *dev = data;
+
+	return mt7996_mcu_rf_regval(dev, dev->mt76.debugfs_reg, (u32 *)&val, true);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_regval, mt7996_rf_regval_get,
+			 mt7996_rf_regval_set, "0x%08llx\n");
+
+int mt7996_init_debugfs(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct dentry *dir;
+
+	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
+	if (!dir)
+		return -ENOMEM;
+	debugfs_create_file("hw-queues", 0400, dir, phy,
+			    &mt7996_hw_queues_fops);
+	debugfs_create_file("xmit-queues", 0400, dir, phy,
+			    &mt7996_xmit_queues_fops);
+	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7996_tx_stats_fops);
+	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
+	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
+	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
+	/* TODO: wm fw cpu utilization */
+	debugfs_create_file("fw_util_wa", 0400, dir, dev,
+			    &mt7996_fw_util_wa_fops);
+	debugfs_create_file("implicit_txbf", 0600, dir, dev,
+			    &fops_implicit_txbf);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
+				    mt7996_twt_stats);
+	debugfs_create_file("fw_ser", 0600, dir, phy, &mt7996_fw_ser_ops);
+	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
+
+	if (phy->mt76->cap.has_5ghz) {
+		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
+				   &dev->hw_pattern);
+		debugfs_create_file("radar_trigger", 0200, dir, dev,
+				    &fops_radar_trigger);
+		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
+					    mt7996_rdd_monitor);
+	}
+
+	if (phy == &dev->phy)
+		dev->debugfs_dir = dir;
+
+	return 0;
+}
+
+static void
+mt7996_debugfs_write_fwlog(struct mt7996_dev *dev, const void *hdr, int hdrlen,
+			   const void *data, int len)
+{
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
+	void *dest;
+
+	spin_lock_irqsave(&lock, flags);
+	dest = relay_reserve(dev->relay_fwlog, hdrlen + len + 4);
+	if (dest) {
+		*(u32 *)dest = hdrlen + len;
+		dest += 4;
+
+		if (hdrlen) {
+			memcpy(dest, hdr, hdrlen);
+			dest += hdrlen;
+		}
+
+		memcpy(dest, data, len);
+		relay_flush(dev->relay_fwlog);
+	}
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len)
+{
+	struct {
+		__le32 magic;
+		u8 version;
+		u8 _rsv;
+		__le16 serial_id;
+		__le32 timestamp;
+		__le16 msg_type;
+		__le16 len;
+	} hdr = {
+		.version = 0x1,
+		.magic = cpu_to_le32(FW_BIN_LOG_MAGIC),
+		.msg_type = cpu_to_le16(PKT_TYPE_RX_FW_MONITOR),
+	};
+
+	if (!dev->relay_fwlog)
+		return;
+
+	hdr.serial_id = cpu_to_le16(dev->fw_debug_seq++);
+	hdr.timestamp = cpu_to_le32(mt76_rr(dev, MT_LPON_FRCR(0)));
+	hdr.len = *(__le16 *)data;
+	mt7996_debugfs_write_fwlog(dev, &hdr, sizeof(hdr), data, len);
+}
+
+bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len)
+{
+	if (get_unaligned_le32(data) != FW_BIN_LOG_MAGIC)
+		return false;
+
+	if (dev->relay_fwlog)
+		mt7996_debugfs_write_fwlog(dev, NULL, 0, data, len);
+
+	return true;
+}
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+/** per-station debugfs **/
+
+static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+#define SHORT_PREAMBLE 0
+#define LONG_PREAMBLE 1
+	struct ieee80211_sta *sta = file->private_data;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = msta->vif->phy->dev;
+	struct ra_rate phy = {};
+	char buf[100];
+	int ret;
+	u16 gi, ltf;
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
+	/* mode - cck: 0, ofdm: 1, ht: 2, gf: 3, vht: 4, he_su: 8, he_er: 9
+	 * bw - bw20: 0, bw40: 1, bw80: 2, bw160: 3
+	 * nss - vht: 1~4, he: 1~4, others: ignore
+	 * mcs - cck: 0~4, ofdm: 0~7, ht: 0~32, vht: 0~9, he_su: 0~11, he_er: 0~2
+	 * gi - (ht/vht) lgi: 0, sgi: 1; (he) 0.8us: 0, 1.6us: 1, 3.2us: 2
+	 * preamble - short: 1, long: 0
+	 * ldpc - off: 0, on: 1
+	 * stbc - off: 0, on: 1
+	 * ltf - 1xltf: 0, 2xltf: 1, 4xltf: 2
+	 */
+	if (sscanf(buf, "%hhu %hhu %hhu %hhu %hu %hhu %hhu %hhu %hhu %hu",
+		   &phy.mode, &phy.bw, &phy.mcs, &phy.nss, &gi,
+		   &phy.preamble, &phy.stbc, &phy.ldpc, &phy.spe, &ltf) != 10) {
+		dev_warn(dev->mt76.dev,
+			 "format: Mode BW MCS NSS GI Preamble STBC LDPC SPE ltf\n");
+		goto out;
+	}
+
+	phy.wlan_idx = cpu_to_le16(msta->wcid.idx);
+	phy.gi = cpu_to_le16(gi);
+	phy.ltf = cpu_to_le16(ltf);
+	phy.ldpc = phy.ldpc ? 7 : 0;
+	phy.preamble = phy.preamble ? SHORT_PREAMBLE : LONG_PREAMBLE;
+
+	ret = mt7996_mcu_set_fixed_rate_ctrl(dev, &phy, 0);
+	if (ret)
+		return -EFAULT;
+
+out:
+	return count;
+}
+
+static const struct file_operations fops_fixed_rate = {
+	.write = mt7996_sta_fixed_rate_set,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int
+mt7996_queues_show(struct seq_file *s, void *data)
+{
+	struct ieee80211_sta *sta = s->private;
+
+	mt7996_sta_hw_queue_read(s, sta);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7996_queues);
+
+void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir)
+{
+	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
+	debugfs_create_file("hw-queues", 0400, dir, sta, &mt7996_queues_fops);
+}
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
new file mode 100644
index 000000000000..c09fe4274935
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include "mt7996.h"
+#include "../dma.h"
+#include "mac.h"
+
+static int mt7996_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt7996_dev *dev;
+
+	dev = container_of(napi, struct mt7996_dev, mt76.tx_napi);
+
+	mt76_connac_tx_cleanup(&dev->mt76);
+	if (napi_complete_done(napi, 0))
+		mt7996_irq_enable(dev, MT_INT_TX_DONE_MCU);
+
+	return 0;
+}
+
+static void mt7996_dma_config(struct mt7996_dev *dev)
+{
+#define Q_CONFIG(q, wfdma, int, id) do {		\
+	if (wfdma)					\
+		dev->q_wfdma_mask |= (1 << (q));	\
+	dev->q_int_mask[(q)] = int;			\
+	dev->q_id[(q)] = id;				\
+} while (0)
+
+#define MCUQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(q, (wfdma), (int), (id))
+#define RXQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(__RXQ(q), (wfdma), (int), (id))
+#define TXQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(__TXQ(q), (wfdma), (int), (id))
+
+	/* rx queue */
+	RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7996_RXQ_MCU_WM);
+	RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7996_RXQ_MCU_WA);
+
+	/* band0/band1 */
+	RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7996_RXQ_BAND0);
+	RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN, MT7996_RXQ_MCU_WA_MAIN);
+
+	/* band2 */
+	RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
+	RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI, MT7996_RXQ_MCU_WA_TRI);
+
+	/* data tx queue */
+	TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
+	TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
+	TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2, MT7996_TXQ_BAND2);
+
+	/* mcu tx queue */
+	MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7996_TXQ_MCU_WM);
+	MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA, MT7996_TXQ_MCU_WA);
+	MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7996_TXQ_FWDL);
+}
+
+static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
+{
+#define PREFETCH(_base, _depth)	((_base) << 16 | (_depth))
+	/* prefetch SRAM wrapping boundary for tx/rx ring. */
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x0, 0x2));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x20, 0x2));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0xc0, 0x2));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(2) + ofs, PREFETCH(0xe0, 0x4));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x120, 0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x140, 0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x160, 0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2_WA) + ofs, PREFETCH(0x180, 0x2));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x1a0, 0x10));
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2) + ofs, PREFETCH(0x2a0, 0x10));
+
+	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT1 + ofs, WF_WFDMA0_GLO_CFG_EXT1_CALC_MODE);
+}
+
+void mt7996_dma_prefetch(struct mt7996_dev *dev)
+{
+	__mt7996_dma_prefetch(dev, 0);
+	if (dev->hif2)
+		__mt7996_dma_prefetch(dev, MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0));
+}
+
+static void mt7996_dma_disable(struct mt7996_dev *dev, bool reset)
+{
+	u32 hif1_ofs = 0;
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	if (reset) {
+		mt76_clear(dev, MT_WFDMA0_RST,
+			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			   MT_WFDMA0_RST_LOGIC_RST);
+
+		mt76_set(dev, MT_WFDMA0_RST,
+			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			 MT_WFDMA0_RST_LOGIC_RST);
+
+		if (dev->hif2) {
+			mt76_clear(dev, MT_WFDMA0_RST + hif1_ofs,
+				   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+				   MT_WFDMA0_RST_LOGIC_RST);
+
+			mt76_set(dev, MT_WFDMA0_RST + hif1_ofs,
+				 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+				 MT_WFDMA0_RST_LOGIC_RST);
+		}
+	}
+
+	/* disable */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (dev->hif2) {
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+			   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+	}
+}
+
+static int mt7996_dma_enable(struct mt7996_dev *dev)
+{
+	u32 hif1_ofs = 0;
+	u32 irq_mask;
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	/* reset dma idx */
+	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR + hif1_ofs, ~0);
+
+	/* configure delay interrupt off */
+	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
+	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG1, 0);
+	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG2, 0);
+
+	if (dev->hif2) {
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG1 + hif1_ofs, 0);
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG2 + hif1_ofs, 0);
+	}
+
+	/* configure perfetch settings */
+	mt7996_dma_prefetch(dev);
+
+	/* hif wait WFDMA idle */
+	mt76_set(dev, MT_WFDMA0_BUSY_ENA,
+		 MT_WFDMA0_BUSY_ENA_TX_FIFO0 |
+		 MT_WFDMA0_BUSY_ENA_TX_FIFO1 |
+		 MT_WFDMA0_BUSY_ENA_RX_FIFO);
+
+	if (dev->hif2)
+		mt76_set(dev, MT_WFDMA0_BUSY_ENA + hif1_ofs,
+			 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0 |
+			 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1 |
+			 MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO);
+
+	mt76_poll(dev, MT_WFDMA_EXT_CSR_HIF_MISC,
+		  MT_WFDMA_EXT_CSR_HIF_MISC_BUSY, 0, 1000);
+
+	/* set WFDMA Tx/Rx */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	/* GLO_CFG_EXT0 */
+	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT0,
+		 WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD |
+		 WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE);
+
+	/* GLO_CFG_EXT1 */
+	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT1,
+		 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
+
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+		/* GLO_CFG_EXT0 */
+		mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
+			 WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD |
+			 WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE);
+
+		/* GLO_CFG_EXT1 */
+		mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT1 + hif1_ofs,
+			 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
+
+		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
+	}
+
+	if (dev->hif2) {
+		/* fix hardware limitation, pcie1's rx ring3 is not available
+		 * so, redirect pcie0 rx ring3 interrupt to pcie1
+		 */
+		mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL,
+			 MT_WFDMA0_RX_INT_SEL_RING3);
+
+		/* TODO: redirect rx ring6 interrupt to pcie0 for wed function */
+	}
+
+	/* enable interrupts for TX/RX rings */
+	irq_mask = MT_INT_RX_DONE_MCU |
+		   MT_INT_TX_DONE_MCU |
+		   MT_INT_MCU_CMD;
+
+	if (!dev->mphy.band_idx)
+		irq_mask |= MT_INT_BAND0_RX_DONE;
+
+	if (dev->dbdc_support)
+		irq_mask |= MT_INT_BAND1_RX_DONE;
+
+	if (dev->tbtc_support)
+		irq_mask |= MT_INT_BAND2_RX_DONE;
+
+	mt7996_irq_enable(dev, irq_mask);
+
+	return 0;
+}
+
+int mt7996_dma_init(struct mt7996_dev *dev)
+{
+	u32 hif1_ofs = 0;
+	int ret;
+
+	mt7996_dma_config(dev);
+
+	mt76_dma_attach(&dev->mt76);
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	mt7996_dma_disable(dev, true);
+
+	/* init tx queue */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76,
+					 MT_TXQ_ID(dev->mphy.band_idx),
+					 MT7996_TX_RING_SIZE,
+					 MT_TXQ_RING_BASE(0), 0);
+	if (ret)
+		return ret;
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM,
+				  MT_MCUQ_ID(MT_MCUQ_WM),
+				  MT7996_TX_MCU_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_WM));
+	if (ret)
+		return ret;
+
+	/* command to WA */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA,
+				  MT_MCUQ_ID(MT_MCUQ_WA),
+				  MT7996_TX_MCU_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_WA));
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL,
+				  MT_MCUQ_ID(MT_MCUQ_FWDL),
+				  MT7996_TX_FWDL_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_FWDL));
+	if (ret)
+		return ret;
+
+	/* event from WM */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT_RXQ_ID(MT_RXQ_MCU),
+			       MT7996_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MCU));
+	if (ret)
+		return ret;
+
+	/* event from WA */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT_RXQ_ID(MT_RXQ_MCU_WA),
+			       MT7996_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MCU_WA));
+	if (ret)
+		return ret;
+
+	/* rx data queue for band0 and band1 */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT_RXQ_ID(MT_RXQ_MAIN),
+			       MT7996_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MAIN));
+	if (ret)
+		return ret;
+
+	/* tx free notify event from WA for band0 */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
+			       MT_RXQ_ID(MT_RXQ_MAIN_WA),
+			       MT7996_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA));
+	if (ret)
+		return ret;
+
+	if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
+		/* rx data queue for band2 */
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2],
+				       MT_RXQ_ID(MT_RXQ_BAND2),
+				       MT7996_RX_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs);
+		if (ret)
+			return ret;
+
+		/* tx free notify event from WA for band2
+		 * use pcie0's rx ring3, but, redirect pcie0 rx ring3 interrupt to pcie1
+		 */
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2_WA],
+				       MT_RXQ_ID(MT_RXQ_BAND2_WA),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_BAND2_WA));
+		if (ret)
+			return ret;
+	}
+
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7996_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	mt7996_dma_enable(dev);
+
+	return 0;
+}
+
+void mt7996_dma_cleanup(struct mt7996_dev *dev)
+{
+	mt7996_dma_disable(dev, true);
+
+	mt76_dma_cleanup(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
new file mode 100644
index 000000000000..b9f62bedbc48
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/firmware.h>
+#include "mt7996.h"
+#include "eeprom.h"
+
+static int mt7996_check_eeprom(struct mt7996_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val = get_unaligned_le16(eeprom);
+
+	switch (val) {
+	case 0x7990:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static char *mt7996_eeprom_name(struct mt7996_dev *dev)
+{
+	/* reserve for future variants */
+	return MT7996_EEPROM_DEFAULT;
+}
+
+static int
+mt7996_eeprom_load_default(struct mt7996_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	const struct firmware *fw = NULL;
+	int ret;
+
+	ret = request_firmware(&fw, mt7996_eeprom_name(dev), dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data) {
+		dev_err(dev->mt76.dev, "Invalid default bin\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(eeprom, fw->data, MT7996_EEPROM_SIZE);
+	dev->flash_mode = true;
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7996_eeprom_load(struct mt7996_dev *dev)
+{
+	int ret;
+
+	ret = mt76_eeprom_init(&dev->mt76, MT7996_EEPROM_SIZE);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		dev->flash_mode = true;
+	} else {
+		u8 free_block_num;
+		u32 block_num, i;
+
+		/* TODO: check free block event */
+		mt7996_mcu_get_eeprom_free_block(dev, &free_block_num);
+		/* efuse info not enough */
+		if (free_block_num >= 59)
+			return -EINVAL;
+
+		/* read eeprom data from efuse */
+		block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, MT7996_EEPROM_BLOCK_SIZE);
+		for (i = 0; i < block_num; i++)
+			mt7996_mcu_get_eeprom(dev, i * MT7996_EEPROM_BLOCK_SIZE);
+	}
+
+	return mt7996_check_eeprom(dev);
+}
+
+static int mt7996_eeprom_parse_band_config(struct mt7996_phy *phy)
+{
+	u8 *eeprom = phy->dev->mt76.eeprom.data;
+	u32 val = eeprom[MT_EE_WIFI_CONF];
+	int ret = 0;
+
+	switch (phy->mt76->band_idx) {
+	case MT_BAND1:
+		val = FIELD_GET(MT_EE_WIFI_CONF1_BAND_SEL, val);
+		break;
+	case MT_BAND2:
+		val = eeprom[MT_EE_WIFI_CONF + 1];
+		val = FIELD_GET(MT_EE_WIFI_CONF2_BAND_SEL, val);
+		break;
+	default:
+		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+		break;
+	}
+
+	switch (val) {
+	case MT_EE_BAND_SEL_2GHZ:
+		phy->mt76->cap.has_2ghz = true;
+		break;
+	case MT_EE_BAND_SEL_5GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	case MT_EE_BAND_SEL_6GHZ:
+		phy->mt76->cap.has_6ghz = true;
+		break;
+	case MT_EE_BAND_SEL_5GHZ_6GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		phy->mt76->cap.has_6ghz = true;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
+{
+	u8 path, nss, band_idx = phy->mt76->band_idx;
+	u8 *eeprom = dev->mt76.eeprom.data;
+	struct mt76_phy *mphy = phy->mt76;
+
+	switch (band_idx) {
+	case MT_BAND1:
+		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND1,
+				 eeprom[MT_EE_WIFI_CONF + 2]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND1,
+				eeprom[MT_EE_WIFI_CONF + 5]);
+		break;
+	case MT_BAND2:
+		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND2,
+				 eeprom[MT_EE_WIFI_CONF + 2]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND2,
+				eeprom[MT_EE_WIFI_CONF + 5]);
+		break;
+	default:
+		path = FIELD_GET(MT_EE_WIFI_CONF1_TX_PATH_BAND0,
+				 eeprom[MT_EE_WIFI_CONF + 1]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF4_STREAM_NUM_BAND0,
+				eeprom[MT_EE_WIFI_CONF + 4]);
+		break;
+	}
+
+	if (!path || path > 4)
+		path = 4;
+
+	nss = min_t(u8, min_t(u8, 4, nss), path);
+
+	mphy->antenna_mask = BIT(nss) - 1;
+	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
+	dev->chainmask |= mphy->chainmask;
+	if (band_idx < MT_BAND2)
+		dev->chainshift[band_idx + 1] = dev->chainshift[band_idx] +
+						hweight16(mphy->chainmask);
+
+	return mt7996_eeprom_parse_band_config(phy);
+}
+
+int mt7996_eeprom_init(struct mt7996_dev *dev)
+{
+	int ret;
+
+	ret = mt7996_eeprom_load(dev);
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			return ret;
+
+		dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
+		ret = mt7996_eeprom_load_default(dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = mt7996_eeprom_parse_hw_cap(dev, &dev->phy);
+	if (ret < 0)
+		return ret;
+
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR, ETH_ALEN);
+	mt76_eeprom_override(&dev->mphy);
+
+	return 0;
+}
+
+int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
+				   struct ieee80211_channel *chan)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	int target_power;
+
+	if (chan->band == NL80211_BAND_5GHZ)
+		target_power = eeprom[MT_EE_TX0_POWER_5G +
+				      mt7996_get_channel_group_5g(chan->hw_value)];
+	else if (chan->band == NL80211_BAND_6GHZ)
+		target_power = eeprom[MT_EE_TX0_POWER_6G +
+				      mt7996_get_channel_group_6g(chan->hw_value)];
+	else
+		target_power = eeprom[MT_EE_TX0_POWER_2G];
+
+	return target_power;
+}
+
+s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u32 val;
+	s8 delta;
+
+	if (band == NL80211_BAND_5GHZ)
+		val = eeprom[MT_EE_RATE_DELTA_5G];
+	else if (band == NL80211_BAND_6GHZ)
+		val = eeprom[MT_EE_RATE_DELTA_6G];
+	else
+		val = eeprom[MT_EE_RATE_DELTA_2G];
+
+	if (!(val & MT_EE_RATE_DELTA_EN))
+		return 0;
+
+	delta = FIELD_GET(MT_EE_RATE_DELTA_MASK, val);
+
+	return val & MT_EE_RATE_DELTA_SIGN ? delta : -delta;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
new file mode 100644
index 000000000000..8da599e0abea
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_EEPROM_H
+#define __MT7996_EEPROM_H
+
+#include "mt7996.h"
+
+enum mt7996_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_MAC_ADDR2 =	0x00a,
+	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_MAC_ADDR3 =	0x2c0,
+	MT_EE_RATE_DELTA_2G =	0x1400,
+	MT_EE_RATE_DELTA_5G =	0x147d,
+	MT_EE_RATE_DELTA_6G =	0x154a,
+	MT_EE_TX0_POWER_2G =	0x1300,
+	MT_EE_TX0_POWER_5G =	0x1301,
+	MT_EE_TX0_POWER_6G =	0x1310,
+
+	__MT_EE_MAX =	0x1dff,
+};
+
+#define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_BAND_SEL		GENMASK(2, 0)
+
+#define MT_EE_WIFI_CONF1_TX_PATH_BAND0		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF4_STREAM_NUM_BAND0	GENMASK(5, 3)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(5, 3)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(2, 0)
+
+#define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
+#define MT_EE_RATE_DELTA_SIGN			BIT(6)
+#define MT_EE_RATE_DELTA_EN			BIT(7)
+
+enum mt7996_eeprom_band {
+	MT_EE_BAND_SEL_DEFAULT,
+	MT_EE_BAND_SEL_2GHZ,
+	MT_EE_BAND_SEL_5GHZ,
+	MT_EE_BAND_SEL_6GHZ,
+	MT_EE_BAND_SEL_5GHZ_6GHZ,
+};
+
+static inline int
+mt7996_get_channel_group_5g(int channel)
+{
+	if (channel <= 64)
+		return 0;
+	if (channel <= 96)
+		return 1;
+	if (channel <= 128)
+		return 2;
+	if (channel <= 144)
+		return 3;
+	return 4;
+}
+
+static inline int
+mt7996_get_channel_group_6g(int channel)
+{
+	if (channel <= 29)
+		return 0;
+
+	return DIV_ROUND_UP(channel - 29, 32);
+}
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
new file mode 100644
index 000000000000..cd1657e3585d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/thermal.h>
+#include "mt7996.h"
+#include "mac.h"
+#include "mcu.h"
+#include "eeprom.h"
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_ADHOC)
+	}, {
+		.max = 16,
+		.types = BIT(NL80211_IFTYPE_AP)
+#ifdef CONFIG_MAC80211_MESH
+			 | BIT(NL80211_IFTYPE_MESH_POINT)
+#endif
+	}, {
+		.max = MT7996_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7996_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
+	}
+};
+
+static void mt7996_led_set_config(struct led_classdev *led_cdev,
+				  u8 delay_on, u8 delay_off)
+{
+	struct mt7996_dev *dev;
+	struct mt76_dev *mt76;
+	u32 val;
+
+	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	dev = container_of(mt76, struct mt7996_dev, mt76);
+
+	/* select TX blink mode, 2: only data frames */
+	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
+
+	/* enable LED */
+	mt76_wr(dev, MT_LED_EN(0), 1);
+
+	/* set LED Tx blink on/off time */
+	val = FIELD_PREP(MT_LED_TX_BLINK_ON_MASK, delay_on) |
+	      FIELD_PREP(MT_LED_TX_BLINK_OFF_MASK, delay_off);
+	mt76_wr(dev, MT_LED_TX_BLINK(0), val);
+
+	/* control LED */
+	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
+	if (dev->mt76.led_al)
+		val |= MT_LED_CTRL_POLARITY;
+
+	mt76_wr(dev, MT_LED_CTRL(0), val);
+	mt76_clear(dev, MT_LED_CTRL(0), MT_LED_CTRL_KICK);
+}
+
+static int mt7996_led_set_blink(struct led_classdev *led_cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	u16 delta_on = 0, delta_off = 0;
+
+#define HW_TICK		10
+#define TO_HW_TICK(_t)	(((_t) > HW_TICK) ? ((_t) / HW_TICK) : HW_TICK)
+
+	if (*delay_on)
+		delta_on = TO_HW_TICK(*delay_on);
+	if (*delay_off)
+		delta_off = TO_HW_TICK(*delay_off);
+
+	mt7996_led_set_config(led_cdev, delta_on, delta_off);
+
+	return 0;
+}
+
+static void mt7996_led_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
+{
+	if (!brightness)
+		mt7996_led_set_config(led_cdev, 0, 0xff);
+	else
+		mt7996_led_set_config(led_cdev, 0xff, 0);
+}
+
+static void
+mt7996_init_txpower(struct mt7996_dev *dev,
+		    struct ieee80211_supported_band *sband)
+{
+	int i, nss = hweight8(dev->mphy.antenna_mask);
+	int nss_delta = mt76_tx_power_nss_delta(nss);
+	int pwr_delta = mt7996_eeprom_get_power_delta(dev, sband->band);
+	struct mt76_power_limits limits;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *chan = &sband->channels[i];
+		int target_power = mt7996_eeprom_get_target_power(dev, chan);
+
+		target_power += pwr_delta;
+		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+							  &limits,
+							  target_power);
+		target_power += nss_delta;
+		target_power = DIV_ROUND_UP(target_power, 2);
+		chan->max_power = min_t(int, chan->max_reg_power,
+					target_power);
+		chan->orig_mpwr = target_power;
+	}
+}
+
+static void
+mt7996_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		mt7996_mcu_rdd_background_enable(phy, NULL);
+
+	mt7996_init_txpower(dev, &phy->mt76->sband_2g.sband);
+	mt7996_init_txpower(dev, &phy->mt76->sband_5g.sband);
+	mt7996_init_txpower(dev, &phy->mt76->sband_6g.sband);
+
+	phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+	mt7996_dfs_init_radar_detector(phy);
+}
+
+static void
+mt7996_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt76_dev *mdev = &phy->dev->mt76;
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->netdev_features = NETIF_F_RXCSUM;
+
+	hw->radiotap_timestamp.units_pos =
+		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7996_sta);
+	hw->vif_data_size = sizeof(struct mt7996_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->reg_notifier = mt7996_regd_notifier;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
+
+	if (!mdev->dev->of_node ||
+	    !of_property_read_bool(mdev->dev->of_node,
+				   "mediatek,disable-radar-background"))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
+
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	hw->max_tx_fragments = 4;
+
+	if (phy->mt76->cap.has_2ghz)
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+	if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
+	}
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7996_set_stream_vht_txbf_caps(phy);
+	mt7996_set_stream_he_caps(phy);
+
+	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
+	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
+}
+
+static void
+mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
+{
+	u32 mask, set;
+
+	/* clear estimated value of EIFS for Rx duration & OBSS time */
+	mt76_wr(dev, MT_WF_RMAC_RSVD0(band), MT_WF_RMAC_RSVD0_EIFS_CLR);
+
+	/* clear backoff time for Rx duration  */
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME1(band),
+		   MT_WF_RMAC_MIB_NONQOSD_BACKOFF);
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME3(band),
+		   MT_WF_RMAC_MIB_QOS01_BACKOFF);
+	mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME4(band),
+		   MT_WF_RMAC_MIB_QOS23_BACKOFF);
+
+	/* clear backoff time and set software compensation for OBSS time */
+	mask = MT_WF_RMAC_MIB_OBSS_BACKOFF | MT_WF_RMAC_MIB_ED_OFFSET;
+	set = FIELD_PREP(MT_WF_RMAC_MIB_OBSS_BACKOFF, 0) |
+	      FIELD_PREP(MT_WF_RMAC_MIB_ED_OFFSET, 4);
+	mt76_rmw(dev, MT_WF_RMAC_MIB_AIRTIME0(band), mask, set);
+}
+
+static void mt7996_mac_init(struct mt7996_dev *dev)
+{
+#define HIF_TXD_V2_1	4
+	int i;
+
+	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
+
+	for (i = 0; i < MT7996_WTBL_SIZE; i++)
+		mt7996_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		i = dev->mt76.led_pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
+	}
+
+	/* txs report queue */
+	mt76_rmw_field(dev, MT_DMA_TCRF1(0), MT_DMA_TCRF1_QIDX, 0);
+	mt76_rmw_field(dev, MT_DMA_TCRF1(1), MT_DMA_TCRF1_QIDX, 6);
+	mt76_rmw_field(dev, MT_DMA_TCRF1(2), MT_DMA_TCRF1_QIDX, 0);
+
+	/* rro module init */
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 3);
+	mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 1);
+
+	mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+			  MCU_WA_PARAM_HW_PATH_HIF_VER,
+			  HIF_TXD_V2_1, 0);
+
+	for (i = MT_BAND0; i <= MT_BAND2; i++)
+		mt7996_mac_init_band(dev, i);
+}
+
+static int mt7996_txbf_init(struct mt7996_dev *dev)
+{
+	int ret;
+
+	if (dev->dbdc_support) {
+		ret = mt7996_mcu_set_txbf(dev, BF_MOD_EN_CTRL);
+		if (ret)
+			return ret;
+	}
+
+	/* trigger sounding packets */
+	ret = mt7996_mcu_set_txbf(dev, BF_SOUNDING_ON);
+	if (ret)
+		return ret;
+
+	/* enable eBF */
+	return mt7996_mcu_set_txbf(dev, BF_HW_EN_UPDATE);
+}
+
+static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
+			       enum mt76_band_id band)
+{
+	struct mt76_phy *mphy;
+	u32 mac_ofs, hif1_ofs = 0;
+	int ret;
+
+	if (band != MT_BAND1 && band != MT_BAND2)
+		return 0;
+
+	if ((band == MT_BAND1 && !dev->dbdc_support) ||
+	    (band == MT_BAND2 && !dev->tbtc_support))
+		return 0;
+
+	if (phy)
+		return 0;
+
+	if (band == MT_BAND2 && dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7996_ops, band);
+	if (!mphy)
+		return -ENOMEM;
+
+	phy = mphy->priv;
+	phy->dev = dev;
+	phy->mt76 = mphy;
+	mphy->dev->phys[band] = mphy;
+
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7996_mac_work);
+
+	ret = mt7996_eeprom_parse_hw_cap(dev, phy);
+	if (ret)
+		goto error;
+
+	mac_ofs = band == MT_BAND2 ? MT_EE_MAC_ADDR3 : MT_EE_MAC_ADDR2;
+	memcpy(mphy->macaddr, dev->mt76.eeprom.data + mac_ofs, ETH_ALEN);
+	/* Make the extra PHY MAC address local without overlapping with
+	 * the usual MAC address allocation scheme on multiple virtual interfaces
+	 */
+	if (!is_valid_ether_addr(mphy->macaddr)) {
+		memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+		       ETH_ALEN);
+		mphy->macaddr[0] |= 2;
+		mphy->macaddr[0] ^= BIT(7);
+		if (band == MT_BAND2)
+			mphy->macaddr[0] ^= BIT(6);
+	}
+	mt76_eeprom_override(mphy);
+
+	/* init wiphy according to mphy and phy */
+	mt7996_init_wiphy(mphy->hw);
+	ret = mt76_connac_init_tx_queues(phy->mt76,
+					 MT_TXQ_ID(band),
+					 MT7996_TX_RING_SIZE,
+					 MT_TXQ_RING_BASE(band) + hif1_ofs, 0);
+	if (ret)
+		goto error;
+
+	ret = mt76_register_phy(mphy, true, mt76_rates,
+				ARRAY_SIZE(mt76_rates));
+	if (ret)
+		goto error;
+
+	ret = mt7996_init_debugfs(phy);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mphy->dev->phys[band] = NULL;
+	ieee80211_free_hw(mphy->hw);
+	return ret;
+}
+
+static void
+mt7996_unregister_phy(struct mt7996_phy *phy, enum mt76_band_id band)
+{
+	struct mt76_phy *mphy;
+
+	if (!phy)
+		return;
+
+	mphy = phy->dev->mt76.phys[band];
+	mt76_unregister_phy(mphy);
+	ieee80211_free_hw(mphy->hw);
+	phy->dev->mt76.phys[band] = NULL;
+}
+
+static void mt7996_init_work(struct work_struct *work)
+{
+	struct mt7996_dev *dev = container_of(work, struct mt7996_dev,
+				 init_work);
+
+	mt7996_mcu_set_eeprom(dev);
+	mt7996_mac_init(dev);
+	mt7996_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_6g.sband);
+	mt7996_txbf_init(dev);
+}
+
+void mt7996_wfsys_reset(struct mt7996_dev *dev)
+{
+	mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
+	msleep(20);
+
+	mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
+	msleep(20);
+}
+
+static int mt7996_init_hardware(struct mt7996_dev *dev)
+{
+	int ret, idx;
+
+	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
+
+	INIT_WORK(&dev->init_work, mt7996_init_work);
+
+	dev->dbdc_support = true;
+	dev->tbtc_support = true;
+
+	ret = mt7996_dma_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	ret = mt7996_mcu_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7996_eeprom_init(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+
+void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
+{
+	int sts;
+	u32 *cap;
+
+	if (!phy->mt76->cap.has_5ghz)
+		return;
+
+	sts = hweight16(phy->mt76->chainmask);
+	cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
+
+	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+		(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+
+	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
+		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+		  IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+
+	if (sts < 2)
+		return;
+
+	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+		IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE |
+		FIELD_PREP(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK, sts - 1);
+}
+
+static void
+mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
+			       struct ieee80211_sta_he_cap *he_cap, int vif)
+{
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	int sts = hweight16(phy->mt76->chainmask);
+	u8 c;
+
+#ifdef CONFIG_MAC80211_MESH
+	if (vif == NL80211_IFTYPE_MESH_POINT)
+		return;
+#endif
+
+	elem->phy_cap_info[3] &= ~IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+	elem->phy_cap_info[4] &= ~IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
+	c = IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK |
+	    IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
+	elem->phy_cap_info[5] &= ~c;
+
+	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
+	elem->phy_cap_info[6] &= ~c;
+
+	elem->phy_cap_info[7] &= ~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
+
+	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+	    IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+	elem->phy_cap_info[2] |= c;
+
+	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
+	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	elem->phy_cap_info[4] |= c;
+
+	/* do not support NG16 due to spec D4.0 changes subcarrier idx */
+	c = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+	    IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU;
+
+	if (vif == NL80211_IFTYPE_STATION)
+		c |= IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO;
+
+	elem->phy_cap_info[6] |= c;
+
+	if (sts < 2)
+		return;
+
+	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
+	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
+
+	if (vif != NL80211_IFTYPE_AP)
+		return;
+
+	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
+	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+		       sts - 1) |
+	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+		       sts - 1);
+	elem->phy_cap_info[5] |= c;
+
+	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
+	elem->phy_cap_info[6] |= c;
+
+	c = IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+	elem->phy_cap_info[7] |= c;
+}
+
+static void
+mt7996_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+	static const u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+
+static int
+mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+#ifdef CONFIG_MAC80211_MESH
+		case NL80211_IFTYPE_MESH_POINT:
+#endif
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+				IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
+
+		mt7996_set_stream_he_txbf_caps(phy, he_cap, i);
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt7996_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
+		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+				  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_2,
+					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+			       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+			       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+					       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
+
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7996_set_stream_he_caps(struct mt7996_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_6ghz) {
+		data = phy->iftype[NL80211_BAND_6GHZ];
+		n = mt7996_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+		band = &phy->mt76->sband_6g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+}
+
+int mt7996_register_device(struct mt7996_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	INIT_WORK(&dev->rc_work, mt7996_mac_sta_rc_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7996_mac_work);
+	INIT_LIST_HEAD(&dev->sta_rc_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	INIT_LIST_HEAD(&dev->twt_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	init_waitqueue_head(&dev->reset_wait);
+	INIT_WORK(&dev->reset_work, mt7996_mac_reset_work);
+
+	ret = mt7996_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	mt7996_init_wiphy(hw);
+
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		dev->mt76.led_cdev.brightness_set = mt7996_led_set_brightness;
+		dev->mt76.led_cdev.blink_set = mt7996_led_set_blink;
+	}
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret)
+		return ret;
+
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
+	ret = mt7996_register_phy(dev, mt7996_phy2(dev), MT_BAND1);
+	if (ret)
+		return ret;
+
+	ret = mt7996_register_phy(dev, mt7996_phy3(dev), MT_BAND2);
+	if (ret)
+		return ret;
+
+	return mt7996_init_debugfs(&dev->phy);
+}
+
+void mt7996_unregister_device(struct mt7996_dev *dev)
+{
+	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
+	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
+	mt76_unregister_device(&dev->mt76);
+	mt7996_mcu_exit(dev);
+	mt7996_tx_token_put(dev);
+	mt7996_dma_cleanup(dev);
+	tasklet_disable(&dev->irq_tasklet);
+
+	mt76_free_device(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
new file mode 100644
index 000000000000..d0a32638a65b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -0,0 +1,2468 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7996.h"
+#include "../dma.h"
+#include "mac.h"
+#include "mcu.h"
+
+#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+static const struct mt7996_dfs_radar_spec etsi_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[5] =  { 1, 0,  6, 32, 28, 0,  990, 5010, 17, 1, 1 },
+		[6] =  { 1, 0,  9, 32, 28, 0,  615, 5010, 27, 1, 1 },
+		[7] =  { 1, 0, 15, 32, 28, 0,  240,  445, 27, 1, 1 },
+		[8] =  { 1, 0, 12, 32, 28, 0,  240,  510, 42, 1, 1 },
+		[9] =  { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 12, 32, 28, { }, 126 },
+		[10] = { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 15, 32, 24, { }, 126 },
+		[11] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 18, 32, 28, { },  54 },
+		[12] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 27, 32, 24, { },  54 },
+	},
+};
+
+static const struct mt7996_dfs_radar_spec fcc_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[0] = { 1, 0,  8,  32, 28, 0, 508, 3076, 13, 1,  1 },
+		[1] = { 1, 0, 12,  32, 28, 0, 140,  240, 17, 1,  1 },
+		[2] = { 1, 0,  8,  32, 28, 0, 190,  510, 22, 1,  1 },
+		[3] = { 1, 0,  6,  32, 28, 0, 190,  510, 32, 1,  1 },
+		[4] = { 1, 0,  9, 255, 28, 0, 323,  343, 13, 1, 32 },
+	},
+};
+
+static const struct mt7996_dfs_radar_spec jp_radar_specs = {
+	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
+	.radar_pattern = {
+		[0] =  { 1, 0,  8,  32, 28, 0,  508, 3076,  13, 1,  1 },
+		[1] =  { 1, 0, 12,  32, 28, 0,  140,  240,  17, 1,  1 },
+		[2] =  { 1, 0,  8,  32, 28, 0,  190,  510,  22, 1,  1 },
+		[3] =  { 1, 0,  6,  32, 28, 0,  190,  510,  32, 1,  1 },
+		[4] =  { 1, 0,  9, 255, 28, 0,  323,  343,  13, 1, 32 },
+		[13] = { 1, 0,  7,  32, 28, 0, 3836, 3856,  14, 1,  1 },
+		[14] = { 1, 0,  6,  32, 28, 0,  615, 5010, 110, 1,  1 },
+		[15] = { 1, 1,  0,   0,  0, 0,   15, 5010, 110, 0,  0, 12, 32, 28 },
+	},
+};
+
+static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
+					    u16 idx, bool unicast)
+{
+	struct mt7996_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt7996_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+
+void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
+{
+}
+
+bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw)
+{
+	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
+
+	return MT_WTBL_LMAC_OFFS(wcid, dw);
+}
+
+static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7996_sta *msta;
+	struct rate_info *rate;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	int i;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	rcu_read_lock();
+
+	while (true) {
+		bool clear = false;
+		u32 addr, val;
+		u16 idx;
+		u8 bw;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&sta_poll_list,
+					struct mt7996_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		idx = msta->wcid.idx;
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7996_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt76_connac_lmac_mapping(i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur, rx_cur);
+		}
+
+		/* We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &msta->wcid.rate;
+
+		switch (rate->bw) {
+		case RATE_INFO_BW_160:
+			bw = IEEE80211_STA_RX_BW_160;
+			break;
+		case RATE_INFO_BW_80:
+			bw = IEEE80211_STA_RX_BW_80;
+			break;
+		case RATE_INFO_BW_40:
+			bw = IEEE80211_STA_RX_BW_40;
+			break;
+		default:
+			bw = IEEE80211_STA_RX_BW_20;
+			break;
+		}
+
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			u8 offs = 24 + 2 * bw;
+
+			addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
+			val = mt76_rr(dev, addr);
+			rate->he_gi = (val & (0x3 << offs)) >> offs;
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val & BIT(12 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static void
+mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				 struct ieee80211_radiotap_he *he,
+				 __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+static void
+mt7996_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
+
+	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
+	if (status->he_dcm)
+		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
+
+	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
+			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
+				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+	}
+}
+
+static void
+mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he = NULL;
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (mode) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+
+		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt7996_mac_decode_he_mu_radiotap(skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+
+/* The HW does not translate the mac header to 802.3 for mesh point */
+static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
+	struct mt7996_sta *msta = (struct mt7996_sta *)status->wcid;
+	__le32 *rxd = (__le32 *)skb->data;
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+	struct ieee80211_hdr hdr;
+	u16 frame_control;
+
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
+	    MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
+	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
+		return -EINVAL;
+
+	if (!msta || !msta->vif)
+		return -EINVAL;
+
+	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+	/* store the info from RXD and ethhdr to avoid being overridden */
+	frame_control = le32_get_bits(rxd[8], MT_RXD8_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[10], MT_RXD10_SEQ_CTRL));
+	hdr.duration_id = 0;
+
+	ether_addr_copy(hdr.addr1, vif->addr);
+	ether_addr_copy(hdr.addr2, sta->addr);
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
+	case 0:
+		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		break;
+	case IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
+		break;
+	case IEEE80211_FCTL_TODS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		break;
+	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
+		break;
+	default:
+		break;
+	}
+
+	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
+		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
+		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
+	else
+		skb_pull(skb, 2);
+
+	if (ieee80211_has_order(hdr.frame_control))
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[11],
+		       IEEE80211_HT_CTL_LEN);
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[10], MT_RXD10_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
+	if (ieee80211_has_a4(hdr.frame_control))
+		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	else
+		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
+
+	return 0;
+}
+
+static int
+mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
+			struct mt76_rx_status *status,
+			struct ieee80211_supported_band *sband,
+			__le32 *rxv, u8 *mode)
+{
+	u32 v0, v2;
+	u8 stbc, gi, bw, dcm, nss;
+	int i, idx;
+	bool cck = false;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	i = idx;
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	stbc = FIELD_GET(MT_PRXV_HT_STBC, v2);
+	gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v2);
+	*mode = FIELD_GET(MT_PRXV_TX_MODE, v2);
+	dcm = FIELD_GET(MT_PRXV_DCM, v2);
+	bw = FIELD_GET(MT_PRXV_FRAME_MODE, v2);
+
+	switch (*mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		i = mt76_get_rate(&dev->mt76, sband, i, cck);
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		status->encoding = RX_ENC_HT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 31)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_VHT:
+		status->nss = nss;
+		status->encoding = RX_ENC_VHT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 11)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_HE_MU:
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+			status->he_gi = gi;
+
+		status->he_dcm = dcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	status->rate_idx = i;
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
+		    (idx & MT_PRXV_TX_ER_SU_106T)) {
+			status->bw = RATE_INFO_BW_HE_RU;
+			status->he_ru =
+				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		} else {
+			status->bw = RATE_INFO_BW_40;
+		}
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		status->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		status->bw = RATE_INFO_BW_160;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+	if (*mode < MT_PHY_TYPE_HE_SU && gi)
+		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	return 0;
+}
+
+static int
+mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7996_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *rxv = NULL;
+	u32 rxd0 = le32_to_cpu(rxd[0]);
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_status = *(u32 *)skb->cb;
+	bool unicast, insert_ccmp_hdr = false;
+	u8 remove_pad, amsdu_info, band_idx;
+	u8 mode = 0, qos_ctl = 0;
+	bool hdr_trans;
+	u16 hdr_gap;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
+	int idx;
+
+	memset(status, 0, sizeof(*status));
+
+	band_idx = FIELD_GET(MT_RXD1_NORMAL_BAND_IDX, rxd1);
+	mphy = dev->mt76.phys[band_idx];
+	phy = mphy->priv;
+	status->phy_idx = mphy->band_idx;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
+		return -EINVAL;
+
+	/* ICV error or CCMP/BIP/WPI MIC error */
+	if (rxd1 & MT_RXD1_NORMAL_ICV_ERR)
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt7996_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		struct mt7996_sta *msta;
+
+		msta = container_of(status->wcid, struct mt7996_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
+	status->freq = mphy->chandef.chan->center_freq;
+	status->band = mphy->chandef.chan->band;
+	if (status->band == NL80211_BAND_5GHZ)
+		sband = &mphy->sband_5g.sband;
+	else if (status->band == NL80211_BAND_6GHZ)
+		sband = &mphy->sband_6g.sband;
+	else
+		sband = &mphy->sband_2g.sband;
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if ((rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (rxd1 & MT_RXD3_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 8;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD8_FRAME_CONTROL, v0));
+		qos_ctl = FIELD_GET(MT_RXD10_QOS_CTL, v2);
+		seq_ctrl = FIELD_GET(MT_RXD10_SEQ_CTRL, v2);
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->timestamp = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->timestamp) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->timestamp;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v3;
+		int ret;
+
+		rxv = rxd;
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v3 = le32_to_cpu(rxv[3]);
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v3);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v3);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v3);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v3);
+
+		/* RXD Group 5 - C-RXV */
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			rxd += 24;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+		}
+
+		ret = mt7996_mac_fill_rx_rate(dev, status, sband, rxv, &mode);
+		if (ret < 0)
+			return ret;
+	}
+
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+	}
+
+	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
+	if (hdr_trans && ieee80211_has_morefrags(fc)) {
+		if (mt7996_reverse_frag0_hdr_trans(skb, hdr_gap))
+			return -EINVAL;
+		hdr_trans = false;
+	} else {
+		int pad_start = 0;
+
+		skb_pull(skb, hdr_gap);
+		if (!hdr_trans && status->amsdu) {
+			pad_start = ieee80211_get_hdrlen_from_skb(skb);
+		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR)) {
+			/* When header translation failure is indicated,
+			 * the hardware will insert an extra 2-byte field
+			 * containing the data length after the protocol
+			 * type field.
+			 */
+			pad_start = 12;
+			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
+				pad_start += 4;
+			else
+				pad_start = 0;
+		}
+
+		if (pad_start) {
+			memmove(skb->data + 2, skb->data, pad_start);
+			skb_pull(skb, 2);
+		}
+	}
+
+	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr;
+
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
+
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag |= RX_FLAG_8023;
+	}
+
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
+		mt7996_mac_decode_he_radiotap(skb, rxv, mode);
+
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
+		return 0;
+
+	status->aggr = unicast &&
+		       !ieee80211_is_qos_nullfunc(fc);
+	status->qos_ctl = qos_ctl;
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
+
+	return 0;
+}
+
+static void
+mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	u16 ethertype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	ethertype = get_unaligned_be16(&skb->data[12]);
+	if (ethertype >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+}
+
+static void
+mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
+		tid = MT_TX_ADDBA;
+	else if (ieee80211_is_mgmt(hdr->frame_control))
+		tid = MT_TX_NORMAL;
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
+		val |= MT_TXD1_FIXED_RATE;
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD1_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	txwi[3] |= FIELD_PREP(MT_TXD3_BCM, multicast);
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
+	}
+}
+
+static u16
+mt7996_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		       bool beacon, bool mcast)
+{
+	u8 mode = 0, band = mphy->chandef.chan->band;
+	int rateidx = 0, mcast_rate;
+
+	if (beacon) {
+		struct cfg80211_bitrate_mask *mask;
+
+		mask = &vif->bss_conf.beacon_tx_rate;
+		if (hweight16(mask->control[band].he_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].he_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HE_SU;
+			goto out;
+		} else if (hweight16(mask->control[band].vht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].vht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_VHT;
+			goto out;
+		} else if (hweight8(mask->control[band].ht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].ht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HT;
+			goto out;
+		} else if (hweight32(mask->control[band].legacy) == 1) {
+			rateidx = ffs(mask->control[band].legacy) - 1;
+			goto legacy;
+		}
+	}
+
+	mcast_rate = vif->bss_conf.mcast_rate[band];
+	if (mcast && mcast_rate > 0)
+		rateidx = mcast_rate - 1;
+	else
+		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+legacy:
+	rateidx = mt76_calculate_default_rate(mphy, rateidx);
+	mode = rateidx >> 8;
+	rateidx &= GENMASK(7, 0);
+
+out:
+	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
+	       FIELD_PREP(MT_TX_RATE_MODE, mode);
+}
+
+void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
+			   struct ieee80211_key_conf *key, u32 changed)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->mphy;
+	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u16 tx_count = 15;
+	u32 val;
+	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED));
+	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+					 BSS_CHANGED_FILS_DISCOVERY));
+
+	if (vif) {
+		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+		omac_idx = mvif->mt76.omac_idx;
+		wmm_idx = mvif->mt76.wmm_idx;
+		band_idx = mvif->mt76.band_idx;
+	}
+
+	mphy = mt76_dev_phy(&dev->mt76, band_idx);
+
+	if (inband_disc) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_ALTX0;
+	} else if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = wmm_idx * MT7996_MAX_WMM_SETS +
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+
+	if (band_idx)
+		val |= FIELD_PREP(MT_TXD1_TGID, band_idx);
+
+	txwi[1] = cpu_to_le32(val);
+	txwi[2] = 0;
+
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+	if (wcid->amsdu)
+		val |= MT_TXD3_HW_AMSDU;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+
+	val = FIELD_PREP(MT_TXD5_PID, pid);
+	if (pid >= MT_PACKET_ID_FIRST)
+		val |= MT_TXD5_TX_STATUS_HOST;
+	txwi[5] = cpu_to_le32(val);
+
+	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS |
+	      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	txwi[6] = cpu_to_le32(val);
+	txwi[7] = 0;
+
+	if (is_8023)
+		mt7996_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
+		/* Fixed rata is available just for 802.11 txd */
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool multicast = is_multicast_ether_addr(hdr->addr1);
+		u16 rate = mt7996_mac_tx_rate_val(mphy, vif, beacon, multicast);
+
+		/* fix to bw 20 */
+		val = MT_TXD6_FIXED_BW |
+		      FIELD_PREP(MT_TXD6_BW, 0) |
+		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
+
+		txwi[6] |= cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+	}
+}
+
+int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_txwi_cache *t;
+	struct mt7996_txp *txp;
+	int id, i, pid, nbuf = tx_info->nbuf - 1;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->jiffies + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->jiffies = jiffies;
+		}
+	}
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	memset(txwi_ptr, 0, MT_TXD_SIZE);
+	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid,
+				      key, 0);
+
+	txp = (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+	for (i = 0; i < nbuf; i++) {
+		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
+		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
+	}
+	txp->nbuf = nbuf;
+
+	txp->flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
+
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		txp->flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+
+	if (!key)
+		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
+
+	if (!is_8023 && ieee80211_is_mgmt(hdr->frame_control))
+		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
+
+	if (vif) {
+		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+		txp->bss_idx = mvif->mt76.idx;
+	}
+
+	txp->token = cpu_to_le16(id);
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
+		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
+	else
+		txp->rept_wds_wcid = cpu_to_le16(0xfff);
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	/* pass partial skb header to fw */
+	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].skip_unmap = true;
+	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
+
+	return 0;
+}
+
+static void
+mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt7996_sta *msta;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	msta = (struct mt7996_sta *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+
+static void
+mt7996_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	struct mt7996_txp *txp;
+	int i;
+
+	txp = mt7996_txwi_to_txp(dev, t);
+	for (i = 0; i < txp->nbuf; i++)
+		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
+
+static void
+mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
+		 struct ieee80211_sta *sta, struct list_head *free_list)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_wcid *wcid;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt7996_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (sta) {
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+		wcid_idx = wcid->idx;
+
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7996_tx_check_aggr(sta, txwi);
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	}
+
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
+}
+
+static void
+mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
+{
+	__le32 *tx_free = (__le32 *)data, *cur_info;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *phy2 = mdev->phys[MT_BAND1];
+	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
+	bool wake = false;
+	u16 total, count = 0;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+	if (phy2) {
+		mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_BE], false);
+	}
+	if (phy3) {
+		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
+	}
+
+	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 4))
+		return;
+
+	total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
+	for (cur_info = &tx_free[2]; count < total; cur_info++) {
+		u32 msdu, info;
+		u8 i;
+
+		if (WARN_ON_ONCE((void *)cur_info >= end))
+			return;
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		info = le32_to_cpu(*cur_info);
+		if (info & MT_TXFREE_INFO_PAIR) {
+			struct mt7996_sta *msta;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7996_sta, wcid);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		if (info & MT_TXFREE_INFO_HEADER)
+			continue;
+
+		for (i = 0; i < 2; i++) {
+			msdu = (info >> (15 * i)) & MT_TXFREE_INFO_MSDU_ID;
+			if (msdu == MT_TXFREE_INFO_MSDU_ID)
+				continue;
+
+			count++;
+			txwi = mt76_token_release(mdev, msdu, &wake);
+			if (!txwi)
+				continue;
+
+			mt7996_txwi_free(dev, txwi, sta, &free_list);
+		}
+	}
+
+	mt7996_mac_sta_poll(dev);
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+}
+
+static bool
+mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid, int pid,
+		       __le32 *txs_data, struct mt76_sta_stats *stats)
+{
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy;
+	struct ieee80211_tx_info *info;
+	struct sk_buff_head list;
+	struct rate_info rate = {};
+	struct sk_buff *skb;
+	bool cck = false;
+	u32 txrate, txs, mode, stbc;
+
+	mt76_tx_status_lock(mdev, &list);
+	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	if (!skb)
+		goto out_no_skb;
+
+	txs = le32_to_cpu(txs_data[0]);
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+
+	info->status.rates[0].idx = -1;
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = le32_get_bits(txs_data[3], MT_TXS3_RATE_STBC);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = mt76_dev_phy(mdev, wcid->phy_idx);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			goto out;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		goto out;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+out:
+	mt76_tx_status_skb_done(mdev, skb, &list);
+
+out_no_skb:
+	mt76_tx_status_unlock(mdev, &list);
+
+	return !!skb;
+}
+
+static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
+{
+	struct mt7996_sta *msta = NULL;
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u8 pid;
+
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+		return;
+
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT7996_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	msta = container_of(wcid, struct mt7996_sta, wcid);
+
+	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);
+
+	if (!wcid->sta)
+		goto out;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+
+bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	if (type != PKT_TYPE_NORMAL) {
+		u32 sw_type = le32_get_bits(rxd[0], MT_RXD0_SW_PKT_TYPE_MASK);
+
+		if (unlikely((sw_type & MT_RXD0_SW_PKT_TYPE_MAP) ==
+			     MT_RXD0_SW_PKT_TYPE_FRAME))
+			return true;
+	}
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7996_mac_tx_free(dev, data, len);
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+			mt7996_mac_add_txs(dev, rxd);
+		return false;
+	case PKT_TYPE_RX_FW_MONITOR:
+		mt7996_debugfs_rx_fw_monitor(dev, data, len);
+		return false;
+	default:
+		return true;
+	}
+}
+
+void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	if (type != PKT_TYPE_NORMAL) {
+		u32 sw_type = le32_get_bits(rxd[0], MT_RXD0_SW_PKT_TYPE_MASK);
+
+		if (unlikely((sw_type & MT_RXD0_SW_PKT_TYPE_MAP) ==
+			     MT_RXD0_SW_PKT_TYPE_FRAME))
+			type = PKT_TYPE_NORMAL;
+	}
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7996_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7996_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+			mt7996_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_RX_FW_MONITOR:
+		mt7996_debugfs_rx_fw_monitor(dev, skb->data, skb->len);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_NORMAL:
+		if (!mt7996_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+
+void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7996_txp *txp;
+
+		txp = mt7996_txwi_to_txp(mdev, e->txwi);
+		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+
+void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u32 reg = MT_WF_PHYRX_BAND_RX_CTRL1(phy->mt76->band_idx);
+
+	mt76_clear(dev, reg, MT_WF_PHYRX_BAND_RX_CTRL1_STSCNT_EN);
+	mt76_set(dev, reg, BIT(11) | BIT(9));
+}
+
+void mt7996_mac_reset_counters(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u8 band_idx = phy->mt76->band_idx;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		mt76_rr(dev, MT_TX_AGG_CNT(band_idx, i));
+
+	phy->mt76->survey_time = ktime_get_boottime();
+
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
+
+	/* reset airtime counters */
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band_idx),
+		 MT_WF_RMAC_MIB_RXTIME_CLR);
+
+	mt7996_mcu_get_chan_mib_info(phy, true);
+}
+
+void mt7996_mac_set_timing(struct mt7996_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_phy *phy2 = mt7996_phy2(dev);
+	struct mt7996_phy *phy3 = mt7996_phy3(dev);
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	u8 band_idx = phy->mt76->band_idx;
+	int offset;
+	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	if (phy2)
+		coverage_class = max_t(s16, dev->phy.coverage_class,
+				       phy2->coverage_class);
+
+	if (phy3)
+		coverage_class = max_t(s16, coverage_class,
+				       phy3->coverage_class);
+
+	mt76_set(dev, MT_ARB_SCR(band_idx),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(band_idx), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(band_idx), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(band_idx),
+		FIELD_PREP(MT_IFS_EIFS_OFDM, a_band ? 84 : 78) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, 10) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (!a_band)
+		mt76_wr(dev, MT_TMAC_ICR1(band_idx),
+			FIELD_PREP(MT_IFS_EIFS_CCK, 314));
+
+	if (phy->slottime < 20 || a_band)
+		val = MT7996_CFEND_RATE_DEFAULT;
+	else
+		val = MT7996_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(band_idx), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(band_idx),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+
+void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band)
+{
+	mt76_set(dev, MT_WF_PHYRX_CSD_BAND_RXTD12(band),
+		 MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY |
+		 MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR);
+
+	mt76_set(dev, MT_WF_PHYRX_BAND_RX_CTRL1(band),
+		 FIELD_PREP(MT_WF_PHYRX_BAND_RX_CTRL1_IPI_EN, 0x5));
+}
+
+static u8
+mt7996_phy_get_nf(struct mt7996_phy *phy, u8 band_idx)
+{
+	static const u8 nf_power[] = { 92, 89, 86, 83, 80, 75, 70, 65, 60, 55, 52 };
+	struct mt7996_dev *dev = phy->dev;
+	u32 val, sum = 0, n = 0;
+	int ant, i;
+
+	for (ant = 0; ant < hweight8(phy->mt76->antenna_mask); ant++) {
+		u32 reg = MT_WF_PHYRX_CSD_IRPI(band_idx, ant);
+
+		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
+			val = mt76_rr(dev, reg);
+			sum += val * nf_power[i];
+			n += val;
+		}
+	}
+
+	return n ? sum / n : 0;
+}
+
+void mt7996_update_channel(struct mt76_phy *mphy)
+{
+	struct mt7996_phy *phy = (struct mt7996_phy *)mphy->priv;
+	struct mt76_channel_state *state = mphy->chan_state;
+	int nf;
+
+	mt7996_mcu_get_chan_mib_info(phy, false);
+
+	nf = mt7996_phy_get_nf(phy, mphy->band_idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state->noise = -(phy->noise >> 4);
+}
+
+static bool
+mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7996_RESET_TIMEOUT);
+
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct ieee80211_hw *hw = priv;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		mt7996_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7996_update_beacons(struct mt7996_dev *dev)
+{
+	struct mt76_phy *phy2, *phy3;
+
+	ieee80211_iterate_active_interfaces(dev->mt76.hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, dev->mt76.hw);
+
+	phy2 = dev->mt76.phys[MT_BAND1];
+	if (!phy2)
+		return;
+
+	ieee80211_iterate_active_interfaces(phy2->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy2->hw);
+
+	phy3 = dev->mt76.phys[MT_BAND2];
+	if (!phy3)
+		return;
+
+	ieee80211_iterate_active_interfaces(phy3->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy3->hw);
+}
+
+static void
+mt7996_dma_reset(struct mt7996_dev *dev)
+{
+	struct mt76_phy *phy2 = dev->mt76.phys[MT_BAND1];
+	struct mt76_phy *phy3 = dev->mt76.phys[MT_BAND2];
+	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+	int i;
+
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	if (dev->hif2)
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	usleep_range(1000, 2000);
+
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+		if (phy2)
+			mt76_queue_tx_cleanup(dev, phy2->q_tx[i], true);
+		if (phy3)
+			mt76_queue_tx_cleanup(dev, phy3->q_tx[i], true);
+	}
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	/* re-init prefetch settings after reset */
+	mt7996_dma_prefetch(dev);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	if (dev->hif2)
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+}
+
+void mt7996_tx_token_put(struct mt7996_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
+		mt7996_txwi_free(dev, txwi, NULL, NULL);
+		dev->mt76.token_count--;
+	}
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
+}
+
+/* system error recovery */
+void mt7996_mac_reset_work(struct work_struct *work)
+{
+	struct mt7996_phy *phy2, *phy3;
+	struct mt7996_dev *dev;
+	int i;
+
+	dev = container_of(work, struct mt7996_dev, reset_work);
+	phy2 = mt7996_phy2(dev);
+	phy3 = mt7996_phy3(dev);
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_stop_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_stop_queues(phy3->mt76->hw);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	if (phy2) {
+		set_bit(MT76_RESET, &phy2->mt76->state);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
+	}
+	if (phy3) {
+		set_bit(MT76_RESET, &phy3->mt76->state);
+		cancel_delayed_work_sync(&phy3->mt76->mac_work);
+	}
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
+
+	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7996_dma_reset(dev);
+
+		mt7996_tx_token_put(dev);
+		idr_init(&dev->mt76.token);
+
+		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
+		mt7996_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
+	if (phy3)
+		clear_bit(MT76_RESET, &phy3->mt76->state);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
+	local_bh_enable();
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_wake_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_wake_queues(phy3->mt76->hw);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt7996_update_beacons(dev);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
+				     MT7996_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(phy2->mt76->hw,
+					     &phy2->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+	if (phy3)
+		ieee80211_queue_delayed_work(phy3->mt76->hw,
+					     &phy3->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+}
+
+void mt7996_mac_update_stats(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	u8 band_idx = phy->mt76->band_idx;
+	u32 cnt;
+	int i;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR1(band_idx));
+	mib->fcs_err_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR33(band_idx));
+	mib->rx_fifo_full_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR31(band_idx));
+	mib->rx_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR6(band_idx));
+	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_RVSR0(band_idx));
+	mib->rx_vector_mismatch_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR35(band_idx));
+	mib->rx_delimiter_fail_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR36(band_idx));
+	mib->rx_len_mismatch_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR0(band_idx));
+	mib->tx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR2(band_idx));
+	mib->tx_stop_q_empty_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR3(band_idx));
+	mib->tx_mpdu_attempts_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR4(band_idx));
+	mib->tx_mpdu_success_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR27(band_idx));
+	mib->rx_ampdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR28(band_idx));
+	mib->rx_ampdu_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR29(band_idx));
+	mib->rx_ampdu_valid_subframe_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RSCR30(band_idx));
+	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_SDR27(band_idx));
+	mib->tx_rwp_fail_cnt += FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR28(band_idx));
+	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_UMIB_RPDCR(band_idx));
+	mib->rx_pfdrop_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_RVSR1(band_idx));
+	mib->rx_vec_queue_overflow_drop_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR1(band_idx));
+	mib->rx_ba_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR0(band_idx));
+	mib->tx_bf_ebf_ppdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR1(band_idx));
+	mib->tx_bf_ibf_ppdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR2(band_idx));
+	mib->tx_mu_bf_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR5(band_idx));
+	mib->tx_mu_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR6(band_idx));
+	mib->tx_mu_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_TSCR7(band_idx));
+	mib->tx_su_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR3(band_idx));
+	mib->tx_bf_rx_fb_ht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR4(band_idx));
+	mib->tx_bf_rx_fb_vht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR5(band_idx));
+	mib->tx_bf_rx_fb_he_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR6(band_idx));
+	mib->tx_bf_rx_fb_eht_cnt += cnt;
+	mib->tx_bf_rx_fb_all_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(band_idx));
+	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
+	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
+	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR7(band_idx));
+	mib->tx_bf_fb_trig_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_BSCR17(band_idx));
+	mib->tx_bf_fb_cpl_cnt += cnt;
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		cnt = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += cnt;
+		mib->tx_amsdu_cnt += cnt;
+	}
+
+	/* rts count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR5(band_idx));
+	mib->rts_cnt += cnt;
+
+	/* rts retry count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR6(band_idx));
+	mib->rts_retries_cnt += cnt;
+
+	/* ba miss count */
+	cnt = mt76_rr(dev, MT_MIB_BTSCR0(band_idx));
+	mib->ba_miss_cnt += cnt;
+
+	/* ack fail count */
+	cnt = mt76_rr(dev, MT_MIB_BFTFCR(band_idx));
+	mib->ack_fail_cnt += cnt;
+
+	for (i = 0; i < 16; i++) {
+		cnt = mt76_rr(dev, MT_TX_AGG_CNT(band_idx, i));
+		phy->mt76->aggr_stats[i] += cnt;
+	}
+}
+
+void mt7996_mac_sta_rc_work(struct work_struct *work)
+{
+	struct mt7996_dev *dev = container_of(work, struct mt7996_dev, rc_work);
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+	struct mt7996_sta *msta;
+	u32 changed;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_rc_list, &list);
+
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7996_sta, rc_list);
+		list_del_init(&msta->rc_list);
+		changed = msta->changed;
+		msta->changed = 0;
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
+			       IEEE80211_RC_NSS_CHANGED |
+			       IEEE80211_RC_BW_CHANGED))
+			mt7996_mcu_add_rate_ctrl(dev, vif, sta, true);
+
+		/* TODO: smps change */
+
+		spin_lock_bh(&dev->sta_poll_lock);
+	}
+
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+void mt7996_mac_work(struct work_struct *work)
+{
+	struct mt7996_phy *phy;
+	struct mt76_phy *mphy;
+
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
+
+	mutex_lock(&mphy->dev->mutex);
+
+	mt76_update_survey(mphy);
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
+
+		mt7996_mac_update_stats(phy);
+	}
+
+	mutex_unlock(&mphy->dev->mutex);
+
+	mt76_tx_status_check(mphy->dev, false);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT7996_WATCHDOG_TIME);
+}
+
+static void mt7996_dfs_stop_radar_detector(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+
+	if (phy->rdd_state & BIT(0))
+		mt7996_mcu_rdd_cmd(dev, RDD_STOP, 0,
+				   MT_RX_SEL0, 0);
+	if (phy->rdd_state & BIT(1))
+		mt7996_mcu_rdd_cmd(dev, RDD_STOP, 1,
+				   MT_RX_SEL0, 0);
+}
+
+static int mt7996_dfs_start_rdd(struct mt7996_dev *dev, int chain)
+{
+	int err, region;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_ETSI:
+		region = 0;
+		break;
+	case NL80211_DFS_JP:
+		region = 2;
+		break;
+	case NL80211_DFS_FCC:
+	default:
+		region = 1;
+		break;
+	}
+
+	err = mt7996_mcu_rdd_cmd(dev, RDD_START, chain,
+				 MT_RX_SEL0, region);
+	if (err < 0)
+		return err;
+
+	return mt7996_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
+				 MT_RX_SEL0, 1);
+}
+
+static int mt7996_dfs_start_radar_detector(struct mt7996_phy *phy)
+{
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	struct mt7996_dev *dev = phy->dev;
+	u8 band_idx = phy->mt76->band_idx;
+	int err;
+
+	/* start CAC */
+	err = mt7996_mcu_rdd_cmd(dev, RDD_CAC_START, band_idx,
+				 MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	err = mt7996_dfs_start_rdd(dev, band_idx);
+	if (err < 0)
+		return err;
+
+	phy->rdd_state |= BIT(band_idx);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
+	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		err = mt7996_dfs_start_rdd(dev, 1);
+		if (err < 0)
+			return err;
+
+		phy->rdd_state |= BIT(1);
+	}
+
+	return 0;
+}
+
+static int
+mt7996_dfs_init_radar_specs(struct mt7996_phy *phy)
+{
+	const struct mt7996_dfs_radar_spec *radar_specs;
+	struct mt7996_dev *dev = phy->dev;
+	int err, i;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_FCC:
+		radar_specs = &fcc_radar_specs;
+		err = mt7996_mcu_set_fcc5_lpn(dev, 8);
+		if (err < 0)
+			return err;
+		break;
+	case NL80211_DFS_ETSI:
+		radar_specs = &etsi_radar_specs;
+		break;
+	case NL80211_DFS_JP:
+		radar_specs = &jp_radar_specs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(radar_specs->radar_pattern); i++) {
+		err = mt7996_mcu_set_radar_th(dev, i,
+					      &radar_specs->radar_pattern[i]);
+		if (err < 0)
+			return err;
+	}
+
+	return mt7996_mcu_set_pulse_th(dev, &radar_specs->pulse_th);
+}
+
+int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	enum mt76_dfs_state dfs_state, prev_state;
+	int err;
+
+	prev_state = phy->mt76->dfs_state;
+	dfs_state = mt76_phy_dfs_state(phy->mt76);
+
+	if (prev_state == dfs_state)
+		return 0;
+
+	if (prev_state == MT_DFS_STATE_UNKNOWN)
+		mt7996_dfs_stop_radar_detector(phy);
+
+	if (dfs_state == MT_DFS_STATE_DISABLED)
+		goto stop;
+
+	if (prev_state <= MT_DFS_STATE_DISABLED) {
+		err = mt7996_dfs_init_radar_specs(phy);
+		if (err < 0)
+			return err;
+
+		err = mt7996_dfs_start_radar_detector(phy);
+		if (err < 0)
+			return err;
+
+		phy->mt76->dfs_state = MT_DFS_STATE_CAC;
+	}
+
+	if (dfs_state == MT_DFS_STATE_CAC)
+		return 0;
+
+	err = mt7996_mcu_rdd_cmd(dev, RDD_CAC_END,
+				 phy->mt76->band_idx, MT_RX_SEL0, 0);
+	if (err < 0) {
+		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+		return err;
+	}
+
+	phy->mt76->dfs_state = MT_DFS_STATE_ACTIVE;
+	return 0;
+
+stop:
+	err = mt7996_mcu_rdd_cmd(dev, RDD_NORMAL_START,
+				 phy->mt76->band_idx, MT_RX_SEL0, 0);
+	if (err < 0)
+		return err;
+
+	mt7996_dfs_stop_radar_detector(phy);
+	phy->mt76->dfs_state = MT_DFS_STATE_DISABLED;
+
+	return 0;
+}
+
+static int
+mt7996_mac_twt_duration_align(int duration)
+{
+	return duration << 8;
+}
+
+static u64
+mt7996_mac_twt_sched_list_add(struct mt7996_dev *dev,
+			      struct mt7996_twt_flow *flow)
+{
+	struct mt7996_twt_flow *iter, *iter_next;
+	u32 duration = flow->duration << 8;
+	u64 start_tsf;
+
+	iter = list_first_entry_or_null(&dev->twt_list,
+					struct mt7996_twt_flow, list);
+	if (!iter || !iter->sched || iter->start_tsf > duration) {
+		/* add flow as first entry in the list */
+		list_add(&flow->list, &dev->twt_list);
+		return 0;
+	}
+
+	list_for_each_entry_safe(iter, iter_next, &dev->twt_list, list) {
+		start_tsf = iter->start_tsf +
+			    mt7996_mac_twt_duration_align(iter->duration);
+		if (list_is_last(&iter->list, &dev->twt_list))
+			break;
+
+		if (!iter_next->sched ||
+		    iter_next->start_tsf > start_tsf + duration) {
+			list_add(&flow->list, &iter->list);
+			goto out;
+		}
+	}
+
+	/* add flow as last entry in the list */
+	list_add_tail(&flow->list, &dev->twt_list);
+out:
+	return start_tsf;
+}
+
+static int mt7996_mac_check_twt_req(struct ieee80211_twt_setup *twt)
+{
+	struct ieee80211_twt_params *twt_agrt;
+	u64 interval, duration;
+	u16 mantissa;
+	u8 exp;
+
+	/* only individual agreement supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST)
+		return -EOPNOTSUPP;
+
+	/* only 256us unit supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT)
+		return -EOPNOTSUPP;
+
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+
+	/* explicit agreement not supported */
+	if (!(twt_agrt->req_type & cpu_to_le16(IEEE80211_TWT_REQTYPE_IMPLICIT)))
+		return -EOPNOTSUPP;
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP,
+			le16_to_cpu(twt_agrt->req_type));
+	mantissa = le16_to_cpu(twt_agrt->mantissa);
+	duration = twt_agrt->min_twt_dur << 8;
+
+	interval = (u64)mantissa << exp;
+	if (interval < duration)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt)
+{
+	enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
+	u16 req_type = le16_to_cpu(twt_agrt->req_type);
+	enum ieee80211_twt_setup_cmd sta_setup_cmd;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_twt_flow *flow;
+	int flowid, table_id;
+	u8 exp;
+
+	if (mt7996_mac_check_twt_req(twt))
+		goto out;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->twt.n_agrt == MT7996_MAX_TWT_AGRT)
+		goto unlock;
+
+	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
+		goto unlock;
+
+	flowid = ffs(~msta->twt.flowid_mask) - 1;
+	le16p_replace_bits(&twt_agrt->req_type, flowid,
+			   IEEE80211_TWT_REQTYPE_FLOWID);
+
+	table_id = ffs(~dev->twt.table_mask) - 1;
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
+	sta_setup_cmd = FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
+
+	flow = &msta->twt.flow[flowid];
+	memset(flow, 0, sizeof(*flow));
+	INIT_LIST_HEAD(&flow->list);
+	flow->wcid = msta->wcid.idx;
+	flow->table_id = table_id;
+	flow->id = flowid;
+	flow->duration = twt_agrt->min_twt_dur;
+	flow->mantissa = twt_agrt->mantissa;
+	flow->exp = exp;
+	flow->protection = !!(req_type & IEEE80211_TWT_REQTYPE_PROTECTION);
+	flow->flowtype = !!(req_type & IEEE80211_TWT_REQTYPE_FLOWTYPE);
+	flow->trigger = !!(req_type & IEEE80211_TWT_REQTYPE_TRIGGER);
+
+	if (sta_setup_cmd == TWT_SETUP_CMD_REQUEST ||
+	    sta_setup_cmd == TWT_SETUP_CMD_SUGGEST) {
+		u64 interval = (u64)le16_to_cpu(twt_agrt->mantissa) << exp;
+		u64 flow_tsf, curr_tsf;
+		u32 rem;
+
+		flow->sched = true;
+		flow->start_tsf = mt7996_mac_twt_sched_list_add(dev, flow);
+		curr_tsf = __mt7996_get_tsf(hw, msta->vif);
+		div_u64_rem(curr_tsf - flow->start_tsf, interval, &rem);
+		flow_tsf = curr_tsf + interval - rem;
+		twt_agrt->twt = cpu_to_le64(flow_tsf);
+	} else {
+		list_add_tail(&flow->list, &dev->twt_list);
+	}
+	flow->tsf = le64_to_cpu(twt_agrt->twt);
+
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+		goto unlock;
+
+	setup_cmd = TWT_SETUP_CMD_ACCEPT;
+	dev->twt.table_mask |= BIT(table_id);
+	msta->twt.flowid_mask |= BIT(flowid);
+	dev->twt.n_agrt++;
+
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
+out:
+	le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
+			   IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
+		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
+}
+
+void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
+				  struct mt7996_sta *msta,
+				  u8 flowid)
+{
+	struct mt7996_twt_flow *flow;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (flowid >= ARRAY_SIZE(msta->twt.flow))
+		return;
+
+	if (!(msta->twt.flowid_mask & BIT(flowid)))
+		return;
+
+	flow = &msta->twt.flow[flowid];
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow,
+				       MCU_TWT_AGRT_DELETE))
+		return;
+
+	list_del_init(&flow->list);
+	msta->twt.flowid_mask &= ~BIT(flowid);
+	dev->twt.table_mask &= ~BIT(flow->table_id);
+	dev->twt.n_agrt--;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
new file mode 100644
index 000000000000..9f68852012b9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_MAC_H
+#define __MT7996_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+#define MT_RXD0_SW_PKT_TYPE_MASK	GENMASK(31, 16)
+#define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
+#define MT_RXD0_SW_PKT_TYPE_FRAME	0x3801
+
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_RX_FW_MONITOR = 0x0c,
+};
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(11, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(16)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(17)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(18)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(19)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(20)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_BAND_IDX		GENMASK(28, 27)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(7)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 13)
+#define MT_RXD2_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(18)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_CO_ANT		BIT(22)
+#define MT_RXD3_NORMAL_FCS_ERR		BIT(24)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
+
+#define MT_RXV_HDR_BAND_IDX		BIT(24)
+
+/* RXD GROUP4 */
+#define MT_RXD8_FRAME_CONTROL		GENMASK(15, 0)
+
+#define MT_RXD10_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD10_QOS_CTL		GENMASK(31, 16)
+
+#define MT_RXD11_HT_CONTROL		GENMASK(31, 0)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(10, 7)
+#define MT_PRXV_TXBF			BIT(11)
+#define MT_PRXV_HT_AD_CODE		BIT(12)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_HT_SHORT_GI		GENMASK(4, 3)
+#define MT_PRXV_HT_STBC			GENMASK(10, 9)
+#define MT_PRXV_TX_MODE			GENMASK(14, 11)
+#define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
+#define MT_PRXV_DCM			BIT(5)
+#define MT_PRXV_NUM_RX			BIT(8, 6)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+#define MT_CRXV_HE_RU0			GENMASK(7, 0)
+#define MT_CRXV_HE_RU1			GENMASK(15, 8)
+#define MT_CRXV_HE_RU2			GENMASK(23, 16)
+#define MT_CRXV_HE_RU3			GENMASK(31, 24)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+enum tx_header_format {
+	MT_HDR_FORMAT_802_3,
+	MT_HDR_FORMAT_CMD,
+	MT_HDR_FORMAT_802_11,
+	MT_HDR_FORMAT_802_11_EXT,
+};
+
+enum tx_pkt_type {
+	MT_TX_TYPE_CT,
+	MT_TX_TYPE_SF,
+	MT_TX_TYPE_CMD,
+	MT_TX_TYPE_FW,
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+enum tx_mgnt_type {
+	MT_TX_NORMAL,
+	MT_TX_TIMING,
+	MT_TX_ADDBA,
+};
+
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
+#define MT_TXD_SIZE			(8 * 4)
+
+#define MT_TXD0_Q_IDX			GENMASK(31, 25)
+#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
+#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
+#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
+
+#define MT_TXD1_FIXED_RATE		BIT(31)
+#define MT_TXD1_OWN_MAC			GENMASK(30, 25)
+#define MT_TXD1_TID			GENMASK(24, 21)
+#define MT_TXD1_BIP			BIT(24)
+#define MT_TXD1_ETH_802_3		BIT(20)
+#define MT_TXD1_HDR_INFO		GENMASK(20, 16)
+#define MT_TXD1_HDR_FORMAT		GENMASK(15, 14)
+#define MT_TXD1_TGID			GENMASK(13, 12)
+#define MT_TXD1_WLAN_IDX		GENMASK(11, 0)
+
+#define MT_TXD2_POWER_OFFSET		GENMASK(31, 26)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(25, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_HDR_PAD			GENMASK(11, 10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_OWN_MAC_MAP		BIT(8)
+#define MT_TXD2_BF_TYPE			GENMASK(6, 7)
+#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
+#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TXD3_SN_VALID		BIT(31)
+#define MT_TXD3_PN_VALID		BIT(30)
+#define MT_TXD3_SW_POWER_MGMT		BIT(29)
+#define MT_TXD3_BA_DISABLE		BIT(28)
+#define MT_TXD3_SEQ			GENMASK(27, 16)
+#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
+#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
+#define MT_TXD3_HW_AMSDU		BIT(5)
+#define MT_TXD3_BCM			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_FL			BIT(15)
+#define MT_TXD5_BYPASS_TBB		BIT(14)
+#define MT_TXD5_BYPASS_RBB		BIT(13)
+#define MT_TXD5_BSS_COLOR_ZERO		BIT(12)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_SRC			GENMASK(31, 30)
+#define MT_TXD6_VTA			BIT(28)
+#define MT_TXD6_FIXED_BW		BIT(25)
+#define MT_TXD6_BW			GENMASK(24, 22)
+#define MT_TXD6_TX_RATE			GENMASK(21, 16)
+#define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
+#define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
+#define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
+#define MT_TXD6_SPE_ID_IDX		BIT(10)
+#define MT_TXD6_ANT_ID			GENMASK(7, 4)
+#define MT_TXD6_DIS_MAT			BIT(3)
+#define MT_TXD6_DAS			BIT(2)
+#define MT_TXD6_AMSDU_CAP		BIT(1)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_IP_SUM			BIT(29)
+#define MT_TXD7_DROP_BY_SDO		BIT(28)
+#define MT_TXD7_MAC_TXD			BIT(27)
+#define MT_TXD7_CTXD			BIT(26)
+#define MT_TXD7_CTXD_CNT		GENMASK(25, 22)
+#define MT_TXD7_UDP_TCP_SUM		BIT(15)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(13, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+/* VHT/HE only use bits 0-3 */
+#define MT_TX_RATE_IDX			GENMASK(5, 0)
+
+struct mt7996_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+#define MT_TXP_MAX_BUF_NUM	6
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
+#define MT_TXFREE0_PKT_TYPE		GENMASK(31, 27)
+#define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
+#define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
+
+#define MT_TXFREE1_VER			GENMASK(18, 16)
+
+#define MT_TXFREE_INFO_PAIR		BIT(31)
+#define MT_TXFREE_INFO_HEADER		BIT(30)
+#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
+#define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
+
+#define MT_TXS0_BW			GENMASK(31, 29)
+#define MT_TXS0_TID			GENMASK(28, 26)
+#define MT_TXS0_AMPDU			BIT(25)
+#define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+#define MT_TXS0_BA_ERROR		BIT(22)
+#define MT_TXS0_PS_FLAG			BIT(21)
+#define MT_TXS0_TXOP_TIMEOUT		BIT(20)
+#define MT_TXS0_BIP_ERROR		BIT(19)
+
+#define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
+#define MT_TXS0_RTS_TIMEOUT		BIT(17)
+#define MT_TXS0_ACK_TIMEOUT		BIT(16)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+
+#define MT_TXS0_TX_STATUS_HOST		BIT(15)
+#define MT_TXS0_TX_STATUS_MCU		BIT(14)
+#define MT_TXS0_TX_RATE			GENMASK(13, 0)
+
+#define MT_TXS1_SEQNO			GENMASK(31, 20)
+#define MT_TXS1_RESP_RATE		GENMASK(19, 16)
+#define MT_TXS1_RXV_SEQNO		GENMASK(15, 8)
+#define MT_TXS1_TX_POWER_DBM		GENMASK(7, 0)
+
+#define MT_TXS2_BF_STATUS		GENMASK(31, 30)
+#define MT_TXS2_BAND			GENMASK(29, 28)
+#define MT_TXS2_WCID			GENMASK(27, 16)
+#define MT_TXS2_TX_DELAY		GENMASK(15, 0)
+
+#define MT_TXS3_PID			GENMASK(31, 24)
+#define MT_TXS3_RATE_STBC		BIT(7)
+#define MT_TXS3_FIXED_RATE		BIT(6)
+#define MT_TXS3_SRC			GENMASK(5, 4)
+#define MT_TXS3_SHARED_ANTENNA		BIT(3)
+#define MT_TXS3_LAST_TX_RATE		GENMASK(2, 0)
+
+#define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
+
+#define MT_TXS5_F0_FINAL_MPDU		BIT(31)
+#define MT_TXS5_F0_QOS			BIT(30)
+#define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
+#define MT_TXS5_F0_FRONT_TIME		GENMASK(24, 0)
+#define MT_TXS5_F1_MPDU_TX_COUNT	GENMASK(31, 24)
+#define MT_TXS5_F1_MPDU_TX_BYTES	GENMASK(23, 0)
+
+#define MT_TXS6_F0_NOISE_3		GENMASK(31, 24)
+#define MT_TXS6_F0_NOISE_2		GENMASK(23, 16)
+#define MT_TXS6_F0_NOISE_1		GENMASK(15, 8)
+#define MT_TXS6_F0_NOISE_0		GENMASK(7, 0)
+#define MT_TXS6_F1_MPDU_FAIL_COUNT	GENMASK(31, 24)
+#define MT_TXS6_F1_MPDU_FAIL_BYTES	GENMASK(23, 0)
+
+#define MT_TXS7_F0_RCPI_3		GENMASK(31, 24)
+#define MT_TXS7_F0_RCPI_2		GENMASK(23, 16)
+#define MT_TXS7_F0_RCPI_1		GENMASK(15, 8)
+#define MT_TXS7_F0_RCPI_0		GENMASK(7, 0)
+#define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
+#define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
+
+struct mt7996_dfs_pulse {
+	u32 max_width;		/* us */
+	int max_pwr;		/* dbm */
+	int min_pwr;		/* dbm */
+	u32 min_stgr_pri;	/* us */
+	u32 max_stgr_pri;	/* us */
+	u32 min_cr_pri;		/* us */
+	u32 max_cr_pri;		/* us */
+};
+
+struct mt7996_dfs_pattern {
+	u8 enb;
+	u8 stgr;
+	u8 min_crpn;
+	u8 max_crpn;
+	u8 min_crpr;
+	u8 min_pw;
+	u32 min_pri;
+	u32 max_pri;
+	u8 max_pw;
+	u8 min_crbn;
+	u8 max_crbn;
+	u8 min_stgpn;
+	u8 max_stgpn;
+	u8 min_stgpr;
+	u8 rsv[2];
+	u32 min_stgpr_diff;
+} __packed;
+
+struct mt7996_dfs_radar_spec {
+	struct mt7996_dfs_pulse pulse_th;
+	struct mt7996_dfs_pattern radar_pattern[16];
+};
+
+static inline struct mt7996_txp *
+mt7996_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
+}
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
new file mode 100644
index 000000000000..21dea3fa7dc1
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -0,0 +1,1325 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include "mt7996.h"
+#include "mcu.h"
+
+static bool mt7996_dev_running(struct mt7996_dev *dev)
+{
+	struct mt7996_phy *phy;
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		return true;
+
+	phy = mt7996_phy2(dev);
+	if (phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return true;
+
+	phy = mt7996_phy3(dev);
+
+	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+}
+
+static int mt7996_start(struct ieee80211_hw *hw)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	bool running;
+	int ret;
+
+	flush_work(&dev->init_work);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	running = mt7996_dev_running(dev);
+	if (!running) {
+		ret = mt7996_mcu_set_hdr_trans(dev, true);
+		if (ret)
+			goto out;
+	}
+
+	mt7996_mac_enable_nf(dev, phy->mt76->band_idx);
+
+	ret = mt7996_mcu_set_rts_thresh(phy, 0x92b);
+	if (ret)
+		goto out;
+
+	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
+	if (ret)
+		goto out;
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	ieee80211_iterate_interfaces(dev->mt76.hw,
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7996_mcu_set_pm, dev->mt76.hw);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT7996_WATCHDOG_TIME);
+
+	if (!running)
+		mt7996_mac_reset_counters(phy);
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void mt7996_stop(struct ieee80211_hw *hw)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	ieee80211_iterate_interfaces(dev->mt76.hw,
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7996_mcu_set_pm, dev->mt76.hw);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static inline int get_free_idx(u32 mask, u8 start, u8 end)
+{
+	return ffs(~mask & GENMASK(end, start));
+}
+
+static int get_omac_idx(enum nl80211_iftype type, u64 mask)
+{
+	int i;
+
+	switch (type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_STATION:
+		/* prefer hw bssid slot 1-3 */
+		i = get_free_idx(mask, HW_BSSID_1, HW_BSSID_3);
+		if (i)
+			return i - 1;
+
+		if (type != NL80211_IFTYPE_STATION)
+			break;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		break;
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_AP:
+		/* ap uses hw bssid 0 and ext bssid */
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return -1;
+}
+
+static void mt7996_init_bitrate_mask(struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mvif->bitrate_mask.control); i++) {
+		mvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
+		mvif->bitrate_mask.control[i].he_gi = 0xff;
+		mvif->bitrate_mask.control[i].he_ltf = 0xff;
+		mvif->bitrate_mask.control[i].legacy = GENMASK(31, 0);
+		memset(mvif->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(mvif->bitrate_mask.control[i].ht_mcs));
+		memset(mvif->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(mvif->bitrate_mask.control[i].vht_mcs));
+		memset(mvif->bitrate_mask.control[i].he_mcs, 0xff,
+		       sizeof(mvif->bitrate_mask.control[i].he_mcs));
+	}
+}
+
+static int mt7996_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt76_txq *mtxq;
+	u8 band_idx = phy->mt76->band_idx;
+	int idx, ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		phy->monitor_vif = vif;
+
+	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->mt76.idx >= (MT7996_MAX_INTERFACES << dev->dbdc_support)) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	idx = get_omac_idx(vif->type, phy->omac_mask);
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	mvif->mt76.omac_idx = idx;
+	mvif->phy = phy;
+	mvif->mt76.band_idx = band_idx;
+	mvif->mt76.wmm_idx = band_idx;
+
+	ret = mt7996_mcu_add_dev_info(phy, vif, true);
+	if (ret)
+		goto out;
+
+	ret = mt7996_mcu_set_radio_en(phy, true);
+	if (ret)
+		goto out;
+
+	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+
+	idx = MT7996_WTBL_RESERVED - mvif->mt76.idx;
+
+	INIT_LIST_HEAD(&mvif->sta.rc_list);
+	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	mvif->sta.wcid.idx = idx;
+	mvif->sta.wcid.phy_idx = band_idx;
+	mvif->sta.wcid.hw_key_idx = -1;
+	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_packet_id_init(&mvif->sta.wcid);
+
+	mt7996_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = idx;
+	}
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    (!mvif->mt76.omac_idx || mvif->mt76.omac_idx > 3))
+		vif->offload_flags = 0;
+	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+
+	mt7996_init_bitrate_mask(vif);
+	memset(&mvif->cap, -1, sizeof(mvif->cap));
+
+	mt7996_mcu_add_bss_info(phy, vif, true);
+	mt7996_mcu_add_sta(dev, vif, NULL, true);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void mt7996_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta = &mvif->sta;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	int idx = msta->wcid.idx;
+
+	mt7996_mcu_add_bss_info(phy, vif, false);
+	mt7996_mcu_add_sta(dev, vif, NULL, false);
+
+	if (vif == phy->monitor_vif)
+		phy->monitor_vif = NULL;
+
+	mt7996_mcu_add_dev_info(phy, vif, false);
+	mt7996_mcu_set_radio_en(phy, false);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+
+	mutex_lock(&dev->mt76.mutex);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mutex_unlock(&dev->mt76.mutex);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+}
+
+int mt7996_set_channel(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	set_bit(MT76_RESET, &phy->mt76->state);
+
+	mt76_set_channel(phy->mt76);
+
+	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_SWITCH);
+	if (ret)
+		goto out;
+
+	mt7996_mac_set_timing(phy);
+	ret = mt7996_dfs_init_radar_detector(phy);
+	mt7996_mac_cca_stats_reset(phy);
+
+	mt7996_mac_reset_counters(phy);
+	phy->noise = 0;
+
+out:
+	clear_bit(MT76_RESET, &phy->mt76->state);
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt76_txq_schedule_all(phy->mt76);
+
+	ieee80211_queue_delayed_work(phy->mt76->hw,
+				     &phy->mt76->mac_work,
+				     MT7996_WATCHDOG_TIME);
+
+	return ret;
+}
+
+static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct mt76_wcid *wcid = &msta->wcid;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	int idx = key->keyidx;
+	int err = 0;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		wcid_keyidx = &wcid->hw_key_idx2;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
+		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mt7996_mcu_add_bss_info(phy, vif, true);
+	}
+
+	if (cmd == SET_KEY)
+		*wcid_keyidx = idx;
+	else if (idx == *wcid_keyidx)
+		*wcid_keyidx = -1;
+	else
+		goto out;
+
+	mt76_wcid_key_setup(&dev->mt76, wcid,
+			    cmd == SET_KEY ? key : NULL);
+
+	err = mt7996_mcu_add_key(&dev->mt76, vif, &msta->bip,
+				 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+				 &msta->wcid, cmd);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	int ret;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ieee80211_stop_queues(hw);
+		ret = mt7996_set_channel(phy);
+		if (ret)
+			return ret;
+		ieee80211_wake_queues(hw);
+	}
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+		if (!enabled)
+			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+		else
+			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+
+		mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
+			       MT_DMA_DCR0_RXD_G5_EN, enabled);
+		mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+	/* no need to update right away, we'll get BSS_CHANGED_QOS */
+	queue = mt76_connac_lmac_mapping(queue);
+	mvif->queue_params[queue] = *params;
+
+	return 0;
+}
+
+static void mt7996_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
+			MT_WF_RFCR1_DROP_BF_POLL |
+			MT_WF_RFCR1_DROP_BA |
+			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_CFACK;
+	u32 flags = 0;
+
+#define MT76_FILTER(_flag, _hw) do {					\
+		flags |= *total_flags & FIF_##_flag;			\
+		phy->rxfilter &= ~(_hw);				\
+		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+	} while (0)
+
+	mutex_lock(&dev->mt76.mutex);
+
+	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+			   MT_WF_RFCR_DROP_OTHER_BEACON |
+			   MT_WF_RFCR_DROP_FRAME_REPORT |
+			   MT_WF_RFCR_DROP_PROBEREQ |
+			   MT_WF_RFCR_DROP_MCAST_FILTERED |
+			   MT_WF_RFCR_DROP_MCAST |
+			   MT_WF_RFCR_DROP_BCAST |
+			   MT_WF_RFCR_DROP_DUPLICATE |
+			   MT_WF_RFCR_DROP_A2_BSSID |
+			   MT_WF_RFCR_DROP_UNWANTED_CTL |
+			   MT_WF_RFCR_DROP_STBC_MULTI);
+
+	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
+			       MT_WF_RFCR_DROP_A3_MAC |
+			       MT_WF_RFCR_DROP_A3_BSSID);
+
+	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
+
+	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
+			     MT_WF_RFCR_DROP_RTS |
+			     MT_WF_RFCR_DROP_CTL_RSV |
+			     MT_WF_RFCR_DROP_NDPA);
+
+	*total_flags = flags;
+	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
+
+	if (*total_flags & FIF_CONTROL)
+		mt76_clear(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+	else
+		mt76_set(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7996_update_bss_color(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct cfg80211_he_bss_color *bss_color)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP: {
+		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+
+		if (mvif->mt76.omac_idx > HW_BSSID_MAX)
+			return;
+		fallthrough;
+	}
+	case NL80211_IFTYPE_STATION:
+		mt7996_mcu_update_bss_color(dev, vif, bss_color);
+		break;
+	default:
+		break;
+	}
+}
+
+static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *info,
+				    u64 changed)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	/* station mode uses BSSID to map the wlan entry to a peer,
+	 * and then peer references bss_info_rfch to set bandwidth cap.
+	 */
+	if (changed & BSS_CHANGED_BSSID &&
+	    vif->type == NL80211_IFTYPE_STATION) {
+		bool join = !is_zero_ether_addr(info->bssid);
+
+		mt7996_mcu_add_bss_info(phy, vif, join);
+		mt7996_mcu_add_sta(dev, vif, NULL, join);
+	}
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7996_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
+		mt7996_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+	}
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7996_mac_set_timing(phy);
+		}
+	}
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
+		mt7996_mcu_add_bss_info(phy, vif, true);
+		mt7996_mcu_add_sta(dev, vif, NULL, true);
+	}
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7996_mcu_set_tx(dev, vif);
+
+	if (changed & BSS_CHANGED_HE_OBSS_PD)
+		mt7996_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+
+	if (changed & BSS_CHANGED_HE_BSS_COLOR)
+		mt7996_update_bss_color(hw, vif, &info->he_bss_color);
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED))
+		mt7996_mcu_add_beacon(hw, vif, info->enable_beacon);
+
+	if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP ||
+	    changed & BSS_CHANGED_FILS_DISCOVERY)
+		mt7996_mcu_beacon_inband_discov(dev, vif, changed);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7996_mcu_add_beacon(hw, vif, true);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	u8 band_idx = mvif->phy->mt76->band_idx;
+	int ret, idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	if (idx < 0)
+		return -ENOSPC;
+
+	INIT_LIST_HEAD(&msta->rc_list);
+	INIT_LIST_HEAD(&msta->poll_list);
+	msta->vif = mvif;
+	msta->wcid.sta = 1;
+	msta->wcid.idx = idx;
+	msta->wcid.phy_idx = band_idx;
+	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->jiffies = jiffies;
+
+	mt7996_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ret = mt7996_mcu_add_sta(dev, vif, sta, true);
+	if (ret)
+		return ret;
+
+	return mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+}
+
+void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	int i;
+
+	mt7996_mcu_add_sta(dev, vif, sta, false);
+
+	mt7996_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
+		mt7996_mac_twt_teardown_flow(dev, msta, i);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->rc_list))
+		list_del_init(&msta->rc_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+static void mt7996_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+
+	if (control->sta) {
+		struct mt7996_sta *sta;
+
+		sta = (struct mt7996_sta *)control->sta->drv_priv;
+		wcid = &sta->wcid;
+	}
+
+	if (vif && !control->sta) {
+		struct mt7996_vif *mvif;
+
+		mvif = (struct mt7996_vif *)vif->drv_priv;
+		wcid = &mvif->sta.wcid;
+	}
+
+	mt76_tx(mphy, control->sta, wcid, skb);
+}
+
+static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	int ret;
+
+	mutex_lock(&phy->dev->mt76.mutex);
+	ret = mt7996_mcu_set_rts_thresh(phy, val);
+	mutex_unlock(&phy->dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+				   params->buf_size);
+		ret = mt7996_mcu_add_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		ret = mt7996_mcu_add_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		ret = mt7996_mcu_add_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		ret = mt7996_mcu_add_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		ret = mt7996_mcu_add_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7996_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
+			      IEEE80211_STA_NONE);
+}
+
+static int
+mt7996_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
+			      IEEE80211_STA_NOTEXIST);
+}
+
+static int
+mt7996_get_stats(struct ieee80211_hw *hw,
+		 struct ieee80211_low_level_stats *stats)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mib_stats *mib = &phy->mib;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	stats->dot11RTSSuccessCount = mib->rts_cnt;
+	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
+	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
+	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf;
+	u16 n;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
+	/* TSF software read */
+	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_READ);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(phy->mt76->band_idx));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(phy->mt76->band_idx));
+
+	return tsf.t64;
+}
+
+static u64
+mt7996_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	u64 ret;
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = __mt7996_get_tsf(hw, mvif);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void
+mt7996_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       u64 timestamp)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
+	/* TSF software overwrite */
+	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_WRITE);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  s64 timestamp)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
+	/* TSF software adjust*/
+	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_ADJUST);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7996_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = phy->dev;
+
+	mutex_lock(&dev->mt76.mutex);
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt7996_mac_set_timing(phy);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static int
+mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+	u8 band_idx = phy->mt76->band_idx, shift = dev->chainshift[band_idx];
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	phy->mt76->antenna_mask = tx_ant;
+
+	/* restore to the origin chainmask which might have auxiliary path */
+	if (hweight8(tx_ant) == max_nss)
+		phy->mt76->chainmask = (dev->chainmask >> shift) << shift;
+	else
+		phy->mt76->chainmask = tx_ant << shift;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7996_set_stream_vht_txbf_caps(phy);
+	mt7996_set_stream_he_caps(phy);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7996_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct rate_info *txrate = &msta->wcid.rate;
+
+	if (!txrate->legacy && !txrate->flags)
+		return;
+
+	if (txrate->legacy) {
+		sinfo->txrate.legacy = txrate->legacy;
+	} else {
+		sinfo->txrate.mcs = txrate->mcs;
+		sinfo->txrate.nss = txrate->nss;
+		sinfo->txrate.bw = txrate->bw;
+		sinfo->txrate.he_gi = txrate->he_gi;
+		sinfo->txrate.he_dcm = txrate->he_dcm;
+		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+	}
+	sinfo->txrate.flags = txrate->flags;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
+static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = msta->vif->phy->dev;
+	u32 *changed = data;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	msta->changed |= *changed;
+	if (list_empty(&msta->rc_list))
+		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+static void mt7996_sta_rc_update(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 u32 changed)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = phy->dev;
+
+	mt7996_sta_rc_work(&changed, sta);
+	ieee80211_queue_work(hw, &dev->rc_work);
+}
+
+static int
+mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			const struct cfg80211_bitrate_mask *mask)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = phy->dev;
+	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
+
+	mvif->bitrate_mask = *mask;
+
+	/* if multiple rates across different preambles are given we can
+	 * reconfigure this info with all peers using sta_rec command with
+	 * the below exception cases.
+	 * - single rate : if a rate is passed along with different preambles,
+	 * we select the highest one as fixed rate. i.e VHT MCS for VHT peers.
+	 * - multiple rates: if it's not in range format i.e 0-{7,8,9} for VHT
+	 * then multiple MCS setting (MCS 4,5,6) is not supported.
+	 */
+	ieee80211_iterate_stations_atomic(hw, mt7996_sta_rc_work, &changed);
+	ieee80211_queue_work(hw, &dev->rc_work);
+
+	return 0;
+}
+
+static void mt7996_sta_set_4addr(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 bool enabled)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+
+	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
+}
+
+static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+
+	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
+}
+
+static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_ampdu_cnt",
+	"tx_stop_q_empty_cnt",
+	"tx_mpdu_attempts",
+	"tx_mpdu_success",
+	"tx_rwp_fail_cnt",
+	"tx_rwp_need_cnt",
+	"tx_pkt_ebf_cnt",
+	"tx_pkt_ibf_cnt",
+	"tx_ampdu_len:0-1",
+	"tx_ampdu_len:2-10",
+	"tx_ampdu_len:11-19",
+	"tx_ampdu_len:20-28",
+	"tx_ampdu_len:29-37",
+	"tx_ampdu_len:38-46",
+	"tx_ampdu_len:47-55",
+	"tx_ampdu_len:56-79",
+	"tx_ampdu_len:80-103",
+	"tx_ampdu_len:104-127",
+	"tx_ampdu_len:128-151",
+	"tx_ampdu_len:152-175",
+	"tx_ampdu_len:176-199",
+	"tx_ampdu_len:200-223",
+	"tx_ampdu_len:224-247",
+	"ba_miss_count",
+	"tx_beamformer_ppdu_iBF",
+	"tx_beamformer_ppdu_eBF",
+	"tx_beamformer_rx_feedback_all",
+	"tx_beamformer_rx_feedback_he",
+	"tx_beamformer_rx_feedback_vht",
+	"tx_beamformer_rx_feedback_ht",
+	"tx_beamformer_rx_feedback_bw", /* zero based idx: 20, 40, 80, 160 */
+	"tx_beamformer_rx_feedback_nc",
+	"tx_beamformer_rx_feedback_nr",
+	"tx_beamformee_ok_feedback_pkts",
+	"tx_beamformee_feedback_trig",
+	"tx_mu_beamforming",
+	"tx_mu_mpdu",
+	"tx_mu_successful_mpdu",
+	"tx_su_successful_mpdu",
+	"tx_msdu_pack_1",
+	"tx_msdu_pack_2",
+	"tx_msdu_pack_3",
+	"tx_msdu_pack_4",
+	"tx_msdu_pack_5",
+	"tx_msdu_pack_6",
+	"tx_msdu_pack_7",
+	"tx_msdu_pack_8",
+
+	/* rx counters */
+	"rx_fifo_full_cnt",
+	"rx_mpdu_cnt",
+	"channel_idle_cnt",
+	"rx_vector_mismatch_cnt",
+	"rx_delimiter_fail_cnt",
+	"rx_len_mismatch_cnt",
+	"rx_ampdu_cnt",
+	"rx_ampdu_bytes_cnt",
+	"rx_ampdu_valid_subframe_cnt",
+	"rx_ampdu_valid_subframe_b_cnt",
+	"rx_pfdrop_cnt",
+	"rx_vec_queue_overflow_drop_cnt",
+	"rx_ba_cnt",
+
+	/* per vif counters */
+	"v_tx_mode_cck",
+	"v_tx_mode_ofdm",
+	"v_tx_mode_ht",
+	"v_tx_mode_ht_gf",
+	"v_tx_mode_vht",
+	"v_tx_mode_he_su",
+	"v_tx_mode_he_ext_su",
+	"v_tx_mode_he_tb",
+	"v_tx_mode_he_mu",
+	"v_tx_bw_20",
+	"v_tx_bw_40",
+	"v_tx_bw_80",
+	"v_tx_bw_160",
+	"v_tx_mcs_0",
+	"v_tx_mcs_1",
+	"v_tx_mcs_2",
+	"v_tx_mcs_3",
+	"v_tx_mcs_4",
+	"v_tx_mcs_5",
+	"v_tx_mcs_6",
+	"v_tx_mcs_7",
+	"v_tx_mcs_8",
+	"v_tx_mcs_9",
+	"v_tx_mcs_10",
+	"v_tx_mcs_11",
+};
+
+#define MT7996_SSTATS_LEN ARRAY_SIZE(mt7996_gstrings_stats)
+
+/* Ethtool related API */
+static
+void mt7996_get_et_strings(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   u32 sset, u8 *data)
+{
+	if (sset == ETH_SS_STATS)
+		memcpy(data, *mt7996_gstrings_stats,
+		       sizeof(mt7996_gstrings_stats));
+}
+
+static
+int mt7996_get_et_sset_count(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif, int sset)
+{
+	if (sset == ETH_SS_STATS)
+		return MT7996_SSTATS_LEN;
+
+	return 0;
+}
+
+static void mt7996_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt76_ethtool_worker_info *wi = wi_data;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+
+	if (msta->vif->mt76.idx != wi->idx)
+		return;
+
+	mt76_ethtool_worker(wi, &msta->stats);
+}
+
+static
+void mt7996_get_et_stats(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_ethtool_worker_info wi = {
+		.data = data,
+		.idx = mvif->mt76.idx,
+	};
+	struct mib_stats *mib = &phy->mib;
+	/* See mt7996_ampdu_stat_read_phy, etc */
+	int i, ei = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7996_mac_update_stats(phy);
+
+	data[ei++] = mib->tx_ampdu_cnt;
+	data[ei++] = mib->tx_stop_q_empty_cnt;
+	data[ei++] = mib->tx_mpdu_attempts_cnt;
+	data[ei++] = mib->tx_mpdu_success_cnt;
+	data[ei++] = mib->tx_rwp_fail_cnt;
+	data[ei++] = mib->tx_rwp_need_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
+		data[ei++] = phy->mt76->aggr_stats[i];
+	data[ei++] = phy->mib.ba_miss_cnt;
+
+	/* Tx Beamformer monitor */
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
+
+	/* Tx Beamformer Rx feedback monitor */
+	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
+
+	data[ei++] = mib->tx_bf_rx_fb_bw;
+	data[ei++] = mib->tx_bf_rx_fb_nc_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_nr_cnt;
+
+	/* Tx Beamformee Rx NDPA & Tx feedback report */
+	data[ei++] = mib->tx_bf_fb_cpl_cnt;
+	data[ei++] = mib->tx_bf_fb_trig_cnt;
+
+	/* Tx SU & MU counters */
+	data[ei++] = mib->tx_mu_bf_cnt;
+	data[ei++] = mib->tx_mu_mpdu_cnt;
+	data[ei++] = mib->tx_mu_acked_mpdu_cnt;
+	data[ei++] = mib->tx_su_acked_mpdu_cnt;
+
+	/* Tx amsdu info (pack-count histogram) */
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
+		data[ei++] = mib->tx_amsdu[i];
+
+	/* rx counters */
+	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_mpdu_cnt;
+	data[ei++] = mib->channel_idle_cnt;
+	data[ei++] = mib->rx_vector_mismatch_cnt;
+	data[ei++] = mib->rx_delimiter_fail_cnt;
+	data[ei++] = mib->rx_len_mismatch_cnt;
+	data[ei++] = mib->rx_ampdu_cnt;
+	data[ei++] = mib->rx_ampdu_bytes_cnt;
+	data[ei++] = mib->rx_ampdu_valid_subframe_cnt;
+	data[ei++] = mib->rx_ampdu_valid_subframe_bytes_cnt;
+	data[ei++] = mib->rx_pfdrop_cnt;
+	data[ei++] = mib->rx_vec_queue_overflow_drop_cnt;
+	data[ei++] = mib->rx_ba_cnt;
+
+	/* Add values for all stations owned by this vif */
+	wi.initial_stat_idx = ei;
+	ieee80211_iterate_stations_atomic(hw, mt7996_ethtool_worker, &wi);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	if (wi.sta_count == 0)
+		return;
+
+	ei += wi.worker_stat_count;
+	if (ei != MT7996_SSTATS_LEN)
+		dev_err(dev->mt76.dev, "ei: %d  MT7996_SSTATS_LEN: %d",
+			ei, (int)MT7996_SSTATS_LEN);
+}
+
+static void
+mt7996_twt_teardown_request(struct ieee80211_hw *hw,
+			    struct ieee80211_sta *sta,
+			    u8 flowid)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7996_mac_twt_teardown_flow(dev, msta, flowid);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static int
+mt7996_set_radar_background(struct ieee80211_hw *hw,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = phy->dev;
+	int ret = -EINVAL;
+	bool running;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		goto out;
+
+	if (dev->rdd2_phy && dev->rdd2_phy != phy) {
+		/* rdd2 is already locked */
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* rdd2 already configured on a radar channel */
+	running = dev->rdd2_phy &&
+		  cfg80211_chandef_valid(&dev->rdd2_chandef) &&
+		  !!(dev->rdd2_chandef.chan->flags & IEEE80211_CHAN_RADAR);
+
+	if (!chandef || running ||
+	    !(chandef->chan->flags & IEEE80211_CHAN_RADAR)) {
+		ret = mt7996_mcu_rdd_background_enable(phy, NULL);
+		if (ret)
+			goto out;
+
+		if (!running)
+			goto update_phy;
+	}
+
+	ret = mt7996_mcu_rdd_background_enable(phy, chandef);
+	if (ret)
+		goto out;
+
+update_phy:
+	dev->rdd2_phy = chandef ? phy : NULL;
+	if (chandef)
+		dev->rdd2_chandef = *chandef;
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+const struct ieee80211_ops mt7996_ops = {
+	.tx = mt7996_tx,
+	.start = mt7996_start,
+	.stop = mt7996_stop,
+	.add_interface = mt7996_add_interface,
+	.remove_interface = mt7996_remove_interface,
+	.config = mt7996_config,
+	.conf_tx = mt7996_conf_tx,
+	.configure_filter = mt7996_configure_filter,
+	.bss_info_changed = mt7996_bss_info_changed,
+	.sta_add = mt7996_sta_add,
+	.sta_remove = mt7996_sta_remove,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.sta_rc_update = mt7996_sta_rc_update,
+	.set_key = mt7996_set_key,
+	.ampdu_action = mt7996_ampdu_action,
+	.set_rts_threshold = mt7996_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.sw_scan_start = mt76_sw_scan,
+	.sw_scan_complete = mt76_sw_scan_complete,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_txpower = mt76_get_txpower,
+	.channel_switch_beacon = mt7996_channel_switch_beacon,
+	.get_stats = mt7996_get_stats,
+	.get_et_sset_count = mt7996_get_et_sset_count,
+	.get_et_stats = mt7996_get_et_stats,
+	.get_et_strings = mt7996_get_et_strings,
+	.get_tsf = mt7996_get_tsf,
+	.set_tsf = mt7996_set_tsf,
+	.offset_tsf = mt7996_offset_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7996_set_antenna,
+	.set_bitrate_mask = mt7996_set_bitrate_mask,
+	.set_coverage_class = mt7996_set_coverage_class,
+	.sta_statistics = mt7996_sta_statistics,
+	.sta_set_4addr = mt7996_sta_set_4addr,
+	.sta_set_decap_offload = mt7996_sta_set_decap_offload,
+	.add_twt_setup = mt7996_mac_add_twt_setup,
+	.twt_teardown_request = mt7996_twt_teardown_request,
+#ifdef CONFIG_MAC80211_DEBUGFS
+	.sta_add_debugfs = mt7996_sta_add_debugfs,
+#endif
+	.set_radar_background = mt7996_set_radar_background,
+};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
new file mode 100644
index 000000000000..9ce249ac7097
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -0,0 +1,3428 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include "mt7996.h"
+#include "mcu.h"
+#include "mac.h"
+#include "eeprom.h"
+
+struct mt7996_patch_hdr {
+	char build_date[16];
+	char platform[4];
+	__be32 hw_sw_ver;
+	__be32 patch_ver;
+	__be16 checksum;
+	u16 reserved;
+	struct {
+		__be32 patch_ver;
+		__be32 subsys;
+		__be32 feature;
+		__be32 n_region;
+		__be32 crc;
+		u32 reserved[11];
+	} desc;
+} __packed;
+
+struct mt7996_patch_sec {
+	__be32 type;
+	__be32 offs;
+	__be32 size;
+	union {
+		__be32 spec[13];
+		struct {
+			__be32 addr;
+			__be32 len;
+			__be32 sec_key_idx;
+			__be32 align_len;
+			u32 reserved[9];
+		} info;
+	};
+} __packed;
+
+struct mt7996_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 reserved[2];
+	char fw_ver[10];
+	char build_date[15];
+	u32 crc;
+} __packed;
+
+struct mt7996_fw_region {
+	__le32 decomp_crc;
+	__le32 decomp_len;
+	__le32 decomp_blk_sz;
+	u8 reserved[4];
+	__le32 addr;
+	__le32 len;
+	u8 feature_set;
+	u8 reserved1[15];
+} __packed;
+
+#define MCU_PATCH_ADDRESS		0x200000
+
+#define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
+
+static u8
+mt7996_mcu_get_sta_nss(u16 mcs_map)
+{
+	u8 nss;
+
+	for (nss = 8; nss > 0; nss--) {
+		u8 nss_mcs = (mcs_map >> (2 * (nss - 1))) & 3;
+
+		if (nss_mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			break;
+	}
+
+	return nss - 1;
+}
+
+static void
+mt7996_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
+			  u16 mcs_map)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
+	const u16 *mask = msta->vif->bitrate_mask.control[band].he_mcs;
+	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+
+	for (nss = 0; nss < max_nss; nss++) {
+		int mcs;
+
+		switch ((mcs_map >> (2 * nss)) & 0x3) {
+		case IEEE80211_HE_MCS_SUPPORT_0_11:
+			mcs = GENMASK(11, 0);
+			break;
+		case IEEE80211_HE_MCS_SUPPORT_0_9:
+			mcs = GENMASK(9, 0);
+			break;
+		case IEEE80211_HE_MCS_SUPPORT_0_7:
+			mcs = GENMASK(7, 0);
+			break;
+		default:
+			mcs = 0;
+		}
+
+		mcs = mcs ? fls(mcs & mask[nss]) - 1 : -1;
+
+		switch (mcs) {
+		case 0 ... 7:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_7;
+			break;
+		case 8 ... 9:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_9;
+			break;
+		case 10 ... 11:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_11;
+			break;
+		default:
+			mcs = IEEE80211_HE_MCS_NOT_SUPPORTED;
+			break;
+		}
+		mcs_map &= ~(0x3 << (nss * 2));
+		mcs_map |= mcs << (nss * 2);
+	}
+
+	*he_mcs = cpu_to_le16(mcs_map);
+}
+
+static void
+mt7996_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
+			   const u16 *mask)
+{
+	u16 mcs, mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
+	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+
+	for (nss = 0; nss < max_nss; nss++, mcs_map >>= 2) {
+		switch (mcs_map & 0x3) {
+		case IEEE80211_VHT_MCS_SUPPORT_0_9:
+			mcs = GENMASK(9, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_8:
+			mcs = GENMASK(8, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_7:
+			mcs = GENMASK(7, 0);
+			break;
+		default:
+			mcs = 0;
+		}
+
+		vht_mcs[nss] = cpu_to_le16(mcs & mask[nss]);
+	}
+}
+
+static void
+mt7996_mcu_set_sta_ht_mcs(struct ieee80211_sta *sta, u8 *ht_mcs,
+			  const u8 *mask)
+{
+	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+
+	for (nss = 0; nss < max_nss; nss++)
+		ht_mcs[nss] = sta->deflink.ht_cap.mcs.rx_mask[nss] & mask[nss];
+}
+
+static int
+mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7996_mcu_rxd *rxd;
+	struct mt7996_mcu_uni_event *event;
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7996_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+	} else if ((rxd->option & MCU_UNI_CMD_EVENT) &&
+		    rxd->eid == MCU_UNI_EVENT_RESULT) {
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7996_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		/* skip invalid event */
+		if (mcu_cmd != event->cid)
+			ret = -EAGAIN;
+	} else {
+		skb_pull(skb, sizeof(struct mt7996_mcu_rxd));
+	}
+
+	return ret;
+}
+
+static int
+mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_uni_txd *uni_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
+	enum mt76_mcuq_id qid;
+	__le32 *txd;
+	u32 val;
+	u8 seq;
+
+	mdev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mt76.mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mt76.mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD(FW_SCATTER)) {
+		qid = MT_MCUQ_FWDL;
+		goto exit;
+	}
+
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+		qid = MT_MCUQ_WA;
+	else
+		qid = MT_MCUQ_WM;
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
+	txd[0] = cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & __MCU_CMD_FIELD_UNI) {
+		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2CN;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			uni_txd->option = MCU_CMD_UNI_QUERY_ACK;
+		else
+			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+
+		if ((cmd & __MCU_CMD_FIELD_WA) && (cmd & __MCU_CMD_FIELD_WM))
+			uni_txd->s2d_index = MCU_S2D_H2CN;
+		else if (cmd & __MCU_CMD_FIELD_WA)
+			uni_txd->s2d_index = MCU_S2D_H2C;
+		else if (cmd & __MCU_CMD_FIELD_WM)
+			uni_txd->s2d_index = MCU_S2D_H2N;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+
+	mcu_txd->cid = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	mcu_txd->set_query = MCU_Q_NA;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
+	if (mcu_txd->ext_cid) {
+		mcu_txd->ext_cid_ack = 1;
+
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+	}
+
+	if (cmd & __MCU_CMD_FIELD_WA)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
+}
+
+int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
+{
+	struct {
+		__le32 args[3];
+	} req = {
+		.args = {
+			cpu_to_le32(a1),
+			cpu_to_le32(a2),
+			cpu_to_le32(a3),
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), false);
+}
+
+static void
+mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (vif->bss_conf.csa_active)
+		ieee80211_csa_finish(vif);
+}
+
+static void
+mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7996_mcu_rdd_report *r;
+
+	r = (struct mt7996_mcu_rdd_report *)skb->data;
+
+	mphy = dev->mt76.phys[r->band_idx];
+	if (!mphy)
+		return;
+
+	if (r->band_idx == MT_RX_SEL2)
+		cfg80211_background_radar_event(mphy->hw->wiphy,
+						&dev->rdd2_chandef,
+						GFP_ATOMIC);
+	else
+		ieee80211_radar_detected(mphy->hw);
+	dev->hw_pattern++;
+}
+
+static void
+mt7996_mcu_rx_log_message(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+#define UNI_EVENT_FW_LOG_FORMAT 0
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+	const char *data = (char *)&rxd[1] + 4, *type;
+	struct tlv *tlv = (struct tlv *)data;
+	int len;
+
+	if (!(rxd->option & MCU_UNI_CMD_EVENT)) {
+		len = skb->len - sizeof(*rxd);
+		data = (char *)&rxd[1];
+		goto out;
+	}
+
+	if (le16_to_cpu(tlv->tag) != UNI_EVENT_FW_LOG_FORMAT)
+		return;
+
+	data += sizeof(*tlv) + 4;
+	len = le16_to_cpu(tlv->len) - sizeof(*tlv) - 4;
+
+out:
+	switch (rxd->s2d_index) {
+	case 0:
+		if (mt7996_debugfs_rx_log(dev, data, len))
+			return;
+
+		type = "WM";
+		break;
+	case 2:
+		type = "WA";
+		break;
+	default:
+		type = "unknown";
+		break;
+	}
+
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type, len, data);
+}
+
+static void
+mt7996_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (!vif->bss_conf.color_change_active)
+		return;
+
+	ieee80211_color_change_finish(vif);
+}
+
+static void
+mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+#define UNI_EVENT_IE_COUNTDOWN_CSA 0
+#define UNI_EVENT_IE_COUNTDOWN_BCC 1
+	struct header {
+		u8 band;
+		u8 rsv[3];
+	};
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+	const char *data = (char *)&rxd[1], *tail;
+	struct header *hdr = (struct header *)data;
+	struct tlv *tlv = (struct tlv *)(data + 4);
+
+	if (hdr->band && dev->mt76.phys[hdr->band])
+		mphy = dev->mt76.phys[hdr->band];
+
+	tail = skb->data + le16_to_cpu(rxd->len);
+	while (data + sizeof(struct tlv) < tail && le16_to_cpu(tlv->len)) {
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_IE_COUNTDOWN_CSA:
+			ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7996_mcu_csa_finish, mphy->hw);
+			break;
+		case UNI_EVENT_IE_COUNTDOWN_BCC:
+			ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7996_mcu_cca_finish, mphy->hw);
+			break;
+		}
+
+		data += le16_to_cpu(tlv->len);
+		tlv = (struct tlv *)data;
+	}
+}
+
+static void
+mt7996_mcu_rx_ext_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+
+	switch (rxd->ext_eid) {
+	case MCU_EXT_EVENT_FW_LOG_2_HOST:
+		mt7996_mcu_rx_log_message(dev, skb);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7996_mcu_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_EVENT_EXT:
+		mt7996_mcu_rx_ext_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+static void
+mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_UNI_EVENT_FW_LOG_2_HOST:
+		mt7996_mcu_rx_log_message(dev, skb);
+		break;
+	case MCU_UNI_EVENT_IE_COUNTDOWN:
+		mt7996_mcu_ie_countdown(dev, skb);
+		break;
+	case MCU_UNI_EVENT_RDD_REPORT:
+		mt7996_mcu_rx_radar_detected(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+
+	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
+		mt7996_mcu_uni_rx_unsolicited_event(dev, skb);
+		return;
+	}
+
+	/* WA still uses legacy event*/
+	if (rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
+	    !rxd->seq)
+		mt7996_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+static struct tlv *
+mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
+{
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+
+	ptlv = skb_put(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	return ptlv;
+}
+
+static void
+mt7996_mcu_bss_rfch_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			struct mt7996_phy *phy)
+{
+	static const u8 rlm_ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	struct bss_rlm_tlv *ch;
+	struct tlv *tlv;
+	int freq1 = chandef->center_freq1;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*ch));
+
+	ch = (struct bss_rlm_tlv *)tlv;
+	ch->control_channel = chandef->chan->hw_value;
+	ch->center_chan = ieee80211_frequency_to_channel(freq1);
+	ch->bw = mt76_connac_chan_bw(chandef);
+	ch->tx_streams = hweight8(phy->mt76->antenna_mask);
+	ch->rx_streams = hweight8(phy->mt76->antenna_mask);
+	ch->band = rlm_ch_band[chandef->chan->band];
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		ch->center_chan2 = ieee80211_frequency_to_channel(freq2);
+	}
+}
+
+static void
+mt7996_mcu_bss_ra_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+		      struct mt7996_phy *phy)
+{
+	struct bss_ra_tlv *ra;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RA, sizeof(*ra));
+
+	ra = (struct bss_ra_tlv *)tlv;
+	ra->short_preamble = true;
+}
+
+static void
+mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+		      struct mt7996_phy *phy)
+{
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+	struct tlv *tlv;
+
+	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+static void
+mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt7996_phy *phy)
+{
+	struct bss_rate_tlv *bmc;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RATE, sizeof(*bmc));
+
+	bmc = (struct bss_rate_tlv *)tlv;
+	if (band == NL80211_BAND_2GHZ) {
+		bmc->short_preamble = true;
+	} else {
+		bmc->bc_trans = cpu_to_le16(0x8080);
+		bmc->mc_trans = cpu_to_le16(0x8080);
+		bmc->bc_fixed_rate = 1;
+		bmc->mc_fixed_rate = 1;
+		bmc->short_preamble = 1;
+	}
+}
+
+static void
+mt7996_mcu_bss_txcmd_tlv(struct sk_buff *skb, bool en)
+{
+	struct bss_txcmd_tlv *txcmd;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_TXCMD, sizeof(*txcmd));
+
+	txcmd = (struct bss_txcmd_tlv *)tlv;
+	txcmd->txcmd_mode = en;
+}
+
+static void
+mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct bss_mld_tlv *mld;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
+
+	mld = (struct bss_mld_tlv *)tlv;
+	mld->group_mld_id = 0xff;
+	mld->own_mld_id = mvif->mt76.idx;
+	mld->remap_idx = 0xff;
+}
+
+static void
+mt7996_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct bss_sec_tlv *sec;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_SEC, sizeof(*sec));
+
+	sec = (struct bss_sec_tlv *)tlv;
+	sec->cipher = mvif->cipher;
+}
+
+static int
+mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+		       bool bssid, bool enable)
+{
+#define UNI_MUAR_ENTRY 2
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	u32 idx = mvif->mt76.omac_idx - REPEATER_BSSID_START;
+	const u8 *addr = vif->addr;
+
+	struct {
+		struct {
+			u8 band;
+			u8 __rsv[3];
+		} hdr;
+
+		__le16 tag;
+		__le16 len;
+
+		bool smesh;
+		u8 bssid;
+		u8 index;
+		u8 entry_add;
+		u8 addr[ETH_ALEN];
+		u8 __rsv[2];
+	} __packed req = {
+		.hdr.band = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_MUAR_ENTRY),
+		.len = cpu_to_le16(sizeof(req) - sizeof(req.hdr)),
+		.smesh = false,
+		.index = idx * 2 + bssid,
+		.entry_add = true,
+	};
+
+	if (bssid)
+		addr = vif->bss_conf.bssid;
+
+	if (enable)
+		memcpy(req.addr, addr, ETH_ALEN);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(REPT_MUAR), &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta,
+			 struct mt76_phy *phy, u16 wlan_idx,
+			 bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->chandef;
+	struct mt76_connac_bss_basic_tlv *bss;
+	struct tlv *tlv;
+	u32 type;
+	int idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MONITOR:
+		type = CONNECTION_INFRA_AP;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (enable) {
+			rcu_read_lock();
+			if (!sta)
+				sta = ieee80211_find_sta(vif,
+							 vif->bss_conf.bssid);
+			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+			if (sta) {
+				struct mt76_wcid *wcid;
+
+				wcid = (struct mt76_wcid *)sta->drv_priv;
+				wlan_idx = wcid->idx;
+			}
+			rcu_read_unlock();
+		}
+		type = CONNECTION_INFRA_STA;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = CONNECTION_IBSS_ADHOC;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*bss));
+
+	bss = (struct mt76_connac_bss_basic_tlv *)tlv;
+	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
+	bss->sta_idx = cpu_to_le16(wlan_idx);
+	bss->conn_type = cpu_to_le32(type);
+	bss->omac_idx = mvif->omac_idx;
+	bss->band_idx = mvif->band_idx;
+	bss->wmm_idx = mvif->wmm_idx;
+	bss->conn_state = !enable;
+	bss->active = enable;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	bss->hw_bss_idx = idx;
+
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		memcpy(bss->bssid, phy->macaddr, ETH_ALEN);
+		return 0;
+	}
+
+	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
+						chandef->chan->band, NULL);
+
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		bss->phymode_ext |= PHY_MODE_AX_6G;
+
+	return 0;
+}
+
+static struct sk_buff *
+__mt7996_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
+{
+	struct bss_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+
+int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, int enable)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START) {
+		mt7996_mcu_muar_config(phy, vif, false, enable);
+		mt7996_mcu_muar_config(phy, vif, true, enable);
+	}
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					 MT7996_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* bss_basic must be first */
+	mt7996_mcu_bss_basic_tlv(skb, vif, NULL, phy->mt76,
+				 mvif->sta.wcid.idx, enable);
+	mt7996_mcu_bss_sec_tlv(skb, vif);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		goto out;
+
+	if (enable) {
+		mt7996_mcu_bss_rfch_tlv(skb, vif, phy);
+		mt7996_mcu_bss_bmc_tlv(skb, phy);
+		mt7996_mcu_bss_ra_tlv(skb, vif, phy);
+		mt7996_mcu_bss_txcmd_tlv(skb, true);
+
+		if (vif->bss_conf.he_support)
+			mt7996_mcu_bss_he_tlv(skb, vif, phy);
+
+		/* this tag is necessary no matter if the vif is MLD */
+		mt7996_mcu_bss_mld_tlv(skb, vif);
+	}
+out:
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+static int
+mt7996_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+		  struct ieee80211_ampdu_params *params,
+		  bool enable, bool tx)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
+	struct sta_rec_ba_uni *ba;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba_uni *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+
+	return mt76_mcu_skb_send_msg(dev, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+/** starec & wtbl **/
+int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
+	struct mt7996_vif *mvif = msta->vif;
+
+	if (enable && !params->amsdu)
+		msta->wcid.amsdu = false;
+
+	return mt7996_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				 enable, true);
+}
+
+int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
+	struct mt7996_vif *mvif = msta->vif;
+
+	return mt7996_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				 enable, false);
+}
+
+static void
+mt7996_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp mcs_map;
+	struct sta_rec_he_v2 *he;
+	struct tlv *tlv;
+	int i = 0;
+
+	if (!sta->deflink.he_cap.has_he)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_V2, sizeof(*he));
+
+	he = (struct sta_rec_he_v2 *)tlv;
+	for (i = 0; i < 11; i++) {
+		if (i < 6)
+			he->he_mac_cap[i] = cpu_to_le16(elem->mac_cap_info[i]);
+		he->he_phy_cap[i] = cpu_to_le16(elem->phy_cap_info[i]);
+	}
+
+	mcs_map = sta->deflink.he_cap.he_mcs_nss_supp;
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			mt7996_mcu_set_sta_he_mcs(sta,
+						  &he->max_nss_mcs[CMD_HE_MCS_BW8080],
+						  le16_to_cpu(mcs_map.rx_mcs_80p80));
+
+		mt7996_mcu_set_sta_he_mcs(sta,
+					  &he->max_nss_mcs[CMD_HE_MCS_BW160],
+					  le16_to_cpu(mcs_map.rx_mcs_160));
+		fallthrough;
+	default:
+		mt7996_mcu_set_sta_he_mcs(sta,
+					  &he->max_nss_mcs[CMD_HE_MCS_BW80],
+					  le16_to_cpu(mcs_map.rx_mcs_80));
+		break;
+	}
+
+	he->pkt_ext = 2;
+}
+
+static void
+mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct sta_rec_he_6g_capa *he_6g;
+	struct tlv *tlv;
+
+	if (!sta->deflink.he_6ghz_capa.capa)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G, sizeof(*he_6g));
+
+	he_6g = (struct sta_rec_he_6g_capa *)tlv;
+	he_6g->capa = cpu_to_le16(sta->deflink.he_6ghz_capa.capa);
+}
+
+static void
+mt7996_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct sta_rec_ht *ht;
+	struct tlv *tlv;
+
+	if (!sta->deflink.ht_cap.ht_supported)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+
+	ht = (struct sta_rec_ht *)tlv;
+	ht->ht_cap = cpu_to_le16(sta->deflink.ht_cap.cap);
+}
+
+static void
+mt7996_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct sta_rec_vht *vht;
+	struct tlv *tlv;
+
+	/* For 6G band, this tlv is necessary to let hw work normally */
+	if (!sta->deflink.he_6ghz_capa.capa && !sta->deflink.vht_cap.vht_supported)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+
+	vht = (struct sta_rec_vht *)tlv;
+	vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
+	vht->vht_rx_mcs_map = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
+	vht->vht_tx_mcs_map = sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
+}
+
+static void
+mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			 struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	if (!sta->deflink.agg.max_amsdu_len)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	msta->wcid.amsdu = true;
+
+	switch (sta->deflink.agg.max_amsdu_len) {
+	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
+		amsdu->max_mpdu_size =
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
+		return;
+	case IEEE80211_MAX_MPDU_LEN_HT_7935:
+	case IEEE80211_MAX_MPDU_LEN_VHT_7991:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991;
+		return;
+	default:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
+		return;
+	}
+}
+
+static inline bool
+mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, bool bfee)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return false;
+
+	if (!bfee && tx_ant < 2)
+		return false;
+
+	if (sta->deflink.he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+
+		if (bfee)
+			return mvif->cap.he_su_ebfee &&
+			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		else
+			return mvif->cap.he_su_ebfer &&
+			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+	}
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		u32 cap = sta->deflink.vht_cap.cap;
+
+		if (bfee)
+			return mvif->cap.vht_su_ebfee &&
+			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		else
+			return mvif->cap.vht_su_ebfer &&
+			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+	}
+
+	return false;
+}
+
+static void
+mt7996_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
+{
+	bf->sounding_phy = MT_PHY_TYPE_OFDM;
+	bf->ndp_rate = 0;				/* mcs0 */
+	bf->ndpa_rate = MT7996_CFEND_RATE_DEFAULT;	/* ofdm 24m */
+	bf->rept_poll_rate = MT7996_CFEND_RATE_DEFAULT;	/* ofdm 24m */
+}
+
+static void
+mt7996_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
+		       struct sta_rec_bf *bf)
+{
+	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
+	u8 n = 0;
+
+	bf->tx_mode = MT_PHY_TYPE_HT;
+
+	if ((mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF) &&
+	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
+		n = FIELD_GET(IEEE80211_HT_MCS_TX_MAX_STREAMS_MASK,
+			      mcs->tx_params);
+	else if (mcs->rx_mask[3])
+		n = 3;
+	else if (mcs->rx_mask[2])
+		n = 2;
+	else if (mcs->rx_mask[1])
+		n = 1;
+
+	bf->nrow = hweight8(phy->mt76->antenna_mask) - 1;
+	bf->ncol = min_t(u8, bf->nrow, n);
+	bf->ibf_ncol = n;
+}
+
+static void
+mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
+			struct sta_rec_bf *bf, bool explicit)
+{
+	struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+	struct ieee80211_sta_vht_cap *vc = &phy->mt76->sband_5g.sband.vht_cap;
+	u16 mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
+	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
+	u8 tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+
+	bf->tx_mode = MT_PHY_TYPE_VHT;
+
+	if (explicit) {
+		u8 sts, snd_dim;
+
+		mt7996_mcu_sta_sounding_rate(bf);
+
+		sts = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
+				pc->cap);
+		snd_dim = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				    vc->cap);
+		bf->nrow = min_t(u8, min_t(u8, snd_dim, sts), tx_ant);
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+		bf->ibf_ncol = bf->ncol;
+
+		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->nrow = 1;
+	} else {
+		bf->nrow = tx_ant;
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+		bf->ibf_ncol = nss_mcs;
+
+		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->ibf_nrow = 1;
+	}
+}
+
+static void
+mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
+		       struct mt7996_phy *phy, struct sta_rec_bf *bf)
+{
+	struct ieee80211_sta_he_cap *pc = &sta->deflink.he_cap;
+	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
+	const struct ieee80211_sta_he_cap *vc =
+		mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
+	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
+	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
+	u8 snd_dim, sts;
+
+	bf->tx_mode = MT_PHY_TYPE_HE_SU;
+
+	mt7996_mcu_sta_sounding_rate(bf);
+
+	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMING_FB,
+				pe->phy_cap_info[6]);
+	bf->trigger_mu = HE_PHY(CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB,
+				pe->phy_cap_info[6]);
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+			 ve->phy_cap_info[5]);
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
+	bf->nrow = min_t(u8, snd_dim, sts);
+	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+	bf->ibf_ncol = bf->ncol;
+
+	if (sta->deflink.bandwidth != IEEE80211_STA_RX_BW_160)
+		return;
+
+	/* go over for 160MHz and 80p80 */
+	if (pe->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
+		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
+		nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
+
+		bf->ncol_gt_bw80 = nss_mcs;
+	}
+
+	if (pe->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
+		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80p80);
+		nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
+
+		if (bf->ncol_gt_bw80)
+			bf->ncol_gt_bw80 = min_t(u8, bf->ncol_gt_bw80, nss_mcs);
+		else
+			bf->ncol_gt_bw80 = nss_mcs;
+	}
+
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+			 ve->phy_cap_info[5]);
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
+
+	bf->nrow_gt_bw80 = min_t(int, snd_dim, sts);
+}
+
+static void
+mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mvif->phy;
+	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+	struct sta_rec_bf *bf;
+	struct tlv *tlv;
+	const u8 matrix[4][4] = {
+		{0, 0, 0, 0},
+		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
+		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
+		{3, 5, 6, 0}	/* 4x1, 4x2, 4x3, 4x4 */
+	};
+	bool ebf;
+
+	if (!(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	ebf = mt7996_is_ebf_supported(phy, vif, sta, false);
+	if (!ebf && !dev->ibf)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
+	bf = (struct sta_rec_bf *)tlv;
+
+	/* he: eBF only, in accordance with spec
+	 * vht: support eBF and iBF
+	 * ht: iBF only, since mac80211 lacks of eBF support
+	 */
+	if (sta->deflink.he_cap.has_he && ebf)
+		mt7996_mcu_sta_bfer_he(sta, vif, phy, bf);
+	else if (sta->deflink.vht_cap.vht_supported)
+		mt7996_mcu_sta_bfer_vht(sta, phy, bf, ebf);
+	else if (sta->deflink.ht_cap.ht_supported)
+		mt7996_mcu_sta_bfer_ht(sta, phy, bf);
+	else
+		return;
+
+	bf->bf_cap = ebf ? ebf : dev->ibf << 1;
+	bf->bw = sta->deflink.bandwidth;
+	bf->ibf_dbw = sta->deflink.bandwidth;
+	bf->ibf_nrow = tx_ant;
+
+	if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
+		bf->ibf_timeout = 0x48;
+	else
+		bf->ibf_timeout = 0x18;
+
+	if (ebf && bf->nrow != tx_ant)
+		bf->mem_20m = matrix[tx_ant][bf->ncol];
+	else
+		bf->mem_20m = matrix[bf->nrow][bf->ncol];
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+	case IEEE80211_STA_RX_BW_80:
+		bf->mem_total = bf->mem_20m * 2;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		bf->mem_total = bf->mem_20m;
+		break;
+	case IEEE80211_STA_RX_BW_20:
+	default:
+		break;
+	}
+}
+
+static void
+mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mvif->phy;
+	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
+	struct sta_rec_bfee *bfee;
+	struct tlv *tlv;
+	u8 nrow = 0;
+
+	if (!(sta->deflink.vht_cap.vht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	if (!mt7996_is_ebf_supported(phy, vif, sta, true))
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
+	bfee = (struct sta_rec_bfee *)tlv;
+
+	if (sta->deflink.he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+
+		nrow = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+			      pe->phy_cap_info[5]);
+	} else if (sta->deflink.vht_cap.vht_supported) {
+		struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+
+		nrow = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				 pc->cap);
+	}
+
+	/* reply with identity matrix to avoid 2x2 BF negative gain */
+	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
+}
+
+static void
+mt7996_mcu_sta_phy_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct sta_rec_phy *phy;
+	struct tlv *tlv;
+	u8 af = 0, mm = 0;
+
+	if (!sta->deflink.ht_cap.ht_supported && !sta->deflink.he_6ghz_capa.capa)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+
+	phy = (struct sta_rec_phy *)tlv;
+	if (sta->deflink.ht_cap.ht_supported) {
+		af = sta->deflink.ht_cap.ampdu_factor;
+		mm = sta->deflink.ht_cap.ampdu_density;
+	}
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		u8 vht_af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+				      sta->deflink.vht_cap.cap);
+
+		af = max_t(u8, af, vht_af);
+	}
+
+	if (sta->deflink.he_6ghz_capa.capa) {
+		af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+				   IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+		mm = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+				   IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+	}
+
+	phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR, af) |
+		     FIELD_PREP(IEEE80211_HT_AMPDU_PARM_DENSITY, mm);
+	phy->max_ampdu_len = af;
+}
+
+static void
+mt7996_mcu_sta_hdrt_tlv(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct sta_rec_hdrt *hdrt;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HDRT, sizeof(*hdrt));
+
+	hdrt = (struct sta_rec_hdrt *)tlv;
+	hdrt->hdrt_mode = 1;
+}
+
+static void
+mt7996_mcu_sta_hdr_trans_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta)
+{
+	struct sta_rec_hdr_trans *hdr_trans;
+	struct mt76_wcid *wcid;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HDR_TRANS, sizeof(*hdr_trans));
+	hdr_trans = (struct sta_rec_hdr_trans *)tlv;
+	hdr_trans->dis_rx_hdr_tran = true;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		hdr_trans->to_ds = true;
+	else
+		hdr_trans->from_ds = true;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (!wcid)
+		return;
+
+	hdr_trans->dis_rx_hdr_tran = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
+		hdr_trans->to_ds = true;
+		hdr_trans->from_ds = true;
+	}
+}
+
+static enum mcu_mmps_mode
+mt7996_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
+{
+	switch (smps) {
+	case IEEE80211_SMPS_OFF:
+		return MCU_MMPS_DISABLE;
+	case IEEE80211_SMPS_STATIC:
+		return MCU_MMPS_STATIC;
+	case IEEE80211_SMPS_DYNAMIC:
+		return MCU_MMPS_DYNAMIC;
+	default:
+		return MCU_MMPS_DISABLE;
+	}
+}
+
+int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
+				   void *data, u16 version)
+{
+	struct ra_fixed_rate *req;
+	struct uni_header hdr;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int len;
+
+	len = sizeof(hdr) + sizeof(*req);
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_RA_FIXED_RATE, sizeof(*req));
+	req = (struct ra_fixed_rate *)tlv;
+	req->version = cpu_to_le16(version);
+	memcpy(&req->rate, data, sizeof(req->rate));
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WM_UNI_CMD(RA), true);
+}
+
+static void
+mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
+			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_phy *mphy = mvif->phy->mt76;
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
+	enum nl80211_band band = chandef->chan->band;
+	struct sta_rec_ra *ra;
+	struct tlv *tlv;
+	u32 supp_rate = sta->deflink.supp_rates[band];
+	u32 cap = sta->wme ? STA_CAP_WMM : 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
+	ra = (struct sta_rec_ra *)tlv;
+
+	ra->valid = true;
+	ra->auto_rate = true;
+	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, sta);
+	ra->channel = chandef->chan->hw_value;
+	ra->bw = sta->deflink.bandwidth;
+	ra->phy.bw = sta->deflink.bandwidth;
+	ra->mmps_mode = mt7996_mcu_get_mmps_mode(sta->deflink.smps_mode);
+
+	if (supp_rate) {
+		supp_rate &= mask->control[band].legacy;
+		ra->rate_len = hweight32(supp_rate);
+
+		if (band == NL80211_BAND_2GHZ) {
+			ra->supp_mode = MODE_CCK;
+			ra->supp_cck_rate = supp_rate & GENMASK(3, 0);
+
+			if (ra->rate_len > 4) {
+				ra->supp_mode |= MODE_OFDM;
+				ra->supp_ofdm_rate = supp_rate >> 4;
+			}
+		} else {
+			ra->supp_mode = MODE_OFDM;
+			ra->supp_ofdm_rate = supp_rate;
+		}
+	}
+
+	if (sta->deflink.ht_cap.ht_supported) {
+		ra->supp_mode |= MODE_HT;
+		ra->af = sta->deflink.ht_cap.ampdu_factor;
+		ra->ht_gf = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
+
+		cap |= STA_CAP_HT;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
+			cap |= STA_CAP_SGI_20;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
+			cap |= STA_CAP_SGI_40;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_TX_STBC)
+			cap |= STA_CAP_TX_STBC;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
+			cap |= STA_CAP_RX_STBC;
+		if (mvif->cap.ht_ldpc &&
+		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
+			cap |= STA_CAP_LDPC;
+
+		mt7996_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
+					  mask->control[band].ht_mcs);
+		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
+	}
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		u8 af;
+
+		ra->supp_mode |= MODE_VHT;
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->deflink.vht_cap.cap);
+		ra->af = max_t(u8, ra->af, af);
+
+		cap |= STA_CAP_VHT;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+			cap |= STA_CAP_VHT_SGI_80;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+			cap |= STA_CAP_VHT_SGI_160;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC)
+			cap |= STA_CAP_VHT_TX_STBC;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
+			cap |= STA_CAP_VHT_RX_STBC;
+		if (mvif->cap.vht_ldpc &&
+		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
+			cap |= STA_CAP_VHT_LDPC;
+
+		mt7996_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs,
+					   mask->control[band].vht_mcs);
+	}
+
+	if (sta->deflink.he_cap.has_he) {
+		ra->supp_mode |= MODE_HE;
+		cap |= STA_CAP_HE;
+
+		if (sta->deflink.he_6ghz_capa.capa)
+			ra->af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	}
+	ra->sta_cap = cpu_to_le32(cap);
+}
+
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta, bool changed)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct sk_buff *skb;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      &msta->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* firmware rc algorithm refers to sta_rec_he for HE control.
+	 * once dev->rc_work changes the settings driver should also
+	 * update sta_rec_he here.
+	 */
+	if (changed)
+		mt7996_mcu_sta_he_tlv(skb, sta);
+
+	/* sta_rec_ra accommodates BW, NSS and only MCS range format
+	 * i.e 0-{7,8,9} for VHT.
+	 */
+	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+static int
+mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta)
+{
+#define MT_STA_BSS_GROUP		1
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta;
+	struct {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+		__le16 wlan_idx;
+		u8 __rsv2[2];
+		__le32 action;
+		__le32 val;
+		u8 __rsv3[8];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_VOW_DRR_CTRL),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.action = cpu_to_le32(MT_STA_BSS_GROUP),
+		.val = cpu_to_le32(mvif->mt76.idx % 16),
+	};
+
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+	req.wlan_idx = cpu_to_le16(msta->wcid.idx);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(VOW), &req,
+				 sizeof(req), true);
+}
+
+int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta;
+	struct sk_buff *skb;
+	int ret;
+
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      &msta->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* starec basic */
+	mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable,
+			!rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
+	if (!enable)
+		goto out;
+
+	/* tag order is in accordance with firmware dependency. */
+	if (sta) {
+		/* starec phy */
+		mt7996_mcu_sta_phy_tlv(dev, skb, vif, sta);
+		/* starec hdrt mode */
+		mt7996_mcu_sta_hdrt_tlv(dev, skb);
+		/* starec bfer */
+		mt7996_mcu_sta_bfer_tlv(dev, skb, vif, sta);
+		/* starec ht */
+		mt7996_mcu_sta_ht_tlv(skb, sta);
+		/* starec vht */
+		mt7996_mcu_sta_vht_tlv(skb, sta);
+		/* starec uapsd */
+		mt76_connac_mcu_sta_uapsd(skb, vif, sta);
+		/* starec amsdu */
+		mt7996_mcu_sta_amsdu_tlv(dev, skb, vif, sta);
+		/* starec he */
+		mt7996_mcu_sta_he_tlv(skb, sta);
+		/* starec he 6g*/
+		mt7996_mcu_sta_he_6g_tlv(skb, sta);
+		/* TODO: starec muru */
+		/* starec bfee */
+		mt7996_mcu_sta_bfee_tlv(dev, skb, vif, sta);
+		/* starec hdr trans */
+		mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+	}
+
+	ret = mt7996_mcu_add_group(dev, vif, sta);
+	if (ret) {
+		dev_kfree_skb(skb);
+		return ret;
+	}
+out:
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+static int
+mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct sk_buff *skb,
+		       struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct sta_rec_sec_uni *sec;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	sec = (struct sta_rec_sec_uni *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key_uni *sec_key;
+		u8 cipher;
+
+		cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		if (cipher == MCU_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+
+		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
+			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
+			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
+			sec_key->key_id = sta_key_conf->keyidx;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, sta_key_conf->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
+			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+			sec->n_cipher = 2;
+		} else {
+			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
+			sec_key->cipher_id = cipher;
+			sec_key->key_id = key->keyidx;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MCU_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			/* store key_conf for BIP batch update */
+			if (cipher == MCU_CIPHER_AES_CCMP) {
+				memcpy(sta_key_conf->key, key->key, key->keylen);
+				sta_key_conf->keyidx = key->keyidx;
+			}
+
+			sec->n_cipher = 1;
+		}
+	} else {
+		sec->n_cipher = 0;
+	}
+
+	return 0;
+}
+
+int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct ieee80211_key_conf *key, int mcu_cmd,
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt7996_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
+}
+
+int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct {
+		struct req_hdr {
+			u8 omac_idx;
+			u8 dbdc_idx;
+			u8 __rsv[2];
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 __rsv;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} data = {
+		.hdr = {
+			.omac_idx = mvif->mt76.omac_idx,
+			.dbdc_idx = mvif->mt76.band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
+		return mt7996_mcu_muar_config(phy, vif, false, enable);
+
+	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WMWA_UNI_CMD(DEV_INFO_UPDATE),
+				 &data, sizeof(data), true);
+}
+
+static void
+mt7996_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
+			 struct sk_buff *skb,
+			 struct ieee80211_mutable_offsets *offs)
+{
+	struct bss_bcn_cntdwn_tlv *info;
+	struct tlv *tlv;
+	u16 tag;
+
+	if (!offs->cntdwn_counter_offs[0])
+		return;
+
+	tag = vif->bss_conf.csa_active ? UNI_BSS_INFO_BCN_CSA : UNI_BSS_INFO_BCN_BCC;
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb, tag, sizeof(*info));
+
+	info = (struct bss_bcn_cntdwn_tlv *)tlv;
+	info->cnt = skb->data[offs->cntdwn_counter_offs[0]];
+}
+
+static void
+mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct sk_buff *rskb, struct sk_buff *skb,
+		       struct bss_bcn_content_tlv *bcn,
+		       struct ieee80211_mutable_offsets *offs)
+{
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	u8 *buf;
+
+	bcn->pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	bcn->tim_ie_pos = cpu_to_le16(offs->tim_offset);
+
+	if (offs->cntdwn_counter_offs[0]) {
+		u16 offset = offs->cntdwn_counter_offs[0];
+
+		if (vif->bss_conf.csa_active)
+			bcn->csa_ie_pos = cpu_to_le16(offset - 4);
+		if (vif->bss_conf.color_change_active)
+			bcn->bcc_ie_pos = cpu_to_le16(offset - 3);
+	}
+
+	buf = (u8 *)bcn + sizeof(*bcn) - MAX_BEACON_SIZE;
+	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+			      BSS_CHANGED_BEACON);
+	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
+}
+
+static void
+mt7996_mcu_beacon_check_caps(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			     struct sk_buff *skb)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_cap *vc = &mvif->cap;
+	const struct ieee80211_he_cap_elem *he;
+	const struct ieee80211_vht_cap *vht;
+	const struct ieee80211_ht_cap *ht;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	const u8 *ie;
+	u32 len, bc;
+
+	/* Check missing configuration options to allow AP mode in mac80211
+	 * to remain in sync with hostapd settings, and get a subset of
+	 * beacon and hardware capabilities.
+	 */
+	if (WARN_ON_ONCE(skb->len <= (mgmt->u.beacon.variable - skb->data)))
+		return;
+
+	memset(vc, 0, sizeof(*vc));
+
+	len = skb->len - (mgmt->u.beacon.variable - skb->data);
+
+	ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, mgmt->u.beacon.variable,
+			      len);
+	if (ie && ie[1] >= sizeof(*ht)) {
+		ht = (void *)(ie + 2);
+		vc->ht_ldpc |= !!(le16_to_cpu(ht->cap_info) &
+				  IEEE80211_HT_CAP_LDPC_CODING);
+	}
+
+	ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, mgmt->u.beacon.variable,
+			      len);
+	if (ie && ie[1] >= sizeof(*vht)) {
+		u32 pc = phy->mt76->sband_5g.sband.vht_cap.cap;
+
+		vht = (void *)(ie + 2);
+		bc = le32_to_cpu(vht->vht_cap_info);
+
+		vc->vht_ldpc |= !!(bc & IEEE80211_VHT_CAP_RXLDPC);
+		vc->vht_su_ebfer =
+			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		vc->vht_su_ebfee =
+			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+		vc->vht_mu_ebfer =
+			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+		vc->vht_mu_ebfee =
+			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+	}
+
+	ie = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY,
+				  mgmt->u.beacon.variable, len);
+	if (ie && ie[1] >= sizeof(*he) + 1) {
+		const struct ieee80211_sta_he_cap *pc =
+			mt76_connac_get_he_phy_cap(phy->mt76, vif);
+		const struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
+
+		he = (void *)(ie + 3);
+
+		vc->he_ldpc =
+			HE_PHY(CAP1_LDPC_CODING_IN_PAYLOAD, pe->phy_cap_info[1]);
+		vc->he_su_ebfer =
+			HE_PHY(CAP3_SU_BEAMFORMER, he->phy_cap_info[3]) &&
+			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		vc->he_su_ebfee =
+			HE_PHY(CAP4_SU_BEAMFORMEE, he->phy_cap_info[4]) &&
+			HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+		vc->he_mu_ebfer =
+			HE_PHY(CAP4_MU_BEAMFORMER, he->phy_cap_info[4]) &&
+			HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4]);
+	}
+}
+
+int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif, int en)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct ieee80211_mutable_offsets offs;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb, *rskb;
+	struct tlv *tlv;
+	struct bss_bcn_content_tlv *bcn;
+
+	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					  MT7996_BEACON_UPDATE_SIZE);
+	if (IS_ERR(rskb))
+		return PTR_ERR(rskb);
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb,
+				     UNI_BSS_INFO_BCN_CONTENT, sizeof(*bcn));
+	bcn = (struct bss_bcn_content_tlv *)tlv;
+	bcn->enable = en;
+
+	if (!en)
+		goto out;
+
+	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > MAX_BEACON_SIZE - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
+
+	mt7996_mcu_beacon_check_caps(phy, vif, skb);
+
+	mt7996_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
+	/* TODO: subtag - 11v MBSSID */
+	mt7996_mcu_beacon_cntdwn(vif, rskb, skb, &offs);
+	dev_kfree_skb(skb);
+out:
+	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
+				    struct ieee80211_vif *vif, u32 changed)
+{
+#define OFFLOAD_TX_MODE_SU	BIT(0)
+#define OFFLOAD_TX_MODE_MU	BIT(1)
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct bss_inband_discovery_tlv *discov;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *rskb, *skb = NULL;
+	struct tlv *tlv;
+	u8 *buf, interval;
+
+	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					  MT7996_INBAND_FRAME_SIZE);
+	if (IS_ERR(rskb))
+		return PTR_ERR(rskb);
+
+	if (changed & BSS_CHANGED_FILS_DISCOVERY &&
+	    vif->bss_conf.fils_discovery.max_interval) {
+		interval = vif->bss_conf.fils_discovery.max_interval;
+		skb = ieee80211_get_fils_discovery_tmpl(hw, vif);
+	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
+		   vif->bss_conf.unsol_bcast_probe_resp_interval) {
+		interval = vif->bss_conf.unsol_bcast_probe_resp_interval;
+		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
+	}
+
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > MAX_INBAND_FRAME_SIZE - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+	info->control.vif = vif;
+	info->band = band;
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_OFFLOAD, sizeof(*discov));
+
+	discov = (struct bss_inband_discovery_tlv *)tlv;
+	discov->tx_mode = OFFLOAD_TX_MODE_SU;
+	/* 0: UNSOL PROBE RESP, 1: FILS DISCOV */
+	discov->tx_type = !!(changed & BSS_CHANGED_FILS_DISCOVERY);
+	discov->tx_interval = interval;
+	discov->prob_rsp_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	discov->enable = true;
+	discov->wcid = cpu_to_le16(MT7996_WTBL_RESERVED);
+
+	buf = (u8 *)tlv + sizeof(*discov) - MAX_INBAND_FRAME_SIZE;
+
+	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+			      changed);
+
+	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
+
+	dev_kfree_skb(skb);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, rskb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+static int mt7996_driver_own(struct mt7996_dev *dev, u8 band)
+{
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(band), MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND(band),
+			    MT_TOP_LPCR_HOST_FW_OWN_STAT, 0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	/* clear irq when the driver own success */
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND_IRQ_STAT(band),
+		MT_TOP_LPCR_HOST_BAND_STAT);
+
+	return 0;
+}
+
+static u32 mt7996_patch_sec_mode(u32 key_info)
+{
+	u32 sec = u32_get_bits(key_info, MT7996_PATCH_SEC), key = 0;
+
+	if (key_info == GENMASK(31, 0) || sec == MT7996_SEC_MODE_PLAIN)
+		return 0;
+
+	if (sec == MT7996_SEC_MODE_AES)
+		key = u32_get_bits(key_info, MT7996_PATCH_AES_KEY);
+	else
+		key = u32_get_bits(key_info, MT7996_PATCH_SCRAMBLE_KEY);
+
+	return MT7996_SEC_ENCRYPT | MT7996_SEC_IV |
+	       u32_encode_bits(key, MT7996_SEC_KEY_IDX);
+}
+
+static int mt7996_load_patch(struct mt7996_dev *dev)
+{
+	const struct mt7996_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+	int i, ret, sem;
+
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 1);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, MT7996_ROM_PATCH, dev->mt76.dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7996_patch_hdr *)(fw->data);
+
+	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt7996_patch_sec *sec;
+		const u8 *dl;
+		u32 len, addr, sec_key_idx, mode = DL_MODE_NEED_RSP;
+
+		sec = (struct mt7996_patch_sec *)(fw->data + sizeof(*hdr) +
+						  i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		sec_key_idx = be32_to_cpu(sec->info.sec_key_idx);
+		dl = fw->data + be32_to_cpu(sec->offs);
+
+		mode |= mt7996_patch_sec_mode(sec_key_idx);
+
+		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
+					       dl, len, 4096);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt76_connac_mcu_start_patch(&dev->mt76);
+	if (ret)
+		dev_err(dev->mt76.dev, "Failed to start patch\n");
+
+out:
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 0);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
+		break;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int
+mt7996_mcu_send_ram_firmware(struct mt7996_dev *dev,
+			     const struct mt7996_fw_trailer *hdr,
+			     const u8 *data, bool is_wa)
+{
+	int i, offset = 0;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt7996_fw_region *region;
+		int err;
+		u32 len, addr, mode;
+
+		region = (const struct mt7996_fw_region *)((const u8 *)hdr -
+			 (hdr->n_region - i) * sizeof(*region));
+		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
+						   region->feature_set, is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
+		if (err) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			return err;
+		}
+
+		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
+					       data + offset, len, 4096);
+		if (err) {
+			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
+}
+
+static int mt7996_load_ram(struct mt7996_dev *dev)
+{
+	const struct mt7996_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, MT7996_FIRMWARE_WM, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof(*hdr));
+
+	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	release_firmware(fw);
+
+	ret = request_firmware(&fw, MT7996_FIRMWARE_WA, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof(*hdr));
+
+	dev_info(dev->mt76.dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, true);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Failed to start WA firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int
+mt7996_firmware_state(struct mt7996_dev *dev, bool wa)
+{
+	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE,
+			       wa ? FW_STATE_RDY : FW_STATE_FW_DOWNLOAD);
+
+	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
+			    state, 1000)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int mt7996_load_firmware(struct mt7996_dev *dev)
+{
+	int ret;
+
+	/* make sure fw is download state */
+	if (mt7996_firmware_state(dev, false)) {
+		/* restart firmware once */
+		__mt76_mcu_restart(&dev->mt76);
+		ret = mt7996_firmware_state(dev, false);
+		if (ret) {
+			dev_err(dev->mt76.dev,
+				"Firmware is not ready for download\n");
+			return ret;
+		}
+	}
+
+	ret = mt7996_load_patch(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7996_load_ram(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7996_firmware_state(dev, true);
+	if (ret)
+		return ret;
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
+int mt7996_mcu_fw_log_2_host(struct mt7996_dev *dev, u8 type, u8 ctrl)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 ctrl;
+		u8 interval;
+		u8 _rsv2[2];
+	} __packed data = {
+		.tag = cpu_to_le16(UNI_WSYS_CONFIG_FW_LOG_CTRL),
+		.len = cpu_to_le16(sizeof(data) - 4),
+		.ctrl = ctrl,
+	};
+
+	if (type == MCU_FW_LOG_WA)
+		return mt76_mcu_send_msg(&dev->mt76, MCU_WA_UNI_CMD(WSYS_CONFIG),
+					 &data, sizeof(data), true);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(WSYS_CONFIG), &data,
+				 sizeof(data), true);
+}
+
+int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		__le32 module_idx;
+		u8 level;
+		u8 _rsv2[3];
+	} data = {
+		.tag = cpu_to_le16(UNI_WSYS_CONFIG_FW_DBG_CTRL),
+		.len = cpu_to_le16(sizeof(data) - 4),
+		.module_idx = cpu_to_le32(module),
+		.level = level,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(WSYS_CONFIG), &data,
+				 sizeof(data), false);
+}
+
+static int mt7996_mcu_set_mwds(struct mt7996_dev *dev, bool enabled)
+{
+	struct {
+		u8 enable;
+		u8 _rsv[3];
+	} __packed req = {
+		.enable = enabled
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(MWDS_SUPPORT), &req,
+				 sizeof(req), false);
+}
+
+static void mt7996_add_rx_airtime_tlv(struct sk_buff *skb, u8 band_idx)
+{
+	struct vow_rx_airtime *req;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_VOW_RX_AT_AIRTIME_CLR_EN, sizeof(*req));
+	req = (struct vow_rx_airtime *)tlv;
+	req->enable = true;
+	req->band = band_idx;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_VOW_RX_AT_AIRTIME_EN, sizeof(*req));
+	req = (struct vow_rx_airtime *)tlv;
+	req->enable = true;
+	req->band = band_idx;
+}
+
+static int
+mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
+{
+	struct uni_header hdr = {};
+	struct sk_buff *skb;
+	int len, num;
+
+	num = 2 + 2 * (dev->dbdc_support + dev->tbtc_support);
+	len = sizeof(hdr) + num * sizeof(struct vow_rx_airtime);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	mt7996_add_rx_airtime_tlv(skb, dev->mt76.phy.band_idx);
+
+	if (dev->dbdc_support)
+		mt7996_add_rx_airtime_tlv(skb, MT_BAND1);
+
+	if (dev->tbtc_support)
+		mt7996_add_rx_airtime_tlv(skb, MT_BAND2);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WM_UNI_CMD(VOW), true);
+}
+
+int mt7996_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 power_mode;
+		u8 __rsv2[3];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_POWER_OFF),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_WM_UNI_CMD(POWER_CREL), &req,
+				 sizeof(req), false);
+}
+
+int mt7996_mcu_init(struct mt7996_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7996_mcu_ops = {
+		.headroom = sizeof(struct mt76_connac2_mcu_txd), /* reuse */
+		.mcu_skb_send_msg = mt7996_mcu_send_message,
+		.mcu_parse_response = mt7996_mcu_parse_response,
+		.mcu_restart = mt7996_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mt7996_mcu_ops;
+
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+
+	ret = mt7996_driver_own(dev, 0);
+	if (ret)
+		return ret;
+	/* set driver own for band1 when two hif exist */
+	if (dev->hif2) {
+		ret = mt7996_driver_own(dev, 1);
+		if (ret)
+			return ret;
+	}
+
+	ret = mt7996_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	ret = mt7996_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, 0);
+	if (ret)
+		return ret;
+
+	ret = mt7996_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, 0);
+	if (ret)
+		return ret;
+
+	ret = mt7996_mcu_set_mwds(dev, 1);
+	if (ret)
+		return ret;
+
+	ret = mt7996_mcu_init_rx_airtime(dev);
+	if (ret)
+		return ret;
+
+	return mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+				 MCU_WA_PARAM_RED, 0, 0);
+}
+
+void mt7996_mcu_exit(struct mt7996_dev *dev)
+{
+	__mt76_mcu_restart(&dev->mt76);
+	if (mt7996_firmware_state(dev, false)) {
+		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
+		return;
+	}
+
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(0), MT_TOP_LPCR_HOST_FW_OWN);
+	if (dev->hif2)
+		mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(1),
+			MT_TOP_LPCR_HOST_FW_OWN);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+}
+
+int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
+{
+	struct {
+		u8 __rsv[4];
+	} __packed hdr;
+	struct hdr_trans_blacklist *req_blacklist;
+	struct hdr_trans_en *req_en;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int len = MT7996_HDR_TRANS_MAX_SIZE + sizeof(hdr);
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_HDR_TRANS_EN, sizeof(*req_en));
+	req_en = (struct hdr_trans_en *)tlv;
+	req_en->enable = hdr_trans;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_HDR_TRANS_VLAN,
+				     sizeof(struct hdr_trans_vlan));
+
+	if (hdr_trans) {
+		tlv = mt7996_mcu_add_uni_tlv(skb, UNI_HDR_TRANS_BLACKLIST,
+					     sizeof(*req_blacklist));
+		req_blacklist = (struct hdr_trans_blacklist *)tlv;
+		req_blacklist->enable = 1;
+		req_blacklist->type = cpu_to_le16(ETH_P_PAE);
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WM_UNI_CMD(RX_HDR_TRANS), true);
+}
+
+int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
+{
+#define MCU_EDCA_AC_PARAM	0
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
+				 WMM_CW_MAX_SET | WMM_TXOP_SET)
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 __rsv[3];
+	} __packed hdr = {
+		.bss_idx = mvif->mt76.idx,
+	};
+	struct sk_buff *skb;
+	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
+	int ac;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct edca *e;
+		struct tlv *tlv;
+
+		tlv = mt7996_mcu_add_uni_tlv(skb, MCU_EDCA_AC_PARAM, sizeof(*e));
+
+		e = (struct edca *)tlv;
+		e->set = WMM_PARAM_SET;
+		e->queue = ac + mvif->mt76.wmm_idx * MT7996_MAX_WMM_SETS;
+		e->aifs = q->aifs;
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = fls(q->cw_min);
+		else
+			e->cw_min = 5;
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(fls(q->cw_max));
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WM_UNI_CMD(EDCA_UPDATE), true);
+}
+
+int mt7996_mcu_set_fcc5_lpn(struct mt7996_dev *dev, int val)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 ctrl;
+		__le16 min_lpn;
+		u8 rsv[2];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_RDD_CTRL_SET_TH),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.ctrl = cpu_to_le32(0x1),
+		.min_lpn = cpu_to_le16(val),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RDD_CTRL),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_set_pulse_th(struct mt7996_dev *dev,
+			    const struct mt7996_dfs_pulse *pulse)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 ctrl;
+
+		__le32 max_width;		/* us */
+		__le32 max_pwr;			/* dbm */
+		__le32 min_pwr;			/* dbm */
+		__le32 min_stgr_pri;		/* us */
+		__le32 max_stgr_pri;		/* us */
+		__le32 min_cr_pri;		/* us */
+		__le32 max_cr_pri;		/* us */
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_RDD_CTRL_SET_TH),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.ctrl = cpu_to_le32(0x3),
+
+#define __req_field(field) .field = cpu_to_le32(pulse->field)
+		__req_field(max_width),
+		__req_field(max_pwr),
+		__req_field(min_pwr),
+		__req_field(min_stgr_pri),
+		__req_field(max_stgr_pri),
+		__req_field(min_cr_pri),
+		__req_field(max_cr_pri),
+#undef __req_field
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RDD_CTRL),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
+			    const struct mt7996_dfs_pattern *pattern)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 ctrl;
+		__le16 radar_type;
+
+		u8 enb;
+		u8 stgr;
+		u8 min_crpn;
+		u8 max_crpn;
+		u8 min_crpr;
+		u8 min_pw;
+		__le32 min_pri;
+		__le32 max_pri;
+		u8 max_pw;
+		u8 min_crbn;
+		u8 max_crbn;
+		u8 min_stgpn;
+		u8 max_stgpn;
+		u8 min_stgpr;
+		u8 rsv[2];
+		__le32 min_stgpr_diff;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_RDD_CTRL_SET_TH),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.ctrl = cpu_to_le32(0x2),
+		.radar_type = cpu_to_le16(index),
+
+#define __req_field_u8(field) .field = pattern->field
+#define __req_field_u32(field) .field = cpu_to_le32(pattern->field)
+		__req_field_u8(enb),
+		__req_field_u8(stgr),
+		__req_field_u8(min_crpn),
+		__req_field_u8(max_crpn),
+		__req_field_u8(min_crpr),
+		__req_field_u8(min_pw),
+		__req_field_u32(min_pri),
+		__req_field_u32(max_pri),
+		__req_field_u8(max_pw),
+		__req_field_u8(min_crbn),
+		__req_field_u8(max_crbn),
+		__req_field_u8(min_stgpn),
+		__req_field_u8(max_stgpn),
+		__req_field_u8(min_stgpr),
+		__req_field_u32(min_stgpr_diff),
+#undef __req_field_u8
+#undef __req_field_u32
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RDD_CTRL),
+				 &req, sizeof(req), true);
+}
+
+static int
+mt7996_mcu_background_chain_ctrl(struct mt7996_phy *phy,
+				 struct cfg80211_chan_def *chandef,
+				 int cmd)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_channel *chan = mphy->chandef.chan;
+	int freq = mphy->chandef.center_freq1;
+	struct mt7996_mcu_background_chain_ctrl req = {
+		.tag = cpu_to_le16(0),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.monitor_scan_type = 2, /* simple rx */
+	};
+
+	if (!chandef && cmd != CH_SWITCH_BACKGROUND_SCAN_STOP)
+		return -EINVAL;
+
+	if (!cfg80211_chandef_valid(&mphy->chandef))
+		return -EINVAL;
+
+	switch (cmd) {
+	case CH_SWITCH_BACKGROUND_SCAN_START: {
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt76_connac_chan_bw(&mphy->chandef);
+		req.monitor_chan = chandef->chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(chandef->center_freq1);
+		req.monitor_bw = mt76_connac_chan_bw(chandef);
+		req.band_idx = phy->mt76->band_idx;
+		req.scan_mode = 1;
+		break;
+	}
+	case CH_SWITCH_BACKGROUND_SCAN_RUNNING:
+		req.monitor_chan = chandef->chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(chandef->center_freq1);
+		req.band_idx = phy->mt76->band_idx;
+		req.scan_mode = 2;
+		break;
+	case CH_SWITCH_BACKGROUND_SCAN_STOP:
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt76_connac_chan_bw(&mphy->chandef);
+		req.tx_stream = hweight8(mphy->antenna_mask);
+		req.rx_stream = mphy->antenna_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+	req.band = chandef ? chandef->chan->band == NL80211_BAND_5GHZ : 1;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(OFFCH_SCAN_CTRL),
+				 &req, sizeof(req), false);
+}
+
+int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
+				     struct cfg80211_chan_def *chandef)
+{
+	struct mt7996_dev *dev = phy->dev;
+	int err, region;
+
+	if (!chandef) { /* disable offchain */
+		err = mt7996_mcu_rdd_cmd(dev, RDD_STOP, MT_RX_SEL2,
+					 0, 0);
+		if (err)
+			return err;
+
+		return mt7996_mcu_background_chain_ctrl(phy, NULL,
+				CH_SWITCH_BACKGROUND_SCAN_STOP);
+	}
+
+	err = mt7996_mcu_background_chain_ctrl(phy, chandef,
+					       CH_SWITCH_BACKGROUND_SCAN_START);
+	if (err)
+		return err;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_ETSI:
+		region = 0;
+		break;
+	case NL80211_DFS_JP:
+		region = 2;
+		break;
+	case NL80211_DFS_FCC:
+	default:
+		region = 1;
+		break;
+	}
+
+	return mt7996_mcu_rdd_cmd(dev, RDD_START, MT_RX_SEL2,
+				  0, region);
+}
+
+int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
+{
+	static const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 0,
+		[NL80211_BAND_5GHZ] = 1,
+		[NL80211_BAND_6GHZ] = 2,
+	};
+	struct mt7996_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	u8 band_idx = phy->mt76->band_idx;
+	struct {
+		/* fixed field */
+		u8 __rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_path_num;
+		u8 rx_path;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[53];
+	} __packed req = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt76_connac_chan_bw(chandef),
+		.tx_path_num = hweight16(phy->mt76->chainmask),
+		.rx_path = phy->mt76->chainmask >> dev->chainshift[band_idx],
+		.band_idx = band_idx,
+		.channel_band = ch_band[chandef->chan->band],
+	};
+
+	if (tag == UNI_CHANNEL_RX_PATH ||
+	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (tag == UNI_CHANNEL_SWITCH)
+		req.rx_path = hweight8(req.rx_path);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WMWA_UNI_CMD(CHANNEL_SWITCH),
+				 &req, sizeof(req), true);
+}
+
+static int mt7996_mcu_set_eeprom_flash(struct mt7996_dev *dev)
+{
+#define MAX_PAGE_IDX_MASK	GENMASK(7, 5)
+#define PAGE_IDX_MASK		GENMASK(4, 2)
+#define PER_PAGE_SIZE		0x400
+	struct mt7996_mcu_eeprom req = {
+		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
+		.buffer_mode = EE_MODE_BUFFER
+	};
+	u16 eeprom_size = MT7996_EEPROM_SIZE;
+	u8 total = DIV_ROUND_UP(eeprom_size, PER_PAGE_SIZE);
+	u8 *eep = (u8 *)dev->mt76.eeprom.data;
+	int eep_len, i;
+
+	for (i = 0; i < total; i++, eep += eep_len) {
+		struct sk_buff *skb;
+		int ret, msg_len;
+
+		if (i == total - 1 && !!(eeprom_size % PER_PAGE_SIZE))
+			eep_len = eeprom_size % PER_PAGE_SIZE;
+		else
+			eep_len = PER_PAGE_SIZE;
+
+		msg_len = sizeof(req) + eep_len;
+		skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, msg_len);
+		if (!skb)
+			return -ENOMEM;
+
+		req.len = cpu_to_le16(msg_len - 4);
+		req.format = FIELD_PREP(MAX_PAGE_IDX_MASK, total - 1) |
+			     FIELD_PREP(PAGE_IDX_MASK, i) | EE_FORMAT_WHOLE;
+		req.buf_len = cpu_to_le16(eep_len);
+
+		skb_put_data(skb, &req, sizeof(req));
+		skb_put_data(skb, eep, eep_len);
+
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_WM_UNI_CMD(EFUSE_CTRL), true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
+{
+	struct mt7996_mcu_eeprom req = {
+		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE
+	};
+
+	if (dev->flash_mode)
+		return mt7996_mcu_set_eeprom_flash(dev);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(EFUSE_CTRL),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		__le32 addr;
+		__le32 valid;
+		u8 data[16];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_EFUSE_ACCESS),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7996_EEPROM_BLOCK_SIZE)),
+	};
+	struct sk_buff *skb;
+	bool valid;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD_QUERY(EFUSE_CTRL), &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	valid = le32_to_cpu(*(__le32 *)(skb->data + 16));
+	if (valid) {
+		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
+		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
+
+		skb_pull(skb, 64);
+		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
+	}
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 num;
+		u8 version;
+		u8 die_idx;
+		u8 _rsv2;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_EFUSE_FREE_BLOCK),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.version = 2,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD_QUERY(EFUSE_CTRL), &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	*block_num = *(u8 *)(skb->data + 8);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
+{
+	struct {
+		struct {
+			u8 band;
+			u8 __rsv[3];
+		} hdr;
+		struct {
+			__le16 tag;
+			__le16 len;
+			__le32 offs;
+		} data[4];
+	} __packed req = {
+		.hdr.band = phy->mt76->band_idx,
+	};
+	/* strict order */
+	static const u32 offs[] = {
+		UNI_MIB_TX_TIME,
+		UNI_MIB_RX_TIME,
+		UNI_MIB_OBSS_AIRTIME,
+		UNI_MIB_NON_WIFI_TIME,
+	};
+	struct mt76_channel_state *state = phy->mt76->chan_state;
+	struct mt76_channel_state *state_ts = &phy->state_ts;
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_mcu_mib *res;
+	struct sk_buff *skb;
+	int i, ret;
+
+	for (i = 0; i < 4; i++) {
+		req.data[i].tag = cpu_to_le16(UNI_CMD_MIB_DATA);
+		req.data[i].len = cpu_to_le16(sizeof(req.data[i]));
+		req.data[i].offs = cpu_to_le32(offs[i]);
+	}
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD_QUERY(GET_MIB_INFO),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	skb_pull(skb, sizeof(req.hdr));
+
+	res = (struct mt7996_mcu_mib *)(skb->data);
+
+	if (chan_switch)
+		goto out;
+
+#define __res_u64(s) le64_to_cpu(res[s].data)
+	state->cc_tx += __res_u64(1) - state_ts->cc_tx;
+	state->cc_bss_rx += __res_u64(2) - state_ts->cc_bss_rx;
+	state->cc_rx += __res_u64(2) + __res_u64(3) - state_ts->cc_rx;
+	state->cc_busy += __res_u64(0) + __res_u64(1) + __res_u64(2) + __res_u64(3) -
+			  state_ts->cc_busy;
+
+out:
+	state_ts->cc_tx = __res_u64(1);
+	state_ts->cc_bss_rx = __res_u64(2);
+	state_ts->cc_rx = __res_u64(2) + __res_u64(3);
+	state_ts->cc_busy = __res_u64(0) + __res_u64(1) + __res_u64(2) + __res_u64(3);
+#undef __res_u64
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 val, u8 band)
+{
+	struct {
+		u8 rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		union {
+			struct {
+				__le32 mask;
+			} __packed set;
+
+			struct {
+				u8 method;
+				u8 band;
+				u8 rsv2[2];
+			} __packed trigger;
+		};
+	} __packed req = {
+		.tag = cpu_to_le16(action),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+
+	switch (action) {
+	case UNI_CMD_SER_SET:
+		req.set.mask = cpu_to_le32(val);
+		break;
+	case UNI_CMD_SER_TRIGGER:
+		req.trigger.method = val;
+		req.trigger.band = band;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SER),
+				 &req, sizeof(req), false);
+}
+
+int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action)
+{
+#define MT7996_BF_MAX_SIZE	sizeof(union bf_tag_tlv)
+#define BF_PROCESSING	4
+	struct uni_header hdr;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int len = sizeof(hdr) + MT7996_BF_MAX_SIZE;
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	switch (action) {
+	case BF_SOUNDING_ON: {
+		struct bf_sounding_on *req_snd_on;
+
+		tlv = mt7996_mcu_add_uni_tlv(skb, action, sizeof(*req_snd_on));
+		req_snd_on = (struct bf_sounding_on *)tlv;
+		req_snd_on->snd_mode = BF_PROCESSING;
+		break;
+	}
+	case BF_HW_EN_UPDATE: {
+		struct bf_hw_en_status_update *req_hw_en;
+
+		tlv = mt7996_mcu_add_uni_tlv(skb, action, sizeof(*req_hw_en));
+		req_hw_en = (struct bf_hw_en_status_update *)tlv;
+		req_hw_en->ebf = true;
+		req_hw_en->ibf = dev->ibf;
+		break;
+	}
+	case BF_MOD_EN_CTRL: {
+		struct bf_mod_en_ctrl *req_mod_en;
+
+		tlv = mt7996_mcu_add_uni_tlv(skb, action, sizeof(*req_mod_en));
+		req_mod_en = (struct bf_mod_en_ctrl *)tlv;
+		req_mod_en->bf_num = 2;
+		req_mod_en->bf_bitmap = GENMASK(0, 0);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_WM_UNI_CMD(BF), true);
+}
+
+int mt7996_mcu_add_obss_spr(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			    bool enable)
+{
+#define MT_SPR_ENABLE		1
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct {
+		u8 dbdc_idx;
+		u8 __rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		__le32 val;
+	} __packed req = {
+		.dbdc_idx = mvif->mt76.band_idx,
+		.tag = cpu_to_le16(UNI_CMD_SR_ENABLE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.val = cpu_to_le32(enable),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SR),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color)
+{
+	int len = sizeof(struct bss_req_hdr) + sizeof(struct bss_color_tlv);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct bss_color_tlv *bss_color;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BSS_COLOR,
+				      sizeof(*bss_color));
+	bss_color = (struct bss_color_tlv *)tlv;
+	bss_color->enable = he_bss_color->enabled;
+	bss_color->color = he_bss_color->color;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+#define TWT_AGRT_TRIGGER	BIT(0)
+#define TWT_AGRT_ANNOUNCE	BIT(1)
+#define TWT_AGRT_PROTECT	BIT(2)
+
+int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
+			       struct mt7996_vif *mvif,
+			       struct mt7996_twt_flow *flow,
+			       int cmd)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 tbl_idx;
+		u8 cmd;
+		u8 own_mac_idx;
+		u8 flowid; /* 0xff for group id */
+		__le16 peer_id; /* specify the peer_id (msb=0)
+				 * or group_id (msb=1)
+				 */
+		u8 duration; /* 256 us */
+		u8 bss_idx;
+		__le64 start_tsf;
+		__le16 mantissa;
+		u8 exponent;
+		u8 is_ap;
+		u8 agrt_params;
+		u8 __rsv2[135];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_CMD_TWT_ARGT_UPDATE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.tbl_idx = flow->table_id,
+		.cmd = cmd,
+		.own_mac_idx = mvif->mt76.omac_idx,
+		.flowid = flow->id,
+		.peer_id = cpu_to_le16(flow->wcid),
+		.duration = flow->duration,
+		.bss_idx = mvif->mt76.idx,
+		.start_tsf = cpu_to_le64(flow->tsf),
+		.mantissa = flow->mantissa,
+		.exponent = flow->exp,
+		.is_ap = true,
+	};
+
+	if (flow->protection)
+		req.agrt_params |= TWT_AGRT_PROTECT;
+	if (!flow->flowtype)
+		req.agrt_params |= TWT_AGRT_ANNOUNCE;
+	if (flow->trigger)
+		req.agrt_params |= TWT_AGRT_TRIGGER;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(TWT),
+				 &req, sizeof(req), true);
+}
+
+void mt7996_mcu_set_pm(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+#define EXIT_PM_STATE	0
+#define ENTER_PM_STATE	1
+	struct ieee80211_hw *hw = priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct bss_power_save *ps;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	bool running = test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					 MT7996_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_PS, sizeof(*ps));
+	ps = (struct bss_power_save *)tlv;
+	ps->profile = running ? EXIT_PM_STATE : ENTER_PM_STATE;
+
+	mt76_mcu_skb_send_msg(&dev->mt76, skb,
+			      MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val)
+{
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_RTS_THRESHOLD),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(BAND_CONFIG),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable)
+{
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		u8 enable;
+		u8 _rsv2[3];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_RADIO_ENABLE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.enable = enable,
+	};
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(BAND_CONFIG),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
+		       u8 rx_sel, u8 val)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+
+		u8 ctrl;
+		u8 rdd_idx;
+		u8 rdd_rx_sel;
+		u8 val;
+		u8 rsv[4];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_RDD_CTRL_PARM),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.ctrl = cmd,
+		.rdd_idx = index,
+		.rdd_rx_sel = rx_sel,
+		.val = val,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RDD_CTRL),
+				 &req, sizeof(req), true);
+}
+
+int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta;
+	struct sk_buff *skb;
+
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      &msta->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* starec hdr trans */
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set)
+{
+	struct {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+		__le16 idx;
+		u8 __rsv2[2];
+		__le32 ofs;
+		__le32 data;
+	} __packed *res, req = {
+		.tag = cpu_to_le16(UNI_CMD_ACCESS_RF_REG_BASIC),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.idx = cpu_to_le16(u32_get_bits(regidx, GENMASK(31, 24))),
+		.ofs = cpu_to_le32(u32_get_bits(regidx, GENMASK(23, 0))),
+		.data = set ? cpu_to_le32(*val) : 0,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	if (set)
+		return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(REG_ACCESS),
+					 &req, sizeof(req), true);
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_WM_UNI_CMD_QUERY(REG_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (void *)skb->data;
+	*val = le32_to_cpu(res->data);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val)
+{
+	struct {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+
+		union {
+			struct {
+				u8 type;
+				u8 __rsv2[3];
+			} __packed platform_type;
+			struct {
+				u8 type;
+				u8 dest;
+				u8 __rsv2[2];
+			} __packed bypass_mode;
+			struct {
+				u8 path;
+				u8 __rsv2[3];
+			} __packed txfree_path;
+		};
+	} __packed req = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+
+	switch (tag) {
+	case UNI_RRO_SET_PLATFORM_TYPE:
+		req.platform_type.type = val;
+		break;
+	case UNI_RRO_SET_BYPASS_MODE:
+		req.bypass_mode.type = val;
+		break;
+	case UNI_RRO_SET_TXFREE_PATH:
+		req.txfree_path.path = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RRO), &req,
+				 sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
new file mode 100644
index 000000000000..ff12a7168bd8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -0,0 +1,662 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_MCU_H
+#define __MT7996_MCU_H
+
+#include "../mt76_connac_mcu.h"
+
+struct mt7996_mcu_rxd {
+	__le32 rxd[8];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	u8 option;
+	u8 __rsv;
+
+	u8 ext_eid;
+	u8 __rsv1[2];
+	u8 s2d_index;
+};
+
+struct mt7996_mcu_uni_event {
+	u8 cid;
+	u8 __rsv[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+struct mt7996_mcu_csa_notify {
+	struct mt7996_mcu_rxd rxd;
+
+	u8 omac_idx;
+	u8 csa_count;
+	u8 band_idx;
+	u8 rsv;
+} __packed;
+
+struct mt7996_mcu_rdd_report {
+	struct mt7996_mcu_rxd rxd;
+
+	u8 __rsv1[4];
+
+	__le16 tag;
+	__le16 len;
+
+	u8 band_idx;
+	u8 long_detected;
+	u8 constant_prf_detected;
+	u8 staggered_prf_detected;
+	u8 radar_type_idx;
+	u8 periodic_pulse_num;
+	u8 long_pulse_num;
+	u8 hw_pulse_num;
+
+	u8 out_lpn;
+	u8 out_spn;
+	u8 out_crpn;
+	u8 out_crpw;
+	u8 out_crbn;
+	u8 out_stgpn;
+	u8 out_stgpw;
+
+	u8 __rsv2;
+
+	__le32 out_pri_const;
+	__le32 out_pri_stg[3];
+	__le32 out_pri_stg_dmin;
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+		u8 mdrdy_flag;
+		u8 rsv[3];
+	} long_pulse[32];
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+		u8 mdrdy_flag;
+		u8 rsv[3];
+	} periodic_pulse[32];
+
+	struct {
+		__le32 start;
+		__le16 pulse_width;
+		__le16 pulse_power;
+		u8 sc_pass;
+		u8 sw_reset;
+		u8 mdrdy_flag;
+		u8 tx_active;
+	} hw_pulse[32];
+} __packed;
+
+struct mt7996_mcu_background_chain_ctrl {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+
+	u8 chan;		/* primary channel */
+	u8 central_chan;	/* central channel */
+	u8 bw;
+	u8 tx_stream;
+	u8 rx_stream;
+
+	u8 monitor_chan;	/* monitor channel */
+	u8 monitor_central_chan;/* monitor central channel */
+	u8 monitor_bw;
+	u8 monitor_tx_stream;
+	u8 monitor_rx_stream;
+
+	u8 scan_mode;		/* 0: ScanStop
+				 * 1: ScanStart
+				 * 2: ScanRunning
+				 */
+	u8 band_idx;		/* DBDC */
+	u8 monitor_scan_type;
+	u8 band;		/* 0: 2.4GHz, 1: 5GHz */
+	u8 rsv[2];
+} __packed;
+
+struct mt7996_mcu_eeprom {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+	u8 buffer_mode;
+	u8 format;
+	__le16 buf_len;
+} __packed;
+
+struct mt7996_mcu_phy_rx_info {
+	u8 category;
+	u8 rate;
+	u8 mode;
+	u8 nsts;
+	u8 gi;
+	u8 coding;
+	u8 stbc;
+	u8 bw;
+};
+
+struct mt7996_mcu_mib {
+	__le16 tag;
+	__le16 len;
+	__le32 offs;
+	__le64 data;
+} __packed;
+
+enum mt7996_chan_mib_offs {
+	UNI_MIB_OBSS_AIRTIME = 26,
+	UNI_MIB_NON_WIFI_TIME = 27,
+	UNI_MIB_TX_TIME = 28,
+	UNI_MIB_RX_TIME = 29
+};
+
+struct edca {
+	__le16 tag;
+	__le16 len;
+
+	u8 queue;
+	u8 set;
+	u8 cw_min;
+	u8 cw_max;
+	__le16 txop;
+	u8 aifs;
+	u8 __rsv;
+};
+
+#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
+#define MCU_PKT_ID			0xa0
+
+enum {
+	MCU_FW_LOG_WM,
+	MCU_FW_LOG_WA,
+	MCU_FW_LOG_TO_HOST,
+	MCU_FW_LOG_RELAY = 16
+};
+
+enum {
+	MCU_TWT_AGRT_ADD,
+	MCU_TWT_AGRT_MODIFY,
+	MCU_TWT_AGRT_DELETE,
+	MCU_TWT_AGRT_TEARDOWN,
+	MCU_TWT_AGRT_GET_TSF,
+};
+
+enum {
+	MCU_WA_PARAM_CMD_QUERY,
+	MCU_WA_PARAM_CMD_SET,
+	MCU_WA_PARAM_CMD_CAPABILITY,
+	MCU_WA_PARAM_CMD_DEBUG,
+};
+
+enum {
+	MCU_WA_PARAM_PDMA_RX = 0x04,
+	MCU_WA_PARAM_CPU_UTIL = 0x0b,
+	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_HW_PATH_HIF_VER = 0x2f,
+};
+
+enum mcu_mmps_mode {
+	MCU_MMPS_STATIC,
+	MCU_MMPS_DYNAMIC,
+	MCU_MMPS_RSV,
+	MCU_MMPS_DISABLE,
+};
+
+struct bss_rate_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 __rsv1[4];
+	__le16 bc_trans;
+	__le16 mc_trans;
+	u8 short_preamble;
+	u8 bc_fixed_rate;
+	u8 mc_fixed_rate;
+	u8 __rsv2[1];
+} __packed;
+
+struct bss_ra_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 short_preamble;
+	u8 force_sgi;
+	u8 force_gf;
+	u8 ht_mode;
+	u8 se_off;
+	u8 antenna_idx;
+	__le16 max_phyrate;
+	u8 force_tx_streams;
+	u8 __rsv[3];
+} __packed;
+
+struct bss_rlm_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 control_channel;
+	u8 center_chan;
+	u8 center_chan2;
+	u8 bw;
+	u8 tx_streams;
+	u8 rx_streams;
+	u8 ht_op_info;
+	u8 sco;
+	u8 band;
+	u8 __rsv[3];
+} __packed;
+
+struct bss_color_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 enable;
+	u8 color;
+	u8 rsv[2];
+} __packed;
+
+struct bss_inband_discovery_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 tx_type;
+	u8 tx_mode;
+	u8 tx_interval;
+	u8 enable;
+	__le16 wcid;
+	__le16 prob_rsp_len;
+#define MAX_INBAND_FRAME_SIZE 512
+	u8 pkt[MAX_INBAND_FRAME_SIZE];
+} __packed;
+
+struct bss_bcn_content_tlv {
+	__le16 tag;
+	__le16 len;
+	__le16 tim_ie_pos;
+	__le16 csa_ie_pos;
+	__le16 bcc_ie_pos;
+	u8 enable;
+	u8 type;
+	__le16 pkt_len;
+#define MAX_BEACON_SIZE 512
+	u8 pkt[MAX_BEACON_SIZE];
+} __packed;
+
+struct bss_bcn_cntdwn_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 cnt;
+	u8 rsv[3];
+} __packed;
+
+struct bss_bcn_mbss_tlv {
+	__le16 tag;
+	__le16 len;
+	__le32 bitmap;
+#define MAX_BEACON_NUM	32
+	__le16 offset[MAX_BEACON_NUM];
+} __packed __aligned(4);
+
+struct bss_txcmd_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 txcmd_mode;
+	u8 __rsv[3];
+} __packed;
+
+struct bss_sec_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 __rsv1[2];
+	u8 cipher;
+	u8 __rsv2[1];
+} __packed;
+
+struct bss_power_save {
+	__le16 tag;
+	__le16 len;
+	u8 profile;
+	u8 _rsv[3];
+} __packed;
+
+struct bss_mld_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 group_mld_id;
+	u8 own_mld_id;
+	u8 mac_addr[ETH_ALEN];
+	u8 remap_idx;
+	u8 __rsv[3];
+} __packed;
+
+struct sta_rec_ba_uni {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+	u8 ba_rdd_rro;
+	u8 __rsv[3];
+} __packed;
+
+struct sec_key_uni {
+	__le16 wlan_idx;
+	u8 mgmt_prot;
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 need_resp;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec_uni {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key_uni key[2];
+} __packed;
+
+struct sta_rec_hdrt {
+	__le16 tag;
+	__le16 len;
+	u8 hdrt_mode;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 from_ds;
+	u8 to_ds;
+	u8 dis_rx_hdr_tran;
+	u8 rsv;
+} __packed;
+
+struct hdr_trans_en {
+	__le16 tag;
+	__le16 len;
+	u8 enable;
+	u8 check_bssid;
+	u8 mode;
+	u8 __rsv;
+} __packed;
+
+struct hdr_trans_vlan {
+	__le16 tag;
+	__le16 len;
+	u8 insert_vlan;
+	u8 remove_vlan;
+	u8 tid;
+	u8 __rsv;
+} __packed;
+
+struct hdr_trans_blacklist {
+	__le16 tag;
+	__le16 len;
+	u8 idx;
+	u8 enable;
+	__le16 type;
+} __packed;
+
+struct uni_header {
+	u8 __rsv[4];
+} __packed;
+
+struct vow_rx_airtime {
+	__le16 tag;
+	__le16 len;
+
+	u8 enable;
+	u8 band;
+	u8 __rsv[2];
+} __packed;
+
+struct bf_sounding_on {
+	__le16 tag;
+	__le16 len;
+
+	u8 snd_mode;
+	u8 sta_num;
+	u8 __rsv[2];
+	__le16 wlan_id[4];
+	__le32 snd_period;
+} __packed;
+
+struct bf_hw_en_status_update {
+	__le16 tag;
+	__le16 len;
+
+	bool ebf;
+	bool ibf;
+	u8 __rsv[2];
+} __packed;
+
+struct bf_mod_en_ctrl {
+	__le16 tag;
+	__le16 len;
+
+	u8 bf_num;
+	u8 bf_bitmap;
+	u8 bf_sel[8];
+	u8 __rsv[2];
+} __packed;
+
+union bf_tag_tlv {
+	struct bf_sounding_on bf_snd;
+	struct bf_hw_en_status_update bf_hw_en;
+	struct bf_mod_en_ctrl bf_mod_en;
+};
+
+struct ra_rate {
+	__le16 wlan_idx;
+	u8 mode;
+	u8 stbc;
+	__le16 gi;
+	u8 bw;
+	u8 ldpc;
+	u8 mcs;
+	u8 nss;
+	__le16 ltf;
+	u8 spe;
+	u8 preamble;
+	u8 __rsv[2];
+} __packed;
+
+struct ra_fixed_rate {
+	__le16 tag;
+	__le16 len;
+
+	__le16 version;
+	struct ra_rate rate;
+} __packed;
+
+enum {
+	UNI_RA_FIXED_RATE = 0xf,
+};
+
+#define MT7996_HDR_TRANS_MAX_SIZE	(sizeof(struct hdr_trans_en) +	 \
+					 sizeof(struct hdr_trans_vlan) + \
+					 sizeof(struct hdr_trans_blacklist))
+
+enum {
+	UNI_HDR_TRANS_EN,
+	UNI_HDR_TRANS_VLAN,
+	UNI_HDR_TRANS_BLACKLIST,
+};
+
+enum {
+	RATE_PARAM_FIXED = 3,
+	RATE_PARAM_MMPS_UPDATE = 5,
+	RATE_PARAM_FIXED_HE_LTF = 7,
+	RATE_PARAM_FIXED_MCS,
+	RATE_PARAM_FIXED_GI = 11,
+	RATE_PARAM_AUTO = 20,
+};
+
+enum {
+	BF_SOUNDING_ON = 1,
+	BF_HW_EN_UPDATE = 17,
+	BF_MOD_EN_CTRL = 20,
+};
+
+enum {
+	CMD_BAND_NONE,
+	CMD_BAND_24G,
+	CMD_BAND_5G,
+	CMD_BAND_6G,
+};
+
+struct bss_req_hdr {
+	u8 bss_idx;
+	u8 __rsv[3];
+} __packed;
+
+enum {
+	UNI_CHANNEL_SWITCH,
+	UNI_CHANNEL_RX_PATH,
+};
+
+#define MT7996_BSS_UPDATE_MAX_SIZE	(sizeof(struct bss_req_hdr) +		\
+					 sizeof(struct mt76_connac_bss_basic_tlv) +	\
+					 sizeof(struct bss_rlm_tlv) +		\
+					 sizeof(struct bss_ra_tlv) +		\
+					 sizeof(struct bss_info_uni_he) +	\
+					 sizeof(struct bss_rate_tlv) +		\
+					 sizeof(struct bss_txcmd_tlv) +		\
+					 sizeof(struct bss_power_save) +	\
+					 sizeof(struct bss_sec_tlv) +		\
+					 sizeof(struct bss_mld_tlv))
+
+#define MT7996_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
+					 sizeof(struct sta_rec_basic) +		\
+					 sizeof(struct sta_rec_bf) +		\
+					 sizeof(struct sta_rec_ht) +		\
+					 sizeof(struct sta_rec_he_v2) +		\
+					 sizeof(struct sta_rec_ba_uni) +	\
+					 sizeof(struct sta_rec_vht) +		\
+					 sizeof(struct sta_rec_uapsd) + 	\
+					 sizeof(struct sta_rec_amsdu) +		\
+					 sizeof(struct sta_rec_bfee) +		\
+					 sizeof(struct sta_rec_phy) +		\
+					 sizeof(struct sta_rec_ra) +		\
+					 sizeof(struct sta_rec_sec) +		\
+					 sizeof(struct sta_rec_ra_fixed) +	\
+					 sizeof(struct sta_rec_he_6g_capa) +	\
+					 sizeof(struct sta_rec_hdrt) +		\
+					 sizeof(struct sta_rec_hdr_trans) +	\
+					 sizeof(struct tlv))
+
+#define MT7996_BEACON_UPDATE_SIZE	(sizeof(struct bss_req_hdr) +		\
+					 sizeof(struct bss_bcn_content_tlv) +	\
+					 sizeof(struct bss_bcn_cntdwn_tlv) +	\
+					 sizeof(struct bss_bcn_mbss_tlv))
+
+#define MT7996_INBAND_FRAME_SIZE	(sizeof(struct bss_req_hdr) +		\
+					 sizeof(struct bss_inband_discovery_tlv))
+
+enum {
+	UNI_BAND_CONFIG_RADIO_ENABLE,
+	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
+};
+
+enum {
+	UNI_WSYS_CONFIG_FW_LOG_CTRL,
+	UNI_WSYS_CONFIG_FW_DBG_CTRL,
+};
+
+enum {
+	UNI_RDD_CTRL_PARM,
+	UNI_RDD_CTRL_SET_TH = 0x3,
+};
+
+enum {
+	UNI_EFUSE_ACCESS = 1,
+	UNI_EFUSE_BUFFER_MODE,
+	UNI_EFUSE_FREE_BLOCK,
+	UNI_EFUSE_BUFFER_RD,
+};
+
+enum {
+	UNI_VOW_DRR_CTRL,
+	UNI_VOW_RX_AT_AIRTIME_EN = 0x0b,
+	UNI_VOW_RX_AT_AIRTIME_CLR_EN = 0x0e,
+};
+
+enum {
+	UNI_CMD_MIB_DATA,
+};
+
+enum {
+	UNI_POWER_OFF,
+};
+
+enum {
+	UNI_CMD_TWT_ARGT_UPDATE = 0x0,
+	UNI_CMD_TWT_MGMT_OFFLOAD,
+};
+
+enum {
+	UNI_RRO_DEL_ENTRY = 0x1,
+	UNI_RRO_SET_PLATFORM_TYPE,
+	UNI_RRO_GET_BA_SESSION_TABLE,
+	UNI_RRO_SET_BYPASS_MODE,
+	UNI_RRO_SET_TXFREE_PATH,
+};
+
+enum{
+	UNI_CMD_SR_ENABLE = 0x1,
+};
+
+enum {
+	UNI_CMD_ACCESS_REG_BASIC = 0x0,
+	UNI_CMD_ACCESS_RF_REG_BASIC,
+};
+
+enum {
+	UNI_CMD_SER_QUERY = 0x0,
+	UNI_CMD_SER_SET = 0x2,
+	UNI_CMD_SER_TRIGGER = 0x3,
+};
+
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
+enum {
+	MT7996_SEC_MODE_PLAIN,
+	MT7996_SEC_MODE_AES,
+	MT7996_SEC_MODE_SCRAMBLE,
+	MT7996_SEC_MODE_MAX,
+};
+
+#define MT7996_PATCH_SEC		GENMASK(31, 24)
+#define MT7996_PATCH_SCRAMBLE_KEY	GENMASK(15, 8)
+#define MT7996_PATCH_AES_KEY		GENMASK(7, 0)
+
+#define MT7996_SEC_ENCRYPT		BIT(0)
+#define MT7996_SEC_KEY_IDX		GENMASK(2, 1)
+#define MT7996_SEC_IV			BIT(3)
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
new file mode 100644
index 000000000000..0d097cda4da7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7996.h"
+#include "mac.h"
+#include "../trace.h"
+
+static const struct __base mt7996_reg_base[] = {
+	[WF_AGG_BASE]	= { { 0x820e2000, 0x820f2000, 0x830e2000 } },
+	[WF_MIB_BASE]	= { { 0x820ed000, 0x820fd000, 0x830ed000 } },
+	[WF_TMAC_BASE]	= { { 0x820e4000, 0x820f4000, 0x830e4000 } },
+	[WF_RMAC_BASE]	= { { 0x820e5000, 0x820f5000, 0x830e5000 } },
+	[WF_ARB_BASE]	= { { 0x820e3000, 0x820f3000, 0x830e3000 } },
+	[WF_LPON_BASE]	= { { 0x820eb000, 0x820fb000, 0x830eb000 } },
+	[WF_ETBF_BASE]	= { { 0x820ea000, 0x820fa000, 0x830ea000 } },
+	[WF_DMA_BASE]	= { { 0x820e7000, 0x820f7000, 0x830e7000 } },
+};
+
+static const struct __map mt7996_reg_map[] = {
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA reserved */
+	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA MCU wrap CR */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x74030000, 0x10000, 0x1000 }, /* PCIe MAC */
+	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820ca000, 0x26000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
+	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820cc000, 0xa5000, 0x2000 }, /* WF_LMAC_TOP BN1 (WF_MUCOP) */
+	{ 0x820c4000, 0xa8000, 0x4000 }, /* WF_LMAC_TOP BN1 (WF_MUCOP) */
+	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, wfdma */
+	{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
+	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
+static u32 mt7996_reg_map_l1(struct mt7996_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	dev->reg_l1_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1,
+			  MT_HIF_REMAP_L1_MASK,
+			  FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
+	/* use read to push write */
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static u32 mt7996_reg_map_l2(struct mt7996_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+
+	dev->reg_l2_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
+			  MT_HIF_REMAP_L2_MASK,
+			  FIELD_PREP(MT_HIF_REMAP_L2_MASK, base));
+	/* use read to push write */
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
+
+	return MT_HIF_REMAP_BASE_L2 + offset;
+}
+
+static void mt7996_reg_remap_restore(struct mt7996_dev *dev)
+{
+	/* remap to ori status */
+	if (unlikely(dev->reg_l1_backup)) {
+		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L1, dev->reg_l1_backup);
+		dev->reg_l1_backup = 0;
+	}
+
+	if (dev->reg_l2_backup) {
+		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L2, dev->reg_l2_backup);
+		dev->reg_l2_backup = 0;
+	}
+}
+
+static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
+{
+	int i;
+
+	mt7996_reg_remap_restore(dev);
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < dev->reg.map_size; i++) {
+		u32 ofs;
+
+		if (addr < dev->reg.map[i].phys)
+			continue;
+
+		ofs = addr - dev->reg.map[i].phys;
+		if (ofs > dev->reg.map[i].size)
+			continue;
+
+		return dev->reg.map[i].mapped + ofs;
+	}
+
+	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
+	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
+	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
+		return mt7996_reg_map_l1(dev, addr);
+
+	if (dev_is_pci(dev->mt76.dev) &&
+	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
+	     (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END)))
+		return mt7996_reg_map_l1(dev, addr);
+
+	/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
+	if (addr >= MT_INFRA_MCU_START && addr <= MT_INFRA_MCU_END) {
+		addr = addr - MT_INFRA_MCU_START + MT_INFRA_BASE;
+		return mt7996_reg_map_l1(dev, addr);
+	}
+
+	return mt7996_reg_map_l2(dev, addr);
+}
+
+static u32 mt7996_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	return dev->bus_ops->rr(mdev, __mt7996_reg_addr(dev, offset));
+}
+
+static void mt7996_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	dev->bus_ops->wr(mdev, __mt7996_reg_addr(dev, offset), val);
+}
+
+static u32 mt7996_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	return dev->bus_ops->rmw(mdev, __mt7996_reg_addr(dev, offset), mask, val);
+}
+
+static int mt7996_mmio_init(struct mt76_dev *mdev,
+			    void __iomem *mem_base,
+			    u32 device_id)
+{
+	struct mt76_bus_ops *bus_ops;
+	struct mt7996_dev *dev;
+
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+	mt76_mmio_init(&dev->mt76, mem_base);
+
+	switch (device_id) {
+	case 0x7990:
+		dev->reg.base = mt7996_reg_base;
+		dev->reg.map = mt7996_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops)
+		return -ENOMEM;
+
+	bus_ops->rr = mt7996_rr;
+	bus_ops->wr = mt7996_wr;
+	bus_ops->rmw = mt7996_rmw;
+	dev->mt76.bus = bus_ops;
+
+	mdev->rev = (device_id << 16) | (mt76_rr(dev, MT_HW_REV) & 0xff);
+
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	return 0;
+}
+
+void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
+				  u32 clear, u32 set)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mdev->mmio.irq_lock, flags);
+
+	mdev->mmio.irqmask &= ~clear;
+	mdev->mmio.irqmask |= set;
+
+	if (write_reg) {
+		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
+		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
+	}
+
+	spin_unlock_irqrestore(&mdev->mmio.irq_lock, flags);
+}
+
+static void mt7996_rx_poll_complete(struct mt76_dev *mdev,
+				    enum mt76_rxq_id q)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	mt7996_irq_enable(dev, MT_INT_RX(q));
+}
+
+/* TODO: support 2/4/6/8 MSI-X vectors */
+static void mt7996_irq_tasklet(struct tasklet_struct *t)
+{
+	struct mt7996_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	u32 i, intr, mask, intr1;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+
+	if (dev->hif2) {
+		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
+		intr1 &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+
+		intr |= intr1;
+	}
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask = intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+	mt7996_irq_disable(dev, mask);
+
+	if (intr & MT_INT_TX_DONE_MCU)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		if ((intr & MT_INT_RX(i)))
+			napi_schedule(&dev->mt76.napi[i]);
+	}
+
+	if (intr & MT_INT_MCU_CMD) {
+		u32 val = mt76_rr(dev, MT_MCU_CMD);
+
+		mt76_wr(dev, MT_MCU_CMD, val);
+		if (val & MT_MCU_CMD_ERROR_MASK) {
+			dev->reset_state = val;
+			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+	}
+}
+
+irqreturn_t mt7996_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7996_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7996_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE |
+			     MT_DRV_HW_MGMT_TXQ,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7996_TOKEN_SIZE,
+		.tx_prepare_skb = mt7996_tx_prepare_skb,
+		.tx_complete_skb = mt7996_tx_complete_skb,
+		.rx_skb = mt7996_queue_rx_skb,
+		.rx_check = mt7996_rx_check,
+		.rx_poll_complete = mt7996_rx_poll_complete,
+		.sta_ps = mt7996_sta_ps,
+		.sta_add = mt7996_mac_sta_add,
+		.sta_remove = mt7996_mac_sta_remove,
+		.update_survey = mt7996_update_channel,
+	};
+	struct mt7996_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), &mt7996_ops, &drv_ops);
+	if (!mdev)
+		return ERR_PTR(-ENOMEM);
+
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	ret = mt7996_mmio_init(mdev, mem_base, device_id);
+	if (ret)
+		goto error;
+
+	tasklet_setup(&dev->irq_tasklet, mt7996_irq_tasklet);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
+	return dev;
+
+error:
+	mt76_free_device(&dev->mt76);
+
+	return ERR_PTR(ret);
+}
+
+static int __init mt7996_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7996_hif_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&mt7996_pci_driver);
+	if (ret)
+		pci_unregister_driver(&mt7996_hif_driver);
+
+	return ret;
+}
+
+static void __exit mt7996_exit(void)
+{
+	pci_unregister_driver(&mt7996_pci_driver);
+	pci_unregister_driver(&mt7996_hif_driver);
+}
+
+module_init(mt7996_init);
+module_exit(mt7996_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
new file mode 100644
index 000000000000..371195e4597d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -0,0 +1,516 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_H
+#define __MT7996_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76_connac.h"
+#include "regs.h"
+
+#define MT7996_MAX_INTERFACES		19
+#define MT7996_MAX_WMM_SETS		4
+#define MT7996_WTBL_SIZE		544
+#define MT7996_WTBL_RESERVED		(MT7996_WTBL_SIZE - 1)
+#define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
+					 MT7996_MAX_INTERFACES)
+
+#define MT7996_WATCHDOG_TIME		(HZ / 10)
+#define MT7996_RESET_TIMEOUT		(30 * HZ)
+
+#define MT7996_TX_RING_SIZE		2048
+#define MT7996_TX_MCU_RING_SIZE		256
+#define MT7996_TX_FWDL_RING_SIZE	128
+
+#define MT7996_RX_RING_SIZE		1536
+#define MT7996_RX_MCU_RING_SIZE		512
+
+#define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
+#define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
+#define MT7996_ROM_PATCH		"mediatek/mt7996/mt7996_rom_patch.bin"
+
+#define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
+#define MT7996_EEPROM_SIZE		7680
+#define MT7996_EEPROM_BLOCK_SIZE	16
+#define MT7996_TOKEN_SIZE		8192
+
+#define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+
+#define MT7996_MAX_TWT_AGRT		16
+#define MT7996_MAX_STA_TWT_AGRT		8
+#define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
+
+struct mt7996_vif;
+struct mt7996_sta;
+struct mt7996_dfs_pulse;
+struct mt7996_dfs_pattern;
+
+enum mt7996_txq_id {
+	MT7996_TXQ_FWDL = 16,
+	MT7996_TXQ_MCU_WM,
+	MT7996_TXQ_BAND0,
+	MT7996_TXQ_BAND1,
+	MT7996_TXQ_MCU_WA,
+	MT7996_TXQ_BAND2,
+};
+
+enum mt7996_rxq_id {
+	MT7996_RXQ_MCU_WM = 0,
+	MT7996_RXQ_MCU_WA,
+	MT7996_RXQ_MCU_WA_MAIN = 2,
+	MT7996_RXQ_MCU_WA_EXT = 2,/* unused */
+	MT7996_RXQ_MCU_WA_TRI = 3,
+	MT7996_RXQ_BAND0 = 4,
+	MT7996_RXQ_BAND1 = 4,/* unused */
+	MT7996_RXQ_BAND2 = 5,
+};
+
+struct mt7996_twt_flow {
+	struct list_head list;
+	u64 start_tsf;
+	u64 tsf;
+	u32 duration;
+	u16 wcid;
+	__le16 mantissa;
+	u8 exp;
+	u8 table_id;
+	u8 id;
+	u8 protection:1;
+	u8 flowtype:1;
+	u8 trigger:1;
+	u8 sched:1;
+};
+
+struct mt7996_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7996_vif *vif;
+
+	struct list_head poll_list;
+	struct list_head rc_list;
+	u32 airtime_ac[8];
+
+	unsigned long changed;
+	unsigned long jiffies;
+	unsigned long ampdu_state;
+
+	struct mt76_sta_stats stats;
+
+	struct mt76_connac_sta_key_conf bip;
+
+	struct {
+		u8 flowid_mask;
+		struct mt7996_twt_flow flow[MT7996_MAX_STA_TWT_AGRT];
+	} twt;
+};
+
+struct mt7996_vif_cap {
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
+	bool he_ldpc:1;
+	bool vht_su_ebfer:1;
+	bool vht_su_ebfee:1;
+	bool vht_mu_ebfer:1;
+	bool vht_mu_ebfee:1;
+	bool he_su_ebfer:1;
+	bool he_su_ebfee:1;
+	bool he_mu_ebfer:1;
+};
+
+struct mt7996_vif {
+	struct mt76_vif mt76; /* must be first */
+
+	struct mt7996_vif_cap cap;
+	struct mt7996_sta sta;
+	struct mt7996_phy *phy;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct cfg80211_bitrate_mask bitrate_mask;
+};
+
+/* per-phy stats.  */
+struct mib_stats {
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
+	u32 tx_mu_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_eht_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
+	u32 tx_bf_rx_fb_nc_cnt;
+	u32 tx_bf_rx_fb_nr_cnt;
+	u32 tx_bf_fb_cpl_cnt;
+	u32 tx_bf_fb_trig_cnt;
+
+	u32 tx_ampdu_cnt;
+	u32 tx_stop_q_empty_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	/* BF counter is PPDU-based, so remove MPDU-based BF counter */
+
+	u32 tx_rwp_fail_cnt;
+	u32 tx_rwp_need_cnt;
+
+	/* rx stats */
+	u32 rx_fifo_full_cnt;
+	u32 channel_idle_cnt;
+	u32 rx_vector_mismatch_cnt;
+	u32 rx_delimiter_fail_cnt;
+	u32 rx_len_mismatch_cnt;
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ampdu_valid_subframe_cnt;
+	u32 rx_ampdu_valid_subframe_bytes_cnt;
+	u32 rx_pfdrop_cnt;
+	u32 rx_vec_queue_overflow_drop_cnt;
+	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
+};
+
+struct mt7996_hif {
+	struct list_head list;
+
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+};
+
+struct mt7996_phy {
+	struct mt76_phy *mt76;
+	struct mt7996_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
+
+	struct ieee80211_vif *monitor_vif;
+
+	u32 rxfilter;
+	u64 omac_mask;
+
+	u16 noise;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	u8 rdd_state;
+
+	u32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mib_stats mib;
+	struct mt76_channel_state state_ts;
+};
+
+struct mt7996_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	struct mt7996_hif *hif2;
+	struct mt7996_reg_desc reg;
+	u8 q_id[MT7996_MAX_QUEUE];
+	u32 q_int_mask[MT7996_MAX_QUEUE];
+	u32 q_wfdma_mask;
+
+	const struct mt76_bus_ops *bus_ops;
+	struct tasklet_struct irq_tasklet;
+	struct mt7996_phy phy;
+
+	/* monitor rx chain configured channel */
+	struct cfg80211_chan_def rdd2_chandef;
+	struct mt7996_phy *rdd2_phy;
+
+	u16 chainmask;
+	u8 chainshift[__MT_MAX_BAND];
+	u32 hif_idx;
+
+	struct work_struct init_work;
+	struct work_struct rc_work;
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
+	struct list_head sta_rc_list;
+	struct list_head sta_poll_list;
+	struct list_head twt_list;
+	spinlock_t sta_poll_lock;
+
+	u32 hw_pattern;
+
+	bool dbdc_support:1;
+	bool tbtc_support:1;
+	bool flash_mode:1;
+
+	bool ibf;
+	u8 fw_debug_wm;
+	u8 fw_debug_wa;
+	u8 fw_debug_bin;
+	u16 fw_debug_seq;
+
+	struct dentry *debugfs_dir;
+	struct rchan *relay_fwlog;
+
+	struct {
+		u8 table_mask;
+		u8 n_agrt;
+	} twt;
+
+	u32 reg_l1_backup;
+	u32 reg_l2_backup;
+};
+
+enum {
+	WFDMA0 = 0x0,
+	WFDMA1,
+	WFDMA_EXT,
+	__MT_WFDMA_MAX,
+};
+
+enum {
+	MT_CTX0,
+	MT_HIF0 = 0x0,
+
+	MT_LMAC_AC00 = 0x0,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+};
+
+enum {
+	MT_RX_SEL0,
+	MT_RX_SEL1,
+	MT_RX_SEL2, /* monitor chain */
+};
+
+enum mt7996_rdd_cmd {
+	RDD_STOP,
+	RDD_START,
+	RDD_DET_MODE,
+	RDD_RADAR_EMULATE,
+	RDD_START_TXQ = 20,
+	RDD_CAC_START = 50,
+	RDD_CAC_END,
+	RDD_NORMAL_START,
+	RDD_DISABLE_DFS_CAL,
+	RDD_PULSE_DBG,
+	RDD_READ_PULSE,
+	RDD_RESUME_BF,
+	RDD_IRQ_OFF,
+};
+
+static inline struct mt7996_phy *
+mt7996_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7996_dev *
+mt7996_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7996_dev, mt76);
+}
+
+static inline struct mt7996_phy *
+__mt7996_phy(struct mt7996_dev *dev, enum mt76_band_id band)
+{
+	struct mt76_phy *phy = dev->mt76.phys[band];
+
+	if (!phy)
+		return NULL;
+
+	return phy->priv;
+}
+
+static inline struct mt7996_phy *
+mt7996_phy2(struct mt7996_dev *dev)
+{
+	return __mt7996_phy(dev, MT_BAND1);
+}
+
+static inline struct mt7996_phy *
+mt7996_phy3(struct mt7996_dev *dev)
+{
+	return __mt7996_phy(dev, MT_BAND2);
+}
+
+extern const struct ieee80211_ops mt7996_ops;
+extern struct pci_driver mt7996_pci_driver;
+extern struct pci_driver mt7996_hif_driver;
+
+struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id);
+void mt7996_wfsys_reset(struct mt7996_dev *dev);
+irqreturn_t mt7996_irq_handler(int irq, void *dev_instance);
+u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif);
+int mt7996_register_device(struct mt7996_dev *dev);
+void mt7996_unregister_device(struct mt7996_dev *dev);
+int mt7996_eeprom_init(struct mt7996_dev *dev);
+int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy);
+int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
+				   struct ieee80211_channel *chan);
+s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band);
+int mt7996_dma_init(struct mt7996_dev *dev);
+void mt7996_dma_prefetch(struct mt7996_dev *dev);
+void mt7996_dma_cleanup(struct mt7996_dev *dev);
+int mt7996_mcu_init(struct mt7996_dev *dev);
+int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
+			       struct mt7996_vif *mvif,
+			       struct mt7996_twt_flow *flow,
+			       int cmd);
+int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, bool enable);
+int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, int enable);
+int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable);
+int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool add);
+int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool add);
+int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color);
+int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  int enable);
+int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
+				    struct ieee80211_vif *vif, u32 changed);
+int mt7996_mcu_add_obss_spr(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			    bool enable);
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta, bool changed);
+int mt7996_set_channel(struct mt7996_phy *phy);
+int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
+int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif);
+int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
+				   void *data, u16 version);
+int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset);
+int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
+int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 set, u8 band);
+int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action);
+int mt7996_mcu_set_fcc5_lpn(struct mt7996_dev *dev, int val);
+int mt7996_mcu_set_pulse_th(struct mt7996_dev *dev,
+			    const struct mt7996_dfs_pulse *pulse);
+int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
+			    const struct mt7996_dfs_pattern *pattern);
+int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
+void mt7996_mcu_set_pm(void *priv, u8 *mac, struct ieee80211_vif *vif);
+int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
+int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
+int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
+		       u8 rx_sel, u8 val);
+int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
+				     struct cfg80211_chan_def *chandef);
+int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set);
+int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans);
+int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val);
+int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
+int mt7996_mcu_fw_log_2_host(struct mt7996_dev *dev, u8 type, u8 ctrl);
+int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
+void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
+void mt7996_mcu_exit(struct mt7996_dev *dev);
+
+void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
+				  u32 clear, u32 set);
+
+static inline void mt7996_irq_enable(struct mt7996_dev *dev, u32 mask)
+{
+	if (dev->hif2)
+		mt7996_dual_hif_set_irq_mask(dev, false, 0, mask);
+	else
+		mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
+static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
+{
+	if (dev->hif2)
+		mt7996_dual_hif_set_irq_mask(dev, true, mask, 0);
+	else
+		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
+}
+
+u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
+bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
+void mt7996_mac_reset_counters(struct mt7996_phy *phy);
+void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy);
+void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
+void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
+			   struct ieee80211_key_conf *key, u32 changed);
+void mt7996_mac_set_timing(struct mt7996_phy *phy);
+int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7996_mac_work(struct work_struct *work);
+void mt7996_mac_reset_work(struct work_struct *work);
+void mt7996_mac_sta_rc_work(struct work_struct *work);
+void mt7996_mac_update_stats(struct mt7996_phy *phy);
+void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
+				  struct mt7996_sta *msta,
+				  u8 flowid);
+void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt);
+int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info);
+void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+void mt7996_tx_token_put(struct mt7996_dev *dev);
+void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb);
+bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
+void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
+void mt7996_stats_work(struct work_struct *work);
+int mt76_dfs_start_rdd(struct mt7996_dev *dev, bool force);
+int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy);
+void mt7996_set_stream_he_caps(struct mt7996_phy *phy);
+void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy);
+void mt7996_update_channel(struct mt76_phy *mphy);
+int mt7996_init_debugfs(struct mt7996_phy *phy);
+void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len);
+bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
+int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct ieee80211_key_conf *key, int mcu_cmd,
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
+int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta);
+#ifdef CONFIG_MAC80211_DEBUGFS
+void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir);
+#endif
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
new file mode 100644
index 000000000000..64aee3fb5445
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7996.h"
+#include "mac.h"
+#include "../trace.h"
+
+static LIST_HEAD(hif_list);
+static DEFINE_SPINLOCK(hif_lock);
+static u32 hif_idx;
+
+static const struct pci_device_id mt7996_pci_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7990) },
+	{ },
+};
+
+static const struct pci_device_id mt7996_hif_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7991) },
+	{ },
+};
+
+static struct mt7996_hif *mt7996_pci_get_hif2(u32 idx)
+{
+	struct mt7996_hif *hif;
+	u32 val;
+
+	spin_lock_bh(&hif_lock);
+
+	list_for_each_entry(hif, &hif_list, list) {
+		val = readl(hif->regs + MT_PCIE_RECOG_ID);
+		val &= MT_PCIE_RECOG_ID_MASK;
+		if (val != idx)
+			continue;
+
+		get_device(hif->dev);
+		goto out;
+	}
+	hif = NULL;
+
+out:
+	spin_unlock_bh(&hif_lock);
+
+	return hif;
+}
+
+static void mt7996_put_hif2(struct mt7996_hif *hif)
+{
+	if (!hif)
+		return;
+
+	put_device(hif->dev);
+}
+
+static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
+{
+	hif_idx++;
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL))
+		return NULL;
+
+	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
+	       pcim_iomap_table(pdev)[0] + MT_PCIE_RECOG_ID);
+
+	return mt7996_pci_get_hif2(hif_idx);
+}
+
+static int mt7996_pci_hif2_probe(struct pci_dev *pdev)
+{
+	struct mt7996_hif *hif;
+
+	hif = devm_kzalloc(&pdev->dev, sizeof(*hif), GFP_KERNEL);
+	if (!hif)
+		return -ENOMEM;
+
+	hif->dev = &pdev->dev;
+	hif->regs = pcim_iomap_table(pdev)[0];
+	hif->irq = pdev->irq;
+	spin_lock_bh(&hif_lock);
+	list_add(&hif->list, &hif_list);
+	spin_unlock_bh(&hif_lock);
+	pci_set_drvdata(pdev, hif);
+
+	return 0;
+}
+
+static int mt7996_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct pci_dev *hif2_dev;
+	struct mt7996_dev *dev;
+	struct mt76_dev *mdev;
+	struct mt7996_hif *hif2;
+	int irq, ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	mt76_pci_disable_aspm(pdev);
+
+	if (id->device == 0x7991)
+		return mt7996_pci_hif2_probe(pdev);
+
+	dev = mt7996_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				id->device);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	mdev = &dev->mt76;
+	mt7996_wfsys_reset(dev);
+	hif2 = mt7996_pci_init_hif2(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		goto free_device;
+
+	irq = pdev->irq;
+	ret = devm_request_irq(mdev->dev, irq, mt7996_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto free_irq_vector;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	/* master switch of PCIe tnterrupt enable */
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	if (hif2) {
+		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
+		dev->hif2 = hif2;
+
+		ret = pci_alloc_irq_vectors(hif2_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0)
+			goto free_hif2;
+
+		dev->hif2->irq = hif2_dev->irq;
+		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
+				       mt7996_irq_handler, IRQF_SHARED,
+				       KBUILD_MODNAME "-hif", dev);
+		if (ret)
+			goto free_hif2_irq_vector;
+
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+		/* master switch of PCIe tnterrupt enable */
+		mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	}
+
+	ret = mt7996_register_device(dev);
+	if (ret)
+		goto free_hif2_irq;
+
+	return 0;
+
+free_hif2_irq:
+	if (dev->hif2)
+		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
+free_hif2_irq_vector:
+	if (dev->hif2)
+		pci_free_irq_vectors(hif2_dev);
+free_hif2:
+	if (dev->hif2)
+		put_device(dev->hif2->dev);
+	devm_free_irq(mdev->dev, irq, dev);
+free_irq_vector:
+	pci_free_irq_vectors(pdev);
+free_device:
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7996_hif_remove(struct pci_dev *pdev)
+{
+	struct mt7996_hif *hif = pci_get_drvdata(pdev);
+
+	list_del(&hif->list);
+}
+
+static void mt7996_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev;
+	struct mt7996_dev *dev;
+
+	mdev = pci_get_drvdata(pdev);
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+	mt7996_put_hif2(dev->hif2);
+	mt7996_unregister_device(dev);
+}
+
+struct pci_driver mt7996_hif_driver = {
+	.name		= KBUILD_MODNAME "_hif",
+	.id_table	= mt7996_hif_device_table,
+	.probe		= mt7996_pci_probe,
+	.remove		= mt7996_hif_remove,
+};
+
+struct pci_driver mt7996_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7996_pci_device_table,
+	.probe		= mt7996_pci_probe,
+	.remove		= mt7996_pci_remove,
+};
+
+MODULE_DEVICE_TABLE(pci, mt7996_pci_device_table);
+MODULE_DEVICE_TABLE(pci, mt7996_hif_device_table);
+MODULE_FIRMWARE(MT7996_FIRMWARE_WA);
+MODULE_FIRMWARE(MT7996_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7996_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
new file mode 100644
index 000000000000..1d53611da4d8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -0,0 +1,533 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_REGS_H
+#define __MT7996_REGS_H
+
+struct __map {
+	u32 phys;
+	u32 mapped;
+	u32 size;
+};
+
+struct __base {
+	u32 band_base[__MT_MAX_BAND];
+};
+
+/* used to differentiate between generations */
+struct mt7996_reg_desc {
+	const struct __base *base;
+	const struct __map *map;
+	u32 map_size;
+};
+
+enum base_rev {
+	WF_AGG_BASE,
+	WF_MIB_BASE,
+	WF_TMAC_BASE,
+	WF_RMAC_BASE,
+	WF_ARB_BASE,
+	WF_LPON_BASE,
+	WF_ETBF_BASE,
+	WF_DMA_BASE,
+	__MT_REG_BASE_MAX,
+};
+
+#define __BASE(_id, _band)			(dev->reg.base[(_id)].band_base[(_band)])
+
+#define MT_MCU_INT_EVENT			0x2108
+#define MT_MCU_INT_EVENT_DMA_STOPPED		BIT(0)
+#define MT_MCU_INT_EVENT_DMA_INIT		BIT(1)
+#define MT_MCU_INT_EVENT_RESET_DONE		BIT(3)
+
+/* PLE */
+#define MT_PLE_BASE				0x820c0000
+#define MT_PLE(ofs)				(MT_PLE_BASE + (ofs))
+
+#define MT_FL_Q_EMPTY				MT_PLE(0x360)
+#define MT_FL_Q0_CTRL				MT_PLE(0x3e0)
+#define MT_FL_Q2_CTRL				MT_PLE(0x3e8)
+#define MT_FL_Q3_CTRL				MT_PLE(0x3ec)
+
+#define MT_PLE_FREEPG_CNT			MT_PLE(0x380)
+#define MT_PLE_FREEPG_HEAD_TAIL			MT_PLE(0x384)
+#define MT_PLE_PG_HIF_GROUP			MT_PLE(0x00c)
+#define MT_PLE_HIF_PG_INFO			MT_PLE(0x388)
+
+#define MT_PLE_AC_QEMPTY(ac, n)			MT_PLE(0x600 +	0x80 * (ac) + ((n) << 2))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)		MT_PLE(0x10e0 + ((n) << 2))
+
+/* WF MDP TOP */
+#define MT_MDP_BASE				0x820cc000
+#define MT_MDP(ofs)				(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR2				MT_MDP(0x8e8)
+#define MT_MDP_DCR2_RX_TRANS_SHORT		BIT(2)
+
+/* TMAC: band 0(0x820e4000), band 1(0x820f4000), band 2(0x830e4000) */
+#define MT_WF_TMAC_BASE(_band)			__BASE(WF_TMAC_BASE, (_band))
+#define MT_WF_TMAC(_band, ofs)			(MT_WF_TMAC_BASE(_band) + (ofs))
+
+#define MT_TMAC_TCR0(_band)			MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TX_BLINK			GENMASK(7, 6)
+
+#define MT_TMAC_CDTR(_band)			MT_WF_TMAC(_band, 0x0c8)
+#define MT_TMAC_ODTR(_band)			MT_WF_TMAC(_band, 0x0cc)
+#define MT_TIMEOUT_VAL_PLCP			GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA			GENMASK(31, 16)
+
+#define MT_TMAC_ICR0(_band)			MT_WF_TMAC(_band, 0x014)
+#define MT_IFS_EIFS_OFDM			GENMASK(8, 0)
+#define MT_IFS_RIFS				GENMASK(14, 10)
+#define MT_IFS_SIFS				GENMASK(22, 16)
+#define MT_IFS_SLOT				GENMASK(30, 24)
+
+#define MT_TMAC_ICR1(_band)			MT_WF_TMAC(_band, 0x018)
+#define MT_IFS_EIFS_CCK				GENMASK(8, 0)
+
+/* WF DMA TOP: band 0(0x820e7000), band 1(0x820f7000), band 2(0x830e7000) */
+#define MT_WF_DMA_BASE(_band)			__BASE(WF_DMA_BASE, (_band))
+#define MT_WF_DMA(_band, ofs)			(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)			MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_RXD_G5_EN			BIT(23)
+
+#define MT_DMA_TCRF1(_band)			MT_WF_DMA(_band, 0x054)
+#define MT_DMA_TCRF1_QIDX			GENMASK(15, 13)
+
+/* ETBF: band 0(0x820ea000), band 1(0x820fa000), band 2(0x830ea000) */
+#define MT_WF_ETBF_BASE(_band)			__BASE(WF_ETBF_BASE, (_band))
+#define MT_WF_ETBF(_band, ofs)			(MT_WF_ETBF_BASE(_band) + (ofs))
+
+#define MT_ETBF_RX_FB_CONT(_band)		MT_WF_ETBF(_band, 0x100)
+#define MT_ETBF_RX_FB_BW			GENMASK(10, 8)
+#define MT_ETBF_RX_FB_NC			GENMASK(7, 4)
+#define MT_ETBF_RX_FB_NR			GENMASK(3, 0)
+
+/* LPON: band 0(0x820eb000), band 1(0x820fb000), band 2(0x830eb000) */
+#define MT_WF_LPON_BASE(_band)			__BASE(WF_LPON_BASE, (_band))
+#define MT_WF_LPON(_band, ofs)			(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)			MT_WF_LPON(_band, 0x360)
+#define MT_LPON_UTTR1(_band)			MT_WF_LPON(_band, 0x364)
+#define MT_LPON_FRCR(_band)			MT_WF_LPON(_band, 0x37c)
+
+#define MT_LPON_TCR(_band, n)			MT_WF_LPON(_band, 0x0a8 + (((n) * 4) << 4))
+#define MT_LPON_TCR_SW_MODE			GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE			BIT(0)
+#define MT_LPON_TCR_SW_ADJUST			BIT(1)
+#define MT_LPON_TCR_SW_READ			GENMASK(1, 0)
+
+/* MIB: band 0(0x820ed000), band 1(0x820fd000), band 2(0x830ed000)*/
+/* These counters are (mostly?) clear-on-read.  So, some should not
+ * be read at all in case firmware is already reading them.  These
+ * are commented with 'DNR' below. The DNR stats will be read by querying
+ * the firmware API for the appropriate message.  For counters the driver
+ * does read, the driver should accumulate the counters.
+ */
+#define MT_WF_MIB_BASE(_band)			__BASE(WF_MIB_BASE, (_band))
+#define MT_WF_MIB(_band, ofs)			(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_BSCR0(_band)			MT_WF_MIB(_band, 0x9cc)
+#define MT_MIB_BSCR1(_band)			MT_WF_MIB(_band, 0x9d0)
+#define MT_MIB_BSCR2(_band)			MT_WF_MIB(_band, 0x9d4)
+#define MT_MIB_BSCR3(_band)			MT_WF_MIB(_band, 0x9d8)
+#define MT_MIB_BSCR4(_band)			MT_WF_MIB(_band, 0x9dc)
+#define MT_MIB_BSCR5(_band)			MT_WF_MIB(_band, 0x9e0)
+#define MT_MIB_BSCR6(_band)			MT_WF_MIB(_band, 0x9e4)
+#define MT_MIB_BSCR7(_band)			MT_WF_MIB(_band, 0x9e8)
+#define MT_MIB_BSCR17(_band)			MT_WF_MIB(_band, 0xa10)
+
+#define MT_MIB_TSCR5(_band)			MT_WF_MIB(_band, 0x6c4)
+#define MT_MIB_TSCR6(_band)			MT_WF_MIB(_band, 0x6c8)
+#define MT_MIB_TSCR7(_band)			MT_WF_MIB(_band, 0x6d0)
+
+#define MT_MIB_RSCR1(_band)			MT_WF_MIB(_band, 0x7ac)
+/* rx mpdu counter, full 32 bits */
+#define MT_MIB_RSCR31(_band)			MT_WF_MIB(_band, 0x964)
+#define MT_MIB_RSCR33(_band)			MT_WF_MIB(_band, 0x96c)
+
+#define MT_MIB_SDR6(_band)			MT_WF_MIB(_band, 0x020)
+#define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_RVSR0(_band)			MT_WF_MIB(_band, 0x720)
+
+#define MT_MIB_RSCR35(_band)			MT_WF_MIB(_band, 0x974)
+#define MT_MIB_RSCR36(_band)			MT_WF_MIB(_band, 0x978)
+
+/* tx ampdu cnt, full 32 bits */
+#define MT_MIB_TSCR0(_band)			MT_WF_MIB(_band, 0x6b0)
+#define MT_MIB_TSCR2(_band)			MT_WF_MIB(_band, 0x6b8)
+
+/* counts all mpdus in ampdu, regardless of success */
+#define MT_MIB_TSCR3(_band)			MT_WF_MIB(_band, 0x6bc)
+
+/* counts all successfully tx'd mpdus in ampdu */
+#define MT_MIB_TSCR4(_band)			MT_WF_MIB(_band, 0x6c0)
+
+/* rx ampdu count, 32-bit */
+#define MT_MIB_RSCR27(_band)			MT_WF_MIB(_band, 0x954)
+
+/* rx ampdu bytes count, 32-bit */
+#define MT_MIB_RSCR28(_band)			MT_WF_MIB(_band, 0x958)
+
+/* rx ampdu valid subframe count */
+#define MT_MIB_RSCR29(_band)			MT_WF_MIB(_band, 0x95c)
+
+/* rx ampdu valid subframe bytes count, 32bits */
+#define MT_MIB_RSCR30(_band)			MT_WF_MIB(_band, 0x960)
+
+/* remaining windows protected stats */
+#define MT_MIB_SDR27(_band)			MT_WF_MIB(_band, 0x080)
+#define MT_MIB_SDR27_TX_RWP_FAIL_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR28(_band)			MT_WF_MIB(_band, 0x084)
+#define MT_MIB_SDR28_TX_RWP_NEED_CNT		GENMASK(15, 0)
+
+#define MT_MIB_RVSR1(_band)			MT_WF_MIB(_band, 0x724)
+
+/* rx blockack count, 32 bits */
+#define MT_MIB_TSCR1(_band)			MT_WF_MIB(_band, 0x6b4)
+
+#define MT_MIB_BTSCR0(_band)			MT_WF_MIB(_band, 0x5e0)
+#define MT_MIB_BTSCR5(_band)			MT_WF_MIB(_band, 0x788)
+#define MT_MIB_BTSCR6(_band)			MT_WF_MIB(_band, 0x798)
+
+#define MT_MIB_BFTFCR(_band)			MT_WF_MIB(_band, 0x5d0)
+
+#define MT_TX_AGG_CNT(_band, n)			MT_WF_MIB(_band, 0xa28 + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)			MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)		(((val) >> ((n) << 4)) & GENMASK(9, 0))
+
+/* UMIB */
+#define MT_WF_UMIB_BASE				0x820cd000
+#define MT_WF_UMIB(ofs)				(MT_WF_UMIB_BASE + (ofs))
+
+#define MT_UMIB_RPDCR(_band)			(MT_WF_UMIB(0x594) + (_band) * 0x164)
+
+/* WTBLON TOP */
+#define MT_WTBLON_TOP_BASE			0x820d4000
+#define MT_WTBLON_TOP(ofs)			(MT_WTBLON_TOP_BASE + (ofs))
+#define MT_WTBLON_TOP_WDUCR			MT_WTBLON_TOP(0x370)
+#define MT_WTBLON_TOP_WDUCR_GROUP		GENMASK(4, 0)
+
+#define MT_WTBL_UPDATE				MT_WTBLON_TOP(0x380)
+#define MT_WTBL_UPDATE_WLAN_IDX			GENMASK(11, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR		BIT(14)
+#define MT_WTBL_UPDATE_BUSY			BIT(31)
+
+/* WTBL */
+#define MT_WTBL_BASE				0x820d8000
+#define MT_WTBL_LMAC_ID				GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW				GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)		(MT_WTBL_BASE | \
+						 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+						 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x820e2000), band 1(0x820f2000), band 2(0x830e2000) */
+#define MT_WF_AGG_BASE(_band)			__BASE(WF_AGG_BASE, (_band))
+#define MT_WF_AGG(_band, ofs)			(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_ACR0(_band)			MT_WF_AGG(_band, 0x054)
+#define MT_AGG_ACR_CFEND_RATE			GENMASK(13, 0)
+
+/* ARB: band 0(0x820e3000), band 1(0x820f3000), band 2(0x830e3000) */
+#define MT_WF_ARB_BASE(_band)			__BASE(WF_ARB_BASE, (_band))
+#define MT_WF_ARB(_band, ofs)			(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)			MT_WF_ARB(_band, 0x000)
+#define MT_ARB_SCR_TX_DISABLE			BIT(8)
+#define MT_ARB_SCR_RX_DISABLE			BIT(9)
+
+/* RMAC: band 0(0x820e5000), band 1(0x820f5000), band 2(0x830e5000), */
+#define MT_WF_RMAC_BASE(_band)			__BASE(WF_RMAC_BASE, (_band))
+#define MT_WF_RMAC(_band, ofs)			(MT_WF_RMAC_BASE(_band) + (ofs))
+
+#define MT_WF_RFCR(_band)			MT_WF_RMAC(_band, 0x000)
+#define MT_WF_RFCR_DROP_STBC_MULTI		BIT(0)
+#define MT_WF_RFCR_DROP_FCSFAIL			BIT(1)
+#define MT_WF_RFCR_DROP_PROBEREQ		BIT(4)
+#define MT_WF_RFCR_DROP_MCAST			BIT(5)
+#define MT_WF_RFCR_DROP_BCAST			BIT(6)
+#define MT_WF_RFCR_DROP_MCAST_FILTERED		BIT(7)
+#define MT_WF_RFCR_DROP_A3_MAC			BIT(8)
+#define MT_WF_RFCR_DROP_A3_BSSID		BIT(9)
+#define MT_WF_RFCR_DROP_A2_BSSID		BIT(10)
+#define MT_WF_RFCR_DROP_OTHER_BEACON		BIT(11)
+#define MT_WF_RFCR_DROP_FRAME_REPORT		BIT(12)
+#define MT_WF_RFCR_DROP_CTL_RSV			BIT(13)
+#define MT_WF_RFCR_DROP_CTS			BIT(14)
+#define MT_WF_RFCR_DROP_RTS			BIT(15)
+#define MT_WF_RFCR_DROP_DUPLICATE		BIT(16)
+#define MT_WF_RFCR_DROP_OTHER_BSS		BIT(17)
+#define MT_WF_RFCR_DROP_OTHER_UC		BIT(18)
+#define MT_WF_RFCR_DROP_OTHER_TIM		BIT(19)
+#define MT_WF_RFCR_DROP_NDPA			BIT(20)
+#define MT_WF_RFCR_DROP_UNWANTED_CTL		BIT(21)
+
+#define MT_WF_RFCR1(_band)			MT_WF_RMAC(_band, 0x004)
+#define MT_WF_RFCR1_DROP_ACK			BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL		BIT(5)
+#define MT_WF_RFCR1_DROP_BA			BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND			BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK			BIT(8)
+
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)		MT_WF_RMAC(_band, 0x0380)
+#define MT_WF_RMAC_MIB_RXTIME_CLR		BIT(31)
+#define MT_WF_RMAC_MIB_ED_OFFSET		GENMASK(20, 16)
+#define MT_WF_RMAC_MIB_OBSS_BACKOFF		GENMASK(15, 0)
+
+#define MT_WF_RMAC_MIB_AIRTIME1(_band)		MT_WF_RMAC(_band, 0x0384)
+#define MT_WF_RMAC_MIB_NONQOSD_BACKOFF		GENMASK(31, 16)
+
+#define MT_WF_RMAC_MIB_AIRTIME3(_band)		MT_WF_RMAC(_band, 0x038c)
+#define MT_WF_RMAC_MIB_QOS01_BACKOFF		GENMASK(31, 0)
+
+#define MT_WF_RMAC_MIB_AIRTIME4(_band)		MT_WF_RMAC(_band, 0x0390)
+#define MT_WF_RMAC_MIB_QOS23_BACKOFF		GENMASK(31, 0)
+
+#define MT_WF_RMAC_RSVD0(_band)			MT_WF_RMAC(_band, 0x03e0)
+#define MT_WF_RMAC_RSVD0_EIFS_CLR		BIT(21)
+
+/* WFDMA0 */
+#define MT_WFDMA0_BASE				0xd4000
+#define MT_WFDMA0(ofs)				(MT_WFDMA0_BASE + (ofs))
+
+#define MT_WFDMA0_RST				MT_WFDMA0(0x100)
+#define MT_WFDMA0_RST_LOGIC_RST			BIT(4)
+#define MT_WFDMA0_RST_DMASHDL_ALL_RST		BIT(5)
+
+#define MT_WFDMA0_BUSY_ENA			MT_WFDMA0(0x13c)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO0		BIT(0)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO1		BIT(1)
+#define MT_WFDMA0_BUSY_ENA_RX_FIFO		BIT(2)
+
+#define MT_WFDMA0_RX_INT_PCIE_SEL		MT_WFDMA0(0x154)
+#define MT_WFDMA0_RX_INT_SEL_RING3		BIT(3)
+
+#define MT_WFDMA0_GLO_CFG			MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN		BIT(0)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN		BIT(2)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO		BIT(28)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO		BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+
+#define WF_WFDMA0_GLO_CFG_EXT0			MT_WFDMA0(0x2b0)
+#define WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD	BIT(18)
+#define WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE	BIT(14)
+
+#define WF_WFDMA0_GLO_CFG_EXT1			MT_WFDMA0(0x2b4)
+#define WF_WFDMA0_GLO_CFG_EXT1_CALC_MODE	BIT(31)
+#define WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE	BIT(28)
+
+#define MT_WFDMA0_RST_DTX_PTR			MT_WFDMA0(0x20c)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0		MT_WFDMA0(0x2f0)
+#define MT_WFDMA0_PRI_DLY_INT_CFG1		MT_WFDMA0(0x2f4)
+#define MT_WFDMA0_PRI_DLY_INT_CFG2		MT_WFDMA0(0x2f8)
+
+/* WFDMA1 */
+#define MT_WFDMA1_BASE				0xd5000
+
+/* WFDMA CSR */
+#define MT_WFDMA_EXT_CSR_BASE			0xd7000
+#define MT_WFDMA_EXT_CSR(ofs)			(MT_WFDMA_EXT_CSR_BASE + (ofs))
+
+#define MT_WFDMA_HOST_CONFIG			MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_HOST_CONFIG_PDMA_BAND		BIT(0)
+
+#define MT_WFDMA_EXT_CSR_HIF_MISC		MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY		BIT(0)
+
+#define MT_PCIE_RECOG_ID			0xd7090
+#define MT_PCIE_RECOG_ID_MASK			GENMASK(30, 0)
+#define MT_PCIE_RECOG_ID_SEM			BIT(31)
+
+/* WFDMA0 PCIE1 */
+#define MT_WFDMA0_PCIE1_BASE			0xd8000
+#define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+
+#define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
+
+/* WFDMA COMMON */
+#define __RXQ(q)				((q) + __MT_MCUQ_MAX)
+#define __TXQ(q)				(__RXQ(q) + __MT_RXQ_MAX)
+
+#define MT_Q_ID(q)				(dev->q_id[(q)])
+#define MT_Q_BASE(q)				((dev->q_wfdma_mask >> (q)) & 0x1 ?	\
+						 MT_WFDMA1_BASE : MT_WFDMA0_BASE)
+
+#define MT_MCUQ_ID(q)				MT_Q_ID(q)
+#define MT_TXQ_ID(q)				MT_Q_ID(__TXQ(q))
+#define MT_RXQ_ID(q)				MT_Q_ID(__RXQ(q))
+
+#define MT_MCUQ_RING_BASE(q)			(MT_Q_BASE(q) + 0x300)
+#define MT_TXQ_RING_BASE(q)			(MT_Q_BASE(__TXQ(q)) + 0x300)
+#define MT_RXQ_RING_BASE(q)			(MT_Q_BASE(__RXQ(q)) + 0x500)
+
+#define MT_MCUQ_EXT_CTRL(q)			(MT_Q_BASE(q) +	0x600 +	\
+						 MT_MCUQ_ID(q) * 0x4)
+#define MT_RXQ_BAND1_CTRL(q)			(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
+						 MT_RXQ_ID(q) * 0x4)
+#define MT_TXQ_EXT_CTRL(q)			(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
+						 MT_TXQ_ID(q) * 0x4)
+
+#define MT_INT_SOURCE_CSR			MT_WFDMA0(0x200)
+#define MT_INT_MASK_CSR				MT_WFDMA0(0x204)
+
+#define MT_INT1_SOURCE_CSR			MT_WFDMA0_PCIE1(0x200)
+#define MT_INT1_MASK_CSR			MT_WFDMA0_PCIE1(0x204)
+
+#define MT_INT_RX_DONE_BAND0			BIT(12)
+#define MT_INT_RX_DONE_BAND1			BIT(12)
+#define MT_INT_RX_DONE_BAND2			BIT(13)
+#define MT_INT_RX_DONE_WM			BIT(0)
+#define MT_INT_RX_DONE_WA			BIT(1)
+#define MT_INT_RX_DONE_WA_MAIN			BIT(2)
+#define MT_INT_RX_DONE_WA_EXT			BIT(2)
+#define MT_INT_RX_DONE_WA_TRI			BIT(3)
+#define MT_INT_RX_TXFREE_MAIN			BIT(17)
+#define MT_INT_RX_TXFREE_TRI			BIT(15)
+#define MT_INT_MCU_CMD				BIT(29)
+
+#define MT_INT_RX(q)				(dev->q_int_mask[__RXQ(q)])
+#define MT_INT_TX_MCU(q)			(dev->q_int_mask[(q)])
+
+#define MT_INT_RX_DONE_MCU			(MT_INT_RX(MT_RXQ_MCU) |	\
+						 MT_INT_RX(MT_RXQ_MCU_WA))
+
+#define MT_INT_BAND0_RX_DONE			(MT_INT_RX(MT_RXQ_MAIN) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_BAND1_RX_DONE			(MT_INT_RX(MT_RXQ_BAND1) |	\
+						 MT_INT_RX(MT_RXQ_BAND1_WA) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_BAND2_RX_DONE			(MT_INT_RX(MT_RXQ_BAND2) |	\
+						 MT_INT_RX(MT_RXQ_BAND2_WA) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_RX_DONE_ALL			(MT_INT_RX_DONE_MCU |		\
+						 MT_INT_BAND0_RX_DONE |		\
+						 MT_INT_BAND1_RX_DONE |		\
+						 MT_INT_BAND2_RX_DONE)
+
+#define MT_INT_TX_DONE_FWDL			BIT(26)
+#define MT_INT_TX_DONE_MCU_WM			BIT(27)
+#define MT_INT_TX_DONE_MCU_WA			BIT(22)
+#define MT_INT_TX_DONE_BAND0			BIT(30)
+#define MT_INT_TX_DONE_BAND1			BIT(31)
+#define MT_INT_TX_DONE_BAND2			BIT(15)
+
+#define MT_INT_TX_DONE_MCU			(MT_INT_TX_MCU(MT_MCUQ_WA) |	\
+						 MT_INT_TX_MCU(MT_MCUQ_WM) |	\
+						 MT_INT_TX_MCU(MT_MCUQ_FWDL))
+
+#define MT_MCU_CMD				MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_STOP_DMA			BIT(2)
+#define MT_MCU_CMD_RESET_DONE			BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE		BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE			BIT(5)
+#define MT_MCU_CMD_ERROR_MASK			GENMASK(5, 1)
+
+/* l1/l2 remap */
+#define MT_HIF_REMAP_L1				0x155024
+#define MT_HIF_REMAP_L1_MASK			GENMASK(31, 16)
+#define MT_HIF_REMAP_L1_OFFSET			GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE			GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1			0x130000
+
+#define MT_HIF_REMAP_L2				0x1b4
+#define MT_HIF_REMAP_L2_MASK			GENMASK(19, 0)
+#define MT_HIF_REMAP_L2_OFFSET			GENMASK(11, 0)
+#define MT_HIF_REMAP_L2_BASE			GENMASK(31, 12)
+#define MT_HIF_REMAP_BASE_L2			0x1000
+
+#define MT_INFRA_BASE				0x18000000
+#define MT_WFSYS0_PHY_START			0x18400000
+#define MT_WFSYS1_PHY_START			0x18800000
+#define MT_WFSYS1_PHY_END			0x18bfffff
+#define MT_CBTOP1_PHY_START			0x70000000
+#define MT_CBTOP1_PHY_END			0x77ffffff
+#define MT_CBTOP2_PHY_START			0xf0000000
+#define MT_CBTOP2_PHY_END			0xffffffff
+#define MT_INFRA_MCU_START			0x7c000000
+#define MT_INFRA_MCU_END			0x7c3fffff
+
+/* FW MODE SYNC */
+#define MT_SWDEF_MODE				0x9143c
+#define MT_SWDEF_NORMAL_MODE			0
+
+/* LED */
+#define MT_LED_TOP_BASE				0x18013000
+#define MT_LED_PHYS(_n)				(MT_LED_TOP_BASE + (_n))
+
+#define MT_LED_CTRL(_n)				MT_LED_PHYS(0x00 + ((_n) * 4))
+#define MT_LED_CTRL_KICK			BIT(7)
+#define MT_LED_CTRL_BLINK_MODE			BIT(2)
+#define MT_LED_CTRL_POLARITY			BIT(1)
+
+#define MT_LED_TX_BLINK(_n)			MT_LED_PHYS(0x10 + ((_n) * 4))
+#define MT_LED_TX_BLINK_ON_MASK			GENMASK(7, 0)
+#define MT_LED_TX_BLINK_OFF_MASK		GENMASK(15, 8)
+
+#define MT_LED_EN(_n)				MT_LED_PHYS(0x40 + ((_n) * 4))
+
+#define MT_LED_GPIO_MUX2			0x70005058 /* GPIO 18 */
+#define MT_LED_GPIO_MUX3			0x7000505C /* GPIO 26 */
+#define MT_LED_GPIO_SEL_MASK			GENMASK(11, 8)
+
+/* MT TOP */
+#define MT_TOP_BASE				0xe0000
+#define MT_TOP(ofs)				(MT_TOP_BASE + (ofs))
+
+#define MT_TOP_LPCR_HOST_BAND(_band)		MT_TOP(0x10 + ((_band) * 0x10))
+#define MT_TOP_LPCR_HOST_FW_OWN			BIT(0)
+#define MT_TOP_LPCR_HOST_DRV_OWN		BIT(1)
+#define MT_TOP_LPCR_HOST_FW_OWN_STAT		BIT(2)
+
+#define MT_TOP_LPCR_HOST_BAND_IRQ_STAT(_band)	MT_TOP(0x14 + ((_band) * 0x10))
+#define MT_TOP_LPCR_HOST_BAND_STAT		BIT(0)
+
+#define MT_TOP_MISC				MT_TOP(0xf0)
+#define MT_TOP_MISC_FW_STATE			GENMASK(2, 0)
+
+#define MT_HW_REV				0x70010204
+#define MT_WF_SUBSYS_RST			0x70002600
+
+/* PCIE MAC */
+#define MT_PCIE_MAC_BASE			0x74030000
+#define MT_PCIE_MAC(ofs)			(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE			MT_PCIE_MAC(0x188)
+
+#define MT_PCIE1_MAC_BASE			0x74090000
+#define MT_PCIE1_MAC(ofs)			(MT_PCIE1_MAC_BASE + (ofs))
+
+#define MT_PCIE1_MAC_INT_ENABLE			MT_PCIE1_MAC(0x188)
+
+/* PHYRX CTRL */
+#define MT_WF_PHYRX_BAND_BASE			0x83080000
+#define MT_WF_PHYRX_BAND(_band, ofs)		(MT_WF_PHYRX_BAND_BASE + \
+						 ((_band) << 20) + (ofs))
+
+#define MT_WF_PHYRX_BAND_RX_CTRL1(_band)	MT_WF_PHYRX_BAND(_band, 0x2004)
+#define MT_WF_PHYRX_BAND_RX_CTRL1_IPI_EN	GENMASK(2, 0)
+#define MT_WF_PHYRX_BAND_RX_CTRL1_STSCNT_EN	GENMASK(11, 9)
+
+/* PHYRX CSD */
+#define MT_WF_PHYRX_CSD_BASE			0x83000000
+#define MT_WF_PHYRX_CSD(_band, _wf, ofs)	(MT_WF_PHYRX_CSD_BASE + \
+						 ((_band) << 20) + \
+						 ((_wf) << 16) + (ofs))
+#define MT_WF_PHYRX_CSD_IRPI(_band, _wf)	MT_WF_PHYRX_CSD(_band, _wf, 0x1000)
+
+/* PHYRX CSD BAND */
+#define MT_WF_PHYRX_CSD_BAND_RXTD12(_band)		MT_WF_PHYRX_BAND(_band, 0x8230)
+#define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
+#define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR		BIT(29)
+
+#endif
-- 
2.25.1

