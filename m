Return-Path: <linux-wireless+bounces-21960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867DFA9A912
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A98D7ADDF2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375522127A;
	Thu, 24 Apr 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WoHlcbz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76836225A36
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488218; cv=none; b=R4DBc26UGzjtgKvI/NYo5fO1LGr9gKjXbtjzdvCqEnxUGtJZ/AJ9Ii/P9zJw4tieBZRMTjrkkUAHX6es2FBAMJ0FMn543cg8mmK0h6UFwhiuE1GMJJVYyrwDtpDlVcPdOefJ9Z8HzGnq8X83RkW0TdYyhACQt9PXpnwsDu2P3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488218; c=relaxed/simple;
	bh=J3EdwhmAk8mTUgYaULYZef2d7v8RGpjo8Wg2LAHXglE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDxVbvpRBfoQ4wJr/DPh4jqNkInFZp0Owjcapfi5QZbWAJMFHoOA0uM12ioNqMMBobuGvVxi+8MrBBSut4VIneRJidp4M4c2Fm56TJwV5VJW5Oe7NnbPjb5R0nfmQk3sgWjEBV+Zzz/dGLiNrRbxeqCdtt7ZExXdbuGHnClqWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WoHlcbz8; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f8d2f8d890so517655b6e.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745488215; x=1746093015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1sDlsk1f7JwMsEIjLPbJg+HMEtxXdhBEoQcbaud2pQY=;
        b=WoHlcbz8lbBR9417t+uMOWImfK4myAhLskqX7YmuTly7OnppbjhlVGXo8Gm5/Sf07h
         ePt5AyN5XoEI1+Qn/5VBOK3e0269RccNizhdHsVJe4e1ucMtAzmqwU6gao9JtDHtuK5X
         YbjQgCjaQVFW7VS2dZWPGGquj3Iaekr97cWeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745488215; x=1746093015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sDlsk1f7JwMsEIjLPbJg+HMEtxXdhBEoQcbaud2pQY=;
        b=dkUJSVmUCueon5imxjKUyt/9D5u96dtC/XUDPztmQ+t4+wuE7pxSHWneaxNaEVfOTJ
         /G+HbQ3jUSdGm+7ZjMZ+xwEHUoecOkNFR90lEi8tnxSxK4T9JSVBTOSnCVdiCD8NsyG/
         b5EcUxSA8blYuckLo5gC07NsWA5rSpcfUUUa9ZKZpSzI5NfhfCSK9nzCxIE5fv1Oz9f0
         9YdSbYbeKvawqTlMTtd3aIG9DyTt7NvoEDGffTgzO4zYu7lrHYNuKuv+gc0GvrEKprgc
         EvnkEtaiSHkZ4o+wcrWX9n7tDqrt3Uh/KQdv/J/RCK1FdNFKLndvFfNsdmqVrzcOlw57
         BBNg==
X-Gm-Message-State: AOJu0YxHk8/+KKKEu8cxhXP/M0rJxLJqBJDjRJPkX0Iok7cPOiS0tN7T
	ulqnJv9SsZcCkhtTTuEHPJoBUMPnFVpGnutDldiuPw7cnHjynjj5fa1nHylS3w==
X-Gm-Gg: ASbGnctwq4D9MqCKkf/PXMhZujsKheruDKgI9wBsYtt6IOmW/4R2QYANUok6qFEqTfv
	16E/3nrtTi99JMZPWvTdG7W9KN5q0mU3Gv4FLXYEzCapAquj4OV+sBVDnueCkyRn2r80ga/VXzA
	wmzGYGPa3Qm+tRlVIaWYX81cTJs9bTdwLUpW2k+Hlu/iRoyatrToWKZNOkKAcUoHqKijYfIjzUz
	XEU90eAM9JriEqiLmxJMaurqMVFN+IGT17Bo/vMjGnHwXHkcUy0DijlENvI5YRQ0PHES0yxEiCf
	I1SddxjN8jei7pyL2dRyz5aH5meqNzx0JETQizgM/ZzQ+66Ml3lddSmUQtjMmV0/MJS8
X-Google-Smtp-Source: AGHT+IFKPrlkA4iqqlI5Tp8HB2lTv2/Mph7jU0vqE9o0lEqsztq8NJva1zfxYl2NH5FqmHAdLxPdFA==
X-Received: by 2002:a05:6808:3848:b0:3f6:abbf:bb88 with SMTP id 5614622812f47-401eb349e28mr1249381b6e.29.1745488215509;
        Thu, 24 Apr 2025 02:50:15 -0700 (PDT)
Received: from [10.176.68.112] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec8e4a4dsm179107b6e.29.2025.04.24.02.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 02:50:14 -0700 (PDT)
Message-ID: <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
Date: Thu, 24 Apr 2025 11:50:09 +0200
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
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 12:15 AM, Johannes Berg wrote:
> On Wed, 2025-04-23 at 23:21 +0530, Gokul Sivakumar wrote:
>>
>> +static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
>> +				     struct bss_parameters *params)
>> +{
>> +	struct brcmf_if *ifp = netdev_priv(dev);
>> +	int ret = 0;
>> +
>> +	/* In AP mode, the "ap_isolate" value represents
>> +	 *  0 = allow low-level bridging of frames between associated stations
>> +	 *  1 = restrict low-level bridging of frames to isolate associated stations
>> +	 * -1 = do not change existing setting
>> +	 */
>> +	if (params->ap_isolate >= 0) {
>> +		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate);
>> +		if (ret < 0)
>> +			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Seems like a terrible idea to accept any other changes silently without
> doing anything at all.

Hi Johannes,

Agree. That would indeed give the wrong impression to user-space. 
However, what if the firmware does not support some of them that 
user-space actually want to change. Seems like we are missing a feedback 
mechanism here to inform user-space about partial failure to apply the 
requested parameters?

Looked at other drivers implementing this callback and here are the results:

[wil6210] wil_cfg80211_change_bss(): does exactly the same thing.
[wilc1000] change_bss(): worse! it accepts everything and does nothing.
[rtl8723bs] cfg80211_rtw_change_bss(): same. just an empty callback.
[mac80211] ieee80211_change_bss(): not surprising this looks pretty good

The mac80211 implementation fills a changed bitmask, but that is to 
inform the mac80211 driver what configuration changes to look for.

> Also, please pay attention to the linux-wireless list. Like, at all. We
> started using tree tags months ago, we started using a different subject
> prefix _years_ ago.

If this patch means Infineon is (mildly) regaining interest in upstream 
wifi development let's not discourage them. I do watch the 
linux-wireless list on occasion but I am a bit lost on your remark. What 
do you mean by tree tags. You mean the "wifi:" prefix? But then I am 
confused about the "subject prefix" remark.

Digging a bit further maybe you are referring to the "Tree labels" 
section [1]? I always considered a patch with only [PATCH] as being for 
-next implicitly. If it makes maintainer life easier I am happy to 
comply and add it explicit ;-)

Regards,
Arend

[1] 
https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#tree-labels

