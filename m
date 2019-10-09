Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156F9D1454
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfJIQnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 12:43:00 -0400
Received: from muru.com ([72.249.23.125]:36202 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfJIQnA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 12:43:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 03F5E8140;
        Wed,  9 Oct 2019 16:43:31 +0000 (UTC)
Date:   Wed, 9 Oct 2019 09:42:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Message-ID: <20191009164255.GJ5610@atomide.com>
References: <20191007172800.64249-1-tony@atomide.com>
 <20191008140556.GZ5610@atomide.com>
 <87h84j7263.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h84j7263.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Kalle Valo <kvalo@codeaurora.org> [191008 14:17]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Tony Lindgren <tony@atomide.com> [191007 17:29]:
> >> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), and test
> >> for it in wlcore_runtime_resume(). But WL1271_FLAG_IRQ_RUNNING currently
> >> gets cleared too early by wlcore_irq_locked() before wlcore_irq() is done
> >> calling it. And this will race against wlcore_runtime_resume() testing it.
> >> 
> >> Let's set and clear IRQ_RUNNING in wlcore_irq() so wlcore_runtime_resume()
> >> can rely on it. And let's remove old comments about hardirq, that's no
> >> longer the case as we're using request_threaded_irq().
> >> 
> >> This fixes occasional annoying wlcore firmware reboots stat start with
> >> "wlcore: WARNING ELP wakeup timeout!" followed by a multisecond latency
> >> when the wlcore firmware gets wrongly rebooted waiting for an ELP wake
> >> interrupt that won't be coming.
> >> 
> >> Note that I also suspect some form of this issue was the root cause why
> >> the wlcore GPIO interrupt has been often configured as a level interrupt
> >> instead of edge as an attempt to work around the ELP wake timeout errors.
> >
> > So this fixed a reproducable test case where loading some webpages
> > often produced ELP timeout errors. But looks like I'm still seeing ELP
> > timeouts elsewhere. So best to wait on this one. Something is still
> > wrong with the ELP timeout handling.
> 
> Ok, I'll drop this then. Please send v3 once you think the patch is
> ready to be applied.

Looks like the real fix is to use level instead of edge interrupt
for omap4 and 5 to avoid the check for untriggered interrupts in
omap_gpio_unidle(). Should not be needed for other SoCs as their
l4per can't idle independent of the CPUs.

I'll send a separate patch for that. And I'll send an updated clean-up
patch for $subject patch as the race described above should never
happen.

The clearing of WL1271_FLAG_IRQ_RUNNING bit happens already within
pm_runtime_get_sync() section of wlcore_irq_locked(). So this patch just
happened to sligthly change the timings for my reproducable test case.
We should not be able to hit the race described above even with super
short autosuspend timeouts between wlcore_irq_locked() and the end of
wlcore_irq() :)

Regards,

Tony


> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
