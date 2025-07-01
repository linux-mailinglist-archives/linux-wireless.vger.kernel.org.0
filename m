Return-Path: <linux-wireless+bounces-24735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4FAEFF12
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A411617E0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429927A92D;
	Tue,  1 Jul 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boZEPBc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804627C175
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385817; cv=none; b=DxGjIAWLsx3t3nVef+k9aURwkq3gvipIx5L4m4or1VFsZoGqHgCbzpH7l8et2CP3PkDBc1kkT/3UI9eYuVcgEiIjFjTSj1iME2BpUk6Vi2B6e01PE3vvHM0JW7v0i5bTU2Yh4hYnzC1pxBpAp7bf7Snq1PMLQF1lJrsjnCBAksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385817; c=relaxed/simple;
	bh=OVB0hw2yaJ1aIc8zS6ALv2EqsWnJ0GDiroyX2R8D2mA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tyL/LVZiGqCWwOlxttmLyvrUqXiVPV61tVicd8vRwGWjfta4q+vDYAs/islVEWqp65u95ESnCCIL/FoqqcoVdzUbnSagvI5PGbuZ8sfi3SovvNLIl4FDQdtHrDFAA/gZBTivi7VlG08R7RTbO6kVViWmpkwRa6Q8HGP3NZviiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boZEPBc+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so18219695e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385814; x=1751990614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I+vV4NYx0HRcuSWjo44u+hLPHKL7HI0ShvBlz/YtW/k=;
        b=boZEPBc+7xClL3AUrwGZNNCOcqdvHHNfzMaysQalB7uZlbtWfhJUJftLLHb5lHey1H
         e94FNCrtHP7KBph0og63z8+zyFVjSYLh0WexISUJI/Ly85dNfZ5nOzlUIvmFKcWGPVjT
         TIsyt6g65BIJ/uDLB/b5LodSnS4dXOaqBBxy1fwFtD+I9sggAwRvtEOPKo38tCGgX+M8
         UAHW1RFP/1aazNQRDUjKt3JzmcOC1D5xRIzXfx09BytSyB0KSq4KGlF1HIqEGsRxP2iD
         q3VFITsdhpm7/4sBKZjVE2MlwO1do/bus1q0/FcQfBOgef9QltyT/SKhrMnj54wauYwZ
         Wa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385814; x=1751990614;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+vV4NYx0HRcuSWjo44u+hLPHKL7HI0ShvBlz/YtW/k=;
        b=VDvkGobClE6ezlNSP6yq6ngsrzD3Jhmkqv51PEnJjmfjC08XNfO3Cofw7Qi8vxY3oF
         QKB+QMLwo31VDqEePPsSzItwp0XV/C9K2DOHgbf1PxuXbPTHV2DtCC+uj9J7muYRTlAa
         RfF6KIR+gTmX1Vf8EieZzCSGSSw2kS1KJcDQmWaffjmUFqz5/bgxDvfTmlg2YO9PhvWe
         Qs++tDf2tKY5zCVLBiJ3hOeOnUf6n5Dh9/YXntCkmKJxN2YWapaiqTw+QaURINt9+F+I
         9zb4yBaUmcDhp9xg9Xp/yyrNQIZfiGE7AQP6cHuFqXa6DajsnAJrZgMel4lMa44vpd65
         wEJQ==
X-Gm-Message-State: AOJu0Yz7Dq2F4I3q6kJgAX8GjKmvUb2NLGZkKfaYMfdZ+cfp30VeL02o
	RGB3d1yJB8hzMdPNjhAUMCFv5WLGNnzX4kc9zovt7Yf2jiIpjMDSlNQq6r5LNA==
X-Gm-Gg: ASbGncukCXavHZxzmI2CN3ZqvN3hOGcmMIOtt6xWBqUQLcluQ6CGVeT+pRDg3k2GCpG
	MScgmQKqScxO+60Q5s7g0J+3KqgbX9FoGjYFT3z8Y5BxFXvIJ01Gfu+Jvy5AXatljO7EGvB8Lhp
	0d2FuOR2I67F6422BNg9sRDLDDWCpg4QrZh0RlektUHA+GpYReTIL990xweDbzNqE8M3NwA8gxW
	P+fhrsbiPymoa+bahGTq6DOWRTMTOzpfNvoGo+1/TRTgRYyo218EOnqYg+STcbezl6yzEf3Xj3Y
	S9BhcqpfmAcK1/OcWY6DT+V93us1TqAzilvZ/Sjc3RwtRkkdQGfkL3HKGpvUfUVAur8QU0s0tME
	AWFsI
X-Google-Smtp-Source: AGHT+IGZajeELs7ii3OxADcFJoVxzTt0uuFIrP/1w8nqduMglD3pSW/OZt+QLiNavQNhlNO3bjQvmQ==
X-Received: by 2002:a05:600c:138d:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-453a84069b7mr38112425e9.8.1751385812923;
        Tue, 01 Jul 2025 09:03:32 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad247sm207104205e9.26.2025.07.01.09.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:03:32 -0700 (PDT)
Message-ID: <a849b808-a998-4f31-95ed-263a3ddd9d5c@gmail.com>
Date: Tue, 1 Jul 2025 19:03:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/6] wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8852BU.

In this case the same parameters are used for USB 2 and USB 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 85b6849db798..50eed21371a5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -66,6 +66,19 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_dle_mem rtw8852b_dle_mem_usb3[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
+			   &rtw89_mac_size.ple_size33, &rtw89_mac_size.wde_qt25,
+			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt74,
+			   &rtw89_mac_size.ple_qt75},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const u32 rtw8852b_h2c_regs[RTW89_H2CREG_MAX] = {
 	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
 	R_AX_H2CREG_DATA3
@@ -834,7 +847,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie, NULL, NULL},
-	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8852b_dle_mem_pcie,
+				   rtw8852b_dle_mem_usb3,
+				   rtw8852b_dle_mem_usb3,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.49.0


