Return-Path: <linux-wireless+bounces-15301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8749C8EC7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D21F22060
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474519D8BE;
	Thu, 14 Nov 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fik7Avny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8118D65F
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599173; cv=none; b=ctxh7+2K8Mr9COHEyCmx1sa/0iVVtDOfYRm/5vcDHeuFyI50xJvPqpUQ+Lt2o8SqByGYvmDWjhi3ZxGWpHr2OnnDrwYh66qV6/1M74RPp32IUghQM0xsduxUR07jSykdKpJ1lMRuNLEe9SdaduTa6+MBTdVI234/evwIeGq5A5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599173; c=relaxed/simple;
	bh=XRQF06g2uM9T71fRMMCmTtLAcL05W+Vnohf7gqnaHx4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l9yyfjNxpe6+DStuvIl4NsxpwL6U73G/2H1tlAYnQ4ndWGyLCKzASeJqzz9OB+Avt8Av9EGWLIQYGoxP4tYwh9bVVGN3/zJQmSkVLiiNxYNRNluNgVTxlni4g+QQ/NcDBJ/Mjo83jJbrYnDPIYKjw1XSKxzERtVwDFnBK9jDOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fik7Avny; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316cce103dso9105445e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731599170; x=1732203970; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8O9jE5CsUMWDUfZMCDR4R1JYcvS1RvyXqx7RJWZk9Q=;
        b=fik7Avny5JujlZ955+gPAtN50g4aCskiiG94LzKVg9GQlZHqz5Bv2xa47pwwn+oi0b
         8TvNkvqcIu3Kknf48lYsLFMG59aiuWxz43l5rDfFD/+7Av/r79ZUqsd7fCbi3tvt9ucv
         kTXvOrh8mCbJ9CVIEdTfmgTMKwZoWUZIo0OXUeH+GjGhiapQHyE0UA9M2fAaZ90js14G
         6HD8X+ozaoJwGXDXujzDx2rlc5kcVGae3T/KhogNecsnrkyKnBrRCq0djO/3H6JKFq63
         mqm69Zq5x+NyQhyuuQ9MbtJ7arwdG+4TXjgGlWnVA4rFO04UbH6Hvtip/RiLbmtmns0T
         Au2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599170; x=1732203970;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T8O9jE5CsUMWDUfZMCDR4R1JYcvS1RvyXqx7RJWZk9Q=;
        b=M20yvoF90jvifvr4fma2oQ9zW2mMvDLcLrawFblQKgWlxMF1B9Zl4A+5QL2VZ9G9oh
         3mgNZ/r0RHDv8yn/d7Rsg2R/CwsBeEegk4rCpaMst20VyPiqaTmFKuE4ljcxyyDyBycn
         1PqUQxtAiy9Z4B/DscqRlefrv6QwcHxLRb/zbsFf/hD2auaEyyR3yEZ9G1+Gzo4h4/TO
         z59dTCHc1OFq3L3EPxsb/hZhABxDRgLmsN6KAh6bbqZkKLvD8yKuvr/ojJbsy/9npTpu
         WWAtGweyrGMpuuNff/dy6Dwseg0lAg68gOBT30ib+wVrVHtgRC8/Q32U47Qn4YBib++7
         WWGA==
X-Gm-Message-State: AOJu0Yx276RMapgXXMpm+5hwyXBKXmgAlqSfa5h/o12faccOU9aj3xaQ
	guoc4UT1Nqt41WT2jDUzi+YKKbjD8pU7H6mNHfYDxc6f2oCDiplZM7NhXg==
X-Google-Smtp-Source: AGHT+IGbKeZZkL2fGsBhjLs4ikwwp13GjAio/FtrekKg9q3Vol/8TAhj7ICh7J1fGcF3V5n/YU80pg==
X-Received: by 2002:a05:600c:3d16:b0:431:5c7b:e939 with SMTP id 5b1f17b1804b1-432da790770mr28766015e9.18.1731599170006;
        Thu, 14 Nov 2024 07:46:10 -0800 (PST)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm24535635e9.12.2024.11.14.07.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:46:09 -0800 (PST)
Message-ID: <19cda72b-f1f1-4b69-8369-0e4376b646bf@gmail.com>
Date: Thu, 14 Nov 2024 17:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add the function to automatically switch the RTL8812AU into USB 3 mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add functions to check if the chip is "old" or "new".
---
 drivers/net/wireless/realtek/rtw88/usb.c | 44 ++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 6fa3c37205f5..6f64c3fd96ae 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -931,6 +931,32 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static int rtw_usb_switch_mode_old(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	enum usb_device_speed cur_speed = rtwusb->udev->speed;
+	u8 hci_opt;
+
+	if (cur_speed == USB_SPEED_HIGH) {
+		hci_opt = rtw_read8(rtwdev, REG_HCI_OPT_CTRL);
+
+		if ((hci_opt & (BIT(2) | BIT(3))) != BIT(3)) {
+			rtw_write8(rtwdev, REG_HCI_OPT_CTRL, 0x8);
+			rtw_write8(rtwdev, REG_SYS_SDIO_CTRL, 0x2);
+			rtw_write8(rtwdev, REG_ACLK_MON, 0x1);
+			rtw_write8(rtwdev, 0x3d, 0x3);
+			/* usb disconnect */
+			rtw_write8(rtwdev, REG_SYS_PW_CTRL + 1, 0x80);
+			return 1;
+		}
+	} else if (cur_speed == USB_SPEED_SUPER) {
+		rtw_write8_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT(1));
+		rtw_write8_clr(rtwdev, REG_ACLK_MON, BIT(0));
+	}
+
+	return 0;
+}
+
 static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
 {
 	enum usb_device_speed cur_speed;
@@ -980,11 +1006,22 @@ static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
 	return 1;
 }
 
+static bool rtw_usb3_chip_old(u8 chip_id)
+{
+	return chip_id == RTW_CHIP_TYPE_8812A;
+}
+
+static bool rtw_usb3_chip_new(u8 chip_id)
+{
+	return chip_id == RTW_CHIP_TYPE_8822C ||
+	       chip_id == RTW_CHIP_TYPE_8822B;
+}
+
 static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 {
 	u8 id = rtwdev->chip->id;
 
-	if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B)
+	if (!rtw_usb3_chip_new(id) && !rtw_usb3_chip_old(id))
 		return 0;
 
 	if (!rtwdev->efuse.usb_mode_switch) {
@@ -999,7 +1036,10 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 		return 0;
 	}
 
-	return rtw_usb_switch_mode_new(rtwdev);
+	if (rtw_usb3_chip_old(id))
+		return rtw_usb_switch_mode_old(rtwdev);
+	else
+		return rtw_usb_switch_mode_new(rtwdev);
 }
 
 int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
-- 
2.47.0


