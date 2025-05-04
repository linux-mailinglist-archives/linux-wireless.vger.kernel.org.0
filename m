Return-Path: <linux-wireless+bounces-22404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A900AA8941
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E19E3AFE04
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625518E34A;
	Sun,  4 May 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UasQyX4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FACDF42
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391755; cv=none; b=g2jNcEoyphebXNlcEw1c9hoeftvX87JummJA/sfn38zGcXDryO5OjeT6P+0ADHTD72j6pZBtKxX86/UuKozCnF0EVaEGzi16d8ss7Ua7IB47k8RLUy7K6dH++We/MPUs6IkphldTrNtP4SHl0VyBOPs9/aVC7ffayuQMyy5fGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391755; c=relaxed/simple;
	bh=koiGNoJGn5MIxjaio0apna9PHXbb6eKHgQn9qKgimCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RmATexPJUE3gZmqkO5coRPI8GnVzEe+nqqc45cbPDR/Pj9et9eq+F00DJI1pYi74HKomLmIyrdXC8I9sJp36VKJ+S7s8FEmQq9J2h6FSJfWTuqIQWYgmNzeRyqhJ6+pS00xbeHsgxbj9TpjSA24Fkb44pzYPn3jnWH++hWmluSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UasQyX4m; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso6924440a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391752; x=1746996552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yEH7+/XFW7hnHO6AvavVfjnscFVufGFmisKtf3HYHiA=;
        b=UasQyX4mdBIGQJnb0tKNrl18wPMCmwscJl5G3NFytowg5r5RRILh2pTZXi48giQsuj
         HbatNOWt4FR7M+QAme8/V/gvAxdHP1VvYIaJ34UCAWe8iZ2lcH/jJM9aw6JHvIcO57+W
         TizTyqyzCn8zlXTvw9bmPLASRaUenr0sn9eNAtQjwfFS/zMb5K+KfOUAuKkzHStSQD2G
         OjzhxfT4alqm98P4pjR1VAcEfxGe380mp5wmCLDwphiwrFpgPMCYJz09G9CS4hflLosP
         bSsPOn+x3p0R3j13PN7FavQZX/ahbz+WBL7owVMhekKVsouyvJJuLX0lllzq/Es5B6nk
         J/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391752; x=1746996552;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEH7+/XFW7hnHO6AvavVfjnscFVufGFmisKtf3HYHiA=;
        b=Hvy5e60EcWOPHZUKC0iFjzFDBzdXswQCU1ejilzRKjYcTdctN4WLMCzt+zoUZBtfkH
         tA8vgW6TalYbAfwJr//yrldAgNLm3hNi35Zxg7DrdhxWimIF5yTAKWtwgxDDiF5AWmFY
         2UuoJMtbwJX+bXSIzZIjF3PBrA4OWg+XGWeh4h3yiXFnCe6gdONjstJeB+cuHm3zBuFF
         2+5lNQzIWL0OnuBtFspPMnzFmJKgJN9+A4K76OSiCl1U7morzz7aqSnrevnc9IVPQje4
         bjNIzXM67ESBhojdKVdGoFxpmTBw4Z7RbbFCA0x+qkVX4xmGwgzENmG3DKcRypbGwdA0
         9cnw==
X-Gm-Message-State: AOJu0YzK2bJAdfBTB7n6jXJRTBCJ42piGKLyP+XEzZxgHOGJe70Hywzu
	VmPlgP3cwMilNBnJaZs4c5G/L1k/z62sx6jYZYw/uvWGnwk4z+8AGUBOoQ==
X-Gm-Gg: ASbGncvVXX4Es1Xbdq3miha1/phoE6h0us4NuJ0zirEH/JntqvfvMTsPKuSLxTKGv9J
	s8e2N4RBiHfofkxNwD1gwLrDBC/LkwRpuxX0mKDutQLfZnLWm8XppBTnsQAZgNKtiXC+5DIVoH2
	eQ/CvUYUilYG7NyTuoU5fIrrup+5qRlBLEwc37G4wYTFtvsXj5/6y52UiJ0jPRXtHcshvEsVa8C
	nf6yD4g2fU+95BuoR4ExreT3kY7JfCYnpxY3jBX3lxVBSAR9WnCX7/5a1FDkjfuvl0ky+0ztSY9
	FFF/I1vjdaBvM0LlklbV4gFzdnkRQoTsg2sUmuYEWm3yXZ2Nrw==
X-Google-Smtp-Source: AGHT+IG3g5nFrKdoi2neFvkEFQI8Gl9lN7pQgH5p9fLvrc7R3sLQIe0ygZblJ6kvcn60SefpHzeAew==
X-Received: by 2002:a05:6402:84c:b0:5f6:31f3:d744 with SMTP id 4fb4d7f45d1cf-5fab05758abmr4253698a12.11.1746391751469;
        Sun, 04 May 2025 13:49:11 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b8fba2sm4396746a12.56.2025.05.04.13.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:49:11 -0700 (PDT)
Message-ID: <9d8f4e50-43fe-4861-973a-460bd598d73f@gmail.com>
Date: Sun, 4 May 2025 23:49:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 01/13] wifi: rtw89: 8851b: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8851b_read_efuse() accept USB devices and load the MAC address
from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 174b90661037..8d774bd75edb 100644
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


