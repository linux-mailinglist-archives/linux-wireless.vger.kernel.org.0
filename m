Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4A732AC2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbjFPI7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245115AbjFPI7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:33 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C19B3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 01:59:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 94FEB46CE6;
        Fri, 16 Jun 2023 11:59:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JxYhO6BDda60-c1bc4oze;
        Fri, 16 Jun 2023 11:59:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686905969;
        bh=1wvENBxA8VswZHAaBnplUEQ2iUEh8rnnKZDg4wG/l7M=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=M9DSATKEKZLQQ/8wDSkJ9kIhtOwaSU+A5N5jjk3FSjMKkId3epxb0M0bx9LNA7U0n
         7L4XfP05wlSyjnqNNxS5ngQ+IVkDrEb/ta2qcfG/d/qaT2+Z9Tfb8/f9k217I3IvAs
         B05hm/202BQHjT9GTYmdaVqOFT9QelV26R20QSbo=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v3] wifi: rtw88: remove unused USB bulkout size set
Date:   Fri, 16 Jun 2023 11:59:17 +0300
Message-Id: <20230616085917.60662-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616085917.60662-1-dmantipov@yandex.ru>
References: <20230616085917.60662-1-dmantipov@yandex.ru>
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

Drop no longer used 'bulkout_size' of 'struct rtw_usb'
and related macros from usb.h, but preserve sanity check
in 'rtw_usb_parse()'. This follows commit 462c8db6a011
("wifi: rtw88: usb: drop now unnecessary URB size check").

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 5 -----
 drivers/net/wireless/realtek/rtw88/usb.h | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 6862338b1d51..40e614f58349 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -186,13 +186,8 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
 	switch (usbd->speed) {
 	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
-		rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
-		break;
 	case USB_SPEED_HIGH:
-		rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
-		break;
 	case USB_SPEED_SUPER:
-		rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
 		break;
 	default:
 		rtw_err(rtwdev, "failed to detect usb speed\n");
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
2.40.1

