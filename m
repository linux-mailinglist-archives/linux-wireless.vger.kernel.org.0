Return-Path: <linux-wireless+bounces-12709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88116972422
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04471B227D9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600A6AB8;
	Mon,  9 Sep 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ1i2tw9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C4178CC8
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915824; cv=none; b=PX8z4lLRaWTG3QRVq6i9pz3W1AvhqU51gqegs6lM7D8iE0SMGoOTPQiLHfzzSS8g6yptj92JbiyeWCGIj6T9clJhd8SiHjr4P2q4tb0TNuDyqts9+Srhp61f3G07rrAnhlyCeqa/Yu6p/5tkUQbqIYbhKYEpOKKjqLKZwlyRTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915824; c=relaxed/simple;
	bh=kPZkZbhZJwYAMzzUbCZ4THsZ8GpHkz/92/0BokPESZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maLIHGMitZ40TGk53iy/sG5MKzL/FJDqnR5762F9GI6I/9YMB1aGFZ1pziYuKqZ8gpkVk0eoYKljkqIusj9oo1t0uuJIxEnWyd69pRn/U32u7njCEUSKlJwyYz42KTqulmSfByJ6nw7T3rfc3cEkqAh0HOJeWYigU3+SK1jz4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ1i2tw9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d3f017f80eso43367187b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2024 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725915821; x=1726520621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kPZkZbhZJwYAMzzUbCZ4THsZ8GpHkz/92/0BokPESZ8=;
        b=WJ1i2tw9wXPZJLiV9xO/nJaedmZ+LmUSq6dlaIaKhECXEl4eknUrt8Fkt/RAbNyXIo
         fpTOXz1vptNh7+GFiX11ZrVr/Sb/bfqFez2Hyp0A7VozoRYNWboIHjWEH1Ww9/oDsmoH
         92B7Fj3bPDfy5S5Gqg2B4Rm/P69eXOgxiVcUVBHnjnwfvw0W6PXrCwnE/oRWOCcRN2jl
         T/ACtP2Mm2qUaRYUs/RgWKyYVOlR909hCCb7aMduZiVFyGUntbK/D+mzwbAGlAzD25mk
         XxFHPkjgsXaLiDXgSCx/YAMVQTHgTtj+N9kAJKfI54/aEiFumRbxYy/mUm5o57jLH9Pe
         5cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915821; x=1726520621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPZkZbhZJwYAMzzUbCZ4THsZ8GpHkz/92/0BokPESZ8=;
        b=mqRSPj16GY9uRE6gQz73SD/OfSjVuTZqobOPN0JPcdnigOWmJm/BVDudJTutckyACY
         S/tDjKXpIs/ce94kY4n4h/dvxKGLFmtsgSOY94RNhaYzUe0LB6+vg53KxIVXhb1If2gR
         AH0V53VL6kFIcKvreO6HpkgUhlGJf70QppFIqbf7X+IRJDhz7Q4nGGaDwJu98j801UbH
         L7yWCQav6os0QIGe+kZ0NH2uk7OLgkNdM0CMjUzWTH/eeCGv7CovWhEgvM4X9P5R7N0X
         qavt5SHR54WOHUZ3Nl60kuE2lPMNIfaKMBwzlHNBJNvimaV7eF+ryC4Dt/R+hSUtYQqO
         oipA==
X-Gm-Message-State: AOJu0YxbrO5jG521is8ac47mFkKsX1TDqVU+FzZUNBLYYR18yBEEhs/u
	ygQykz5/nhqIbsdVmAc2i7rsSXOraxVLfNWVNn9ru4Tqqv2dQEYWf04fbysV2ttpSJizJ24U3Fx
	3AAZvTabfVjaPpEZyo4BlmZKcjZI=
X-Google-Smtp-Source: AGHT+IFeCRkJtK2cCGzEFwaKQD5FP7VZYmZry96zQ5u2k62UkXW1CFVn/YEXOpqeKhmvGcxaL7bYqdhiaj5kI21t+8E=
X-Received: by 2002:a05:690c:67c1:b0:6d9:90f3:1a79 with SMTP id
 00721157ae682-6db451544f3mr165321137b3.32.1725915821450; Mon, 09 Sep 2024
 14:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
 <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>
 <Zt4PKMCp_FTx3kac@debian.local> <cd2ec07a08c9a51e0dfa5be70b35d39e5cc5e577.camel@intel.com>
 <CAP-bSRbmKvaoU662XtgjaPaOwR7fHZaJyrYxkpT=DfuCxwsJ4w@mail.gmail.com> <5b372558da9aed3a33e466970a64a5eda8f82454.camel@intel.com>
In-Reply-To: <5b372558da9aed3a33e466970a64a5eda8f82454.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 9 Sep 2024 22:03:30 +0100
Message-ID: <CAP-bSRYNQVbzP6WNBMe2Ak_7w9b-=tXQ-9ktgK5XvoU4LFX2zg@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 20:40, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> On Mon, 2024-09-09 at 17:16 +0100, Chris Bainbridge wrote:
> > On Mon, 9 Sept 2024 at 04:08, Grumbach, Emmanuel
> > <emmanuel.grumbach@intel.com> wrote:
> > >
> > > On Sun, 2024-09-08 at 21:55 +0100, Chris Bainbridge wrote:
> > > > On Sun, Sep 08, 2024 at 10:54:09AM +0000, Grumbach, Emmanuel wrote:
> > > > >
> > > > > Strike that.
> > > > >
> > > > > Can you please take the patch in attached instead?
> > > >
> > > > Sure, the error with v6.11-rc6+patch is:
> > >
> > > I expected that, but is wifi functional after resume?
> > > Not having wifi after resume is one thing.
> > > Having wifi but with lots of garbage in the logs is another thing.
> >
> > Yes, wifi is working after resume.
>
> Does it work without my patch?

Yes.

