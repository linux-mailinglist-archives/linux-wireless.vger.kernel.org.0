Return-Path: <linux-wireless+bounces-26102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90713B18883
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B457A78F6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B828CF70;
	Fri,  1 Aug 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnfrPQIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AE2147F9
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082266; cv=none; b=Jf1e/Py6XND/DzU+wZIurjAgt+mrTJV7490YJUsXwy+CT3tUr4BIY0tPtAg1T6xiazfSdbqHWKnP3ubADS8TWz9ZYeKHV4ao0oXtmPnAlEBe4/07GeBFTtzYStVncgzE0VnfQmCEYvHjEzxdsNbZE1f3kI2lFSBwhO3b83Dai7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082266; c=relaxed/simple;
	bh=zTte/g921qHz7aKEAOAt+nuq4gn7a6FQ5VoA/XJ5xpY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ELxM+whGliJ6O5/bilmkq/K+uAxMdbKXxSHht17lUakAsG3qkO53sB9OHKq3brrS5yGW/QMGejQf1GdnR9vCBoM91r+7uwz710gC9DwRsxdq9vYRoSNcT8CRWZJ9PAFkvOvbJWxzOHRJY6Jq0H3NioOCwqqAKF7LKdRXm0BZy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnfrPQIK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso2864953a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082263; x=1754687063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VSMq5+P06HNbymlE4zgwFjZ0e6NAd3ShP7xXsO9IZqI=;
        b=BnfrPQIKsQQjGSAjBGniRPKXG59wZVhSzvl0QHDONro4eHcn0G8AlpI3VDy68ZMgtm
         ux+Bc4SDV7LxMEpiNjGbvMdaDF0K0oK7P35BIxcWxrCSLVyVSGt7SC8HoSkN8OAt83Qr
         6WCwUVR/UH4Lf1LsVFJOGlx6IXGoq8DTTzQv34sGSKwXQQce4s4TKPveTWZaFvE9OTFX
         Y/askWu0NdMKRlDIDgYt6CJMLB9tpL7eEQgvuyHLENQxz2Tottu8dbS4bTteUA9sAA8s
         dtFMrGndhN6qI/Fe/nECvD1XQB9FVd85TvSEjHnbx5Ec0vDTe7KuOA6idgxCwQ+7bR+2
         Or1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082263; x=1754687063;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSMq5+P06HNbymlE4zgwFjZ0e6NAd3ShP7xXsO9IZqI=;
        b=TZjdWheTlhcm9l5D5cNrAzy6NNnvGC4AjA2MSMGpud4WTRibeqs6o6rS7qLbSB/Yh6
         X6PUiK2L8GSGrTbcRAYg0It4NVv/HKuehhaWtpZqkFRLuY6lsgGeHWJRQIf9/0oeMfgD
         btxghO9LqW/s0Yp+LUNGcwsyNsegYupAMZJv3NWnWBNkDnsn85VqPo9sBFkrfn/RB0Zj
         ZgEpoa+AKe8obDJ9OUwFjOS5ISSoJJp4xMv5/91coEssxCuyM/Pb3SrupwgdINz/L10M
         E/ghkphZ3dOne0JAh2ODWHYLI6u7tiwJpfYiDsAgH8WQYG+JbMjLvZUhhc2uZFRzpIsI
         XNFg==
X-Gm-Message-State: AOJu0Yw9Y+jk+46OJDXR9XpB1753kD67VqKuDw1/lH8xMRx/B64wc0bn
	UHWkGohAM4s9zfE4ealMhQGvuo6McnlgDgxRy5Um9DUeOX3S5Qh+zPhqdw9XZg==
X-Gm-Gg: ASbGnctuJ0n/qtGasaX6YHTcSGKPgiGOb18P4MZFwb+9iBJFS+2z664DYjn8vu5uWeo
	oDrrYQmbgxWWGcbYnn/FohrUEhQh6EJeaV+LFt/hWJpfzbkZV/ITfvkVEezS8R0HqxlQAbcEfTh
	ZLXou8pBpf3gKfSxiJ8xPeEPaAR3VhzRHBjBuzfEjWNv4TM+gIAQ6SbOtK5HnYVRtHkchqCRzJk
	rS+JpMeamYn5UgPSxQl5dLKjxXAXr6b36/oXey105b57p5cIYnLzBqGVJtHLucfVBeY+hRJB9V+
	yiviI3SUgY8rbAH/ojGooqCRysjmAoW/5Zu/9WKTqBb15IdkSZQAUDw8mWB2ekW6OMClcCgz8WO
	ibv1U/2YQctEG64/9hUJCMwfc1fk/FA==
X-Google-Smtp-Source: AGHT+IFCUKCexFLOw9hzGNxSpUDG47zHG+XMwBtIYSTVeHM1IaE0R1lA5el1T9qnziqIUuwJXtj4IQ==
X-Received: by 2002:a17:907:944c:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-af9401b1a3amr117778666b.35.1754082262751;
        Fri, 01 Aug 2025 14:04:22 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a243742sm332788266b.132.2025.08.01.14.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:04:22 -0700 (PDT)
Message-ID: <187182af-ab82-4e1f-86f3-2d49162f668f@gmail.com>
Date: Sat, 2 Aug 2025 00:04:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 09/11] wifi: rtw89: 8852c: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8852c_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Also fix the offset of the MAC address because it was wrong.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 16 +++++++---------
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4a1405ba3567..2e5fa87ba9a1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -480,14 +480,6 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8852c_e_efuse_parsing(struct rtw89_efuse *efuse,
-				     struct rtw8852c_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8852c_efuse *map)
 {
@@ -596,12 +588,18 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852c_e_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -ENOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 77b05daedd10..8585921ac6c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -11,7 +11,7 @@
 #define BB_PATH_NUM_8852C 2
 
 struct rtw8852c_u_efuse {
-	u8 rsvd[0x38];
+	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
 };
 
-- 
2.50.0


