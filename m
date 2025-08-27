Return-Path: <linux-wireless+bounces-26713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40377B3880A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02772980CC4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3A215F7C;
	Wed, 27 Aug 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIX9CmBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC1285050
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313572; cv=none; b=Bh1R3E2+yIOuSX/6EAMIVlgvbRPVt+t9rufkv7Esmb5EYRf4DN73wQCC3mGJvq8/dlrjgP6gqMNtHG2kxgxzi3SakEGBtvTx54WX5Vu4etQgkhCqNxrQOlXRIc9eVeUqWYTxq45I9kXa6z+vnz1gaxdP6fvQiS/ju22JQFFMGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313572; c=relaxed/simple;
	bh=ueVVnjOONroxj7HhM1oPED5H2GpsgzmK1gHtsQZSo3U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ae83XmKmKh9321rXoYD6JNrbbAYOFjRmE21KEe1YgcqtEGnP0mxDWQGORWmOth923bZ47ziWe2KKUTb39ofwuyaLWYpe0aoSMucHaJ8caW1ESh6ehODTkOwHyVLa/TsQDWtiGA1Qfwvu5WInWOc6Ovrjh2Qp7060c9smd7ceOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIX9CmBm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso12885f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313569; x=1756918369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzPvosgZ5k6DosjNKJ4Mifd9IVhbzkJ1WlhtswgR290=;
        b=MIX9CmBmz5/7eMniN+Ke0EMGcod6fm7PKBC/vQNvTgD2GldihYWe8ZRhgnesdasGcQ
         drAcVKivzJL7tPQKhdqU397fHVXCZEGY7dWox+blTE7pHfz0W0vrkPHpjM24jkG8oQ9P
         MVS6VJoz5jyA5eXEMHt4HV08SrA8BKPAlVKhx5qZEpGMxMX8SpxPrXlyE9GdMqxqERBQ
         qXEEgYmL2Mf2qEaODzElBTN7M2vqA5wUurN2OY43tXiQ4hYSoH64vdWB1Fyo1l67sHzR
         RPJHDaqPDwDihQBGYWiTtwq0IoWUmItwUPx3u8mtGjVK2O8lPuGl4mKuQk8g2R4aDdre
         HnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313569; x=1756918369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzPvosgZ5k6DosjNKJ4Mifd9IVhbzkJ1WlhtswgR290=;
        b=OQS2ehVWNiPqCePSc5tUh4Yfy4u2QuAeL8DfmJx8aFtRCWcMcRScvhmmXUth43MB4+
         wFczKwa21pc2vZMuOKepVpnU7riSJPnHagXtKUWp/37R+MXJibjwyL1jj3MEDHZzaXb9
         iC1QC9iRBz03IR4iUZO2wbT3VkNjiOgwrfaUdknyuhNxqk7n9pkGYL6F54hKNxk5y6+q
         BBM6ZCJvWbFIPG5G73J2IEP3Y12dfUpi8gAnFdk+R1RlvxmMGe38t7g8/F6wIOF4RxeW
         UPsJSpYMfRkHuuCzuMEEqApmTXQrchBqjQJeBHL3U/cmr/J8rohhBvDowWyj2uJ50+am
         GnJw==
X-Gm-Message-State: AOJu0YxAie5LyMrbm0dYLyxWq3QFsJWUS+QSKaYbG0Ea4gTgSgbA23CD
	to6tC2ILy2ExnGF+Yxkis16o1ZCa8B9ghJAxsV8jI6bGCBDDgquLrJFA0cuPJQ==
X-Gm-Gg: ASbGncvKCaJmf60PaOOPU3dgPh4PwG6cAhisMtkH5uyTZlv2D7gVZVYGgWmItYyOR3u
	UfYzympNHAUI8k8rB7hS9KbBmkK/lJ2/r9wH8qA35kGnfc7qP4f/EJTyVcVy6buqsUO2+N5/Dki
	L0ZXXURf5MwNtRnAAaIeox7phNcMleEHyC2Y18ucIYheKwoblu2ziwTSm4Lh+2zhBRuoBTTHNEu
	MS37OpQno8wNvieLgrOmpmUYBAlFh/FdDkrIKht3a0uGxH8IC1VYM35ugboDM6jFwzvFT7uC5hX
	AH0e88viC1v7JmDXlMbIdyf04la/sSKfuhGK70egavM/rR0BuqtuOZFyUlDVBtNK3XSMiymjHai
	zEjPz7i9Oa73IObUKqGF/dSvF54dNRQ==
X-Google-Smtp-Source: AGHT+IFLfhA/x02Y0kJ1a/2Yq8uoreQy5UJBsefEMaKOfQcu/Cw+skQvdbMka16kGHQpS/2z8tCFaA==
X-Received: by 2002:a05:6000:2709:b0:3cd:5815:68d4 with SMTP id ffacd0b85a97d-3cd58156b71mr876726f8f.57.1756313568678;
        Wed, 27 Aug 2025 09:52:48 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c9c9324dc9sm12636234f8f.3.2025.08.27.09.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:52:48 -0700 (PDT)
Message-ID: <0bd16ad5-6838-4af1-9bd1-d50dd331511a@gmail.com>
Date: Wed, 27 Aug 2025 19:52:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 06/11] wifi: rtw89: 8852c: Fix
 rtw8852c_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB. The changes in the power off function in particular are needed
for the RTL8832CU to be able to power on again after it's powered off.

While the RTL8832CU appears to work without the changes in the power on
function, it's probably best to implement them, in case they are needed
in some situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ee1915307376..6aedbd03e3d4 100644
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
2.50.1


