Return-Path: <linux-wireless+bounces-9923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF8925F1A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 13:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2394B28652
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25311849FF;
	Wed,  3 Jul 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYbxGRBa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D20178384;
	Wed,  3 Jul 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006289; cv=none; b=olo6PrzLKQhqyMjEFftrnYp+0h4iTSsIIWpz/2QcfInjMpiL3rGpKBwajryoPV2Cgolpwdk6jloe7g2TTGgsrJ9MPl37BKlkvprKsG9zoD60kk1ejDKAw6Vsn4u+n/nZja+3JxV/bh854kFhaBixAHPDxUkHidvkNSKsyjJHfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006289; c=relaxed/simple;
	bh=OOqX7HXKQvRZ8kJaMG1PBXsJYL3kB9aBJ4y7GrmT338=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXiLRYSolPtGJTpjmemmarhPrjwi+5ohtLZpWp909Upfm6ObvNqIaLk8z03U0dRGOMhYZEtxk6gTnSepIxlcRmanbypJ7K/d3lFJ2r8ahxuOuoNeFXuGV7gbpm2ldBoaPgmhMaMqMcDQZmBIY3lusX2sF4e7Kc9ByjhBCKE8eaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYbxGRBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B480C4AF0E;
	Wed,  3 Jul 2024 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720006289;
	bh=OOqX7HXKQvRZ8kJaMG1PBXsJYL3kB9aBJ4y7GrmT338=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZYbxGRBaglXSZvrdwzgntW0V74f2TqoCGL+Vwbgw0ZqQuebO1HOJmOLvbOY+Xu+qO
	 TJNpjMY/7U34DyJb0FgCUypHUCkvxV4LnsFOgmYPLnYYAA+C0+tjCkBoPxF9cPFw3c
	 HBg87gg3TkQIsunfDw7CyASp9l1hNmmTq7PIFNtPhOhTgLUYgx25YbBVU4OnIqH9Ox
	 0zD+MxC2fDX4pZNqOFpR37Hr0L2pl/UkE3sBg599P/OnAps9IcFoVbgUSRcZvlxVey
	 7fvXwe3SEItT+qKg1+AvR5RQSw74QmgUxtzG6j160/jhoAgK9vTX+issGs400HYaI5
	 gCgwDzLSyCznQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d56754a4ceso298058b6e.1;
        Wed, 03 Jul 2024 04:31:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvdhGcxc/9ZUqeGcNRGvCgIVy/qj0Wl+LCeoNZprEJtJd6M62BjNQ7x452Ied9vZzLMdxQAIM3BKmQfYlhOKY9eI7ay3ufq/ZINVzk5KgdSxUNsSUSK+sEf2U/K6wkMkkHIagLe35bQH/Z/JBEUoydCYbgcNWGh3kSpp0eAMMzLG7cfiwL2jUL0yslckA2+gW50XHxlKkdVFshI/YBB+y65Qr+
X-Gm-Message-State: AOJu0YwGrn54YUWokqHEH6QkU50gnL7zFv9DVBTlS6ezMvwP4pAD2Sgt
	jZu9MbMgLns8sqt3zeoE1pmo1J4NPNrnBmM/r7360gypjIYVw5f4T9ySaGbWs89AK7dKcxSsFur
	Ahjn7yreCwwWuaheAJJQuZLxe8EI=
X-Google-Smtp-Source: AGHT+IHjc7MTNZRLTBNE7mu4jABEZQGDjUj30z0WrDXIT7TlEe02wTsalj1wTZ4s4WUo3e9PxE2VMnph7z7hy9nYD4M=
X-Received: by 2002:a05:6870:46a8:b0:25c:f5f8:a822 with SMTP id
 586e51a60fabf-25db33f8baamr12061362fac.1.1720006288688; Wed, 03 Jul 2024
 04:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1890956.tdWV9SEqCh@rjwysocki.net> <8392906.T7Z3S40VBb@rjwysocki.net>
 <c5fdac6f90b7b2191914f632dc89bac8b4701bdc.camel@sipsolutions.net>
In-Reply-To: <c5fdac6f90b7b2191914f632dc89bac8b4701bdc.camel@sipsolutions.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 13:31:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gdQtbJHsQ2LMQrgnaQxS3BybaCXLYKeF1sFh7wPW8Uuw@mail.gmail.com>
Message-ID: <CAJZ5v0gdQtbJHsQ2LMQrgnaQxS3BybaCXLYKeF1sFh7wPW8Uuw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 3/5] thermal: trip: Pass trip pointer to
 .set_trip_temp() thermal zone callback
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-wireless@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:43=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> You said in the cover letter this hasn't received much attention ... as
> far as I can tell, the only wireless thing is this:
>
> > --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -638,7 +638,7 @@ out:
> >  }
> >
> >  static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *dev=
ice,
> > -                                    int trip, int temp)
> > +                                    const struct thermal_trip *trip, i=
nt temp)
> >  {
> >       struct iwl_mvm *mvm =3D thermal_zone_device_priv(device);
> >       int ret;
>
> which I guess looks totally fine :)

Well, I would think so. :-)

Thanks!

