Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD746E8CC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhLINKj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhLINKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0BC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 05:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EB50CE2557
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32516C004DD;
        Thu,  9 Dec 2021 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055220;
        bh=V/Q5wjkAyHzyKLKTJxK1w7QNQfi7sp8+7Zt9XYv0cqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0qkTYjsC8eKWrSyAoOTP34W8WC1GJrsa45LKZHUfXE8eAs1LqKs7CJs0FX/qEwFM
         kqvRKtBQw+pbKYWicwSm3FKUuFwipLu2WJHWIbFJ5KIqRR0bpiT9eA/CJ3C0dE3sv5
         +qVxrAzzf/7Asji5wdzBRza7Bk4E1Pc/LFd/XEyD+DX1nNRsDAHsGRfX1lJ7ICUaKn
         QrEZMN6Su3+w3xLpBOFf7wEZZMh3AUjxflt6GuEV1KkyxD74WpjubimXBLwilqpO5K
         +B0bQwXuNC1IJo/tPjkT6HmqLzvliZHnClU/gNQ+v47RV54Th0pXygR+pMsQ7MgUU6
         bh5wI0N9/9xEQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 6/7] mt76: connac: rely on MCU_CMD macro
Date:   Thu,  9 Dec 2021 14:06:28 +0100
Message-Id: <bfce763d628e738d825f97ae7f1f46179d12ab36.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, rely on MCU_CMD macro and do not command
definitions directly

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 12 ++++++------
 .../net/wireless/mediatek/mt76/mt7615/usb_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 10 +++++-----
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c |  2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 58be537adb1f..3a6fa6c8d471 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -106,7 +106,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
 
-	if (cmd != MCU_CMD_FW_SCATTER) {
+	if (cmd != MCU_CMD(FW_SCATTER)) {
 		q_idx = MT_TX_MCU_PORT_RX_Q0;
 		pkt_fmt = MT_TX_TYPE_CMD;
 	} else {
@@ -173,7 +173,7 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
 	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
@@ -1377,7 +1377,7 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 
 int mt7615_mcu_restart(struct mt76_dev *dev)
 {
-	return mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL, 0, true);
+	return mt76_mcu_send_msg(dev, MCU_CMD(RESTART_DL_REQ), NULL, 0, true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_restart);
 
@@ -1423,7 +1423,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		goto out;
 	}
 
-	ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+	ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 				     fw->data + sizeof(*hdr), len);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
@@ -1486,7 +1486,7 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 			return err;
 		}
 
-		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					     data + offset, len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
@@ -1734,7 +1734,7 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 			goto out;
 		}
 
-		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					     fw->data + offset, len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send firmware\n");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 028ff432d811..0ebb4c3c336a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -21,7 +21,7 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	int ret, ep, len, pad;
 
 	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
-	if (cmd != MCU_CMD_FW_SCATTER)
+	if (cmd != MCU_CMD(FW_SCATTER))
 		ep = MT_EP_OUT_INBAND_CMD;
 	else
 		ep = MT_EP_OUT_AC_BE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 71896e56256e..93480f448d85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -13,8 +13,8 @@ int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
 		.addr = cpu_to_le32(addr),
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_FW_START_REQ, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_CMD(FW_START_REQ), &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_firmware);
 
@@ -27,8 +27,8 @@ int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get)
 		.op = cpu_to_le32(op),
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_PATCH_SEM_CONTROL, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(dev, MCU_CMD(PATCH_SEM_CONTROL),
+				 &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_patch_sem_ctrl);
 
@@ -41,8 +41,8 @@ int mt76_connac_mcu_start_patch(struct mt76_dev *dev)
 		.check_crc = 0,
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_PATCH_FINISH_REQ, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(dev, MCU_CMD(PATCH_FINISH_REQ),
+				 &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_patch);
 
@@ -64,9 +64,9 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 
 	if (is_mt7921(dev) &&
 	    (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000))
-		cmd = MCU_CMD_PATCH_START_REQ;
+		cmd = MCU_CMD(PATCH_START_REQ);
 	else
-		cmd = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+		cmd = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
 
 	return mt76_mcu_send_msg(dev, cmd, &req, sizeof(req), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index da77e4697c9f..c4a8fe31197d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -179,7 +179,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
 	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
@@ -237,7 +237,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	if (cmd == MCU_CMD_FW_SCATTER)
+	if (cmd == MCU_CMD(FW_SCATTER))
 		goto exit;
 
 	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
@@ -592,7 +592,7 @@ int mt7921_mcu_restart(struct mt76_dev *dev)
 		.power_mode = 1,
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
+	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
 				 sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_restart);
@@ -698,7 +698,7 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 			goto out;
 		}
 
-		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+		ret = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					       dl, len, max_len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
@@ -783,7 +783,7 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 			return err;
 		}
 
-		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+		err = __mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					       data + offset, len, max_len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 7b34c7f2ab3a..a020352122a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -30,7 +30,7 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (cmd == MCU_CMD_FW_SCATTER)
+	if (cmd == MCU_CMD(FW_SCATTER))
 		txq = MT_MCUQ_FWDL;
 
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 437cddad9a90..d20f2ff01be1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -33,7 +33,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (cmd == MCU_CMD_FW_SCATTER)
+	if (cmd == MCU_CMD(FW_SCATTER))
 		type = MT7921_SDIO_FWDL;
 
 	mt7921_skb_add_sdio_hdr(skb, type);
-- 
2.31.1

