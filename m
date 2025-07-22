Return-Path: <linux-wireless+bounces-25841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46133B0D609
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A151162134
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5F539A;
	Tue, 22 Jul 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="SRysRH0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD32DC33C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176897; cv=none; b=N7GSr9rGF4m2kVs8J8jpqSLrkULKa1xFOBjUc3vRquQ+RRQl48bY9qL/ze4Q2FX2ySwl0Py2BWUTXrJDUZ7YycPnEElgPQgMwShgmF217iEpOMDcWM3ZvbMwi14eDL1a4WH4w52iFQMSHY/P0ZGJg7M/ExJnJnBUACKuKGhNJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176897; c=relaxed/simple;
	bh=QiXlwzeUzIfpndMvuYuw7ipBRx/tGhDIErJOX+npC2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLbWOIHYkQp6mx++abUpKaPLA/as8jg/bzAouK9rtvkxJf99hcDJ/bfWnLYbLOvrCvNV4rDt3RGaba/bC2dQHAKIuOWMRemyZH//CwXOA+QIUu/wjOVWOq82vJ+j9gpc+Dnz8DCU9H2bouZrGNOlAM834265tC+kyzxkfyT77iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SRysRH0G; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so8977423a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753176894; x=1753781694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mRRFow74hkDzdHK2M00HN8QjhSRHwpbF0siFAmDnE0=;
        b=SRysRH0G5+PWymFBmauX/PbZbk8a304UPLK7Zwc474fH8YBFyRNc1G9XwEX+SyrEvI
         jG/azBkGIuO749K6VUXPdoUJJiz4k7x4kSylr2JVlAGkmVUY7tgznjob43Yv4JgKVDN+
         tQ/YdwVnKO49R83irXAViC9jfdVf1CLxMmdjcVLJIIayd+GY6lf6vVFdmKarTAGvSmi8
         GZ6R427fSNE1VsU4hNqJvYpAGnWk1Y7y6j7OAQEqAsbK+WTV5To+0VZGrRlcSixRgyKV
         h80TzCgkaJuh4VcMKr20yhqh/67sMgmQO2Y6vG8O9aMcwEfoGjB1tYCPnr6et9WhKpq2
         T6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176894; x=1753781694;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mRRFow74hkDzdHK2M00HN8QjhSRHwpbF0siFAmDnE0=;
        b=D/BJ3R1+M7gfUmUbyE7RqA5wxmBOy57OQLnKGD1FqMayqz2rCqYHgymOLn66FpE5Sj
         eO/nidhcs64x27sdKDG7zD8oGedNbKoajuOLHEgg9s97bGnYmFIMsMXM1qDQ5M0OpGti
         EKSestOrI/Q7TvqxFPNw27c11obAqBMGuoZLD37N4vDggk30Eur0ILAgeMX7CmHcdovF
         GrlUIlz8kkIOLw6PcDSfODBrbmHCB4TXVT7MaBQkfsdEP6wBXpFZ1uxAsg0TLJ+Xgfxc
         OgLkTZCpCUDOxW0iBWU62nBPcZ0uT9qNKC8e3+l9UIKl7s205MOTQVVdvsIM4cE+/BES
         7pIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRD1BZFjVXe1LKbft3F0vfuMh+WWXOl0/BiIxIlh2BaSwzN3Ytl7RTN3gYg8u9s2iWyTZuHZ9LRd1S0M/DpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsh4SI/PTNzeYXORpiiWClzm5U8nT5MzYkzWAXoPYxaKD3JwC
	toI2BlhPp9Q5CpBNDvFveBjPlIXcryXb28yoAcng3S2EAKshfZf6MBeOtwJngwm6kCnxVWWp1K9
	1ygWczm88qg==
X-Gm-Gg: ASbGnctn+NLCMF3ZgnXd4Yfz2awz09D4pgdldLn24nnGAHyJ9FLaZxzCs/x5xDDTkn2
	DNAsmSkzCdxYnmWbXXsFMpbGlaUNiIM13myXzlxY6Zjrv0lCm1wGUU2D1qqNqUEAvqeBOPGhMLm
	keR2zQDdYffJNKwvFpGsnL4518MeFTMeE4aIudv+CJ62c+AeJN84fpGCqrHYz6uDRa5SdSE+Xiu
	eEBJI9nRVpv5NtLNmd8exggouVFbzk455LKNLeoyZO1W16W7mgzkNmrvB65HJP9DZa9eJTUpnGY
	6cGh2wbbxpPLEJGEf/0P56t+IMDcpr7oPbME7Xim2uiweTOJC9jNTplXW+PU1LWYyj/E4axFtCh
	/XLNAu9IfGv5H8NEfowHLr+mot60kQYBlNhmk6iC69joSRp2ha+YGfbGvsBTKvYOusteJFIA=
X-Google-Smtp-Source: AGHT+IHtabRUfRky2fcXRw6vpi3pTz4XODqheitLXVFrSz+L8j2W4H5IwU2QA1dc8GdyMzIBYMs9SA==
X-Received: by 2002:a50:d61c:0:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-612a4f7d7d6mr14483364a12.33.1753176893944;
        Tue, 22 Jul 2025 02:34:53 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b6d9:6def:525:5a1b? ([2001:67c:2fbc:1:b6d9:6def:525:5a1b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90a92c7sm6636155a12.62.2025.07.22.02.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:34:53 -0700 (PDT)
Message-ID: <26781b7e-b5b5-473b-bfd6-1190536eb8fa@mandelbit.com>
Date: Tue, 22 Jul 2025 11:34:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix unassigned variable access
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250721211736.29269-1-antonio@mandelbit.com>
 <cdfcd722e1f8527809d89e13484bcb25d3e74947.camel@sipsolutions.net>
 <2e3aa500-989b-4acf-b6f8-9ee200e67cca@mandelbit.com>
 <1db07eb608ee4345c70fe135dfbe6fc19e17cdf2.camel@sipsolutions.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <1db07eb608ee4345c70fe135dfbe6fc19e17cdf2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2025 11:02, Johannes Berg wrote:
> On Tue, 2025-07-22 at 11:00 +0200, Antonio Quartulli wrote:
>>> So I think if anything we should worry about the
>>>
>>>                   if (time_is_after_jiffies(timeout) &&
>>>                       time_after(timeout, latest_timeout))
>>>                           latest_timeout = timeout;
>>>
>>> comparison, but for that just unconditionally setting it to 0 is really
>>> the wrong thing to do, since it means you compare to an arbitrary time
>>> zero here?
>>
>> We are looking for the maximum timeout, so using 0 (minimum possible
>> value) as base line should be what we want, no?
>>
>> [note: I am assuming 0 is not a possible timeout value]
> 
> That assumption is wrong, in fact jiffies starts at a slightly negative
> value (about 5 minutes?) so that a few minutes after boot the time goes
> to the perfectly valid value zero. And on HZ=1000 32-bit systems, this
> situation of course reappears every ~49.7 days.

As discussed on IRC, also the caller of this function is wrongly 
assuming that returning 0 means "no timeout planned".

For this reason I'll send v2 where I will initialize latest_timeout to 
jiffies and I will re-arrange surrounding checks accordingly (caller 
included).


Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


