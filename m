Return-Path: <linux-wireless+bounces-26085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D15B18837
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9899D3A5D61
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475CA1F9F70;
	Fri,  1 Aug 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifvKiIKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504C15539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080695; cv=none; b=WPmDqAlZmW/E6wj7Qz/n99cIIeYrzg9tBGwoy6WKGvBx8vNOpcbMV42xT29giYD/Rxxkf0wYyYeh1H/3YGuQb47GrQWIccN/TMRIgxvwmXr08iwgp8wf332iTU4ZDmm5Xzn1Ru7u4ZZTEo8FnarsG2v+sWe0kmv5NMYjBY6OTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080695; c=relaxed/simple;
	bh=oppqG9aqaR30De9CAvMQtJSrHxE2ot3dQfpGacH6uH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q+CI5871ZnvbWSTwtM2gF8d/f53bVtNlFGCODP42qrO7vCK/peXCSN9ZC5+24Np10O7FrWFs23+/DSpmYHT0+hbvh7fQcuwPXhDkjVqoWkIryqGf9XpBLDCRt2YcKCAIypB1AIUARyMLPtzNbUvadBwsP0miCwanl4OeinFUZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifvKiIKq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so467838266b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080692; x=1754685492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gh+6/wTLd+oX7IpN5BW+6PqBOVGuDPaHa9xeTHG+VdY=;
        b=ifvKiIKq5+DJRYunsP2kWJvI41M675YcGFynL+z7NZrpYtMNGyf9qrjSVVCRsG7Q+q
         MYxXJzk3jD0C5cAprAWWqIyOFI1TiVHOZAWWSJ6ldC/DqsbQ7gJnr3vVCeBx6bdIA0+D
         Isbn20ABmRG/R+HXTvHVTZihwGKxdQLUg0tHu6GYVd4LPpVg5KwhbF4kWy1d8iCIazLj
         Qey0+Ny3MTLSNFj6HXTON7GcJS5JOpZQ7lxiH0nmhdLWvUTzmeRbP41jcLhNmeqV5blJ
         evezM72ss1Z+Voy5Llv+C3iTnEt8QAXhcAfx5YMtncvBOhS9dT4+guQAHrfwPS73zyBF
         n7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080692; x=1754685492;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gh+6/wTLd+oX7IpN5BW+6PqBOVGuDPaHa9xeTHG+VdY=;
        b=RIV7K/XJcxk/PgkqWZvdovjijE7pkiOkuOF1rCXh7hI8bhb4itj6J8b+CmrSJpJ45F
         fhxSobtknBkkgNf6KTRYZrIHIeZhNz6ZlQurkx7IMNno5an6cBIR6ioyxD70Z8c2O80C
         T0uibxckUYo37XZ5GGcQuTzk27b+0YulY0TWBJI5hfrQY2K5YvmhFB2mhfCcz2Yet2gr
         Src9nq6vQAjjxnGP2b+/wKJpVKjbL40pw7b38qt7eem3MULVm4T3j3LCVOkRvM1zZcrS
         NkQExUBS63ea/LfjNJqrsxRmhnX+KsdB99Dvke4nsKycpukKKEhaVPDFLW0TyS7Z07iw
         3Neg==
X-Gm-Message-State: AOJu0Yy46p9F2Vy2t05qQWTYqjoQlxcou+pxdu7ntv5Ajsz14fzdHqaW
	AMNref6ViYdLZAbXcA7c98/Nij0qKko16bKDYlofOFsY9DrlE5XDHV+DdqKg2A==
X-Gm-Gg: ASbGncu/ho6zDjFr3ksMZm/INYe+sqHm0dlZXu2p2yY8mR3YxWszaTv0xLGDKufYu4W
	ofLosUsyZZhNRgEsKl82QcReGIBPBG1kBbMBeXm1Jy6o0jNp8nWLFb+7komXnRXyR+z8smZuo+D
	arp8ZMkjeuW5Nq6Zva5Mq5ajWSYD9O+i0lcQoQzPup/SmLFZx9aAnKv6L9Q4cZvJMrzyeE3Hw9l
	3rixVQOhoguNHG53zv+8Q6Ql8eyDzCoJ/o3VzzvIYg1kv+MbbxTfmJVG8x3H8uVFvYGlmarWdWT
	6qP4pbkPnYKJU6sHWfasmGaUpA5/GqJLUJ3S0SyUzxS1tsasIp0CnMdFPdw1fIMHJurwWVx4XlT
	RkO1mNdhWilDPTK/qD0qMtBisQ8NQew==
X-Google-Smtp-Source: AGHT+IFPdFt5kB97kwycCG2d723QV6RXaLvbHHM4dODfCrETbcw4ac8tWm5mtdz2/gbKi/624i0FZg==
X-Received: by 2002:a17:907:72c2:b0:ae3:6ff6:1aad with SMTP id a640c23a62f3a-af940009783mr109729366b.14.1754080691828;
        Fri, 01 Aug 2025 13:38:11 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm333105466b.41.2025.08.01.13.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:38:11 -0700 (PDT)
Message-ID: <0fe03e30-0330-4674-aabf-aafe111810a4@gmail.com>
Date: Fri, 1 Aug 2025 23:38:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 03/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
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
 drivers/net/wireless/realtek/rtw89/usb.c | 29 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index eb9978a60d04..e749a37ac1b5 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -726,20 +726,39 @@ static int rtw89_usb_ops_deinit(struct rtw89_dev *rtwdev)
 
 static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 {
+	u32 usb_host_request_2, usb_wlan0_1, hci_func_en;
 	u32 val32;
 
-	rtw89_write32_set(rtwdev, R_AX_USB_HOST_REQUEST_2, B_AX_R_USBIO_MODE);
+	switch (rtwdev->chip->chip_id) {
+	case RTL8851B:
+	case RTL8852A:
+	case RTL8852B:
+		usb_host_request_2 = R_AX_USB_HOST_REQUEST_2;
+		usb_wlan0_1 = R_AX_USB_WLAN0_1;
+		hci_func_en = R_AX_HCI_FUNC_EN;
+		break;
+	case RTL8852C:
+		usb_host_request_2 = R_AX_USB_HOST_REQUEST_2_V1;
+		usb_wlan0_1 = R_AX_USB_WLAN0_1_V1;
+		hci_func_en = R_AX_HCI_FUNC_EN_V1;
+		break;
+	default:
+		rtw89_err(rtwdev, "%s: unknown chip\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	rtw89_write32_set(rtwdev, usb_host_request_2, B_AX_R_USBIO_MODE);
 
 	/* fix USB IO hang suggest by chihhanli@realtek.com */
-	rtw89_write32_clr(rtwdev, R_AX_USB_WLAN0_1,
+	rtw89_write32_clr(rtwdev, usb_wlan0_1,
 			  B_AX_USBRX_RST | B_AX_USBTX_RST);
 
-	val32 = rtw89_read32(rtwdev, R_AX_HCI_FUNC_EN);
+	val32 = rtw89_read32(rtwdev, hci_func_en);
 	val32 &= ~(B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN);
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, hci_func_en, val32);
 
 	val32 |= B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN;
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, hci_func_en, val32);
 	/* fix USB TRX hang suggest by chihhanli@realtek.com */
 
 	return 0;
-- 
2.50.0


