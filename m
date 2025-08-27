Return-Path: <linux-wireless+bounces-26677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB34B37A1A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84A01B6342E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52721239567;
	Wed, 27 Aug 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ix41X8YB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211424467A
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274433; cv=none; b=gJsZosmiovhk3ojMIsfGc0c6SrNCEsgeQVafgdz5fWA8f8QaBbyDVymGKw8Pouy8payh52sk/yg8HMQXtULgC4W/EpxJEVXdcruR11aEyq1Tr3D3rb2SBwcE7jrNLRotf0jodcNO+SNgQS/R25yM+uqEhX1miB3kwcBKuJy2Okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274433; c=relaxed/simple;
	bh=a7fiD53HY9LR/WHNKstFdnh8gBx+5iF39uEUNg0VB6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbJsdSRhvcww5fYYeDDzzvIc6oG5fLWW+PkbGDNyNY0rtrH8ihoLRaUkoiZJ+3BA4yZRdqhGRktGELNIDWvotwG0Nr7GXdv+Gii9nxnVi89LMJK3lFeH++grcsDI5GoIYv3hBtmtmS6q4mfADRrlSavbur8h8zx3IuMG0BgQUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ix41X8YB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-246151aefaaso5034765ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756274430; x=1756879230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HUiGVNvbIKTNFzDxNQYko03DQ+PMfUIWvNoNcmJQNo=;
        b=ix41X8YBZeauQUx6Uxz56PtzaL33HXCW5Tgl9yWBpGGvvJ793W78aTaT70+Uhm3JEN
         dtVXmieTRaKWONZyKO728ZOt3NBPgyfIqoJ9N51tpC/dJehf90R+UoLxYVfgUH2+xiRF
         Qa+EXAUHCLDJlSN+LHKgDgs0q2UoxuaqF54W7YFu1p4P4O25BLYFR8SUlybOBQV7o9u0
         Bdnxgj0ZfVMUbV3IS3E3gK9nCODCqLZEBzrsdomr2+Da8PWWh64XcDUtq4VFLnc4tLpy
         8JkDxc3wR5CRXyzOUZSBLYg0jNZ6+sYhzJuC9TPBAU6BOJJhRwTV0KiFPuyAsbTLK1Gi
         YC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274430; x=1756879230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HUiGVNvbIKTNFzDxNQYko03DQ+PMfUIWvNoNcmJQNo=;
        b=sXWdeoQeZMa3ducIwF+KK28yveM7rTbcpQG6FNwu4U9C6fsgCHFzTjMIoyu2omGKZH
         IWwwbt/FO5hDk0qlWz0dFZuVwfDbxlxWUx8udgsaYyGZEIL3Bf7iFGLxsD4QTCcxkcLi
         dDEztmSeURsNivUfSu2GrBMViXrV9VZdrw0eySSGW9hDBcGEtnmkWFsDPhcITvFJapwC
         doqVol2YHbNBbMj7UKs2shwM1pihsJfxKASFMDHLElI09IyzRGmuXNp24Zx+/LZJy2gi
         mQVCze2f4yX6cuIPVvUnZgEnpfKjpoui3TUm8/eYib7P45QVz7TIH6J4Zfe1Cpvk/miG
         GN2A==
X-Gm-Message-State: AOJu0YzBklJ/wGrPjRR/L2rBkg3tzw9M0Uj7GMHqGPcVpTcSJaz9Y8tt
	LLM4YJPeVhq/4O/5dpn5gC0xe6GlULRolHCYHByQ4xbebbqOxi+W+qVBrB/nk0Vj1gQLYx+vPjp
	Z7f5e
X-Gm-Gg: ASbGnctgvPGdGdmmwWf1ID0MQasHHd5Wo0Cb0qHEHytfTDZTSZqM+s5g1cJStaP6W2+
	uwxtf4COZFL/BH9GMCOd15tk7o378NPAdXVu/+lf5U5womsdTmPZSv5Q37ujpobh1KiGKjI5PsE
	25X9LRED395VeVxI958GaqiRaOy6SP0eyltM6GPq/WGtCl6TYkOH8INvCxxG83q+OIxDzkKAv0F
	8+HRJciBuAlR6UqAQuQfOUYM1N5CN1CyFSTqFJfpH/KLtzQl9FUVSSTNEkkwXZdBg3/NrJWINOL
	t9lu+CTXpgCvsOmMdfheZKRjVssRpPE30WdsGvTuIwnjtDF5JEPvtJFz4MlGVmvjUU+Mua217bz
	TZJOHe9C/W2KJDwTijMNLirzSu+/UwJ9DcIxjSL6DaDURFN8rCGWwTtMKMBoc8KfFl5alYrqv+Y
	s=
