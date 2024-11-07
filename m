Return-Path: <linux-wireless+bounces-15116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BE9C12AC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 00:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864841F210B6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8181EE000;
	Thu,  7 Nov 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqXeg9kA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D61F12F5
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022876; cv=none; b=VVHINKHY7F9QOdspl0fldeIPBQKRxTjeVDwmKKgcq9J71O4GSqIf5f/s5i9azeRlPDJDpUVvzq5FdyW3YZMkYh0754nbpdjYL1AM9WFHaDQEbkIKr4yX162CUfZDjdF0rGhEfqk3Ln8ZwGY39GGRYwjtgnSAZWqCE5Q4FdYLD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022876; c=relaxed/simple;
	bh=BoBGhXZ4IlplzxfHKisvd1d5TafzGo4a/091fM3XBi8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VVAAIoqHjVd3QcgOanOmlMpjDWHw+RFaDhMJkjC5rPckLXWlNnVG4fQBLcDHTDGsTMpkuXlj3lHUDbRYJISeaoGcOP1oUngMAJqCkM5eSS6Fxu5OlrYMUOwJoH7H5MvuqK98NGZNGfYAitldRwfUcCkK85IzvuJTjPNQ9/QsSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqXeg9kA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so14016375e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731022873; x=1731627673; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCDqhBJ+jq+VBXMID1YxY5Ae9MuvN2QzBbQMXEgb79s=;
        b=eqXeg9kAwtXlodePAeis8PTcGq3mSSAKSxmr4uImGcPXhP3IPGO4DEOJagpjIUFL5z
         0H7obXUAZpTZUGFo7ozypGYsk/wP7wkSxL6t1Y/vAidbkmiYZlDVckiCL8QqMFGSUoHW
         UJJoXb2Z87HvPVfIw9tdRdsuZA3imJaKQdcIUscNHo04ksfAiRD6EszXwPbW1RXnsWzm
         jOc9QbJ5MapZfBdDtSwUz4n6gvMoBClaB9aYNpWILtxA33fh0zaR2SQOOx/uU+f60ESY
         kkogEtrztPt/HZgQGkFsT+5/kCLFUss4cXz14hNnYxp7rOFqtABsLmdiZz0oymxN9XPT
         WvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022873; x=1731627673;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCDqhBJ+jq+VBXMID1YxY5Ae9MuvN2QzBbQMXEgb79s=;
        b=Ysd63uVsNVH6ScUzqHgyvfrz3ht4FGxjSSadBIkAyCAmYBSkolMfvJ1WLkmoby3MjA
         SEbTV5GuVmTlmNIMIUg0kFrUYoihL6dalgFbtah5NPxh/fIgZ117mRODMEO7sPLlNYI0
         ewfQazvWu/jiZIY+SRezBRKbQzS51Izj46sez2dSl8laVYX4JxUJ4KJDBZoevR4su+6Y
         nbPNx96mImQQvew8m9vyLetRm2FeK1ruoT4kG8ygCHbBpOfbLXkzWuU6tKpjVDROYyFG
         6e/8wkQx/q8laswbwFZGTrOoJqOxOIdEqVGIKX73zflN3EA15ddOsKkShTKZQzj6ORqm
         y34Q==
X-Gm-Message-State: AOJu0Yz/i/yrQrm0tMm7xcUdadIbbDHHqkgUI2fQait/OcZT2nk1yBWf
	H4oQGs4PVDiT1wtzOR06jHeHiVMp4ra2UV3H0YsUxfK2C3TqkdSFFiQGOA==
X-Google-Smtp-Source: AGHT+IFJI4jp0NhwJggxt6zfe4J2EMQAvtgkY4yvnmEPTSquKasSZd/5eGD/3DgzWUWQwpDsBDZmdA==
X-Received: by 2002:a05:600c:3c8e:b0:431:1a98:cb40 with SMTP id 5b1f17b1804b1-432b7508b23mr4902655e9.18.1731022872607;
        Thu, 07 Nov 2024 15:41:12 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e2a31sm40239335e9.36.2024.11.07.15.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 15:41:11 -0800 (PST)
Message-ID: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
Date: Fri, 8 Nov 2024 01:41:08 +0200
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
Subject: [PATCH 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add the function to automatically switch the RTL8812AU into USB 3 mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 6fa3c37205f5..752bca05b9af 100644
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
@@ -984,7 +1010,8 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 {
 	u8 id = rtwdev->chip->id;
 
-	if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B)
+	if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B &&
+	    id != RTW_CHIP_TYPE_8812A)
 		return 0;
 
 	if (!rtwdev->efuse.usb_mode_switch) {
@@ -999,7 +1026,10 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
 		return 0;
 	}
 
-	return rtw_usb_switch_mode_new(rtwdev);
+	if (id == RTW_CHIP_TYPE_8812A)
+		return rtw_usb_switch_mode_old(rtwdev);
+	else /* RTL8822CU, RTL8822BU */
+		return rtw_usb_switch_mode_new(rtwdev);
 }
 
 int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)

