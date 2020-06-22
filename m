Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E183203C26
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgFVQGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 12:06:32 -0400
Received: from muru.com ([72.249.23.125]:58622 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgFVQGb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 12:06:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B52CA8140;
        Mon, 22 Jun 2020 16:07:23 +0000 (UTC)
Date:   Mon, 22 Jun 2020 09:06:28 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] wlcore: Use spin_trylock in wlcore_irq_locked() for
 running the queue
Message-ID: <20200622160628.GL37466@atomide.com>
References: <20200617212505.62519-1-tony@atomide.com>
 <20200617212505.62519-2-tony@atomide.com>
 <875zbjgpbj.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zbjgpbj.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Kalle Valo <kvalo@codeaurora.org> [200622 14:15]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > We need the spinlock to check if we need to run the queue. Let's use
> > spin_trylock instead and always run the queue unless we know there's
> > nothing to do.
> 
> Why? What's the problem you are solving here?

To simplify the flags and locking use between the threaded irq
and tx work.

While chasing an occasional hang with an idle wlan doing just a
periodic network scans, I noticed we can start simplifying the
locking between the threaded irq and tx work for the driver.

No luck so far figuring out what the occasional idle wlan hang is,
but I suspect we end up somewhere in a deadlock between tx work
and the threaded irq.

We currently have a collection of flags and locking between the
threaded irq and tx work:

- wl->flags bitops
- wl->mutex
- wl->wl_lock spinlock

The bitops flags do not need a spinlock around them, and
wlcore_irq() already holds the mutex calling wlcore_irq_locked().
And we only need the spinlock to see if we need to run the queue
or not.

So I think eventually we can remove most of the spinlock use in
favor of the mutex. I guess I could leave out the trylock changes
here if this is too many changes at once.

Or do you see some problem in general with this approach?

Regards,

Tony
