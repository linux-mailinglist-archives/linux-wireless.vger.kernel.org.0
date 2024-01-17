Return-Path: <linux-wireless+bounces-2126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AEB830DCA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 21:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5392B281B65
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BD624A1D;
	Wed, 17 Jan 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdGq0d3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FE249F7
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522313; cv=none; b=s+KOCiQoL2YM6inoH5XSjF8oZYg2M3JnA8bF2eUnrffCdLuom1Q2LbPbgmVtMY/YPrJcjIH1YkMr643kPadk1TnAdkAjKvTIvytXn+P5FkiMfHfAlis9YbJg5MgYZhydJ0U6VGZSXHVcv/FfVScIPzvi/USx9Y/zzxSkbncT8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522313; c=relaxed/simple;
	bh=QSYukGeIM0WrNLcSScefpaQvREWH2FBAaKVN/z2Kfo4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding; b=iU2gcBMLUKfPCf4WsXkZj7qsjOK355ZQfweN80xSnylH/J29NRahz7EaB5xZ/iD6GSXH9E19/XJwuvsgsZ1sGDoVqwAduLG24mTsOAlBME8o5wxTEvCMUtcphzsWEwE0mbqoYgNNdqRdp/EUaGm5G3rQs716UOuAuxryTU5Jqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdGq0d3z; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2ece31f5fdso121456466b.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705522310; x=1706127110; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rueZ1ZsBQ8J3uPaMggPD12s4mi0eEllFam5+/YUNj0Y=;
        b=jdGq0d3zsQIrsK/19FmqUBnEkHHlaTST1O4hfVvV1CcZeWFSI4+cmpFwYGi0QFKG87
         hIJx9v8hElzk+Tn4SnraqZ9u5VeqqPQ7QCgkVf6WOs/2FZjOG+4YCGeu38hkGod20A7A
         mag+J/VAfmJsxYFvHqvWim7fkZXrnl2FB2w/kh+TrgN0ubZLJnnStMUz31oxIOUJeyf3
         wKaNc9fj5mtWNYRn4wavNUG7aQ70RQ4+jdmV+QIcHW3BQa0ttqYN6mU60LdFSbEWwksN
         CN2oJQvDdQO/kx5ib19dbXdSlLvC4/AZ9k0AGmy8ml/0HmFkGR+MR3jG6w6Cv58rx7Km
         yekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522310; x=1706127110;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rueZ1ZsBQ8J3uPaMggPD12s4mi0eEllFam5+/YUNj0Y=;
        b=Njerc1NDu4DV8NzRmXgZ8JzjxCtXKg9LL7+9Sncbo2E8EgrBnVFDxVhRFobIscSk4w
         Xgp3W/1v4+vcxv0eGf+J1VpfG59u7A3JFezJsFhYqYOoN1Um971nG6lIZ6d9NGm3NXf9
         NvsHfgHtbfJr1fhKtz6BamuYOYb8ssZL3V2GAOuYy1ONnxJ5NbJxaixcv4ssQTAKIpja
         wsXbegmZyja59emsbKZU0ac4FRH8LIS3lPMecGUnAWLdyQRczoZH5geujeKRRcSBO6nV
         4VTtc044T3KLKoOyzGy3GR8q8wReDNRJXjazPm4CQdk/Il/ZFYTXfqpquLePrTLRl+Xw
         yzpA==
X-Gm-Message-State: AOJu0YwjIfPI+CJwvqO89lrkCn3yU9ycH7YOXINwC1kfrHgOnS6kkpob
	hEz+fbN6MlLzah4tNgjNa7eN1MYhZbI=
X-Google-Smtp-Source: AGHT+IHzkgSdlToy/pnam5hzDNWSfvxnmlwSrRvLqQiXy2sclECpIT+wdRhPSDLowZ04da3tOPZZAQ==
X-Received: by 2002:a17:907:c206:b0:a2f:15a7:c298 with SMTP id ti6-20020a170907c20600b00a2f15a7c298mr17775ejc.108.1705522309979;
        Wed, 17 Jan 2024 12:11:49 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id g22-20020a17090613d600b00a26aaf9f79asm8098138ejc.20.2024.01.17.12.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:11:49 -0800 (PST)
