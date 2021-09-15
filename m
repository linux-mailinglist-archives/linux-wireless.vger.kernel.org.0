Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA540C22D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhIOI7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 04:59:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhIOI7M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 04:59:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631696272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oO9OrB1G0+YxTYn/JMvLtBpJYNEF69i2CP96bjIn7ik=;
        b=vgC8kAEuGghuxRk6oLs9YOA4m+/CPyok0IXqSq/RQwAliqNSFG7N2sfhvA4flz/w+16dXS
        ze4J6Z3GFT8N2+Poo/b8OnWUIoqAp/7Rj5XlkcSHHqI+mEpxILlT5DUMy4rYiEdxTPzziT
        YkifNWR599qlh4v77bwqXaUfuGeqjHsAA4d0kOR2HboBNQeFb0PYmWvPyZ4/N55aQ9NF4V
        X9J0mdaE05krLDUmsixWfqH41ZVe9a0eK+Uo90phs6GArDDPp1+eD8B76DrhrKIEO0xQdy
        hgHq45m3u9aAIsM7SzSuL8m4PDncS8inBg9BGHgvqqJBFWF8iukLNWgLMHn6Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631696272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oO9OrB1G0+YxTYn/JMvLtBpJYNEF69i2CP96bjIn7ik=;
        b=9kyvvPSSWvn71+QrnJy9ImxxpNW73+vs4dy6JlrZE54kCOPRwX3FE0TRUfD1/VEtvke3SQ
        HbLcye+tf86ue0BA==
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
In-Reply-To: <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
Date:   Wed, 15 Sep 2021 10:57:52 +0200
Message-ID: <87mtoeb4hb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 14 2021 at 20:00, Dmitry Vyukov wrote:
> On Tue, 14 Sept 2021 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Now what happens when the mac80211 callback rearms the timer so it
>> expires immediately again:
>>
>>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
>>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
>>
>> bcn is a user space controlled value. Now lets assume that bcn_int is <=1,
>> which would certainly cause the loop in hrtimer_run_queues() to keeping
>> looping forever.
>>
>> That should be easy to verify by implementing a simple test which
>> reschedules a hrtimer from the callback with a expiry time close to now.
>>
>> Not today as I'm about to head home to fire up the pizza oven.
>
> This question definitely shouldn't take priority over the pizza. But I
> think I saw this "rearm a timer with a user-controlled value without
> any checks" pattern lots of times and hangs are inherently harder to
> localize and reproduce. So I wonder if it makes sense to add a debug
> config that would catch such cases right when the timer is set up
> (issue a WARNING)?

Yes and no. It's hard to differentiate between a valid short expiry
rearm and something which is caused by unchecked values. I have some
ideas but all of them are expensive and therefore probably debug
only. Which is actually better than nothing :)

> However, for automated testing there is the usual question of
> balancing between false positives and false negatives. The check
> should not produce false positives, but at the same time it should
> catch [almost] all actual stalls so that they don't manifest as
> duplicate stall reports.

Right. The problem could be even there with checked values:

       start_timer(1ms)
       timer_expires()
         callback()
           forward_timer(timer, now, period(1ms));

which might be perfectly fine with a production kernel as it leaves
enough time to make overall progress.

Now with a full debug kernel with all bells and whistels that callback
might just run into this situation:

      start_timer(1ms) T0
       timer_expires() T1
         callback()
           do_stuff()
           forward_timer(timer, TNOW, period(1ms));


T1 - T0   = 1.001ms
TNOW - T1 = 0.998 ms

So the forward will just rearm it to T0 + 2ms which means it expires in
1us.

> If I understand it correctly the timer is not actually set up as
> periodic, but rather each callback invocation arms it again. Setting
> up a timer for 1 ns _once_ (or few times) is probably fine (right?),
> so the check needs to be somewhat more elaborate and detect "infinite"
> rearming.

Yes.

That made me actually look at that mac80211_hwsim callback again.

	hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
			ns_to_ktime(bcn_int * NSEC_PER_USEC));

So what this does is really wrong because it tries to schedule the timer
on the theoretical periodic timeline. Which goes really south once the
timer is late or the callback execution took longer than the
period. Hypervisors scheduling out a VCPU at the wrong place will do
that for you nicely.

What this actually should use is hrtimer_forward_now() which prevents
that problem because it will forward the timer in the periodic schedule
beyond now. That won't prevent the above corner case, but I doubt you
can create an endless loop with that scenario as easy as you can with
trying to catch up on your theoretical timeline by using the previous
expiry time as a base for the forward. Patch below.

/me goes off to audit hrtimer_forward() usage. Sigh...

After that figure out ways to debug or even prevent this. More sigh...

Thanks,

        tglx
---
 drivers/net/wireless/mac80211_hwsim.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1867,8 +1867,8 @@ mac80211_hwsim_beacon(struct hrtimer *ti
 		bcn_int -= data->bcn_delta;
 		data->bcn_delta = 0;
 	}
-	hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
-			ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	hrtimer_forward_now(&data->beacon_timer,
+			    ns_to_ktime(bcn_int * NSEC_PER_USEC));
 	return HRTIMER_RESTART;
 }
 
