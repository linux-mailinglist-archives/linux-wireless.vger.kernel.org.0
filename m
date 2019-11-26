Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58050109870
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfKZFEi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 00:04:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41589 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKZFEi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 00:04:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so18569257ljj.8
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 21:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JQSdHWPAU2nitRvT0Di7Ib4QABBb5+QiA8tiP3X9DWM=;
        b=lRned6cZi6/wDX1xJ1HLugPH2HIWLAYfrFFbV5Y5oAcFWELce6f+opZWj8td6z0XNB
         k8QaFu+1RuA6mRb6k5xImAYyuEqIs/5RktUh92Mf1W/F9z/AaiEK+lGAUctcjdbJj4RR
         7cIdRNW6MzmSYifH29aeislagfZslmXmofI5n55rTGY6AYHNYnAzXu/OQfLxhoOOzFP2
         MMmVDBGqiuDpDvGwnDsqdMC3TlTl4xlDDzzyxZmRx9shgiXdB2xjfmG+wnXw9dqWE1ak
         jU3JPtw85qRh/Wex4UWXpT6hECE89NXzNikKzqO9jc1HxjBzorcm53qyHJzNYjs/wG/W
         99xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JQSdHWPAU2nitRvT0Di7Ib4QABBb5+QiA8tiP3X9DWM=;
        b=bwZPBqOFULCXhm9V+WgZmFiR/GfYnq73k5GyYNeKUWOfHAsD/z5/Lj4EAeQysbr0aK
         Uf+iztjVUg/UF8onQZRZQAjGBbywfrwWCZh08rgcNbtVXyJcncLcwobv/QxdmYX3YF9+
         RUf5AUUi2cQ0BcwxXrGftJgXG9G5Xn1myPqKfQin9Sxv84y86qvasvQatgnJvCzaCv16
         6rGEGOjL5Fj3mWh+/XYfSvKqfFSlM1p4puu0BJNaIbg+xySV3QHgdz7fptpn3Umdkle1
         agvpIPKHjDJ5Bg03OSmzX3nWQKvXfu1uFfwJAokmbXSRck5fcVaNCFWIiIykGEoVG42T
         jHZA==
X-Gm-Message-State: APjAAAUYN0IbrV36QUpNHctHLLR+D9G2aze2/IN8jU2lR0R6jHFQkqyC
        V/yxQOVK4cTkbhSsLJ23M6lV04bokDIB4mRw7GsayQ==
X-Google-Smtp-Source: APXvYqyw6ShEcPeBSRIAOlL/m3Z6ruiZ+OtmTjgBZIE0N6S7H2FMAooQF4M3qp5TnHittIM67oemZRzavLd2PRI/zHI=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr24686240ljd.10.1574744675047;
 Mon, 25 Nov 2019 21:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
 <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
 <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
 <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
 <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
 <8736eiam8f.fsf@toke.dk> <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
 <87a78p8rz7.fsf@toke.dk> <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
 <87muco5gv5.fsf@toke.dk>
In-Reply-To: <87muco5gv5.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Mon, 25 Nov 2019 21:04:23 -0800
Message-ID: <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Dave Taht <dave.taht@gmail.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Yeah, bpftrace can be a bit of a pain to get running; but it may be
> worth the investment longer term as well. It really is quite useful! :)

My attempt to build bpftrace didn't work out, so I just got the
sojourn time using old fashioned trace event.
The raw trace, parsed data in csv format and plots can be found here:
https://drive.google.com/open?id=3D1Mg_wHu7elYAdkXz4u--42qGCVE1nrILV

All tests are done with 2 TCP download sessions that oversubscribed
the link bandwidth.
With AQL on, the mean sojourn time about ~20000us, matches the default
codel "target".
With AQL off, the mean sojourn time is less than 4us even the latency
is off the charts, just as we expected that fd_codel with mac80211
alone is not effective for drivers with deep firmware/hardware queues.

> Any chance you could turn ecn on and off and give it a go
> again in your next test run?

ECN on shows very similar results as with ECN off. "aqm" stats from
debugfs shows it is doing ECN marking instead of dropping packets as
expected. Flent test data also is in the same link.



On Fri, Nov 22, 2019 at 2:45 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> >> In theory, this ought to produce a histogram of sojourn times (in
> >> microseconds):
> >> bpftrace -e 'kretprobe:codel_skb_time_func { @sojourn =3D lhist((nsecs=
 -
> > (retval << 10))/1000, 0, 100000, 1000); }'
> >
> > Thanks for the tips!
> >
> >> Can't get the CoDel drop mechanism to trigger on my system at all,
> >> though (a laptop running on iwl). I guess because there's queue
> >> backpressure to userspace first?
> >
> > What's the tcp_congestion_control in your system? Maybe it is BBR that
> > prevents bufferbloat.
>
> It's not BBR, just plain old CUBIC. I've seen the issue before that it's
> almost impossible to build a queue in the mac80211 layer when the TCP
> session is originated on the local machine, though...
>
> >> It would be interesting to see if it works for you, assuming you can g=
et
> >> bpftrace to work on your test system :)
> >
> > I can enable required kernel configuration easily, but cross-compile
> > bpftrace for an ARM64 platform may take some time and effort.
>
> Yeah, bpftrace can be a bit of a pain to get running; but it may be
> worth the investment longer term as well. It really is quite useful! :)
>
> Some links:
>
> Install guide:
> https://github.com/iovisor/bpftrace/blob/master/INSTALL.md
>
> Tutorial by one-liners:
> https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.=
md
>
> Reference guide:
> https://github.com/iovisor/bpftrace/blob/master/docs/reference_guide.md#5=
-tracepoint-static-tracing-kernel-level
>
> -Toke
>
