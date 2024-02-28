Return-Path: <linux-wireless+bounces-4216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB186BA45
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 22:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83141C202ED
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A57005A;
	Wed, 28 Feb 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzTWD5RH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8186244
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157288; cv=none; b=IJLAo0QAwkFOdvwPTP3Kyc3tWUL6WmMzjjWvyZL/a6dB6C/OADtzPEaiV5m3PBRKAfOBvbKJ5hW7cuQSU3qFA8h3MY4gfCsg6yolOicgyz0RfQYUsUO2TNezhQUpH11XIlqi1W5R+AqOCmlOVL/eaX0Hd29GFY9oCq2uxs01hmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157288; c=relaxed/simple;
	bh=bkuXhYyiexqO7S5cX/nD6OtsrxErEsgfTDFTsXPfc7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5q5oLqMhX8ApEaK+8XqVa4IgUxeK9RyLYfL7iP4PYPrApPlBFjsRjIkNIXHyr7gpR8Cy61A6F+YJlZPztGWWqaPyy8Clz8/E+nn8nnSA3vnYelbf0485WGXuDAnEDz/i4FrE0oUTJiA8cP7s3GOzfEPj+lraxNvfAM1ljAbOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzTWD5RH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d26da3e15so922502f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709157285; x=1709762085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBENQzlbIGegMGnJTVL+jxmJ0nxfnD0A49KbOdgaRBs=;
        b=lzTWD5RH+nFnFQP5fE88XaJrZ7n9m4uF4pg1y/S5l7lljTNO+j9MoZb1UgylvbtQYL
         jqm9LPsm3MT2HPxNGIAUAjyevJwABmZVAnXODE9FHyl4tpI2LmMTY/kOaz9v0OderNmJ
         XqXsCQX/6InT7vVsj6BPtTYXbCXRibUG82yziXjGvHOcNMeMFA6gbf1ffxfktzWSf2mt
         VS5Khe8+DsFQWHjpeq0tu3GO2FdchyN6jKAiFjxqDRy0jT/Hf7veUDymtLu4LYjCLAzj
         NWkwHXRoZPPKTXUZHdlPmR2yGrMaa5vkYHtkiypIkzIejAEpR+tEWgTmoLk/kjc4lUyU
         1AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157285; x=1709762085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBENQzlbIGegMGnJTVL+jxmJ0nxfnD0A49KbOdgaRBs=;
        b=RbZNSOYRS6Gdx6+/6P/EIz+7L0ciQfffNcIyypb8VfabVvggaLVs96inodEc02FDau
         gI0etMdtcp5pewKlnHuXK6EBjQwAJcrRok7Afxap7CoSiQqD8bxAQ0Vtc7tvsFJXTYQ7
         znCK0BdYX3CMRi2D0PaZtlJoFaXpXTU6QiJpWpAHBfWltd/rV2kg713tt+oC38X54TmU
         gPW7XY0ixKM4PZcnbUaPV6tGI6g6tlWyQdihx/qW0LcMeqHfm2n6IVNX/SndYyTf2Sco
         ZrqTFhIptmn/hsA/oSQhaacRCLlJOJ53aEoJjsAWnmRPAIEFg6Zb2B2hhj8NAf3862cp
         JYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVeb9vcszttsgW6xvsvlItbROQ8StBtUVmy19XTcMXt2KqnN5Z7LspDGKbqKn/HLeoF3si6cDFI+vffF+R59t8OzFJPPnlWelqibYg6d4Y=
X-Gm-Message-State: AOJu0YwsEvzZLd85jQ4uqoul8Cdkk1+Z5YBbr83UNqrNs4m7FT0TiJof
	vcF/kuhSMZqscSIR6Arlqp/WT4mSkz2P14B+GKJfkSM5TkXd9evPba6TrnR9
X-Google-Smtp-Source: AGHT+IEJ9Y8lPd8B+hCUmzl8b/mK/oyWL5Kd5bExWPGcZASx9tRIogc1UaujttPfnT94E60QAVkAZw==
X-Received: by 2002:adf:959a:0:b0:33d:9d76:2f82 with SMTP id p26-20020adf959a000000b0033d9d762f82mr6183wrp.26.1709157284960;
        Wed, 28 Feb 2024 13:54:44 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0033d6c928a95sm15637957wrq.63.2024.02.28.13.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:54:44 -0800 (PST)
Message-ID: <2053a900-19de-4a7e-a460-f1e8a6a0b36b@gmail.com>
Date: Wed, 28 Feb 2024 23:54:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
Content-Language: en-US
To: Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
 <b908b9a7-e1fd-47ba-b573-ac11b334101b@lwfinger.net>
 <c68d2d91-fb81-41e2-b8a2-0eb63783311b@gmail.com>
 <17ff48b2-1f78-4eaf-b4ad-9dfeb5ea8620@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <17ff48b2-1f78-4eaf-b4ad-9dfeb5ea8620@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 21:02, Larry Finger wrote:
> On 2/28/24 03:57, Bitterblue Smith wrote:
>> On 28/02/2024 00:46, Larry Finger wrote:
>>> On 2/27/24 06:20, Bitterblue Smith wrote:
>>>> Make dm_info->total_fa_cnt the sum of cck_fa_cnt and ofdm_fa_cnt,
>>>> not just ofdm_fa_cnt.
>>>>
>>>> Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>    drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>>> index 429bb420b056..fe5d8e188350 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>>> @@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
>>>>          dm_info->cck_fa_cnt = cck_fa_cnt;
>>>>        dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
>>>> +    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>>>        if (cck_enable)
>>>>            dm_info->total_fa_cnt += cck_fa_cnt;
>>>> -    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>>>          crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
>>>>        dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
>>>
>>> I applied these 4 patches to my rtw88 GitHub repo, and loaded rtw_core with the disable_lps_deep=y option. The option reduced the number of "firmware failed to leave lps state" messages, but did not eliminate all of them. The messages I received are as follows:
>>>
>>> [ 2063.847153] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>>> [ 2450.120216] rtw_8821cu 3-6:1.0: timed out to flush queue 2
>>
>> [...]
>>
>>> [ 4323.823755] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>>> [ 4453.846759] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>>> [ 4455.822861] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>>>
>>> My system has now been up for about 4470 sec. Obviously these messages come in a burst.
>>>
>>> Larry
>>>
>>
>> I have never seen these. I guess you don't get these messages
>> without the patches? Can you see which patch causes this, please?
> 
> Bitterblue,
> 
> These warnings are not new, but probably only happen for some models of 8821CU.
> 
> When I get time, I will try to see if I can quiet them,
> 
> Larry
> 
 
Oh, so they are not caused by my patches. That's a relief.

