Return-Path: <linux-wireless+bounces-16622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95169F7F43
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16D41885999
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AE13A41F;
	Thu, 19 Dec 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpouHdBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697E22616F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625239; cv=none; b=ae1CTmDdbZ5k2BVDsovu8CSWunNN8P1C8y2lwESdGOO1ISmCG9wIQtovUPjpEOrei3qhpagMTkZMheKheXj6CN5IzbSwLKXSt3SaSsmkowjZC2F5keISKfnJCXU9OJ12pgqVJgWoJZ1pVdRyGjqn2/Tsw+seqmeU/ETOEdScWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625239; c=relaxed/simple;
	bh=XZ6Xuf7QI/VK5JlR1JK2GTzOpxu+uwX008I4R9tPRhQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SmZhteloFnwY2YaeuwgPrienSaJ6SCTvrNVw+nbNRpwMmM0Bev2ZYnzk8Wk0q1jNZT4Sw55O5AJH+DVGYdRMiv+5CtWaa6oPzdMXmyG62xskpvnHGs89SWAUAD+Y6k/bhFsLHOsmxESyW7ZFjuIAMCocYPeZAM0eaWG/mxAu1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpouHdBv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so1221699a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734625236; x=1735230036; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQdhEQGRIs23woWXsk4JsTWND3mGSdYSOkrNAI18DAY=;
        b=SpouHdBvjEtYcvkBptc0hGY8On90AAu+BnWI+E/Te57XUojLoih2/gvc4aWr8D10lA
         pdpGPZs4VMW1W25ZqjokbDFpVN5QuEq8wOkIPI8ma/RxK6CwirQEOA/xKKceDtqri8YW
         NPsEIk4vjep2fskCpCgaHwslUmYcBfH3LPxpKy1V8Md5td/3Tm2s5ggfdnJtq2+3AN83
         N4gsqdtImkNGr6Iw8Nj+KxqgL0tTxtaBAKfbdIe3ylWZEttVjTEC8Mo/FBYdRfGhszCm
         5xVECjFy8L3Fpl9RgkA37b2x9dTtCZHP0A2WKinBlr4OadhhcprkPXGuN1NdLrdC7eVP
         gG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734625236; x=1735230036;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQdhEQGRIs23woWXsk4JsTWND3mGSdYSOkrNAI18DAY=;
        b=d8fq9gTgoWBomrrxOwKGyycc17EIt7mYw+2q92Yyr0uLpPuNY2/Ct6881zSZz6aEsL
         72domd6GuofQMXYcvbW+BTHEOT5ayQmnY97rqiEq8+N4w8gQ8tIM64SthKecl20PR3Yf
         CZchl1QYZnzcNBdH4O+RTykamcMGB+BLvrpJ8LkoApM+leSl3tC6tkwCIK4OtNRSIF7g
         CJzWfQJYc3t+1zgpgHc9P5nWaqGXMNQYonR/oHROa5YxkLl75ykCHNN036eMVBc9cq8o
         yUhLYv5yYOClwjemEs30YfZMgHq/7lqG32+Hfkt0qZBf/xjzPtykNEP9jpn96imI+GDl
         FX+Q==
X-Gm-Message-State: AOJu0YxduOeWy4T1AzBngPRNB+TX9fXhHbVvZ0w88E9GFqmbvf4wbkB6
	4Rc44DZbfW26dZQ5oVB3rPXmxPib98I0nybp91bx5b6QeExpTLv91rrJPw==
X-Gm-Gg: ASbGnctafI1eQx5aZPce4HKR41WlxQZ0e9OaPQLut1RV1NuCR//6o0a26kb4TM34k1S
	i3C3pXjw58B0H8PX/vsF3R3lCFP9bkWJAS4QSBmuLZ2lNhafGKJZLGbZER5Z7kXINj6WGXgLjRR
	tgADJdvwbx8OEKEAVAG780xI5MbeWelEOC5GqfFwdoNgPHStMclcVj6Qwv4ARunwSfZymXTGLTI
	BZfX6hoiTQqCOAaZKQzL/fVVc6+xStsng7eByKo07bTEbncNRnU7YCpTZTvshwB
