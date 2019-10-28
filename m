Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B271E74F6
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 16:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfJ1PV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 11:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfJ1PV7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 11:21:59 -0400
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259D821721;
        Mon, 28 Oct 2019 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572276117;
        bh=gmj9O84K9V8bIQhh+r26OJS8qU4+6hDM/k1gb5e6/JU=;
        h=From:To:Cc:Subject:Date:From;
        b=c0ul+afipgAy/S+NltT73MYRVyTjEJLkVQIPA9JbMF5f2nbEmpHdq3USk+AaZqilj
         t5YFwqWLQmYyqFRyg5H3QYUpfr1Mck8OhpgwB/KTyDx1aNPoxo3YznElxoa6oubUcz
         SaXA79Vcq8IdeAOvtchhFOCij3DUpU7y4WX6OX3g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com, ZeroBeat@gmx.de, sidhayn@gmail.com
Subject: [PATCH] mt76: mt76u: rely on usb_interface instead of usb_dev
Date:   Mon, 28 Oct 2019 16:21:41 +0100
Message-Id: <0851d8f413ed0086a2734c06e6e4c203b63cd017.1572275706.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

usb drivers are supposed to communicate using usb_interface instead
mt76x{0,2}u is now registering through usb_device. Fix it by passing
usb_intf device to mt76_alloc_device routine.

Fixes: 112f980ac8926 ("mt76usb: use usb_dev private data")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c        | 12 +++++++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8bcc7f21e83c..ccbc05d8e96d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -806,7 +806,8 @@ static inline int
 mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	       int timeout)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	struct mt76_usb *usb = &dev->usb;
 	unsigned int pipe;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index ade6312c7367..b9fd41433106 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -221,7 +221,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	u32 mac_rev;
 	int ret;
 
-	mdev = mt76_alloc_device(&usb_dev->dev, sizeof(*dev), &mt76x0u_ops,
+	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), &mt76x0u_ops,
 				 &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index e6d778456e5e..48b9017813b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -41,7 +41,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	struct mt76_dev *mdev;
 	int err;
 
-	mdev = mt76_alloc_device(&udev->dev, sizeof(*dev), &mt76x2u_ops,
+	mdev = mt76_alloc_device(&intf->dev, sizeof(*dev), &mt76x2u_ops,
 				 &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index cac058fc41ef..be19038ea7dd 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -19,7 +19,8 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 				  u8 req_type, u16 val, u16 offset,
 				  void *buf, size_t len)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	unsigned int pipe;
 	int i, ret;
 
@@ -234,7 +235,8 @@ mt76u_rd_rp(struct mt76_dev *dev, u32 base,
 
 static bool mt76u_check_sg(struct mt76_dev *dev)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 
 	return (!disable_usb_sg && udev->bus->sg_tablesize > 0 &&
 		(udev->bus->no_sg_constraint ||
@@ -369,7 +371,8 @@ mt76u_fill_bulk_urb(struct mt76_dev *dev, int dir, int index,
 		    struct urb *urb, usb_complete_t complete_fn,
 		    void *context)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	unsigned int pipe;
 
 	if (dir == USB_DIR_IN)
@@ -951,6 +954,7 @@ int mt76u_init(struct mt76_dev *dev,
 		.rd_rp = mt76u_rd_rp,
 		.type = MT76_BUS_USB,
 	};
+	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
 
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
@@ -964,6 +968,8 @@ int mt76u_init(struct mt76_dev *dev,
 	dev->bus = &mt76u_ops;
 	dev->queue_ops = &usb_queue_ops;
 
+	dev_set_drvdata(&udev->dev, dev);
+
 	usb->sg_en = mt76u_check_sg(dev);
 
 	return mt76u_set_endpoints(intf, usb);
-- 
2.21.0

