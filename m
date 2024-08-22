Return-Path: <linux-wireless+bounces-11806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EF95B7E7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8511F25AAD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D831CBE8F;
	Thu, 22 Aug 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFDwxqAg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C219DFA2
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335478; cv=none; b=RczrKrri1tN5yT8shGBXy8R6RB6xIU2pqyGPLbM1eCTaKkupiF3XBL8x7WsMKeD01WemD96MhqGGkePcxnR8LY4v7UWew3s//yW1bRUygryd0D9Xri/hyGOdchUT9OuIpqtGzqb82eR8Cp/ApMT78SFC5Pk1YRvd7o44ippROqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335478; c=relaxed/simple;
	bh=K2gGs90LarNdjFRhV9NhY9BSL6T+ubLd1wAMY71+6cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APB0rGGLoHa+id3HJBpmq6JyXSa7qBhg8zkKgJFmXkl1LjsxyY7huVpF5r98QfGEhBpH8gP9/NNhLQA+G1dtv2JPItk6ZEF9pnAKWuYm9+YE6+QvwaOcciUA1uMhkVtLBG4PtVHA7Hoh6P4hG56enr6iQun8/C/NEWZg/qQA8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFDwxqAg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so153246266b.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724335475; x=1724940275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8Y+3czbKMOWg3UabiJ2zTPdcYm0g94LyEO4gwRhz5Y=;
        b=UFDwxqAgZv3agLxh7ixUZr6GMq7Hs1EyJcrJ/P6Xuyg6d4RhdAXtRxB9arevIOgBqq
         I7u9rureUNLT+vSQD8VuHXVrL6PvphTMBtW4jY5+3MNYmjkT1FfU8qLkjhZwiFO3Ki2U
         cfPkyrMsh8sl3bASFKhxqaxdh3yooNfld1G32mPWPww1rLU3oxuNDlGHR4iJsrb+qC/H
         R8qCK/A6Jp8B1JHRWRQns75M8TkNmLt5uAgf7oiRCvnmXwHOKiYZBwWtUB0JC0A77Mpe
         4LC+oXaV6pP86+EdU67rnlQS8wElzgfn/SPOSU3e6ZRZz5pxoVvte1mAsHOKsjQHi9c3
         T4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724335475; x=1724940275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Y+3czbKMOWg3UabiJ2zTPdcYm0g94LyEO4gwRhz5Y=;
        b=pPbFqg+RrLCGS+wbn41dV6wNMb6QEGzydNPBBZcglU90e6xmLjLx5ZpfDmEMl4em6e
         0mNVQ7dZwjL5fV+9K2lxdS70USKRMYWaqucSF7qaXChVPGOAds1jRy7SDYeONtBTj9V1
         5vQKHRlnydf1xR/P2Aia5OKF8eKIc1yH0JyfrJy8WVjKrt3S5rH0A/pvq7k+g0LqjEhI
         JSzwmWIQoTUTWCcN5LCrnIAgWStveQagiYNHB7zMBWWrFyFPykAQYcVSNRYdp3qHxJei
         YxoZFtQ4LqfZEpYcUjYXBjQYSAM4cBGB+oQOpxocQhgj907I9Iq2mWmCBk977IWHr7/z
         x3OQ==
X-Gm-Message-State: AOJu0YwWziC0M/ZnNoHMli7PvYC61NGIY5yb6iTRrKfRF5Fwd2MIRXkx
	Kmjl1QnOCIHT0j+E2TNf+mHS0AvizLQ7ROvtEfarRdDP6Ch2qEJ6+We6QQ==
X-Google-Smtp-Source: AGHT+IGl9YceM+7in7FlYCaLUEAF9bTY9+xSzulIHTJCXLof7o3Iq/jo/F1NT/qm3YHliyHhlleIIA==
X-Received: by 2002:a17:907:1b0e:b0:a86:6a9a:d719 with SMTP id a640c23a62f3a-a868a91f0e0mr325224266b.29.1724335474209;
        Thu, 22 Aug 2024 07:04:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2200f3sm125089766b.45.2024.08.22.07.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 07:04:33 -0700 (PDT)
Message-ID: <2df8a217-b65b-473e-b69b-1b99c597a3f0@gmail.com>
Date: Thu, 22 Aug 2024 17:04:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
To: Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
 <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
 <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
 <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
 <9456919959d94b548750f78a371f204e@realtek.com>
 <73accc26-15ee-43d9-bad2-061c42b76e0e@gmail.com>
 <423f1f602b52464499c38459bd19cc84@realtek.com> <875xrtgi2f.fsf@kernel.org>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <875xrtgi2f.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 09:58, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>>> On 21/08/2024 03:31, Ping-Ke Shih wrote:
