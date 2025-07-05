Return-Path: <linux-wireless+bounces-24842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF2AFA174
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC53C1BC5B0F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37618786A;
	Sat,  5 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Fs4rnC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC42E36E6
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744258; cv=none; b=uXi0dMVuTS9HM1lpJdwP3FakYnSrcvepbBkIfAcR94VE0e690XWHZEZj2jnx72M9W82is90Z9DvXGeUCV2dwFZcEVufsSSi+n1xvPGxDL2WxLODfzqAlaY5UvRdZ1gTXYxH3P2PHze4Nwy4psjMzafeMxZRR+4wE+CzL3GUdERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744258; c=relaxed/simple;
	bh=DjSEHuWb/ZKy2V9RSA4cfmk+EDaLql70TFQF/R0x8JI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YJV0x9Uw7p4nqUvFHeLT2gTAtRo4Dip5krXbCEjFG6iE2Y4413AZBBvaMnt7nG4Yn7IfcskCqssMKeRSchWRTVePtV3qEfuSS2bSQsQlpD/myN3t8HjopKn/SlmV0SLt+S2F8fpVfStmdKDX09ch6pWDBNeMTmpoofG1KGSdRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Fs4rnC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a52874d593so1617160f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744254; x=1752349054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X51w49u98dn8Z7luhtyZ3DtkOksBT7i5qz5QebCKb7A=;
        b=Z6Fs4rnCXJ4ExgBVfzpP0WD+U9sPeRErX4PGbzgNABzXTOL5jOcHRWXx6TokHjJDCS
         dQMyj6bWH72qhmCZDYpVo2+Dziz9RZSYmFMVXZ0htV2vBIxn5Fx1YJLhAbrs5AJprYyz
         2pivC4OLxTjY1L4yBHULY0c8B301IFVRJf7tRjm/5hlf/qr48NDW93e0ni2UQjzqQtQQ
         +ciTfk24wk26topxWyK/j7Nd1WlgLJ2MkkE0B4u78pT54jh0LDJkDNdIhTnN4mSv+C+w
         8Qp39yGABx6Y8eWWwpkCllI+fzOV9HsX/zbUNbEGPslkFEovlXLgySYrERslDYtvG9ZT
         E6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744254; x=1752349054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X51w49u98dn8Z7luhtyZ3DtkOksBT7i5qz5QebCKb7A=;
        b=i1/ikpfOi8xLSFabn6WNunJd2/UQ7kGo7VigHS7MwHlr++W2x3vK7w4QTRpDfAzMeB
         mUlLInnx19qxTTbbYg3yJBo2xLKT5Vcw4iM6U3mWX7EpXrkSmHNVqkgKVVaSOKYetHF9
         Hucb1WmSM32MvR1+dPzvoTxe5362rCt/1ipL3yjcPVQTfCeIlvd83gevZ5/KdmnTATrW
         eT1xrkEM8aD+WWgJrflNI+4PtOB0/5jcvWUSkfJKdaz2I4KoESL7G5sW6zZYo6alqNQR
         xPUqJUpfIZFaesp8R6mtIpCPXnTf3dbo2GqG3x24iXnlxFLhqqMRrxcXN2YA2wGp7fSG
         fyKA==
X-Gm-Message-State: AOJu0YxuxgCb0FzbkTSb7tqN9AN3VB8qXp/rBLBG/odZejuc9jyfivo0
	7ZpUUo9jrB9QSRAztFW6Wm/CJyZlKEpz3BZnJvO4xP8cLn7MMwkDvgKdzlgjqQ==
X-Gm-Gg: ASbGncuKA7RjYCVYuvGGaD4A0lRqF1gQCsvTKutCylRVBtgedNol6q7A7nUS7JNpMaQ
	SwyB2zxkeklGwD81OSR/mh52GPC1CDtXoro32VXFlhLFpb3jrZblQzj1CSknK6vtcV8xFTwqlTH
	Jx1FtOvzDCrejHQCTBHNhgHPwz/DWBtEF8tW59lTcW3zqkb4Ab1ueYv0QR2933kbCeWAbOPJLfr
	AzjTWsa5EhAF0ktjH4C4C0bYFSuykTyrpzR/U1wkfJp/pajTV8X1B7wn2+M4PuEKjzX5u11NSWj
	Rr19wYE/ILDpxU0EW5j2t48PpoIpDCFbj7K+QmX4zoN0WSG9AY13rpCEKcMGsT3DoFDA6w==
X-Google-Smtp-Source: AGHT+IGHUioh1ELhMN/x44LwwWsk9V432Q2ql/8+0PQSSjasinSXoKfTF+5TWiSrINRJl5UqXInhAQ==
X-Received: by 2002:a05:6000:70b:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3b49661d7e8mr4794357f8f.42.1751744254317;
        Sat, 05 Jul 2025 12:37:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm5618864f8f.46.2025.07.05.12.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:37:33 -0700 (PDT)
Message-ID: <c12da54f-88e6-4b11-8587-36f9cac13bf3@gmail.com>
Date: Sat, 5 Jul 2025 22:37:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/6] wifi: rtw89: 8852b: Fix
 rtw8852b_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB. The changes in the power off function in particular are needed
for the RTL8832BU to be able to power on again after it's powered off.

While the RTL8832BU appears to work without the changes in the power on
function, it's probably best to implement them, in case they are needed
in some situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b0b73a4a70a0..85b6849db798 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -299,7 +299,8 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
 
@@ -361,7 +362,7 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VOL_L1_MASK, 0x9);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VREFPFM_L_MASK, 0xA);
 
-	if (rtwdev->hal.cv == CHIP_CBV) {
+	if (rtwdev->hal.cv == CHIP_CBV && rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
 		rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
 		rtw89_write16_mask(rtwdev, R_AX_HCI_LDO_CTRL, B_AX_R_AX_VADJ_MASK, 0xA);
 		rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
@@ -443,10 +444,22 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
+
 	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x3);
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
2.49.0


