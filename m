Return-Path: <linux-wireless+bounces-29928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3BBCD047D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3C76300913A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366B302140;
	Fri, 19 Dec 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBPwua8d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BC339701
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154810; cv=none; b=qAXtaOM0nmjQGRP0Oi9dVb/zuzimylJqnp2fMzRVvgDSCDl9vlI4pORJjrP/9jWP29qzewMJ/a6MIzR97D48Y3PQRJf7Lc1LXF3XCSPwhGWfNSqskdxcPJJU8n3MzijmOBGJd5AdEtkMypkpU0OYyLJJaGYKXguR1Vi0iPc+4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154810; c=relaxed/simple;
	bh=zNTyBY0thjdT/VJ83BykN1lP+V+qyOXUAmAHADfPA3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rre2KVulX6YNSAwvfWYiAUlMv/pWJ4NypkNgR10RF2x1VmcsWevkWrntz2EZC6G9s66rOPUmZijc1v+xxbPTcHshdiJFhQ4G1biGFCO7E5MxUTPQ4NDYOpWPuapfbMJDq7yrw0bJFaoLG/cnLMvlEXJefDPfAWxDSat+3ybjKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBPwua8d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so12809295e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766154805; x=1766759605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+wQ/Wi0f7yjr9An/5DGy0nteWDVX9DJq0xQd5+X65E=;
        b=XBPwua8dSGRSbyMLgzF1fzoL2kEYAAFnbz/RBQWzSgHMQ/HMODAsKKDpfYexAg8iZi
         e6f+ZSqThNSNy3qIp1UuFBRx98cZeE7YskPdFgVNv/6ykJQ8hR/2MmeBbnJJzbeL/pkf
         99OXypJDwZxJBzefOaEYrQJSVgTP0OKYiR4QWaf60DyfrKXleHNyt64jXtTYE4zGU35E
         9YbNcSP/JHHfDsPuqeF9P1mnvDSSPF1MpwB20L3/QfVso2OX97Uzqj1r4dEi5fYknCza
         zmIduhADOx7EGFnc8eeCbh1mTeS431n66lSqFWEl86MUrKNg8GdzJTqsXGiaeokze6SC
         IAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154805; x=1766759605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+wQ/Wi0f7yjr9An/5DGy0nteWDVX9DJq0xQd5+X65E=;
        b=Mh3NtryOlKybO4lipN+Mn49UCpYyn1Fh+tspjgXxHIbHxlG/UrmF96TKF6Qyd5soKC
         nmXS8IhgKhy63wa9EIE86vu8/hM+AImcqcqkvt7l3cUk+QCd/vsMcmftfkFaXny3x37r
         62hbt0KLtUSIEs0BX7w/2g3jzasYq1COwFDjCFbNILMv9p6MYPnUlvhc7OgIP+FuUoGX
         urTTFt7j3eKA8n3j08FGhedi4n/4j9teKgQLOoaEuaal+5G/cli0aFPXD5bGao478+e0
         wf4lKaBUVjWPXZstn+hoAGDM/QHeGuLRm4j1aKf2aLN543VoG2cR8wVr5k8pnfzmnh7M
         aXrw==
X-Forwarded-Encrypted: i=1; AJvYcCWOkj2HtG3TAOjtjsoTRqTIuZ57gEJqrTmzmbbsaORcjD34IXpxHdHYKfE9vd5Uhz1q5eCFt5D1xCQdzBXwHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSdpFifoeGt/Zs/foAEhpZVTDMfUxD6OagQ5oJfg9Yy4jDLPN
	NV6jwRged+bVck22W2Ygxqyzm6t3yJ63sFFow53aO1BbkGmG7xtueHe6
