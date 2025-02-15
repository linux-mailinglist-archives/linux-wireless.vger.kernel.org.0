Return-Path: <linux-wireless+bounces-18964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68660A370F2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D2B7A349C
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DC19B3EE;
	Sat, 15 Feb 2025 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp3EWUwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50F153803
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656829; cv=none; b=bGjAyrfYSMi4Jwi2zvWF+v2k2g76Zv6g4PaXzQdx8yfi9JBJFk0hriEIQzuuQjrEt5o3sz2eoywzZUdQLY7XSzWMbnyd7/ckhWdxjhJFXWsu/dErmmn2GTsB9RYOMDkv4EATgc+hp4ov615hLCKTY4D2xNefWNcdGir4HhvIG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656829; c=relaxed/simple;
	bh=S0qMUJ6XSJJkzXl8EPzk0cQghbNyHbEQ2fDm/vBz90I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ik/4JuAftqq/Og6sarrv7YqXVEEzK6YShsVf3AHorowvUxg18pMPn6VLOodiVEfDt3lT9HfwOa6Hl/+jAwcWJ/Uf65M3sD4KENkC3zmZRbpDgzoHwf8YZx5rDGtsG0ukCjPHCHBzf+OegIkWXiQISCLi+Ar6GTO5o8P9Od70pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp3EWUwT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso727098566b.2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656826; x=1740261626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGG6dmGTzJ+8pUiGHLaAE4SoVCuq+G9S7DsnSuwYi5g=;
        b=Kp3EWUwTPLnNy2lwUMqvI8OExAbjaW5hX2DNCknqIxHg8+lT8MmGrhcba/vFYOaGdz
         0FV3C4VNHL56QQGxntV1ti76qVI40hELy3+C/cFrDbcToicbZemKwdNeZLO+4tJyVyF3
         1XVRlgWPoICcZK+ZMYxyoNLJ7mgSN80Dp6ZVJiliJIYIBrVP3upvLAloetD1WyhkVHTX
         tfgJf9k9633M1loKirZDqpxXkYg88jvagNfhODR+guJK/KgnIiwCmFL9GgoOU92JYaIn
         t3C5RiGZQM2SUBpZhTM4ADt/nA0e1qajLZcQQ3GZnyaZFtecNLvaYVmRKEQkKb3dAdgT
         5Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656826; x=1740261626;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGG6dmGTzJ+8pUiGHLaAE4SoVCuq+G9S7DsnSuwYi5g=;
        b=toDNiFEdWWcoSVScDZlsiGHexTkfUq6nwnZuK1FKnLNUXuXn2WFV4cKNNf+wBTPycb
         mM/t6Md8AO4eOta3IIC9+Yr83PiUGHifCii86ISWQvp6XHiIdAKNHIxgaA0EbK6Axxfb
         /xGwa/JDKTZ8OrF2nL3U4UhtnRj5zb8wEMyw/8o1phbhb+PxK7g0DxwjKC2iDOc2Nau/
         sxUTXf4C1T8Vblt2rOz4I7eKxdr/MwOEFduL68KWvaTHPc5jw5RPUNu4Qs3MYDZytZfF
         Azo/IDZus/Jz9uuD4KjrcCT0zfys1HojVAH+Qom1qNMiSptgTDYTsuIu6ATSUUn/1yrL
         rhJA==
X-Gm-Message-State: AOJu0Yx4rVgW4QPuex7CANRlQsuEq7/z78aAYuPdPZADft2DrE4NFHmf
	QSzyUxnSVBDz/z8YTx8npgc4ofBE4kvD1Q+0HBDGd8eEm0kpVbHWiPhT+A==
X-Gm-Gg: ASbGncvGmYZ/NcQzROVGU36egubRkngUuDwf+NFa6uTh79BzA3MxYrE2YvSBWcpF7QO
	U6iSp8P+V7CercvnOD/uAQg+fWUw3/lBKKA5w8DaUteYTSA1YjYMmQOjXsRzu4I949o2sJWTeI4
	6EJN9Wj60Q61ijLZ20sETOPu27QvgfcJ3y4FiU7A7Wk2Gl7XK+Xw/o5rIaEIB5/6RC3ZZnCVoXo
	A9/QwSj5RkNpBLgkRyPFWnzSmrA4lx3pJkVsNubxw9ASPhwr201aYaN+MdIDuqbkIvqxitRy1Ce
	AZ0vZbb2O/MZmXApVJGbGaTX
X-Google-Smtp-Source: AGHT+IHPoWyP39Xq1ur2J9cpBGHPQnl5ZA6hiAyRYIzLa07bMkGDj3BzD9KfuA19uLAG0iktKfon2g==
X-Received: by 2002:a17:906:c154:b0:ab3:7812:ba69 with SMTP id a640c23a62f3a-abb70bfc710mr500834566b.5.1739656826065;
        Sat, 15 Feb 2025 14:00:26 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533998d4sm600387066b.130.2025.02.15.14.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:00:25 -0800 (PST)
Message-ID: <178f6dae-b72b-4f73-bac1-4678dcc1062b@gmail.com>
Date: Sun, 16 Feb 2025 00:00:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/8] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the RX mask and the highest RX rate according to the number of
spatial streams the chip can receive. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e4f9b744f24d..3319bb5044c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1565,6 +1565,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1584,17 +1585,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
-- 
2.48.1


