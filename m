Return-Path: <linux-wireless+bounces-30990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9351D3BEB8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3DF335ADBB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD8340A79;
	Tue, 20 Jan 2026 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="gZ2snTkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9C31ED77
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886561; cv=none; b=qBZfmHB5qusFwHaVqvWwKxjCESOJeT2g3kNzAC/to5h/QsqnD5oZ79W28jIU+ajYWN+KXx7BeO4gmOhez9DvVdOsdzurGx8N+s0yHSlhMqAyRSqETC8t5/xxPvss0cA4zvN4sBlKwsNt7UwgBEmSFpGzUhJgHmzjf6otHHkVIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886561; c=relaxed/simple;
	bh=TKi56gVqR9FIzCAxT2fhBIhwhhTOasGefxlZZNLrGqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiNz5mE/IfalHKTPET4aqQNpHdkk3wK0L/P/iV+ZV3IP2K8jNOa52m/rmUuBwnQAgBfidgE3UuJ0lGzg3PJnpM7NN8gkzTH1exoOb5rfnq03132zkQtddD9/Lnce76FKaro6YS/RaqdmrFjiMnx8FgAam6xA4m7MTPoSOuhed+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=gZ2snTkj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e7477828bso2691317b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 21:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768886558; x=1769491358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lseYKAFnM5W7h7JRnSrsox/rPwv4yYCXI+JXbSyzQ1o=;
        b=gZ2snTkjXDqgMFhlleVwVYO/zgyHkQrlygsRPzolqe2ovMzZpbpynpCF6AQk9glnpt
         yAgq//LYhExpjK4xnGuFR+ekWrhYX2OgcjraasByFQv9wzLoFXTr6uiKyrXSTG5A2txr
         M8ocmDdAoR8KjeNTwP0qqEM0FR45kZSxI4SAlshcdJofd5YC/GamCC6rw4HtYv22ibeJ
         w2beQuOf5Wc+FuHNld3y/OpiALrDT8CSnunIsCFlNhwEQeaX0QuBmBBzlNprxpM2b5e4
         fpuvVQtJ5Oo1bgPEYSy2gwSbF5HyexPuiZoOg2Nfh4C9XfXIWX89+W5YHgZ2u5QdwFR+
         71RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768886558; x=1769491358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lseYKAFnM5W7h7JRnSrsox/rPwv4yYCXI+JXbSyzQ1o=;
        b=FYKRAtAdnWwgSJCUf22Kb+MiOUQq3//21pr0VjzRowxFkx9W4tmaJpuaEnNDBDbKUu
         EtmcI+U3wKM0saeayI1I6KRajkQ/aK5LQlGGGa9OOM1Rdy1XaTp3rl4K1iUzJRctR8b/
         FB+sCwUkbfC8jqmk5BvondX0SNgOpS2RCYJa+nowyZy+jMZt+FdSv5Z7XsuCpj/uGE20
         ybhmsOjg3hf+Ny0yPVd5E17+ZIq3d9SRXkwoHQ1jjz0MO0W0AqAa+I2fzUqjNOb3Glql
         e7Q1bo7GodmByr8xei2o9SKI3e5kQqV5FmDHFFe9xmST3kLY6wqv14ZPK+H5mj5gWjOF
         gdwg==
X-Gm-Message-State: AOJu0Yykc9rXuKwOmhj4l9MajP735Uujc9th96Uik44dOY8HKOhuK6fK
	y33wxlzHMStHTtoijQHEAVXIFySGqsMdaGrW6KfD3aAEjNFrmJshqIYwjQ22iR90heo=
X-Gm-Gg: AY/fxX4kQN5NT66Knyc2yLFcSPU5z5FcTyYRXj7iWQbjtzBCc7VrjnRsYJVvviK1jC8
	x+fp1RJxfBD5zYXp08bor0+0y97QxSgnVxHjw4Np9Z5mBv7iEYsVirJHiazNd4x7sAI/BuBP5Lx
	8ER8cdM0VR+fCVRd3eaMMXjEmwjsAyH9OgCOTPjNa6w0xjHtfTTLh7q1dg8JDfmDJx47QOcWovs
	7yF8SAaPaY7AKaKm3jgfWhCVsNE7iGJzq/MLC5S2Q3XLk7CVsCHCNZ1z8/Q1Hm5Gvhz1KCSSKkv
	S6J5vFheOxqhX39/Fjtn6vG0OIir1d4nhjct1L0amme+dZeJW1t9ppSTi5Oym9xk1dp5Y3srULj
	TuZrj8BypUJVuhMzFpIdpOuntyHTv6yaGBmr3TXPVPWydWKSa2kG/NhB5ARIcrm0WDbtHtEC5c7
	awvNjOHlZD4s0UyjVDti2/rK1OqsY1dH5TlLhuWEcp+zIBjK515zpUiSg0PzG+L+49WdGEwbQJL
	MjZAjYrdko=
