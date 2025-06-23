Return-Path: <linux-wireless+bounces-24371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E29AE4BB8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4A1898EB7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC4287519;
	Mon, 23 Jun 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7bJI63g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1081C84D2;
	Mon, 23 Jun 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699349; cv=none; b=QLEdQHbeOmcSSwgdiV0llLUTqQXatmnaTweTBChOCrBuvEhRzEoROZRz596MECGbR/WLILovM9WQojLFGsZXAoGRB/41n0vU1bOSlnXbHKjZrOvJXokqWIZ9fYth9nlGjRgCCZZ2yyaTEnZ9Eu1iJuQozz3eeC58Z3MAw+TLH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699349; c=relaxed/simple;
	bh=jJnC3oKax7f/8XuZzqa3hqAba65AYPaIpYSbsZESE0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHc6LUC28+kBBZMM9WLHpv0jZRmq5XcGJamnba+MyxaOTUt9Ry9MVxi9Rz9u+4C5b8j/+i2hyXWXsM+nI4xGbjf3L1knH9Dj09wWlvCcEgk0hqeuMIkGW6wVC5ReK0HP4cwxLpdZ3CGd6wstojJZlllCm47lIstHMw8O/a/vaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7bJI63g; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4161938f8f.0;
        Mon, 23 Jun 2025 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750699346; x=1751304146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1dFWO8xuumTz++9X/S3giqAnnD34xC8uxJzEdXlf3g=;
        b=B7bJI63g/o0oVMQJjUhTTfTf09YMg8hLaM8oU8UmQ9XxTpCf7DS19/YWn3qROOZhDb
         crkvY6Nsaz2uRJ4KO1RLJKGBiSw30dcXPXuVeXUGeE9p8rggwFtai0AX79drj8zRk2OV
         +79cYNU1+6VSu+fh2nNEOjkXGjm3+3/lBiW44BshRj1TVO/DumQDtpkwGBtojtjpFIOZ
         pooMC+bHCXg3HtcgugoD4gzENlE19kBNF0UGTjeesjLOqjPObGXWmvcR2mUhfmsZfCb/
         W3cCCdjwPevNcTGVH7L0yyImFWRsEcipKciK5WdtUN4/TvO9KEBolNnivDZB+RtHeWIo
         fB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699346; x=1751304146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1dFWO8xuumTz++9X/S3giqAnnD34xC8uxJzEdXlf3g=;
        b=Aqxf1+F1JWKBBRYI6RnK06IsPICYJOWkpFAwUMAYRrF0T4c6QeUQVA+FOsCflx6k7K
         1HS2zdjktKbkvCnm2IptRolpaTFEjRfiAZXX7lrCMvTClvucOFEt1a0qckhr0Gh19WCs
         bvw9HQy/3kmoC4eXSnK2lktGikq5pwoRbaZNM11bfSKE4Fg2Fm0X1X5TgGQX9JC/tMq7
         srHADnedAjfK+/VUBMXkuSaA4umwjVZHGgBrWRPRwGT1GzhzRXxF6rEJkBfodsmZhV/V
         sR9fJKAJbzbzMhDhAH2t6C4Ta0rNjK2nK/t0FeLnHDKbwhQJBXSbXvGiHMwfaPI08XpR
         iFcA==
X-Forwarded-Encrypted: i=1; AJvYcCWK4+KYJtJLwlBVYse69IIfEOWE1URogk1ne0biw9eAjRCaz8gc5FYdguxA+Fk+eSOPdzEnjo+Mf4oeVok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunKHYTLeBFPPIHONfbW9CJouctjc6xSW3rk/JFWTApJMT9VA+
	kjcJG4GbhWgsb6ubLxHVIl01XkgC68cw/B5nENnIJteDYihi6hPVW2L9