X-Google-Smtp-Source: AGHT+IEk5EqTW0bZMYrLlBLRQwjMRTVuOAvHQMd7OnZmOG2VehXzqwTXIb/GgP+EbQmFvgqjdxmDTw==
X-Received: by 2002:a17:902:da84:b0:246:80ef:8808 with SMTP id d9443c01a7336-248753ada95mr50742365ad.3.1756274429880;
        Tue, 26 Aug 2025 23:00:29 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668896cb9sm111917225ad.133.2025.08.26.23.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:00:29 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:00:26 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
Message-ID: <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
References: <xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>

On Tue, Aug 26, 2025 at 08:56:21PM +0200, Johannes Berg wrote:
> > The channelisation of an S1G PHY consists of two components, a center
> > frequency and a primary center frequency as per IEEE80211-2024 23.3.14.
> > The center frequency is equivalent to other PHY types, being the center
> > operating frequency for the operating channel and the primary center
> > frequency being the center frequency for the primary channel.
> >
> > When an S1G PHY changes channel, it requires both the operating channel
> > and the primary channel parameters. The implementation of this will be
> > briefly mentioned at the end of this email.
>
> How is the primary channel in S1G different from the primary channel in
> 2.4/5/6 GHz bands? The widths are multiples of 20 MHz rather than
> multiples of 1 MHz, but it seems pretty similar otherwise?

Ok so reading below, I think the only difference is that the S1G primary
can be 1MHz or 2MHz. That shouldn't matter though, see below

> > and must exist as a primary subchannel within the operating channels band.
> > Using the sample above, operating channel 44 can have a 1MHz primary of
> > 37, 39, 41, 43, 45, 47, 49 or 51 and same goes for the 2MHz channels. Whereas
> > an operating channel of 40 may only have primary 1MHz channels of 37, 39,
> > 41 and 43.
>
> Again, very similar to HT etc., which is all captured well by the
> chandef today.

Correct, there is only 1 new field required, that being the primary
channel location. Ill describe below.

> > Proposed Solution
> > -----------------
> >
> > We propose a new flag within struct ieee80211_channel_flags called
> > IEEE80211_CHAN_S1G_NO_PRIMARY or something similar that tells the
> > wireless subsystem that this channel cannot be used as a primary channel,
> > but is not disabled. This is an important distinction as during subchannel
> > validation, if a single subchannel is disabled that operating channel cannot
> > be used (similar to VHT and other PHY types) but an operating channel can
> > be used if an edgeband 1MHz channel has the NO_PRIMARY flag but is _not_
> > disabled.
> >
> > NB: While the existing for_each_subchan macro doesn't work for S1G channels
> >     given its fixed step size of 20MHz, this will be updated during
> >     the implementation.
> >
> > It's also important to note that this can only apply to edgeband primary
> > channels for the current regdom. This validation will be performed upon
> > advertisement by the driver of the available channels for the S1G band.
> > Additionally, puncturing is not supported for S1G.
> >
> > This will be an implementation detail, as this is not explicitly described
> > by the standard, but rather used by vendors to ensure FCC compliance.
>
> Hmm. So first I wanted to say that this totally makes sense to me. But
> actually I'm not so sure. I mean, get the restriction and why it's
> needed and all that, however, we have to consider interplay of various
> factors here.
>
> Consider the difference between AU and US in the regdb (the only
> countries currently listed with S1G support):
>
> country AU: DFS-ETSI
>         (915 - 920 @ 4), (1000 mW)
>         (920 - 928 @ 8), (1000 mW)
>
> country US: DFS-FCC
>         (902 - 904 @ 2), (30)
>         (904 - 920 @ 16), (30)
>         (920 - 928 @ 8), (30)
>
> I'm not sure which operating class you're applying to get those channel
> numbers in your figure above, so I'm going to have to handwave a bit.
> But assuming such a restriction also applies on the lower band edge
> (OFDM is symmetric, so it probably should) then you'd have to disable
> different channels in AU and US regdomains, since one starts at 902 MHz
> and the other only at 915 MHz. So for a channel that's between 915/916
> MHz (which according to your figure I guess would be channel 27?) you'd
> probably have to disable it in AU but not disable it in the US?

Correct.

> So I'm not sure statically disabling the channels from the driver works
> unless you assume there's no regulatory domain involved or anything?

