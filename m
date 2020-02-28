Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455CE173853
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 14:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgB1N3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 08:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgB1N3h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 08:29:37 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA9F2469D;
        Fri, 28 Feb 2020 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896576;
        bh=f8RbrseGRCEYx1Vjvw+blcmWjgiQe/rZQwvLiN/IQgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bVuBDtrmkZ1uImr71X2QjAXD6ZPf8fwzrJ4GUeiYtbybZxHaUe6t/AEVnt3e98JV
         1SzKwEtXL75T2JcB6FbqPVcHmpU1XaiPp8C1VI8vtIi4jviS59CVbVe8Y6E3aEVZZV
         Z/ts8EZMzSV4mPUz5rgwxdmapzj4UbFH186Pqws4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 2/6] mt76: mt7615: introduce mt7615_mcu_fill_msg
Date:   Fri, 28 Feb 2020 14:29:23 +0100
Message-Id: <9b64674550f709022ccfb36dbfa221f50f7127f3.1582893136.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582893136.git.lorenzo@kernel.org>
References: <cover.1582893136.git.lorenzo@kernel.org>
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
index 89f679c16a71..9975ee3b6c99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -79,22 +79,20 @@ struct mt7663_fw_buf {
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
@@ -103,7 +101,6 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 		q_idx = MT_TX_MCU_PORT_RX_FWDL;
 		pkt_fmt = MT_TX_TYPE_FW;
 	}
-
 	txd = mcu_txd->txd;
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
@@ -134,7 +131,14 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 
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
index 7bf31ac2797e..1614a0b8ecb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -376,6 +376,8 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
+void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
+			 int cmd, int *wait_seq);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.24.1

