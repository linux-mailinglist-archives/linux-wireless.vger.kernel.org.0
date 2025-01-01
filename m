Return-Path: <linux-wireless+bounces-16970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9969FF481
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046D01617F4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB12940B;
	Wed,  1 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OARZSN0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7F1E1C30
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735748198; cv=none; b=kL9g8EQDCbF6SfLHsNZO82T7ZztWaTtlZDqd+Rph5Nuw0Zuyksnfb5V9w/DMDjHnlnVvsxs16DkkxfX6f1W67IbTjl7GO1N4s23RgO9aENNfq2Ax18mwhcADMulzOnlb9GSa1keeXl0w/AWo1PsHAZXM+Fm2fJGvbz0TBlSrZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735748198; c=relaxed/simple;
	bh=FXUzQ8mclQWuoxbOV542GPvpmQzwnLklZNdh1c5nrEk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Isboo0o1uRBvLHOH1XSoAXeVDp5tLc+c3W2TtDKj5RjMxwc83dao8eYz+IGcp91LgFoYOPP1HR+mOVzeeub23rJoSRQ66NlzjTNsfNFMi0jXukl/kADXcjHqWqIXt1CV1FeY0bl3P1tBMKM4hZmW5RLhYfLDHcQtJ9/P6NlKrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OARZSN0f; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso1680714266b.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2025 08:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735748194; x=1736352994; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXvzlAKy4CJt47xjbWvhl8GMnxO0+Nkw8SXfMTqC94E=;
        b=OARZSN0fvpPpPOSH4TwqwUOVA+wEixpmcUiB5KFfRguGPfW8vAJbwxAK1y7OWYBORf
         zqDBPma0aajp4ZxefGrkf6aILewaQ47aL8mc4AfpLRh98Q4dsIvj5L/zQlkneR9REX7G
         7yY6CvliOPxgn3EbnmZGgVQSM5Bzz0ZzmkyHFg3WkNxP+Cf5gQ2uyUnOIhjEGbsYR51o
         WLcaPYPkTgDt9Y4j2n2kdySq1AP3GvmyJoM4lrdcCjxyJUwIe/9iITz0kaIHMSgPWbO+
         bYyrUHOL0vMU0OU4Xx9nV1G5yMIztdVAtUqrd2H4bY/MzX/vW9D5ySaA+BFOcqAjniQj
         ZcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735748194; x=1736352994;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXvzlAKy4CJt47xjbWvhl8GMnxO0+Nkw8SXfMTqC94E=;
        b=msq3I3zqo9L1U/l/iNlO01hMPBf7ah8qbRHyuuI7SNjgR1Sf1dFhMlh5LPUAPUo7ET
         ysF0UFKXHMCTJL/8PzybyiwU1ib8O0k52dpFBE9/RwQ0+AQjgMzAxbSinSkT2BNOk4kW
         96/pDnRQOj+Jm046TCH9o4kOBVjNbjYmQy7bQl5rBH9DdkSg1bGmcC8S58FJ33tG4FKT
         Uy/AW2qEyEd5DNzCoahcquJCGjS7Q7WB/KKDld+OymR1O24sgzNTlb/6KEuJbwzVXf8O
         tPGG3Yo2mayYVeOCtvQQ0zM4SQRH4+X6pC9rghl/NAHE74/3su/4l6Jty0cl5X7tnz22
         12Ww==
X-Gm-Message-State: AOJu0YylLU5kIMSGjmyDEbtyPw8c1syi0HCMZVZPBbvQdXqBfYA8qG9N
	vTz4YELTNKSgxY2MKDLN+vX4C45h3sK2MF9pY/peAtuB+G76UiCLeE2Hxg==
X-Gm-Gg: ASbGncvivmGC28M3vSG6jLzZpwAjRpHLEYKMYifBjosZVA22mQVpGpr+4rAglFQyUvr
	hlmxMe1x5vuymB5pqH0Dp3/Jlb0vFkQfI/rNw56fSKTQxzxck3l5t84ziCOjHuNh8sbllH5XTZm
	Y4UktBF1BHTdiNvbq7H4nORMx+llngnRAr5itU+J4FERlGsy4lxmAiRUdugOwFK/JJyvzMjtUx2
	82b+92y7F8iJOlrVtH6dcKf0VAWlbd2smsatlsQQ6gzWMZIegjRs4/hYwSGUBdY
X-Google-Smtp-Source: AGHT+IGxFJDhEsuyjLP/3NuaOsv064sPIXXdkLqmzlQlhVPQK12/8hrgTWwMvf7P5AJN6Utey1Q1Ag==
X-Received: by 2002:a17:907:2ce2:b0:aa6:873b:ed8a with SMTP id a640c23a62f3a-aac33549f8fmr2562127866b.47.1735748193967;
        Wed, 01 Jan 2025 08:16:33 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89595fsm1712004366b.66.2025.01.01.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 08:16:33 -0800 (PST)
