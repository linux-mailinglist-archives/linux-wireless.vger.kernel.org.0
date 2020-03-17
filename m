Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66CD188AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCQQmR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:17 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B78420735;
        Tue, 17 Mar 2020 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463336;
        bh=6qufdRdAO/GVF/xteQddJRK47BzgysXE3imF6JTA2ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaBKPqjN5R3XIgnYg9TzXggCdLN3G2cwLuAhPmUPhp7Qi3aP7utS3DxhU1NNX+htG
         /71KHnCpFCvj1pemnTqHd1yfMiYIsjstkyNNEk7c9MSLv5xVYJKrkxh9zrtgz72u2P
         3we7yiY+Qpl88/Sqva8KPl8XphFVwnJbTPsLXzBM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 13/25] mt76: mt7615: introduce MCU_FW_PREFIX for fw mcu commands
Date:   Tue, 17 Mar 2020 17:41:20 +0100
Message-Id: <659a7e5be19f1a209145f00b3a049965b3beb502.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently fw commands rely on negative cmds since they need different
mcu msg metadata. Extend this approach introducing MCU_FW_PREFIX.
This is a preliminary patch to support new mt7663e firmware commands

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 25 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 15 ++++++-----
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 1c26e2c3e476..4ce3d248182c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -52,6 +52,7 @@ struct mt7615_fw_trailer {
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq)
 {
+	int mcu_cmd = cmd & MCU_CMD_MASK;
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
 	__le32 *txd;
@@ -63,7 +64,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 
 	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
 
-	if (cmd != -MCU_CMD_FW_SCATTER) {
+	if (cmd != MCU_CMD_FW_SCATTER) {
 		q_idx = MT_TX_MCU_PORT_RX_Q0;
 		pkt_fmt = MT_TX_TYPE_CMD;
 	} else {
@@ -87,9 +88,9 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
 
-	if (cmd < 0) {
+	if (cmd & MCU_FW_PREFIX) {
 		mcu_txd->set_query = MCU_Q_NA;
-		mcu_txd->cid = -cmd;
+		mcu_txd->cid = mcu_cmd;
 	} else {
 		mcu_txd->cid = MCU_CMD_EXT_CID;
 		mcu_txd->set_query = MCU_Q_SET;
@@ -127,7 +128,7 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 		return -EAGAIN;
 
 	switch (cmd) {
-	case -MCU_CMD_PATCH_SEM_CONTROL:
+	case MCU_CMD_PATCH_SEM_CONTROL:
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
 		break;
@@ -152,8 +153,8 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 	while (true) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
 		if (!skb) {
-			dev_err(dev->mt76.dev, "Message %d (seq %d) timeout\n",
-				cmd, seq);
+			dev_err(dev->mt76.dev, "Message %ld (seq %d) timeout\n",
+				cmd & MCU_CMD_MASK, seq);
 			return -ETIMEDOUT;
 		}
 
@@ -308,7 +309,7 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 		.mode = cpu_to_le32(mode),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TARGET_ADDRESS_LEN_REQ,
 				   &req, sizeof(req), true);
 }
 
@@ -1101,7 +1102,7 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 		cur_len = min_t(int, 4096 - sizeof(struct mt7615_mcu_txd),
 				len);
 
-		ret = __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER,
+		ret = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_SCATTER,
 					  data, cur_len, false);
 		if (ret)
 			break;
@@ -1127,13 +1128,13 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 		.addr = cpu_to_le32(addr),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ,
 				   &req, sizeof(req), true);
 }
 
 static int mt7615_mcu_restart(struct mt76_dev *dev)
 {
-	return __mt76_mcu_send_msg(dev, -MCU_CMD_RESTART_DL_REQ, NULL,
+	return __mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL,
 				   0, true);
 }
 
@@ -1145,7 +1146,7 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_SEM_CONTROL,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL,
 				   &req, sizeof(req), true);
 }
 
@@ -1158,7 +1159,7 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 		.check_crc = 0,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_FINISH_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ,
 				   &req, sizeof(req), true);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index c84695facf08..8ae08a2bf10d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -179,16 +179,19 @@ enum {
 	MCU_S2D_H2CN
 };
 
+#define MCU_FW_PREFIX		BIT(31)
+#define MCU_CMD_MASK		~MCU_FW_PREFIX
+
 enum {
-	MCU_CMD_TARGET_ADDRESS_LEN_REQ = 0x01,
-	MCU_CMD_FW_START_REQ = 0x02,
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
+	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
 	MCU_CMD_INIT_ACCESS_REG = 0x3,
 	MCU_CMD_PATCH_START_REQ = 0x05,
-	MCU_CMD_PATCH_FINISH_REQ = 0x07,
-	MCU_CMD_PATCH_SEM_CONTROL = 0x10,
+	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
 	MCU_CMD_EXT_CID = 0xED,
-	MCU_CMD_FW_SCATTER = 0xEE,
-	MCU_CMD_RESTART_DL_REQ = 0xEF,
+	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
+	MCU_CMD_RESTART_DL_REQ = MCU_FW_PREFIX | 0xEF,
 };
 
 enum {
-- 
2.25.1

