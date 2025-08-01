Return-Path: <linux-wireless+bounces-26088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC669B18840
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6DE24E0205
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00901F9F70;
	Fri,  1 Aug 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPKOFIVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240ED218596
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080756; cv=none; b=m9vcxHyHvTNXsETtU++ESnz+Fu/a52ILpE/92803+f0r61Iqziiapvhm1O2HkhEMvoRdMeWnD+D0KzUVIIOi+V/iDQHLM7QzaDA4idRo6eRrMoN5+JVHMjYSLqVNCk5dCJMZVx0zBhuIM6riZFp5oUbGJ3IkjmLs0oMtnCovGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080756; c=relaxed/simple;
	bh=TC37zxBTzOtk2bb/HlzxYo/Pf70QA5O906jUykPVGbk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=heIbG5lLvOJJ6eJH9sa/hyCEPwf2PtPwV5+CRfWXNjpIrlfIsQjRd2m5KQWfL/0sHn8vCdois5BgVYSo4ECgDaEbSBMYHnY+6M+FK1rwWbzTAoIBa0BcAEHxHDADNc7Br1/ei4faMC5krhz98JFt0gTrvhtItcrE+/0vFHALTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPKOFIVE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af8f5e38a9fso400356066b.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080752; x=1754685552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ilCfeQAnYn7RvWLYSIOxBF8e2fx9ONcG7cPm8w93btE=;
        b=WPKOFIVECxSnHAq2KoCMfRC6pyKQRVbjLHKxJPoVnd/GauwbhQDJT5KBLt99McHJDT
         xLX8gS2XuZ7Nn/rc3kMhJ7gV2dgi/orhQ0T6ToiUjNnak5/IiCPxktx5SQ5vBfSHp1ux
         j6pvFzy2QYK4/VOspb70hqRKaqWnsNTmCDXq6zVVyyuJGM/1+l7GDysuLFD6+sCupg1C
         58rPnPc6rRwJPUSJ6SPt7Lb/FzKkxXo1RvY3gebFYClHExX0Z55PMtNkZhwoyB9n+2Xi
         EZyK9otNiyj4qzEYbsPD9HcV2dqKIY9Zw0qSnjQZqaYxp6QOQyAioYsSEJ6akhhwM/u1
         Zuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080752; x=1754685552;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilCfeQAnYn7RvWLYSIOxBF8e2fx9ONcG7cPm8w93btE=;
        b=LAow5ymRxJOZ3ivVuCZppE/3khaDsZUJEgx0o6j3z5OXUI+JQ50yHMgUPXouDm29LX
         XHb5lHus9J4lRtmFhDn7oxu+uEl01TID44Z+a3W1bumNUOLF4lqXolK+CNWP0HArvNcY
         FNXWreodJpC7wXbJZGIxER1fj7FyX0xNdBCyt3t3WG5gQ/37P1jviYJX3D/VRV6JmUGd
         5hnBoumMIVELRgOT3Sl81Dj0jI/Rl0YF2TlOkpXrfP/VJqLJPi95rdmioCkN5eJD7GPv
         qs4gPhNfWgGeUzS0xkjHGdRp/eINc+VVVrWLzbeE0Fy0vY42onLf62wKluehTu34qhxT
         aSHQ==
X-Gm-Message-State: AOJu0YzJhwjg4g/JplBxjQtAgwOyicZHdedi3oK8XPwKiSi039nNc8sV
	mUg86pcv86POLAjHfKg0cFpE/odf72vnbjR4pg/h6qNcdNlvZ3WLJM0nzzYMlg==
X-Gm-Gg: ASbGnctdjZb0L0Er4vTRYt+yRX9N52Vvx4x0kiMWeva45/7IpREs6+xdJ4DCQezLMHS
	sxDbAbntiu7rpUQzZSp3RGD3dffdYwl71SIZvBNEE2q+KPjbEkrYmA+kJInPp7Y3AqH8X8RlJ/p
	UtQ6SLPYew3mgdGOtgB7F/a/PUWDmPN+I4/x7ZtX5GqKsFHW3/E9rcQ1XDRseOzxDTTcAI0fNZ5
	b4Vqoxut4boHCgK2R88/7cInpeNh6ION4hb1OiqUxBIvWrEUAz6cCu2pRLPfMWF5zJ/OopbjbMg
	vI7zjyIJLuZNRAxThbQoO7W38DabjWjlD/qQkFm4u1oLJ8kGJ5naSMSAra4H3wU/0jD9GXvYCin
	pechOLPz4CseBvXnIT2KxIlaY+4k2QA==
X-Google-Smtp-Source: AGHT+IEhe8EdNBcUZY70qfln/Sr4o4x05PzMG3iI1UsKGTYNrosVk5JQUyFDxDCRt6GjeJ7Hk6QukA==
X-Received: by 2002:a17:906:f584:b0:ae3:64ec:5eb0 with SMTP id a640c23a62f3a-af93ffa4063mr126307066b.11.1754080752124;
        Fri, 01 Aug 2025 13:39:12 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82fbsm333022066b.88.2025.08.01.13.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:39:11 -0700 (PDT)
Message-ID: <74209132-9db2-4430-97b7-12d9e8972806@gmail.com>
Date: Fri, 1 Aug 2025 23:39:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 06/11] wifi: rtw89: 8852c: Fix
 rtw8852c_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB. The changes in the power off function in particular are needed
for the RTL8832CU to be able to power on again after it's powered off.

While the RTL8832CU appears to work without the changes in the power on
function, it's probably best to implement them, in case they are needed
in some situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 88cf8ea13e7c..49fdcb9aebb5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -214,7 +214,8 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	int ret;
 
 	val32 = rtw89_read32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_PAD_HCI_SEL_V2_MASK);
-	if (val32 == MAC_AX_HCI_SEL_PCIE_USB)
+	if (val32 == MAC_AX_HCI_SEL_PCIE_USB ||
+	    rtwdev->hci.type == RTW89_HCI_TYPE_USB)
 		rtw89_write32_set(rtwdev, R_AX_LDO_AON_CTRL0, B_AX_PD_REGU_L);
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
@@ -246,7 +247,9 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_CMAC1_FEN);
 	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_R_SYM_ISO_CMAC12PP);
@@ -305,9 +308,11 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
 	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
-	rtw89_write32_set(rtwdev, R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN,
-			  B_AX_EECS_PULL_LOW_EN | B_AX_EESK_PULL_LOW_EN |
-			  B_AX_LED1_PULL_LOW_EN);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_set(rtwdev, R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN,
+				  B_AX_EECS_PULL_LOW_EN | B_AX_EESK_PULL_LOW_EN |
+				  B_AX_LED1_PULL_LOW_EN);
 
 	rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
 			  B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MPDU_PROC_EN |
@@ -385,12 +390,24 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
+
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_XTAL_OFF_A_DIE);
 	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
 			   B_AX_REG_ZCDC_H_MASK, 0x3);
-	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
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
2.50.0


