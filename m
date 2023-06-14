Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD70972F497
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbjFNGTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 02:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbjFNGSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 02:18:49 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B21739
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 23:18:48 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id DBDA8600DC;
        Wed, 14 Jun 2023 09:18:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZIU6oK2DVa60-cVfY5Q7M;
        Wed, 14 Jun 2023 09:18:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686723526;
        bh=UO6cBaVlAhrhVAeqWV4LJGoKhOtjuy4yV2frEdteu6o=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=v65qefVTIyvZv7y6bqrwE38AuSq8A9hStp0/xqym7W+ZyQhDxsF2qgKdBcrtmR6Ep
         rmVqwhDnyPbeTUgsPfkxrGhwjxuT3pCXgLa2nnRVgD0OyVXB9U/FMntB+xZezzMV3A
         TPDmQxmVZDjMIU8/T2Y4VqylJtPfEbRASOPWLOak=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v3] wifi: rtlwifi: cleanup USB interface
Date:   Wed, 14 Jun 2023 09:18:32 +0300
Message-Id: <20230614061832.40882-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614061832.40882-1-dmantipov@yandex.ru>
References: <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
 <20230614061832.40882-1-dmantipov@yandex.ru>
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

Drop unused '_usb_writen_sync()' and relevant pointer
from 'struct rtl_io', handle possible write error in
'_usb_write_async()', adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: readjust to new series and keep pr_{info,err}() things (Kalle Valo)
---
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 31 ++++-----------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  2 --
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 96207b237bf0..30bf2775a335 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -164,13 +164,17 @@ static void _usb_write_async(struct usb_device *udev, u32 addr, u32 val,
 	u16 wvalue;
 	u16 index;
 	__le32 data;
+	int ret;
 
 	request = REALTEK_USB_VENQT_CMD_REQ;
 	index = REALTEK_USB_VENQT_CMD_IDX; /* n/a */
 	wvalue = (u16)(addr&0x0000ffff);
 	data = cpu_to_le32(val);
-	_usbctrl_vendorreq_async_write(udev, request, wvalue, index, &data,
-				       len);
+
+	ret = _usbctrl_vendorreq_async_write(udev, request, wvalue,
+					     index, &data, len);
+	if (ret < 0)
+		dev_err(&udev->dev, "error %d writing at 0x%x\n", ret, addr);
 }
 
 static void _usb_write8_async(struct rtl_priv *rtlpriv, u32 addr, u8 val)
@@ -194,28 +198,6 @@ static void _usb_write32_async(struct rtl_priv *rtlpriv, u32 addr, u32 val)
 	_usb_write_async(to_usb_device(dev), addr, val, 4);
 }
 
-static void _usb_writen_sync(struct rtl_priv *rtlpriv, u32 addr, void *data,
-			     u16 len)
-{
-	struct device *dev = rtlpriv->io.dev;
-	struct usb_device *udev = to_usb_device(dev);
-	u8 request = REALTEK_USB_VENQT_CMD_REQ;
-	u8 reqtype =  REALTEK_USB_VENQT_WRITE;
-	u16 wvalue;
-	u16 index = REALTEK_USB_VENQT_CMD_IDX;
-	int pipe = usb_sndctrlpipe(udev, 0); /* write_out */
-	u8 *buffer;
-
-	wvalue = (u16)(addr & 0x0000ffff);
-	buffer = kmemdup(data, len, GFP_ATOMIC);
-	if (!buffer)
-		return;
-	usb_control_msg(udev, pipe, request, reqtype, wvalue,
-			index, buffer, len, 50);
-
-	kfree(buffer);
-}
-
 static void _rtl_usb_io_handler_init(struct device *dev,
 				     struct ieee80211_hw *hw)
 {
@@ -229,7 +211,6 @@ static void _rtl_usb_io_handler_init(struct device *dev,
 	rtlpriv->io.read8_sync		= _usb_read8_sync;
 	rtlpriv->io.read16_sync		= _usb_read16_sync;
 	rtlpriv->io.read32_sync		= _usb_read32_sync;
-	rtlpriv->io.writen_sync		= _usb_writen_sync;
 }
 
 static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 5b4979771dbf..2e7e04f91279 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1457,8 +1457,6 @@ struct rtl_io {
 	void (*write8_async)(struct rtl_priv *rtlpriv, u32 addr, u8 val);
 	void (*write16_async)(struct rtl_priv *rtlpriv, u32 addr, u16 val);
 	void (*write32_async)(struct rtl_priv *rtlpriv, u32 addr, u32 val);
-	void (*writen_sync)(struct rtl_priv *rtlpriv, u32 addr, void *buf,
-			    u16 len);
 
 	u8 (*read8_sync)(struct rtl_priv *rtlpriv, u32 addr);
 	u16 (*read16_sync)(struct rtl_priv *rtlpriv, u32 addr);
-- 
2.40.1

