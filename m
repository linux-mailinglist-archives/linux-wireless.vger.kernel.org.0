Return-Path: <linux-wireless+bounces-24302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCCDAE229D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D353ACA3D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD01CBEB9;
	Fri, 20 Jun 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD2qiM+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237C136988
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446082; cv=none; b=RLFa2HZKnW324k3NDKTrEq69Jg78IJTvzCwAxSzD7UXdax1/5qGDHbuPyuCXaOHmW/PbywRBzmxqnMn4MuRb8LSCPJrsszGgY3OHYd3K/sPv/Y1xO4bQFuhRLcYFvxSWWmCR8LdP8V3ej8CNRmWIemMVEMcfuE3ir22/rqBb5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446082; c=relaxed/simple;
	bh=gC6jCJeaopFOrccx0ZKNSyJeoP2ytc1yDUzjQNeTUsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jqfqfT9qLuawDWteB23WZFu0YM+jODbTacGvLEKxeP5sCYtnUHaNVRfuAPdH+D7M6WibmdGbhTuUzyDZq7REIXvuS3bEH2bz6HSNfmkg7WrHa9HAiV1Xydaln2X8z2zD2VzQ/On7HVGg7fioxMwcTw0DjskAqGJv/nf+UUtebjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD2qiM+l; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f71831abso1847622f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446079; x=1751050879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxHMMOcY66bP1LsRIoW6eOannwq1DaW34Cyw+f/JOEg=;
        b=iD2qiM+liX4vPRB6AEyW5X0VE6EGMGskbQ0J3MXGL5RQkFXmtW02ap6fljF/LdBAwt
         Aq5gg4wgxlMo4GjLAcAENDG3eR3fACmibxyrgL+VLF5kcAjbFuB0qEEKhK4O8UhXdHdv
         m8CeINJKi+iHOG6Ic/LibU/nDXrnN5o6LEaeWKQaLJPLxCM9GnKeoz0ZrWlVSr73GNGh
         cvQIK/o/tKVK/8FstuY5PAy8L/AazP5tmG1N5+kIZOlhWyB0RiAKmzyiB3rwoLRL9H5d
         2LMtY57n1xOh6muoeokVFh4ENMFmZMbLU/4bz5K6OnIVyUgX9MjscDn9l6TrEF5Eu2ih
         iZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446079; x=1751050879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxHMMOcY66bP1LsRIoW6eOannwq1DaW34Cyw+f/JOEg=;
        b=IPD5Tv9BZOT5pRDhbgPl2E5+0krupRkDNqusPveCmbzVgQQbqpXkKPI5RmPBNzSy67
         4SgcGpwWNmW1Xnz8IzP9qZpMB6uDU+oYwT7lJzzHU5/zhgVmGjz30ZWDskrbd587ae2L
         oy+eIctblQ1QfKJ6/AnGHkSHw4mpXUcBtJdIVe7q8S8Nz8Gw4R4gLT4NMRs7w33CCSK3
         CMUkDIuxwAoTNfL8wjdm9E46ZCXlTCrS0dab9kMcbc7C4eaTGnSzwFw8kHJ9KBjtceJg
         ZeyElyjdSm/nyTcVi18usP3dp/N+dPCYMcdbBgL7LrksX1eJSa18J70ohke0EEAKgcCV
         qddQ==
X-Gm-Message-State: AOJu0YxkKaZ6q0Qi3BcoS0qqZxhqcahTfaAAoX+dxfJu47JxNg5r7dZs
	tOb1tUOeJwrGXlKROGW1Dxaj1hJifQEjbEdt9r9SoIE+bpcxpwpC90ffgG/DNg==
X-Gm-Gg: ASbGncsA5gXj1MLwygieEq4jj2iLXPiaZsCnU/W2LdzlILIIHjJNB3T6ppwOWra3Wv7
	6raEmuvyG8H8qAy/ooypjSL6oltTOHfGY/o5aHkdBnaBWm41mxhIDUdusq/bmgyeGgSJjeMvvk4
	kmzyZmB1QI+VTiU/070vrndbJZYlGXHuv0AHS4d+BjtvItkU+VrGmXPs9y9K5qmqeJXQxs3ckxG
	do/NJq/ZkKuh1jttQBhLHoO6roVvr/m4ABbk4jHk56ZMUPOeObIWLTZpvrqiJqfdaTOmJWbgxDS
	fUlc9O3pghIw1yrSNGwPFBklweGGCeE434TasZVBMYa6x7VOzoKMHGSWJfDUlvfRnjDChQ==
X-Google-Smtp-Source: AGHT+IHQpBnQJxO48Mvs1hG6WsuhZEpWkeki4eqewrGlisNzW/UX/BTziFGEHYmeJXQ8kIc/NhpSWg==
X-Received: by 2002:a05:6000:25ca:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3a6d1325e94mr3620524f8f.51.1750446078866;
        Fri, 20 Jun 2025 12:01:18 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c66esm2683271f8f.47.2025.06.20.12.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:01:18 -0700 (PDT)
Message-ID: <a7cb3d99-33c8-42e5-95aa-86247c7a9d43@gmail.com>
Date: Fri, 20 Jun 2025 22:01:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB.

While the RTL8851BU appears to work without these changes, it's
probably best to implement them, in case they are needed in some
situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.

v3:
 - Add B_AX_SOP_EDSWR to reg.h, which was accidentally missing in v2.
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 22 ++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 4a65b0c9c2d1..c680441232fb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -21,6 +21,7 @@
 #define R_AX_SYS_PW_CTRL 0x0004
 #define B_AX_SOP_ASWRM BIT(31)
 #define B_AX_SOP_PWMM_DSWR BIT(29)
+#define B_AX_SOP_EDSWR BIT(28)
 #define B_AX_XTAL_OFF_A_DIE BIT(22)
 #define B_AX_DIS_WLBT_PDNSUSEN_SOPC BIT(18)
 #define B_AX_RDY_SYSPWR BIT(17)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e6ca3b045fc2..30fa64f02e94 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -385,7 +385,8 @@ static int rtw8851b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_WEI,
 				      XTAL_SI_OFF_WEI);
@@ -430,8 +431,9 @@ static int rtw8851b_pwr_on_func(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
 	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
-	rtw89_write32_set(rtwdev, R_AX_GPIO0_16_EECS_EESK_LED1_PULL_LOW_EN,
-			  B_AX_GPIO10_PULL_LOW_EN | B_AX_GPIO16_PULL_LOW_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_set(rtwdev, R_AX_GPIO0_16_EECS_EESK_LED1_PULL_LOW_EN,
+				  B_AX_GPIO10_PULL_LOW_EN | B_AX_GPIO16_PULL_LOW_EN_V1);
 
 	if (rtwdev->hal.cv == CHIP_CAV) {
 		ret = rtw89_read_efuse_ver(rtwdev, &val8);
@@ -515,7 +517,10 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
 
 	if (rtwdev->hal.cv == CHIP_CAV) {
 		rtw8851b_patch_swr_pfm2pwm(rtwdev);
@@ -524,7 +529,14 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 		rtw89_write32_set(rtwdev, R_AX_SPSANA_ON_CTRL1, B_AX_FPWMDELAY);
 	}
 
-	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_PW_CTRL);
+		val32 &= ~B_AX_AFSM_PCIE_SUS_EN;
+		val32 |= B_AX_AFSM_WLSUS_EN;
+		rtw89_write32(rtwdev, R_AX_SYS_PW_CTRL, val32);
+	}
 
 	return 0;
 }
-- 
2.49.0


