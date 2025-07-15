Return-Path: <linux-wireless+bounces-25457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D3B055D7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640E4189AA13
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29AC271456;
	Tue, 15 Jul 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="xu7KhmTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54324886A
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570429; cv=none; b=MpD7MDIpjn+CpX5510zam3De90lMYZfG7jYTptpiU2gAK+0I6hCS3Icf/uJctrXpQKJiN5mehsZ/rNjIrYH6Nj33aIt63E3gOZ7iZ6H3GG9osOG1FariFf8V7p+6LgofyhxT3hNwnlmTt9EMK/kZX6t5O5kJ9FMxCbnBzh5IxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570429; c=relaxed/simple;
	bh=A80/GZ9EM5qvdI8sKy6c57arpHnC0UHFtODB8zD0p6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fujoz3l+8J241IWtdPQxDzEnIwHncR/2CDNZj2DXop7EceqA5CyIU22d679Zj8QllT8zbacwq+BT6GISJ6RWJcO35Lp7jb4ioUUQWH7DT4MNvxd2AQrKLKJG1J7SxMQTsW7/5Lg7eOCwuGR6H72dUa1wabsB4ZtULot5y0OeYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=xu7KhmTZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235f9e87f78so47821965ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752570427; x=1753175227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E13MMtr6ZbzASYbT6FGr6cq+Zd9bDxwz58pMR/dxpkY=;
        b=xu7KhmTZL9m6V/xjgL5DxsUOvk7DabbLv0Cthl7/yVfj/kivI9cyNOGMAK/AmhdFd2
         dHMm3IOOSRBPFUEf8gWprQJP65kOQJSHqmNm4lVa9hBmfZOM+/JFrQ+JnMnVYMe1qGFl
         Tud9lMF0ofk4GUHj/jOFgZgHIKv6jlzF2vyE+G5Z+CB2A0BZcFp0NGB+ez+9+8z/moB5
         qNX1wxcm4gJu5vzCNNJK0AnbudKuhITx/RkleRcaQFv0JFuzlfoKHZ/VZK26n9wqE4IJ
         xYzo/quasbAZdpcBtWPwMWx69FfHmU+5if0Mk/Y5CVsETDOsrbp1Cm7TKC1pA+G+plNz
         Kd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570427; x=1753175227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E13MMtr6ZbzASYbT6FGr6cq+Zd9bDxwz58pMR/dxpkY=;
        b=ucd5KuhS/HKoHRnHNBn2b5Qs7B73Kyp4fCA8lm4MM4e6qw0e56rt/yTxULzLMMYwvt
         jAtGx7roCkgKJjVimUT8GEu0mdnKdKSog8YCHCJj5RLXi/udwaUxevuFJ9yTc9LUzkd8
         BmumehJGPOxA1qWOXr8IGBbnE0qe7m6BKdUtB+FJwyGtMNxVQxlpVV639hSJYi+xG4/a
         PwfRFYkumkda2BF/yH1J9B4AXHBLKSnAR3zvZdR47IU/vRjRrcb2DnPoG2gpK1KYnNxe
         78Bt26AWeujIZZkPwzrTwXvGDo8Ub5ZMYI1HiM5FM8aoyXVrbtVbpGpJyIRbL9gjhqtg
         sBCw==
X-Gm-Message-State: AOJu0YwBEIHX4d0UYzaRQVhQy03/ChM7fHU1gUCr+TlI3gyZThNkC25Q
	lyWesRZur146yRTh7U6/B3HclolFmAEeHTeHmvHKHDodGNevfvI45F/keNYwhAjlJ78u89+7xxA
	G+kcE
X-Gm-Gg: ASbGncv6qvDDgklD/TweWZfRTrk5gtsTXqfCcga8Yz/T4Xt4cZ5OSgMmsOXfrrSF49/
	RRNoNC/toSaniik04kCpurP1fvaYARU8sSNYbaoBA18DtErRgFgYH4GZQHuCfk2HygZE7trCbIo
	aWRRVQgcbJxkq04UBDdNtWsv8C+ZGGjoMzKSMThM+JEAspu54gUyvlsdci8oEL7X5lIKipWKnRC
	Hg1ZsbY/m9KLAdOmjuZ0fJQtC4nSYthpXdE6GJSov8jgr5tJN1dF/ngwoiami/eBM50Kk2BjQmP
	bji9aOLmWkK652vTWiCQ5h7rRaJRSkWxG9o6X7jZn/c1TFlIM+/JWFm980p3PpngnRW+gK1uvv+
	IDCtV9cEc0f6QAwR4uvmr67zfELNWtBWMAaPqFQ==
X-Google-Smtp-Source: AGHT+IHd2UabRSO/iygQaEDL5exS/DQ+iPK+k5E2A+itZYV67AOzy27rlcKMCJ5fm8cPX/LIQpg2Vw==
X-Received: by 2002:a17:903:2a8e:b0:234:ed31:fcaa with SMTP id d9443c01a7336-23dede98453mr196725595ad.50.1752570426956;
        Tue, 15 Jul 2025 02:07:06 -0700 (PDT)
Received: from localhost ([1.145.89.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322776sm106737025ad.132.2025.07.15.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:07:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:07:01 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [RFC 0/5] wifi: S1G short beacon support
Message-ID: <roc64x2sxlgjwos52gqopszycjmdyazuu7pz2e4vf2huwhbs5e@inmocfqrssr6>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
 <fa265deeae5dedcc7e13cda8cccd9b42f85026d3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa265deeae5dedcc7e13cda8cccd9b42f85026d3.camel@sipsolutions.net>

Mon, Jul 14, 2025 at 02:50:42PM +0200, Johannes Berg wrote:
> Hi,
> 
> So just to say this up front I have very little interest per se in this
> feature directly, so I'll mostly leave it to you :)

Hi Johannes,

Firstly appreciate the thorough and quick reply... and of course that is
fine. We still want to make sure we implement it correctly :)

> > 11.1.3.10.2:
> > 
> > "The value for the dot11ShortBeaconPeriod shall be such that
> > dot11BeaconPeriod = n * dot11ShortBeaconPeriod, where n is a
> > positive integer. This defines a series of TSBTTs exactly
> > dot11ShortBeaconPeriod TUs apart"
> > 
> > the value for n here is what we are denoting as
> > s1g_short_beacon_period (another deviation from the naming
> > within the standard) which represents the number of short
> > beacons between each long beacon.
> 
> That seems slightly confusing - I've have interpreted a 'period' either
> as a span of time (as in the spec), or the number of steps between
> events, so maybe that's rather 's1g_long_beacon_period'? But if the spec
> uses period as a span of time, then perhaps 's1g_long_beacon_step' or
> something would be easier to understand? Not sure ...

You are right, it should be the long beacon period (similar to how the
DTIM period describes the number of intervals between each DTIM beacon).

lachlan

