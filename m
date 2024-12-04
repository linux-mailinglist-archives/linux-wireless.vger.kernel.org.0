Return-Path: <linux-wireless+bounces-15874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF99E3117
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB8FB22111
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D222338;
	Wed,  4 Dec 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwKzEtYH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFCEAC7
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277888; cv=none; b=mn2mmvZL1hms71sOvPH/+5YXRpU3eVGDQ0z8khAOJ2HqfzQLRXfETOAxMIh2RsidUu2m06/PY9T4wTj1jBWPth4emgEXgkCy/L7tYMr716Rf4TtS+gPjcJm1mc7/+1PldTjQvvp/FLjV6PA3Ty9QUYyaQOxzV9+NR5HdOpuUmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277888; c=relaxed/simple;
	bh=pNiFolC76ExhieVQMQFF8JSvZA2vSPq1BxLKk2ioJxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK3nY+g0fDF9HdeEpI0x/eGHJz3X6FhixEu/kSgXcBwb/lLmo9XZfBRAG1K4845sFfv7ne4Lo4c8yX6ojPem3CB4bQXQCSLBezto0HqP1n8HA5h5+abnFtzUFe0HMR7zIwxuuM7hA75y5vBvort8dPkjjJqRGo6XNNm2NfBR1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hwKzEtYH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-723f37dd76cso5619566b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2024 18:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733277885; x=1733882685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0lkwcza4lR0Ccd84VeETqMtWnsNfx0dgjzB65ixZLd4=;
        b=hwKzEtYHyau8f0d4DO+31ryXczYzaj3DEMBoF/xnPR7FUQyOCqYg9q1xI4+Adl2X6D
         PtZnm5BxZZlacYKNElEKFccrHo+bgk9ayj1sxS6QX0QNRq5uDT9xDVyABv6mQGD/uQFu
         Zm8Hds9oecv4kR/LumGxnakW3h5VU02zHADUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277885; x=1733882685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lkwcza4lR0Ccd84VeETqMtWnsNfx0dgjzB65ixZLd4=;
        b=a7KCwA8oo0gwRz/n1CTEgQxHccBL6SpRGO2acJAs1HBRK5IKfJZ9aXGhFs9oNXrMDr
         IJanRYvFRAC7+2qnKMnik+rGs2YsKXyEfAecHOLVJlt2OMSozH2/W8kgA532ITx6uafh
         xIF3uOj+MxzZ6p1Ij2BzOQXZiJRXG1kICxSTlZajQFyRQKHVsg7kVWEbC0rWs9Yt/eW5
         wXL7od5914bKmKTZAfK/+YKdm5BgTa6GLnJ2sfk6FEc4AGPoTIMh+Rys6YMG5TIo1k/r
         ovrjhgCS8mrz2CPL1HMWfYbOl+yq58f9jdRuaagj/iP2Qv1JmeJ3H4uDJVVT/ySE9Z/T
         J8tA==
X-Forwarded-Encrypted: i=1; AJvYcCVEBZDzbc1+ekCDbbXh3zp81MztcdPTHzSXAnFI6s1+Z5nM5I60z9ocmo1Wi05ckwkFZkDOJxWRDYFEEIiLAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfKucOru2Op3lpWEAQHoju5HRqMa8DywkIZet5x7kTYMN/Ee3
	7Tg/z5mWPkEAbSdM1FVEY84ujEPiczHpvRKv6Dc/DPyv1prK6vYb0qoNehuQ5A==
X-Gm-Gg: ASbGncu0UhMikWxhHpXCV8HgrCgc1+jdhDKlaWrj2GTp5fH9XeMPbY9mR2hi02KRq4E
	x2Czw3wRGiaM2m21MbPWuC9BmTc4F/AI6U59/jIhu/ou5MNseAC/R7RC4KCkKOwETpP6FWi0jsG
	arDBsU/IcNuAM9GxQpUe+W87zsjV5Z9n+XoJ3kzuvHHkAF6mK0m2B0nJk3S95h7tI0+Oc19532/
	LMMdQSVkRScfoGVQgzwwdjCm6nCalkMpmmGO5O4QL89+/JzSSzH1SGWiFEkaqz27HtMle5gfJsG
	n04G5+9R9TUY
X-Google-Smtp-Source: AGHT+IFpZ/RZ49422Kd7KVYSNsi/NlhPCf3EpP3hywu9bAd1sv2QI3B8XKbRZlBw8dZikjOWL3sP0g==
X-Received: by 2002:a05:6a00:3994:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-7257fa758a8mr8425832b3a.8.1733277884954;
        Tue, 03 Dec 2024 18:04:44 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:8ab8:57a6:96ad:47f7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7254182c817sm11201228b3a.170.2024.12.03.18.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 18:04:44 -0800 (PST)