>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>> On 20/08/2024 04:10, Ping-Ke Shih wrote:
>>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>> On 15/08/2024 09:14, Ping-Ke Shih wrote:
>>>>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>>>> The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
>>>>>>>>> Avoid the "invalid ra report c2h length" error.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>>>>>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>>>>>>>>>  7 files changed, 12 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>>> index 782f3776e0a0..ac53e3e30af0 100644
>>>>>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>>>> @@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
>>>>>>>>>
>>>>>>>>>         rate = GET_RA_REPORT_RATE(ra_data->payload);
>>>>>>>>>         sgi = GET_RA_REPORT_SGI(ra_data->payload);
>>>>>>>>> -       bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>>>>>> +       if (si->rtwdev->chip->c2h_ra_report_size < 7)
>>>>>>>>
>>>>>>>> Explicitly specify '== 4' for the case of RTL8821AU and RTL8812AU.
>>>>>>>>
>>>>>>>>> +               bw = si->bw_mode;
>>>>>>>>> +       else
>>>>>>>>> +               bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Would that make sense? I check for less than 7 because the size
>>>>>>> has to be at least 7 in order to access payload[6] (GET_RA_REPORT_BW).
>>>>>>
>>>>>> As you did "WARN(length < rtwdev->chip->c2h_ra_report_size)", I assume you
>>>>>> expect "< 7" cases is only for coming chips RTL8821AU and RTL8812AU.
>>>>>>
>>>>>> Maybe explicitly specifying chips ID would be easier to understand:
>>>>>>         if (chip == RTL8821A || chip == RTL8812A)
>>>>>>                bw = si->bw_mode;
>>>>>>         else
>>>>>>                bw = GET_RA_REPORT_BW(ra_data->payload);
>>>>>>
>>>>>> That's why I want "== 4". (but it seems implicitly not explicitly though.)
>>>>>>
>>>>>
>>>>> I just checked, the RA report size of RTL8814AU is 6.
>>>>
>>>> Could you also check if the report format is compatible?
>>>> I mean definition of first 4 bytes are the same for all chips? and
>>>> definition of first 6 bytes are the same for RTL8814AU and current
>>>> exiting chips?
>>>>
>>>> By the way, I think we should struct with w0, w1, ... fields instead.
>>>>     struct rtw_ra_report {
>>>>         __le32 w0;
>>>>         __le32 w1;
>>>>         __le32 w2;
>>>>         __le32 w3;
>>>>         __le32 w4;
>>>>         __le32 w5;
>>>>         __le32 w6;
>>>>     } __packed;
>>>>
>>>> Then, we can be easier to avoid accessing out of range. GET_RA_REPORT_BW()
>>>> hides something, no help to read the code.
>>>>
>>>
>>> The report format looks compatible.
>>>
>>> I'm not sure how a struct with __le32 members would help here.
>>> I agree that the current macros hide things. We could access payload
>>> directly. The variable names already make it clear what each byte is:
>>>
>>>         mac_id = ra_data->payload[1];
>>>         if (si->mac_id != mac_id)
>>>                 return;
>>>
>>>         si->ra_report.txrate.flags = 0;
>>>
>>>         rate = u8_get_bits(ra_data->payload[0], GENMASK(6, 0));
>>>         sgi = u8_get_bits(ra_data->payload[0], BIT(7));
>>>         if (si->rtwdev->chip->c2h_ra_report_size >= 7)
>>>                 bw = ra_data->payload[6];
>>>         else
>>>                 bw = si->bw_mode;
>>
>> Yes, this is also clear to me to avoid accessing out of range. 
>> Another advantage of a struct is to explicitly tell us the total size of a
>> C2H event.
> 
> Yeah, please avoid that payload[6] stuff for parsing firmware commands
> and events. It just makes the code harder to read and more fragile.
> 

Okay, I will use a struct. This is similar to the solution
already accepted in rtl8xxxu:

struct rtw_c2h_ra_rpt {
	u8 rate_sgi;
	u8 mac_id;
	u8 byte2;
	u8 status;
	u8 byte4;
	u8 ra_ratio;
	u8 bw;
	u8 txcls_rate;
} __packed;

#define RTW_C2H_RA_RPT_RATE	GENMASK(6, 0)
#define RTW_C2H_RA_RPT_SGI	BIT(7)


	mac_id = ra_rpt->mac_id;
	if (si->mac_id != mac_id)
		return;

	si->ra_report.txrate.flags = 0;

	rate = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_RATE);
	sgi = u8_get_bits(ra_rpt->rate_sgi, RTW_C2H_RA_RPT_SGI);
	if (ra_data->length >= offsetofend(typeof(*ra_rpt), bw))
		bw = ra_rpt->bw;
	else
		bw = si->bw_mode;


