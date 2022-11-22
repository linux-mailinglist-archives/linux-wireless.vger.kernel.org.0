Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF063377F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiKVIwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKVIwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA22F00B
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:04 -0800 (PST)
X-UUID: 2823b4249646437fb48f3983e64670bb-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9C6acqONXDmgqPwAJculx9Re4XjiOziwGNvHPbZeXuM=;
        b=ePKJZuIIRh7/40Ya1qVf/bae3BeBZEF89Jtr4xV0+0oynDiIYyn5Jtc7LSOha39dp1MxxyIEOS0o1LQx5idSGITLNnhAeewK2fTHWXqgyVVFGwK4nf0s4epvLyTeyvqQfvNy+LDAOU1MWt9/cQlYgyWZFCejq4WqEyH4NdV+Cz0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:8ba818aa-b841-4380-aaf4-35fd008a22ca,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.13,REQID:8ba818aa-b841-4380-aaf4-35fd008a22ca,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:d12e911,CLOUDID:dd367b2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221122165202L33PTLSL,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2823b4249646437fb48f3983e64670bb-20221122
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1569209857; Tue, 22 Nov 2022 16:52:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 7/9] wifi: mt76: mt7996: add debugfs support
Date:   Tue, 22 Nov 2022 16:45:52 +0800
Message-ID: <20221122084554.9494-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
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

(Split the big patch into smaller intermediate patches by functionality
for easier review. Refer to the cover letter for more info.)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 851 ++++++++++++++++++
 1 file changed, 851 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c

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
-- 
2.25.1

