Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016E41158ED
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFWE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 17:04:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32923 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFWE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 17:04:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so6428208lfl.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2019 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REclCB1pv4dj9b8U2bYRObXlAu7fa21jBQQM0L2wVGU=;
        b=QslVPX5zjzDwzQT2lT+y9MjvCbJGzr2K16EI8S9ABs7+M9ei0WuWo/8Diq63JlwQd/
         gMhuA9LKPVXiATq9Zm5XDNNxSSZ5IG5221gxfECjJyIPpk8Fpo414geQ8sIyFvWDmIEk
         5Ob4uBNvasVLE+1iVMc8qDL7pMqcz9HiYpbFIYFjsgYa+h8G0oG2lezL79jRZGkiNNqF
         6HecVrdX3rsA1KIscdkX/hkazgZjvDOIS0OWyRxxYErBMPlh4pJ8q/HRb4bPSSgHbxHC
         B43Aamh49vVhVllkBVDZIFahfAD0RytQ+TmWqmLKAfEa4WD2q3uc80t8Ed1WNGwqYyb3
         3KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REclCB1pv4dj9b8U2bYRObXlAu7fa21jBQQM0L2wVGU=;
        b=Q3v1rASA6iAvpxOrayLwjnDPj8dJt1xRP0BTefam5X4aA4XBCeWNFicPImGTOocQYe
         RlpY3Y9WpJAYAtE1JWWj5O11J/3ZhtaLuypNUs13t2mH7zAcXhVVR/ulInph9M5oPDIq
         DBefPKvt+HPJbj723rm+tq3/FVPnkBhJ8M639sQKR6VO3FtilFHpOVNT8gDVGWkBbLIw
         Zkf78p8jdV2X2AyEV/0I6x2yYHnc00x6yz9HyK+I0m3eYG9UsyL6IUJZhkko4htUgsCS
         +Izp8IZHOYqv3DiV1NwVi22tL5R2kvmv6I165VtuWHBpBXOw3q9Z4rSUef0wXJyrlokh
         Ucog==
X-Gm-Message-State: APjAAAUoM0CfNmsYdodc3yI+3sgrMMJ5aZvA6rQuQOhztvI1yDbjI3n5
        0Ahk2gibdVCzn+P5NlQdyMsWFwv/qZ6MdsawLZJQAA==
X-Google-Smtp-Source: APXvYqwFeR4uFiVGJ1lZGHYFU2XiRLgwbZzYVhlfH4V6PbOObFlNRJnCMGPU7Yw1LpcanbHXxtwP/3u0/vLNJFotMjU=
X-Received: by 2002:a19:4906:: with SMTP id w6mr9234164lfa.168.1575669895961;
 Fri, 06 Dec 2019 14:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
 <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
 <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
 <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
 <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
 <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
 <87a78p8rz7.fsf@toke.dk> <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
 <87muco5gv5.fsf@toke.dk> <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
 <87eexvyoy8.fsf@toke.dk> <878so2m5gp.fsf@nemesis.taht.net>
 <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com>
 <0101016ecf3bc899-6e391bba-96ed-4495-a7be-1aa8dd8f1bf2-000000@us-west-2.amazonses.com>
 <fa98f3b62454370ef6c1951571ba1789ac2679c3.camel@sipsolutions.net> <87h82dkz8i.fsf@taht.net>
In-Reply-To: <87h82dkz8i.fsf@taht.net>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 6 Dec 2019 14:04:44 -0800
Message-ID: <CA+iem5tqEwceNpo7O_J8=oDpAxotbzFrSNUxhfB4BxB9yWNYJg@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
To:     Dave Taht <dave@taht.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dave Taht (taht.net) writes:

> Judging from kan's (rather noisy) data set 10ms is a good default on
> 5ghz. There is zero difference in throughput as near as I can tell.
> It would be interesting to try 3ms (as there's up to 8ms of
> buffering in the driver) to add to this dataset, helpful also
> to be measuring the actual tcp rtt rather in addition to the fq behavior.

One large aggregation in 11ac can last 4-5 ms, with bursting,
firmware/hardware can complete as much 8 -10 ms worth of frames in one
shot and then try to dequeue more frames, so the jitter for the
sojourn time can be as high as 8-10 ms. Setting the default target to
something less than 10ms can cause unnecessary packet drop in some
occasions.


