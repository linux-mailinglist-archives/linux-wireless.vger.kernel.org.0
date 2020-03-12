Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2189F1835B5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgCLQCu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgCLQCt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:02:49 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05AC206F1;
        Thu, 12 Mar 2020 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028969;
        bh=LofA1Tf4Ojn05zW6aYLjcW0ajhRVAKo3O13PT84eo0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dEZl0yCFVSI31eHGIhqQ5ECv8Rq7Bb4h5+ay2fTpysmAVJMcsveXrGOLBglPVQwK
         +icia5+a0dvQlqtIWDbXhTYVZDk4M7kaWyF0SLPCMhiGXdBJwKcC/Zk0za1b289Wg0
         CmCaOY6ed5AICpRKFAELWXv9zjsW4IzCj7z+bS50=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 01/25] mt76: mt7615: introduce mt7615_mcu_fill_msg
Date:   Thu, 12 Mar 2020 17:02:11 +0100
Message-Id: <a7216e3375c7019017bbab507238f2cffa76ab49.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_fill_msg routine to initialize mcu messages.
mt7615_mcu_fill_msg will be reused adding mt7663u support

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 20 +++++++++++--------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b51a3cb247c9..71b209fe439f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -49,22 +49,20 @@ struct mt7615_fw_trailer {
 #define FW_START_OVERRIDE		BIT(0)
 #define FW_START_WORKING_PDA_CR4	BIT(2)
 
-static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-				 int cmd, int *wait_seq)
+void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
+			 int cmd, int *wait_seq)
 {
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
-	enum mt76_txq_id qid;
-	u32 val;
 	__le32 *txd;
+	u32 val;
 
 	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb,
-		   sizeof(struct mt7615_mcu_txd));
-	memset(mcu_txd, 0, sizeof(struct mt7615_mcu_txd));
+	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
+	memset(mcu_txd, 0, sizeof(*mcu_txd));
 
 	if (cmd != -MCU_CMD_FW_SCATTER) {
 		q_idx = MT_TX_MCU_PORT_RX_Q0;
@@ -73,7 +71,6 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 		q_idx = MT_TX_MCU_PORT_RX_FWDL;
 		pkt_fmt = MT_TX_TYPE_FW;
 	}
-
 	txd = mcu_txd->txd;
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
@@ -104,7 +101,14 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
 	if (wait_seq)
 		*wait_seq = seq;
+}
+
+static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
+				 int cmd, int *wait_seq)
+{
+	enum mt76_txq_id qid;
 
+	mt7615_mcu_fill_msg(dev, skb, cmd, wait_seq);
 	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 		qid = MT_TXQ_MCU;
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 68c4f1683204..2b7cee4da519 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -364,6 +364,8 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
+void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
+			 int cmd, int *wait_seq);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.24.1

