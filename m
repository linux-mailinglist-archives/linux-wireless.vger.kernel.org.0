Return-Path: <linux-wireless+bounces-1844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0109982C604
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC61C244BF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6822215AFA;
	Fri, 12 Jan 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIzg1mTR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06415AFE
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e55c885d7so37093965e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088998; x=1705693798; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KnsbOGdxXkhxj4fVWBh+ufn+zH4Ob6tXtsoNnDKGEA=;
        b=OIzg1mTR1VHmehIAh8fdvCwi6K4iKTBkCsUqUP8VEHM1y+w81l767djxTXydBtceSN
         h7RFYJ3opayGaO2/ApHXWg1GtAHOVxX8T30Lr8Jt2djJ5kXup2SDQvx1L+hqxV/nsypV
         RT3wMfAJTUppYnytY9qc+DAhb2s8g/ccLrQ0rC53Hg5iIOgkbbwR/XJxTsi8mhxdrhGh
         7pdQJPmaz9HabkUeRX6MjTG+2GZUrCHgBdZAwKrAjPMoAlQBCv1WE5gfCdbsaWSJ361A
         iTtaZ3gmy3Y6T7RCMwGpuBGl/5OWydFlylC4ctcxj4OlC7BG0Niklg3ymggVQlxGMRaC
         3bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088998; x=1705693798;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KnsbOGdxXkhxj4fVWBh+ufn+zH4Ob6tXtsoNnDKGEA=;
        b=UZcjPVHg1jJdqO/wJ982nXGQSC+qkxjlajVqXgMEUFJ/QllPJOruDnxXg3ggzL4TY7
         +6LL/1B114r3QO1M5CUNOoAde9pwXPu6wpP3pqIQBuUAfDRD91yZjv2Uki7TWf8bjuZH
         Tu4Y5rpgL2EPik+SeW+jLvb0W6QgUspJuMGj+Azcy42nR3t3rk5KH/a41BcQxCgbvlvc
         yy5eaBvAQ3RQYfLe1g/aQdiu1vVRkBvuB0NTQrlf5yib+W9qow9KG6hgyavejfMwyO0o
         XJ6rixTeXbe9nULje4YDOVNwmcGJYBuLJ6uWgAd3YhdSiA/bOgANCDUCFrTgKmVqu4Z9
         4eLg==
X-Gm-Message-State: AOJu0YxqTxV3nct6yxzjSRkgM4cMbU/8C/XD/8HypGkSX9U5WO1HvBQ+
	GIBr7Nz15r71wB/epdMubPQENL/2owE=
X-Google-Smtp-Source: AGHT+IEzImGVXSVpTXznKDmd2o6DQZsPtF1k2vmqUSVTinL7IQ7lFG3oi1WOoIhZxFnzRZjVo2WFdA==
X-Received: by 2002:a05:600c:1c0a:b0:40d:6582:4729 with SMTP id j10-20020a05600c1c0a00b0040d65824729mr1159257wms.130.1705088997494;
        Fri, 12 Jan 2024 11:49:57 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm10569337wmo.28.2024.01.12.11.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 11:49:57 -0800 (PST)
Message-ID: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com>
Date: Fri, 12 Jan 2024 21:49:53 +0200
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
Subject: wifi: rtlwifi: Speed up firmware loading for USB
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

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/efuse.c  | 65 +++++++++++++++++--
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |  4 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  6 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c    |  9 +++
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  8 +++
 5 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 2e945554ed6d..870a276299f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -1287,18 +1287,73 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 }
 EXPORT_SYMBOL_GPL(rtl_get_hwinfo);
 
-void rtl_fw_block_write(struct ieee80211_hw *hw, const u8 *buffer, u32 size)
+static void _rtl_fw_block_write_usb(struct ieee80211_hw *hw, u8 *buffer, u32 size)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 blockcount, blockcount8, blockcount4;
+	u32 remain8 = 0, remain4 = 0, remain = 0;
+	const u32 blocksize = 64;
+	const u32 blocksize8 = 8;
+	const u32 blocksize4 = 4;
+	u32 i, offset;
+
+	blockcount = size / blocksize;
+	remain8 = size % blocksize;
+	for (i = 0; i < blockcount; i++) {
+		offset = i * blocksize;
+		rtl_write_chunk(rtlpriv,
+				START_ADDRESS + offset,
+				blocksize, buffer + offset);
+	}
+
+	if (remain8) {
+		offset = blockcount * blocksize;
+		blockcount8 = remain8 / blocksize8;
+		remain4 = remain8 % blocksize8;
+
+		for (i = 0; i < blockcount8; i++)
+			rtl_write_chunk(rtlpriv,
+					START_ADDRESS + offset + i * blocksize8,
+					blocksize8,
+					buffer + offset + i * blocksize8);
+	}
+
+	if (remain4) {
+		offset += blockcount8 * blocksize8;
+		blockcount4 = remain4 / blocksize4;
+		remain = remain8 % blocksize4;
+
+		for (i = 0; i < blockcount4; i++)
+			rtl_write_dword(rtlpriv,
+					START_ADDRESS + offset + i * blocksize4,
+					cpu_to_le32(*(u32 *)(buffer + offset + i)));
+	}
+
+	if (remain) {
+		offset += blockcount4 * blocksize4;
+
+		for (i = 0; i < remain; i++)
+			rtl_write_byte(rtlpriv, START_ADDRESS + offset + i,
+				       *(buffer + offset + i));
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

