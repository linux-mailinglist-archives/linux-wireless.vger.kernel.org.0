Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A532613F8C2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgAPQxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 11:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgAPQxp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCEB20730;
        Thu, 16 Jan 2020 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193625;
        bh=YxgnhOYDbT7KSEZFo5YqdsGUEpgMB64qZI0ItoJFqAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqTd2bRLA5uYhIELYykjEdLBjucIndSVIo3vxcbhxHaitjisG9Rr3kYsSI3MKMTJA
         DIZMS+D9tNB2KIBEZ2sfjxkZfralqMzAN3SJlNPBszq7UpC2g1wJJwvZ87a7Fr07WR
         JrSWNADo4CRwDeQqHMW+kmMcFn1YTdxAxs955by0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Zero_Chaos <sidhayn@gmail.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 159/205] mt76: mt76u: rely on usb_interface instead of usb_dev
Date:   Thu, 16 Jan 2020 11:42:14 -0500
Message-Id: <20200116164300.6705-159-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 80df01f4dc79abbed724bbe0851cab3fe8ad9d99 ]

usb drivers are supposed to communicate using usb_interface instead
mt76x{0,2}u is now registering through usb_device. Fix it by passing
usb_intf device to mt76_alloc_device routine.

Fixes: 112f980ac8926 ("mt76usb: use usb_dev private data")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-By: Zero_Chaos <sidhayn@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c        | 12 +++++++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8aec7ccf2d79..e8605ae6f8a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -799,7 +799,8 @@ static inline int
 mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	       int timeout)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	struct mt76_usb *usb = &dev->usb;
 	unsigned int pipe;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 00a445d27599..65d404e61404 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -226,7 +226,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	u32 mac_rev;
 	int ret;
 
-	mdev = mt76_alloc_device(&usb_dev->dev, sizeof(*dev), &mt76x0u_ops,
+	mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), &mt76x0u_ops,
 				 &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index da5e0f9a8bae..8b26c6108186 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -39,7 +39,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	struct mt76_dev *mdev;
 	int err;
 
-	mdev = mt76_alloc_device(&udev->dev, sizeof(*dev), &mt76x2u_ops,
+	mdev = mt76_alloc_device(&intf->dev, sizeof(*dev), &mt76x2u_ops,
 				 &drv_ops);
 	if (!mdev)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 20c6fe510e9d..05aa42bd9808 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -20,7 +20,8 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 				  u8 req_type, u16 val, u16 offset,
 				  void *buf, size_t len)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	unsigned int pipe;
 	int i, ret;
 
@@ -235,7 +236,8 @@ mt76u_rd_rp(struct mt76_dev *dev, u32 base,
 
 static bool mt76u_check_sg(struct mt76_dev *dev)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 
 	return (!disable_usb_sg && udev->bus->sg_tablesize > 0 &&
 		(udev->bus->no_sg_constraint ||
@@ -370,7 +372,8 @@ mt76u_fill_bulk_urb(struct mt76_dev *dev, int dir, int index,
 		    struct urb *urb, usb_complete_t complete_fn,
 		    void *context)
 {
-	struct usb_device *udev = to_usb_device(dev->dev);
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
 	unsigned int pipe;
 
 	if (dir == USB_DIR_IN)
@@ -952,6 +955,7 @@ int mt76u_init(struct mt76_dev *dev,
 		.rd_rp = mt76u_rd_rp,
 		.type = MT76_BUS_USB,
 	};
+	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
 
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
@@ -965,6 +969,8 @@ int mt76u_init(struct mt76_dev *dev,
 	dev->bus = &mt76u_ops;
 	dev->queue_ops = &usb_queue_ops;
 
+	dev_set_drvdata(&udev->dev, dev);
+
 	usb->sg_en = mt76u_check_sg(dev);
 
 	return mt76u_set_endpoints(intf, usb);
-- 
2.20.1

