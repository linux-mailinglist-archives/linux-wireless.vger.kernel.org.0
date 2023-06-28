Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383F4740B23
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjF1IWh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 04:22:37 -0400
Received: from forward205a.mail.yandex.net ([178.154.239.88]:38352 "EHLO
        forward205a.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbjF1IPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 04:15:14 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
        by forward205a.mail.yandex.net (Yandex) with ESMTP id 23DE34745A
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 10:24:20 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id EE8CE46CF9;
        Wed, 28 Jun 2023 10:24:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uNGuVj7DSKo0-LJF64G3N;
        Wed, 28 Jun 2023 10:24:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687937042;
        bh=HdDXaLqdKzcHjh2GGd4U0FU2gMsRbrQ0pExRQqozsxU=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Y5TWeMlXMYokuWT6qS1nle+vqFU2dT34OH+qZKZDPdhbAnwGKA0q85BAzN91LIglq
         89xLm0VNrvXG0XRPGC0pDnH4K1RO99JPfLKIj9YLgfhx4Ol8hIG9uirNEcdJ1EhJCD
         lQH+N+qFQY9S4f9OcO3CEYAbQ121DkaBiTV4alpA=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] [v6] wifi: rtw88: remove unused USB bulkout size set
Date:   Wed, 28 Jun 2023 10:23:17 +0300
Message-ID: <20230628072327.167196-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628072327.167196-1-dmantipov@yandex.ru>
References: <20230628072327.167196-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop no longer used 'bulkout_size' of 'struct rtw_usb' as well
as related macros from usb.h and leftovers in 'rtw_usb_parse()'.
This follows commit 462c8db6a011 ("wifi: rtw88: usb: drop
now unnecessary URB size check").

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: adjust to match series
v5: adjust to match recent changes
v4: remove all bulkout size leftovers (Ping-Ke Shih, Sascha Hauer)
---
 drivers/net/wireless/realtek/rtw88/usb.c | 17 -----------------
 drivers/net/wireless/realtek/rtw88/usb.h |  5 -----
 2 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 0458ab02a89f..91ed6d10ba8a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -142,7 +142,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 	struct usb_host_interface *host_interface = &interface->altsetting[0];
 	struct usb_interface_descriptor *interface_desc = &host_interface->desc;
 	struct usb_endpoint_descriptor *endpoint;
-	struct usb_device *usbd = interface_to_usbdev(interface);
 	int num_out_pipes = 0;
 	int i;
 	u8 num;
@@ -184,22 +183,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 		}
 	}
 
-	switch (usbd->speed) {
-	case USB_SPEED_LOW:
-	case USB_SPEED_FULL:
-		rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
-		break;
-	case USB_SPEED_HIGH:
-		rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
-		break;
-	case USB_SPEED_SUPER:
-		rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
-		break;
-	default:
-		rtw_err(rtwdev, "failed to detect usb speed\n");
-		return -EINVAL;
-	}
-
 	rtwdev->hci.bulkout_num = num_out_pipes;
 
 	if (num_out_pipes < 1 || num_out_pipes > 4) {
diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
index fad998005ec8..86697a5c0103 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.h
+++ b/drivers/net/wireless/realtek/rtw88/usb.h
@@ -18,10 +18,6 @@
 
 #define RTW_USB_VENQT_CMD_IDX		0x00
 
-#define RTW_USB_SUPER_SPEED_BULK_SIZE	1024
-#define RTW_USB_HIGH_SPEED_BULK_SIZE	512
-#define RTW_USB_FULL_SPEED_BULK_SIZE	64
-
 #define RTW_USB_TX_SEL_HQ		BIT(0)
 #define RTW_USB_TX_SEL_LQ		BIT(1)
 #define RTW_USB_TX_SEL_NQ		BIT(2)
@@ -73,7 +69,6 @@ struct rtw_usb {
 	__le32 *usb_data;
 	unsigned int usb_data_index;
 
-	u32 bulkout_size;
 	u8 pipe_interrupt;
 	u8 pipe_in;
 	u8 out_ep[RTW_USB_EP_MAX];
-- 
2.41.0

