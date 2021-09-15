Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764340C29A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhIOJPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhIOJPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 05:15:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CDC061575
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 02:14:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w144so3251583oie.13
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2R5sQocnc5nHBs+VrySqd2CEimyp7idPHRQqGykyb8=;
        b=QsgOKFYHtP7k3b0fDCYInl3hodXFFr8+LOxQTNgoDGCPfFBy2oVBYEP8+fYh6Bjb0t
         Baoga54t4aVFdX2EGvkEqd53Gpz/6lK+FT2AiGOBRbtOPjHKkixjaxkGgh8Z8UbKSMXn
         pRNTqSeHX7M3xZRRs9VHFbJHJV76pOsW6ToYi4mT2pxnbwWFbeHLDD9lIKZwZFelkuv/
         2s5RbMJUmXOPFXBxLuSp8Pe5GUZjVWaC0dXr3FqAEakFYh0LbPVMEyFX5YDXfeelTeex
         qKQ8F70AKSdCcIg8J+MHoIkH97pgbYUQGLzQyl8J2lwqKiouuqFqDhApKT1pzoT4xlId
         V34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2R5sQocnc5nHBs+VrySqd2CEimyp7idPHRQqGykyb8=;
        b=vTGr/uXGpZDKIVPd32OdFuvsMLX5XhBXtfKNAl8OYGwslNamEV1R2KRZKG8Tc+Eg9E
         0Qzn4Ro9NZWFkyh8tMwqfCzGn5CDIEDerpR0QOJ8KnGiN8lLztu3BdY+aTr6/qoMIN0J
         k5FxLBL9Va7KCD60AnyuDAxoC8bDflIr5NPwf7Jh8qpejiAloetbvYhIBuutPUnrm9r3
         Gy5XCllLbQZos2NNvuR5ic/gOqL8kz8GSE3wvhpX32f91TbDBEeeuYzKYhZrV3GRXYBl
         pjELUsF4stwYiWKU3a7DwLImxaOECIcOHeSSrHlVdMf41rQHE6yfGBVQ9Cwp5Fx/VnFH
         H4LA==
X-Gm-Message-State: AOAM532irEzC8aLBFzyB7z1s9YtNvbZE5I69M+StxgrDrqpmiznGY2+0
        oLuOf6o9MfUL0Rldr7T9tcA5lx8cSyPxa102GNEU8A==
X-Google-Smtp-Source: ABdhPJxrplVg3i7lev3jvD1KetqKrk8zl3U6724cMh67wfpVYOS0SD87U9serb5ZgRgxlO/ByXmi7ENyfRIlyg+0QQU=
X-Received: by 2002:aca:f189:: with SMTP id p131mr4569843oih.128.1631697257294;
 Wed, 15 Sep 2021 02:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eaacf005ca975d1a@google.com> <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com> <87mtoeb4hb.ffs@tglx>
In-Reply-To: <87mtoeb4hb.ffs@tglx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Sep 2021 11:14:06 +0200
Message-ID: <CACT4Y+avKp8LCS8vBdaFLXFNcNiCq3vF-8K59o7c1oy86v-ADA@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 15 Sept 2021 at 10:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Sep 14 2021 at 20:00, Dmitry Vyukov wrote:
> > On Tue, 14 Sept 2021 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Now what happens when the mac80211 callback rearms the timer so it
> >> expires immediately again:
> >>
> >>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
> >>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
> >>
> >> bcn is a user space controlled value. Now lets assume that bcn_int is <=1,
> >> which would certainly cause the loop in hrtimer_run_queues() to keeping
> >> looping forever.
> >>
> >> That should be easy to verify by implementing a simple test which
> >> reschedules a hrtimer from the callback with a expiry time close to now.
> >>
> >> Not today as I'm about to head home to fire up the pizza oven.
> >
> > This question definitely shouldn't take priority over the pizza. But I
> > think I saw this "rearm a timer with a user-controlled value without
> > any checks" pattern lots of times and hangs are inherently harder to
> > localize and reproduce. So I wonder if it makes sense to add a debug
> > config that would catch such cases right when the timer is set up
> > (issue a WARNING)?
>
> Yes and no. It's hard to differentiate between a valid short expiry
> rearm and something which is caused by unchecked values. I have some
> ideas but all of them are expensive and therefore probably debug
> only. Which is actually better than nothing :)
>
> > However, for automated testing there is the usual question of
> > balancing between false positives and false negatives. The check
> > should not produce false positives, but at the same time it should
> > catch [almost] all actual stalls so that they don't manifest as
> > duplicate stall reports.
>
> Right. The problem could be even there with checked values:
>
>        start_timer(1ms)
>        timer_expires()
>          callback()
>            forward_timer(timer, now, period(1ms));
>
> which might be perfectly fine with a production kernel as it leaves
> enough time to make overall progress.
>
> Now with a full debug kernel with all bells and whistels that callback
> might just run into this situation:
>
>       start_timer(1ms) T0
>        timer_expires() T1
>          callback()
>            do_stuff()
>            forward_timer(timer, TNOW, period(1ms));
>
>
> T1 - T0   = 1.001ms
> TNOW - T1 = 0.998 ms
>
> So the forward will just rearm it to T0 + 2ms which means it expires in
> 1us.
>
> > If I understand it correctly the timer is not actually set up as
> > periodic, but rather each callback invocation arms it again. Setting
> > up a timer for 1 ns _once_ (or few times) is probably fine (right?),
> > so the check needs to be somewhat more elaborate and detect "infinite"
> > rearming.
>
> Yes.
>
> That made me actually look at that mac80211_hwsim callback again.
>
>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
>
> So what this does is really wrong because it tries to schedule the timer
> on the theoretical periodic timeline. Which goes really south once the
> timer is late or the callback execution took longer than the
> period. Hypervisors scheduling out a VCPU at the wrong place will do
> that for you nicely.

Nice!

You mentioned that hrtimer_run_queues() may not return. Does it mean
that it can just loop executing the same re-armed callback again and
again? Maybe then the debug check condition should be that
hrtimer_run_queues() runs the same callback more than N times w/o
returning?


> What this actually should use is hrtimer_forward_now() which prevents
> that problem because it will forward the timer in the periodic schedule
> beyond now. That won't prevent the above corner case, but I doubt you
> can create an endless loop with that scenario as easy as you can with
> trying to catch up on your theoretical timeline by using the previous
> expiry time as a base for the forward. Patch below.
>
> /me goes off to audit hrtimer_forward() usage. Sigh...
>
> After that figure out ways to debug or even prevent this. More sigh...
>
> Thanks,
>
>         tglx
> ---
>  drivers/net/wireless/mac80211_hwsim.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -1867,8 +1867,8 @@ mac80211_hwsim_beacon(struct hrtimer *ti
>                 bcn_int -= data->bcn_delta;
>                 data->bcn_delta = 0;
>         }
> -       hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
> -                       ns_to_ktime(bcn_int * NSEC_PER_USEC));
> +       hrtimer_forward_now(&data->beacon_timer,
> +                           ns_to_ktime(bcn_int * NSEC_PER_USEC));
>         return HRTIMER_RESTART;
>  }
>