Date: Tue, 3 Dec 2024 18:04:42 -0800
From: Brian Norris <briannorris@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Pin-yen Lin <treapking@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
Message-ID: <Z0-4umP9TnNAbJXO@google.com>
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>

Hi Doug,

On Tue, Dec 03, 2024 at 05:38:55PM -0800, Doug Anderson wrote:
> On Tue, Dec 3, 2024 at 3:05 PM Brian Norris <briannorris@chromium.org> wrote:
> > The Kconfig default is 120 seconds, and it's hidden under
> > CONFIG_EXPERT. What makes you think 10 is a good value? (It sounds
> > pretty small for triggering panics.) The smallest I can see outside of
> > ChromeOS is 12 seconds, although 60 seconds is much more common. I
> > also happen to see other WiFi drivers have hit similar problems, but
> > they settled on 20 seconds (assuming a 60s timeout on other distros):
> > https://lore.kernel.org/linux-wireless/20230329162038.8637-1-kvalo@kernel.org/
> > https://git.kernel.org/linus/cf5fa3ca0552f1b7ba8490de40700bbfb6979b17
> >
> > Technically, this Kconfig lets you set a value as small as 1 second. I
> > don't think we should work at reducing all timeouts to fit that
> > target.
> >
> > I could maybe approve lowering this one, but I'd also recommend
> > reconsidering your timeout value. And more questions below.
> 
> That's fair. I guess having a 10 second timeout for full system
> suspend didn't seem totally crazy to me. If a system is taking more
> than 10 seconds to do a full system suspend then that seems like
> something is pretty broken. I guess it's somewhat like the same
> argument that the WiFi driver had for picking 10 seconds but applied
> to the whole system level, and I guess that's where we get into
> trouble. That made me think that even 5 seconds seems a bit long for
> any given driver to suspend. ...but yeah, it's squishy.

10 seconds is likely that *something* is wrong (or at least suboptimal),
but IMO, it's not quite at unreasonable levels. But yes, my point was
mainly that it's squishy, and I personally wouldn't want to be the one
running with the lowest CONFIG_DPM_WATCHDOG_TIMEOUT out there, given the
known behavior of multiple drivers and the timeout-means-panic behavior.

> Maybe the ChromeOS should change to 15 seconds for the DPM Watchdog
> timer and that's a better solution and leave the WiFi driver how it
> is?

That seems reasonable.

To be clear, I'm OK with this patch, if we can get a little more
confidence in it (like the timing data and HW info). I *think* 5 vs 10
isn't a big deal here, but I don't have much other than my guess at the
moment.

> Another thought: I wonder if it's possible to be dynamic and somehow
> set the timeout as "max(10, dpm_watchdog_timeout / 2)". Not that I've

You probably meant min()?

> checked to see if the mwifiex can actually query the DPM watchdog
> timeout... ;-)

Yeah, I wondered similarly -- or in reverse, if we could somehow "pat"
the watchdog or prime it with an expected timeout. But AFAICT, neither
such feature exists today.

> ...also, it sure seems like if we're going to choose a value so low
> that we shouldn't panic. All of our other watchdogs that panic aren't
> so short, so probably this one shouldn't be either. Maybe we could
> submit a patch to make the DPM watchdog just abort the suspend if
> that's not too hard (and if the power people accept it).

Yeah, if you made the watchdog just interrupt suspend and dump some
warnings, then the effect would be pretty similar to this patch.

> > I wonder what the distribution of (successful) timing is today. I'd
> > assume this typically take on the order of milliseconds, but do we
> > commonly see outliers? What if a system is fully loaded while
> > suspending?
> 
> I would hope this doesn't affect things from the DPM watchdog, but I
> haven't researched. Hopefully the DPM watchdog starts after userspace
> is frozen so the system being fully loaded shouldn't matter?

I was just throwing out ideas, but I didn't specifically mean user
space. You provided a few more ideas. Anyway, I was just fishing for
*some* attempt at real-world (and, as-bad-as-you-can-simulate world)
numbers, since that's the point of a timeout like this.

> >  Can you try testing (and gather timing numbers) when
> > suspending soon after initiating scans? It's hard to judge what the
> > lower limit of this timeout should really be without any numbers, just
> > like it's hard to judge whether your 10 second watchdog is reasonable.
> 
> Pin-yen: is this something you could gather?
> 
> 
> > Also, for the record, since we might have to field regression reports
> > for other systems: what hardware (chip variant, FW version) are you
> > seeing problems on?
> 
> Pin-yen: I'm assuming you'll provide this.

I'll leave it up to y'all (Doug and Pin-Yen) whether you want to provide
the above to provide a little more confidence, or if you want to
reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.

Brian

