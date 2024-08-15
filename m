Return-Path: <linux-wireless+bounces-11493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F9953868
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A121F22FB4
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45C19E7E8;
	Thu, 15 Aug 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F185c1vm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354871AC8B2
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739939; cv=none; b=XfrM+VIG5KDyUkEMHwIvX/LGrnhH7xBgBk2kpXyocmZpfdVLwIF80GrYTeK7tK9J0CCtZG8A1YcLxPHTuGL2pVVMh1GYmDGeaAq5iDmc1lTazdf6R85mfOQ8DBJIIWfzxxsj883Pw7RwT4Imnla36ITgepq6QvIjjAEMmHs6KAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739939; c=relaxed/simple;
	bh=aRxA7FJ+lvpowcEW2vlZsytKe5uHWkNPCSCJkxOg1k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVTfA9xjA28pPsHdN3/CeCFCDKUmNB5OaJaKDz/+I16/2ShrUl/6srO9vFDZk1L3mwWZREKPrJRR4nfJ0+QUP3kTOU36sUOYXTSkx+FQ0zomSkC2teJ0CYgKVlde/ghvpTGAa59frCmhnVt5VZ5Kszv1IizF4bgt5pFwVnuBHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F185c1vm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710d0995e21so875493b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723739937; x=1724344737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xulcGXZEULbJ4WCNcSPQTMNlh6M7re1bQifn38go1EI=;
        b=F185c1vmORxX8uHx+N7j0fTX5CwH1djFFVqS9WEBmIEawsWnbP8kZ7mMVjXvLaYXj6
         b2ShnJx7hDZGAKNhfJEnrZw5TBW1E6+ZlFsjQR7EUSrSNhbGyiDKZLF7lve8veLHHt9p
         bCnLd+CjCJpqQJH/9QAdMHjBx5e7DuA14x8GtEuhGy0FLDFuqDCeckDYyXZs+BEaroR7
         getpZKk7BEqTtNnulzU8FA5pBfquZ/O5ylWdkd6oQuZ6+8foYsOdl2cKuOaTFbdndiyK
         LnSlD/Vm6ZIvk1f3Ed4b8xkQz1rawBh41ayppAy92NUFvCXRmr9PGNDSH2SovlpmgjJP
         rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739937; x=1724344737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xulcGXZEULbJ4WCNcSPQTMNlh6M7re1bQifn38go1EI=;
        b=SbGocX4yHD+OUgnM41XsG3NM30/93/8feCkq5QsxL+dctfXacRQwEWxsY5VZSetJVZ
         UDQqx/FTevT8ijsCTc5zJqZLrlcOj3fJM5A3h+x27yUl+1aLNClzhNiSCN+rgAMibzz7
         ywzLmdMeDXbBrF0hM/3iXSeJHlR7H2RKfwu//HJSKqpXJw7Aj4SX1frGVlAtb74owp1W
         xGGdp8CUWMbRw94TGN6j9H87H2JFkoao0GfPRUtbFE0IVixEjN0I1+7JFeWHdheJWSXY
         oiZOj/fC3k6Ut1CRXBsvWI3DdpeSmqcZ9QlG63K08J6w31nHOxp8+kaIGsB5EjdjQDHV
         Ubtg==
X-Gm-Message-State: AOJu0YyiWWAOdUMf41+NWS6qsM9VKHGqHQZMAjHw1JUfmMhUMLP9cZzk
	VyeSYAomiEEq2IvDRh1C+4jupqj0zZ3xUgtC906dga49xl/QpPcomRkD+Q==
X-Google-Smtp-Source: AGHT+IHf9LDzrQUk0mhNX0HZI9A7eurftX5m+Q9cLW4kXKvfJE7VxepV3F0mOJa0dPy47BylagdAYg==
X-Received: by 2002:a05:6a21:9184:b0:1c4:986a:de71 with SMTP id adf61e73a8af0-1c90502fc2emr307361637.35.1723739937328;
        Thu, 15 Aug 2024 09:38:57 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef4504sm1188265b3a.132.2024.08.15.09.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:38:56 -0700 (PDT)
Message-ID: <3dfd6f81-62d0-4959-9ebe-69fceab3f32f@gmail.com>
Date: Thu, 15 Aug 2024 09:38:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
 <9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com> <87r0apyjc3.fsf@kernel.org>
 <6ba02350-3c8c-4664-9d68-67cb7e90eddb@gmail.com> <87ed6pydzw.fsf@kernel.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87ed6pydzw.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/15/24 8:58 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> On 8/15/24 7:03 AM, Kalle Valo wrote:
>>> James Prestwood <prestwoj@gmail.com> writes:
>>>
>>>> Hi,
>>>>
>>>> So I have no resolution to this (trying to get the AP vendor to chase
>>>> it down), but I'm toying with the idea of trying to work around
>>>> whatever issue the AP is having when this occurs. The only thing I can
>>>> think of is that there is a 3 second delay between the authentication
>>>> and reassociation, and perhaps this is causing some timeout in the AP
>>>> and in turn the deauth.
>>>>
>>>> I'm wondering how long it should take to add/remove a key from the
>>>> firmware? 3 seconds seems very long, and I question if this timeout is
>>>> really necessary or was just chosen arbitrarily? Is this something
>>>> that could be lowered down to e.g. 1 second without negative impacts?
>>>> The code in question is in ath10k_install_key:
>>>>
>>>> ret = ath10k_send_key(arvif, key, cmd, macaddr, flags);
>>>> if (ret)
>>>>       return ret;
>>>>
>>>> time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
>>>> if (time_left == 0)
>>>>       return -ETIMEDOUT;
>>> I can't remember anymore but I'm guessing the 3s delay was chosen
>>> arbitrarily just to be on the safe side and not get unnecessary
>>> timeouts.
>> Thanks, I have reduced this to 1 second and have had it running on a
>> client for ~19 hours. Still am seeing the timeouts, but no more than
>> prior. And even with the timeouts the roams are successful.
>>
>> After doing more looking in the spec I did see that there is
>> dot11ReassociationDeadline which may be coming into play here. Of
>> course these APs aren't advertising any TIE or even support FT
>> resource requests that so its impossible to know for sure, and hostapd
>> AFAICT doesn't enforce any deadlines even if you set it... But in any
>> case the timeout reduction is helping immensely and avoiding a
>> disconnect.
> Yeah, reducing the time out might a good option. 3s feels like overkill,
> especially if 1s timeout passes your tests.
>
> But I do wonder what's the root cause here. Are you saying that SET_KEY
> always works for you?

Yeah its only key removal that fails, we proceed on and adding the new 
key succeeds 100% of the time and in most cases this is fine, except 
these picky APs that don't like the 3 second delay.

Fwiw this seemed to start after going from 5.15 -> 6.2, which is a 
needle in a haystack, I know. Makes me think there is a race somewhere 
(like in the firmware) and the command timing changed just enough 
between 5.15 and 6.2 that it happens more frequently.

Thanks,

James


