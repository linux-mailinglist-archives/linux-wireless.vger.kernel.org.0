Return-Path: <linux-wireless+bounces-23365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03462AC231F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6E616C1C3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A999EAE7;
	Fri, 23 May 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eozYbqy3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091C2BB15
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004857; cv=none; b=eOY9kMmzuL4ELynBkp1E+bP2tWefBXDXbwa2ppiAwZ93z6OmUWRoVFtkj/hGplWohb4psj9FyVoD3rKo6fs+xb3+e2ZFZLr/178wJ1CCQgg+EPAPMHbG3cnWF7g8tkODEizWxAhZhe42csvTPD9CBy1LVbeITcCtixZ6abKSPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004857; c=relaxed/simple;
	bh=Gk3cofDhFY6qdYdVoCbrR5V4VFdfVsfiwWQ4H0rQp8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GDerz0quKKOFFn7tQcOtysy5/ff1YpO5ueppjJij1PRO43iiZsGjwMYi2cCZKJqRiUwQVJLzi+KX81f8T2UUa9sYAzVFKbRYe8M2HV7Sqpp07654hPGbRb8UYazvyipvO6LajNNedfnHzL9IGxcwTEAMPFRxT3GvDiro1w1L2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eozYbqy3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-310f082a677so340520a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748004855; x=1748609655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3t0/4AQw8Vu1T6H0cm+6ZsLDGgCE6oBI6ib3cGfYqo=;
        b=eozYbqy3Y7eZch1/x3pJWbOUX7kOcJ4HrTCRtwdq+emZaUPbf7268yxc68AB3MHonG
         QpSwrXDjlr2ci/f3d0HJhJZEJriXNlSVGr1+jvi+jxn9oMuHv1jzQ4FdVOqTW8d26p0x
         gJ7M0/CDaTodD+9aBHQS0rN9OSYISRXHf0jJst5uetei6EvuFbl+780aZ40eOyINPFI3
         ZA0lPzs8l1pAqzi/GqyH8yEcKJFGl8WB5zzbKpkxWV5LBNhi3iGQhEHdWJlafWw9o0s2
         K1h/JPqqN3CbjrNwHaDH0ndJ438iz0Ddw/GYfBRr8MxJ9qGyL0J70ZRjJSnpMw+tSGFU
         d7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748004855; x=1748609655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3t0/4AQw8Vu1T6H0cm+6ZsLDGgCE6oBI6ib3cGfYqo=;
        b=JsgD5zSi4ZT6+X0T+5vuOQ89jcZbi7Z5114Z6qwLMMK9GaqVFY+9GAKdC9wrMZlwsm
         QiOaBjupEmAeBSVgI5gDQfwE4jugLZ7c2gMGLkYrUN2F9LeMeLm2e10NGtFExl9U1atO
         5zrXOaaKlnbs+HlTYEdjI7iP67yB5GZjYxktE5gFy6WESLy8Svp83TmeBvQMfdEqBwUE
         ze9Rn57CeiFDYu8Xv2vyYrXVtrQZD+epUCYfegEwmWfTy8u363qDDwwCgd3jcAqx7l4Y
         xlTlAjY/ih+U0X0+1iebqNJC92lUwbqoHVklSY5tvx2IbkNpp1Kqys0NnKogRL6MFehQ
         7VjA==
X-Forwarded-Encrypted: i=1; AJvYcCXDzu3RG4Ks7E6QKy1zdTBUvsCkCvC+HdEOUfsDTZLhlhHtnpfFHV+PIB9TokFG3Bp77X8qDxWAxkmprW/cZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPVoFTY0tsBGDO9ECCtM3YuzB2X9VNBQAWfgSj6aUFq9D5lMf
	jH53PLLcZlGEvQxWzqMuaA+1pSFGwgU3j+h4Jfd0zpMTtJeCqpXHf2I1Rwsm7g==
X-Gm-Gg: ASbGnctHEZwQCYqNLonYw6+8Ec3IYqQ1PLt4f3piKdGFTf0caYM2giOHjegWPoN4Atq
	qlkLED8RUO6DW7fcfjjjr5eQmMP4MEl7rqe4oThpXMsSkRy9cCeWk3JzWvpjeXMsK5BSLzomfOE
	gfpsfJhqKgAjzXou4FkDTRtotazBDrHEz9lb4KEgoEo7Jmy3ApX6r9ZgIiAsXeTbLN7bbQiJNqW
	oBn4N1I3VB2ZvHsPQOllEL/OexyGToXwPhyYplAUa9o+IpqEV8B7o8SiQn7fdMEfV1sJ2r6jLHc
	dCFjCiqTsGX0SgZSW+vznjy6qxd7l/FfhMle4opoUFHpJSS3fHsnIdBYUWe/h5El0cWCegyPWmL
	LjAl/6CaUc0V6eLOfnxJniq5HFW6e7tyu5Kg1B3rE