Message-ID: <9d312b14-0146-4be8-9c50-ef432234db50@gmail.com>
Date: Wed, 1 Jan 2025 18:16:32 +0200
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
Subject: [PATCH v2] wifi: rtw88: Add USB PHY configuration
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

Link: https://github.com/lwfinger/rtw88/issues/262
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use names for the USB registers.
 - Get rid of the cut variable in rtw_usb_phy_cfg().
 - Make the addr parameter of rtw_usb_phy_write() a u8.
 - Remove unnecessary cast to u8 in rtw_usb_phy_write().
---
 drivers/net/wireless/realtek/rtw88/reg.h | 10 ++++
 drivers/net/wireless/realtek/rtw88/usb.c | 68 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e4d506cf9c33..95a39ae74cd3 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -871,7 +871,17 @@
 
 #define REG_USB_MOD	0xf008
 #define REG_USB3_RXITV	0xf050
+#define REG_USB2_PHY_ADR	0xfe40
+#define REG_USB2_PHY_DAT	0xfe41
+#define REG_USB2_PHY_CMD	0xfe42
+#define BIT_USB2_PHY_CMD_TRG	0x81
 #define REG_USB_HRPWM	0xfe58
+#define REG_USB3_PHY_ADR	0xff0c
+#define REG_USB3_PHY_DAT_L	0xff0d
+#define REG_USB3_PHY_DAT_H	0xff0e
+#define BIT_USB3_PHY_ADR_WR	BIT(7)
+#define BIT_USB3_PHY_ADR_RD	BIT(6)
+#define BIT_USB3_PHY_ADR_MASK	GENMASK(5, 0)
 
 #define RF_MODE		0x00
 #define RF_MODOPT	0x01
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 1572b61cf877..c4908db4ff0e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1128,6 +1128,71 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 		return rtw_usb_switch_mode_new(rtwdev);
 }
 
+#define USB_REG_PAGE	0xf4
+#define USB_PHY_PAGE0	0x9b
+#define USB_PHY_PAGE1	0xbb
+
+static void rtw_usb_phy_write(struct rtw_dev *rtwdev, u8 addr, u16 data,
+			      enum usb_device_speed speed)
+{
+	if (speed == USB_SPEED_SUPER) {
+		rtw_write8(rtwdev, REG_USB3_PHY_DAT_L, data & 0xff);
+		rtw_write8(rtwdev, REG_USB3_PHY_DAT_H, data >> 8);
+		rtw_write8(rtwdev, REG_USB3_PHY_ADR, addr | BIT_USB3_PHY_ADR_WR);
+	} else if (speed == USB_SPEED_HIGH) {
+		rtw_write8(rtwdev, REG_USB2_PHY_DAT, data);
+		rtw_write8(rtwdev, REG_USB2_PHY_ADR, addr);
+		rtw_write8(rtwdev, REG_USB2_PHY_CMD, BIT_USB2_PHY_CMD_TRG);
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
+	u16 offset;
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
+	for ( ; para->offset != 0xffff; para++) {
+		if (!(para->cut_mask & BIT(rtwdev->hal.cut_version)))
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
@@ -1183,6 +1248,9 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_phy_cfg(rtwdev, USB_SPEED_HIGH);
+	rtw_usb_phy_cfg(rtwdev, USB_SPEED_SUPER);
+
 	ret = rtw_usb_switch_mode(rtwdev);
 	if (ret) {
 		/* Not a fail, but we do need to skip rtw_register_hw. */

base-commit: 104372ff359486b26b5a2db33b8e1dc6bfb39812
prerequisite-patch-id: ffa5686d26c03c3bd942dd0e0c4e85d6cc1141c0
prerequisite-patch-id: 5fe117f3707ee7525549baaeea323157019be897
prerequisite-patch-id: f733af9c741a3e02f8dd374a402da4b07c51f97a
prerequisite-patch-id: 26c5a5c5739a581686f97ff17916b9c641a0d189
prerequisite-patch-id: 73580f2822eceab5e3a1d7291beebd362b9af45f
prerequisite-patch-id: ebd38e2e7e1f7731046d8641dbaaa2bcc9a385fe
prerequisite-patch-id: ebc85d1f7996a01b46f27e78dc6ebfb5c5a8c013
prerequisite-patch-id: 4cb1a033c2beec35dfbee0cddb8c8d1df80f2994
prerequisite-patch-id: 3887710d4f2069a49bdeb35d6e17144fe9da9c84
prerequisite-patch-id: 6b23ff2c45082cbce357c8547e5582455b160649
-- 
2.47.1


