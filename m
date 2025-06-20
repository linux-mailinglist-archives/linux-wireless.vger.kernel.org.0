Return-Path: <linux-wireless+bounces-24294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDFAE2290
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AABA189D667
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC127E040;
	Fri, 20 Jun 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZybjQ4sb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC111FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445621; cv=none; b=QwZvKU72rEfbxKQ0el6XJWUO1X4/fbbs0olSochA4ljohYC0qFlt049AxXFcILX4Qdw52Ytb2B/uuPInbSJPlD/qCjyy52ym1PriX0Q3eTOWdMNgZwqqBq5eaQ7gKLB7rJJr442p8rptLtP73kDjMRN578ho5s4HSurd/n9F02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445621; c=relaxed/simple;
	bh=qBPDhoEDLvjmbM258D8VBejJh3CqNYlJ75BO+GkoKvA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CPcN5SG6TZDGBg+PQ5kkQEnQYcbFfmq/fEOrrAoTxXnyEVtHnaLrOOTT1lcrJP1IgJq27JLZzFapdQE0PqzkQfcV//4b6XERGim9ikUhksyBH9EZ2KCLKb0NcY1LN7NtM6eNZtmgYB5Y5PxEaAGUpitnYR2XJLAMnbvxDDqUxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZybjQ4sb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1448295f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445618; x=1751050418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fypJ14hsScvHrpm8yo+S6aLQ74r2PcJMYNDCJkz5Gfw=;
        b=ZybjQ4sbS+VtdT3i52wpKbHa8FIa6GhThYElhYlkr2yMMKl032p/z5gNi1Gs/Lpgjr
         qXkYfgsiB9AuempNN2RUP+p8mpmNS399rje8qgMO+DFK4Cg2U2+p1KnES42okpxwA9cL
         LoIo82FDcDDRhsqQPjn0Wo1F62l+E8Rrl6+UMsYki4HMy01HjmFyJu5j3+snadUU/Vv6
         2K6eLiDsfV5QDemZ93fRl3B+1+h23zwfunl7eOkHKGbDlPFrDENcTJ+jNOWa8cuQk9p/
         GO3OouA23R12aT1WiPOGJ1DwXrLNm5sG2l/n84J9tOQ6XZD227hl1+MprMnJZh7T2Hz1
         n6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445618; x=1751050418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fypJ14hsScvHrpm8yo+S6aLQ74r2PcJMYNDCJkz5Gfw=;
        b=LjPRdMcFrQewBvJ6QcupxY/kKl9Z8RNNMiR99Vw/v98y5V8bBLH+kPBSUIAroauOzy
         Bf7dIm2sGueH05NV8qkZ2PIVzBQpb7vhxnalpFT0W6cs47lryYDF0xJ7RIo9xTwEmafA
         E4ILKz7AWbA59Q4MmfWE72Q7GYuig/yWQHq1WLM4ouUhQfLB2CceZS6eilCv/KDQDG9a
         b5p5Ze8apCyX/ETmWEBobFi/kjLT7C7rappdw4BW/Y7yY0p/mQ1iRsXQ1zVQ7/bLeyJa
         l8c3m1Ml3xIVUl+wBBfwnpHqiDAWh/jw60bIVQfIEb/CJKIpg+CRDFj2nRVL3IzEW/K/
         EdpQ==
X-Gm-Message-State: AOJu0Yzm9PnVp/CsGfiUNTVrmK/Jsot6x2uTyWzF688X0ym1mosOnDtJ
	tVRjlOv5KT2xNN7epZ9QnS5nxO4YCqtPBJ/wIogP8bVJGXLmSlFkb1LxM0N9Ng==
X-Gm-Gg: ASbGnctcfFocQyTKc88LfKhYflJQoPp04RFNZi7qC+elWSpxk5RAwGXADPL9M5YxA68
	tm9mh5uIUUDBL+JqX2QYEsDNGYM7ZLUs4PIVWob9WbN1iIpFQrU9b7t4FTUb6G7xcto5QwVjZPg
	e8cEn460vkK0lgFwpATrfTonls1viXkZbLHcR7K18fQAWk154xoAp8XG/Jy05QH2P+/c4mhxSJo
	Bk2hsxoXg0P+MAQSfnAr3z9pIZzPwQVuk85RNA8q/XKfgFmlm9IP+lLNo8im5f9IhhZqCBHWJ8w
	Ch/TzrNAPwyaQqVgoe3edF7MzPJWPS5KDnyuAJmceCiX3OWSQqXiLhNrakzY7mVwjSuUUQ==
X-Google-Smtp-Source: AGHT+IH8mn9ckSeR+YqcfzTU5GXj/M0C90sYmXGYDaR6CBFEGhLh10sjnsP0jCoH+tQ8OvE6JBpNpw==
X-Received: by 2002:a05:6000:2289:b0:3a4:e6d7:6160 with SMTP id ffacd0b85a97d-3a6d12c298dmr3653286f8f.6.1750445618304;
        Fri, 20 Jun 2025 11:53:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18207sm2772544f8f.30.2025.06.20.11.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:53:37 -0700 (PDT)
Message-ID: <8690ab79-c5ed-45ca-a234-7074ceb9ca70@gmail.com>
Date: Fri, 20 Jun 2025 21:53:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 01/14] wifi: rtw89: 8851b: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8851b_read_efuse() accept USB devices and load the MAC address
from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 39df1a255095..6ba88ca2bab3 100644
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