Message-ID: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
Date: Wed, 17 Jan 2024 22:11:48 +0200
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
Subject: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
(and 11 seconds for RTL8192DU). That's because the firmware is uploaded
one byte at a time.

Also, after plugging the device, the firmware gets uploaded three times
before a connection to the AP is established.

Maybe this is fine for most users, but when testing changes to the
driver it's really annoying to wait so long.

Speed up the firmware upload by writing chunks of 64 bytes at a time.
This way it takes about 110 ms for RTL8192CU (and about 210 ms for
RTL8192DU).

PCI devices could upload it in chunks of 4 bytes, but I don't have any
to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
rather than as dwords") decided otherwise anyway.

Allocate memory for the firmware image with kmalloc instead of vzalloc
because this memory is passed directly to usb_control_msg(), which
can't take memory allocated by vmalloc.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Simplify _rtl_fw_block_write_usb().
 - Explain kmalloc in the commit message.
---
 drivers/net/wireless/realtek/rtlwifi/efuse.c  | 36 ++++++++++++++++---
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |  4 +--
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  6 ++--
 drivers/net/wireless/realtek/rtlwifi/usb.c    |  9 +++++
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  8 +++++
 5 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 2e945554ed6d..c1fbc29d5ca1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -1287,18 +1287,44 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 }
 EXPORT_SYMBOL_GPL(rtl_get_hwinfo);
 
-void rtl_fw_block_write(struct ieee80211_hw *hw, const u8 *buffer, u32 size)
+static void _rtl_fw_block_write_usb(struct ieee80211_hw *hw, u8 *buffer, u32 size)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 start = START_ADDRESS;
+	u32 n;
+
+	while (size > 0) {
+		if (size >= 64)
+			n = 64;
+		else if (size >= 8)
+			n = 8;
+		else
+			n = 1;
+
+		rtl_write_chunk(rtlpriv, start, n, buffer);
+
+		start += n;
+		buffer += n;
+		size -= n;
+	}
+}
+
+void rtl_fw_block_write(struct ieee80211_hw *hw, u8 *buffer, u32 size)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 *pu4byteptr = (u8 *)buffer;
 	u32 i;
 
-	for (i = 0; i < size; i++)
-		rtl_write_byte(rtlpriv, (START_ADDRESS + i), *(pu4byteptr + i));
+	if (rtlpriv->rtlhal.interface == INTF_PCI) {
+		for (i = 0; i < size; i++)
+			rtl_write_byte(rtlpriv, (START_ADDRESS + i),
+				       *(buffer + i));
+	} else if (rtlpriv->rtlhal.interface == INTF_USB) {
+		_rtl_fw_block_write_usb(hw, buffer, size);
+	}
 }
 EXPORT_SYMBOL_GPL(rtl_fw_block_write);
 
-void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, const u8 *buffer,
+void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, u8 *buffer,
 		       u32 size)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.h b/drivers/net/wireless/realtek/rtlwifi/efuse.h
index 1ec59f439382..4821625ad1e5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.h
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.h
@@ -91,8 +91,8 @@ void efuse_power_switch(struct ieee80211_hw *hw, u8 write, u8 pwrstate);
 int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 		   int max_size, u8 *hwinfo, int *params);
 void rtl_fill_dummy(u8 *pfwbuf, u32 *pfwlen);
-void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, const u8 *buffer,
+void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, u8 *buffer,
 		       u32 size);
