Return-Path: <linux-wireless+bounces-26099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A5B18863
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3841A16D135
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E5204C1A;
	Fri,  1 Aug 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig2Lxr9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774761DE4DC
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081683; cv=none; b=KJhZ/ZFLz6mNSg3MBE4zlFj/l2h6k7+J+icoaWEOoazmq4AVn0C0HzonyOKrPAovDbVCqIfXNrbEEcwbEp1EsAkZ4YLLlK4rAxPTA2WbgVH6jMCRKiB71i5ID2CzS+UH9peei4OfoB59SxqqinAqAC+ONuTU1nq8os8+6DOyBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081683; c=relaxed/simple;
	bh=SKDYcfL4cXM4mEz2gzLij5WeFW08dHjJ0F7r7AwrCrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XSAyK0e4jZgISaTVxKju/1dZaCXo+s0F0imq2Ueel2hi2MQd2JmgflNJP01frYMufzmvzSZ+arPCw/LF1+fpp0iF6mY3F+zPNpZOS5rWpOlS+K3Hd2ktsFppahccRz+iILaDtngNgvUALa7ndjvF+sOBptEImp9U/+bco711GAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig2Lxr9+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so457152966b.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081680; x=1754686480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnCqToF4uSAPtsklrZ68+7XxITYd+un5/uMZOaplnrE=;
        b=ig2Lxr9+F5UglQFdU8nVPjta48D4MH+1bnirqUbqefBg9IdRHvPJIeq2Zn4QdNdGae
         nGVitAA9vPuOc/2CFZWgK95+GOTbfbxJWcb00DDCSMUGkKo5L7j4ASyJI0vgqdYYFc13
         yMcBDCRW/mo8wMR8J1R6wChdBFf0B8Mh9qRjAr9wXdhOzjpEQeyw0OfMWACcXPLCvh6P
         iqNBKJaX49q79/YnoQxFMO/V5/FTBIN/PVIzMEGmPr40iqW2nzZDd5NQRU5UuIH7PAJY
         dtweJCVWSQiof8DO7/Jx7uCHUiYHStc+dNUS8goUGNp3kIg0Crg24KJ2nqVuQ1sAhcBJ
         XM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081680; x=1754686480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnCqToF4uSAPtsklrZ68+7XxITYd+un5/uMZOaplnrE=;
        b=nvbH3eCDXZbB2ofyTeUgoeg1yWeJPYNxS2ndDY3zJescg3pMhiHEjsLAknAjqK0awE
         eVHXgOgadaffUbzwfRrhxkK1XL+0WViy4b7plTfVzzSCVE+27GVw6Rb0b3GHIl+0umre
         +TURzYKchs7aPodrnK5fLUtUYroW1zIcxk+C9yqz6FTfZZle+cLBcfmd1AVlYjkXBkWI
         q9rAyvR4r+ESyBDbMEyXiBIgi+EE8f8y4zvHiIf0cq4bfRhQ8E2j9Ap0HTiBqMnqaOAt
         NoNEClugJFGxXFiPmhau3VFeF0h49Bogv8buMmqaq/vq0oT9H+1zgSRQgH7Q8l2887U8
         K2NA==
X-Gm-Message-State: AOJu0Yy+vs0cjDKFg41dhzbFljm5rq55d7rFzvqT1LdWN7rmcPGeu2pI
	GSveAWL7a/6pZof0Dbf8ifiZRsV20TTjDJ5bHVZvigYkLQ6sK0N8c08RvXvi1w==
X-Gm-Gg: ASbGncsqT58mNf3vgChcrNJV1hzHZJysdrTJeEQzi0b31SjAAV1aH7r2zRjl8RBiCte
	2cUy7TaY0/yHZjW9soewOWeIe69uYX+ZErZHw3Xaw9P7k+QtDLs2oov8/zHS7h2KS5mYXTFx2rr
	sQsxZtmSaMDXU1PnESPq8aYqcrHzF7Y/L6saiWK26HzQ7aiJ1p+OsbDwxMs3HcoWk3PDR/GrHCz
	zk6MNwaYzNFEpiHOG6JxH9uCt+TElUOksWnz1fDDkN6YyIgIo8Gzvu0aAyVcYcY/nqicqb0eskD
	2NiPPkUJYUDjcqBFqFImiXXMzeIhFRKsRxrbVQUTy8HQfKYlFXkYunXM9/1x6BohovZB0L1Q2le
	FAaYXfmg2S+Yaa/cM3vYGqhumcvPMRA==
X-Google-Smtp-Source: AGHT+IHJ6641vyXh/nUiGic1AxRLCk/eQ1WRYsgx6Hf47a92U0lWGw0lNicDaHRj8pnMFUi6mT7Xsg==
X-Received: by 2002:a17:906:478c:b0:ae0:e18b:e92f with SMTP id a640c23a62f3a-af94000bf11mr121059066b.23.1754081679871;
        Fri, 01 Aug 2025 13:54:39 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm336951066b.116.2025.08.01.13.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:54:39 -0700 (PDT)
Message-ID: <17cd1b2c-d4a0-4a60-80a7-2d23b97a2375@gmail.com>
Date: Fri, 1 Aug 2025 23:54:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 06/11] wifi: rtw89: 8852c: Fix
 rtw8852c_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
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
v2:
 - No change, messed up sending v1.
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


