Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3322D17D6B4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCHWJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCHWJk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:40 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB162083E;
        Sun,  8 Mar 2020 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705379;
        bh=52y2x5H0lix5N4OacHXxNPB/4QL9ffOqbHlJRPuA5Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOXBHK+EWn9U+NZqDsXlOjYHLSAA2JIUwLBAft1xzkkSRaFYy3sg+Zn8JsKEM8WMX
         wz0kKTMIctDnpl99T7S+LPWNQyMy7hA/zztswGHGSSCx4jkz4k5g/WcFrQZJOxSWqa
         wnj5SFgOBVj0qCC7u7lUacZI5uBRrs5X7YDWlbis=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 20/25] mt76: mt7615: introduce uni cmd command types
Date:   Sun,  8 Mar 2020 23:08:32 +0100
Message-Id: <bd84d4fea33bf72adb0f754ba90167f796ba3519.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mcu uni command type. Uni commands rely on a stripped verions
of mt7615_mcu_txd data strutture. Split mt7615_mcu_txd_common and
mt7615_mcu_txd. Uni commands will be use by mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h | 9 ++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e73cd3cb014a..73c68ce871a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -52,7 +52,8 @@ struct mt7615_fw_trailer {
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq)
 {
-	int mcu_cmd = cmd & MCU_CMD_MASK;
+	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	bool uni_cmd = cmd & MCU_UNI_PREFIX;
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
 	__le32 *txd;
@@ -62,7 +63,8 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
+	txd_len = uni_cmd ? sizeof(*mcu_txd) - 20 : sizeof(*mcu_txd);
+	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb, txd_len);
 
 	if (cmd != MCU_CMD_FW_SCATTER) {
 		q_idx = MT_TX_MCU_PORT_RX_Q0;
@@ -91,6 +93,9 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	if (cmd & MCU_FW_PREFIX) {
 		mcu_txd->set_query = MCU_Q_NA;
 		mcu_txd->cid = mcu_cmd;
+	} else if (uni_cmd) {
+		mcu_txd->ext_cid_ack = MCU_CMD_UNI_EXT_ACK;
+		mcu_txd->cid = mcu_cmd;
 	} else {
 		mcu_txd->cid = MCU_CMD_EXT_CID;
 		mcu_txd->set_query = MCU_Q_SET;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 8ae08a2bf10d..bdbc5d9567cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -180,7 +180,8 @@ enum {
 };
 
 #define MCU_FW_PREFIX		BIT(31)
-#define MCU_CMD_MASK		~MCU_FW_PREFIX
+#define MCU_UNI_PREFIX		BIT(30)
+#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX)
 
 enum {
 	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
@@ -217,6 +218,12 @@ enum {
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
 
+#define MCU_CMD_ACK		BIT(0)
+#define MCU_CMD_UNI		BIT(1)
+#define MCU_CMD_QUERY		BIT(2)
+
+#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
+
 enum {
 	PATCH_SEM_RELEASE = 0x0,
 	PATCH_SEM_GET	  = 0x1
-- 
2.24.1

