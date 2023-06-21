Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80683738159
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjFUJYG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjFUJYF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:05 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D611BD3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:23:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:f15:0:640:e80a:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 2460F463C4;
        Wed, 21 Jun 2023 12:23:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FNeUOg7DXeA0-DzzDE45m;
        Wed, 21 Jun 2023 12:23:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687339399;
        bh=hQJotLizViI1WdSL8GrapSTqZyQoIhJYM90Cxw2O1e4=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=PN4Spa5pFMz2M9aOKMl8dvLccvA0/2bem4Y0/vCiZ/D582npTdZEH1HpPst+M4zcX
         5NdgC4gLsOC6+Qc8EsBhULp2ye+busR2Z8pl7a+0Z6zYhFM/zlBAkoSHxYLVu/TNDM
         3Qdepl4XLirZPLv8f/GlwSPq9aek4wXPUdzOrUO4=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v4] wifi: rtw88: remove unused USB bulkout size set
Date:   Wed, 21 Jun 2023 12:22:15 +0300
Message-ID: <20230621092313.65965-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621092313.65965-1-dmantipov@yandex.ru>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop no longer used 'bulkout_size' of 'struct rtw_usb' as well
as related macros from usb.h and leftovers in 'rtw_usb_parse()'.
This follows commit 462c8db6a011 ("wifi: rtw88: usb: drop
now unnecessary URB size check").

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: remove all bulkout size leftovers (Ping-Ke Shih, Sascha Hauer)
---
 drivers/net/wireless/realtek/rtw88/usb.c | 17 -----------------
 drivers/net/wireless/realtek/rtw88/usb.h |  5 -----
 2 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 6862338b1d51..6423140c6005 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -141,7 +141,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 	struct usb_host_interface *host_interface = &interface->altsetting[0];
 	struct usb_interface_descriptor *interface_desc = &host_interface->desc;
 	struct usb_endpoint_descriptor *endpoint;
-	struct usb_device *usbd = interface_to_usbdev(interface);
 	int num_out_pipes = 0;
 	int i;
 	u8 num;
@@ -183,22 +182,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
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

