Return-Path: <linux-wireless+bounces-4213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED986B7CC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9A51C21FA2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BB40870;
	Wed, 28 Feb 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agcNssyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC81EA6E
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146927; cv=none; b=TVqCqrli84rZooOh9aUkWRqkAhtu0XfecJ7krVCpeVU3U+lv1HEGngZn9uYUG4RV4uuUVEXTbUvVzhpFffcBe1l2r87jEkRh17sc2f9DxXfMaeXJPGNdT1MDRKW5CMG7m/ufR4pXHrNYYFzp/wl88E9fLdnfvhkRXIZD0f5TutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146927; c=relaxed/simple;
	bh=9g4y2IVfAQrUN0HTvRJRw710VakyA5XoR0fWI3iw/8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DO0Wod5aNrlip/Y3v50Ho51XTFDphkxnMbA7QSs0x7QPxQrcai/WNL18XWiwNb/Sz5R23ekVeVkN2yfYJgY4w2n15c+3iZCjqsawpmJ4L75BqGoPpxhP4Ewlggl8NBa6QkKuYrU2WjneSOfksALdQDBq2adKcZiSsHmQTsn1rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agcNssyU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19e8d4a9eso9126b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709146924; x=1709751724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5O0ZfWuMG4BsPkn1lukAcwRckYsDgg1ZfQ+/p93tbGg=;
        b=agcNssyU7lSfemN/KHrgepoCt75iqdg6jl2/hSdj5JwjQgsxFjBFbXiDfUSob5ktvr
         0gMSE1QFjXC6IpykdAxnQXBA1vO44InA9ez4IWJk823BOwt9T9aZnPHN4smJqI/oUBot
         4auZUgiSdkSwMVYGB5celpH5hojJ1K6QQQsf2C0OVKpxSzlmiQPITnNEFKDKeBYPHE9G
         bujYm2WW4DlNzSNZZGLSpA2xSQdVuIBrr1QDIbtpCTKEZs1y2kmApsloPuqlFr38WWq6
         IKo5L2E5hw1qrRJu4brv3hT6ZHPvqNcRAI5+iHi1C/0SBK86lQzygkHc75OH78tANVKc
         WHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146924; x=1709751724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O0ZfWuMG4BsPkn1lukAcwRckYsDgg1ZfQ+/p93tbGg=;
        b=FBxjjHTnUD6v084xxgOKwGCri/Wz3GayQ9twYiZ+UzLKNjoDU/3A0rtlCwwL4NDKR3
         zCqsd0GkIxZVm+oRJVC2rb+VKLAA6YQzJFb38U/zbPcNhJIUWJiQQ0kQxWsOwqDcdGl/
         xdlwgTRrAuqUIUs89uapMPFagYg7o+Shnj1mI3ysBdksVBq8U0kX0TlnfoHWrrQILJX9
         Wvckv4BwVj3saHweE+kllURzfVBn/PwuKbIOuCNnZy106gUfpqXjJiUikE2ixJ6SwQhE
         U47AXVf/6KK+YSGJtb1/tilM034GBj80jSiyJ85juRi6Fdvn20v+Ni8uvmFqzAzFWJvx
         Bc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHbyynPO+RZdH42NES0r+he235vLWea2Wm3ZNEMF9jE30OJDxq10eGfIF40sp8wdoi8LGeL37SL0grhH9vx3mUIg2njYes/yWeuAXR7nU=
X-Gm-Message-State: AOJu0YzuLIJswWdF3/Ry7Yn8S5LdLQWceKRorJ6M3PV2hw7pFFWhYv+x
	gj+7mIVOrgioiWvEzlzP1QH+6tiDUSt8eWivaWhzoLy0AcDwDhb/
X-Google-Smtp-Source: AGHT+IGMy2jZFeRB9YV2mw7/Au2mHAMYq6fe0bNBS7Ugmv+rUBD5gfNtTVrtvoCPl71fCgDJFC2hig==
X-Received: by 2002:a05:6808:1998:b0:3c1:adab:989e with SMTP id bj24-20020a056808199800b003c1adab989emr6524924oib.37.1709146924060;
        Wed, 28 Feb 2024 11:02:04 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w5-20020a056808018500b003c170120a9bsm1960oic.26.2024.02.28.11.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:02:03 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <17ff48b2-1f78-4eaf-b4ad-9dfeb5ea8620@lwfinger.net>
Date: Wed, 28 Feb 2024 13:02:02 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
Content-Language: en-US
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
 <b908b9a7-e1fd-47ba-b573-ac11b334101b@lwfinger.net>
 <c68d2d91-fb81-41e2-b8a2-0eb63783311b@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c68d2d91-fb81-41e2-b8a2-0eb63783311b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/24 03:57, Bitterblue Smith wrote:
> On 28/02/2024 00:46, Larry Finger wrote:
>> On 2/27/24 06:20, Bitterblue Smith wrote:
>>> Make dm_info->total_fa_cnt the sum of cck_fa_cnt and ofdm_fa_cnt,
>>> not just ofdm_fa_cnt.
>>>
>>> Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> ---
>>>    drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>> index 429bb420b056..fe5d8e188350 100644
>>> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>>> @@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
>>>          dm_info->cck_fa_cnt = cck_fa_cnt;
>>>        dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
>>> +    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>>        if (cck_enable)
>>>            dm_info->total_fa_cnt += cck_fa_cnt;
>>> -    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>>          crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
>>>        dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
>>
>> I applied these 4 patches to my rtw88 GitHub repo, and loaded rtw_core with the disable_lps_deep=y option. The option reduced the number of "firmware failed to leave lps state" messages, but did not eliminate all of them. The messages I received are as follows:
>>
>> [ 2063.847153] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>> [ 2450.120216] rtw_8821cu 3-6:1.0: timed out to flush queue 2
> 
> [...]
> 
>> [ 4323.823755] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>> [ 4453.846759] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>> [ 4455.822861] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
>>
>> My system has now been up for about 4470 sec. Obviously these messages come in a burst.
>>
>> Larry
>>
> 
> I have never seen these. I guess you don't get these messages
> without the patches? Can you see which patch causes this, please?

Bitterblue,

These warnings are not new, but probably only happen for some models of 8821CU.

When I get time, I will try to see if I can quiet them,

Larry



