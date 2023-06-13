Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C095E72DC4D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbjFMIXA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFMIW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:22:57 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E367AC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:22:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id D527446D1F;
        Tue, 13 Jun 2023 11:22:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iMV2e1sDg4Y0-Ah1575w4;
        Tue, 13 Jun 2023 11:22:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686644574;
        bh=dciR4s6zJ6AnonOesc8hBIzjMI07INLxe44hDaWEX7I=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=hQsrsSKM8Qb6R2sfUaSlOFnol0VcD7qCx49eGYg3Agkj0PInj9UQ7j757jlCbfA+t
         TkwbePY0jwZ1ChcuwAIkSd+jAmf5swKVQBlaMVzkMuSexn7tCdd8pGgJKAnxKczU1O
         W4GAwIOv7CJG94Wi3iVgKmTLjiCsP6G5dCG/5ca4=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: cleanup USB interface
Date:   Tue, 13 Jun 2023 11:22:29 +0300
Message-Id: <20230613082229.60869-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
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
'_usb_write_async()', use 'dev_err()' for device-specific
error messages, adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
This is intended to follow https://patchwork.kernel.org/project/linux-wireless/patch/20230608095051.116702-4-dmantipov@yandex.ru
---
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 38 ++++++---------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  2 --
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 969fb31d7985..42e33463963a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -114,8 +114,9 @@ static int _usbctrl_vendorreq_sync_read(struct usb_device *udev, u8 request,
 	} while (++vendorreq_times < MAX_USBCTRL_VENDORREQ_TIMES);
 
 	if (status < 0 && count++ < 4)
-		pr_err("reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x\n",
-		       value, status, *(u32 *)pdata);
+		dev_err(&udev->dev,
+			"timeout reading 0x%x: status:0x%x value=0x%x\n",
+			value, status, *(u32 *)pdata);
 	return status;
 }
 
@@ -164,13 +165,17 @@ static void _usb_write_async(struct usb_device *udev, u32 addr, u32 val,
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
@@ -194,28 +199,6 @@ static void _usb_write32_async(struct rtl_priv *rtlpriv, u32 addr, u32 val)
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
@@ -229,7 +212,6 @@ static void _rtl_usb_io_handler_init(struct device *dev,
 	rtlpriv->io.read8_sync		= _usb_read8_sync;
 	rtlpriv->io.read16_sync		= _usb_read16_sync;
 	rtlpriv->io.read32_sync		= _usb_read32_sync;
-	rtlpriv->io.writen_sync		= _usb_writen_sync;
 }
 
 static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
@@ -1014,7 +996,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 	hw = ieee80211_alloc_hw(sizeof(struct rtl_priv) +
 				sizeof(struct rtl_usb_priv), &rtl_ops);
 	if (!hw) {
-		pr_warn("rtl_usb: ieee80211 alloc failed\n");
+		dev_err(&intf->dev, "failed to allocate 802.11 device data\n");
 		return -ENOMEM;
 	}
 	rtlpriv = hw->priv;
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

