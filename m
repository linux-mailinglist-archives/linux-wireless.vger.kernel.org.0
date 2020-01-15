Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10FC13BDEC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgAOK7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:53 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD06324671;
        Wed, 15 Jan 2020 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085991;
        bh=EsVgRJwB7SUf9NfCy74rIjm0PrIxPNmaQ9hqe+C+8do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYv91SgpT8at+SjFa8JdVfbW66Te+dZ/Yky5VZs0EJKaxhx3Oip0NT36TUTkmEQov
         krq1yfnbyZG1F16t1JKu2NasYRWxl7WjMRO8itNzGqJPM4p7kf2x3P7HX18A/aNL+s
         fajJUm3C7JpJBoGMlanI1nbpNfDdZj8FGQs6mA8A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 14/18] mt76: mt76u: add {read/write}_extended utility routines
Date:   Wed, 15 Jan 2020 11:58:54 +0100
Message-Id: <f0c1025b8288e4e2bd80cb9943458004a9e96bd9.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce extended utility routines to read/write data o usb bus. New
devices (e.g. mt7663u) will rely on both upper and lower part of the
register address. Add ext parameter to mt76u_init signature in order to
reuse the code adding mt7663u support.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   6 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 142 ++++++++++++++----
 4 files changed, 123 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d58d76e31a84..a30b994e98de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -359,12 +359,15 @@ struct mt76_rate_power {
 enum mt_vendor_req {
 	MT_VEND_DEV_MODE =	0x1,
 	MT_VEND_WRITE =		0x2,
+	MT_VEND_POWER_ON =	0x4,
 	MT_VEND_MULTI_WRITE =	0x6,
 	MT_VEND_MULTI_READ =	0x7,
 	MT_VEND_READ_EEPROM =	0x9,
 	MT_VEND_WRITE_FCE =	0x42,
 	MT_VEND_WRITE_CFG =	0x46,
 	MT_VEND_READ_CFG =	0x47,
+	MT_VEND_READ_EXT =	0x63,
+	MT_VEND_WRITE_EXT =	0x66,
 };
 
 enum mt76u_in_ep {
@@ -887,8 +890,9 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 void *buf, size_t len);
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
-int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
 void mt76u_deinit(struct mt76_dev *dev);
+int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
+	       bool ext);
 int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
 int mt76u_alloc_queues(struct mt76_dev *dev);
 void mt76u_stop_tx(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 78ceb14fe5d3..4505d39381d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -246,7 +246,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	usb_set_intfdata(usb_intf, dev);
 
 	mt76x02u_init_mcu(mdev);
-	ret = mt76u_init(mdev, usb_intf);
+	ret = mt76u_init(mdev, usb_intf, false);
 	if (ret)
 		goto err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 2c07063eadfe..eafa283ca699 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -54,7 +54,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	mt76x02u_init_mcu(mdev);
-	err = mt76u_init(mdev, intf);
+	err = mt76u_init(mdev, intf, false);
 	if (err < 0)
 		goto err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 4e0a115c6fd2..6b31a7a99072 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -62,12 +62,25 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 }
 EXPORT_SYMBOL_GPL(mt76u_vendor_request);
 
-static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
+static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u32 addr)
 {
 	struct mt76_usb *usb = &dev->usb;
 	u32 data = ~0;
-	u16 offset;
 	int ret;
+
+	ret = __mt76u_vendor_request(dev, req,
+				     USB_DIR_IN | USB_TYPE_VENDOR,
+				     addr >> 16, addr, &usb->reg_val,
+				     sizeof(__le32));
+	if (ret == sizeof(__le32))
+		data = le32_to_cpu(usb->reg_val);
+	trace_usb_reg_rr(dev, addr, data);
+
+	return data;
+}
+
+static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
+{
 	u8 req;
 
 	switch (addr & MT_VEND_TYPE_MASK) {
@@ -81,16 +94,8 @@ static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
 		req = MT_VEND_MULTI_READ;
 		break;
 	}
-	offset = addr & ~MT_VEND_TYPE_MASK;
 
-	ret = __mt76u_vendor_request(dev, req,
-				     USB_DIR_IN | USB_TYPE_VENDOR,
-				     0, offset, &usb->reg_val, sizeof(__le32));
-	if (ret == sizeof(__le32))
-		data = le32_to_cpu(usb->reg_val);
-	trace_usb_reg_rr(dev, addr, data);
-
-	return data;
+	return ___mt76u_rr(dev, req, addr & ~MT_VEND_TYPE_MASK);
 }
 
 static u32 mt76u_rr(struct mt76_dev *dev, u32 addr)
@@ -104,10 +109,32 @@ static u32 mt76u_rr(struct mt76_dev *dev, u32 addr)
 	return ret;
 }
 