X-Gm-Gg: AY/fxX550GG5rcb+n6LC9QGzpwXnHzysO4VD8lAsTXgGDI1Z4a5pIOb9GS4Ngj35Jym
	nkZ50A+b0XCFJJWMzRCc5jwTtW6vhsdsPFkEz34Dhg/0TLSjyQDvlH0Ik7b+GGTpZyF7s7lQ9Ob
	XjCYRGvxbIBExZtdzN8muficsDMHfoXyAoSz4eVhuB7fBTMg72gFwfRp4Glb7KbySQNLDtBBgSQ
	QraT+OMWVPjTtZGisMmNcPwN9vE0PeJo3GozXl0p5k/sGjPTFtNbAZHq6JUYjsP0LEkwg2bqMmF
	26f4W7iqY0Wc+CqrzQ6EYC5I+o834vpUCvpwFBsBvUpHG1HKnKA0BQj8qzj2SjQk2RY+c6K9y1u
	u8KlQJT9A7NejUsOZ3jFpsy2GEO0v82PjjRd+YltzfAonQ/Cg1qKWg3XBUGX05gU7w7K2UMIS9d
	iM7yr8+PTG78Y4/MJPydx8haBSpOdfcZ4=
X-Google-Smtp-Source: AGHT+IF/s8ujOm93tcd15TKcDVFrMsCraCeMpO8XeU4CD7sKcPO/wyk8wssoQWTwaGxKyR0ZOnLrqQ==
X-Received: by 2002:a05:600c:64c7:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-47d195a4a14mr27000255e9.35.1766154804557;
        Fri, 19 Dec 2025 06:33:24 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm45144665e9.4.2025.12.19.06.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 06:33:24 -0800 (PST)
Message-ID: <79dd0a91-1a3f-469e-ae7f-3691e9277340@gmail.com>
Date: Fri, 19 Dec 2025 16:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
 Zong-Zhe Yang <kevin_yang@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
 <20251218063117.26278-11-pkshih@realtek.com>
 <fd0e0d09-e220-4465-a80a-b26974602fa9@gmail.com>
 <7482605222b747afbf9658170cc29b6b@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7482605222b747afbf9658170cc29b6b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2025 15:21, Ping-Ke Shih wrote:
> 
> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>
>> On 18/12/2025 08:31, Ping-Ke Shih wrote:
>>> XTAL SI is an indirect serial interface to access registers in another
>>> hardware domain. When BT driver initializes UART interface, firmware might
>>> rarely control XTAL SI at the same time causing access racing.
>>>
>>> Current is to adjust initialization flow to avoid the racing. To make
>>> the racing visible if it still presents, add a message to address this.
>>>
>>> USB adapters might be unplugged suddenly, causing flooding messages. Check
>>> RTW89_FLAG_UNPLUGGED flag to avoid them.
>>>
>>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>> ---
>>> v2: handle USB being unplugged case to avoid warnings.
>>> ---
>>>  drivers/net/wireless/realtek/rtw89/mac.c    | 31 +++++++++++++++++++--
>>>  drivers/net/wireless/realtek/rtw89/mac_be.c | 13 ++++++++-
>>>  2 files changed, 40 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>>> index e5f2fa3b2b37..8987077bf756 100644
>>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>>> @@ -1483,6 +1483,15 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
>>>       rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
>>>  }
>>>
>>> +static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwdev)
>>> +{
>>> +     /*
>>> +      * Avoid accessing IO for unplugged power-off to prevent warnings,
>>> +      * especially XTAL SI.
>>> +      */
>>> +     return 0;
>>> +}
>>> +
>>>  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>>  {
>>>       const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
>>> @@ -1497,8 +1506,13 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>>               cfg_seq = chip->pwr_on_seq;
>>>               cfg_func = chip->ops->pwr_on_func;
>>>       } else {
>>> -             cfg_seq = chip->pwr_off_seq;
>>> -             cfg_func = chip->ops->pwr_off_func;
>>> +             if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags)) {
>>> +                     cfg_seq = NULL;
>>
>> I just realised, this NULL will be dereferenced in rtw89_mac_pwr_seq(). 
> 
> Did you mean this statement?
>    ret = cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq);
> 
> In this case cfg_func is rtw89_mac_pwr_off_func_for_unplugged (not NULL),
> so not possible to run rtw89_mac_pwr_seq(), no?
> 

Oh, right. I didn't consider that.

>    
>>
>>> +                     cfg_func = rtw89_mac_pwr_off_func_for_unplugged;
>>> +             } else {
>>> +                     cfg_seq = chip->pwr_off_seq;
>>> +                     cfg_func = chip->ops->pwr_off_func;
>>> +             }
>>>       }
>>>
>>>       if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))


