Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4256C14DE4C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 17:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgA3QBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 11:01:24 -0500
Received: from nbd.name ([46.4.11.11]:33372 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3QBX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SnYQ1FO0AhHfcSnQsmJ+YJML7qQiMtvdGTgDIu4qCX0=; b=bpH10Ff3eUeee9N79iwTrbzY6h
        n+t/dIN88Q/ASrMBZZtAU1hS7ehdU01Y7T+1eB9pOSgQONA0WTJ65Fbewq2ioepanNFixYjMx4RFL
        ZaImihPsbPSHOdVXBudtZqtcnOtW1mXGG40HH/cw1r4wrwtYBp4YgdYG0mwNQwKzf4DY=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixCFt-0006qS-U7
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 17:01:22 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 52C547AE5A02; Thu, 30 Jan 2020 17:01:21 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7615: report firmware log event messages
Date:   Thu, 30 Jan 2020 17:01:21 +0100
Message-Id: <20200130160121.14714-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130160121.14714-1-nbd@nbd.name>
References: <20200130160121.14714-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Useful for debugging firmware issues. Can be turned on via the "fw_debug"
debugfs file

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 28 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 39 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 4 files changed, 70 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 783f145b7d02..158c0c183e9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -71,6 +71,33 @@ mt7615_dbdc_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_dbdc, mt7615_dbdc_get,
 			 mt7615_dbdc_set, "%lld\n");
 
+static int
+mt7615_fw_debug_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	if (!mt7615_wait_for_mcu_init(dev))
+		return 0;
+
+	dev->fw_debug = val;
+	mt7615_mcu_fw_log_2_host(dev, dev->fw_debug ? 2 : 0);
+
+	return 0;
+}
+
+static int
+mt7615_fw_debug_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = dev->fw_debug;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7615_fw_debug_get,
+			 mt7615_fw_debug_set, "%lld\n");
+
 static int
 mt7615_ampdu_stat_read(struct seq_file *file, void *data)
 {
@@ -222,6 +249,7 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
 	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
 	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
+	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e43d480ed1ae..94b3c59373d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -201,6 +201,28 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 	dev->hw_pattern++;
 }
 
+static void
+mt7615_mcu_rx_log_message(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+	const char *data = (char *)&rxd[1];
+	const char *type;
+
+	switch (rxd->s2d_index) {
+	case 0:
+		type = "N9";
+		break;
+	case 2:
+		type = "CR4";
+		break;
+	default:
+		type = "unknown";
+		break;
+	}
+
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
+}
+
 static void
 mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
@@ -215,6 +237,9 @@ mt7615_mcu_rx_ext_event(struct mt7615_dev *dev, struct sk_buff *skb)
 				IEEE80211_IFACE_ITER_RESUME_ALL,
 				mt7615_mcu_csa_finish, dev);
 		break;
+	case MCU_EXT_EVENT_FW_LOG_2_HOST:
+		mt7615_mcu_rx_log_message(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -643,6 +668,19 @@ static int mt7622_load_firmware(struct mt7615_dev *dev)
 	return 0;
 }
 
+int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST,
+				   &data, sizeof(data), true);
+}
+
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
@@ -667,6 +705,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt7615_mcu_fw_log_2_host(dev, 0);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 640b00b8aa32..2fbfbdb2c53d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -195,6 +195,7 @@ enum {
 	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
 	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
 	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
+	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
 	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
 	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
 	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index b43a09894487..b4748cf079b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -169,6 +169,7 @@ struct mt7615_dev {
 
 	u8 mac_work_count;
 	bool scs_en;
+	bool fw_debug;
 
 	spinlock_t token_lock;
 	struct idr token;
@@ -308,6 +309,7 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
 		       u8 rx_sel, u8 val);
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
+int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl);
 
 static inline bool is_mt7622(struct mt76_dev *dev)
 {
-- 
2.24.0

