Return-Path: <linux-wireless+bounces-10350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60440934CB1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19811281F97
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FD13A257;
	Thu, 18 Jul 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+5Wzbo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E5558BA;
	Thu, 18 Jul 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302933; cv=none; b=T/FNgAYcdpPKjxBFzUGV4Ngx5Ivpaxrf4qixxElSim+h+Qjfb4m5YTfKxiWPm6CGUlIdxJh5MRhXsNBgs/GS7mLDVExM/jFqbRYnGHoL0Z/IZHrI/XQGKxDtgpPOR/IUbmZJ+MBfLU3j2HjA1SIO887H8CY7h4QWJQXJtuV8U7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302933; c=relaxed/simple;
	bh=jSLxpc8wkxTgKpeFNSG3xETxoREa5rhzKqkP1DGPhJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+5ybotf2zjHkULYDDzz1WteWE6DjQt7MZHPvtUkFSiTN9wgF72Wnfk6WEOGJ0dcFXczotNAYQTr1TnIosTr5u8UrJaJ7zUI58IxB6Vdr6gKFrL4zM7rFCzTAsoCp0cI8A1gQES+BAbwnlUm7vCjAJtVBzEqAxhcKA7mmFyadgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+5Wzbo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6714C4AF12;
	Thu, 18 Jul 2024 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721302932;
	bh=jSLxpc8wkxTgKpeFNSG3xETxoREa5rhzKqkP1DGPhJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+5Wzbo89lLyTdgW2Lr6ep4NwdVxMqITeYw7qikQbzpQctbNntPXBaE0kBVrwdzi1
	 vNJFARNVDNqv79tq2NciDgjmpGOygQe2phcCgocXKnnohju1XbMQDcKJgDnqXlCFV7
	 1rnf1dagB5MGq9mUHRB8QlbVDkfTBZyJo7H05Qu5fLi/fAWNLRZz2TocFfMk8guElm
	 b/dKGyjyLt4wtKPWm2tUHYz2TXLzrArwtuTe7x4qSvXTMTPU9xRzdnahp47sTewxrK
	 RYh7q7UzQ3c9kGCe8UbQwfpnwQ8A5U6hycH3sF/sWXJPd5BW1LX3KUAhS7Ur3jDRQl
	 ApvAaGZ6XaRAw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e23e0492dso114971fac.3;
        Thu, 18 Jul 2024 04:42:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpWUTKD3qZbFbLyFjxhKQDFyPzEcLalObgOUwBOgqXk/s3lX7RjqSFHHgrCN+ZM6QqQBUrTfSu88BV3yvT7MkF8xx3HrFvfoGeR63JmBzP/hRZ2OfOhrNB/mABIqjcekoDLpnxvP294o0RYIuDnbxPDmmziAPIks94qvdGh1RMyVYipGgKvA==
X-Gm-Message-State: AOJu0YxrJ1OrXxifQD+V1iiqgTdqlOfpR0cZuMduPj5j1AAoyTwd94Me
	xYbnoWomhBD3A5UGAIZHyM8XPOFjlLODXJ/pIFOxTHQ08WxfZLNEekl/bcoqgHumWJ1EPEDVe2G
	gM0v9Hqel1AM0Be3RG8vVE1LD/7c=
X-Google-Smtp-Source: AGHT+IE2wr/y+LGWtWs2b70t8ZWMMoqeLUJ/TymgWf5Y8DMgWtCQF0GroDDcvugz4bkpm3GT+q3lNf+WvckTpv8iQNY=
X-Received: by 2002:a05:687c:2bcc:b0:254:d417:351f with SMTP id
 586e51a60fabf-260ee846b1fmr1537278fac.1.1721302932051; Thu, 18 Jul 2024
 04:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4950004.31r3eYUQgx@rjwysocki.net> <20240717212421.GA1191@sol.localdomain>
