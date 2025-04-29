Return-Path: <linux-wireless+bounces-22193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D9AA0A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93CD1B6643C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED422C108F;
	Tue, 29 Apr 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVFFuFuc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02152C10B3
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926716; cv=none; b=Is/aeoOFyQ0iyvn+i7AgF44W3DgQUToNWb5jyWic5UE/eotUqgCniqXREIm+w1beluDfNKgRsayqKD+y4ub4x9PVvdyzlqEVTApgEfXdEZD/FNYRugWQ2x8ItkkBPDeH6t764Y0GvYUlr8AZpRTgFkYwg/mOXYkKgzBFPf0mLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926716; c=relaxed/simple;
	bh=ZMMdSJAz6HC39zwFjExtSNYOeqTiMcMuhOTnW0CGgpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KsVfou64U7lLpiKeIXb4wZEXeTpo3y1NdRGbzzlvW4q1CIE5eS/xRJxHy7tMGio3gfc0VOywDarSqQ6SFqXkaqZLG7LDhdhP/G2Ln+XTaQuwAkb6G03OALW0d7dM0mrIJXOnB2RwhHaUGh9lefrmU1i2bhqoiTQb1eLyFN+P02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVFFuFuc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acae7e7587dso866326866b.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745926713; x=1746531513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKmgAQhcf4c+2Jjlt+oyFMA/DHJfscgAfHvO3Jythbk=;
        b=PVFFuFucahJ8piOyw9fk3k2GvnjONs0DsdF2qkvAfFZVM/0ahka526v0v+JUmoh2Fn
         09fXSeLOcTCxPh1x0jy48gUOVSOJKlaeLGCxMz2YxW5474/iEBrLn5aKm4Px2oGBKBMm
         Ur+UgaEHKbGxzH3vnvMD2zCaWLiiA7EDyWKstb47FFlwJ/rqlM5F79MW2Fg55Tnd5in/
         Xl1rm2Oe+pQ3xWRCe8pNLwe+HmNt2ult2HTHPtHykFUWCtxwK+/yp7lo5FlxB25+QTmg
         GDYVyqqMZKtAGtkcNbqPKbYBg9FLR0T2nCZCvqoP2UAd1TOA6q+92QozO6p6+JbBDL76
         YQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745926713; x=1746531513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKmgAQhcf4c+2Jjlt+oyFMA/DHJfscgAfHvO3Jythbk=;
        b=KrYhYtxtaJhKjcHTaLmm0JEiXijKj/GfRrONPWwOQ6e6tVjfdevaS+CI0UYvHeJSYc
         Zdtvb1VAe5L8TvG0MA0IPRBT3gjs9ICSKRMORCu/nbWvfhqoiIfxLKZ7sIwSOiTxruIV
         mWUwvkz5wAtm4OdDKpxvLMCsxvdrnQzxNRJSCnPThyRfN3YsgYoprFdakDzgr6ehCL5v
         YtGcCqyvwebl8LWuU6JHDV2FaDWWbLQaWN3JQpwUCI+6BA2NTQ72kZN/xFxz97zgewi3
         DJ/fL2Zcv+hsWuSgqQNYqpOoSrWblkN+yGnxbSk4DSBLuYjm5EM+ATkny15XfbjEpu63
         dbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZtjr/LOY6vXMETe8w0CQd2xz4RT6uJH8lgQPSz9Mf3BqjZbV4DJB0XhjImzmIQgA6m0JgBKuvMiCPuXcpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyErpo9KWrAzgZc0l2rTGF7py+NkGtqmwdClsJt75+c2SwFIUPm
	ypLod0sSoZCWqX+AQLtWGuEK2XVqfEFoIlYdakiUHK2hskSJ4rM6LIJU8w==
X-Gm-Gg: ASbGncunLEfRWqPyeF5M8ZFDHiBDU5Gm/ztAhshXgCGM7hW+bXwiWiKRywJuINGJJis
	AKRKWyz812fjbMuiP6WTf4VJ4hvRaqdqXBA73K0od7JOA1QNKgmaVZNk8m4X/KYghbQfn09o6Oo
	wWI4ef6fJ2S6F7C3gXD4jFwworNBD0RRQ1ouTQfUIvaYnGhO0tSpPrKWSmaensYa3rhrfpoB8u6
	x3+L5/NMQ+HMWtLtNY0luVKhfc73V9kvcT5v0RxApBIJZoUV4vdd4xpVX5JDtBtNKMk2wdb+wyZ
	tXtp/7o4dbw1/2zdQ59nUTmFizo18yF7KWyRNRAcui69VRalVg==
X-Google-Smtp-Source: AGHT+IHaSW6i1rmu0a2yTkCqO5N4g+1xZADu2RfP+yFf3cjhjMj8bocqk5z0PfXGcsFm0Un5ik+6fQ==
X-Received: by 2002:a17:907:60d0:b0:acb:8a27:2727 with SMTP id a640c23a62f3a-acec4cee50amr351373166b.33.1745926712574;
        Tue, 29 Apr 2025 04:38:32 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e699esm769593666b.39.2025.04.29.04.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 04:38:32 -0700 (PDT)
Message-ID: <49bce002-77a9-4f12-9988-98a5e22141e2@gmail.com>
Date: Tue, 29 Apr 2025 14:38:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw88: Fix RX aggregation settings for
 RTL8723DS
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
 <0e9badc047ee4bbcb4256a0bcfd1c611@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <0e9badc047ee4bbcb4256a0bcfd1c611@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2025 04:03, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Use the same RX aggregation size and timeout used by the out-of-tree
>> RTL8723DS driver. Also set mystery bit 31 of REG_RXDMA_AGG_PG_TH. This
>> improves the RX speed from ~44 Mbps to ~67 Mbps.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/sdio.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
>> index c57f683d9af8..6f63fd5db665 100644
>> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
>> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>> @@ -677,12 +677,20 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
>>  {
>>         u8 size, timeout;
>>
>> -       if (rtw_chip_wcpu_11n(rtwdev)) {
> 
> Originally this only affects 11n chips, but now it affects all chips by
> default case. Is that in your expectation? 
> 

I think it only changes the behaviour for RTL8723D, RTL8821A, and
RTL8812A. These last two don't have SDIO drivers in rtw88, but I can
add them to the switch so they get the same size and timeout as
before.

> And have you tested chips other than RTL8723DS you mentioned in commit
> message. If so, please add them to commit message. 
> 

I only tested RTL8723DS. I don't have others.

>> +       switch (rtwdev->chip->id) {
>> +       case RTW_CHIP_TYPE_8703B:
>>                 size = 0x6;
>>                 timeout = 0x6;
>> -       } else {
>> +               break;
>> +       case RTW_CHIP_TYPE_8723D:
>> +               size = 0xa;
>> +               timeout = 0x3;
>> +               rtw_write8_set(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
>> +               break;
>> +       default:
>>                 size = 0xff;
>>                 timeout = 0x1;
>> +               break;
>>         }
>>
>>         /* Make the firmware honor the size limit configured below */
>> --
>> 2.49.0
> 


