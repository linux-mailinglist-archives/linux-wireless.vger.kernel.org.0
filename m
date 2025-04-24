Return-Path: <linux-wireless+bounces-21977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC6A9AD08
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CEA17D0CE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7E21FF2A;
	Thu, 24 Apr 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YAtElbgm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC822579B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496990; cv=none; b=aRSbXaUowYzc75AHsJuNfAZBUzOystU9oJYZbNWQ+RtSshjnSCAg72ftR+eRJMUkmTyb1Bmvzmk5WkU/1ESucImdbQIrSAekvZ/pfHr84aZ0kj9dokytkU0P2XxerLuj1HS0sZk0smoLNMOOcpe2LCBy84U3KD7+2wKhG6/Ba+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496990; c=relaxed/simple;
	bh=RH4cxXtt7fI3mEpjHRbYYW1oLOn4FaBe3NxCiHWwyvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gj0oaJEYPNwbzqlL3FMU6dZSL42qKrOeiHHaIr9mJhNfh84pe2htQ1X8HmHu0rjDAI43RRE3PpsJtOz2Ed5Z/5vinrhn9OZcjLaLs1DK/ET9krmqTFHqr/TIUj8zQ6SNIoP+ODT7ZvG/1EIBf1w7jV7TcO86nnYpx/mjOIFriF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YAtElbgm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72ecb4d9a10so703540a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745496987; x=1746101787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sNVMnodmIyeZPeLyfxnfC/latgBCcr61ac08k4+PpQ8=;
        b=YAtElbgmZ89x4pSojsv0KEQb3liwsptKkdDGrNMh9KmYbFr54SXkNPRA41axCP0j7c
         l/bs6fF/BTEdGq9n5IBFoMhzCYJe7kzUIephG8zo5p0mQKRyQtkvpk1l3B/nK4B+bXa/
         3gtChc5W4VZsexm4Pempn/fUeaamn7LcG1QFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496987; x=1746101787;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNVMnodmIyeZPeLyfxnfC/latgBCcr61ac08k4+PpQ8=;
        b=iI/+rsgcSgIfLoqxNrlaynOVrqn6/OcbtJbzc68f0Q+4IS+R/Gd+5P/UOKrEOZTgoJ
         MJYjK8Oq8dqjJY4ksVEHO20x7VfozW234znrqD9G+2Hz0hIB3yqrGNCjpMTOEkXOw3aW
         x0T6TZQVoQuEoam+YlO/euM5chqBGpWkxa7bL3ZK08sWr8D7h0B+IqNs/Ek/ElbTiX0v
         c/hDNQCTPfuxrIF/j//CZmun5OU8nn8Y2cQ3cYzzUbbptPDwUciUyH8V9iKkOwYxgoRP
         QnsEHhOgO/uoiu9BiYZNRs6l2wuwMFD/MYakqLnEpRumzwPi1506PAC+i9qkPTdruXo/
         L5cQ==
X-Gm-Message-State: AOJu0YwJs4Lk/LydJ56avd4fmFIrAGjaxeSWKqYmB7PkKb+53PTYegib
	H9ffQ8aanP9DJdWCJFimYUhWV1+NaetDq/2mxTSA1BrBx2ZoXEpfX834lNT/1Q==
X-Gm-Gg: ASbGncvTmio96xOvtoGZJovWHosHrZfL2j51kHdQkkqELbr/q5tWqnsf131L/dSt2ed
	Zx8/bAa0F+U+IWJOaad9i9O9Y15zeavRB9lHAmJfuNEtuyDfXt8uFc2Jso6L/8njaHSj3c8+Ng8
	v9kJGUQyD3xlu/2l89/gdQhaMeo4q/jPzIKEACfkY4CMqCLAoReOqDtcNTvZM3ddECbIJG1qebG
	Xfkm7DtLOu9LfW3QY76wddgg4x6HjG0j2H4f100BDQJVfLXkH/R42vaNWpsZQc8nrON4Ez8B9Nl
	8zCwQm/QnZMNzDtCqAK2Vcq6X/9pQ4EbO7lTeF0YLy+f5dtUQQ2YO+/xXCBkv2ULIaW4
X-Google-Smtp-Source: AGHT+IHb2bB8QsP/OdEicmEEmA8u7IxMunRI8XtykHg9ervlxSioq3AHmPs5HwYVY2Pl893o8/RlMA==
X-Received: by 2002:a05:6830:61c5:b0:72b:a465:d93c with SMTP id 46e09a7af769-7304dbad04bmr1653952a34.20.1745496987191;
        Thu, 24 Apr 2025 05:16:27 -0700 (PDT)
Received: from [10.176.68.112] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f1a408fsm215566a34.27.2025.04.24.05.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:16:25 -0700 (PDT)
Message-ID: <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
Date: Thu, 24 Apr 2025 14:16:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
To: Johannes Berg <johannes@sipsolutions.net>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
 <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/2025 1:46 PM, Johannes Berg wrote:
> On Thu, 2025-04-24 at 13:36 +0200, Arend van Spriel wrote:
>> On 4/24/2025 12:22 PM, Johannes Berg wrote:
>>> On Thu, 2025-04-24 at 11:50 +0200, Arend van Spriel wrote:
>>>>
>>>> Looked at other drivers implementing this callback and here are the results:
>>>>
>>>> [wil6210] wil_cfg80211_change_bss(): does exactly the same thing.
>>>> [wilc1000] change_bss(): worse! it accepts everything and does nothing.
>>>> [rtl8723bs] cfg80211_rtw_change_bss(): same. just an empty callback.
>>>
>>> OK, though I guess other drivers being bad doesn't mean this one should
>>> be :)
>>
>> Sure. I am on your team in this. Can you recommend a plan of attack
>> here? Should we add a mechanism to expose what BSS parameter changes the
>> driver can handle similar to what is used for struct
>> station_info::bss_params?
> 
> I don't even know off the top of my head what's there and what isn't,
> just thought the code looked odd. I guess mac80211 just mostly supports
> all of them anyway.
> 
> Today the change is simply rejected by cfg80211 with -EOPNOTSUPP:
> 
> static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
> {
> ...
>          if (!rdev->ops->change_bss)
>                  return -EOPNOTSUPP;
> 
> 
> why not keep doing that for everything but ap_isolate?
> 
> Oh, I see what you mean, there's no way to keep that updated since you'd
> have to check each value for being changed and reject that ...
> 
> Hmm, yeah, that's not great. I guess ideally then we'd have a bitmap of
> what changed, and what the driver can support?
> 
> enum {
> 	CFG80211_BSS_PARAM_CHANGE_CTS_PROT	= BIT(0),
> 	CFG80211_BSS_PARAM_CHANGE_SHORT_PRE	= BIT(1),
> 	CFG80211_BSS_PARAM_CHANGE_SHORT_SLOT	= BIT(2),
> ...
> 	CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE	= BIT(N),
> ...
> };
> 
> and
> 
> struct bss_parameters {
> 	int link_id;
> 	u32 changed;
> 	...
> }
> 
> and then this driver can just do
> 
> 	if (params->changed & ~CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE)
> 		return -EOPNOTSUPP;
> 
> or so?
> 
> 
> Not sure how that'd be related to station_info::bss_param, that's just
> output from the driver.

It kinda looked similar. At least there is a bitmap in place for it that 
is a subset of the enum you listed above. I was wondering if we should 
convey the bitmask to usesr-space beforehand in struct wiphy.

Gr. AvS