In-Reply-To: <20240717212421.GA1191@sol.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Jul 2024 13:41:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hc=tVDBiRrJqgVNZ5Bi59vqHQt-fYEV-quw8nnZVqJtg@mail.gmail.com>
Message-ID: <CAJZ5v0hc=tVDBiRrJqgVNZ5Bi59vqHQt-fYEV-quw8nnZVqJtg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Allow thermal zones to tell the core to
 ignore them
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	Stefan Lippers-Hollmann <s.l-h@gmx.de>, Oleksandr Natalenko <oleksandr@natalenko.name>, 
	Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:24=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Wed, Jul 17, 2024 at 09:45:02PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The iwlwifi wireless driver registers a thermal zone that is only neede=
d
> > when the network interface handled by it is up and it wants that therma=
l
> > zone to be effectively ignored by the core otherwise.
> >
> > Before commit a8a261774466 ("thermal: core: Call monitor_thermal_zone()
> > if zone temperature is invalid") that could be achieved by returning
> > an error code from the thermal zone's .get_temp() callback because the
> > core did not really handle errors returned by it almost at all.
> > However, commit a8a261774466 made the core attempt to recover from the
> > situation in which the temperature of a thermal zone cannot be
> > determined due to errors returned by its .get_temp() and is always
> > invalid from the core's perspective.
> >
> > That was done because there are thermal zones in which .get_temp()
> > returns errors to start with due to some difficulties related to the
> > initialization ordering, but then it will start to produce valid
> > temperature values at one point.
> >
> > Unfortunately, the simple approach taken by commit a8a261774466,
> > which is to poll the thermal zone periodically until its .get_temp()
> > callback starts to return valid temperature values, is at odds with
> > the special thermal zone in iwlwifi in which .get_temp() may always
> > return an error because its network interface may always be down.  If
> > that happens, every attempt to invoke the thermal zone's .get_temp()
> > callback resulting in an error causes the thermal core to print a
> > dev_warn() message to the kernel log which is super-noisy.
> >
> > To address this problem, make the core handle the case in which
> > .get_temp() returns 0, but the temperature value returned by it
> > is not actually valid, in a special way.  Namely, make the core
> > completely ignore the invalid temperature value coming from
> > .get_temp() in that case, which requires folding in
> > update_temperature() into its caller and a few related changes.
> >
> > On the iwlwifi side, modify iwl_mvm_tzone_get_temp() to return 0
> > and put THERMAL_TEMP_INVALID into the temperature return memory
> > location instead of returning an error when the firmware is not
> > running or it is not of the right type.
> >
> > Also, to clearly separate the handling of invalid temperature
> > values from the thermal zone initialization, introduce a special
> > THERMAL_TEMP_INIT value specifically for the latter purpose.
> >
> > Fixes: a8a261774466 ("thermal: core: Call monitor_thermal_zone() if zon=
e temperature is invalid")
> > Closes: https://lore.kernel.org/linux-pm/20240715044527.GA1544@sol.loca=
ldomain/
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D201761
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> > Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * It is safer to retain the old behavior in thermal_zone_get_temp(),
> >      which is the second place where the .get_temp() zone callback is
> >      used, so make it return -ENODATA if the temperature value coming
> >      from that callback is invalid.
> >    * Add Tested-by: for Stefan.
> >
> > I have retained the previous Tested-by because the part of the patch th=
at has
> > been tested remains unchanged.
> >
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    7 +++
> >  drivers/thermal/thermal_core.c              |   51 +++++++++++++------=
---------
> >  drivers/thermal/thermal_core.h              |    3 +
> >  drivers/thermal/thermal_helpers.c           |    2 +
> >  4 files changed, 35 insertions(+), 28 deletions(-)
>
> This makes the log messages go away for me.  However I had to resolve a c=
onflict
> in drivers/net/wireless/intel/iwlwifi/mvm/tt.c to apply this patch to the=
 latest
> upstream.

Thanks for the heads-up, I've rebased it on top of the current
mainline while applying.

