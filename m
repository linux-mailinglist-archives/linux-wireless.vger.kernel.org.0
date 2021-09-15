Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAE40C2CF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhIOJdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 05:33:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B871C061574;
        Wed, 15 Sep 2021 02:32:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631698323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbtaLyN7bc/D5y/kWdbb4hJQoxC3BRCKmIuJD4Msv60=;
        b=PnQrEKGeDM1uKX6dWFrx5doA2OvA8rNZ6xG3vlF/PXtN2qs29zJVCOSJMWfv+7Dcs2TlAk
        vevuwzcm4Z7UYSJuRsx5kjBLPoKNHn9IfsIe3zQfQDpLM4Nxw98n4aPgyucwmSLTgvnEqa
        Q5sXSRT9wY8aOBr2FIojQkDfrnvXL1ZXQDauodNubGglqAjfpGwvQKaCLxxODpCkbyuWRl
        tBZpYUgYR3YTYzXevs9yZuKjyfxFHS5wXgqH4TKiGVtGCBeg7SX+WYcpzrzc0PiLvxXpnc
        oF3zEduNfoCJ+ikq4Zs5cqT9gJRyBHlP4gcmWGnqgQMXwfH/nS8hvU/d3ABPPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631698323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbtaLyN7bc/D5y/kWdbb4hJQoxC3BRCKmIuJD4Msv60=;
        b=9jXDKBdeYWN3H5v3Zu/2lVd2wkzPK0jiD1YoUcfY/vX4I3fQ3JIpUMdQbDii/yBJ5UCF0R
        pbjudhEU5DZnLzCg==
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
In-Reply-To: <CACT4Y+avKp8LCS8vBdaFLXFNcNiCq3vF-8K59o7c1oy86v-ADA@mail.gmail.com>
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
 <87mtoeb4hb.ffs@tglx>
 <CACT4Y+avKp8LCS8vBdaFLXFNcNiCq3vF-8K59o7c1oy86v-ADA@mail.gmail.com>
Date:   Wed, 15 Sep 2021 11:32:02 +0200
Message-ID: <87k0jib2wd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 15 2021 at 11:14, Dmitry Vyukov wrote:
> On Wed, 15 Sept 2021 at 10:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>> That made me actually look at that mac80211_hwsim callback again.
>>
>>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
>>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
>>
>> So what this does is really wrong because it tries to schedule the timer
>> on the theoretical periodic timeline. Which goes really south once the
>> timer is late or the callback execution took longer than the
>> period. Hypervisors scheduling out a VCPU at the wrong place will do
>> that for you nicely.
>
> Nice!
>
> You mentioned that hrtimer_run_queues() may not return. Does it mean
> that it can just loop executing the same re-armed callback again and
> again? Maybe then the debug check condition should be that
> hrtimer_run_queues() runs the same callback more than N times w/o
> returning?

Something like that.
