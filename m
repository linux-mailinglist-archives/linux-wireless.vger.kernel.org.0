Return-Path: <linux-wireless+bounces-26086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B60B18838
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129603A440C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053541F4CAF;
	Fri,  1 Aug 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyHSJOw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CE15539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080713; cv=none; b=esmarmKDN+qL9kiqI+2KmZ2dVgh3TIqDeaMaWKV5LjOoL5hyONcqoYqHq7kT64mE6jQezIW3xfklN0oqS7GFTbnSj5cbtmF/WN9A3kz0I4xK6qFpWinwqJIatkRHMxjCAvzTO5Qrb8Kheg6YGlwnTwoFnHrODQwvB7byZv6cZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080713; c=relaxed/simple;
	bh=U5UmEf8EiR2cb3ULgcu/sYVWekZdrsRwfmFXFMR/I58=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KK9BY6l648lPK2y7vztz5ECGSBZ/lrtzOVC87iK8oSKu7AL/kAypfYpezwPTwDJDq+80rArFW67tQsWs5X6ruFQ61f/8Gq+g8TjytBXEnzIGRuxwgpQCrPYjy6m8xGSScIDgGPr5aqFgPyiWcCrTKOSynxHZP8GJXYeAcx38Esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyHSJOw+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af90fd52147so261112566b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080710; x=1754685510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3l873YR+6BL4SwMEgslWFq52yH7vegm0vY6y/x8DfO4=;
        b=hyHSJOw+hH7zX6o0q952S/Oz07/qBAILX0ECkOQrLZxFQYUEPDy/MgtKrTBl/7cyqt
         hTBBaPmw+90ASou3MrAOy0ypUJnHfA+E2FAi1wizy6ou0/Q+Y+DmQMPmBynZ1UOWM8cA
         Uhr1mOlM+dksEnJhWOlL4T5DhfWi0pUsq/TZI+MdmEL+9lRk/gDT0PXLtgrEXsPSZKui
         n0ErFRbEj3hDkJEw3R2T4TdzfX/cftwikFV2vfxtEIoYRsutQbcW9UuhoaEkQzgyhHiZ
         BdHhGtR/x2ChcAcI3o6OqkwdngRBmMx5kCy6Il2hMkrMD5GmRvF7soSwkhsyqHCQOFd5
         6KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080710; x=1754685510;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l873YR+6BL4SwMEgslWFq52yH7vegm0vY6y/x8DfO4=;
        b=fzPZUTezGqmrk83AD/1nOUrlSlcBAibZ8/sDFwqxpwzR/U3yJIHpa+0XmOhRro4iZS
         ENXWCzyW8m53eAfTBO662Zm1hF84+1KBDdigh1IWLHpmHCOIioqGKGbn4BSgCvilHym7
         mrLDSsZmJ5QhxGGXQas5efE0xdeELUIAfXAFu4kVdNENGWFxxHinEtByeDobIePfKm08
         9bQ9eza/WkbzUv15J51hhXkSbbuMrmyArjh3tPkuCnurKSyim2FPCXtlu1wu89DYO3pP
         tF5v3QBLKNFImF5P4lgqvzdMKMfy++FqsHnxt4Q7rgNHUwXNNZl4BBLQXqmaBddAzwI3
         Jmgg==
X-Gm-Message-State: AOJu0Yzi1PTFDO7zcnmIaUuA+q7q+KxnDSFANTgNjK5U8JJqZsuw8SMv
	4RceTtlyXxFJkyQNtsJ7+bb34mCP4egC4/kgUK+MZBSkig9pTLGJVlUdCC9L+Q==
X-Gm-Gg: ASbGncsmizADNBiBkC1Q7R1/Hul5NdlK9EmcoKBmBiJTljLeQE3SWkW14mFBwO6wLhG
	dCf/9nlWMAm4DkxMdoqnmR2Bz/Wu1oewznQlUmt81JLWjEHgCyka5k4IJqc9dFnyJQMc8R1sBYY
	NYLrIAPfk9n1pU/UWcizz16w0RaOrIS34t6uFqcl64OyOr4wWjGfCuSNabnQEcPBcfxtP5lBPuI
	aASnWFu8GcOgVmoCtBHjoVt/3+oju4usf37kB99cicq3g3DLggpmrv6MJEXTBHvcbBbJhuR99bp
	vRTGf/Zmw0nFi5vlVa4kZaNG3IARVzaKq/+F4bXxxNDXce7bWXMWa5jJIiqNYUTRVTnNw4+xzek
	n49QQEQX3azeMmfiuq4OU1CvGemlbkQ==
X-Google-Smtp-Source: AGHT+IGQKOAFteaAmzJPTzsXxadTqtGo/ddRFGFIcsIij6h9QD1/o9nWiwsL33/Zj1ymgSnR9t+ypQ==
X-Received: by 2002:a17:907:2d8e:b0:ae3:c521:d3a4 with SMTP id a640c23a62f3a-af9401f895fmr119902166b.50.1754080710451;
        Fri, 01 Aug 2025 13:38:30 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm334926966b.126.2025.08.01.13.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:38:30 -0700 (PDT)
Message-ID: <e35e1c46-ca5d-4a44-ac45-c497e2340992@gmail.com>
Date: Fri, 1 Aug 2025 23:38:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 04/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_post_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in this function are located at different offsets in
RTL8852CU compared to other chips. Use the right registers for each
chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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


