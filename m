Return-Path: <linux-wireless+bounces-23892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE9FAD26A7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A6E161E2E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7F1CD1E1;
	Mon,  9 Jun 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx7ttCWp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F419258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497021; cv=none; b=m2oMh1MnOPIcF7NOFmRZ7DWqknPrAW9g/VPs7/zraT27zFoF8xI2iNTL/vDNKtd+EjhMgeGLpQnGxzQYQFPL4MhyFmAFLQTzBxs/Ls6MbpiZUCxCtQpunJfQy5WqbOJzzac7CQWh0Y8kVKqqeYHVPcsh6jWSwr4Uz9IsM6ylS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497021; c=relaxed/simple;
	bh=63L3UDL8J5DhCte3GLcbbTBSkUON6N3FFFt3wsHHT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KkgnroAH6Gh7JxOrZSIMqbgKFyoEwfaRnWgOekRxoso1SD2X0ueBkmlPoRwwUCJLv9+XKNP7wB3vjFA106DT3k3Llg1Mg/3XZeOdkKO4rtKiLfzqTOk6PhVL5yPmeFfOPh0VEE34peQG1QTNLzNreIlRbDxaip9tz3/4TrhntEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx7ttCWp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso8209825a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497018; x=1750101818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2iICtur6g1oo5eiKkTXGu8IeImTt4JuqjKviwIqNIxY=;
        b=Dx7ttCWp4vVTUT5+4M24sNlwEDlmH0lmueoFx+Kc//jpL8KghWcbPtteg04MUZN8oG
         ZD1POWLdmXmeGpSu3dU+EmacZIBDyv5f/U1BT1ylTiRnTohGaFP7Ir02OTsqc6HAu0Zk
         ZnKKKCr508FP/zNsjdiZk9L8h4KjN0Y2ASaGIn3G2lwDgrZPwWvV1moDzK60mqZ4kWti
         G/MuFXwUPZeNq7PFk2hwwVCrMKmBSDvN2jX5ncRrll4y6/7KVRJESBUnzBQdJsvJkkux
         9SOHLCSS042sWftoj1YY44CVT8nzGmFp3G7zNlynWElvVRIOCU2Udi4F8ytOiKmzpT8w
         BMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497018; x=1750101818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iICtur6g1oo5eiKkTXGu8IeImTt4JuqjKviwIqNIxY=;
        b=qSesLeS4kJO7LQ2L6En7K2MDuQOsFvydlIM2eCQdWFPClOqWbWNaCJ6+LqHt5BkpOP
         siCLfyKzUJXpjOZxBBRZgIsW/Vaok0CAdqpy3GJhYtlds4oIDu4+sNOcNQ7OqCZqkV1g
         yWBmBvUlA/qkfSOmHBPyVE3N1qTs6wXEraQEpaZ/lOUTGgdlM04LbDFvpxS+7dWYbcCv
         a8HdzEpmb3zCC2vZMfMSK45MaHzxcwCJ6VVru6sGOwlCAzeKdG9hEXmkkfpzQlFQaTP5
         j8n123j1UZ7n83bVV02e2cePQkID7cIVRaHLRCyDJJN4m2NGQlGRFNtQ444gF2Aqruj7
         Hbmg==
X-Gm-Message-State: AOJu0YwJft2OIqDvoPRDumrNHlI3077vrYHqhqnkcS5UnN32Ps7x+SVG
	BMIi9GUdXVOTbYwICC6eZWoUKAlyjgaSDTYsRvIwZ52m0cNAynzEPAMBl7qybQ==
X-Gm-Gg: ASbGncsJfe0YMJ+wSCnG+ztGPJLcaU5fbLJfEiwdJGJJ+1xo/Emq0IwUHw2XsHP+Ath
	cEzQlqvWm4zwVc4prIQJNM1Uj5TH1pSI0tz2Pt0qZyewcsaMdTaCnuaIyZOyKys0+vTCV81/cyd
	srcGfP6OWjTC9qHvcjFSPhwjXwJ8bqdAwUAevIutKhw6cJ054FnypKJFtNmsRrDsgL5wHvRRRys
	DxHk912Mw7OZRjnbWXNDacBudV3TBn3sKZ3+7ohNFuw8pHZYwAc0ajS9IRo9qapGZ4xDa6OOTWl
	DglR0CGjkbkQrtF+/wC/S2fCWNB+6DZt4JzHjU3bbXVWHGJd1EJMqUSrDZb6g+vnVwgIRA==
X-Google-Smtp-Source: AGHT+IF85RLTmbtVcyCubBnm724EB2xDl5dQbVV6o5GOXp2KattINeq19klkymVUSQJEPxQD5Kai+Q==
X-Received: by 2002:a05:6402:274a:b0:606:ef9e:c711 with SMTP id 4fb4d7f45d1cf-60774b7f794mr13621389a12.30.1749497018220;
        Mon, 09 Jun 2025 12:23:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077836fe51sm5030876a12.13.2025.06.09.12.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:23:37 -0700 (PDT)
Message-ID: <c2b5d5d4-c441-47dd-903b-368958fe200c@gmail.com>
Date: Mon, 9 Jun 2025 22:23:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 01/14] wifi: rtw89: 8851b: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8851b_read_efuse() accept USB devices and load the MAC address
from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index fafa200a9c8d..c9fdf7e8e53c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -461,14 +461,6 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8851b_efuse_parsing(struct rtw89_efuse *efuse,
-				   struct rtw8851b_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8851b_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8851b_efuse *map)
 {
@@ -549,12 +541,18 @@ static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8851b_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
-- 
2.49.0


