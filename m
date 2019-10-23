Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA4E1EDA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfJWPHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 11:07:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45793 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390629AbfJWPHc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 11:07:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id l5so2704536vsh.12
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50+55fOZpgMJ3ywx+S/l93zu0e/H3x84JmCU84w/5zk=;
        b=q7Ee2Ifo7ppiH/FKiG1JgwqGKZ1PinhbWDZf6kFjfFckO3ROAeO8HOoKPARGjpGWMm
         k8InVem2hsg+7b4mzlj7oe3E/rBJf3xO2TOVOww8SH3xZiP4HH4Y92n0FsFTeuuY8OgS
         G5V6hEmg7OuenV8hm8f/b8CmDQaAhriuDFvPur/9kNekVNyupla+jLGoXs9qrHhqaYwJ
         maQoszO5pAuw2uPDjCduhAbH0FjaiMDlV+cTzG+3D7rXtAJSNI3bV/tborPPKSBEjRsm
         jqmSrtUlAmwVIxF9Dd6iwGe34Zx5IJEjp415rTvdbuK4J8CnsYrd+LKAhuVnAogllQcQ
         sPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50+55fOZpgMJ3ywx+S/l93zu0e/H3x84JmCU84w/5zk=;
        b=RllmjFE3FufzwrllF4QKBfFdhKs4cNpWqLpSTRKZvSckBR4WSLd1nne1RmDAY9Nzhu
         B4vSBQaMRjbxyBJ5ue+Ga9zgrQIcVLdLcPwW7EgUceF5mgChGEG8Ywim4vNqXkIjVnnk
         djjfeCVGZDFygYmHXGbv80LN3MnLPnECioOX08DxXTHp3kUamVZvOg/eVs2FDe1zpxiu
         lhCSA37Fqg4DMf4NLCWDN6cqvfp22o+tNEHki7+SEDxuXNpgG3iR+23seINinFNBfUG6
         G1MuF+rvW6nPuvhUl/RzWrGGC2DJLb5LPVeOjmRrp52X4mbgoa/S10LOkm43iXoSaJhy
         LsFg==
X-Gm-Message-State: APjAAAXowGxh1+pPaJY/trko3WxgOZSto4D68+1JqhGNS67Td8q9l0lF
        aBfsT/StSyjj5b/ZPehNjngq85+TeDiqhBvKXU6eQA==
X-Google-Smtp-Source: APXvYqzS3l7CbELaPuMRCmS340ZTE5lYOpf9CdTCmiur80L7lI/V0txZw8FoZiJ8vdITAcD+/zadl2+515h4rqpyhiQ=
X-Received: by 2002:a67:ead4:: with SMTP id s20mr3477590vso.165.1571843250696;
 Wed, 23 Oct 2019 08:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
 <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com> <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
In-Reply-To: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Oct 2019 17:06:54 +0200
Message-ID: <CAPDyKFoumdj9u1B4fQh8ws2PqvtYtVekDyq+M4nLs=hriqD-VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 22 Oct 2019 at 16:47, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Oct 21, 2019 at 11:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > > The problem I see here is that callers of this reset function aren't
> > > expecting it to work this way.  Look specifically at
> > > mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> > > things like shutdown / reinit.  Now it's true that the old
> > > mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> > > also had SDIO bluetooth, but presumably it worked OK on systems
> > > without SDIO Bluetooth.  I don't think it'll work so well now.
> >
> > Good point!
> >
> > I guess I was hoping that running through ->remove() and then
> > ->probe() for the SDIO func drivers should simply take care of
> > whatever that may be needed. In some way this makes the driver broken
> > already in regards to this path, but never mind.
>
> Yeah, probably true.  I guess if anyone actually expected to use one
> of these cards as a removable SDIO card (I have seen such dev boards
> long ago) then it would always have been possible for someone to
> remove the card at just the wrong time and break things.

Well, this isn't solely about card removal but driver removal as well.
And the latter can be managed from user space at any point in time.

>
>
> > > Testing shows that indeed your patch breaks mwifiex reset worse than
> > > it was before (AKA WiFi totally fails instead of it just killing
> > > Bluetooth).
> > >
> > > I think it may be better to add a new API call rather than trying to
> > > co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> > > make people move away from it, or something?
> >
> > Thanks again for testing and for valuable feedback! Clearly this needs
> > a little more thinking.
> >
> > An additional concern I see with the "hotplug approach" implemented in
> > $subject patch, is that it becomes unnecessary heavy when there is
> > only one SDIO func driver bound.
> >
> > In one way I am tempted to try to address that situation, as it seems
> > a bit silly to do full hotplug dance when it isn't needed.
>
> True, though I kinda like the heavy solution here.  At least in the
> mwifiex case this isn't a part of the normal flow.  AKA: we don't call
> this function during normal bootup nor during any normal operations.
> It's much more of an "oh crap, something's not working and we don't
> know what to do" type solution.  I mean, I guess it's still not
> uncommon that we end up in this code path due to the number of bugs in
> Marvell firmware, but I'm just trying to say that it's an error code
> path and not a normal one.  In my mind that means the more things we
> can re-init the better.

You have a point, but...

>
> If this was, on the other hand, a reset that we were supposed to
> always assert when doing a normal operation (like it wants us to reset
> it when we switch modes, or something) then a lighter operation would
> make more sense.

This is indeed the tricky part, as it depends on the level of bugs,
but also under what specific circumstances the reset is getting
called.

In the TI case (drivers/net/wireless/ti/wlcore/sdio.c) the reset is
executed at the "power on" case, which for example is at system
resume. And we want system resume to be as fast as possible...

I am exploring a few options to deal with both cases, let's see what I
can come up with in a day or two.

Kind regards
Uffe
