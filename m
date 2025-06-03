Return-Path: <linux-wireless+bounces-23557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3228ACC77F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2DF1893CD3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9EE130A73;
	Tue,  3 Jun 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Adoz7MAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60872617
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956666; cv=none; b=lMEMFm41j9sUK8IdC/nLq2gGj25fbRK0ghKv/0bcOZqcSREklEIhtcfDcb03FGUKsSEEzrF+ssN8O5EtGFafrrXNlHzV2isEdto8Caj5bMMIsw6HRgdI8Hppbj/KBjeMlY59Tu0RXpIdR/fkD3fJ5kLfQEI/YV9AxNTP8UeX/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956666; c=relaxed/simple;
	bh=z0wMJM9XeopdPxUsMiSJupD8vdtn9jb74bquBGPkeQg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AFz8rvpb5YcmO8xbvHZVO1clSnrQusOBWOJWnAuW8aZ79QnwJg+AiuPZ47E8HF96wcaGTsuqDrTsrHwxQx0ZpaJFGoMgCNz7NAN6aKGxsomXTErAZL9t/PMiXhfTCOWOKml9ruWBndNYhfGGbGFQCeDnkKY6Zk3RusQkJB7vYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Adoz7MAe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234d366e5f2so70992325ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748956663; x=1749561463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1UO9An8hDPLdThdGt8VWZhztcb+qiPurIajuW+ZKV8=;
        b=Adoz7MAewp98ueadptBxbwv5T3FRtq02Qiyd8e+LVJkdvoDWSgxT5zv8WqrlzfXfFZ
         xZ3nCPA9kVZMwXo/BSDCME0KBpbDeUagoDGYjhZqg6rDEJGdgxCWzGptODlnvpyNQpLg
         czrDNw6YFxz6b7vlJ9pHTIpde9UaDVT/rPbYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956663; x=1749561463;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1UO9An8hDPLdThdGt8VWZhztcb+qiPurIajuW+ZKV8=;
        b=eHJxOqAnPThdIHO64u8IaCsXCX7+Kc6L8YHr5pesaeILrc7b6JJUQccSN8FToCE0vT
         VyJoGjWHCv17Ob0Goy3NbApSYOVn2UgLEhtQImibutCgP/aDughscQLt31uLtkVY8i4M
         HX+rRblFBzRTmy+FNm2OvVOaL4UGjxsO64T18lTzhVn0NRybJIsKIRVHfO6azCE8N1T7
         Ya6rdhDw85hovgU2olhRsOuluQhVxmRmD5xPUScJjFp2Zcl/V0/pFQvv6XTU7wM5e9hg
         d88x/R9tZIwJy9wlmrrbP1Um7ro8juiowS+WHd8EQicvDfS0ZQoakERkETGoqP6wKfql
         bHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbB7lbIaQQJzqQHfEcYsdGpnXWRVTjlA1bqSwpBQpKaMcyA9rF+9yaeOBywPV1BLvocCATr6t5hlJ7PkjG1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzECItkHM9G/mowN8OkLVUOOCG1YSDQQstpWx1l3Z13M1xE7vQC
	bh5KICb2HnPqjziUKdlskmNQx/uPSrXs4Nf45VUs1zURyyFgFiEWcys/QWe2v1JWSQ==
X-Gm-Gg: ASbGncuFgaijFznr8T7T5MzDShj28UtOyacE0/6RRb6gNwhjn1TG/17DA24w8WV/QLn
	OmMCN/2fyxG4HNioCafNzaUSujp2wQs9eyDKoYBNHNjHYdYzWc6HiSUWnkvoZEEftBiznyfJvJS
	eoZelNM2LVEZhkpreo0aBJbDvkBLULph6f2npwZnVmlPzWUy4LfZu3dWaFS9v0oWQ2IgwcHW6OH
	dVn+ilXuHJQwUzSnTLt7vwjQRqzpxDQXtBKOZ2OkFXumq7HTh2e5HbwUpvORAWkitRFb+Z38rTG
	RO8BIicmF8VHsPZO2/BdFRfame6lnQfbWxVHqC+1ocn4i2wQqB2u9nNTiztYqMLM8UNKRCJzcl3
	6B4xJqav4m3c=
X-Google-Smtp-Source: AGHT+IGso/xoHzEOjZpFXtjfx3bJf3Nin/vWa+Jbo4hMNICpA3pKa5Xf/++49R4Ac5V6ORy61L9rQg==
X-Received: by 2002:a17:903:19c3:b0:235:668:fb00 with SMTP id d9443c01a7336-2355fa00353mr197447885ad.46.1748956663042;
        Tue, 03 Jun 2025 06:17:43 -0700 (PDT)
Received: from [10.229.22.9] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdb4besm87089965ad.64.2025.06.03.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 06:17:42 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <wlan-kernel-dev-list@infineon.com>
Date: Tue, 03 Jun 2025 15:17:33 +0200
Message-ID: <19735f0a5c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <5095079184a282ae552c50c8c121a632d51b0419.camel@sipsolutions.net>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
 <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
 <aD7mpkhmQXuN9tMT@ISCN5CG14747PP.infineon.com>
 <5095079184a282ae552c50c8c121a632d51b0419.camel@sipsolutions.net>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to indicate changed AP BSS parameters to drivers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 3, 2025 2:29:54 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2025-06-03 at 17:42 +0530, Gokul Sivakumar wrote:
>>>
>>>> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>>>> 0 = allow low-level bridging of frames between associated stations
>>>> 1 = restrict low-level bridging of frames to isolate associated stations
>>>> -1 = do not change existing setting
>>>
>>> Is that -1 still true? Seems like now it should just be that
>>> CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE isn't set and then you don't touch
>>> it?
>
>> Kindly note that the driver is rejecting the SET_BSS operation if an
>> unsupported AP BSS param is passed by userspace, while the opposite is not
>> true. ie. the operation would not be rejected by the driver, when a
>> supported AP BSS param is not passed by the userspace.
>
> Sure. That's a different question though.
>
>> So yes, the significance of "-1" still holds true, because if suppose the
>> userspace skipped this param in the SET_BSS request, the driver when
>> receiving the request will have the ap_isolate param with the default
>> value "-1". The driver is checking if the param value is >=0 before
>> proceeding with handling it. And will ignore the param, only if it is -1.
>
> Why though? It seems odd. Basically in this case cfg80211 is saying "I'm
> not changing this parameter" but then anyway you check it's value, why?
>
> While we're changing all the drivers, it would seem better to me to just
> change them in a way that they don't look at the value if the
> corresponding change flag isn't set?

I do have a couple of patches prepped for this, but did want to run few 
tests before sending it out. Now that this is submitted I am not sure what 
to do with that. I can send it as RFC so the idea is clear.

Regards,
Arend



