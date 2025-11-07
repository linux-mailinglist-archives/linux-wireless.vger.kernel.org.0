Return-Path: <linux-wireless+bounces-28684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDFC40C6C
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB565566B0B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172B256C9E;
	Fri,  7 Nov 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGhOT0YF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1F2836A6
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531732; cv=none; b=KJ07LrPKGucC+Fkznpo+L+209ozffdB1ZmegfJwZudHd1WlLiGl48euR8VJmLoiE+IxFQWodGGG6GREoi96IZvItF4Anq1gUHsqQSjtOR2OUti74fJ3JWY4vx9645WClOV3R8oGp3o8urEpRXiUNYQJp/l0MJeVzwkbtlLnV6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531732; c=relaxed/simple;
	bh=iHNrm9AUVhUMsB18n3I35bXIeKqxM2dmP/7Zoxel/60=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O30elwPtXtgBKjObFkKgLZFkWll5q7YrDFfprPvUInTCxYFcvLSmVJdCu1uWJgOqgQe4klGV1/uQbIhZln395el3YYzNGwc2d+Uhsd76/N0cbZOupQ67Oz0JWGCMm+HI0FvF7IBHthUvHrxCcopl4a4GL9lXqy03lGTLfeMYe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGhOT0YF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471b80b994bso10039495e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531728; x=1763136528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZD+GKiML/3W9oQgBa3CHnv/elljaCWCuTl7msOr8pak=;
        b=LGhOT0YFBJvIx8EIheGOYqU5agALPgxXv7AG+J234+bE+yXOTJaKfqxo3YBOZWuizc
         uHfcO2CzsBUfBf/8ATVwow/8Xzzt5cbo/JEFFreQcdbUzIfpOouxp3QkCZ8CmsGzdQGI
         ZkNvdOEBA01GCv9tC3YyNdeojtF89Y86qubgqQTNaD+1vwSZCGRRRdUgLgA6pPAGb31e
         Oc3Ne1ebZSsCYqlTwJxl3Sk6GDqQdW4pvacqoqVwniIXyVXl46xgcIYONBeeWoC/Uhi4
         nPN6krutx/4S35ZoW7k/QzZp3u/ClTYa0k6kw+c6m3quEUuqz+shZ5W/jMKwvQR7wTTG
         zCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531728; x=1763136528;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD+GKiML/3W9oQgBa3CHnv/elljaCWCuTl7msOr8pak=;
        b=nhGP+A1BtjhUvQeNGCqXyj1tFVozfkypFOczD/UOj4sKbknvHeUe8D+vohNjoouXNk
         0Pywf6uaXtem1NvnkLk8LDgxG1Uun9lIZ8O6eRR1fjOyggN9ivTKgyEnKHP0818njRjQ
         GZPGnGC4LH3qaINfhgSRwnAKJVZfYBSa3wLu4wqmZUcO/HWYvNhsfPRhSaDX8iGKYUvH
         1no1eidNziEAXxLnTugzim0fskcVydzlZR6kxN27LgwoHm4KnxxMT2OOwGt4gxBC3mgc
         rtsgSlZfL37mF0fltZqrELI6mfQrsvyrjiRuFdoJgvckbAndJZ+0hhDZsYg/lY/gNZEx
         jU7Q==
X-Gm-Message-State: AOJu0YzwQ4l0Mqfs0Mvj3ONxdpgteFI1jsuB8LaG3AScQYt5OFGXIvgU
	1bXsADkT8Ft4zHAKCnMFbNqBQXmMqk71VrN3Bl77of+Dv5NnyLnzL16/OOeKbw==
X-Gm-Gg: ASbGncvm2cfhZrM5rtGqRswwbAb0INuVlrS1FJRBL7Nnbin0a0MCvfCBOBzALE1o9ik
	jUzdg8H5H/HcEahr2KbgeIGNvE/z1WsWXePPRhiSlIHqmiu31crSsDGuD0vomZCUdIZ29oTpHy3
	qlZwXQlWGR5+yaKT98DEQExGYr57RobSIYewroNWlgotoWr7Em/98raF0wq/F5sKLGfUCGacW3Q
	ibnKvxGJsudtxauKhLjfWsokpeC6ktQi2N3UQDDgCoCB94iHNf1ejyn/MD+xZPp3rmRvu5HUfBR
	rygE4VG8ZtyjrQ9ka7fWMwGglX2vkBho8p8UdrAtPc5Rcr4d8sRY53ifGpXvurEMyyy7DbEFpad
	eIE3PbbvCl34njGlorgT9JiXVhiBeIbUwvm036I5f6lziJ3fOZx8h10YFJdiz8ZqWl3mOR9aZ2R
	FJzJQln0owJZZLZrfdias=
X-Google-Smtp-Source: AGHT+IFHpEIPBW4y/ehWl5O0RbC3uPTNQMvSoxVNBY1MhEqc4OhboF/Tw64wuuKMUYeWH3qdMIA/Tw==
X-Received: by 2002:a05:600c:6287:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-4776bc22ca2mr32393615e9.0.1762531728479;
        Fri, 07 Nov 2025 08:08:48 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776c2aff72sm53140105e9.4.2025.11.07.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:08:47 -0800 (PST)
Message-ID: <97412e2c-ac98-403c-9056-9d9fe1ed9f28@gmail.com>
Date: Fri, 7 Nov 2025 18:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 4/6] wifi: rtw89: 8852a: Accept USB devices and load
 their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8852a_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 76b64fd5a639..48205aa4a980 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -621,14 +621,6 @@ static const struct rtw89_edcca_regs rtw8852a_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
-static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
-				    struct rtw8852a_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852a_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8852a_efuse *map)
 {
@@ -674,12 +666,18 @@ static int rtw8852a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852ae_efuse_parsing(efuse, map);
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
-- 
2.51.1


