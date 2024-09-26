Return-Path: <linux-wireless+bounces-13232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41C9877BA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 18:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A0A289D01
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEB15AD90;
	Thu, 26 Sep 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIAdrjxg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCC15ADA6
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368893; cv=none; b=RXchcKNFG1o4EdqFgrXgOWUqgZGB3F6kpbm/3ZtbvY1cS4hW2GIhetq/cU7MO8OzuH7QuFRYdITVS3VnnG7W5vks628TWD3fBdkVBTjEnVLJMmJsuUf39iY1l0beKN6bdGeMd/aC8jiEkBiqBSUjXb8xLLsoBYftjJp/yPwC8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368893; c=relaxed/simple;
	bh=SfgMOsmhlQgUIAK0yjqmjQztXAyJ0ohLPwKWJwFvIZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YGna/zXt3Lfmvf64jiO5enj7fOwyup/2nb4C7vlzLoj+KhEJmVeVb+kdUegZjGhirvHkfvA3nq/7kEe80GQJnNxjPqpJ5LHEUOHVsaR5lZkN8hxMkwFEfQo04qT01BsaYarcmhZR6bo5pTNHZxuZy647UjxeNlem2BzR7DOryT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIAdrjxg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so15234711fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727368890; x=1727973690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5tw+FGrHpX9EgigL+rusrC8bznYJ/sOjLMDfu51wqw=;
        b=QIAdrjxgUXR6KlWMgx4BdJ5WmOoyh7450UIyb0zG5qxGbqib5dlaGPhrY6JRgEZbR4
         Vi13HVb1xFDLp3UXLa+Q5CVkhiACzOM69l988lFCvjEVb2R5D0OJDouMKGT2XRWff4Bc
         UtV+sTPiJ0ixU5yl7ZbUooLdHRvpNMG9hcSX0eBpQee8Sv45gXLhgYsnF+gBgmVZNQX1
         E1IQ7Lp4solRWqKdkFuYSpuVRbot/XYiWB3e5VguAfC+64CJijtFULqzijpSQX0v9INx
         OAMzCqaU3DUO+lwhCmijr3Hhv2WS6a+GAXw3u6nBgnlUUEI+VOLcZnqW8KjHA3fTtlzN
         h5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368890; x=1727973690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5tw+FGrHpX9EgigL+rusrC8bznYJ/sOjLMDfu51wqw=;
        b=nLNzcPyGZgI6KfgP+9llwlxuAawZ6tF79nmQg73Veox5daut3nUFxPYsD0lxax9aUo
         IHAtWvKlo+sXyJGnmQa6QYU66XtB/TjTHnM372QG5NQgFeepx9XInzRrvbvJLrLtMPqF
         +JTYkczxhAKT3pQOt9VExhbiNZCFg9+TwjfeN7GS6TktHgMMZsOzaPKqM0FTqpWcnioY
         QgIyUjJHBjkBQsNcQ/UcJJCEj6UBGtbuv8OLO5lqK1y+0pH+CFZNzIWYytvubPrxZ6OT
         IJ95YaLPOnU0hlPcCoG8G9VKezFm4fVc0L1qJsg9n/+ul6oUHPK7/xp4yArNciFDGthc
         L1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW0y9SfAOZrlz4FSlr5V6dBrlqqYs7xYRVAr6vFsatth1oNdYuNUq9UE/SufADiHTkmn/a3UW+FboE6WLSMow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Wl6cU1hvLy/3+3d+Fp8pUd8M6q93p1z74fqEn4w4pTlRzg83
	sW4M5ztUxwxhL0aIk363ZlGsEdFGZSWCuHE+BPeKFWXqGhx6RsDLQcQafQ==
X-Google-Smtp-Source: AGHT+IFAjO+tIAzmCmq6DBKTx1LT9ToLQQ3gNi8GlI23JQ4NWbqTG49W5YP2bXH8PvIaOGjvieSl6A==
X-Received: by 2002:a05:651c:554:b0:2ef:296d:1dd5 with SMTP id 38308e7fff4ca-2f9d3dbbe01mr2567491fa.0.1727368889305;
        Thu, 26 Sep 2024 09:41:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882493acasm105743a12.83.2024.09.26.09.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:41:28 -0700 (PDT)
Message-ID: <7d94c3cb-cae4-4f5f-94bd-bfea287faeaa@gmail.com>
Date: Thu, 26 Sep 2024 19:41:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
 <73de8e7135554ae9a0f7968780644515@realtek.com>
 <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
 <9c991498a48043d0b0b06dc05356cbae@realtek.com>
 <d621b3ed-86f5-40d4-b826-79615a2def6e@gmail.com>
 <1e27a798215e4a5299f4ed27dca7413c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1e27a798215e4a5299f4ed27dca7413c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/2024 05:27, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 25/09/2024 04:25, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 23/09/2024 08:47, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>>>>>>> +
