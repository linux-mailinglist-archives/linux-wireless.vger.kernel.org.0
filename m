Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D3A205B1E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbgFWSs6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 14:48:58 -0400
Received: from muru.com ([72.249.23.125]:59146 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733138AbgFWSs6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 14:48:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA48E816A;
        Tue, 23 Jun 2020 18:49:49 +0000 (UTC)
Date:   Tue, 23 Jun 2020 11:48:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] wlcore: Use spin_trylock in wlcore_irq_locked() for
 running the queue
Message-ID: <20200623184854.GO37466@atomide.com>
References: <20200617212505.62519-1-tony@atomide.com>
 <20200617212505.62519-2-tony@atomide.com>
 <875zbjgpbj.fsf@codeaurora.org>
 <20200622160628.GL37466@atomide.com>
 <87wo3ye11n.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo3ye11n.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Kalle Valo <kvalo@codeaurora.org> [200623 06:46]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kalle Valo <kvalo@codeaurora.org> [200622 14:15]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> > We need the spinlock to check if we need to run the queue. Let's use
> >> > spin_trylock instead and always run the queue unless we know there's
> >> > nothing to do.
> >> 
> >> Why? What's the problem you are solving here?
> >
> > To simplify the flags and locking use between the threaded irq
> > and tx work.
> >
> > While chasing an occasional hang with an idle wlan doing just a
> > periodic network scans, I noticed we can start simplifying the
> > locking between the threaded irq and tx work for the driver.
> >
> > No luck so far figuring out what the occasional idle wlan hang is,
> > but I suspect we end up somewhere in a deadlock between tx work
> > and the threaded irq.
> >
> > We currently have a collection of flags and locking between the
> > threaded irq and tx work:
> >
> > - wl->flags bitops
> > - wl->mutex
> > - wl->wl_lock spinlock
> >
> > The bitops flags do not need a spinlock around them, and
> > wlcore_irq() already holds the mutex calling wlcore_irq_locked().
> > And we only need the spinlock to see if we need to run the queue
> > or not.
> >
> > So I think eventually we can remove most of the spinlock use in
> > favor of the mutex. I guess I could leave out the trylock changes
> > here if this is too many changes at once.
> >
> > Or do you see some problem in general with this approach?
> 
> My only problem was lack of background information in the commit logs.
> Conditional locking is tricky and I didn't figure out why you are doing
> that and why it's safe to do. So if you could send v2 with the
> information above in the commit log I would be happy.

OK. I'll update the description for the patches and resend.

Thanks,

Tony