-static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
+static u32 mt76u_rr_ext(struct mt76_dev *dev, u32 addr)
+{
+	u32 ret;
+
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT, addr);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return ret;
+}
+
+static void ___mt76u_wr(struct mt76_dev *dev, u8 req,
+			u32 addr, u32 val)
 {
 	struct mt76_usb *usb = &dev->usb;
-	u16 offset;
+
+	usb->reg_val = cpu_to_le32(val);
+	__mt76u_vendor_request(dev, req,
+			       USB_DIR_OUT | USB_TYPE_VENDOR,
+			       addr >> 16, addr, &usb->reg_val,
+			       sizeof(__le32));
+	trace_usb_reg_wr(dev, addr, val);
+}
+
+static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
+{
 	u8 req;
 
 	switch (addr & MT_VEND_TYPE_MASK) {
@@ -118,13 +145,7 @@ static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 		req = MT_VEND_MULTI_WRITE;
 		break;
 	}
-	offset = addr & ~MT_VEND_TYPE_MASK;
-
-	usb->reg_val = cpu_to_le32(val);
-	__mt76u_vendor_request(dev, req,
-			       USB_DIR_OUT | USB_TYPE_VENDOR, 0,
-			       offset, &usb->reg_val, sizeof(__le32));
-	trace_usb_reg_wr(dev, addr, val);
+	___mt76u_wr(dev, req, addr & ~MT_VEND_TYPE_MASK, val);
 }
 
 static void mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
@@ -134,6 +155,13 @@ static void mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 }
 
+static void mt76u_wr_ext(struct mt76_dev *dev, u32 addr, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+}
+
 static u32 mt76u_rmw(struct mt76_dev *dev, u32 addr,
 		     u32 mask, u32 val)
 {
@@ -145,6 +173,17 @@ static u32 mt76u_rmw(struct mt76_dev *dev, u32 addr,
 	return val;
 }
 
+static u32 mt76u_rmw_ext(struct mt76_dev *dev, u32 addr,
+			 u32 mask, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT, addr) & ~mask;
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return val;
+}
+
 static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 		       const void *data, int len)
 {
@@ -177,6 +216,55 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
 
+static void mt76u_copy_ext(struct mt76_dev *dev, u32 offset,
+			   const void *data, int len)
+{
+	struct mt76_usb *usb = &dev->usb;
+	int ret, i = 0, batch_len;
+	const u8 *val = data;
+
+	len = round_up(len, 4);
+	mutex_lock(&usb->usb_ctrl_mtx);
+	while (i < len) {
+		batch_len = min_t(int, usb->data_len, len - i);
+		memcpy(usb->data, val + i, batch_len);
+		ret = __mt76u_vendor_request(dev, MT_VEND_WRITE_EXT,
+					     USB_DIR_OUT | USB_TYPE_VENDOR,
+					     (offset + i) >> 16, offset + i,
+					     usb->data, batch_len);
+		if (ret < 0)
+			break;
+
+		i += batch_len;
+	}
+	mutex_unlock(&usb->usb_ctrl_mtx);
+}
+
+static void
+mt76u_read_copy_ext(struct mt76_dev *dev, u32 offset,
+		    void *data, int len)
+{
+	struct mt76_usb *usb = &dev->usb;
+	int i = 0, batch_len, ret;
+	u8 *val = data;
+
+	len = round_up(len, 4);
+	mutex_lock(&usb->usb_ctrl_mtx);
+	while (i < len) {
+		batch_len = min_t(int, usb->data_len, len - i);
+		ret = __mt76u_vendor_request(dev, MT_VEND_READ_EXT,
+					     USB_DIR_IN | USB_TYPE_VENDOR,
+					     (offset + i) >> 16, offset + i,
+					     usb->data, batch_len);
+		if (ret < 0)
+			break;
+
+		memcpy(val + i, usb->data, batch_len);
+		i += batch_len;
+	}
+	mutex_unlock(&usb->usb_ctrl_mtx);
+}
+
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val)
 {
@@ -1008,13 +1096,10 @@ void mt76u_deinit(struct mt76_dev *dev)
 EXPORT_SYMBOL_GPL(mt76u_deinit);
 
 int mt76u_init(struct mt76_dev *dev,
-	       struct usb_interface *intf)
+	       struct usb_interface *intf, bool ext)
 {
-	static const struct mt76_bus_ops mt76u_ops = {
-		.rr = mt76u_rr,
-		.wr = mt76u_wr,
-		.rmw = mt76u_rmw,
-		.write_copy = mt76u_copy,
+	static struct mt76_bus_ops mt76u_ops = {
+		.read_copy = mt76u_read_copy_ext,
 		.wr_rp = mt76u_wr_rp,
 		.rd_rp = mt76u_rd_rp,
 		.type = MT76_BUS_USB,
@@ -1022,6 +1107,11 @@ int mt76u_init(struct mt76_dev *dev,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
 
+	mt76u_ops.rr = ext ? mt76u_rr_ext : mt76u_rr;
+	mt76u_ops.wr = ext ? mt76u_wr_ext : mt76u_wr;
+	mt76u_ops.rmw = ext ? mt76u_rmw_ext : mt76u_rmw;
+	mt76u_ops.write_copy = ext ? mt76u_copy_ext : mt76u_copy;
+
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
 	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
-- 
2.21.1

