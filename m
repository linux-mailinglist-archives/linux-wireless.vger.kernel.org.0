Return-Path: <linux-wireless+bounces-26929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C933AB3F81B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 10:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62437B35C8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E31400E;
	Tue,  2 Sep 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="z9LO6N1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0512E7BD9
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800879; cv=none; b=Wry2wjr9p2jl6Fy7UyZxg0QlCw1FoKqail4m/bZTr1iOt2NDPKTxkmC2l5Mevpb8qD5vyhqSy6AEQwAboD6j8/SHDBvGJT1SiXTJRjv2tkfTHAiyI/wulr+rr2FH+VHtDC0nSIx/1TX+X5Bb+ncNJHvELzE+J7XfOPsPOXWSBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800879; c=relaxed/simple;
	bh=0WHBTrp+NQ9AaYkm39w7F8RIafudZJzxO6GskJANTzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ylaGQ77xWUgO/BzrvXzA1H58S5NC6gbi2Hv5sbhQIyZHEuQbYt+Ie5T6SfDyjsvNBRbGzVRWAb5ATmvHCLsXlRZAhEcdH0aH/PnXTGIbhiwAhbXq05qBSVGmJBXh8ASLRrMJADvum0Tm0hzLAM00j7VZhrmNjmQYaIRLLgbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=z9LO6N1r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2743208b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756800877; x=1757405677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6n5vrn7Gv1rAG7LegoStASNctVv5qfAF2TnNGl6ok7k=;
        b=z9LO6N1rQb5459KnNc3bUi8/oIOHUDBpzUWCgO39c/rGBXcUli33talSOpQE8NsSBw
         h1qbVQnMAB4wHtgKBZsvwNCnhSSNdMzyM8OEr2BYoqNnid9LyQD/E7GGUeKaN0QWE0op
         /cD+aAf1m6dAZFdtwco/X3Rld7UbvaRMfyfIYjbMu5S6CyTTICiRkIFjzfv8rwrS83Ug
         0bwU8b36u0Ro0Eoa9LAXN9lL9OFBMGmuIIbgTHJlQjgc9nUqY+iAi7BML5TDwzFkEMrY
         YlaC1xQCS8jBQOCN/oMCits+xCrQ1Zy2vKsD/caYiObT6XSyoXS7WA5GuX8sWcjTXZAS
         6Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800877; x=1757405677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n5vrn7Gv1rAG7LegoStASNctVv5qfAF2TnNGl6ok7k=;
        b=lNmAn1cJNO9db+SQd30YG8WQ6ggnzlzZQL49n+N6RKIFjMDWzSywSMOmhOocwVhGV7
         Eo3oZyvXGtBXyygS49j1c9LxnE65tE/ZJVir0Ipwi01yp33jkpEa//yoRTYkmZUkafQL
         Tf171rkn8rOA22e12IHXzlgXyytkB/Fi+6mL2X+/UDUJTW2uN8if8eACx4QIVzY5z3zU
         JSrNt5xGgXuW9VBni92D07cgMeuEndPDPvQZSZX62QDuTwpaXwqKP1luBhKi3f8YyicZ
         bDBiwZs9nrE1rcpUsoY+JgA2ke879UgCgjAs/tbnweGLgDUqTfRTMinUX0XszDd7IsNO
         L3fA==
X-Gm-Message-State: AOJu0YzJsm6/tbzytk+EGnh7zq4rZUeJJDLaICUfu+hgPGauOImkyxhw
	wT4SpVypCf9wzqz2nBwcSaFW2gZqTOIMTMN5ORn6XEnMd8jlK8mgdpSlbpLcv091ntw=
X-Gm-Gg: ASbGncs5H8GJ3R4cic3P9MiSrdvq5Nwtp7e5VswX2Yho/UddFJrEeDAXYVxBvXPzDQr
	Hzntbu5/pJDHb9PT7tvRlDP3AK2tiZ0BkvV0pdDs9mCI7arf5FZBZF/kmZKNApweAaP7WYmpX2M
	MJe/OmeOtsXnPiJrlCF+PHbxtJRlmRvfaMWIfSmk8TljBAqCkSSkc4NeeuAhD+1VShZNULoww59
	bRPJ9uJl7/dGZdyF3nYsTJ/AnJDX9cQywiXJKLr7s5rJ7qgReNod1HnDa4cKONLmTlI+PJlqw88
	dHzSjxOmXLCGwA/9pDWn3phpctxfWLc/HQg80QrgZgih6hqOdbDVn7go5jNbbnG5SYx81Sf1Vwn
	1DiftO3znHeoReWIoKE1apV+iJM++cWTcPwpnh+0jtrqzGZD0GF5Cs61q+tdheL22bSQw2kfc+v
	YrIYAWTcvB7Z1eaIGrzCs=
X-Google-Smtp-Source: AGHT+IFp37eVKe21lIA6CFAW2qc1fZkeC43v97Qluh0IX85PYmkhKD96OQJxzps15dscNx5J0nHD6w==
X-Received: by 2002:a05:6a00:1707:b0:772:59c6:432b with SMTP id d2e1a72fcca58-77259c650b8mr7707738b3a.27.1756800876584;
        Tue, 02 Sep 2025 01:14:36 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77248cfbc9esm7894444b3a.99.2025.09.02.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:14:36 -0700 (PDT)
Date: Tue, 2 Sep 2025 18:14:33 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com, 
	lachlan.hodges@morsemicro.com
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
Message-ID: <s56cbux4fcydxoiqu3r3jhmxyvda2c6sdayhamks3d2ey2l3sr@6m5kaxhgpwvm>
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

Hi,

We discussed internally regarding some of the comments raised. Also I have
messed up this email chain by not CC'ing myself, and then failing to again. :)

On Tue, Aug 26, 2025 at 08:56:21PM +0200, Johannes Berg wrote:
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

The restrictions are not necessarily symmetric as adjacent bands may have
different limitations.

> different channels in AU and US regdomains, since one starts at 902 MHz
> and the other only at 915 MHz. So for a channel that's between 915/916
> MHz (which according to your figure I guess would be channel 27?) you'd
> probably have to disable it in AU but not disable it in the US?

For what it's worth, our current hardware does not disable AU channel 27 as
the emissions restrictions make it usable, but upper channels (eg 51) are 
disabled.

> So I'm not sure statically disabling the channels from the driver works
> unless you assume there's no regulatory domain involved or anything?
> 
> If I'm right about this, then perhaps it should be expressed as a
> (wiphy-specific) "primary channel band edge distance"?

Currently our existing driver queries the disabled channels from a binary blob 
passed to chip firmware on initialisation/reg notification. This isn't quite a 
complete regdom.

Our expectation for a future upstream driver would be to statically
advertise the entire set of potential supported channels, but to query the chip
firmware on initialisation or on reg notification so as to dynamically mark
channels NO_PRIMARY when required. Sort of similar to what the rsi_91x driver
is doing for NO_IR.

There are still issues with S1G channelisation that we will need to solve later
on (op classes, varying channel starting frequency etc.).

lachlan