X-Received: by 2002:a05:6a00:ad0:b0:81d:70d9:2e9e with SMTP id d2e1a72fcca58-81f8f187eebmr13911099b3a.30.1768886558353;
        Mon, 19 Jan 2026 21:22:38 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bda5csm10703137b3a.19.2026.01.19.21.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 21:22:38 -0800 (PST)
Date: Tue, 20 Jan 2026 16:22:34 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to
 S1G channels
Message-ID: <tyreg7kb5ownpgrbcwo72rk5tevk6jpzbthtlqr5z5zykvhaji@wpybm6oversy>
References: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
 <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi>
 <14bc5d3362b071c7c7a6a64724d5b354c173a501.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bc5d3362b071c7c7a6a64724d5b354c173a501.camel@sipsolutions.net>

> > Playing around with some 5 GHz configurations in OpenWRT it appears that only
> > so much information can be conveyed and indeed there are configurations that
> > will be rejected by cfg80211 (or maybe hostapd in some cases, not sure).
> 
> Really? Got an example, perhaps even with hostapd log to see how it's
> rejected? That clearly contradicts what I wrote above which I really did
> believe to be true until this moment ;-)

Sorry, it is indeed cfg80211 that is not accepting the chandef configuration.
Taking a look at the generated config:

country_code=AU
ieee80211d=1
ieee80211h=1
hw_mode=a
beacon_int=100
stationary_ap=1
channel=165
[...]
ieee80211n=1
ht_coex=0
ht_capab=[HT40+][LDPC][SHORT-GI-20][SHORT-GI-40][TX-STBC][RX-STBC1][MAX-AMSDU-7935]
ieee80211ac=1
vht_oper_chwidth=1
vht_oper_centr_freq_seg0_idx=171
[vht_caps..]
ieee80211ax=1
he_oper_chwidth=1
he_oper_centr_freq_seg0_idx=171

This is the result of selecting mode AX, channel 165 with a width of 80MHz.
The GL-MT3000 using the mt76 driver with mt7915e driver (?)

cfg80211              299008  4 mt7915e,mt76_connac_lib,mt76,mac80211
compat                 12288  3 mt76,mac80211,cfg80211
mac80211              581632  3 mt7915e,mt76_connac_lib,mt76
mt76                   73728  2 mt7915e,mt76_connac_lib
mt76_connac_lib        45056  1 mt7915e

And for hostapd output (Sorry I don't have anything more verbose)

Tue Jan 20 04:10:43 2026 daemon.err hostapd: nl80211: kernel reports: (extension) channel is disabled
Tue Jan 20 04:10:43 2026 daemon.err hostapd: Could not set channel for kernel driver
Tue Jan 20 04:10:43 2026 daemon.err hostapd: Interface initialization failed

where _cfg80211_chandef_usable() is (rightfully) rejecting the configuration.
This simply appears to be the logic to generate the config doesn't cover this
case properly. Anyways, I don't think this is all that useful too be honest,
it just comes down to ensuring the static configurations are known especially
since this range is specified as AUTO-BW anyway as per the regdom.

> > I
> > suppose what I'm asking is - how much do we need to protect usermode from
> > this? Do you feel it's worth including a flag that somewhat emulates
> > NOHT40+/-? I know much of that logic is quite old and S1G is "modern" ... ?
> 
> It's always nice to have userspace be aware of things, but I guess if
> it's a configuration that's statically known to be invalid, it wouldn't
> matter so much? But I don't think I've understood the S1G angle - are
> you talking about primary 1 MHz? Primary 2 MHz?

Putting primaries aside and just thinking of operating - eventually we would
need a NO_2MHZ flag as India for example only has 1MHz channels.. however
this is well into the future .. we first need to add support for other
countries :').

But yes as you said since these configurations are static it's not really a
big deal and more up to userspace to be aware of it. I think what we have in
cfg80211 now is good enough and seems to be working well when integrating
into an actual userspace stack.

> > Now on an unrelated note while I'm sending this email, we've sent a few additional
> > fixups / cleanups over the last 2 months as we hope to have a driver submitted
> > for review in the coming weeks. There's still 2 small fixes that need to be
> > done within hwsim before we can send up our hostapd patchset but I will
> > wait until we have at least kicked of the driver review process before sending
> > them.
> 
> Very cool! :)
> 
> We just posted a lot of hwsim changes for NAN - better send yours sooner
> rather than later ;-)

Yes I have seen, lots of Wi-Fi 8 documents aswell so I assume that will get busy
soon too. Well see .. Lots to do!!

lachlan

