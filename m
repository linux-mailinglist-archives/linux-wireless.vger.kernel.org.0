Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8A354222
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhDEMlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235651AbhDEMlJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9362C613A9;
        Mon,  5 Apr 2021 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626463;
        bh=sAzbDRGBF0P9UO61PnCIiMh4UYURzBH4AHMv2rDgbys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmoYZ9rWWZPL4eQuMQ6YNji1FJ2AxJv6x/VVYAN49zB9Z/4bLSP+m8FE4pFHJJ2mW
         8YdMv8MFdaLSTR+MBeB/THJgudMDLx58vrhK6RojJtuqR8F9pOVgfkYU95G3n+F4Op
         aksxGWaI5zeZPX0rva52zwBBa2ehwSVUeFPfwVazahnHV1jLHm9drtPAO/Mewwlpl/
         wWUkb6JGI2s0OlMAsVzwFw3v69XlQ9xNCKrJelD/vomFEGIscK1pw9yqqxZpp2GqB5
         zVakfQ/nwza/smJA5RBjkhUjAfb61KKGZAqmsQQ32ndfC49El/TMfK4EXD+f/W3Ygn
         vZXXrhgFVQ/YQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 8/8] mt76: mt7921: add dumping Tx power table
Date:   Mon,  5 Apr 2021 14:40:32 +0200
Message-Id: <7046f040d5ba6410820b12e2ef9a6e8d514d6d7e.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617625912.git.lorenzo@kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
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
index c397adb817f2..11bee1972534 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -561,6 +561,7 @@ enum {
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
index 9283f9865ad5..0ae0a22ca966 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1325,3 +1325,26 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
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
index 5cedefc41416..ad5c5f51ee19 100644
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
@@ -348,4 +378,5 @@ int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
 				 bool enable);
 void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
+int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
 #endif
-- 
2.30.2

