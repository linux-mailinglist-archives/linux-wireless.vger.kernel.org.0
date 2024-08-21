Return-Path: <linux-wireless+bounces-11739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EA959A67
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AF9281B75
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205F1CC8BF;
	Wed, 21 Aug 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfxFLps9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCB1CCEC3
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238806; cv=none; b=KqKVyG+DAGlIQAjU9V1N/pjppPyOUOKDi8DRi6KvTz1NkVOjrfcWMuFJmV/GNXD9ThJMF39271nTYDLdnxGFwf4USDKJB/QBjwFq2GXN+4RG4yJGCo8LDSiKl2pUIuLVF3q8a9LI2t/rH9y65oEkbnT49SmWFotq4lKtHNaE+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238806; c=relaxed/simple;
	bh=03rrp94btuiPKWG0/E+KNGEZF7nZyYDuHb32ok6+sdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4bCUX4vUoj2T6OcVNC7BhifA3oBxhVBSo5bNDc4guC1mC+exaytTlWAvFSKYkM4Yql4uzW1+F8ZZKbDASr4h/A4ygmAeocuxseWJQMqS9YJp4OAm+lfwhkHW/AnZWHyJfGGablY7CijoyAxTnjSsrwoE7MRHqyYJa1VLU1xSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfxFLps9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso541763566b.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238802; x=1724843602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laLQ01fVVa5NKVN44D62AoURNz2vvYO19bm5UpRhVrk=;
        b=RfxFLps9jQqWiOLsSuU5yCe84ZEOx1S5W6FbZYS+t6NoI1WU2RXG6MsMytXOAIGBFX
         lpOuRfihLJItEcc5+//vpkiD5KKXKhLkvvwWPlJxtklNK8ob4sjME+KiLOPWWpUmci5Y
         gTW1VYefmusHS6Sz+uVecuastBWyeNLVHAsSnVJxgkB3BU50cbR1hyWNQkcrNZeWfx7w
         pJajB9B3oYGP/yqs5HN6nVYbujOUEE8rZvtIgdeQohPuGdEbTQ4ii9Cg8HZoQ6uho9ZJ
         kLn/EOCMFqgjuhDbtqupjXu6yYMI8j2MVb88MoTI29RjsNGXL2LSGONbgZiOJIOdeM6/
         EvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238802; x=1724843602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laLQ01fVVa5NKVN44D62AoURNz2vvYO19bm5UpRhVrk=;
        b=U0yg6UZc+fKvg8ljuDkWHghbfGSe7Kw1nFyAmq2uPJZJIs+gEzZgUq34YDCTyh7xGP
         uD0/3yUXs6+kWiK5vjhpGpBfFwMmzuvusFBvWeslZ7rF6dikLdmw727+Wr+CR139nXy6
         8DviSnUabBQ/OZ2G4zjpvHGCTwGkW68jcMlIJgaGoLC5IfP6+Izbny9Y7jQNATj4qaKy
         CVJNBHvJ4HYVgDlN1XeG7lUevOws5LcGwZyqgom3KrACoaLvqVptU288wcuPnb7mbNuN
         y9aZ81hCUBiVtfoOHesZ2/EF+YVZdfJfCtkjCMUYIFE6fMhjPdG4wo3KykJzUzXI8W+W
         Ivlw==
X-Forwarded-Encrypted: i=1; AJvYcCXSYBdkqrSIvLwVWY1CCnOY7YTemiPb70C+vwtfd4HFrgXl4G1ZIiUSmimC0HpYSJXvV5kIJhadGP3a8B6PUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+Y7ul+iGKh+q9Z8t/sPCRhIWabV6kgnoOZhMhy+c5ZhVehin
	pufL/0Fh7MGi3RgDUhcMv+GL1l+Yy8Pcq3nsr59ufdcHt/9nBOOAjcTV4g==
X-Google-Smtp-Source: AGHT+IFx3hzBRseHFgp68tCXuYSX1+vR9OOJA48PmJU+YDj/2stWKfD+KUfN00D2U7/20ACI5DxHiw==
X-Received: by 2002:a17:907:9726:b0:a86:8169:f3d6 with SMTP id a640c23a62f3a-a86816a205cmr37960566b.49.1724238801868;
        Wed, 21 Aug 2024 04:13:21 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a866ade6321sm103387566b.184.2024.08.21.04.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:13:21 -0700 (PDT)
Message-ID: <73accc26-15ee-43d9-bad2-061c42b76e0e@gmail.com>
Date: Wed, 21 Aug 2024 14:13:19 +0300
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
 <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
 <9456919959d94b548750f78a371f204e@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9456919959d94b548750f78a371f204e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 03:31, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 20/08/2024 04:10, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 15/08/2024 09:14, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>> The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
>>>>>> Avoid the "invalid ra report c2h length" error.
>>>>>>
>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
>>>>>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>>>>>>  7 files changed, 12 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> index 782f3776e0a0..ac53e3e30af0 100644
>>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> @@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
>>>>>>
>>>>>>         rate = GET_RA_REPORT_RATE(ra_data->payload);
>>>>>>         sgi = GET_RA_REPORT_SGI(ra_data->payload);
>>>>>> -       bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>>> +       if (si->rtwdev->chip->c2h_ra_report_size < 7)
>>>>>
>>>>> Explicitly specify '== 4' for the case of RTL8821AU and RTL8812AU.
>>>>>
>>>>>> +               bw = si->bw_mode;
>>>>>> +       else
>>>>>> +               bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>>>
>>>>>
>>>>>
>>>>
>>>> Would that make sense? I check for less than 7 because the size
>>>> has to be at least 7 in order to access payload[6] (GET_RA_REPORT_BW).
>>>
>>> As you did "WARN(length < rtwdev->chip->c2h_ra_report_size)", I assume you
>>> expect "< 7" cases is only for coming chips RTL8821AU and RTL8812AU.
>>>
>>> Maybe explicitly specifying chips ID would be easier to understand:
>>>         if (chip == RTL8821A || chip == RTL8812A)
>>>                bw = si->bw_mode;
>>>         else
>>>                bw = GET_RA_REPORT_BW(ra_data->payload);
>>>
>>> That's why I want "== 4". (but it seems implicitly not explicitly though.)
>>>
>>
>> I just checked, the RA report size of RTL8814AU is 6.
> 
> Could you also check if the report format is compatible?
> I mean definition of first 4 bytes are the same for all chips? and
> definition of first 6 bytes are the same for RTL8814AU and current
> exiting chips?
> 
> By the way, I think we should struct with w0, w1, ... fields instead.
>     struct rtw_ra_report {
>         __le32 w0;
>         __le32 w1;
>         __le32 w2;
>         __le32 w3;
>         __le32 w4;
>         __le32 w5;
>         __le32 w6;
>     } __packed;
> 
> Then, we can be easier to avoid accessing out of range. GET_RA_REPORT_BW()
> hides something, no help to read the code. 
> 

The report format looks compatible.

I'm not sure how a struct with __le32 members would help here.
I agree that the current macros hide things. We could access payload
directly. The variable names already make it clear what each byte is:

	mac_id = ra_data->payload[1];
	if (si->mac_id != mac_id)
		return;

	si->ra_report.txrate.flags = 0;

	rate = u8_get_bits(ra_data->payload[0], GENMASK(6, 0));
	sgi = u8_get_bits(ra_data->payload[0], BIT(7));
	if (si->rtwdev->chip->c2h_ra_report_size >= 7)
		bw = ra_data->payload[6];
	else
		bw = si->bw_mode;

