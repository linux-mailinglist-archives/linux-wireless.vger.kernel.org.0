Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7092041B4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgFVUNk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B228C061796
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TVT3R7w1jjo5JU27R+tCzQRtDEiME6TSokZrDyZ5QZc=; b=PfsyGGWmTr2ax1k1Cu579AqV6h
        xn+lQK1q0yNBHCF3/oZy7/6vuwSfngxz8ygGAEqMRoOxVEGvAr4zRos/F/bmxhds3ukM9ybC+Lz0d
        6O5sK78otl09QpOzvLEJ69Lb2tVOqo8X7+AgjJxvITYvPIn+iXn2GolCBuZ+GXXcBhiE=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSp0-0000qE-1B
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] mt76: mt7615: add support for accessing RF registers via MCU
Date:   Mon, 22 Jun 2020 22:13:23 +0200
Message-Id: <20200622201327.94414-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622201327.94414-1-nbd@nbd.name>
References: <20200622201327.94414-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Includes debugfs files for testing it.
Will be used for testmode support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 28 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 43 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 +++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index d06afcf46d67..8bb7c64db738 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -285,6 +285,29 @@ mt7615_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7615_rf_reg_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	mt7615_rf_wr(dev, dev->debugfs_rf_wf, dev->debugfs_rf_reg, val);
+
+	return 0;
+}
+
+static int
+mt7615_rf_reg_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = mt7615_rf_rr(dev, dev->debugfs_rf_wf, dev->debugfs_rf_reg);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_reg, mt7615_rf_reg_get, mt7615_rf_reg_set,
+			 "0x%08llx\n");
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -324,6 +347,11 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
 				    mt7615_read_temperature);
 
+	debugfs_create_u32("rf_wfidx", 0600, dir, &dev->debugfs_rf_wf);
+	debugfs_create_u32("rf_regidx", 0600, dir, &dev->debugfs_rf_reg);
+	debugfs_create_file_unsafe("rf_regval", 0600, dir, dev,
+				   &fops_rf_reg);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt7615_init_debugfs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d3a8ada3b779..b4440f131925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -151,8 +151,11 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 		break;
 	default:
 		mcu_txd->cid = MCU_CMD_EXT_CID;
-		mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->ext_cid = cmd;
+		if (cmd & MCU_QUERY_PREFIX)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid = mcu_cmd;
 		mcu_txd->ext_cid_ack = 1;
 		break;
 	}
@@ -192,6 +195,10 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 		break;
+	case MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX:
+		skb_pull(skb, sizeof(*rxd));
+		ret = le32_to_cpu(*(__le32 *)&skb->data[8]);
+		break;
 	case MCU_UNI_CMD_DEV_INFO_UPDATE:
 	case MCU_UNI_CMD_BSS_INFO_UPDATE:
 	case MCU_UNI_CMD_STA_REC_UPDATE:
@@ -271,6 +278,38 @@ int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_msg_send);
 
+u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
+{
+	struct {
+		__le32 wifi_stream;
+		__le32 address;
+		__le32 data;
+	} req = {
+		.wifi_stream = cpu_to_le32(wf),
+		.address = cpu_to_le32(reg),
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76,
+				   MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX,
+				   &req, sizeof(req), true);
+}
+
+int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
+{
+	struct {
+		__le32 wifi_stream;
+		__le32 address;
+		__le32 data;
+	} req = {
+		.wifi_stream = cpu_to_le32(wf),
+		.address = cpu_to_le32(reg),
+		.data = cpu_to_le32(val),
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_REG_ACCESS, &req,
+				   sizeof(req), false);
+}
+
 static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 4f70c4de69a4..8e2be150a556 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -238,8 +238,9 @@ enum {
 #define MCU_FW_PREFIX		BIT(31)
 #define MCU_UNI_PREFIX		BIT(30)
 #define MCU_CE_PREFIX		BIT(29)
+#define MCU_QUERY_PREFIX	BIT(28)
 #define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
-				  MCU_CE_PREFIX)
+				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
 
 enum {
 	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
@@ -254,6 +255,7 @@ enum {
 };
 
 enum {
+	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
 	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
 	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
 	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 78cc2a2c31f7..6e423f45b63f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -281,6 +281,9 @@ struct mt7615_dev {
 
 	struct work_struct wtbl_work;
 	struct list_head wd_head;
+
+	u32 debugfs_rf_wf;
+	u32 debugfs_rf_reg;
 };
 
 enum tx_pkt_queue_idx {
@@ -522,6 +525,8 @@ u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			int len, bool wait_resp);
+u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg);
+int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
-- 
2.24.0

