Return-Path: <linux-wireless+bounces-26959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15568B41261
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 04:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9698207A53
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 02:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953D12CD8B;
	Wed,  3 Sep 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="rTwocrew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85C16FF37
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866816; cv=none; b=gCNu7kmWNT+VBjexXUrVs8S0QsShojpqJi8j8yVd+YUpvl5z2613LjsK2cu9GRIY1zu0El9NPZreJszpqtXX+m5yhUYGu0cvNUHiWBnm1f9qCHMVd8pHT3879oCv07s0xnPrkIAadIfwZzb+dRKpm1jIxgglw9exbqccuYF/MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866816; c=relaxed/simple;
	bh=YQ/9MwHKqNWSWsrgMZiuoWgsJIZpDS4D0B6rZato/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRsz3OxOs62/QMKcRfxjy8b11BzXIoBOvg0EBkZviyzZDcJnFW0mLXYF3LZYEmr1TlceJhs1LInq3KAZYvUowUFn993vxe48JIChx4jAnYGyfo+E50F/SV+Y9St8fKNbnt3Ry5TKNs7wZyw3e8xaMMer+nDfihAkIsWUXfgjSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=rTwocrew; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-327e5b65e2cso4012989a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756866814; x=1757471614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LdrmIOMJu7DyOFq6sPxM83Va4V/PzAz8GEAErTubVYw=;
        b=rTwocrew90RW5+Osk2m9CUoLtU29MLTuUmWY9rYgBgQAqYVSeVgV9Zzh3Msu4pDX9N
         gqsDJnhHZj89AWPu/1GF7k1i5yjwAvQ/w/AvWFj4HKf6m2S5zPYohknbZY6cfZUGOiGz
         7WCyJFpbuKyTziW/joSE/TgPMOKMia20/jpD3DeqbsUvdJ28YDYZbcU3uE0fD88mNN1r
         rtDSA35FE9FOpgvt3vjEXglxjvyyPmOL3VwoTJe5mFRpZHepaYgfxdS0m/2Rr0KdTsVJ
         dTjlP1QhMSzl03VEmkbGOiLXMFggU1GD7uC+ZW0XVsiLJI70GwbsWYWdPQbi036Lmeuo
         ZvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756866814; x=1757471614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdrmIOMJu7DyOFq6sPxM83Va4V/PzAz8GEAErTubVYw=;
        b=L8b4SJxLjnDQa1yrZqY9jbhsO32HXh9CIZ0iDBXnSpgpUxWMCTz4f5+uW+xDFhiGWR
         tl+HFGzLjVq/UQeisOcy/nOV+rLruOY3krwjwBZqJDjD4nVkLEUlLEHGJvNhTrHcd/P6
         41eE76de09wWMiJvCpE5HtxjIPF4fuTfbXIqyVn+cSdHhzeayTS749c+73kXcqa7cRZs
         LDEHVSRxceofkkt7Q/OsL/nLHrooYWG0tT02h9fvOneSrHMxCzFnSRM/vOPz2cNMZ+Z2
         PA0wuX5jPhR4CeApmGluTmrmQpP3m7Rye31NhcvGBQs1kI5kKLAbsirgUBegK5rBP5ZC
         j7FA==
X-Gm-Message-State: AOJu0YyXCH+Piim5icTnxJfC2kpC2ut7iGk+mICmky2w+vFfJcAvIVdC
	K4p1jogsJD9N0W+5yOBOTfnoc83FCXKe7Awl/0jAteyhdy5dMvQWNWvRzQ/jhp5stUw=
X-Gm-Gg: ASbGncsLs8cuwGpBwcK0Kamv3Yl4/xTHB1Qcak/+upgYEIeFBKgqG7+cHGFaqEdHpMN
	m6OOQrvqrOL3t+N6Gx1zNDoDyx1m2ittI83y5PjPdybIrc94kC6wan2+LA//8yW3CWdii52QBFg
	uGSYMFP4uisj+NEpWZNLf/qPiK8j9GjOtJ79Rl8Pz3MrJRHirIJT8D4ZsCeZnn/JM3UaripHuCK
	hVOazGN/18kW4BwX9MLdKGAxMgVBvz+Ijbj4H+7RZgapbu11Kt1LdFS8KPB3+DbxImRU9OmsUab
	++M3DbBVvHSK2BX0oA9O9bywzLUih+tAEnmfLiwE7nAh23BkqbCZFS4Es+7HxUJhGerHbflOZWR
	qN/6EXWy0MefYAofEK5LZGA8Vuw4PVI8txhdMGXx/gSkk0nlVZee1xJdGilUMEc/HNyDYtSE4zd
	g9UfkkCjc8mfD2ubpqERg=
X-Google-Smtp-Source: AGHT+IElSHoMvLtU2UHE0Ui+93FZF1UBbtJQ0yxn75uj77ORX6i9QTBqmCq5J1KhgT2zFxIsO6vHTA==
X-Received: by 2002:a17:90b:1649:b0:327:a665:da89 with SMTP id 98e67ed59e1d1-328156b83b2mr19566234a91.18.1756866813681;
        Tue, 02 Sep 2025 19:33:33 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd33c1sm20662785a91.17.2025.09.02.19.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 19:33:33 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:33:29 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
