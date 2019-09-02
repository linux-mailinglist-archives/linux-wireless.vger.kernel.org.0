Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88133A56AA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfIBMwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 08:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbfIBMwD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 08:52:03 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F31216C8;
        Mon,  2 Sep 2019 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567428722;
        bh=RSIPoR3IeaFtNEemZm13mviViif2fJNbf7NDXlvDx/A=;
        h=From:To:Cc:Subject:Date:From;
        b=aKzXiZ3JjZA7K1aHNy7qHowwLLuCXpqsit5jNWNJZhQrSNZbXaNZQ4HBRAYWuHZhA
         x1DQactct4W2l4D1iWjJNVB6SIetkVOzmcmtbBNOSKHnPz2aLEAM2mYCiEbsKAuyFt
         2AP2EZ9ON4lLOHkpa7yuWl0Ttf1By+ncUv3Me0JQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: add support to read temperature from mcu
Date:   Mon,  2 Sep 2019 14:51:54 +0200
Message-Id: <1388cf9a392606db7705ca45511e899c84e113e0.1567427903.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce debugfs entry to read device temperature and related cmu
command. Introduce mt7615_mcu_parse_response to parse mcu response
messages and refactor mt7615_mcu_msg_send routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 14 +++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 54 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index e62a5eb1bf53..2428a4659a1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -49,6 +49,18 @@ mt7615_radio_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int mt7615_read_temperature(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+	int temp;
+
+	/* cpu */
+	temp = mt7615_mcu_get_temperature(dev, 0);
+	seq_printf(s, "Temperature: %d\n", temp);
+
+	return 0;
+}
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -72,6 +84,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 			   &dev->radar_pattern.power);
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
 			    &fops_radar_pattern);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
+				    mt7615_read_temperature);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 51554af5aa2d..275d5eaed3b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -112,13 +112,39 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
 }
 
+static int
+mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7615_mcu_rxd *rxd = (struct mt7615_mcu_rxd *)skb->data;
+	int ret = 0;
+
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case -MCU_CMD_PATCH_SEM_CONTROL:
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+		break;
+	case MCU_EXT_CMD_GET_TEMP:
+		skb_pull(skb, sizeof(*rxd));
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
 static int
 mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		    int len, bool wait_resp)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	unsigned long expires = jiffies + 10 * HZ;
-	struct mt7615_mcu_rxd *rxd;
 	struct sk_buff *skb;
 	int ret, seq;
 
@@ -141,16 +167,9 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			break;
 		}
 
-		rxd = (struct mt7615_mcu_rxd *)skb->data;
-		if (seq != rxd->seq)
-			continue;
-
-		if (cmd == -MCU_CMD_PATCH_SEM_CONTROL) {
-			skb_pull(skb, sizeof(*rxd) - 4);
-			ret = *skb->data;
-		}
-		dev_kfree_skb(skb);
-		break;
+		ret = mt7615_mcu_parse_response(dev, cmd, skb, seq);
+		if (ret != -EAGAIN)
+			break;
 	}
 
 out:
@@ -1574,3 +1593,16 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &wtbl_req, sizeof(wtbl_req), true);
 }
+
+int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
+{
+	struct {
+		u8 action;
+		u8 rsv[3];
+	} req = {
+		.action = index,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
+				   sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index d4d08fa59349..1fd7dffa6eef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -98,6 +98,7 @@ enum {
 	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
 	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
 	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
+	MCU_EXT_CMD_GET_TEMP = 0x2c,
 	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
 	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a79f4ffcb70f..cef3fd43cb00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -246,6 +246,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_init_mac(struct mt7615_dev *dev);
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter);
+int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 int mt7615_mcu_set_tx_power(struct mt7615_dev *dev);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 
-- 
2.21.0

