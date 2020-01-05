Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB81307F2
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAEMXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMXG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:23:06 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFC0215A4;
        Sun,  5 Jan 2020 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226986;
        bh=/reuDa2D8elOVkRq0En+vuwI5Yg7j8ixrHM5ooHsBHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKUFiEx4XK7HC5FuUTlSpA4IAWRo0bNqXqKNfDOMB70rK3orTbl/PQgVlIyGECAfV
         choSIZ2X7SEE8u3fzS6obC4zLuF3d9EaLm5mERWSUEMHZ7A5UbXyioDr2M+Kt794kp
         vk7DHHyouOzbV9MqFkYSzs1zVCAkIglGjYMcsLeg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 17/18] mt76: mt76u: add endpoint to mt76u_bulk_msg signature
Date:   Sun,  5 Jan 2020 13:21:55 +0100
Message-Id: <652a6d8e7815099738ff6f2eab6daffaaf14bb9d.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to support mt7663u usb dongles

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c | 9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 69211472d8fb..e7b86712f574 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -870,7 +870,7 @@ static inline u8 q2ep(u8 qid)
 
 static inline int
 mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
-	       int timeout)
+	       int timeout, int ep)
 {
 	struct usb_interface *uintf = to_usb_interface(dev->dev);
 	struct usb_device *udev = interface_to_usbdev(uintf);
@@ -878,9 +878,9 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
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
2.21.1