Message-ID: <byajqzqa2qqxh7l6kul7pxzt5rn74hiwln3rpkcfytqq6fw2ml@wszpdqibci4t>
References: <xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
 <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
 <9363e3a700565a34145be7268deb0a8623f659ba.camel@sipsolutions.net>
 <ab4ea03131cec7847b31eb548881ef79da4ae1c5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab4ea03131cec7847b31eb548881ef79da4ae1c5.camel@sipsolutions.net>

On Tue, Sep 02, 2025 at 01:36:02PM +0200, Johannes Berg wrote:
> To maybe describe where I'm confused more clearly:
> 
> > > * ->chan points to the primary 1MHz or 2MHz channel
> 
> This was based on something I said. When I first read it it, I thought
> this was because 2 MHz primary channel was a completely independent mode
> of operation of the two 1 MHz frequency ranges that make up this 2 MHz
> range.
> 
> But maybe that was wrong? Because you also said this:
> 
> > > As mentioned, the one difference is that S1G primary channels can be 2MHz.
> > > The standard (and by extension, the S1G Operation element) uses the notion of
> > > primary channel location. When we have a 2MHz primary channel, the AP must
> > > specify which 1MHz subchannel _within_ this 2MHz primary channel is used.
> 
> So this seems to indicate the primary channel is always 1 MHz?

Not necessarily, in fact most cases we use a 2MHz primary when possible.
In cases like this, beacons are transmitted on the center frequency of the
2MHz primary channel (And I realise Im just saying "channel" again). This is
a composite of 2 1MHz subchannels and we then specify the location of the
1MHz subchannel and advertise this to STAs (This is done in hostapd anyway,
so not really a concern here). With the flag you suggested below, this is fine
though.
 
> Looking at the spec, the S1G operation says you have _both_:
>  - the primary width [B0]
>  - the overall width 1/2/4/8/16 MHz [B1-B4]
>  - the location of the 1 MHz primary inside the 2 MHz primary [B5]
>  - the overall channel center frequency (as a channel number)
> 
> So something like Channel 44/8MHz with 1 MHz primary in the upper half
> of the primary 2 MHz would be
> 
>  - primary 1 MHz	width B0 == 0
>  - 8 MHz		width B1-B4 == 7
> 			(? Table 10-41 S1G BSS operation channel width)
>  - primary channel num	38
>  - channel center freq	44
> 
> 
> But I don't think we necessarily have to capture this the same way in
> our chandef.
> 
> We could also say that the 'control' channel pointer always points to
> the primary 1 MHz. Then, we only need a single flag in the *chandef* to
> capture the whole definition, in this example:
> 
>  - chan: pointer to struct ieee80211_channel for channel 37
>  - width: 8 MHz
>  - center_freq1: 925 Mhz (== channel 44)
>  - s1g_primary_2mhz: true

This makes sense to me. One misunderstanding I had (that you brought up in
the email before this one) was that only 20MHz control channels are advertised,
for example, with VHT. I think I better now understand the structure of the
chandef (hopefully) such that now the driver would advertise _only_ 1MHz
control channels. Then the flag can indicate if we have a 2MHz primary and then
the actual chandef fields can describe the wider operating channel.

> All the locations automatically follow, you just need a little bit of a
> helper to calculate the "primary channel num" for the S1G operating
> element, since that's now no longer obvious - but basically just
> 
>   if (!chandef->s1g_primary_2mhz)
>        return channel_number(chandef->chan);
>   BUG_ON(chandef->width == 1MHz);
> 
>   ... depends on width and distance between chandef->center_freq1
>       and chandef->chan->center_freq but I'm too lazy to write it down
>       since that also depends on the _khz bits. something like
> 
>   diff = 1000 * chandef->center_freq1 + chandef->center_freq1_offset
>        - 1000 * chandef->chan->center_freq
>        -        chandef->chan->center_freq_offset;
>   diff = abs(diff)
> 
> and then take the figure you had before into account:
> 
> >    |------|---------------------------------------------|*|
> >  c | 8MHz |  |                  44                   |  |*|
> >  h |------|---------------------------------------------|*|
> >  a | 4MHz |  |        40         |        48         |  |*|
> >  n |------|---------------------------------------------|*|
> >  n | 2MHz |  |   38    |   42    |   46    |   50    |  |*|
> >  e |------|---------------------------------------------|*|
> >  l | 1MHz |  | 37 | 39 | 41 | 43 | 45 | 47 | 49 | 51 |  |*|
> >    |======|=============================================|*|
> >    |******| 920  921  922  923  924  925  926  927  928 |*|
> >    |******|---------------------------------------------|*|
> >                            frequency (MHz)
> 
> 
> That should work?
> 
> 
> Then we also only need struct ieee80211_channel for each 1 MHz channel,
> your thing with the regulatory "non-primary flag" also works more
> easily?

Yes this works. If we have the s1g_primary_2mhz set to true we'd need to do
some validation that both 1Mhz subchannels dont contain the NO_PRIMARY flag,
but that should be fairly straightforward.

These emails have been very helpful, will go ahead and draft the patchset then
probably send sometime next week for RFC.

lachlan

