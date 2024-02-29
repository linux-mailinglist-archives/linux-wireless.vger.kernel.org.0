Return-Path: <linux-wireless+bounces-4270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F786D6DF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22571B20E50
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01D1EB24;
	Thu, 29 Feb 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyS7vMYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC71E531
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245971; cv=none; b=umdk5pLjpNGd+mnINAbvPY528eBDF8sC/1d6aASQgrdbsluOukqIek1kBhk5H9ShPVRXzznBCxZRmWi5pf+b47s54AvQF5ws/Mn2qVAeCUUImDKvqaBT8yCicQBIiABtBLwFnM5Tb6rxRx+aqsuYHdwcaZK2BlRwhmgGWe3IrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245971; c=relaxed/simple;
	bh=6Lf6QcisGSJb9jN+FYFboIAnPn8rBJqoU2uteBNkI+s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=faS9YLwLuBN7x2gR8ajeXnznwlx13ao0c/Brks+evSbB1aVFE9mcaaYm79q3eIfkvhdUkEdkpIr1QRnAOolkI02IBWBj1k5KJwR8CAziOvVU2K91EPwmbzWvt3PsEfpS5EPxhPRKxhaR86TCmiwFA9EJ2UhBOA52WgvvyIoltgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyS7vMYS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23d301452so16051711fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245968; x=1709850768; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoeNQ8kAfls9o1BZEGh0fB/dpADJEynRThwySqfJIb0=;
        b=YyS7vMYSD65jAEbL5ZjZU1WlhMGRIWaRegFHPBdH1AJPC8cpZDqUvbpHGQiN1kk3GU
         gWtA2B2ZS7TX0fpsZOERkteYd0MpCUekiSCIqxck9qaVdeOSKkKiHBk0vn897v6epFYL
         SbRew45/0gELgfHvqKQXEkP7MWnpF6ZzV4EbVeWq9aOlhsTKWSkX7JKzL1H7u1BfS2Nm
         c1n3qF0g3Owho3FMM3Eg9Qgl7NL/XLKFQ39N4yOD2KAiBE2JNGepgYblNh1Dn/6WMp9T
         s6OdU868yFOGEAZGq3ZjnfgRQXTWiHOjDC5amUZK8XViWWj8SLx53gA8ZGw2w55d2xN7
         V7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245968; x=1709850768;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zoeNQ8kAfls9o1BZEGh0fB/dpADJEynRThwySqfJIb0=;
        b=WAkdVMGjKNMFmL6UbcauxOWoKiBHXqcJgrRJYQAcuvtiP5XZT4pu/BGaz9D3e5qaNx
         fzlnY2QXWOR9bMWOG45WmIbvzsrOppBPBq1WCDg9p6QxjS7Xx2FNiX65JlAi5DAw1Iw5
         rZE8VCYEECMKRgWvjCkrOr5wRN7Ps9vG+ZSdz7cieNMpj/lUpEKyIGIvCec7KHI/oVKM
         ZSnSG5RurAfBPnGlghq2QZLc0kc5KUfoBiAvQ3/3vWpzfRG+hr/PeWb+813bKkQColbT
         WaVm6WaZcFvdMM6n6eh1AmVzzC9EgvskLks9H66WvdCOS2bj9HyhL9xgXJ+Lbb0KOAKk
         92tQ==
X-Gm-Message-State: AOJu0YyBUAUMpSI3DQpqLgwjiW+KoFBgiZFBKPQnzdyMAQa0xSnOTWuh
	TBjMLMVd9tWsnKN8xlTI7W/ER6R95GPWF9JLek4uuHlM7+r1QGJlwQv0bwNd
X-Google-Smtp-Source: AGHT+IHxPcQw4iyH2grEpfpRsqz8MWVNiFjyRaQfZTkDd5w3+sRoKvdNW7Pul4FiTYi9lGVP1DGy+g==
X-Received: by 2002:a05:651c:10a2:b0:2d2:5668:3a40 with SMTP id k2-20020a05651c10a200b002d256683a40mr2588418ljn.4.1709245968042;
        Thu, 29 Feb 2024 14:32:48 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00412b68cc169sm3360442wmg.16.2024.02.29.14.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:32:47 -0800 (PST)
Message-ID: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Date: Fri, 1 Mar 2024 00:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Sean Mollet <sean@malmoset.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8822CU, RTL8822BU, and RTL8821CU need an extra register write after
reading and writing certain addresses.

Without this, the firmware upload fails approximately more than 50% of
the time.

Tested with RTL8811CU (Tenda U9 V2.0) which is the same as RTL8821CU
but without Bluetooth.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Simplify the code and add comments, as suggested.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3c4f28c306a9..3be6cbbf9ad8 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -33,6 +33,36 @@ static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
 	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
 }
 
+static void rtw_usb_reg_sec(struct rtw_dev *rtwdev, u32 addr, __le32 *data)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	bool reg_on_section = false;
+	u16 t_reg = 0x4e0;
+	u8 t_len = 1;
+	int status;
+
+	/* There are three sections:
+	 * 1. on (0x00~0xFF; 0x1000~0x10FF): this section is always powered on
+	 * 2. off (< 0xFE00, excluding "on" section): this section could be
+	 *    powered off
+	 * 3. local (>= 0xFE00): usb specific registers section
+	 */
+	if (addr <= 0xff || (addr >= 0x1000 && addr <= 0x10ff))
+		reg_on_section = true;
+
+	if (!reg_on_section)
+		return;
+
+	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				 RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
+				 t_reg, 0, data, t_len, 500);
+
+	if (status != t_len && status != -ENODEV)
+		rtw_err(rtwdev, "%s: reg 0x%x, usb write %u fail, status: %d\n",
+			__func__, t_reg, t_len, status);
+}
+
 static u32 rtw_usb_read(struct rtw_dev *rtwdev, u32 addr, u16 len)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
@@ -58,6 +88,11 @@ static u32 rtw_usb_read(struct rtw_dev *rtwdev, u32 addr, u16 len)
 		rtw_err(rtwdev, "read register 0x%x failed with %d\n",
 			addr, ret);
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822B ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_usb_reg_sec(rtwdev, addr, data);
+
 	return le32_to_cpu(*data);
 }
 
@@ -111,6 +146,11 @@ static void rtw_usb_write(struct rtw_dev *rtwdev, u32 addr, u32 val, int len)
 	if (ret < 0 && ret != -ENODEV && count++ < 4)
 		rtw_err(rtwdev, "write register 0x%x failed with %d\n",
 			addr, ret);
+
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822B ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_usb_reg_sec(rtwdev, addr, data);
 }
 
 static void rtw_usb_write8(struct rtw_dev *rtwdev, u32 addr, u8 val)
-- 
2.43.2

