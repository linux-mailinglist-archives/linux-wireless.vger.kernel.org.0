Return-Path: <linux-wireless+bounces-1664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40354829B95
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F3A2813E1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28378495C8;
	Wed, 10 Jan 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEyNnEQ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30012495C5
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so20277165e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704894398; x=1705499198; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJ3uVgacrcDR1lT55/ZpNp2hlDHlF2p+h6Jub1OjAA=;
        b=EEyNnEQ+O6aMO5Q2s8p945EDIAUDMN+Ys5ijkiCq+9U+hI8c6zkc+AeVZpyVZ+R2MC
         wWz0EHJne8CdNxINMceOxILXkr9xwKnAiYbmBb56Qp94hHjaLid2Xs+3iLfTyS3VMY4u
         2OgVCaFnJLtrYiOZ0bT1n9xef8DVtV+IZzwhv5cx3udS84skYSnvn3NWQlA/O05UQISt
         sJDFh3MPV/PmUZ/nswdP3LKVrocM6H61QMMTTyUJtwOFc3Y4HqOJEOtbsB0E/Hn8w0mr
         ig7OVUp0pn2VMg5+9BNwJs0QHQwqTWikENWGP4kpRVpeN4lXZaHJOD8QvjPfXHwyoIly
         FA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894398; x=1705499198;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1vJ3uVgacrcDR1lT55/ZpNp2hlDHlF2p+h6Jub1OjAA=;
        b=M8rKELGJ+tiQWh2ed9i5LBxmMwboaidxodpJom7TRRSq3VO34imW8NFfZltSCfGz2s
         poCJ9CXV6+Xuv5uwyCsPeSCVwwz+VS2Z5tG5+E8SQCPZins5buE1yzmZ8X/0dVTWvN34
         fPcH9CK3WB0Sjrnq/U2Vz0qPEXXo3ujMJPnDCjgX7W/RR71menyFCk7xzgO73sge8A+0
         sbNP812TFEyv7DEzmSj7YxdeeTj5aw6z/qSI4ofuXimMuVz2Nv3Mb6e2wm/PR+Wlf72D
         28YiBP4TivwrIajR/XJEfY3SuDTVwzgwsMBvAVEbjbJXbPZZYilt59bCueUQQYkvBzwO
         BJ6w==
X-Gm-Message-State: AOJu0Yy1rrtAlr5ItJrMLzlYPKHrLINhUnpVovrQN6bctO8OihI3qnt+
	fSAVaqRf8ISfWX8zc14Rv+8Y9Tt7Ds0=
X-Google-Smtp-Source: AGHT+IE8ilBR3Vy/0FbBILbH/K3QY9Ru6WbjAA3X74c5m2mOpkCFl6ZvnPU7ww5ZD6F4U5y7ZTvvBw==
X-Received: by 2002:a05:600c:468a:b0:40e:3d8d:4cc1 with SMTP id p10-20020a05600c468a00b0040e3d8d4cc1mr622382wmo.71.1704894398080;
        Wed, 10 Jan 2024 05:46:38 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id k38-20020a05600c1ca600b0040e5945307esm1128716wms.40.2024.01.10.05.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:46:37 -0800 (PST)
Message-ID: <400ec3ff-2ab7-469f-b32f-43dfd62621f9@gmail.com>
Date: Wed, 10 Jan 2024 15:46:35 +0200
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
Subject: [PATCH v2] wifi: rtlwifi: rtl_usb: Use sync register writes
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