X-Google-Smtp-Source: AGHT+IGo6URzZ0AR9yBJnie6hzCw4mEARVeYzupgXtwnZmLvQAxo1/Cq0TEUACHysc/ZjYLXp2v7BQ==
X-Received: by 2002:a05:6402:430c:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d802642b4amr8191401a12.28.1734625236021;
        Thu, 19 Dec 2024 08:20:36 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4206sm80501166b.117.2024.12.19.08.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:20:35 -0800 (PST)
Message-ID: <a3b87566-4e11-4fc2-8c51-db592e56af13@gmail.com>
Date: Thu, 19 Dec 2024 18:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: Add USB PHY configuration
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add some extra configuration for USB devices. Currently only RTL8822BU
version (cut) D needs this. The new code makes use of the existing
usb3_param_8822b array from rtw8822b.c.

A user reported that TP-Link Archer T3U in USB 3 mode was randomly
disconnecting from USB:

[ 26.036502] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
...
[ 27.576491] usb 2-2: USB disconnect, device number 3
[ 28.621528] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
...
[ 45.984521] usb 2-2: USB disconnect, device number 4
...
[ 46.845585] usb 2-2: new SuperSpeed USB device number 5 using xhci_hcd
...
[ 94.400380] usb 2-2: USB disconnect, device number 5
...
[ 95.590421] usb 2-2: new SuperSpeed USB device number 6 using xhci_hcd

This patch fixes that.

Link: https://github.com/lwfinger/rtw88/issues/262.
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index b405f8317021..b5ef7e31df19 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1127,6 +1127,73 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 		return rtw_usb_switch_mode_new(rtwdev);
 }
 
+#define USB_REG_PAGE	0xf4
+#define USB_PHY_PAGE0	0x9b
+#define USB_PHY_PAGE1	0xbb
+
+static void rtw_usb_phy_write(struct rtw_dev *rtwdev, u16 addr, u16 data,
+			      enum usb_device_speed speed)
+{
+	if (speed == USB_SPEED_SUPER) {
+		rtw_write8(rtwdev, 0xff0d, (u8)data);
+		rtw_write8(rtwdev, 0xff0e, (u8)(data >> 8));
+		rtw_write8(rtwdev, 0xff0c, addr | BIT(7));
+	} else if (speed == USB_SPEED_HIGH) {
+		rtw_write8(rtwdev, 0xfe41, (u8)data);
+		rtw_write8(rtwdev, 0xfe40, addr);
+		rtw_write8(rtwdev, 0xfe42, 0x81);
+	}
+}
+
+static void rtw_usb_page_switch(struct rtw_dev *rtwdev,
+				enum usb_device_speed speed, u8 page)
+{
+	if (speed == USB_SPEED_SUPER)
+		return;
+
+	rtw_usb_phy_write(rtwdev, USB_REG_PAGE, page, speed);
+}
+
+static void rtw_usb_phy_cfg(struct rtw_dev *rtwdev,
+			    enum usb_device_speed speed)
+{
+	const struct rtw_intf_phy_para *para = NULL;
+	u16 cut, offset;
+
+	if (!rtwdev->chip->intf_table)
+		return;
+
+	if (speed == USB_SPEED_SUPER)
+		para = rtwdev->chip->intf_table->usb3_para;
+	else if (speed == USB_SPEED_HIGH)
+		para = rtwdev->chip->intf_table->usb2_para;
+
+	if (!para)
+		return;
+
+	cut = BIT(0) << rtwdev->hal.cut_version;
+
+	for ( ; para->offset != 0xffff; para++) {
+		if (!(para->cut_mask & cut))
+			continue;
+
+		offset = para->offset;
+
+		if (para->ip_sel == RTW_IP_SEL_MAC) {
+			rtw_write8(rtwdev, offset, para->value);
+		} else {
+			if (offset > 0x100)
+				rtw_usb_page_switch(rtwdev, speed, USB_PHY_PAGE1);
+			else
+				rtw_usb_page_switch(rtwdev, speed, USB_PHY_PAGE0);
+
+			offset &= 0xff;
+
+			rtw_usb_phy_write(rtwdev, offset, para->value, speed);
+		}
+	}
+}
+
 int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct rtw_dev *rtwdev;
@@ -1182,6 +1249,9 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_phy_cfg(rtwdev, USB_SPEED_HIGH);
+	rtw_usb_phy_cfg(rtwdev, USB_SPEED_SUPER);
+
 	ret = rtw_usb_switch_mode(rtwdev);
 	if (ret) {
 		/* Not a fail, but we do need to skip rtw_register_hw. */
-- 
2.47.1