-void rtl_fw_block_write(struct ieee80211_hw *hw, const u8 *buffer, u32 size);
+void rtl_fw_block_write(struct ieee80211_hw *hw, u8 *buffer, u32 size);
 void rtl_efuse_ops_init(struct ieee80211_hw *hw);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 20b4aac69642..9f4cf09090d6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -40,7 +40,7 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->dm.thermalvalue = 0;
 
 	/* for firmware buf */
-	rtlpriv->rtlhal.pfirmware = vzalloc(0x4000);
+	rtlpriv->rtlhal.pfirmware = kmalloc(0x4000, GFP_KERNEL);
 	if (!rtlpriv->rtlhal.pfirmware) {
 		pr_err("Can't alloc buffer for fw\n");
 		return 1;
@@ -61,7 +61,7 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
 				      fw_name, rtlpriv->io.dev,
 				      GFP_KERNEL, hw, rtl_fw_cb);
 	if (err) {
-		vfree(rtlpriv->rtlhal.pfirmware);
+		kfree(rtlpriv->rtlhal.pfirmware);
 		rtlpriv->rtlhal.pfirmware = NULL;
 	}
 	return err;
@@ -72,7 +72,7 @@ static void rtl92cu_deinit_sw_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (rtlpriv->rtlhal.pfirmware) {
-		vfree(rtlpriv->rtlhal.pfirmware);
+		kfree(rtlpriv->rtlhal.pfirmware);
 		rtlpriv->rtlhal.pfirmware = NULL;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 07a7e6fa46af..1fc480fe18ad 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -125,6 +125,14 @@ static void _usb_write32_sync(struct rtl_priv *rtlpriv, u32 addr, u32 val)
 	_usb_write_sync(rtlpriv, addr, val, 4);
 }
 
+static void _usb_write_chunk_sync(struct rtl_priv *rtlpriv, u32 addr,
+				  u32 length, u8 *data)
+{
+	struct usb_device *udev = to_usb_device(rtlpriv->io.dev);
+
+	_usbctrl_vendorreq_sync(udev, REALTEK_USB_VENQT_WRITE, addr, data, length);
+}
+
 static void _rtl_usb_io_handler_init(struct device *dev,
 				     struct ieee80211_hw *hw)
 {
@@ -135,6 +143,7 @@ static void _rtl_usb_io_handler_init(struct device *dev,
 	rtlpriv->io.write8	= _usb_write8_sync;
 	rtlpriv->io.write16	= _usb_write16_sync;
 	rtlpriv->io.write32	= _usb_write32_sync;
+	rtlpriv->io.write_chunk	= _usb_write_chunk_sync;
 	rtlpriv->io.read8	= _usb_read8_sync;
 	rtlpriv->io.read16	= _usb_read16_sync;
 	rtlpriv->io.read32	= _usb_read32_sync;
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 53af324f3807..3821f6e31447 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1450,6 +1450,8 @@ struct rtl_io {
 	void (*write8)(struct rtl_priv *rtlpriv, u32 addr, u8 val);
 	void (*write16)(struct rtl_priv *rtlpriv, u32 addr, u16 val);
 	void (*write32)(struct rtl_priv *rtlpriv, u32 addr, u32 val);
+	void (*write_chunk)(struct rtl_priv *rtlpriv, u32 addr, u32 length,
+			    u8 *data);
 
 	u8 (*read8)(struct rtl_priv *rtlpriv, u32 addr);
 	u16 (*read16)(struct rtl_priv *rtlpriv, u32 addr);
@@ -2962,6 +2964,12 @@ static inline void rtl_write_dword(struct rtl_priv *rtlpriv,
 		rtlpriv->io.read32(rtlpriv, addr);
 }
 
+static inline void rtl_write_chunk(struct rtl_priv *rtlpriv,
+				   u32 addr, u32 length, u8 *data)
+{
+	rtlpriv->io.write_chunk(rtlpriv, addr, length, data);
+}
+
 static inline u32 rtl_get_bbreg(struct ieee80211_hw *hw,
 				u32 regaddr, u32 bitmask)
 {
-- 
2.43.0

