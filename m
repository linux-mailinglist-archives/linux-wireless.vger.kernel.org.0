Return-Path: <linux-wireless+bounces-4082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248FC86903D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6E71F21108
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374B13DB87;
	Tue, 27 Feb 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTipjWCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFD13B28E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036306; cv=none; b=Ftf+EwaUlQJRfFMqVK5N5Cm1dtymCMl+vRYL4m10bIorn+gXAd/kKGb0eAhLu+PmgrGsxGTRCFqlI7iHTA8HAze0ROvoEeeqtq2VyX3NV0N/LgEG612SaD3xJu0C6hsZHaXL3sOSPmzxl9bfYGt7R9ikU7Kc5R334l1S6k5fITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036306; c=relaxed/simple;
	bh=dDp/qw2ylsyt0/DErKDJpw/jlFxVReNwnvYsSO2nDd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=t9x4og24DVCgdPNtjOdZ8d4kC8SbWC33vY14yWPBGP31i7VVuimJmEsmYZdtkV7chI1ZnfdmlJ79rm+2cRPadv/CHzNklChFCrUMa2E+bGOxM0I/RJqTO/xf3ov9qrpR8YnPcL8lc3quc9IW+L/bVtYgFaBod0bOvgsHJTjx3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTipjWCn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so5381679a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036302; x=1709641102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7rOwWhcPG8trPkhoq+V5n2+RCXcnonYxMv5l4SIdCc=;
        b=lTipjWCnK8sE/2OfxFAOaFIKFzz8ZlJivFkqOx4b++37eymU3Kok4DHkH8xf65Qn1P
         CdB7ibfRaQRYI/1os9ElLyx6OM68U3jG0DwKRtDs2kacQ/psd4j7yP0peq3BvoVj+s5k
         408ratYLAdISktuD2q3kYdGMqBjJuAgYbc2SrDHJKtQ+ihsJVcjjQfR8lyFooNNMXkvf
         SPZF113Tq1S8h4x1GP2Xhl8R3s+nX++6FTCDm5JBUJjycWydYuwI03T68CUDnFlsUlg1
         MV7aehSJBKewQt+qhNQwRT8D2nK2tzwMTAiYqE2kCdayPW5F6faF9b967KphMicR0ZQX
         44sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036302; x=1709641102;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7rOwWhcPG8trPkhoq+V5n2+RCXcnonYxMv5l4SIdCc=;
        b=axuD/VdIVZz1dPVIUZNJsZIZq/wbyuJox778LZhQkvLKwcD5ZT1Q4fXbqh6sQfkQnF
         DseTcdel9mq4jDyZsSc0kwGA1flkuoTQHSLTIl8001jHZWih7N4/5E8Oz9qnXGoA/xEr
         OCQvh9WNV26eSLmgJykWu9eGoRGXN0CgdmZDh4f/vS7YjCTRaE0xhtSQzQPmzTnuW4Xl
         jclIIQHd2bD1RgnhZSnrfDI8osQ2Hk0FG5m22NxtklKTl58dGmP9KNBOkI4lrtQ25pG3
         tqz4rbcp+ZEfFIf3QYfaiMiA9KAt3oNGhx53qYHdsfTeObPwT4BAUTM407H5pLnxIpzu
         G/hA==
X-Gm-Message-State: AOJu0YzPaJOkxfOP6lk1y6zBBu2ZT0TIZp/YlzoMyLlUQZ4PNIWsGe0l
	j1xBDsHYxfNyhPeHN2EZ1lHh6jAdRp8e5pUg7gjes+jtpsnY+mSKmvJQYr9Q
X-Google-Smtp-Source: AGHT+IFWXyuo8btriyrstLpHaSmpf43SfaM04ny0VcQYPeBYFB5/HpG0ePMqJ85oqfIWbnl5qktj5g==
X-Received: by 2002:a05:6402:3587:b0:565:a607:6c31 with SMTP id y7-20020a056402358700b00565a6076c31mr7309350edc.12.1709036302349;
        Tue, 27 Feb 2024 04:18:22 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00566317ad834sm681406edb.49.2024.02.27.04.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:18:22 -0800 (PST)
Message-ID: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
Date: Tue, 27 Feb 2024 14:18:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Content-Language: en-US
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
 drivers/net/wireless/realtek/rtw88/usb.c | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3c4f28c306a9..ff01f7056ca9 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -33,6 +33,42 @@ static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
 	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
 }
 
+#define REG_ON_SEC 0x00
+#define REG_OFF_SEC 0x01
+#define REG_LOCAL_SEC 0x02
+
+static void rtw_usb_reg_sec(struct rtw_dev *rtwdev, u32 addr, __le32 *data)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	u8 current_reg_sec;
+	u16 t_reg = 0x4e0;
+	u8 t_len = 1;
+	int status;
+
+	if (addr < 0xFE00) {
+		if (addr <= 0xff)
+			current_reg_sec = REG_ON_SEC;
+		else if (0x1000 <= addr && addr <= 0x10ff)
+			current_reg_sec = REG_ON_SEC;
+		else
+			current_reg_sec = REG_OFF_SEC;
+	} else {
+		current_reg_sec = REG_LOCAL_SEC;
+	}
+
+	if (current_reg_sec != REG_ON_SEC)
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
@@ -58,6 +94,11 @@ static u32 rtw_usb_read(struct rtw_dev *rtwdev, u32 addr, u16 len)
 		rtw_err(rtwdev, "read register 0x%x failed with %d\n",
 			addr, ret);
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822B ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_usb_reg_sec(rtwdev, addr, data);
+
 	return le32_to_cpu(*data);
 }
 
@@ -111,6 +152,11 @@ static void rtw_usb_write(struct rtw_dev *rtwdev, u32 addr, u32 val, int len)
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

