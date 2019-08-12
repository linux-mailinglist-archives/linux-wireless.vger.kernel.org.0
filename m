Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6339B8A668
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2019 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHLSkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Aug 2019 14:40:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39438 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLSj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Aug 2019 14:39:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so1384491pln.6
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2019 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgFa1SL69T309RLFZYkM7FIsdyI0JJIyDE2GolmJBeY=;
        b=LyhV/oL3l2uuMOciq09Tn2meUd+ZcTuclSu3buDD5ZowCvErYrJGdj43sCmm1GCXvj
         +N7fwsQjs74gjLArjIhRIQ+4IYt1ht5qZOLrnsFqk66jn3MVmIprh9L5w5nkqBjqEBMy
         P3LG9OutafGM2oxAkim2AxmOHMOUIX1dqkxNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgFa1SL69T309RLFZYkM7FIsdyI0JJIyDE2GolmJBeY=;
        b=DdC6hUGy4LkvNEAChSCi75oTMu6ZOVf7zYDKl1FOv4kyZOx/cb4rUpE7ZQGg7dFsbu
         GdDMLwA8nak+GEdWqpkqScKquJncIPIaVkb58Te70CfCgXE0G1fYuTbxO0g2wOjX4ImV
         UNHNztgqfC6F9ux+/cWsrTIsIUcfPaofNQWZUJxougRDJ9jc0M2p61mLFwnUXnbfoKJQ
         ygUW+LN6omGX5pMen7oAsGGaTb90QmydAfFsv2uR+sD1JnCznfNdWipmxFEwrQR3WrKS
         jJ/juPbisIqUsx2Bnp354kdy/Ellr0STFGg0BDoc6FkG6yLen31vK+8BqDUa8FrGwvDx
         Qmog==
X-Gm-Message-State: APjAAAWGbWKykSvH0t9bZLIB5Y5lL5JAbbfIoU3x4TQcYTuYBXZx6VQn
        lU9laI8H7rx81Ab1hCCMymdopSTttAA=
X-Google-Smtp-Source: APXvYqz4AUzgfMYIcdFSviOngvjAqviG5G7y34vFbWsYW6D7O0Z0mw1NGX95+F5BcVZoZ4nwae/Z/g==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr34891028plp.281.1565635198230;
        Mon, 12 Aug 2019 11:39:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i9sm119408681pgg.38.2019.08.12.11.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 11:39:57 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:39:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is
 suspended
Message-ID: <20190812183954.GQ250418@google.com>
References: <20190611123221.11580-1-ulf.hansson@linaro.org>
 <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
 <CAPDyKFqR-xSKdYZYBTK5kKOt1dk7dx_BjedHiDOKs7-X4od=dg@mail.gmail.com>
 <CAD=FV=WODbZa1fBrLbJBsd77xn5ekHWjks-ydxOSzjdBK83Rmg@mail.gmail.com>
 <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ulf,

On Fri, Jun 14, 2019 at 01:55:54PM +0200, Ulf Hansson wrote:
> On Thu, 13 Jun 2019 at 20:05, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 13, 2019 at 2:30 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > > A) Do we need to do anything extra to make sure we actually call the
> > > > interrupt handler after we've resumed?  I guess we can't actually
> > > > "lose" the interrupt since it will be sitting asserted in CCCR_INTx
> > > > until we deal with it (right?), but maybe we need to do something to
> > > > ensure the handler gets called once we're done resuming?
> > >
> > > Good point!
> > >
> > > Although, it also depends on if we are going to power off the SDIO
> > > card or not. In other words, if the SDIO IRQ are configured as a
> > > system wakeup.
> >
> > Even if it's not a system wakeup, we still don't want to drop the
> > interrupt on the ground though, do we?  For instance, think about a
> > level-triggered GPIO interrupt that's _not_ a wakeup interrupt.  If
> > that gets asserted in suspend then we won't wakeup the system, but as
> > soon as the system gets to a certain point in the resume sequence then
> > we should pass the interrupt on to the handler.  If an edge triggered
> > (but non-wakeup) interrupt fires when the system is resuming then we
> > should similarly not drop it, should we?
> 
> GPIOs is clearly different.
> 
> When it comes to SDIO cards, re-playing/re-kicking an SDIO IRQ doesn't
> make sense in case the SDIO card was powered off during system
> suspend. The reason is simply because the internal state inside the
> SDIO card gets lost at a power off. For example, the used SDIO func
> number, needs to re-enabled before any SDIO IRQs can be delivered for
> it.
> 
> So yes, I really think we should drop the SDIO IRQ, unless it's
> configured as a wakeup. Simply because it's not valid after the system
> has resumed.

With the dropped interrupts SDIO is broken on veyron jerry when
the Marvell 8997 Bluetooth controller sends events while
suspending. On the system MMC remains powered during suspend, but SDIO
isn't configured as wakeup. On this system the problem can be fixed by
processing the interrupt after resuming, however from the discussion
it seems this isn't universally a good solution.

Not sure if this is just a special case that is best worked around in
the downstream kernel of the device, or if this could affect other
systems and it would be worth to address it upstream (e.g. by
processing the dropped interrupt on resume if MMC_PM_KEEP_POWER is
set and the SDIO interrupt is not configured as wakeup).