Right now (as since I sent this eamil I've written the patchset) the firmware
notifies us of disabled primaries, so then driver would add the flag to the
selected channels before registering the wiphy.

> If I'm right about this, then perhaps it should be expressed as a
> (wiphy-specific) "primary channel band edge distance"?

This sounds like a reasonable idea, looking at handle_channel() we can
move the flag setting to reg.c (where it should be). This is a region specific
value as you correctly pointed out - the channels that will be flagged are
different in the US vs AU and so forth. Rather then commenting too much now,
we will explore the idea and explain what we end up doing in the initial RFC.
The main idea behind this email in the first place was just making sure the
flag is OK to be added, we can work out the implementation during the review
process.

> > Primary Channel Representation
> > ------------------------------
> >
> > One potential challenge with actually implementing primary channel support
> > is how and where the primary channel is described. Initially it was thought
> > that a channel definition could contain a separate struct ieee80211_channel
> > like such:
> >
> > struct cfg80211_chan_def {
> >         struct ieee80211_channel *chan;
> >         [...]
> >         struct ieee80211_channel *s1g_pri_chan;
> > };
>
> Just off-hand, that seems awkward.
>
> > The obvious problem with this is that now a channel definition describes two
> > channels, though you could argue that to correctly describe an S1G channel
> > you require both components - which in some regards makes sense to put them
> > both in the channel definition. It does, however, require various API changes,
> > with the biggest one being cfg80211_chandef_create() to accept the new primary
> > channel parameter. An alternative is to create an S1G specific chandef creation
> > function which can then call the generic form.
>
> Yeah, but not even just technically awkward.
>
> It's also a complete deviation from how anything else works, and you'd
> actually have to have different channel structs for all those
> 'aggregate' channels like 44, which we certainly don't do for EHT. If
> this is the wrong way to think about it in EHT, why would it be the
> right way to do it in S1G? Even in EHT the whole channel is "44" (to
> stay in your numbering scheme), but the full channel is expressed as the
> overall width/center_freq1, and the control/primary channel is the
> pointer to the channel struct, and channel structs only exist for the 20
> MHz channels.
>
> > Additionally, we can reuse cfg80211_chandef_valid() to perform validation as
> > both the operating channel and primary channel exist within the same
> > channel definition. By extension, many of the function that operate on a
> > chandef have access to both the primary channel and operating channel.
> > Definitely something to consider.
> >
> > The second option is to treat them as two separate channel definitions. This
> > is probably more "correct" as after all a primary channel is a separate channel.
> > While this approach doesn't require many major API changes like the previous
> > method, it still has some negatives. Firstly, the need to carry a separate
> > channel definition in various places. Taking struct ieee80211_chanctx_conf as
> > an example:
> >
> > struct ieee80211_chanctx_conf {
> >         struct cfg80211_chan_def def;
> >         [...]
> >         struct cfg80211_chan_def s1g_pri_def;
> > };
> >
> > When building this new channel definition, we probably don't want to be using
> > _nl80211_parse_chandef() as it relies on the NL80211_ATTR_WIPHY_FREQ to find
> > the channel, where the primary channel center frequency will rely on a separate
> > attribute. Now we could, of course, add in another branch to handle this case,
> > but the function seems fairly overloaded as is and would be good to keep the
> > S1G specific case separate.
>
> I'm not really sure this is all that much better?
>
> Why not do it similar to what HT/VHT/HE/EHT does, and have:
>
>  * ->chan points to the primary 1 MHz channel
>  * ->width is 1, 2, 4 or 8 - which already exist
>  * ->center_freq1/->freq1_offset is the center frequency of the entire
>    channel (e.g. 924 for channel 44 8MHz, or 921.5 for channel 39 1MHz)
>
> This doesn't capture the fact that the primary channel could be 2 MHz
> wide, either we add that as a separate channel struct (not sure?) or we
> just add a flag or something? TBH with how this was done I always
> assumed the primary channel was _always_ 1 MHz wide.

So you are right, I re-read the VHT channelisation and also the chandef
and everything is there except for the primary channel location (will get to
that shortly). Fleshing out your example:

* ->chan points to the primary 1MHz or 2MHz channel

S1G channels contain the width flag (IEEE80211_CHAN_1MHZ/2MHZ) so that
can completely represent the primary channel. This channel would then
be required to exist as a subchannel within the operating channels
frequency range. (I assume this to be the same case for VHT / EHT etc.)

* -> width 1/2/4/8

This would be the operating channel width, channel 44 would be 8MHz.

* ->center_freq1/->freq1_offset

This would be the operating channel center frequency. So for example,
channel 44 would be 924MHz.

As mentioned, the one difference is that S1G primary channels can be 2MHz.
The standard (and by extension, the S1G Operation element) uses the notion of
primary channel location. When we have a 2MHz primary channel, the AP must
specify which 1MHz subchannel _within_ this 2MHz primary channel is used.
Now Im inclined to place this in the chandef, as it's a value used to
"configure" a channel... :). Anyway, that is an implementation specific
thing - we can clarify that during the review process.

lachlan.