X-Gm-Gg: ASbGncvQn+91ldZn2YCkH2jfkD3W4YbTnYrYnSCvviAxNDFj5J+EVDDCu4yKRckNhNS
	y420T40S53kHmQORLIMjwe6Gic/I7KY8bY4C2TsZzL+w2A2UfAdXqwZlKjN2iKn+O8oo/O1EFAW
	XBWYpO4HdO+unJ1+F31pbIuwHXiB1ANlIjmWl8EJHrv6Tfkts7rZ+eMswPP72BTVO2SVDyGqwlb
	w7fCUSzFZLMpg6FYloNG8MbIA4R3FzfHwnH4hod1+MNufTmmMztR4r/Wjv8mcLhe2urUsmOajSa
	lvY55hbzD4wAKVXB3KdzxtSNCT94ZwSAP8FxMThkN3qINuCtjSVXGsRZ4D5JwbHm0giGnQ==
X-Google-Smtp-Source: AGHT+IEVywBUomgjS8sPQ/hW0owg/JrKv3kaTq6UiGdoH2tmO57p8pY3WLUjlagdvN1FcUpF+NXsEw==
X-Received: by 2002:a05:6000:23c3:b0:3a5:8905:2dda with SMTP id ffacd0b85a97d-3a6d1303bd5mr8898449f8f.43.1750699345418;
        Mon, 23 Jun 2025 10:22:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm118259585e9.6.2025.06.23.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 10:22:24 -0700 (PDT)
Message-ID: <ed0b9b6f-f480-40ec-b4d5-453c78bd8a5c@gmail.com>
Date: Mon, 23 Jun 2025 20:22:22 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
To: Bernie Huang <phhuang@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Fedor Pchelkin <boddah8794@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
 <dcf695a6621f43e38a20eb860194191a@realtek.com>
 <7injzacfmvhrugcovyxkn4elnaxnzg27c26zmcqzrwhottyk7e@ap5ellaozcg4>
 <419811cccd774d38b5a9c0bbcdf5dfbe@realtek.com>
 <42783d9a032143bfb67ea969ee0b805d@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <42783d9a032143bfb67ea969ee0b805d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2025 06:29, Bernie Huang wrote:
> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com> 
> Sent: Thursday, May 8, 2025 8:59 AM
> To: Fedor Pchelkin <boddah8794@gmail.com>
> Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature enabled
> 
> Fedor Pchelkin <boddah8794@gmail.com> wrote:
>>> On Thu, 17. Apr 01:05, Ping-Ke Shih wrote:
>>>> Fedor Pchelkin <boddah8794@gmail.com> wrote:
>>>>>
>>>>> On Wed, 16. Apr 00:49, Ping-Ke Shih wrote:
>>>>>> As bisection, can I summarize as below table?
>>>>>>
>>>>>>     d56c261e52           firmware             IO_PAGE_FAULT
>>>>>>    (CQM support)
>>>>>>   ---------------      -----------          -----------------
>>>>>>       o                 0.29.29.7                  yes
>>>>>>       o                 0.29.29.5                  no
>>>>>>       x                 0.29.29.7                  no
>>>>>>       x                 0.29.29.5                  no
>>>>>>
>>>>>> If this table is correct, we will check the beacon filter feature in firmware.
>>>>>>
>>>>>
>>>>> Yes, it correctly describes the situation. My suspicion currently 
>>>>> falls on the beacon filter feature in firmware, too.
>>>>
>>>> Could you help to test when we have updated firmware?
>>>>
>>>
>>> Hi,
>>>
>>> Were you able to reproduce or track down the problem?
> 
>> Yes, we have reproduced this problem, and we found sending firmware command during deep PS mode will raise IO_PAGE_FAULT. With below setting to disable deep PS > mode, the symptom can disappear.
> 
>>   rtw89_core.ko disable_ps_mode=y
> 
>> Now we are arranging CAT-C equipment to capture signals in PCIE bus to see what happens at that moment. 
> 
>> One possible solution (workaround) is to avoid sending firmware commands during deep PS mode, before we found out the root cause. 
> 
> Hi Fedor,
> 
> Could you please check whether the attached firmware fixes this issue?
> The firmware version should be 1.29.29.9.
By the way, what does the first number mean? The previous version was
0.29.29.8. I would expect only the last number to change for this bug fix.

