Return-Path: <linux-wireless+bounces-24679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F892AEE872
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ACB189EB12
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157A233136;
	Mon, 30 Jun 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoKE9DyT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED891F2BB5
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316209; cv=none; b=Z+lld+HxRuYAsuAFlhUoFJBENGpABNk8mhOOLormCpWh3XCnffFvjZ4ZgOd1wHw7HMdfoWIbC8hatS82UTUm6lpIaJnmT0BaB2iyda4t+POcPiDb5oSIQA2Pj5cY1f0vzOjn8250D1fFTguMtsW0C+XKsIZ2jBvUKEN/LpmP3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316209; c=relaxed/simple;
	bh=Uqzh5HyqhEf3wGOCDxHqD6BKqr5Dc3Xaesp1J9sV65E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dzl5v7yetbvuwfBztJNDN9dq3dZlX0hTLuF/zxCF0dNGlFsoxmm0OaZHQeqV2a2ZIf5r/lHKVPj7SlbooRkMHdGLo1VQr1G2YKgBdGLMciTI4hwgAGTjDj8/59ziqXRynt1xvi8l/r5Rwb0c2QackxN915Ht/vP6mgER5CZrueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoKE9DyT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45310223677so18046505e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316207; x=1751921007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjxjoJG4eb8vDMNOv4A4KVhikwwZ01dcCvfujJ/cD4Y=;
        b=eoKE9DyT8SDV2MoEbcXXQulXzgnCwk8wfIPByH6lg2JPr10PjxstsDx8JB4GsyG1h1
         NkiOs2z675znLmBPx0QxM+siwMGQC2uuwdkinb6EcsEljt2Ti/PrNCzxHPTNo2BrUhBZ
         NtN1hzwrzxboxYxFXPzFXHI5r1P1FvTUsQgkJ/obd0mZQcS47TOqlTo8Dxy4TjDr4iLm
         ZD0AOXsiBSEmrNtpMb2PiOp0n/LaXj2N942minjtmYJcUYfLYd6WF1HrNcH4JgUfDI/3
         FxVC/7RpqROwP/1RzaDiOK32ZyRAKjBdQnA0rL4ehy5ka+i9zBAu7x/9/XambJtxnQQi
         sJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316207; x=1751921007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjxjoJG4eb8vDMNOv4A4KVhikwwZ01dcCvfujJ/cD4Y=;
        b=Sal0iLzjFC8R5cGYEX2smdE5Bnq9JIDkpLKNlWMhJgVk6OqldTL0a8oRNeRMipoEew
         BHYAWNxCaPadnGIApOJhla4le+INICDgkjLUfFeAMsroN7+ScmYv5MjDLuANTdlZtSYM
         sgIAa6IWThLC/2Iswgj3yQpV6w+HFCE+HAWOXVZ690sm9Rp+lk4Yzc3Tu9uysir+kWxe
         pWPinn2wsMJH7pqXiHKs/Lwgds7QeN7VEsnwlWW7DBIQPrOdpkHj6AGQzzFGmDJzsg/N
         MRP44GYGtVs5OnIT+fNCYIc62liPV6Z8wRa03AEUU4N3MKeQOcTsf/d/xvPLUVyheefU
         HZeA==
X-Gm-Message-State: AOJu0Ywb6zMx9al5JnmOyZlmj5cJ1sFkw7BvYUrKf2BABWHq5qA7rxL6
	qdVKNHPpL2KXq9U3xOOy/SMupgadmfZpY9RvTrzn5gLFArP6w+u/wz9HEbfKGg==
X-Gm-Gg: ASbGnct/inTp1h3dizPe3dcBbwaXWgjxpm4wBbVFOSDoRrAb0FSyQD2X4/NUqndC8Hz
	dYGDTy2+3q9OpeHZZxqiuwquX5YEzKr8xWeAaDcU5OsBY+1+ULckGWJetzos27sk3z7PVlBLoG8
	OncQTjVge6+IGk00GiwdE4cUb+hseKeJaFPNbu2gzjuZpKfxaDwzwMJVJHTzROn73UVbfV55wHB
	sFVn3uutBY/Y3KbAv4g5TzADEuxtEDfyhpZnp3/HLyboZMBmwLHmjdenOwRPwT3Ac1r3pINRzEZ
	tT3sFNXM9NXVuaEoi2aXUk0jvLRHdkX+88sbFwJeohYUzkFZU5zQFQfMPekPty+7VN7wsg==
X-Google-Smtp-Source: AGHT+IH3rw50/6dzYoE/rZrUO7s9bYXxHlMZ9pmvQ1igGUzO1BAlVou+50wzzWsEv5pFX2bmIsNpNw==
X-Received: by 2002:a05:600c:698c:b0:441:b076:fce8 with SMTP id 5b1f17b1804b1-4538ee5db08mr159699605e9.14.1751316206479;
        Mon, 30 Jun 2025 13:43:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a306a01sm153191255e9.0.2025.06.30.13.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:43:26 -0700 (PDT)
Message-ID: <0f49eceb-0de0-47e2-ba36-3c6a0dddd17d@gmail.com>
Date: Mon, 30 Jun 2025 23:43:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 06/14] wifi: rtw89: Disable deep power saving for
 USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disable deep power saving for USB and SDIO because rtw89_mac_send_rpwm()
is called in atomic context and accessing hardware registers results in
"scheduling while atomic" errors.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Disable deep power saving for SDIO also.
 - Don't disable rtw89_ps_power_mode_change() for USB/SDIO.
 - Disable rtw89_mac_power_mode_change() for USB/SDIO.
 - Call rtw89_ps_power_mode_change_with_hci() only for PCI and call
   rtw89_mac_power_mode_change() for USB/SDIO.
 - Update the commit message.

v3:
 - Disable deep ps from rtw89_update_ps_mode() because it's simpler.
 - Leave rtw89_ps_power_mode_change_with_hci() for later.
 - Update the commit message.

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f5639a5d166..fe6b19a078c5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2884,6 +2884,9 @@ static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return RTW89_PS_MODE_NONE;
+
 	if (rtw89_disable_ps_mode || !chip->ps_mode_supported ||
 	    RTW89_CHK_FW_FEATURE(NO_DEEP_PS, &rtwdev->fw))
 		return RTW89_PS_MODE_NONE;
-- 
2.49.0


