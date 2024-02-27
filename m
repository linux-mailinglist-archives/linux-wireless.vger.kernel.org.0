Return-Path: <linux-wireless+bounces-4085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EF869050
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B361F29100
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041E13A891;
	Tue, 27 Feb 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDyAz7Wr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3413AA3C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036458; cv=none; b=LKsj0vMBDpXH5jI4s5rfkgvbKbVp+KPunr2m+/blbyq8CCf1jGEU5bI8OAp5kBs3IRd9JU9KtvA8kzhvw5IQwDeNruIEyv+F86/lpzPMhIizUhAtPzaX8ZUsdqPLrZnvav3lErZ1aWX4bV79BFXOmuztD33+FkCa6AfkURhbrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036458; c=relaxed/simple;
	bh=hlmUwANRaFaAu1C9VuTwPmQEJFuTEkK3YbaG7alhduE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bh+dKmcY3ThA9jgPfo7eKa7KcLKcckJOiI9kscNiEeCA8l8ZxLC1mf53xA8uT1GtggWRlLJuqx/K2r0xSbEeYlATvJHSDeYi6wixxZImH+gJnLePDzYoEddtw4q2kbN2UAnyunMoT+pEKIOJqtJ3HZJOpVgqc5NmuIi815nt+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDyAz7Wr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5209737a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036455; x=1709641255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wfMeJBjMkIyQXwN/Pu/ck+cMnJNHg5FKeK4s9gmkheg=;
        b=JDyAz7WrGqaeP0PlghqXcC76SpYzEpbrjbShUOCJc1dLTk/Ava9/ku70X277GuEqPz
         lclPbexRZbaYazOXqb3v1TrvlnKHKCNaOZyBhahBpcOhsG0YN+rE31v5AhNohh8eE5nj
         SqETi1EGzV4sApFNS3X63aUcKQiuFz8OW5am1AFXPJvCcL4s719FKf81u/m9cwl6x3uQ
         Yf1RiblynAIZ2R9dfEN/+550p907QdpdfArlJFlLHwIQfOHmZqPwkRQerxDRHzat62WY
         O73hZIVnJKZbTSGVumehmIDKP+9AiS3NDl+EeZ1VtcIWmihsISUbx940IumY3WELqNLU
         HeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036455; x=1709641255;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfMeJBjMkIyQXwN/Pu/ck+cMnJNHg5FKeK4s9gmkheg=;
        b=vc1USUvRIwK99gGSJWacG7LuRgg0sJ+j3ATUp2+fKonZQVolV5W1wMpVOpEzAJA3YG
         WaVtdxwbNxY4gBXZGeD4W9l5R4jeP+uNk1cubTg7aY47oEwOFRUmzKsUe2qOSMDwEbe+
         AuwuUWfkN0KjpW7yWn9goBhHWRccVABm76/4UV9I0J3lSGly+kRoO3/LkMMAtax2/FUw
         NcDmy9hfM8tfGHW9ZrjrlatXZPeqSM2VBOxenZSO0jqHvgFXVi9R+CRyb7PZWvgZ6swc
         16aKz1ZfZTnowFfXP+y3lM4LHEcXtQ0IIBD3FYWD4cbWwdGkq9oky4SaFFvLVqOOrLd2
         uCCQ==
X-Gm-Message-State: AOJu0Yymm002ad/1YdP33LnjqQ1GGRJ0CBRqp07UQeqDj1vtenxReLDx
	thK51NMLh1WnbXkEcKkwZKOu7K2OabsRRPS+OZOwq50lB8FZZwDmqXLqktWK
X-Google-Smtp-Source: AGHT+IEe9ide8wgiPm2EetIvl406fr/+f/2WjWrNGUNTCjJZjGyj6G00Hx+A50zD+kqCfQAfAhhhrQ==
X-Received: by 2002:a05:6402:14d4:b0:565:dce3:670c with SMTP id f20-20020a05640214d400b00565dce3670cmr3702976edx.41.1709036454992;
        Tue, 27 Feb 2024 04:20:54 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00566317ad834sm681406edb.49.2024.02.27.04.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:20:54 -0800 (PST)
Message-ID: <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
Date: Tue, 27 Feb 2024 14:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
Content-Language: en-US
In-Reply-To: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make dm_info->total_fa_cnt the sum of cck_fa_cnt and ofdm_fa_cnt,
not just ofdm_fa_cnt.

Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 429bb420b056..fe5d8e188350 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
-- 
2.43.2

