Return-Path: <linux-wireless+bounces-19076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A51A38F9F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D363A4CE2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1114F9E2;
	Mon, 17 Feb 2025 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPErnW48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAC748F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834945; cv=none; b=otTyfsWavicOW+ahJc1OleCZn4wcCPSU5ma+4NCbWaeKiVbCzJ0rtoOhfzUJhyqbK54EIpDvsfBvKwGNyQ1lfzKWb5dj6RzEQ9FMJj3dUpDM0OhdzNq7lyacuXapQfWPqZj26H+xrslQHa9kbOl7kJoVxpRrKBtsW/aAGzw5YVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834945; c=relaxed/simple;
	bh=mWAON8Ri/EFtRcbRq1K739SpKiVbj5M1B0ystpR3XgE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o9VwcgYqC+ldzu7pMuL+LrUKc3jBNQKpSq6kwdm4eII8XtUoezH0ga9XF9CiPvQbA7jG4mIl5KMHg3uMVlcZJbWXDxVeFyceF4xJukXc9DmSM/JnOF3MKWr5c3d+h6iF1uOrOxFukysfD4RhRvukZFYL5N0Zu7ZMt885t0FUS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPErnW48; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so7938612a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739834942; x=1740439742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4yN3GJKIrid0LbO1BVVrkFjsUHAqNN5obsVl6EkmWQ=;
        b=TPErnW48Rogt0Fb8D9hTbep2kEtsUtxpUNu7nI7AZmJKanjU1cVi2fRFtN/zzWKIpb
         Uptj16eYTw/DGFayyTaHR99A/FE8TIWmwnz6YdaQaxObdkmPzpzy3fgiSyVrdbMHR8Im
         kk7SCGgFCuaKE8cXSBIyrVLzMmGRjfobfL+rwkGgh65JpbwLZjpBg57TfYbwWzSgSw1o
         LaPASHBFma1tRirJZUuBnm2Gy+5iWn5ywg90notdJjXjbb5dAbpBtHADRsZMzpO1wBUM
         TM63EVAikOxgl1Qc+/M2ywsHI5RzDDEe2l3r5ndBqyKylbV2L3zMY0A77HbhQ5ZakUwh
         xy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834942; x=1740439742;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4yN3GJKIrid0LbO1BVVrkFjsUHAqNN5obsVl6EkmWQ=;
        b=O1HuLkCjkveRf7XgBK3CHs8XvK7okL79OtSmECJ2X5/KYAGKkzw7Ra80fG8AGCPXdI
         CCgjJle9eJ0WtGLu/2cqRkoZB/C1JpLa85wgirnjU3qyyDrrmMVAk7UnrXOA//Tj9oOO
         debqYD7LRnTWYpwIQT5Y7UADJFi00KVoek5fxv4+OqdaepQDKX2kBEmis0bplIOXVSGR
         JEwJJEwOQPvVQ2H14kGl+e23Gb/DI8GhhXrxStIfYIm0pEu7mf4qMAU8ELIsGdO6A5Ce
         XHlaNsi2tGavEz9Vqmap8WXfDzscgb4LsQTaVieKLLjExgYGEDT/NSc6GQ+n74ZTIjHS
         ysaA==
X-Gm-Message-State: AOJu0YxHKFhnvWoQXr7ZZvqQoF5tm5AIz2OiZKCHG38Yx6a5lFzlhipS
	WQwj0XiByG0F883c1kv81zJO4afv4+nG/5is1H3rGDaxN5PisI4BGaJTNQ==
X-Gm-Gg: ASbGncvvWcwkneEGEtwerSACik+jjWR3q6Zu949SXvsN9JbWM7Gt71GetskAT9GI82n
	vM7XSC0h17L2vxji6zvtTWHlB58rYYmGl9mbEFCAOZW6P9rl40tspPvmv8yGj5QhyamjENDrpN3
	Shr+cvJif42WUtvL7GSlZ9i6770ShXhQQNS4OFZ/Maz1GL2+bN/5abQH70wiVTmmdP9mSzuuSUV
	5Vlm3yIDVKn9cvjSKYEHAZjnXkg4T7pCOLOEVztpbuWsYxwUyJpxRFpZR/VnpR0n1uOPV3CzEna
	JzMlWEQHBdpBwqMar9Lmywro
X-Google-Smtp-Source: AGHT+IGOw75kAGFyfC9XX3c+o4xGU3GVrbuQbnUmGEqp1R1GndZAog8lfrGHjlY38kjyy9BO5nNfug==
X-Received: by 2002:a05:6402:3488:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5e0361c1eacmr11579614a12.24.1739834941716;
        Mon, 17 Feb 2025 15:29:01 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287d3fsm7699935a12.72.2025.02.17.15.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:29:00 -0800 (PST)
Message-ID: <2f0fcffb-3067-4d95-a68c-f2f3a5a47921@gmail.com>
Date: Tue, 18 Feb 2025 01:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
chip is powered on. This bit appears to be always on in the RTL8814AU,
so ignore it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Fix indentation.

v3:
 - Add Acked-by.
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


