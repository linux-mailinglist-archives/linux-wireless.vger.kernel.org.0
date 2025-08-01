Return-Path: <linux-wireless+bounces-26097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F6BB1885F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75BF7B952B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0D204C1A;
	Fri,  1 Aug 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHOFALt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C52192F8
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081614; cv=none; b=c3O2WmKiplqTd3hfqOqgLefkd0ncGE/ipixgeDhGt9sWGAuI5icwJCD996KEPQmx3KqVhlRtEuE9ZjI3TLUM1igIsbUHEa29doSRxnfUauI36qC5kHoRuD+IhpEHXw1H0nmvusYmiz7xtxFEDY2MEYsc208ThR0iJqf3EnP8FN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081614; c=relaxed/simple;
	bh=sBTQls9mBaGpZ7l97q/jBnTL9s3dD1yGdjN+MvL5bQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LiT4esr6jUn1yuWQLKLN4MTgHCWx5MwGYU0FQsorSVrG10sRdFMVOV5eWqC1jYzc/LgYnA3LM4Zy4FzxPHAzRrkcpLw+cem3hRxkC1A/6DBm424HO4cA2LFh14gHYj/rXJPA5Z2lZ4pFo0bMX2AuYs4nRZlwFwKiE6gcJg6ttzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHOFALt3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso3957398a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081611; x=1754686411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XlFlIrzgu+D87GYoE4w3Rzk4jCuzLMcpwcIC11VH0rI=;
        b=gHOFALt3c49xq5jVaKTicQoxQAi8T7zLP4OrJKtInBRLa2+h1Kk7kg7+EgtuCFuSye
         m1Ft7AOuFbtszYXRC+A5TVCYvpTDGkVfTTe/F2kMtg40kjoxkS3/WigONK8qGhAlbKoR
         DWLRHI43b2PeNux92u0O4x+KZoQgibAKeEkL2MyZWaoRl+npndh3v8jl9DlMkTxbnyX6
         H7AZJILj4LOhrCSLeu6DIZ7bKV+oMAXNQo5Y+wz2LdsUcSYHzGXoxfDWqZebGWLCnfre
         d/8kZ5LeF5d9wTx1hztU7vyrFyMWh851BrvCnfbXNfOcThKLpvCJFKC8LWW7R2YEZjuC
         vdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081611; x=1754686411;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlFlIrzgu+D87GYoE4w3Rzk4jCuzLMcpwcIC11VH0rI=;
        b=xOF+SJlO2l/KtpIzyxAFGGttNSls01TIL/g6afXrR4KKSfGF1/hscbSEPS3hSvVT86
         k15+z1cjXghgj7YAw27L7RaeWHa6jtTPhsl23MGJnu13uNAI0byNMZftcZsTdl9p/cQL
         GhwbiowKujOw3LWJmyin6bfCmmA2ie3wPk1hDZykyFOl0pkPATzgHzMzmr0n/WGSmEa7
         HTOdnLI4UnERD2OU+xfCYUFNfZv6DCyWXiWyGyhDrKyNs0aHObaTek2243oiihxVwfdW
         //1dWm+qJADrF8OJNr5/J+CeO9tSqMz5tYe452tPT2usF6ZwKONVMaawtX+4TBQQGliu
         6p9Q==
X-Gm-Message-State: AOJu0YwcZgTyKtJ937mZBkGHcv5QGgpjAblGk632MdgOc0Ga35dyYu6t
	LEWd8fmjULIouVKYRS58o4xsLz9BvrTEQ+cwH3qUd8XeXpkqvt3LHK7nFexL1A==
X-Gm-Gg: ASbGncvoQPMTt/6lwwpiqly2T8sGJjwDOgkbDEXOcbyl0fS10MfMzJrOLCNVNM/Dbhz
	5vehILjqPNBmH1fK6ZGDBs6UNYpx0+DxhrfpBalIIYmcrW32tpT536ob22B1z9ug7xn3ct6X1a5
	kUmDLC6K3RcESQJKI8Zere+4POJN03fxbCz419zkVi0hSlVCaKo8lCsGzmaj4nxEGt2+IAazG7F
	je/Rw3udGbx687cIUrtI2LIojapqPll4vwVZ9M/Zb8kWhdNriv7OewTNSejvXAoMdCPCFWqQ94n
	aVBsNyhRDmz/iIOQ2/d7qkizaeQ5GlIMS1GUHNuxU0hhJwqswT0SdXLVpZ3O6WQVHZPBiJmj/lh
	qJFMI9I7yN/thgUidJgi9/oDONdyWJA==
X-Google-Smtp-Source: AGHT+IGEyAeatblVjuwkxPyetQ1XjsKSQfQcKRg8MZyfFUeBt7aCxaZM3aA2YcUzMSm10L9Kjfw1lw==
X-Received: by 2002:a05:6402:1d4e:b0:615:5cc1:3453 with SMTP id 4fb4d7f45d1cf-615e6ed2688mr527764a12.9.1754081610979;
        Fri, 01 Aug 2025 13:53:30 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a91141e9sm3218521a12.58.2025.08.01.13.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:53:30 -0700 (PDT)
Message-ID: <2e628a7b-5548-434c-860b-ddeefe3fa4e1@gmail.com>
Date: Fri, 1 Aug 2025 23:53:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 04/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_post_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in this function are located at different offsets in
RTL8852CU compared to other chips. Use the right registers for each
chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index e749a37ac1b5..1c65fbdf7673 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -772,10 +772,29 @@ static int rtw89_usb_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
 static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	u32 usb3_mac_npi_config_intf_0, usb_endpoint_0, usb_endpoint_2;
 	enum usb_device_speed speed;
 	u32 ep;
 
-	rtw89_write32_clr(rtwdev, R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+	switch (rtwdev->chip->chip_id) {
+	case RTL8851B:
+	case RTL8852A:
+	case RTL8852B:
+		usb3_mac_npi_config_intf_0 = R_AX_USB3_MAC_NPI_CONFIG_INTF_0;
+		usb_endpoint_0 = R_AX_USB_ENDPOINT_0;
+		usb_endpoint_2 = R_AX_USB_ENDPOINT_2;
+		break;
+	case RTL8852C:
+		usb3_mac_npi_config_intf_0 = R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1;
+		usb_endpoint_0 = R_AX_USB_ENDPOINT_0_V1;
+		usb_endpoint_2 = R_AX_USB_ENDPOINT_2_V1;
+		break;
+	default:
+		rtw89_err(rtwdev, "%s: unknown chip\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	rtw89_write32_clr(rtwdev, usb3_mac_npi_config_intf_0,
 			  B_AX_SSPHY_LFPS_FILTER);
 
 	speed = rtwusb->udev->speed;
@@ -791,9 +810,9 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 		if (ep == 8)
 			continue;
 
-		rtw89_write8_mask(rtwdev, R_AX_USB_ENDPOINT_0,
+		rtw89_write8_mask(rtwdev, usb_endpoint_0,
 				  B_AX_EP_IDX, ep);
-		rtw89_write8(rtwdev, R_AX_USB_ENDPOINT_2 + 1, NUMP);
+		rtw89_write8(rtwdev, usb_endpoint_2 + 1, NUMP);
 	}
 
 	return 0;
-- 
2.50.0


