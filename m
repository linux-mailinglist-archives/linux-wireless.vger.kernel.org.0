Return-Path: <linux-wireless+bounces-1333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12382016F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7FAB220DC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59EA14267;
	Fri, 29 Dec 2023 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF9ximjX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB201426F
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so26091805e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703883081; x=1704487881; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNc245D/BAq9HlkqelvZ+jO/WoBo6ssnlFr40wVqNVw=;
        b=VF9ximjXGvq96mzuHNNj8BHcADV4bqi8WCDkeXx5xpKh/1WMIkXGT014G01JYK2888
         0Uvvu8VRV3u8BAy6qOjx6h/QEqlu0TvnUDdKf6z0u1m/LDwE8inhAV/KZGMRXeIWLdIV
         mqb8LaU7OVc/QiVb8+t3MUMUyitnraAZM4pX4u+VA5Bqn7TWsNMMZGvioIBzOfskAjB3
         5clZx9JH/i7s+AVra6Ct7HgP8RmVXtogGGuBjRc1viwjmiLlB2twpXVUXv4PMhKB3BxR
         A3ieHJAG2/Re0hXdkft5JzNZMmfsehuZvRilMoewaM0oudbY0GjnA1kfeCcf1tpgJGpl
         aIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703883081; x=1704487881;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNc245D/BAq9HlkqelvZ+jO/WoBo6ssnlFr40wVqNVw=;
        b=f4un1ej38ANM/UhoQEIJG/QngEoKqQrpBihc7pH5DNBiCApy3wDDXdIboYYexv5Zvv
         S4Gn4V8XWk6Ph/UzGoXE+J1k3IcLtjYQ2+m2vxz3JdQa6v33dGTxKoCoh4Sh+DS0MNC0
         ZIgVm6sQrpZIRbAEgL2xww6froYqXRB3zahvkXNWYhT3oeNlem3toK9PTdCUtHxIrZod
         uWIiqLhFP5escxHr3q8wmIrDk1tHDCL96QyYTD1yObQKh83oQuwxRAxvviOwmGudmKNA
         D2YxFnL8Mqp5GjzJRVorgBx/vXnBAiyTcwrWWE7sR3Rp3pGEg+COBn68q+cdOYJD4TG5
         3rMg==
X-Gm-Message-State: AOJu0YzNMUx7KlGJ16Qod2Bj9MthptDKJpIX6vSVxFeTYujQIXC6cRXU
	7wtdcJEUsvkDWuoTlzuL5nVgvFGiUt8=
X-Google-Smtp-Source: AGHT+IFHn413YvlPntElL3bz1BUgQSDfXFsjKhZ4vOk/KqKMOxh/OuAXssS06NgMee95KQxmkyuJcg==
X-Received: by 2002:a05:600c:1547:b0:40d:5fc7:a2f7 with SMTP id f7-20020a05600c154700b0040d5fc7a2f7mr2081877wmg.34.1703883080820;
        Fri, 29 Dec 2023 12:51:20 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040d6eb44b94sm5933257wmo.2.2023.12.29.12.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 12:51:20 -0800 (PST)
Message-ID: <f806007e-8fba-4f29-8a38-f81d04bd4fb8@gmail.com>
Date: Fri, 29 Dec 2023 22:51:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl_usb: Use sync register writes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently rtl_usb performs register writes using the async
usb_submit_urb() function. This appears to work fine for the RTL8192CU,
but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHZ
band is still untested.)

With this patch, rtl_usb performs the register writes using the
synchronous usb_control_msg() function, and the RTL8192DU works
normally. The RTL8192CU still works.

The vendor drivers use the async writes in only one function,
rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
doesn't even run in real life. They use sync writes everywhere else.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---

Larry, do you remember why, back in 2011, you chose to implement the
async writes?

I'm not happy about this part:

+	rtlpriv->io.write8_async	= _usb_write8_sync;

The variables say "async" but the functions are not async anymore.
But I couldn't think of a good way to avoid this.

---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 157 ++++++---------------
 1 file changed, 42 insertions(+), 115 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 30bf2775a335..25394ef702c8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -23,86 +23,23 @@ MODULE_DESCRIPTION("USB basic driver for rtlwifi");
 
 #define MAX_USBCTRL_VENDORREQ_TIMES		10
 
