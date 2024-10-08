Return-Path: <linux-wireless+bounces-13658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EC993A42
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 00:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D01C23216
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57218DF96;
	Mon,  7 Oct 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3VL5Ud8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B518BBBD
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340529; cv=none; b=XM97ud9js2acMlxz9Lz1MK4tkynCVNVxX6iPu887QJcq8NgksGwr54CAlMKtzVmyNA4qysEYWi2dzGcUl5PHIUGyXPiXCn5fnpQDaAVXtgrIk52ULEaECTI3drsYbN8wJRws5j5C2NmJooPnZYDvA7dABZ4Om27woVywVa5jgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340529; c=relaxed/simple;
	bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5jJ1GE1mcF8Pn3apuZcNbHtQ9J30CE+QfArQn9I6FclTXXYajo+yQEMfhVjp+RH6Wc4QCnwVFcaBgM2+9pRoMYuca8nqbSzBrnvvZgMKLtsKBYSFbT8H9D/YFonclOG2wbHB2CIv92JMUx32dr0c2eeddHLbd5ImcGT6gO4t8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3VL5Ud8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25d164854dso4139029276.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728340526; x=1728945326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
        b=e3VL5Ud84GLI+E2x3bA8ztpqvuFMv57yd9aYEVQJXCzdGLPTTmXpQqv3Opq72bJmux
         KBHMo3MVO1HOzdmTO8H+pcTCfVPqaiTDnPTpbQzl0qQR7IL44jHkwS4bzBufrjeR8qhe
         DDLiaWivcex7UxcVlthWRdgNLBWzi+M8qTeDx57baSkDWFH1agIYPgvRPadbYLCLtjZu
         06qTHbdte5aRDCOnGRwQe0feCJbqguEWevqetTaa5WoZI91EWlvvh0bLcBUS4nMqHsf9
         D1KWrNcsh7YIcTiYbXUJhkPijHa5aKTMIfa20aY8luGYazLflzR5ecy/UydbOSAfiQM/
         3TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728340526; x=1728945326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gesjil9Y0RZgbcjmX5qHd/S97rHztDCcedkOm+1cl0k=;
        b=hnCuJSM+OA2YI47m0HTg/59Y3Hame4DTMpzaB7SfRxD+5niv7DMAOVWVfd/XYtqpLT
         JC9nT+nQ1/3aY5JbjAOspkfQzmAncbAtpc1wq/fFrOZ17FFgAGH1KBaEdCaCRPgRPQyV
         JJSXWJbhzn0nYd6u9RmpXi/8KJ9LIegIjsqhknNir6cwim8fkO9g+Guy7ys5d5QdhI/X
         mjY2y3QLp8WH4qlm05YpOmmZVFCXQzQswaCIcGHNaUi2mwk+d0D9p+D6wDR9Q1Z7CVio
         chufNxu6EpurQ8PJRCSYRTB+XHKm+PXUPqQQe/S9dWIHP4DwJGAvMEObAcx9zzkEAb0P
         XwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHRypwwvCla51D+w32DT4Q69005vGsg4Rg+42hOOYLfmmaCNOmgLOeOLeW79FYMNsvOfcW0ZP3Y+BmT4cQkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoYSewVmfehH4/vLyv8llyV61iKiOQCT5ePd5mRkyh4u/VzII
	RESXtsPN9kw7hBfhm1dRY8RCzaK/Q9CFRbH/k6eBKaq+kLAYRtf3pR3JgaKpB3wFX7yYFE1HnK5
	Hp/Sryic+EBFcl6ALxf+kVnQXylV50tnG9hoX7A==
X-Google-Smtp-Source: AGHT+IGYLLRVc3CeXKReIUVnntYlZ+ULRb29gPUl3UTx4hoqAUGdx6q2aFDzdnacRWqcM/cOYseo4GoEdp7e3a8qLZE=
X-Received: by 2002:a05:6902:2305:b0:e28:6ec7:4353 with SMTP id
 3f1490d57ef6-e2893964043mr10612649276.54.1728340526338; Mon, 07 Oct 2024
 15:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com> <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
 <20241007222502.GG30699@pendragon.ideasonboard.com>
In-Reply-To: <20241007222502.GG30699@pendragon.ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 00:34:49 +0200
Message-ID: <CAPDyKFrGNwna6Y2pqSRaBbRYHKRaD2ayqQHLtoqLPOu9Et7qTg@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, rafael@kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 00:25, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Tue, Oct 08, 2024 at 12:08:24AM +0200, Ulf Hansson wrote:
> > On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart wrote:
> > > On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > > > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > > > __pm_runtime_put_autosuspend() while the former will soon be re-purposed
> > > > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > > > always used together, apart from bugs which are likely common. Going
> > > > > forward, most new users should be using pm_runtime_put_autosuspend().
> > > > >
> > > > > Once this conversion is done and pm_runtime_put_autosuspend() re-purposed,
> > > > > I'll post another set to merge the calls to __pm_runtime_put_autosuspend()
> > > > > and pm_runtime_mark_last_busy().
> > > >
> > > > That sounds like it could cause a lot of churns.
> > > >
> > > > Why not add a new helper function that does the
> > > > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > > > things? Then we can start moving users over to this new interface,
> > > > rather than having this intermediate step?
> > >
> > > I think the API would be nicer if we used the shortest and simplest
> > > function names for the most common use cases. Following
> > > pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> > > most common use case. That's why I like Sakari's approach of repurposing
> > > pm_runtime_put_autosuspend(), and introducing
> > > __pm_runtime_put_autosuspend() for the odd cases where
> > > pm_runtime_mark_last_busy() shouldn't be called.
> >
> > Okay, so the reason for this approach is because we couldn't find a
> > short and descriptive name that could be used in favor of
> > pm_runtime_put_autosuspend(). Let me throw some ideas at it and maybe
> > you like it - or not. :-)
>
> I like the idea at least :-)
>
> > I don't know what options you guys discussed, but to me the entire
> > "autosuspend"-suffix isn't really that necessary in my opinion. There
> > are more ways than calling pm_runtime_put_autosuspend() that triggers
> > us to use the RPM_AUTO flag for rpm_suspend(). For example, just
> > calling pm_runtime_put() has the similar effect.
>
> To be honest, I'm lost there. pm_runtime_put() calls
> __pm_runtime_idle(RPM_GET_PUT | RPM_ASYNC), while
> pm_runtime_put_autosuspend() calls __pm_runtime_suspend(RPM_GET_PUT |
> RPM_ASYNC | RPM_AUTO).

__pm_runtime_idle() ends up calling rpm_idle(), which may call
rpm_suspend() - if it succeeds to idle the device. In that case, it
tags on the RPM_AUTO flag in the call to rpm_suspend(). Quite similar
to what is happening when calling pm_runtime_put_autosuspend().

>
> >
> > Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
> > during rpm_resume() too, for example. So why bother about having
> > "mark_last_busy" in the new name too.
> >
> > That said, my suggestion is simply "pm_runtime_put_suspend".
>
> Can we do even better, and make pm_runtime_put() to handle autosuspend
> automatically when autosuspend is enabled ?

As stated above, this is already the case.

>
> > If you don't like it, I will certainly not object to your current
> > approach, even if I think it leads to unnecessary churns.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> --
> Regards,
>
> Laurent Pinchart

Kind regards
Uffe