base-commit: 1f3de77752a7bf0d1beb44603f048eb46948b9fe
prerequisite-patch-id: 8b66ae2bfbf46f30a9c17b37423ea9f42f3e56c7
prerequisite-patch-id: a700764f0bfe91e9a17bfe194ffef9b59d8cc994
prerequisite-patch-id: aa91f11d43dbf3e0081fb33022fdf623b2e1fe41
prerequisite-patch-id: fff3a9dafec3b293c8c1c3059ab8c85ed8d51af2
prerequisite-patch-id: 05bc1efb4d16788c5dc7a82a5fc02ebc2c40b9bb
prerequisite-patch-id: 33acc0f39fc264666ddc16e371f4190a117b9b0a
prerequisite-patch-id: 586a4c77227a0942032a70d7752328906f5c2353
prerequisite-patch-id: 9005f7599ce3819f952955e356f2971f942491cf
prerequisite-patch-id: 6565f68bb43594f2e3bbd310ae6d1e10aff52ba2
prerequisite-patch-id: 247a49275f81bc0ea4704813c845d0f4b212b4fa
prerequisite-patch-id: cadb4f3eead80e0b8dc21c4976df6e3d4eed4411
prerequisite-patch-id: bcc4b916fa66e3a1f8830ed91ae66d0edc792c27
prerequisite-patch-id: 61bd0f9fa3727495e0b575699c572e9028add725
prerequisite-patch-id: 67db016e612870e24bb50686c7b8382df78a3b3b
prerequisite-patch-id: 241b9366e96914fdc3736ca3a694a2b7b645c25e
prerequisite-patch-id: d2a9596fdb06a0be72a8810108854ea059b20ac8
prerequisite-patch-id: aa2559586159d347d03e247c6ab1752c7766b198
prerequisite-patch-id: 7981f49a43504646fd84b1b3adf995a736bc33eb
prerequisite-patch-id: 0ce4cf3b765d24fd438e6ba64b89e1b72048b65d
prerequisite-patch-id: c6ac89babaf69252ddbf1717138067c8ab3b0e77
prerequisite-patch-id: 74d3154402984209896914648e007cffe37bdd3c
prerequisite-patch-id: c36cea8efa84a07a046ea2932e1cc5d0eebc467c
prerequisite-patch-id: 479974f2c2409052c0c8448cd27a3fc73b8e73d0
prerequisite-patch-id: b60b6c409a2e5927ac7a49098b001071ce43f3fa
prerequisite-patch-id: 9e4bfe239b896239676462a48d32dacb209a56a6
prerequisite-patch-id: f1b3646b39c10f1f161375b8b776f6b66b8f33fb
prerequisite-patch-id: 736ad8d856f1cc2a83255a011d2db3460f1e85b1
prerequisite-patch-id: 48d62dd217e39eb066b3a06b194b4e381793127b
prerequisite-patch-id: 238957a0ff4ef34bbedf672ff67da8d662b01a67
prerequisite-patch-id: a5449cf3f19fa1b121198019fdb22fa0b6c48a49
prerequisite-patch-id: f346f8594746643ef30be1d361dcdacfb5be4e3c
prerequisite-patch-id: fb031f6f42836fbe1d60763a58b35097a2e9457c
prerequisite-patch-id: e29ec9929e742da830e4ee1fa808829774d8ee6a
prerequisite-patch-id: 0829766dcbc11378cad6c756a6cafd93070b992d
prerequisite-patch-id: 5dd8ec4c6093fd9a1e1737f9ba869ef3d188d5a2
prerequisite-patch-id: a680a3f9bf6c1588e3a62a17522be06a3cdeb079
prerequisite-patch-id: 07c39d390fb61e4eb8e80ee5f3836767a3f6680b
prerequisite-patch-id: 672a373a86d7a211e85859237d243347a2d13ce0
prerequisite-patch-id: d2e00f128353188d030f39b3658451c57bd9c913
prerequisite-patch-id: 7df183849b8a6d64f52d078856eb831e9634b566
prerequisite-patch-id: cd152cbdc8c9de5873e98789abc4caea7dc1c870
prerequisite-patch-id: 4818acfce4e354055ff924b0b89001d0e217cdc1
prerequisite-patch-id: bc0a866ecbe4ed2a47160ed7f4ccc873363f563e
prerequisite-patch-id: e8143557e487ccfe2e47984b2180fcc073809918
prerequisite-patch-id: d63803c13783916dfb1b749eeb1489375a7eb430
prerequisite-patch-id: 99377bd088a6e29960512c992d8230696d738590
prerequisite-patch-id: ed2518483f01f0318d05340c810dd00fa9ef11a6
prerequisite-patch-id: a8cf4b56e129d2f3c45f81c14cfa2303c4390b5d
prerequisite-patch-id: fe466966970d814fa39e382576d81581a12bccaf
prerequisite-patch-id: d93663ab1bf75a8195e277ee3a9ab94a8d7b2549
prerequisite-patch-id: 525e477a3d2b1ea716c1f4f11541b682d63b3cb2
prerequisite-patch-id: 1de02a8e6dcb59729482d47530ac88395cd170e1
prerequisite-patch-id: 0b210cacbae1c807bc8c451810694cbf04022b25
prerequisite-patch-id: c931ac7fbeed6e2726e13c9a6e2d9b3464b95c12
prerequisite-patch-id: 0aca217593ea6baafd4b06b6c0f9afbf072c6b3e
prerequisite-patch-id: 1459cd218e055ad892ace18ed623eba0f5edbd77
prerequisite-patch-id: c7fe9e344191cd37d3f9bc91e005efef0bec334f
prerequisite-patch-id: d663885e71ace7de915daee73c450a85ef4daa8f
prerequisite-patch-id: 3cf29e3f9c292f4eca2e6393d98670c216a22f41
prerequisite-patch-id: 182184449702b94beeade2526e691ea4c4eef7ed
-- 
2.47.0