-static void usbctrl_async_callback(struct urb *urb)
-{
-	if (urb) {
-		/* free dr */
-		kfree(urb->setup_packet);
-		/* free databuf */
-		kfree(urb->transfer_buffer);
-	}
-}
-
-static int _usbctrl_vendorreq_async_write(struct usb_device *udev, u8 request,
-					  u16 value, u16 index, void *pdata,
-					  u16 len)
-{
-	int rc;
-	unsigned int pipe;
-	u8 reqtype;
-	struct usb_ctrlrequest *dr;
-	struct urb *urb;
-	const u16 databuf_maxlen = REALTEK_USB_VENQT_MAX_BUF_SIZE;
-	u8 *databuf;
-
-	if (WARN_ON_ONCE(len > databuf_maxlen))
-		len = databuf_maxlen;
-
-	pipe = usb_sndctrlpipe(udev, 0); /* write_out */
-	reqtype =  REALTEK_USB_VENQT_WRITE;
-
-	dr = kzalloc(sizeof(*dr), GFP_ATOMIC);
-	if (!dr)
-		return -ENOMEM;
-
-	databuf = kzalloc(databuf_maxlen, GFP_ATOMIC);
-	if (!databuf) {
-		kfree(dr);
-		return -ENOMEM;
-	}
-
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urb) {
-		kfree(databuf);
-		kfree(dr);
-		return -ENOMEM;
-	}
-
-	dr->bRequestType = reqtype;
-	dr->bRequest = request;
-	dr->wValue = cpu_to_le16(value);
-	dr->wIndex = cpu_to_le16(index);
-	dr->wLength = cpu_to_le16(len);
-	/* data are already in little-endian order */
-	memcpy(databuf, pdata, len);
-	usb_fill_control_urb(urb, udev, pipe,
-			     (unsigned char *)dr, databuf, len,
-			     usbctrl_async_callback, NULL);
-	rc = usb_submit_urb(urb, GFP_ATOMIC);
-	if (rc < 0) {
-		kfree(databuf);
-		kfree(dr);
-	}
-	usb_free_urb(urb);
-	return rc;
-}
-
-static int _usbctrl_vendorreq_sync_read(struct usb_device *udev, u8 request,
-					u16 value, u16 index, void *pdata,
-					u16 len)
+static void _usbctrl_vendorreq_sync(struct usb_device *udev, u8 reqtype,
+				   u16 value, void *pdata, u16 len)
 {
 	unsigned int pipe;
 	int status;
-	u8 reqtype;
 	int vendorreq_times = 0;
 	static int count;
 
-	pipe = usb_rcvctrlpipe(udev, 0); /* read_in */
-	reqtype =  REALTEK_USB_VENQT_READ;
+	if (reqtype == REALTEK_USB_VENQT_READ)
+		pipe = usb_rcvctrlpipe(udev, 0); /* read_in */
+	else
+		pipe = usb_sndctrlpipe(udev, 0); /* write_out */
 
 	do {
-		status = usb_control_msg(udev, pipe, request, reqtype, value,
-					 index, pdata, len, 1000);
+		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
+					 pdata, len, 1000);
 		if (status < 0) {
 			/* firmware download is checksumed, don't retry */
 			if ((value >= FW_8192C_START_ADDRESS &&
@@ -114,18 +51,15 @@ static int _usbctrl_vendorreq_sync_read(struct usb_device *udev, u8 request,
 	} while (++vendorreq_times < MAX_USBCTRL_VENDORREQ_TIMES);
 
 	if (status < 0 && count++ < 4)
-		pr_err("reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x\n",
-		       value, status, *(u32 *)pdata);
-	return status;
+		pr_err("reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x reqtype=0x%x\n",
+		       value, status, *(u32 *)pdata, reqtype);
 }
 
 static u32 _usb_read_sync(struct rtl_priv *rtlpriv, u32 addr, u16 len)
 {
 	struct device *dev = rtlpriv->io.dev;
 	struct usb_device *udev = to_usb_device(dev);
-	u8 request;
 	u16 wvalue;
-	u16 index;
 	__le32 *data;
 	unsigned long flags;
 
@@ -134,14 +68,33 @@ static u32 _usb_read_sync(struct rtl_priv *rtlpriv, u32 addr, u16 len)
 		rtlpriv->usb_data_index = 0;
 	data = &rtlpriv->usb_data[rtlpriv->usb_data_index];
 	spin_unlock_irqrestore(&rtlpriv->locks.usb_lock, flags);
-	request = REALTEK_USB_VENQT_CMD_REQ;
-	index = REALTEK_USB_VENQT_CMD_IDX; /* n/a */
 
 	wvalue = (u16)addr;
-	_usbctrl_vendorreq_sync_read(udev, request, wvalue, index, data, len);
+	_usbctrl_vendorreq_sync(udev, REALTEK_USB_VENQT_READ, wvalue, data, len);
 	return le32_to_cpu(*data);
 }
 
+
+static void _usb_write_sync(struct rtl_priv *rtlpriv, u32 addr, u32 val, u16 len)
+{
+	struct device *dev = rtlpriv->io.dev;
+	struct usb_device *udev = to_usb_device(dev);
+	unsigned long flags;
+	__le32 *data;
+	u16 wvalue;
+
+	spin_lock_irqsave(&rtlpriv->locks.usb_lock, flags);
+	if (++rtlpriv->usb_data_index >= RTL_USB_MAX_RX_COUNT)
+		rtlpriv->usb_data_index = 0;
+	data = &rtlpriv->usb_data[rtlpriv->usb_data_index];
+	spin_unlock_irqrestore(&rtlpriv->locks.usb_lock, flags);
+
+	wvalue = (u16)(addr & 0x0000ffff);
+	*data = cpu_to_le32(val);
+
+	_usbctrl_vendorreq_sync(udev, REALTEK_USB_VENQT_WRITE, wvalue, data, len);
+}
+
 static u8 _usb_read8_sync(struct rtl_priv *rtlpriv, u32 addr)
 {
 	return (u8)_usb_read_sync(rtlpriv, addr, 1);
@@ -157,45 +110,19 @@ static u32 _usb_read32_sync(struct rtl_priv *rtlpriv, u32 addr)
 	return _usb_read_sync(rtlpriv, addr, 4);
 }
 
-static void _usb_write_async(struct usb_device *udev, u32 addr, u32 val,
-			     u16 len)
-{
-	u8 request;
-	u16 wvalue;
-	u16 index;
-	__le32 data;
-	int ret;
-
-	request = REALTEK_USB_VENQT_CMD_REQ;
-	index = REALTEK_USB_VENQT_CMD_IDX; /* n/a */
-	wvalue = (u16)(addr&0x0000ffff);
-	data = cpu_to_le32(val);
-
-	ret = _usbctrl_vendorreq_async_write(udev, request, wvalue,
-					     index, &data, len);
-	if (ret < 0)
-		dev_err(&udev->dev, "error %d writing at 0x%x\n", ret, addr);
-}
-
-static void _usb_write8_async(struct rtl_priv *rtlpriv, u32 addr, u8 val)
+static void _usb_write8_sync(struct rtl_priv *rtlpriv, u32 addr, u8 val)
 {
-	struct device *dev = rtlpriv->io.dev;
-
-	_usb_write_async(to_usb_device(dev), addr, val, 1);
+	_usb_write_sync(rtlpriv, addr, val, 1);
 }
 
-static void _usb_write16_async(struct rtl_priv *rtlpriv, u32 addr, u16 val)
+static void _usb_write16_sync(struct rtl_priv *rtlpriv, u32 addr, u16 val)
 {
-	struct device *dev = rtlpriv->io.dev;
-
-	_usb_write_async(to_usb_device(dev), addr, val, 2);
+	_usb_write_sync(rtlpriv, addr, val, 2);
 }
 
-static void _usb_write32_async(struct rtl_priv *rtlpriv, u32 addr, u32 val)
+static void _usb_write32_sync(struct rtl_priv *rtlpriv, u32 addr, u32 val)
 {
-	struct device *dev = rtlpriv->io.dev;
-
-	_usb_write_async(to_usb_device(dev), addr, val, 4);
+	_usb_write_sync(rtlpriv, addr, val, 4);
 }
 
 static void _rtl_usb_io_handler_init(struct device *dev,
@@ -205,9 +132,9 @@ static void _rtl_usb_io_handler_init(struct device *dev,
 
 	rtlpriv->io.dev = dev;
 	mutex_init(&rtlpriv->io.bb_mutex);
-	rtlpriv->io.write8_async	= _usb_write8_async;
-	rtlpriv->io.write16_async	= _usb_write16_async;
-	rtlpriv->io.write32_async	= _usb_write32_async;
+	rtlpriv->io.write8_async	= _usb_write8_sync;
+	rtlpriv->io.write16_async	= _usb_write16_sync;
+	rtlpriv->io.write32_async	= _usb_write32_sync;
 	rtlpriv->io.read8_sync		= _usb_read8_sync;
 	rtlpriv->io.read16_sync		= _usb_read16_sync;
 	rtlpriv->io.read32_sync		= _usb_read32_sync;
-- 
2.43.0

