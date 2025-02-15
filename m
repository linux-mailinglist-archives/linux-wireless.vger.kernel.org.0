Return-Path: <linux-wireless+bounces-18962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4AA370F0
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42B516CDFD
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604F1F4185;
	Sat, 15 Feb 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogk8FT+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF57E56C
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656742; cv=none; b=WiDw0PuSdoBjzgkcXRuRS8u5LUa1o/pBk/b4KYxIMPDFjsiwS0B1SU3QuvhqwXBL7eYUqod4lAOmTW9wvGCvUYk/fzfA01Lr8lInQwAJYDl2ZYjptIhIlijgPdwRxf/mNRtqAjQ3N4n48Qz0tobY7y8tCUdq/T2HIA3LeFOVn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656742; c=relaxed/simple;
	bh=bPh5aX1KMufNygTF+jz98s8+8yq2lFeEf+WX1wnXL1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bEG1B4UPwLz49sV00A4DwXfO0ga+/KEE6ODf95BkxlYo9EuM10lBQoACnrUdfeRTtyg4MKFowcmzPm5am0mJk6sbd/E27sU3RIqaZ+vazsgg9kMp4wD7BLSBgTfe2RENWNu2z/wws2AkI0loIrXlcTH/ZfKQuswbZmXnnp6XkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogk8FT+g; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso87866066b.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 13:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656739; x=1740261539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LyaXH8Duwq8+kKiyVhkjUhKETvgb1TWs8NiKCV6pHJo=;
        b=Ogk8FT+g7xKLuL2CDmJHC1JWmT5vUGeKrwj2PNK2l/YVkVL38dLNKOMMYThAzrpl2y
         OlqYTq0VYtSdZPpW+aBzLACEN1jldHpnB3TNW2mYWOepJ9Y+QN0zEAVZSs3XCrN0Quuu
         orJudGjWNeMzcp2Z+GB83CfzEYnN9dtVEsO0FCEOPX9acjV+bay/1NIhtLeMeVuSie/i
         jeI6MSmFERUtZbt/rYmBmX9z0ParWnn1/PiYOmCNSdN7f1TSBT1bbrSGjrGYX/x7QxGT
         HSNclSidVvBuXrEipTj8qTEI3wxwjiPPnHdQIsfagCT8Ba+tU/9yuRu4nmcilJbCohcG
         F9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656739; x=1740261539;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyaXH8Duwq8+kKiyVhkjUhKETvgb1TWs8NiKCV6pHJo=;
        b=uFcY1MnD8U7NEpdRSXRPO068bHIGuhsf/8U0j9cQ0Eg4GtFPgaYptneEngm1eNEY4h
         ZvX8oDjk2ziE3LR3BGd2DWXemZCt6LEeR2Bm1ofySfFuwm3uYLNMEp1aaBouu4gRZFpV
         NSYLCJDitf97VUuqOTQNlqU2thzPDRxZ7IzA4F/jkAesUEN3GbNdUywV6E/NOVmtmbG3
         nl0G4jZZUUUS86/KoeiZdFtZZz+BI4zH2EaWi4I6I7dxXHcFCPQSnwoNYojaGKh7hyoI
         pboOYlDqNABtXrF5GQI6HE80p6raU61qbJtxpiyuJT1Y0gVkfnv9YkaJs1VyWOFG3xfD
         p9IA==
X-Gm-Message-State: AOJu0YxTcFaM/bSju0A2St86h++mrWGorKQhtGfyXfIa+NuUIavaf5Ga
	juVWL5l27HTwTdQNcfO3+PNnn3BKEEr61GyzcBIYsjlwFduHLbXu/5h06A==
X-Gm-Gg: ASbGncswLdJPD16gdNc0B8YPxWQPJ2UzfvflEhlO0boir+kcCRURP8BInJsMsumlfhz
	qRlhPLY08ReeTadVPwXhoUY+07dsSHTiTKUNhO91Y8G5kTviBEQcM9liPEGtGLDMJJBzxOVELe9
	merNfOVCvKt2aIn1i2lJtISSALnCH6cehZzPGg4IibKtT/cKc88AJr89ZD7Zc+T0wJ/NWFO03wM
	ve8MDub/t5FIvfpWxvY0dY0PJmlvHWCuelDPqKtt772AWDRa/xyKZhzrJ5Du6LkBQXLX/rOmu2Q
	p8cweNIqInoaCC9ygh48gyu1
X-Google-Smtp-Source: AGHT+IEH+l2A4h0QdbbA+9bNrXMBX6hDFbpSp54sX5thTxycbv82OuEUeY7VC1mhTD5Okqr/accmKg==
X-Received: by 2002:a17:906:6a03:b0:aae:8495:e064 with SMTP id a640c23a62f3a-abb70d77263mr413037866b.40.1739656738483;
        Sat, 15 Feb 2025 13:58:58 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5325b58bsm591583366b.74.2025.02.15.13.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 13:58:58 -0800 (PST)
Message-ID: <749490ce-6663-4c82-bdf2-8df1e237fd74@gmail.com>
Date: Sat, 15 Feb 2025 23:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
chip is powered on. This bit appears to be always on in the RTL8814AU,
so ignore it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Fix indentation.
---
 drivers/net/wireless/realtek/rtw88/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 63edf6461de8..0491f501c138 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -291,6 +291,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	if (rtw_read8(rtwdev, REG_CR) == 0xea)
 		cur_pwr = false;
 	else if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB &&
+		 chip->id != RTW_CHIP_TYPE_8814A &&
 		 (rtw_read8(rtwdev, REG_SYS_STATUS1 + 1) & BIT(0)))
 		cur_pwr = false;
 	else
-- 
2.48.1


