Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC6128D6E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLVKeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKeE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:34:04 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256492084D;
        Sun, 22 Dec 2019 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010844;
        bh=phIxcRwveQMibTPDXYbguCaRDtPWN9jvdY8t28NGf5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjWdD32GXwAiY6KXOWqBvdiGm8CpAUpyhRVLLBJQYOn5+oG9RSNOxkF5zw9TdeaqM
         JVpm+e0RahMCshxQcErr2d9RiTjKWtaXqNP4ygUGOdGLfJh/LcdnOEPeZvX11ta9KS
         T80C3skclMV0rgiuKtpaaFI3WeooiCXBb3rR4PdQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 17/18] mt76: mt76u: add endpoint to mt76u_bulk_msg signature
Date:   Sun, 22 Dec 2019 11:33:19 +0100
Message-Id: <35baa3de03d0357cb762de3ef676efea5b560478.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to support mt7663u usb dongles

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c | 9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b47cc3c2fa0a..fa5518bd76c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -869,7 +869,7 @@ static inline u8 q2ep(u8 qid)
 
 static inline int
 mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
-	       int timeout)
+	       int timeout, int ep)
 {
 	struct usb_interface *uintf = to_usb_interface(dev->dev);
 	struct usb_device *udev = interface_to_usbdev(uintf);
@@ -877,9 +877,9 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	unsigned int pipe;
 
 	if (actual_len)
-		pipe = usb_rcvbulkpipe(udev, usb->in_ep[MT_EP_IN_CMD_RESP]);
+		pipe = usb_rcvbulkpipe(udev, usb->in_ep[ep]);
 	else
-		pipe = usb_sndbulkpipe(udev, usb->out_ep[MT_EP_OUT_INBAND_CMD]);
+		pipe = usb_sndbulkpipe(udev, usb->out_ep[ep]);
 
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index 106ff4b3e6ff..c58282baee46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -55,7 +55,8 @@ static int mt76x02u_mcu_wait_resp(struct mt76_dev *dev, u8 seq)
 	u32 rxfce;
 
 	for (i = 0; i < 5; i++) {
-		ret = mt76u_bulk_msg(dev, data, MCU_RESP_URB_SIZE, &len, 300);
+		ret = mt76u_bulk_msg(dev, data, MCU_RESP_URB_SIZE, &len,
+				     300, MT_EP_IN_CMD_RESP);
 		if (ret == -ETIMEDOUT)
 			continue;
 		if (ret)
@@ -103,7 +104,8 @@ __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	ret = mt76u_bulk_msg(dev, skb->data, skb->len, NULL, 500);
+	ret = mt76u_bulk_msg(dev, skb->data, skb->len, NULL, 500,
+			     MT_EP_OUT_INBAND_CMD);
 	if (ret)
 		return ret;
 
@@ -248,7 +250,8 @@ __mt76x02u_mcu_fw_send_data(struct mt76x02_dev *dev, u8 *data,
 
 	data_len = MT_CMD_HDR_LEN + len + sizeof(info);
 
-	err = mt76u_bulk_msg(&dev->mt76, data, data_len, NULL, 1000);
+	err = mt76u_bulk_msg(&dev->mt76, data, data_len, NULL, 1000,
+			     MT_EP_OUT_INBAND_CMD);
 	if (err) {
 		dev_err(dev->mt76.dev, "firmware upload failed: %d\n", err);
 		return err;
-- 
2.24.1

