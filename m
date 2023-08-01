Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E276B7B0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjHAOgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjHAOf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:35:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A8A1729
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:35:54 -0700 (PDT)
X-UUID: b37e41d0307811ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SgAPRGvgX3dm83yIBAUp1v6jgMWaGvCFgkl26MeFD+g=;
        b=AiRPl06hS9jqUfvvKvP2i7MFyTR63VpCvEX7ZiTj13Gg2z9tBD5S7D0z5+u2grqDsQOZ5JCZ+P2mPSK7XTNfzYJBG8u2zyMsKueSvC/tzTTu1pZVj2gXdd50OKAk01gMD5dOi17AC6O4+rvccGZYBkq0YYYubbuedieXEMRwdSs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:d5adae98-e6dd-4071-9727-b079799ceccb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:93fdc5a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: b37e41d0307811ee9cb5633481061a41-20230801
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1247306986; Tue, 01 Aug 2023 22:35:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:35:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:35:44 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 15/17] wifi: mt76: mt7925: add debugfs.c
Date:   Tue, 1 Aug 2023 22:34:31 +0800
Message-ID: <167363384a162e4b697c0d5bdf95e50a04b22a34.1690864199.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690864199.git.deren.wu@mediatek.com>
References: <cover.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/debugfs.c   | 319 ++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
new file mode 100644
index 000000000000..1e2fc6577e78
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include "mt7925.h"
+#include "mcu.h"
+
+static int
+mt7925_reg_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	u32 regval = val;
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_regval(dev, dev->mt76.debugfs_reg, &regval, true);
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7925_reg_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+	u32 regval;
+	int ret;
+
+	mt792x_mutex_acquire(dev);
+	ret = mt7925_mcu_regval(dev, dev->mt76.debugfs_reg, &regval, false);
+	mt792x_mutex_release(dev);
+	if (!ret)
+		*val = regval;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt7925_reg_get, mt7925_reg_set,
+			 "0x%08llx\n");
+static int
+mt7925_fw_debug_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+
+	mt792x_mutex_acquire(dev);
+
+	dev->fw_debug = (u8)val;
+	mt7925_mcu_fw_log_2_host(dev, dev->fw_debug);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7925_fw_debug_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->fw_debug;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7925_fw_debug_get,
+			 mt7925_fw_debug_set, "%lld\n");
+
+DEFINE_SHOW_ATTRIBUTE(mt792x_tx_stats);
+
+static void
+mt7925_seq_puts_array(struct seq_file *file, const char *str,
+		      s8 val[][2], int len, u8 band_idx)
+{
+	int i;
+
+	seq_printf(file, "%-22s:", str);
+	for (i = 0; i < len; i++)
+		if (val[i][band_idx] == 127)
+			seq_printf(file, " %6s", "N.A");
+		else
+			seq_printf(file, " %6d", val[i][band_idx]);
+	seq_puts(file, "\n");
+}
+
+#define mt7925_print_txpwr_entry(prefix, rate, idx)	\
+({							\
+	mt7925_seq_puts_array(s, #prefix " (tmac)",	\
+			      txpwr->rate,		\
+			      ARRAY_SIZE(txpwr->rate),	\
+			      idx);			\
+})
+
+static inline void
+mt7925_eht_txpwr(struct seq_file *s, struct mt7925_txpwr *txpwr, u8 band_idx)
+{
+	seq_printf(s, "%-22s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11",
+		   "mcs12", "mcs13", "mcs14", "mcs15");
+	mt7925_print_txpwr_entry(EHT26, eht26, band_idx);
+	mt7925_print_txpwr_entry(EHT52, eht52, band_idx);
+	mt7925_print_txpwr_entry(EHT106, eht106, band_idx);
+	mt7925_print_txpwr_entry(EHT242, eht242, band_idx);
+	mt7925_print_txpwr_entry(EHT484, eht484, band_idx);
+
+	mt7925_print_txpwr_entry(EHT996, eht996, band_idx);
+	mt7925_print_txpwr_entry(EHT996x2, eht996x2, band_idx);
+	mt7925_print_txpwr_entry(EHT996x4, eht996x4, band_idx);
+	mt7925_print_txpwr_entry(EHT26_52, eht26_52, band_idx);
+	mt7925_print_txpwr_entry(EHT26_106, eht26_106, band_idx);
+	mt7925_print_txpwr_entry(EHT484_242, eht484_242, band_idx);
+	mt7925_print_txpwr_entry(EHT996_484, eht996_484, band_idx);
+	mt7925_print_txpwr_entry(EHT996_484_242, eht996_484_242, band_idx);
+	mt7925_print_txpwr_entry(EHT996x2_484, eht996x2_484, band_idx);
+	mt7925_print_txpwr_entry(EHT996x3, eht996x3, band_idx);
+	mt7925_print_txpwr_entry(EHT996x3_484, eht996x3_484, band_idx);
+}
+
+static int
+mt7925_txpwr(struct seq_file *s, void *data)
+{
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
+	struct mt7925_txpwr *txpwr = NULL;
+	u8 band_idx = dev->mphy.band_idx;
+	int ret = 0;
+
+	txpwr = devm_kmalloc(dev->mt76.dev, sizeof(*txpwr), GFP_KERNEL);
+
+	if (!txpwr)
+		return -ENOMEM;
+
+	mt792x_mutex_acquire(dev);
+	ret = mt7925_get_txpwr_info(dev, band_idx, txpwr);
+	mt792x_mutex_release(dev);
+
+	if (ret)
+		goto out;
+
+	seq_printf(s, "%-22s  %6s %6s %6s %6s\n",
+		   " ", "1m", "2m", "5m", "11m");
+	mt7925_print_txpwr_entry(CCK, cck, band_idx);
+
+	seq_printf(s, "%-22s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "6m", "9m", "12m", "18m", "24m", "36m",
+		   "48m", "54m");
+	mt7925_print_txpwr_entry(OFDM, ofdm, band_idx);
+
+	seq_printf(s, "%-22s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7");
+	mt7925_print_txpwr_entry(HT20, ht20, band_idx);
+
+	seq_printf(s, "%-22s  %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs32");
+	mt7925_print_txpwr_entry(HT40, ht40, band_idx);
+
+	seq_printf(s, "%-22s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11");
+	mt7925_print_txpwr_entry(VHT20, vht20, band_idx);
+	mt7925_print_txpwr_entry(VHT40, vht40, band_idx);
+
+	mt7925_print_txpwr_entry(VHT80, vht80, band_idx);
+	mt7925_print_txpwr_entry(VHT160, vht160, band_idx);
+
+	mt7925_print_txpwr_entry(HE26, he26, band_idx);
+	mt7925_print_txpwr_entry(HE52, he52, band_idx);
+	mt7925_print_txpwr_entry(HE106, he106, band_idx);
+	mt7925_print_txpwr_entry(HE242, he242, band_idx);
+	mt7925_print_txpwr_entry(HE484, he484, band_idx);
+
+	mt7925_print_txpwr_entry(HE996, he996, band_idx);
+	mt7925_print_txpwr_entry(HE996x2, he996x2, band_idx);
+
+	mt7925_eht_txpwr(s, txpwr, band_idx);
+
+out:
+	devm_kfree(dev->mt76.dev, txpwr);
+	return ret;
+}
+
+static int
+mt7925_pm_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (val == pm->enable_user)
+		goto out;
+
+	if (!pm->enable_user) {
+		pm->stats.last_wake_event = jiffies;
+		pm->stats.last_doze_event = jiffies;
+	}
+	/* make sure the chip is awake here and ps_work is scheduled
+	 * just at end of the this routine.
+	 */
+	pm->enable = false;
+	mt76_connac_pm_wake(&dev->mphy, pm);
+
+	pm->enable_user = val;
+	mt7925_set_runtime_pm(dev);
+	mt76_connac_power_save_sched(&dev->mphy, pm);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7925_pm_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->pm.enable_user;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7925_pm_get, mt7925_pm_set, "%lld\n");
+
+static int
+mt7925_deep_sleep_set(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(dev->mphy.hw->conf.flags & IEEE80211_CONF_MONITOR);
+	bool enable = !!val;
+
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+	if (pm->ds_enable_user == enable)
+		goto out;
+
+	pm->ds_enable_user = enable;
+	pm->ds_enable = enable && !monitor;
+	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
+out:
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7925_deep_sleep_get(void *data, u64 *val)
+{
+	struct mt792x_dev *dev = data;
+
+	*val = dev->pm.ds_enable_user;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, mt7925_deep_sleep_get,
+			 mt7925_deep_sleep_set, "%lld\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt792x_pm_idle_timeout_get,
+			 mt792x_pm_idle_timeout_set, "%lld\n");
+
+static int mt7925_chip_reset(void *data, u64 val)
+{
+	struct mt792x_dev *dev = data;
+	int ret = 0;
+
+	switch (val) {
+	case 1:
+		/* Reset wifisys directly. */
+		mt792x_reset(&dev->mt76);
+		break;
+	default:
+		/* Collect the core dump before reset wifisys. */
+		mt792x_mutex_acquire(dev);
+		ret = mt7925_mcu_chip_config(dev, "assert");
+		mt792x_mutex_release(dev);
+		break;
+	}
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7925_chip_reset, "%lld\n");
+
+int mt7925_init_debugfs(struct mt792x_dev *dev)
+{
+	struct dentry *dir;
+
+	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
+	if (!dir)
+		return -ENOMEM;
+
+	if (mt76_is_mmio(&dev->mt76))
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt792x_queues_read);
+	else
+		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
+					    dir, mt76_queues_read);
+
+	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
+				    mt792x_queues_acq);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
+				    mt7925_txpwr);
+	debugfs_create_file("tx_stats", 0400, dir, dev, &mt792x_tx_stats_fops);
+	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
+	debugfs_create_file("idle-timeout", 0600, dir, dev,
+			    &fops_pm_idle_timeout);
+	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
+				    mt792x_pm_stats);
+	debugfs_create_file("deep-sleep", 0600, dir, dev, &fops_ds);
+
+	return 0;
+}
-- 
2.18.0

