Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE340D61B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhIPJ0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhIPJ0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 05:26:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9CC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 16 Sep 2021 02:24:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s69so688653oie.13
        for <linux-wireless@vger.kernel.org>; Thu, 16 Sep 2021 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJJaNclf3wzSnd6KFncvUtNJPgnZ1G90tgAnEdwOG7Q=;
        b=SbSTnF6YB4bss2Kwu3Ep7iIEb7Q6CmnnRp4hjIFt/9Pbhj0Q711D/tuvfqU5zB2Kjc
         AjQSqIobj2DUtSFPEaZpc0U/vym4bSYEkapUidoU/gnKfC0w4vjWy521Fpw8HdYST4D3
         IQEYySJdphMWR8Qt2gOgqw395pigN34xQhmSc8LV2lP/9U7QLfqfE8GvbVcvZTd7JrBC
         7LrcCviFVgp0ib51iXroH0631blxOqX8+UwkNtj+2SLuWsDo0c5Ogh++or4k/ig36Oz+
         WKGkSIqvhC6lRVAvZQsC4fXhokL4iWJEsKMYmBKlDDbyyeoMnBIbigJwQLE3zxDBKCf8
         JZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJJaNclf3wzSnd6KFncvUtNJPgnZ1G90tgAnEdwOG7Q=;
        b=SeM+YUaOaohW1j9Rvd3klhq3smQcEysVmpEywZ8+CkULGf5tE1xpiX+Ov+/bsENGQf
         diB+zdShnAIMz0eiXunPVSsYp/svY52D8Pd86L3XEtgz/Je3rl3zMdCkdICJ+FiwSoq1
         CmqrUCOjRuzqD7DUAikBzGG/E4AFPXWRGjWIdObMGdZK7Q05L6aFN71mjQZ//1SSr6rr
         ip74sgqrlukiFSzVq176XvyohXLTIQkLiJ//KuDkgtKQaFm34UCj8a6zFnzusnriYuPz
         2Mkd9FiqWaLWir35OCXBXUJm92v0ZuacZP9S1aJwNdiIc7ma1Y+WZH3d6v1YYOb1wvxe
         MQzw==
X-Gm-Message-State: AOAM531Tgca/OG1YwPpUEk2opgnnNcPPPlJI5qn0Xx5ohXR7j6PVDBpJ
        b2S+mLb9qUKWazTiIYAf05dXVnwE2G6ATvIEchCjIw==
X-Google-Smtp-Source: ABdhPJxi7CXHXatKk6Ent0JGeDYXpkYxaElSOp3Gne6NRfOXLMwCR+A/DisuphBRfpRFcm02SiUwwPboPjwflF/uMLw=
X-Received: by 2002:aca:f189:: with SMTP id p131mr8669427oih.128.1631784285005;
 Thu, 16 Sep 2021 02:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eaacf005ca975d1a@google.com> <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
 <87mtoeb4hb.ffs@tglx> <CACT4Y+avKp8LCS8vBdaFLXFNcNiCq3vF-8K59o7c1oy86v-ADA@mail.gmail.com>
 <87k0jib2wd.ffs@tglx>
In-Reply-To: <87k0jib2wd.ffs@tglx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 11:24:33 +0200
Message-ID: <CACT4Y+ZCRiwobf0rGUoMiUEi=6Eoxvvgxxv-c+AhH=7U6M3LXQ@mail.gmail.com>
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

On Wed, 15 Sept 2021 at 11:32, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Sep 15 2021 at 11:14, Dmitry Vyukov wrote:
> > On Wed, 15 Sept 2021 at 10:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> That made me actually look at that mac80211_hwsim callback again.
> >>
> >>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
> >>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
> >>
> >> So what this does is really wrong because it tries to schedule the timer
> >> on the theoretical periodic timeline. Which goes really south once the
> >> timer is late or the callback execution took longer than the
> >> period. Hypervisors scheduling out a VCPU at the wrong place will do
> >> that for you nicely.
> >
> > Nice!
> >
> > You mentioned that hrtimer_run_queues() may not return. Does it mean
> > that it can just loop executing the same re-armed callback again and
> > again? Maybe then the debug check condition should be that
> > hrtimer_run_queues() runs the same callback more than N times w/o
> > returning?
>
> Something like that.

I've filed https://bugzilla.kernel.org/show_bug.cgi?id=214429 so that
it's not lost. Thanks.
