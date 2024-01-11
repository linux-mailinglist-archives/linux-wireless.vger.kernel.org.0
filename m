Return-Path: <linux-wireless+bounces-1720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C129382B122
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94851C219C8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721A4A9B0;
	Thu, 11 Jan 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPihfDTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FB4A9A0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5336986cso69582215e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704985002; x=1705589802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xwNderw4i89xV+CGGir6L0sq/5zTn3AOomvJ45qeK8=;
        b=ZPihfDTJzeAbELtwAQDCgh/dcRc7qtYz1gzRiQ1rQE640IKQR691AcWV2b6kCmvlzR
         Iem4pSNDdpkUxpzch7oS4gCe6U6xVoHZ59KcnVKuWkYlDtC5hmud0gsf8pqfPBsZtCF4
         oG8N4fFPWfOMgkCTGvhIIrgqbUjho3fNKioTLPEs8cCInXeUlrrIRiCK45KvQTmTEUfb
         iyiuADCXKQ0uKN1hydjK933QSHtVdzAOwYD+Gme3zUx4IxZ4CRym7YBDoeCB/QDFjkoJ
         ZyIOaz1c20iSjlCeHgHyWw8E7LhOtMVnEd7Kmw9jq0JZGN9eQzOdeZDPhfRwbMtUShIk
         OZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985002; x=1705589802;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5xwNderw4i89xV+CGGir6L0sq/5zTn3AOomvJ45qeK8=;
        b=pot8uxRsw1AXGn75rfPhdGtmDrDXZxm44RicfGopHXaNgypoaZ0+I32/1ovUs3G8r1
         6voSn8k/cOc1I8j3ZUweDxB+Kf1hlg6dwgOtedYCkn2a2saLC8OIfKGIidG+qzIluTc3
         NeAgljc3ASxp+G+4zkY3axvpt/fKHLp265oAcNGT6TrJpdouoPZS6AdSO5r0IRjVrJoW
         VzSUnoWGwZnN/JiJhpDeJipmxe7Z6zknbbaJ6NGLkyPlKHzwRM0DFkTjCWxh3Y43s6Iu
         q7/w1xzVsCe+rgZ1WY+YMqQOTsu5ogigwkvqujxlhXzUUJObMf2kRlQgNHzqedCJ2UVY
         gXmA==
X-Gm-Message-State: AOJu0YxX9dLOiog7kJ/yAoRcAwOY+sarM5nBpT+gtS4dzm1AtE75sJVB
	PX6wI7VYVECtae2D8+SyUye7MOuh4yo=
X-Google-Smtp-Source: AGHT+IGhsD15wUWyLjxb5huwqurOM7g3YgKreVJ6MkUdwotOZEPR4JfjmhNQTTXmFMO7vVhORP4Dtg==
X-Received: by 2002:a05:600c:1392:b0:40d:8944:657d with SMTP id u18-20020a05600c139200b0040d8944657dmr472967wmf.140.1704985002146;
        Thu, 11 Jan 2024 06:56:42 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id p19-20020adf9d93000000b003378ea9a7desm596589wre.33.2024.01.11.06.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 06:56:41 -0800 (PST)
Message-ID: <fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com>
Date: Thu, 11 Jan 2024 16:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtlwifi: rtl_usb: Use sync register writes
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently rtl_usb performs register writes using the async
usb_submit_urb() function. This appears to work fine for the RTL8192CU,
but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHz
band is still untested.)

With this patch, rtl_usb performs the register writes using the
synchronous usb_control_msg() function, and the RTL8192DU works
normally. The RTL8192CU still works.

The vendor drivers use the async writes in only one function,
rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
doesn't even run in real life. They use sync writes everywhere else.

Also, remove "sync" and "async" from the names of the members of
struct rtl_io to avoid confusion:

write{8,16,32}_async -> write{8,16,32}
 read{8,16,32}_sync  ->  read{8,16,32}

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Use dev_err instead of pr_err.

v2:
 - Rename the members of struct rtl_io.
