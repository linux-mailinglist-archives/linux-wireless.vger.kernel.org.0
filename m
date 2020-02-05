Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA33153C1F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBEXxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXxY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:24 -0500
Received: from localhost.lan (unknown [151.48.147.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4585214AF;
        Wed,  5 Feb 2020 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580946804;
        bh=8S+l64tKDobTXrUFl9AX7jFbUU5HL5ycWYokXh30gJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMX4N6W8SAaAGAn48eY0QF+thmIKivF2NWdB2RIi7+PdNLBDgLES/dMrzEIzfh0Z0
         /O0p1NXJARa9njzFeM4BftjIhbpxlbBvpifugiixjIAJbRyjPDyYTqpwv8/91s1sR/
         fmYv5O3rBy0/QvBi/E0BbDCo2NgGXixOwyB4+CsI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: reuse mt76_mcu in mt76u_mcu
Date:   Thu,  6 Feb 2020 00:53:08 +0100
Message-Id: <9edce905c69623f50f64b0904e0657d1345b0ffe.1580945999.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1580945999.git.lorenzo@kernel.org>
References: <cover.1580945999.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_mcu data structure to contain common fields between
mt76u_mcu and mt76e_mcu.
Move mt76u_mcu at the beginning of mt76_usb in order to rely on mt76_mcu
to access mt76u_mcu common fields

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 41 ++++++++++---------
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  | 22 ++++++----
 drivers/net/wireless/mediatek/mt76/usb.c      |  6 ++-
 3 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0956785ad6f8..c09f929c2d31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -388,12 +388,31 @@ enum mt76u_out_ep {
 	__MT_EP_OUT_MAX,
 };
 
+struct mt76_mcu {
+	struct mutex mutex;
+	u32 msg_seq;
+
+	struct sk_buff_head res_q;
+	wait_queue_head_t wait;
+};
+
 #define MT_TX_SG_MAX_SIZE	8
 #define MT_RX_SG_MAX_SIZE	1
 #define MT_NUM_TX_ENTRIES	256
 #define MT_NUM_RX_ENTRIES	128
 #define MCU_RESP_URB_SIZE	1024
 struct mt76_usb {
+	struct mt76u_mcu {
+		struct mt76_mcu common; /* first */
+		u8 *data;
+
+		/* multiple reads */
+		struct mt76_reg_pair *rp;
+		int rp_len;
+		u32 base;
+		bool burst;
+	} mcu;
+
 	struct mutex usb_ctrl_mtx;
 	__le32 reg_val;
 	u8 *data;
@@ -406,29 +425,10 @@ struct mt76_usb {
 	u8 out_ep[__MT_EP_OUT_MAX];
 	u8 in_ep[__MT_EP_IN_MAX];
 	bool sg_en;
-
-	struct mt76u_mcu {
-		struct mutex mutex;
-		u8 *data;
-		u32 msg_seq;
-
-		/* multiple reads */
-		struct mt76_reg_pair *rp;
-		int rp_len;
-		u32 base;
-		bool burst;
-	} mcu;
 };
 
 struct mt76_mmio {
-	struct mt76e_mcu {
-		struct mutex mutex;
-
-		wait_queue_head_t wait;
-		struct sk_buff_head res_q;
-
-		u32 msg_seq;
-	} mcu;
+	struct mt76_mcu mcu;
 	void __iomem *regs;
 	spinlock_t irq_lock;
 	u32 irqmask;
@@ -561,6 +561,7 @@ struct mt76_dev {
 	union {
 		struct mt76_mmio mmio;
 		struct mt76_usb usb;
+		struct mt76_mcu mcu;
 	};
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index c58282baee46..5055fea3a382 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -84,17 +84,18 @@ __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			int cmd, bool wait_resp)
 {
 	struct mt76_usb *usb = &dev->usb;
-	int ret;
+	struct mt76_mcu *mcu = &usb->mcu.common;
 	u8 seq = 0;
 	u32 info;
+	int ret;
 
 	if (test_bit(MT76_REMOVED, &dev->phy.state))
 		return 0;
 
 	if (wait_resp) {
-		seq = ++usb->mcu.msg_seq & 0xf;
+		seq = ++mcu->msg_seq & 0xf;
 		if (!seq)
-			seq = ++usb->mcu.msg_seq & 0xf;
+			seq = ++mcu->msg_seq & 0xf;
 	}
 
 	info = FIELD_PREP(MT_MCU_MSG_CMD_SEQ, seq) |
@@ -122,6 +123,7 @@ mt76x02u_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 		      int len, bool wait_resp)
 {
 	struct mt76_usb *usb = &dev->usb;
+	struct mt76_mcu *mcu = &usb->mcu.common;
 	struct sk_buff *skb;
 	int err;
 
@@ -129,9 +131,9 @@ mt76x02u_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&mcu->mutex);
 	err = __mt76x02u_mcu_send_msg(dev, skb, cmd, wait_resp);
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&mcu->mutex);
 
 	return err;
 }
@@ -148,6 +150,7 @@ mt76x02u_mcu_wr_rp(struct mt76_dev *dev, u32 base,
 	const int CMD_RANDOM_WRITE = 12;
 	const int max_vals_per_cmd = MT_INBAND_PACKET_MAX_LEN / 8;
 	struct mt76_usb *usb = &dev->usb;
+	struct mt76_mcu *mcu = &usb->mcu.common;
 	struct sk_buff *skb;
 	int cnt, i, ret;
 
@@ -166,9 +169,9 @@ mt76x02u_mcu_wr_rp(struct mt76_dev *dev, u32 base,
 		skb_put_le32(skb, data[i].value);
 	}
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&mcu->mutex);
 	ret = __mt76x02u_mcu_send_msg(dev, skb, CMD_RANDOM_WRITE, cnt == n);
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&mcu->mutex);
 	if (ret)
 		return ret;
 
@@ -182,6 +185,7 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 	const int CMD_RANDOM_READ = 10;
 	const int max_vals_per_cmd = MT_INBAND_PACKET_MAX_LEN / 8;
 	struct mt76_usb *usb = &dev->usb;
+	struct mt76_mcu *mcu = &usb->mcu.common;
 	struct sk_buff *skb;
 	int cnt, i, ret;
 
@@ -202,7 +206,7 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 		skb_put_le32(skb, data[i].value);
 	}
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&mcu->mutex);
 
 	usb->mcu.rp = data;
 	usb->mcu.rp_len = n;
@@ -213,7 +217,7 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 
 	usb->mcu.rp = NULL;
 
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&mcu->mutex);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 981d8a985557..5510baa22ff2 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1150,6 +1150,7 @@ int mt76u_init(struct mt76_dev *dev,
 	};
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
+	struct mt76_mcu *mcu = &usb->mcu.common;
 
 	mt76u_ops.rr = ext ? mt76u_rr_ext : mt76u_rr;
 	mt76u_ops.wr = ext ? mt76u_wr_ext : mt76u_wr;
@@ -1167,13 +1168,16 @@ int mt76u_init(struct mt76_dev *dev,
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
 	if (usb->data_len < 32)
 		usb->data_len = 32;
+
 	usb->data = devm_kmalloc(dev->dev, usb->data_len, GFP_KERNEL);
 	if (!usb->data) {
 		mt76u_deinit(dev);
 		return -ENOMEM;
 	}
 
-	mutex_init(&usb->mcu.mutex);
+	skb_queue_head_init(&mcu->res_q);
+	init_waitqueue_head(&mcu->wait);
+	mutex_init(&mcu->mutex);
 
 	mutex_init(&usb->usb_ctrl_mtx);
 	dev->bus = &mt76u_ops;
-- 
2.21.1