X-Google-Smtp-Source: AGHT+IGK0Kw8OVLPL6W7EPTHZTteboHegBzaua4pGrVbZc0qwFPE8KkRjs1biCbXD10ixc9lL2N9CA==
X-Received: by 2002:a17:90b:2e42:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-30e7d5acb46mr38551558a91.26.1748004854782;
        Fri, 23 May 2025 05:54:14 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d4599sm7255083a91.28.2025.05.23.05.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 05:54:14 -0700 (PDT)
Message-ID: <1b442183-1b73-4461-a9ad-14c1980bbc43@gmail.com>
Date: Fri, 23 May 2025 05:54:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Association comeback delay behavior
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
 <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
 <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com>
 <e5241e83e7675a3db309c9bdab378549ee27ee45.camel@sipsolutions.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e5241e83e7675a3db309c9bdab378549ee27ee45.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/23/25 5:34 AM, Johannes Berg wrote:
> Hi,
>
> (uh, please trim quotes)
>
>>>> 1. The kernel takes the delay in the association response frame and
>>>> waits, but has no sane bounds for how long the wait is. An AP could send
>>>> 0xffffffff and the kernel will just block for that entire duration.
>>> For some value of "block", it's not really blocking in the (traditional)
>>> threading sense of the word :)
>> Yes, true, its not blocking the kernel. Just blocks userspace unless
>> that event is handled, which isn't handled by any userspace supplicants
>> AFAICT.
> wpa_supplicant seems to handle it just fine? I guess in an ideal world
> we'd have made it some kind of opt-in, or the supplicant would've given
> some sort of maximum wait value.

It logs and returns:

static void nl80211_assoc_comeback(struct wpa_driver_nl80211_data *drv,
                    struct nlattr *mac, struct nlattr *timeout)
{
     if (!mac || !timeout)
         return;
     wpa_printf(MSG_DEBUG, "nl80211: Association comeback requested by "
            MACSTR " (timeout: %u ms)",
            MAC2STR((u8 *) nla_data(mac)), nla_get_u32(timeout));
}

Its relying on its connection timer though, which is why it "works". 
Opt-in or userspace providing a maximum is definitely a step in the 
right direction IMO.

>
>>> Oh, so you're just trying to sell us a missing implementation in iwd as
>>> a kernel security bug? :-)
>> Depends on how you look at it I guess. Handling the event in userspace
>> almost feels like an escape hatch for the kernel having used untrusted
>> input but that's just how I see it. Waiting 15 minutes for a WiFi
>> connection that should take 200ms is on the level of absurd and
>> unreasonable from my view, but that's just my opinion.
> But it shouldn't take 200ms. The comeback can be larger and you may
> actually want to wait for it if you have no other choice of AP anyway.
> Sure it takes less than 200ms to connect in normal cases, but comeback
> already isn't an immediate connection. Whether that then is 15 seconds
> or 15 minutes - sure, the latter seems excessive, but I'm not sure I'd
> want to define a timeout somewhere between there. Given your
> argumentation it sounds like you'd say "1 second is excessive", but
> that's just under the _default_ setting in hostapd for
> assoc_sa_query_max_timeout.

I'll admit, from a single AP use-case if the AP _REALLY_ needs you to 
wait that long you are right in that we have no other choice. I question 
under what circumstances the AP would need that though; when your 
talking on the order of minutes or even 10-15 seconds the AP feels 
broken at that point. I'm also not a vendor and don't know what 
conditions would even trigger this in the first place. Maybe this piece 
of information is what I need to convince me either direction, a 
legitimate reason for an AP to tell the station to wait, and an amount 
of time that would be for.

 From a user-experience point of view I think most people watching their 
device trying to connect for more than about 20-30 seconds is going to 
trigger a "wtf, this is broken" response. And I know if my router was 
taking that long to accept connections it would be promptly rebooted. 
Its a long way of saying that I think there is some reasonable value here.

Thanks,

James

>
> johannes