---
 drivers/net/wireless/realtek/rtlwifi/pci.c  |  12 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 163 ++++++--------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  30 ++--
 3 files changed, 66 insertions(+), 139 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 96ce05bcf0b3..d059cfe5a2a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -378,13 +378,13 @@ static void _rtl_pci_io_handler_init(struct device *dev,
 
 	rtlpriv->io.dev = dev;
 
-	rtlpriv->io.write8_async = pci_write8_async;
-	rtlpriv->io.write16_async = pci_write16_async;
-	rtlpriv->io.write32_async = pci_write32_async;
+	rtlpriv->io.write8 = pci_write8_async;
+	rtlpriv->io.write16 = pci_write16_async;
+	rtlpriv->io.write32 = pci_write32_async;
 
-	rtlpriv->io.read8_sync = pci_read8_sync;
-	rtlpriv->io.read16_sync = pci_read16_sync;
-	rtlpriv->io.read32_sync = pci_read32_sync;
+	rtlpriv->io.read8 = pci_read8_sync;
+	rtlpriv->io.read16 = pci_read16_sync;
+	rtlpriv->io.read32 = pci_read32_sync;
 }
 
 static bool _rtl_update_earlymode_info(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 30bf2775a335..7b91d882f969 100644
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
+		dev_err(&udev->dev, "reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x reqtype=0x%x\n",
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
@@ -205,12 +132,12 @@ static void _rtl_usb_io_handler_init(struct device *dev,
 
 	rtlpriv->io.dev = dev;
 	mutex_init(&rtlpriv->io.bb_mutex);
-	rtlpriv->io.write8_async	= _usb_write8_async;
-	rtlpriv->io.write16_async	= _usb_write16_async;
-	rtlpriv->io.write32_async	= _usb_write32_async;
-	rtlpriv->io.read8_sync		= _usb_read8_sync;
-	rtlpriv->io.read16_sync		= _usb_read16_sync;
-	rtlpriv->io.read32_sync		= _usb_read32_sync;
+	rtlpriv->io.write8	= _usb_write8_sync;
+	rtlpriv->io.write16	= _usb_write16_sync;
+	rtlpriv->io.write32	= _usb_write32_sync;
+	rtlpriv->io.read8	= _usb_read8_sync;
+	rtlpriv->io.read16	= _usb_read16_sync;
+	rtlpriv->io.read32	= _usb_read32_sync;
 }
 
 static void _rtl_usb_io_handler_release(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index d87cd2252eac..53af324f3807 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1447,13 +1447,13 @@ struct rtl_io {
 	/*PCI IO map */
 	unsigned long pci_base_addr;	/*device I/O address */
 
-	void (*write8_async)(struct rtl_priv *rtlpriv, u32 addr, u8 val);
-	void (*write16_async)(struct rtl_priv *rtlpriv, u32 addr, u16 val);
-	void (*write32_async)(struct rtl_priv *rtlpriv, u32 addr, u32 val);
+	void (*write8)(struct rtl_priv *rtlpriv, u32 addr, u8 val);
+	void (*write16)(struct rtl_priv *rtlpriv, u32 addr, u16 val);
+	void (*write32)(struct rtl_priv *rtlpriv, u32 addr, u32 val);
 
-	u8 (*read8_sync)(struct rtl_priv *rtlpriv, u32 addr);
-	u16 (*read16_sync)(struct rtl_priv *rtlpriv, u32 addr);
-	u32 (*read32_sync)(struct rtl_priv *rtlpriv, u32 addr);
+	u8 (*read8)(struct rtl_priv *rtlpriv, u32 addr);
+	u16 (*read16)(struct rtl_priv *rtlpriv, u32 addr);
+	u32 (*read32)(struct rtl_priv *rtlpriv, u32 addr);
 
 };
 
@@ -2916,25 +2916,25 @@ extern u8 channel5g_80m[CHANNEL_MAX_NUMBER_5G_80M];
 
 static inline u8 rtl_read_byte(struct rtl_priv *rtlpriv, u32 addr)
 {
-	return rtlpriv->io.read8_sync(rtlpriv, addr);
+	return rtlpriv->io.read8(rtlpriv, addr);
 }
 
 static inline u16 rtl_read_word(struct rtl_priv *rtlpriv, u32 addr)
 {
-	return rtlpriv->io.read16_sync(rtlpriv, addr);
+	return rtlpriv->io.read16(rtlpriv, addr);
 }
 
 static inline u32 rtl_read_dword(struct rtl_priv *rtlpriv, u32 addr)
 {
-	return rtlpriv->io.read32_sync(rtlpriv, addr);
+	return rtlpriv->io.read32(rtlpriv, addr);
 }
 
 static inline void rtl_write_byte(struct rtl_priv *rtlpriv, u32 addr, u8 val8)
 {
-	rtlpriv->io.write8_async(rtlpriv, addr, val8);
+	rtlpriv->io.write8(rtlpriv, addr, val8);
 
 	if (rtlpriv->cfg->write_readback)
-		rtlpriv->io.read8_sync(rtlpriv, addr);
+		rtlpriv->io.read8(rtlpriv, addr);
 }
 
 static inline void rtl_write_byte_with_val32(struct ieee80211_hw *hw,
@@ -2947,19 +2947,19 @@ static inline void rtl_write_byte_with_val32(struct ieee80211_hw *hw,
 
 static inline void rtl_write_word(struct rtl_priv *rtlpriv, u32 addr, u16 val16)
 {
-	rtlpriv->io.write16_async(rtlpriv, addr, val16);
+	rtlpriv->io.write16(rtlpriv, addr, val16);
 
 	if (rtlpriv->cfg->write_readback)
-		rtlpriv->io.read16_sync(rtlpriv, addr);
+		rtlpriv->io.read16(rtlpriv, addr);
 }
 
 static inline void rtl_write_dword(struct rtl_priv *rtlpriv,
 				   u32 addr, u32 val32)
 {
-	rtlpriv->io.write32_async(rtlpriv, addr, val32);
+	rtlpriv->io.write32(rtlpriv, addr, val32);
 
 	if (rtlpriv->cfg->write_readback)
-		rtlpriv->io.read32_sync(rtlpriv, addr);
+		rtlpriv->io.read32(rtlpriv, addr);
 }
 
 static inline u32 rtl_get_bbreg(struct ieee80211_hw *hw,
-- 
2.43.0

