Return-Path: <linux-wireless+bounces-6523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8A8A99AE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1B2836E0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039E15D5D6;
	Thu, 18 Apr 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsbExEHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADF15E5C9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442935; cv=none; b=jWHrbRqIPmfhatkWXJkUym+X47syE+yEO8IJq1NJL8Zy09BgDwi4ZKSle0fwa6QXJLAL5vFGJsZd5GK1CPnUqgkMd7sxhC9E2CkPcaQWL6YC0jfH2cmGDTEwofx1jPrD14zot5U6j6QHsxERbS6hpggB7s+jd+MFyymux5ODONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442935; c=relaxed/simple;
	bh=QtXXT/QFYde8XdVhs7nc/lo1biN57+1P5AAI9Ec98MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibJJ2fSZJbNPoixYe6UhI2nuA9K5gtdCxZjtVuXwNbCYwxxjZk8xD1fH/eMmkFQbc8Wa4gWUoQLvg+Om6P2fjPyZgINY5e6W/zQsnbXzzyhlZVcwZHFZKkKTOKL8wjBdQE55BbAu3IWRL2/0g84fZhRT7RauANEKvnSZbewnqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsbExEHW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418dde387a3so5906675e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713442932; x=1714047732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxiOphSzFG5Jwu7YxITX8qnsYklBmzhxTqREey7lHE0=;
        b=KsbExEHWYP25+X9pAS3C7jTcJGe2czIk7I/FH96b5Tozhz0QC/JjnQLYkJJgXKXTlL
         yObEOPr9ZnIbgiylcHjFg65zqAxprlmmIPR9j0ihMwRWvgQCwiSH2l4KExRCK2hUcp49
         f/KgMwFtgxdXD25H5rZ/J7f0gF3y/bwCGWmvMgLiqnvJ2meHWSjBVGNCgFKa0KI1yNY6
         5mkaqsXxtnS41T2XMx0czPG5DJA+hmUOLimLkJFJ+HP6AHCu5J9GFAigTHbKn2Iz0yaz
         OxfaWQwDAkdgiQZfmqP9aB/D+dPtzZlM15aPeoaULk45wu5JQYuTxtU1j0hcInPWCUUC
         uLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442932; x=1714047732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxiOphSzFG5Jwu7YxITX8qnsYklBmzhxTqREey7lHE0=;
        b=burvLqrl6ITqdepP5dLpMJKH8x8G8LS/Eamif/N4e3tSLSsgn7fj8RsvFaJvoa0GBp
         m4zdMbfMii9uSR42coHqs49zc1VidGoOmEvCDlppo/8HonSUErYx3eZNRZzYbMj7UUoN
         4PUanmBBdMZMn+99dMEXqf0WD+HRZizJ3Z6iB6V4J5y6UsSMERT9HvM/34TbcTMJ000l
         FsuayAJcA8jACmkjGUkCm5m4PjVDUOG40qavy5z8Lmy0uCbYGC7J6YB479mBBTfTWLi8
         idGXpApNPw6dsVbW3otobsyKQuLB2IwNaZUvlQMCk5YpR+Mr1bTkLg9725+eWBKpUHWA
         yUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQNfvL20sGlf59fyC9usoLx5YFYp3V5l5+J167aunZX2YahVC0d0DDHJPSNBQUH0aPg3W5LMXYJUKgqoG3sEPa4xV5vKO3+Y60MTvThxY=
X-Gm-Message-State: AOJu0YzSDcFoo0V4DEKzXmYHWmsLiy/QRlwiYIiaaGEqmMmRiVz1trAw
	Y9Df5CSoGb37P5+LqvtwGb2j+uWg5o9LZpq03dGjQvE8RhoVo8zS
X-Google-Smtp-Source: AGHT+IFMXGy6d/csMGjsuPbn5tvH4stxskgLU9vEl2biplUuMNn62V6CNDr/CrFSwhpqujRYV1MznA==
X-Received: by 2002:a05:600c:524a:b0:416:8091:a39e with SMTP id fc10-20020a05600c524a00b004168091a39emr2078138wmb.10.1713442931885;
        Thu, 18 Apr 2024 05:22:11 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004189a5ada3asm6412908wmb.19.2024.04.18.05.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 05:22:11 -0700 (PDT)
Message-ID: <cc3c4c40-e07b-42c4-8d24-80d67fa1f46f@gmail.com>
Date: Thu, 18 Apr 2024 15:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <4e47c56c-4b7f-4ae6-84b9-05f0cac97dac@gmail.com>
 <72bd1a7172154d4e9a79678e5151cdf3@realtek.com>
 <ad6057a1-9d3b-4b2c-ac47-5df688f5bed5@gmail.com>
 <42113d0a089d4096aa1b5cc3861ac297@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <42113d0a089d4096aa1b5cc3861ac297@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 03:49, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> On 17/04/2024 09:48, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>
>>>> @@ -228,35 +238,25 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
>>>>                         break;
>>>>                 }
>>>>         }
>>>> +
>>>>         while (!bwrite_success) {
>>>>                 wait_writeh2c_limmit--;
>>>>                 if (wait_writeh2c_limmit == 0) {
>>>>                         pr_err("Write H2C fail because no trigger for FW INT!\n");
>>>>                         break;
>>>>                 }
>>>> +
>>>>                 boxnum = rtlhal->last_hmeboxnum;
>>>>                 switch (boxnum) {
>>>> -               case 0:
>>>> -                       box_reg = REG_HMEBOX_0;
>>>> -                       box_extreg = REG_HMEBOX_EXT_0;
>>>> -                       break;
>>>> -               case 1:
>>>> -                       box_reg = REG_HMEBOX_1;
>>>> -                       box_extreg = REG_HMEBOX_EXT_1;
>>>> -                       break;
>>>> -               case 2:
>>>> -                       box_reg = REG_HMEBOX_2;
>>>> -                       box_extreg = REG_HMEBOX_EXT_2;
>>>> -                       break;
>>>> -               case 3:
>>>> -                       box_reg = REG_HMEBOX_3;
>>>> -                       box_extreg = REG_HMEBOX_EXT_3;
>>>> +               case 0 ... 3:
>>>> +                       box_reg = REG_HMEBOX_0 + boxnum * 4;
>>>> +                       box_extreg = REG_HMEBOX_EXT_0 + boxnum * 2;
>>>
>>> Should be "* 4" as well?
>>>
>>> box_extreg = REG_HMEBOX_EXT_0 + boxnum * 4;
>>>
>>
>> No, because they are only two bytes apart in this old chip:
>>
>> #define REG_HMEBOX_EXT_0                0x0088
>> #define REG_HMEBOX_EXT_1                0x008A
>> #define REG_HMEBOX_EXT_2                0x008C
>> #define REG_HMEBOX_EXT_3                0x008E
>>
> 
> Sorry, I misread them in rtl8188ee/reg.h. 
> 
> To clearly know what 4 and 2 are, how about to define:
> 
> #define SIZE_OF_REG_HMEBOX 4
> #define SIZE_OF_REG_HMEBOX_EXT 2
> 

Sounds good.