>>>>>>>>>>>> +const struct rtw_chip_info rtw8812a_hw_spec = {
>>>>>>>>>>>
>>>>>>>>>>> Is it possible moving 8812a to individual file?
>>>>>>>>>>> Since you have rtw8812au.c and rtw8821au.c.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think it is possible. But most of the code is common to both chips.
>>>>>>>>>> Only the IQ calibration could be moved.
>>>>>>>>>
>>>>>>>>> Yep, depend on how much IQK code echo chip has.
>>>>>>>>>
>>>>>>>>
>>>>>>>> The IQ calibration for RTL8812AU is about 700 lines.
>>>>>>>
>>>>>>> rtw8812au  -----> (a) rtw8812a
>>>>>>>                         |
>>>>>>>                         v
>>>>>>>                   (b) rtw8821a_common  (hard to give a name)
>>>>>>>                         ^
>>>>>>>                         |
>>>>>>> rtw8821au  -----> (c) rtw8821a
>>>>>>>
>>>>>>> Put all common code to (b). IQK code in (a) or (c).
>>>>>>>
>>>>>>> I feel you have thought above picture already. What are problems we will encounter?
>>>>>>> Many export symbols? If so, how about below?
>>>>>>>
>>>>>>> rtw8812au  -----> (1) rtw8812a
>>>>>>>     +---------+
>>>>>>>               +-> (2) rtw8821a_common  (hard to give a name)
>>>>>>>     +---------+
>>>>>>> rtw8821au  -----> (3) rtw8821a
>>>>>>>
>>>>>>> Put rtw8812a_hw_spec and rtw8821a_hw_spec in (2). Only IQK code in (1) and (3)
>>>>>>> respectively, and export IQK entry only. Does it work?
>>>>>>>
>>>>>>>
>>>>>> For the name of the common module, I was thinking rtw88_88xxa.ko.
>>>>>>
>>>>>> I wonder, what is the goal? To put the code in separate kernel
>>>>>> modules, or just separate files?
>>>>>
>>>>> I would like to reduce runtime memory. As I asked, how many IQK code are different
>>>>> from them? If you have separated and compiled them, can you share size by the
>>>>> output of 'size' command?
>>>>>
>>>>
>>>> I separated the IQK code into two files (still just one module).
>>>> size says:
>>>>
>>>>    text    data     bss     dec     hex filename
>>>>    7192      32       0    7224    1c38 rtw8821a-iqk.o
>>>>   12319      40       0   12359    3047 rtw8812a-iqk.o
>>>>
>>>> This is x86_64.
>>>>
>>>>>>
>>>>>> I think we can have rtw88xxa.c (common code), rtw8821a.c (IQK code,
>>>>>> rtw8821a_hw_spec, bluetooth stuff), and rtw8812a.c (IQK code,
>>>>>> rtw8812a_hw_spec, some efuse stuff, channel switching)... if these
>>>>>> three files compile into a single module, rtw88_88xxa.ko.
>>>>>>
>>>>>> If each file compiles into a module of its own, we have circular
>>>>>> dependencies: rtw8821a_hw_spec -> common code -> IQK code.
>>>>>> If *_hw_spec go in the common module, it still depends on both of
>>>>>> the other two modules, so what use is it?
>>>>>
>>>>> If we have dependency of common code -> IQK code, we can't save runtime
>>>>> memory, because common code reference to both IQK code. So I felt
>>>>> dependency of IQK code would be rtw8812au --> IQK code as above second
>>>>> diagram.
>>>>>
>>>>> But if the work is complicated and save not few runtime memory, we can
>>>>> use simple design as current did.
>>>>>
>>>>>
>>>>
>>>> The IQK code can be separated into different modules if I duplicate
>>>> rtw8821a_ops and rtw8821a_pwr_track, and rtw8821a_phy_pwrtrack takes
>>>> a pointer to the IQK function. Then your first diagram above can work.
>>>
>>> Not sure the "duplicate" you meant. If it only a struct, that would be fine.
>>> Not prefer duplicate of tables.
>>>
>>
>> Yes, it's a struct rtw_chip_ops.
>>
>>>>
>>>> The tables also take up a bit of space:
>>>>
>>>>   text    data     bss     dec     hex filename
>>>>   16832       0       0   16832    41c0 rtw8821a_table.o
>>>>   21552       0       0   21552    5430 rtw8812a_table.o
>>>
>>> Good point.
>>>
>>>>
>>>> I don't know how many kilobytes is enough to make it worth
>>>> creating two more modules.
>>>
>>> I think we can list all *.o related to rtw8821a/8812a, and check the
>>> percentage to make decisions. I mean if it occupies 50%, I will prefer
>>> to have separated module. But I don't have an exact number now.
>>>
>>
>>    text    data     bss     dec     hex filename
>>   12319      40       0   12359    3047 rtw8812a-iqk.o
>>   21552       0       0   21552    5430 rtw8812a_table.o
>>    7192      32       0    7224    1c38 rtw8821a-iqk.o
>>   16832       0       0   16832    41c0 rtw8821a_table.o
>>   29445     429       0   29874    74b2 rtw8821a.o
>> =========
>>   87340 total. So it's about 38% for 8812a and 27% for 8821a.
>> Maybe a bit more in the final version.
> 
> chip    separated(a)   single one(b)   increase rate(c)
> -----   ------------   -------------   ----------------
> 8812a   63,785         87,841          38%
> 8821a   53,930         87,841          63%
> 
> * increase rate (c) = (b - a) / a
> 
> Since increasing rate of 8821a is 63%, I feel separated case would be better. 
> 
> 

All right.

