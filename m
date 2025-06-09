Return-Path: <linux-wireless+bounces-23901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D1AD26C1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B6718899A6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325438DF9;
	Mon,  9 Jun 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkqvpSEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290101922DE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497461; cv=none; b=mppsKsAxH/jg84jDoD7As4SpMgSg+kmHycUK0f+AmE4ruHqoNjuM1Hp7KTWQzrgQ7fdy2tDnkSemSsj9C0rCpx00Xf/QM2Lg2M7sdHkVIbMI/RriIoSnfXKqdDV/aqhQH//WJuw5wTZa8a2hInP4OqHLDrN2asd/ti+Xbp06dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497461; c=relaxed/simple;
	bh=sjOS9BvWK4Ff1PVy3tWbKqqFcpv4Yg/MaSTsalGwT4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P4CsebjPdL5X1de68uMb4/CEWiP1CFuL7EgB5N0lwA0BVZW9efyeGt03WNVd2g3b3+yVZxs787PxX5P3v+gGE0OvCxirVTGmR3ehJj0c1YquVFjOnx0aQdUnzQe+g1lsPkQy24aFwqwni9LkbbrHNPEEd1+YU5zOxKKzfQILp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkqvpSEB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso8854458a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497458; x=1750102258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpgMDw7+UB0ghKc7XG8oNg+m14V6ExUUFK39B4WKBjY=;
        b=WkqvpSEBebElpqGM6UwmQp5wSgZWAOUt8TfMOQ5IIjksY9d1D/PBZu6uij+v+dqnmB
         AD1nv8IjrwouVuvWPLTRKq787cHHiVg9su/9ATUleBmwpoWrmvt4cwYqRPSi2NKwVcSA
         +Iar+dhTqJINVt/X+8ICwx86zgpLw0+2XfW/rzm2i6nYg7CUy2SMGaiobKcCuU7in4Dm
         lqXxonY6thy+bq4nOzRQf9pY7F+1tdH95iVtsYPEutfBuM3HJvq4+F35gg/7B2B6Twu8
         O9gdiOxL6oH2TwNjhz6LeDhECJlxG6EZnT4vcv7aQpLipoBrLou0yOBmpyJBlzUiTgpa
         6RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497458; x=1750102258;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpgMDw7+UB0ghKc7XG8oNg+m14V6ExUUFK39B4WKBjY=;
        b=wVyi6y1oUdp89/2zJExlE2Nr33J/+IBFXrvHPn10BltZQcmLN+vh0F8HBvpyCfY6HP
         RsU3CxLIQG+4rjBC3RtQ5MmQ4IWry/Tvp3xINL7DG1Jwld79bzdq2g87RmCjsNWDpafk
         WxWDKe6ixHcIAWFEYJ4n/uG9+R9hABSK1ObukvAjMMvgWzYZDamA3+i9ryq9kW756RdC
         XNqouPQJy88jdsVZfNrRZFtOg6pyCENd1fo3LaF0TZMGSDm9+UJFnUm0TOY2VMF4FG0F
         76eF/xAucz5jCclv6wLdvWi1sVyIW6Xl2CqldWdVZHe13YQ3bMVpkEl+lFEh5Q/MFVR2
         Y+Wg==
X-Gm-Message-State: AOJu0YyyIu9gR45KBSX+HZdbPaI8esw/5Sz3dPqkYvDCvjPFGfA8NIx5
	LiIqL5cNFZmV3Fl1mzZM+Jw8SuGLI5cRtAwhh0CTnLlTzTCKOC0hTbbZld/rcA==
X-Gm-Gg: ASbGncssFEbGmkZ53d643resvTPMHbQL9tTZ65Op+rTGIUxkU1nloTrCKlW5DtQ8r9t
	SMXsv4rnMoRE+QLABHIOerkKGDXOFRnmQa9A4uSMONcPtd8ySC7OJ2aJeFhNtVJIRqShb/Czju4
	F3MssCHU0ELYFLm8eKJDncA4N9buMVlWH0/Qk/kBlyKhTXCp9wjcM2x0txhODTYV64fqv6czlx7
	EG1TlXEbL5qiz4Ubg2/qPOY+/7uvGt9/YE5UejV0GguQP8eVI8LFCjdA3my1JapFeiWCp4mTQVu
	nY58Q+CCb/IE5NCr/JNlJr1e4ZNIoo2LGhXgkJuzK6NXP8+zAIHZsWIZZ53P+rl2kZ30MSmDGQQ
	xgaqU
X-Google-Smtp-Source: AGHT+IEscXBndvsKaCefDWCba9ziIegmFGLeBgnnKHteJwEKYLk9MvaIkHNzX41MFrwbDwO816Fryg==
X-Received: by 2002:a05:6402:3590:b0:602:1b8b:2925 with SMTP id 4fb4d7f45d1cf-60774895d94mr11720716a12.29.1749497458321;
        Mon, 09 Jun 2025 12:30:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607ed78b8cesm1864848a12.75.2025.06.09.12.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:30:57 -0700 (PDT)
Message-ID: <1faf699e-b40c-4408-8655-b5bc8a6776e1@gmail.com>
Date: Mon, 9 Jun 2025 22:30:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 10/14] wifi: rtw89: Fix rtw89_mac_power_switch()
 for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear some bits in some registers in order to allow RTL8851BU to power
on. Also tested with RTL8832BU and RTL8832CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Put the new code in a function.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 20 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 875c1a3c5ca8..bccb504915f4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1449,6 +1449,24 @@ void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
 	rtw89_mac_send_rpwm(rtwdev, state, true);
 }
 
+static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
+{
+	u32 boot_mode;
+
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_USB)
+		return;
+
+	boot_mode = rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+
+	if (!boot_mode)
+		return;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_STATUS1, B_AX_AUTO_WLPON);
+	rtw89_write32_clr(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 #define PWR_ACT 1
@@ -1459,6 +1477,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	int ret;
 	u8 val;
 
+	rtw89_mac_power_switch_boot_mode(rtwdev);
+
 	if (on) {
 		cfg_seq = chip->pwr_on_seq;
 		cfg_func = chip->ops->pwr_on_func;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f05c81ae5869..9d9e1b02bfc7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -182,6 +182,7 @@
 
 #define R_AX_SYS_STATUS1 0x00F4
 #define B_AX_SEL_0XC0_MASK GENMASK(17, 16)
+#define B_AX_AUTO_WLPON BIT(10)
 #define B_AX_PAD_HCI_SEL_V2_MASK GENMASK(5, 3)
 #define MAC_AX_HCI_SEL_SDIO_UART 0
 #define MAC_AX_HCI_SEL_MULTI_USB 1
-- 
2.49.0


