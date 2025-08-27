Return-Path: <linux-wireless+bounces-26716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16422B3881A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E401C163F8B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE12E03E1;
	Wed, 27 Aug 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH2xeMfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03422C2376
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313806; cv=none; b=c5spVJXyQHEt2RpP4vea6VvNCtuwQuK4NI8r3zR2GHa7bsxM/qW95xmNfzU9J7YSangU/NnzdHK4NdCnVoPTuyHvvnCU9+NHZe/fKuP8x4I6RPI+SimijEPkjSHNzPn3vynCLXQGhiM6qy6OVKWxQ8VxUDcZTSw3Q70jhwPnTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313806; c=relaxed/simple;
	bh=KXpLnzht9lHlvHNhmHUjPwBkrg4n0UiVuOrYP9V6g+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WQY2IM08QkJdBa9oQ742rdWPeaCRMF1q4ZuDWehKPyavzpLMvFLVYfcsnT94lpWqLlDdrybmw/xzP8iZRyk01eLuqf/3+s6W6gLNfSABVoVChi1WZFeHqYCydfBbsm2ueqBBpbrlYLivwuABProHBusm8vOrNbR5X1eyKoW8EJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH2xeMfB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso37358f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313803; x=1756918603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bi2yxesFqsdF4VCqih+i1iJoFunqQan+oX7byzwK9EI=;
        b=LH2xeMfBjCtGSYGnfc7rwwg8qUAVN0SZQKMCqBjaMjf7HrnS+oa7CyHz2VIWVwK3Ev
         O+tGbmA/qNnbQPcxFBG/Ibn/EN5anSygxeyOZ7xZC6g4ALDT7RaPI6ar+xDPLQ0g5/fa
         qs5w5xyEPp3Ql5ropeERjLin4kqA3i4nzdZ2jPr6Rv8kXJY/BX90Bins0wElDD4O/bUp
         TJ7flW98ILe3rR9/qBKvWbaO+VBlnnjz94B0NnsPlgjJjGwMPZl0bu+IaOoFrbHZqSP+
         avN0gFjBQekhMHOyjA/CS16BMIB29Cc6nEUU3zPp9tzrwtvZgUS/zj6KPpNBti9PZ30t
         CnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313803; x=1756918603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi2yxesFqsdF4VCqih+i1iJoFunqQan+oX7byzwK9EI=;
        b=GcydynMiR5GArxEpfqZS44t1ZlvgmKME/dar08+GtaLoBKl87wwQXQwIElVYrvdjgz
         VISN5fGyxQpGo7jgRBtOWFnqWUhbqUOiYAYZMA3qbzKZvXqJNA3QpkDJKrp8W7nVJviq
         JKzQ2q0CNAnNaG9o47cy1Fpkd7PCzizTzNMMaMaoHDdAOnRkX4dlKP7kbA9CBRXuoXAY
         Oty4oPP+C/hL91+BteZnLq7J7kHqhMGBTRn4MA+ieCyjeSLkjMNG+bAQ/RKkAl3nFxBb
         ORiTPBaRFCjY5YdXNjaOQ8OaD+3+zS5vTSzsDpZ16RSZk1Z/Fz3kXqQ9gtZHczjb5r0J
         PJBQ==
X-Gm-Message-State: AOJu0YybQjCZ3prRVJY7aDTl8R6+SozX2MaDjynrJlxTM+fscOeRb+6K
	i4HB8vhPy3HltetVPGHfCpxakvqoO8kUJHeGhdwSFc7gh4LcVtOUQqgrxo5SWw==
X-Gm-Gg: ASbGncvgheRy83Qyy5s4BIpKtcikcx4j0y0WPGmNDfTRfkd0OPLIzzZ1tQ1xyG3mWXf
	Wi2zxxjxGiHBXXkaQgXG+kkjJpxf1KdTqSFAFoUpIMAukwffZQu4fmBzPH22UJQDETYVX/BIGx/
	o5B1xueTNXKgRoboHv56lmWYeEmwna1iCHSKFLSSxJVU7cRR+BWC7CftkJvwugkbGvOmSk0Lm80
	f56xYzwHndAgbnQfjf1T7aCc1Kgb5Hjpd+KM/9LntnY7l3i9F7c8unsDvpy4G87VGUYYEHzh+I2
	MzSnvk6KbSUVwzOFK0Jp58fLyi885j8ilFR+++PmLTEACMQ2p9XxV8SJk2L4qHmvfY+C1q+Jr67
	bI2q1dT0eBGx1Ok7iaYkLyB2fGs9lnA==
X-Google-Smtp-Source: AGHT+IFLKQOOsty6cds4NeSWOxnlFoTwZWsw/Cm1P1KJRDHsK2xqKUA7gId+lQs/8JYWx0Vwp4ff+A==
X-Received: by 2002:a5d:5d85:0:b0:3cb:9495:6241 with SMTP id ffacd0b85a97d-3cb949564d5mr4841164f8f.39.1756313802799;
        Wed, 27 Aug 2025 09:56:42 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca8f2811d9sm10385585f8f.20.2025.08.27.09.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:56:42 -0700 (PDT)
Message-ID: <cf9b3864-5849-431a-bc43-f10aa716f62c@gmail.com>
Date: Wed, 27 Aug 2025 19:56:41 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 09/11] wifi: rtw89: 8852c: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8852c_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Also fix the offset of the MAC address because it was wrong.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 16 +++++++---------
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dc48c66a3b2b..79bdb648cfc6 100644
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
2.50.1


