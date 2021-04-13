Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1978235DAB4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbhDMJJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244480AbhDMJJ2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:09:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54217613B6;
        Tue, 13 Apr 2021 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618304949;
        bh=qsz0wGM2ihjdhhrpX6OJ+KFengIv2Q1WFB8f/HKAsW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXTmLFi9/ACdyVhTqXIQ6U0fUXt9hRxHx7SaFfDtFTAzc6zjbQKZXVmwejvdU0kh3
         NxSxxwt/eAIxO1PcEZyk3tOEmQnxSPl2xLlcT72xn90bUHoGfTKwZLqRsoeX6TGJiv
         OnWk079Z28Fp3XcH+E5S4SfhiYAa7yFcrqPsCy4AoH5S20fFIrsVyJTrJEZ532kmwe
         l0u+uxjgZMXtgOKqmGQFJhjiP7Zwp4QqYQoz5X+fEIjTXRLS3vuaqOaQOY6pOZDPyf
         rgZLcrrgYVrZ4Oda/62lU1o1wz1hkMd1FrV6YMzUm93GlTPyqFuJpH71gxN/1F/eUY
         CnhoFFPIL1N0w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v3 7/7] mt76: mt7921: add dumping Tx power table
Date:   Tue, 13 Apr 2021 11:08:41 +0200
Message-Id: <f72dbecf13e0d5d8f452b88b6d55c3ebc074d128.1618304559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618304559.git.lorenzo@kernel.org>
References: <cover.1618304559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Dump the tx power table saved in offload firmware.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 79 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 23 ++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 17 ++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 31 ++++++++
 5 files changed, 151 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 01c458e14dc7..c056eca6816a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -564,6 +564,7 @@ enum {
 	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
 	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
 	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
+	MCU_CMD_GET_TXPWR = MCU_CE_PREFIX | 0xd0,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index b2e8d698e019..024524173115 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -158,6 +158,83 @@ mt7921_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static void
+mt7921_seq_puts_array(struct seq_file *file, const char *str,
+		      s8 *val, int len)
+{
+	int i;
+
+	seq_printf(file, "%-16s:", str);
+	for (i = 0; i < len; i++)
+		if (val[i] == 127)
+			seq_printf(file, " %6s", "N.A");
+		else
+			seq_printf(file, " %6d", val[i]);
+	seq_puts(file, "\n");
+}
+
+#define mt7921_print_txpwr_entry(prefix, rate)				\
+({									\
+	mt7921_seq_puts_array(s, #prefix " (user)",			\
+			      txpwr.data[TXPWR_USER].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_USER].rate)); \
+	mt7921_seq_puts_array(s, #prefix " (eeprom)",			\
+			      txpwr.data[TXPWR_EEPROM].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_EEPROM].rate)); \
+	mt7921_seq_puts_array(s, #prefix " (tmac)",			\
+			      txpwr.data[TXPWR_MAC].rate,		\
+			      ARRAY_SIZE(txpwr.data[TXPWR_MAC].rate));	\
+})
+
+static int
+mt7921_txpwr(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt7921_txpwr txpwr;
+	int ret;
+
+	ret = mt7921_get_txpwr_info(dev, &txpwr);
+	if (ret)
+		return ret;
+
+	seq_printf(s, "Tx power table (channel %d)\n", txpwr.ch);
+	seq_printf(s, "%-16s  %6s %6s %6s %6s\n",
+		   " ", "1m", "2m", "5m", "11m");
+	mt7921_print_txpwr_entry(CCK, cck);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "6m", "9m", "12m", "18m", "24m", "36m",
+		   "48m", "54m");
+	mt7921_print_txpwr_entry(OFDM, ofdm);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7");
+	mt7921_print_txpwr_entry(HT20, ht20);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs32");
+	mt7921_print_txpwr_entry(HT40, ht40);
+
+	seq_printf(s, "%-16s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s\n",
+		   " ", "mcs0", "mcs1", "mcs2", "mcs3", "mcs4", "mcs5",
+		   "mcs6", "mcs7", "mcs8", "mcs9", "mcs10", "mcs11");
+	mt7921_print_txpwr_entry(VHT20, vht20);
+	mt7921_print_txpwr_entry(VHT40, vht40);
+	mt7921_print_txpwr_entry(VHT80, vht80);
+	mt7921_print_txpwr_entry(VHT160, vht160);
+	mt7921_print_txpwr_entry(HE26, he26);
+	mt7921_print_txpwr_entry(HE52, he52);
+	mt7921_print_txpwr_entry(HE106, he106);
+	mt7921_print_txpwr_entry(HE242, he242);
+	mt7921_print_txpwr_entry(HE484, he484);
+	mt7921_print_txpwr_entry(HE996, he996);
+	mt7921_print_txpwr_entry(HE996x2, he996x2);
+
+	return 0;
+}
+
 static int
 mt7921_pm_set(void *data, u64 val)
 {
@@ -237,6 +314,8 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 				    mt7921_queues_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7921_queues_acq);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
+				    mt7921_txpwr);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index b233b12860ef..b5cee20c5f27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1358,3 +1358,26 @@ int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
 				     true);
 }
+
+int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
+{
+	struct mt7921_txpwr_event *event;
+	struct mt7921_txpwr_req req = {
+		.dbdc_idx = 0,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_TXPWR,
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	event = (struct mt7921_txpwr_event *)skb->data;
+	WARN_ON(skb->len != le16_to_cpu(event->len));
+	memcpy(txpwr, &event->txpwr, sizeof(event->txpwr));
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index af8b42983a00..d980e92028ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -85,6 +85,7 @@ enum {
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
 	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_DBG_MSG = 0x27,
+	MCU_EVENT_TXPWR = 0xd0,
 	MCU_EVENT_COREDUMP = 0xf0,
 };
 
@@ -389,4 +390,20 @@ struct mt7921_mcu_wlan_info {
 	__le32 wlan_idx;
 	struct mt7921_mcu_wlan_info_event event;
 } __packed;
+
+struct mt7921_txpwr_req {
+	u8 ver;
+	u8 action;
+	__le16 len;
+	u8 dbdc_idx;
+	u8 rsv[3];
+} __packed;
+
+struct mt7921_txpwr_event {
+	u8 ver;
+	u8 action;
+	__le16 len;
+	struct mt7921_txpwr txpwr;
+} __packed;
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index e3d83d3d954c..5cc01efee989 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -172,6 +172,36 @@ struct mt7921_dev {
 	struct mt76_connac_coredump coredump;
 };
 
+enum {
+	TXPWR_USER,
+	TXPWR_EEPROM,
+	TXPWR_MAC,
+	TXPWR_MAX_NUM,
+};
+
+struct mt7921_txpwr {
+	u8 ch;
+	u8 rsv[3];
+	struct {
+		u8 ch;
+		u8 cck[4];
+		u8 ofdm[8];
+		u8 ht20[8];
+		u8 ht40[9];
+		u8 vht20[12];
+		u8 vht40[12];
+		u8 vht80[12];
+		u8 vht160[12];
+		u8 he26[12];
+		u8 he52[12];
+		u8 he106[12];
+		u8 he242[12];
+		u8 he484[12];
+		u8 he996[12];
+		u8 he996x2[12];
+	} data[TXPWR_MAX_NUM];
+};
+
 enum {
 	MT_LMAC_AC00,
 	MT_LMAC_AC01,
@@ -352,4 +382,5 @@ int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
+int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
 #endif
-- 
2.30.2

