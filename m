Return-Path: <linux-wireless+bounces-11714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A894C958FDC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 23:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31BBFB21135
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF845008;
	Tue, 20 Aug 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxbVCUkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7128FA
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190262; cv=none; b=FeFW+OBelQiqcBobHMkoHFW+sz7jQqZMlNfR41BsWk8IBSuiEvXFGMGhxLzwHwovpSK8T1Qj+8u5BFtX6WewsVFZPSPmfJ6IcLPikb2Y1DwomPDeykGao9vO4V1qia0vfzH9cJDy4XWwgxlHyGuJx4eG142sEgo6hkXNAjsfqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190262; c=relaxed/simple;
	bh=ZfDnJNdbjYY1MPAZDjjdwqhR98lkI3q4RihDEfYiATw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KfgWdR/JBNAu8GgtSCX3wIAEM+y64XQ3PzTQWLw1Wk9A0lwm046OEGlNqGaEq3mqXhUWvZs7dSASCEqG+PAqaUz4R4qWq8fB0japLwR75Gmx1BKgOx/Rp6Q/XBiyisTeofioQ6deg0QGfjv4e7iDNzPWL/delT5Kj2LDxqMia9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxbVCUkd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so3500704a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724190259; x=1724795059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctPp+aa27vNG+TjacFaAY1wjyjO+YrEk8WzcUMxQ8CU=;
        b=CxbVCUkdhR3VfHNfQY4Cetud/hUIu2BDYT419M6PCJeksASTglFYp5WjqJdJ24aos9
         NWOf4JxF4pAP50aOfudqep4fploTQPNFzQ51QsF0OD3oMPRT69fM3EnpPuiKS0mIWy1b
         5Dx/TdnGje52p02uJW+bHn0obzXm7J5kWr0Ob/cTrbh9lV1JljSmanAGockam8i2UjW1
         KY3azgALDmyfSF2hwsX3KoWBJVkzNZ3Ku6A2xXR14sEid5KxpdXCaD/XlUIGhxqNZ4i0
         zIZRBIwnBcgeLs1SquG4mONUvkBAvb6IhF97/DGE8EetmvY3JcnRq66WaTaM1hJUlEBX
         Bzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190259; x=1724795059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctPp+aa27vNG+TjacFaAY1wjyjO+YrEk8WzcUMxQ8CU=;
        b=w/hEVKiCDSRh9vi3N5Ne8wI5d/+Bmr3aHJt7o83tV8LaYgOVX+nRmKSsyUPFtk9oPE
         Oqz51L5gBSaZQfejMNjq6sVkxcliQXzn7AdvaKw6RU45o9vklHSgPBVOCKwHPqkQVsuK
         ZO4FzGEukw2RwRn0W32ukXzlhI4RzJ0RT2YwseZqIUaAoyKpucuHvHiW4MSYLniBF1Zg
         AKJfyv+kSdzN5LOKgpUItBW2gmnXipv7FimS3+nvQRAlHoztGmDwGEPraC3kTapzGmbA
         CqhEbVN9/hI/8zK20vaTBbXag32RB3atkiPbYmi3/tsAEoQO+1ZzUty9Wmc1wB+FXbMm
         r+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXIiV9A499OzipLwLsoRhcgJoSyU88X4/+MCoYHRzZg53dphKc2JQdw3kifb18VeFu33hA1qrbhF9m9BwlPSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5bNm48oXaNSy3uzDIavTDh+esQ0UDdA+c9glRxiJ/lpbgdzQ
	alaNEqWZnzNC0jRU2eTn3hvURT4Pi+U3F1a0KiaMOwlL8Eh7cRkA
X-Google-Smtp-Source: AGHT+IFyYqY5LQUDiHrQ16bmY23azf8PK0i4LlA3kl+qiO2Nw5DhPZfuT7GOd+bmdmYU8Q51znqQ4w==
X-Received: by 2002:a05:6402:280f:b0:5a1:cab1:fbd0 with SMTP id 4fb4d7f45d1cf-5bf1f0a4206mr221230a12.5.1724190258302;
        Tue, 20 Aug 2024 14:44:18 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081cf5sm7197685a12.90.2024.08.20.14.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:44:17 -0700 (PDT)
Message-ID: <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
Date: Wed, 21 Aug 2024 00:44:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
 <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
 <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 04:10, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 15/08/2024 09:14, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
>>>> Avoid the "invalid ra report c2h length" error.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
>>>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>>>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>>>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>>>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>>>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>>>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>>>>  7 files changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> index 782f3776e0a0..ac53e3e30af0 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> @@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
>>>>
>>>>         rate = GET_RA_REPORT_RATE(ra_data->payload);
>>>>         sgi = GET_RA_REPORT_SGI(ra_data->payload);
>>>> -       bw = GET_RA_REPORT_BW(ra_data->payload);
>>>> +       if (si->rtwdev->chip->c2h_ra_report_size < 7)
>>>
>>> Explicitly specify '== 4' for the case of RTL8821AU and RTL8812AU.
>>>
>>>> +               bw = si->bw_mode;
>>>> +       else
>>>> +               bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>
>>>
>>>
>>
>> Would that make sense? I check for less than 7 because the size
>> has to be at least 7 in order to access payload[6] (GET_RA_REPORT_BW).
> 
> As you did "WARN(length < rtwdev->chip->c2h_ra_report_size)", I assume you
> expect "< 7" cases is only for coming chips RTL8821AU and RTL8812AU.
> 
> Maybe explicitly specifying chips ID would be easier to understand:
>         if (chip == RTL8821A || chip == RTL8812A)
>                bw = si->bw_mode;
>         else
>                bw = GET_RA_REPORT_BW(ra_data->payload);
> 
> That's why I want "== 4". (but it seems implicitly not explicitly though.)
> 

I just checked, the RA report size of RTL8814AU is 6.

