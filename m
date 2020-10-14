Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6702228DE3C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Oct 2020 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgJNKEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Oct 2020 06:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgJNKEL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Oct 2020 06:04:11 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D412080A;
        Wed, 14 Oct 2020 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602669850;
        bh=wHGlbIwIV9+GcJVMXDlkV+U5R95WsALgYH7wSwY+B1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=XnxzJV1gDNiIz5kUGA0fkc06kpHTpuqIu40+w0cz8qtBhPBIeuwgJuwcoOS5VEAbB
         jP+j2JplA8vN6vB1e+ltC3ylqV48CnoMiZtf6mQ2JUWQfb7Uf+6lgIvXZJ47JTfJ0z
         eY4+LM8HWfWvrcgBASsofPk1Zic3H3uuxt5NcKdk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: move mt76_mcu_send_firmware in common module
Date:   Wed, 14 Oct 2020 12:03:58 +0200
Message-Id: <5efb4c7388e85db119c3cfbc8826f714793c636e.1602669770.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_mcu_send_firmware routine in common code since it is actually
shared between mt7615, mt7663, mt7603 and mt7915 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c      | 23 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 24 ++------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 ++++---------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 28 +++-------------
 5 files changed, 37 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 76dadef7ccfe..30a6515758a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -105,3 +105,26 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_skb_send_and_get_msg);
+
+int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+			   int len)
+{
+	int err, cur_len;
+
+	while (len > 0) {
+		cur_len = min_t(int, 4096 - dev->mcu_ops->headroom, len);
+
+		err = mt76_mcu_send_msg(dev, cmd, data, cur_len, false);
+		if (err)
+			return err;
+
+		data += cur_len;
+		len -= cur_len;
+
+		if (dev->queue_ops->tx_cleanup)
+			dev->queue_ops->tx_cleanup(dev, MT_TXQ_FWDL, false);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_mcu_send_firmware);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 639ef7b5c2c3..64683eff76fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1076,6 +1076,8 @@ int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
 			      int len, bool wait_resp, struct sk_buff **ret);
 int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 				  int cmd, bool wait_resp, struct sk_buff **ret);
+int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+			   int len);
 static inline int
 mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data, int len,
 		  bool wait_resp)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index b2ccfe6772ce..9e6c8e1b7ea5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -93,27 +93,6 @@ mt7603_mcu_init_download(struct mt7603_dev *dev, u32 addr, u32 len)
 				 &req, sizeof(req), true);
 }
 
-static int
-mt7603_mcu_send_firmware(struct mt7603_dev *dev, const void *data, int len)
-{
-	int cur_len, ret = 0;
-
-	while (len > 0) {
-		cur_len = min_t(int, 4096 - sizeof(struct mt7603_mcu_txd),
-				len);
-
-		ret = mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER, data,
-					cur_len, false);
-		if (ret)
-			break;
-
-		data += cur_len;
-		len -= cur_len;
-	}
-
-	return ret;
-}
-
 static int
 mt7603_mcu_start_firmware(struct mt7603_dev *dev, u32 addr)
 {
@@ -200,7 +179,8 @@ static int mt7603_load_firmware(struct mt7603_dev *dev)
 		goto out;
 	}
 
-	ret = mt7603_mcu_send_firmware(dev, fw->data, dl_len);
+	ret = mt76_mcu_send_firmware(&dev->mt76, -MCU_CMD_FW_SCATTER,
+				     fw->data, dl_len);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2b17bd1c2a32..8a74775f9ff0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1872,29 +1872,6 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
-static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
-				    int len)
-{
-	int ret = 0, cur_len;
-
-	while (len > 0) {
-		cur_len = min_t(int, 4096 - dev->mt76.mcu_ops->headroom, len);
-
-		ret = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_SCATTER, data,
-					cur_len, false);
-		if (ret)
-			break;
-
-		data += cur_len;
-		len -= cur_len;
-
-		if (mt76_is_mmio(&dev->mt76))
-			mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
-	}
-
-	return ret;
-}
-
 static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 				     u32 option)
 {
@@ -1981,7 +1958,8 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		goto out;
 	}
 
-	ret = mt7615_mcu_send_firmware(dev, fw->data + sizeof(*hdr), len);
+	ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+				     fw->data + sizeof(*hdr), len);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
 		goto out;
@@ -2041,7 +2019,8 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 			return err;
 		}
 
-		err = mt7615_mcu_send_firmware(dev, data + offset, len);
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     data + offset, len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware to device\n");
 			return err;
@@ -2282,7 +2261,8 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 			goto out;
 		}
 
-		ret = mt7615_mcu_send_firmware(dev, fw->data + offset, len);
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     fw->data + offset, len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send firmware\n");
 			goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ce2357550015..1a630e5e4ba1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2486,28 +2486,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
 
-static int mt7915_mcu_send_firmware(struct mt7915_dev *dev, const void *data,
-				    int len)
-{
-	int ret = 0, cur_len;
-
-	while (len > 0) {
-		cur_len = min_t(int, 4096 - sizeof(struct mt7915_mcu_txd),
-				len);
-
-		ret = mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER, data,
-					cur_len, false);
-		if (ret)
-			break;
-
-		data += cur_len;
-		len -= cur_len;
-		mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
-	}
-
-	return ret;
-}
-
 static int mt7915_mcu_start_firmware(struct mt7915_dev *dev, u32 addr,
 				     u32 option)
 {
@@ -2653,7 +2631,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 			goto out;
 		}
 
-		ret = mt7915_mcu_send_firmware(dev, dl, len);
+		ret = mt76_mcu_send_firmware(&dev->mt76, -MCU_CMD_FW_SCATTER,
+					     dl, len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
 			goto out;
@@ -2721,7 +2700,8 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 			return err;
 		}
 
-		err = mt7915_mcu_send_firmware(dev, data + offset, len);
+		err = mt76_mcu_send_firmware(&dev->mt76, -MCU_CMD_FW_SCATTER,
+					     data + offset, len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
 			return err;
-- 
2.26.2

