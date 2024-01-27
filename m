Return-Path: <linux-wireless+bounces-2595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48383EB42
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 06:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EF281A5D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BA134C3;
	Sat, 27 Jan 2024 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqhK42SA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF87F
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332773; cv=none; b=QfTJQnkYbpr+jjBh4a2Uw668jGNE3nsj2ByNb/MET4BrpMj4jTu3fdondMDlAftsXSot6Yu9OUwZnDBa6jD71RfxcrcQGSJKvxNQPjpBKAM20PxhYibVJU5RITJ1nwfioCuK76huYqT7YvCjWm8LYB3NzW91azKBGmQMRWf/IrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332773; c=relaxed/simple;
	bh=UUm52DDs1DdO1GYqGNEYQ/2MhKLs1aaBpZYltmJR5oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoDCbS8iJsQyEWjjrGBVb5qhiIapRzScKu590navOFAKyvbhp5zdikKS9fMNLgP7VWJ95rozq6BOaz1v10kvfU284tEOtjilt++23uIm+Ar/xXtFedmqOgafe8z0692QKG4Y57jNWipSe42PO8wVxGWaj0A/dGqnbcSG6KL47LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqhK42SA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so731926a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 21:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706332771; x=1706937571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwPUAl6/WE0Iz5wtvJeDFbKAkv1tr9cB03w9FhW5zw=;
        b=eqhK42SA3VpTyh8PeMHqv7QDB9m2WpofIYwe14eh9itpbYLeDvJEm/xsOaaGJp/F1d
         LCOvL9hG7ZF0hO7nXUcqgD300q61qMIwwjhjR62IBNxup5lZ5t/o6CRx1J+cHHFVUWJm
         Iepw3lA97sTxcoK+FBpr7gKDDClLXNWKR169YbmMrwrCkCyW0QbMrAsv+gwTMzQYoKeX
         NzNK7HzyirIbXdrQvJwn1oXEGOXllnuPjSOCCcKaDnlJPT5wE84zZ0hh6MiaJJQIAjEm
         rxALKrwgGG9VL9nsRW/7sXNm8TyPLwoJlDic3KYXcYC4GCWl2FzNeZ7HRiRyQiDZUso4
         hlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706332771; x=1706937571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwPUAl6/WE0Iz5wtvJeDFbKAkv1tr9cB03w9FhW5zw=;
        b=BmWkDzzknqvIjzsBMyyXPPee8D+qLCYKSNM+3bRSRDqROyFtpzqpieRJoMMGv0Xlm8
         7pF1dYkbcGzbJeU2agImRwSpawQL3WKPSJYC0HLK5Dxi/Yh8TLH/xwzmXyM+wrqy4KXI
         ik5FySYvnh4OxWrp9Ult2oXDUXS43GsxLeIn0I6dYB2wGTvGT3qcb2ymhr3h2XYdfTS/
         57uqXnkD9wIDTCcyzp0QKXgeia+ih+XjoUAwYK5qHaWFCmDeFkazKMdmz04L3o0Oc9kH
         Okm72a8+9ftwwrN7YKqYimXc36b6piX4jLkMQGIPZ4jNU/bLUPwhb0Gyxzw7g9+R6GCa
         fsVw==
X-Gm-Message-State: AOJu0YyFskuoEXPVcT1fBRw9oREWTk3d312Pwb8gJB9uMSVLzyp2FiYP
	O+Z4YLKEmAMwPa/S2ZRu5GFF+57MQw5I8bkap/MY1ajJqO+qvcuG
X-Google-Smtp-Source: AGHT+IGoQk/AVJgLYnRpz/t6BgHCALxC1mQhdVMBlv+sN8qu9oUMcPZo2z7delqcT0PguXyU5JsdNg==
X-Received: by 2002:a62:f252:0:b0:6dd:8a4c:bfb2 with SMTP id y18-20020a62f252000000b006dd8a4cbfb2mr506242pfl.60.1706332771321;
        Fri, 26 Jan 2024 21:19:31 -0800 (PST)
Received: from ?IPV6:2601:204:df00:9cd0:106a:b3d9:2374:e3a5? ([2601:204:df00:9cd0:106a:b3d9:2374:e3a5])
        by smtp.gmail.com with ESMTPSA id a10-20020a63d40a000000b005bd980cca56sm1742316pgh.29.2024.01.26.21.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 21:19:30 -0800 (PST)
Message-ID: <fa71e57c-e50f-4538-afa8-9779f3aebde0@gmail.com>
Date: Fri, 26 Jan 2024 21:19:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with
 flexible-array member
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, aspriel@gmail.com,
 franky.lin@broadcom.com, kvalo@kernel.org, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20230803052238.12147-1-rauji.raut@gmail.com>
 <20230803052238.12147-2-rauji.raut@gmail.com>
 <f739cc15-dade-4f69-a17a-30242026c099@broadcom.com>
 <202401181217.1D75C32E@keescook>
 <CAKXUXMzjGbO0U0pko1rg9=q3j6xS5rbzmLnMPeT3g9fMhBr0hw@mail.gmail.com>
From: Atul Raut <rauji.raut@gmail.com>
In-Reply-To: <CAKXUXMzjGbO0U0pko1rg9=q3j6xS5rbzmLnMPeT3g9fMhBr0hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank You Kees,

Hello Lukas, Arend & Kalle,

Sorry for not getting back to you sooner, am out of county &

hence unable to push the patch right away.

Will share once back, apologize for inconvenience caused.

-Atul


On 1/19/24 05:00, Lukas Bulwahn wrote:
> On Thu, Jan 18, 2024 at 9:20 PM Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Jan 18, 2024 at 02:53:28PM +0100, Arend van Spriel wrote:
>>> + Kees
>>>
>>> On 8/3/2023 7:22 AM, Atul Raut wrote:
>>>> One-element arrays are obsolete, and flexible
>>>> array members have taken their place. So, in
>>>> struct cca_stats_n_flags, replace the one-element
>>>> array with a flexible-array member.
>>>>
>>>> This fixes warnings such as:
>>>> ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>>> I think this correct, but maybe Kees can give definitive answer here.
>>>
>>>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>>>> ---
>>>>    drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> index de8a2e27f49c..fff32e54833d 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> @@ -116,7 +116,7 @@ struct brcmf_dump_survey {
>>>>    struct cca_stats_n_flags {
>>>>      u32 msrmnt_time; /* Time for Measurement (msec) */
>>>>      u32 msrmnt_done; /* flag set when measurement complete */
>>>> -   char buf[1];
>>>> +   char buf[];
>>>>    };
>>>>    struct cca_msrmnt_query {
>> Normally a [1] -> [] conversion needs some details in the commit log
>> about why this is safe (since it runs the risk of changing sizeof(struct
>> cca_stats_n_flags). In this case, there's only a single user of the
>> struct, and nothing about its use depends on its size:
>>
>> #define BRCMF_DCMD_MEDLEN       1536
>> ...
>>          struct cca_stats_n_flags *results;
>>          char *buf;
>>          ...
>>          buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
>>          ...
>>          results = (struct cca_stats_n_flags *)(buf);
>>          ...
>>                  brcmf_parse_dump_obss(results->buf, survey);
>>
>> So, the allocation size is big enough for the struct, and nothing
>> depends on the struct size.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
> As the linux-kernel-mentees mailing list is in CC, I assume that Atul
> is a linux-kernel mentee. In that case, it is certainly reasonable and
> at least of educational value for Atul to take Kees' explanation and
> add this to the patch's commit message in his own words. Then, with
> that, submit a PATCH v3.
>
>
> Lukas