On Fri, Dec 6, 2019 at 11:53 AM Dave Taht <dave@taht.net> wrote:
>
> Johannes Berg <johannes@sipsolutions.net> writes:
>
> > On Wed, 2019-12-04 at 04:47 +0000, Kalle Valo wrote:
> >>
> >> > Overall, I think AQL and fq_codel works well, at least with ath10k.
> >> > The current target value of 20 ms is a reasonable default.
>
> >> > It is
> >> > relatively conservative that helps stations with weak signal to
> >> > maintain stable throughput.
>
> This statement is overbroad and largely incorrect.
>
> >>> Although, a debugfs entry that allows
> >> > runtime adjustment of target value could be useful.
> >>
> >> Why not make it configurable via nl80211? We should use debugfs only for
> >> testing and debugging, not in production builds, and to me the use case
> >> for this value sounds like more than just testing.
>
> I certainly lean towards making it configurable AND autotuning it
> better.
>
> > On the other hand, what application/tool or even user would be able to
> > set this correctly?
>
> The guideline from the theory ("Power") is the target should 5-10% of
> the interval, and the interval fairly close to the most commonly
> observed max RTT. I should try to stress (based on some statements made
> here) - that you have to *consistently* exceed the target for the
> interval, in order for codel to have any effect at all. Please try to
> internalize that - the smoothing comes from the interval... 100ms is
> quite a large interval....
>
> Judging from kan's (rather noisy) data set 10ms is a good default on
> 5ghz. There is zero difference in throughput as near as I can tell.
>
> It would be interesting to try 3ms (as there's up to 8ms of
> buffering in the driver) to add to this dataset, helpful also
> to be measuring the actual tcp rtt rather in addition to the fq behavior.
>
> I see what looks like channel scan behavior in the data. (on the
> client?) Running tests for 5 minutes will show the impact and frequency
> of channel scans better.
>
> The 20ms figure we used initially was due to a variety of factors:
>
> * This was the first ever attempt at applying an AQM technology to wifi!!!
> ** FIXED: http://blog.cerowrt.org/post/real_results/
> * We were debugging the FQ component, primarily.
> ** FIXED: http://blog.cerowrt.org/post/crypto_fq_bug/
> * We were working on backports and on integrating a zillion other pieces
>   all in motion.
> ** sorta FIXED. I know dang full well how many darn variables there
>    are, as well as how much the network stack has changed since the initial work.
> *  We were working on 2.4ghz which has a baseline rate of 1Mbit (13ms target)
>    Our rule of thumb is that min target needs to MTU*1.5. There was also a
>    a fudge factor to account for half duplex operation and the minimum
>    size of a txop.
> ** FIXED: 5ghz has a baseline rate of 6mbits.
> * We didn't have tools to look at tcp rtts at the time
> ** FIXED: flent --socket-stats tcp_nup
> * We had issues with power save
> ** Everybody has issues with powersave...
> ** These are still extant on many platforms, notably ones that wake up
>    and dump all their accumulated mcast data into the link. Not our problem.
> * channel scans: http://blog.cerowrt.org/post/disabling_channel_scans/
> **  Non background channel scans are very damaging. I am unsure from this
>     data if that's what we are seeing from the client? Or the ath10k?
>     the ability to do these in the background or notmight be a factor in
>     autotuning things better.
> * We had MAJOR issues with TSQ
> ** FIXED: https://lwn.net/Articles/757643/
>
> Honestly the TSQ interaction was the biggest barrier to figuring out
> what was going wrong at the time we upstreamed this, and a tcp_nup test,
> now, with TSQ closer to "right", AQL in place and the reduced target
> should be interesting. I think the data we have now on TSQ vs wifi on
> this chip, is now totally obsolete.
>
> * We had issues with mcast
> ** I think we still have many issues with multicast but improving that
>    is a separate problem entirely.
> * We ran out of time and money, and had hit it so far out of the park
>   ( https://lwn.net/Articles/705884/ )
>   that it seemed like sleeping more and tweaking things less was a win.
>
> Judging from the results we now get on 5ghz and on ac, it seems good to
> reduce the target to 10ms (or less!) on 5ghz ghz, especially on ac,
> which will result in a less path inflation and no loss in throughput.
>
> I have been running with a 6ms target for several years now on my
> 802.11n 5ghz devices. (I advertise a 3ms rather than the default txop
> size also) These are, admittedly, mostly used as backhaul
> links (so I didn't have tsq, aql, rate changes, etc) , but seing a path
> inflation of no more than 30ms under full bidirectional load is
> nice. (and still 22ms worse than it could be in a more perfect world)
>
> Another thing I keep trying to stress: TCP's ability to grab more
> bandwidth is quadratic relative the delay.
>
> >
> > johannes
