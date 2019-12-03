Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD71104B1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfLCTC7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 14:02:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36200 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfLCTC7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 14:02:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id f16so3928070lfm.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2019 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WKfh6GWqcaSVgesRgdbFaj17CDDjaivkWCoA/zzVuzk=;
        b=A6OMwBIPYhKqtUoc0aqT172eH5LSzXX/5Yj6kINNSYyyohieCqtm8KN9j84YPz3twY
         NYJjl0S/O3YKRiTtOQZnMlm5u55uHlRnRVnynJ+1trJlHL6XAhvFqR45LIIpOGew51S5
         LP/QchwQaGmpcNQv9r1ZTOWJaojXMcsySaFo0SF7RgKhn7IyZifuKPZFekTe+hes4TPf
         zP9GY6RqiVCL/+LE6h1uD07DIzKWuWhBstKhFVnVbJWEzYQnjdyiYXtVJx2UDLxuxntu
         KKvFWwDftVdkqChyV4pZHjHezUBTPsxMBKX/UICNrkycZv0MbZwrGZnkpccFYaDvlT6q
         nIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WKfh6GWqcaSVgesRgdbFaj17CDDjaivkWCoA/zzVuzk=;
        b=AFJwSUbHeQaeYkg0RpsNUzg8/LlGxQQUg+Mbb928GCAqPJkkqUIoYHxJgxeo10Z6zs
         bW7l+f+jFw1q6UBF7riOg1J0SHE4nlMjwuEVNu2SfcVsCiw4d89gKSS7Klf2gbdXvm/S
         Ste/IZ73KmmDmOuo5p75dIVIrdvgsk6w54D2X2xdDRdIrUiiixoGQlbVTE3h/C95mfhS
         BLkJe2SkdumldQM0a0mynPdq8+p6VpuXaWEdWR4qwg9+fz0WgCOP/w1bh5h5G5TiDkEO
         4/WM6P1GhP5pnjdHdSR5Q1IOfFGt91qv/sDJrRXcpEtcuxpcaS+jH5ZrflDElqvoUNNA
         LW/A==
X-Gm-Message-State: APjAAAXbMCbUwiBrybt4DiLEs5g8+d/KJXtkt1rVqdu037joRg4bGuIx
        FgS32gzhnbUxGhedJbKW3nWV495DCSNaizeefp0LYA==
X-Google-Smtp-Source: APXvYqwitBPEhqoOUjaebGsAJwes+hxPAol9nfWGNbmaAJN5OleoZyKQjuozpKuBKgirVI2D/UnH7s7CF11QUYliVoA=
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr3647289lfp.88.1575399775967;
 Tue, 03 Dec 2019 11:02:55 -0800 (PST)
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
In-Reply-To: <878so2m5gp.fsf@nemesis.taht.net>
From:   Kan Yan <kyan@google.com>
Date:   Tue, 3 Dec 2019 11:02:44 -0800
Message-ID: <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
To:     Dave Taht <dave@taht.net>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
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

Dave Taht <dave@taht.net> writes:

> I hope to take a close look at the iwl ax200 chips soon. Unless
> someone beats me to it. Can we get these sort of stats out of it?

Here is a patch for the trace event I used to get the sojourn time:
https://drive.google.com/open?id=3D1Mq8BO_kcneXBqf3m5Rz5xhEMj9jNbcJv

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> While you're running tests, could you do one with the target changed to
> 10ms, just to see what it looks like? Both sojourn time values and
> throughput would be interesting here, of course.

Apologize for the late reply. Here is the test results with target set to 1=
0ms.
The trace for the sojourn time:
https://drive.google.com/open?id=3D1MEy_wbKKdl22yF17hZaGzpv3uOz6orTi

Flent test for 20 ms target time vs 10 ms target time:
https://drive.google.com/open?id=3D1leIWe0-L0XE78eFvlmRJlNmYgbpoH8xZ

The sojourn time measured during throughput test with a relative good
5G connection has mean value around 11 ms, pretty close to the 10 ms
target.

A smaller CoDel "target" time could help reduce latency, but it may
drop packets too aggressively for stations with low data rate and
hurts throughput, as shown in one of the tests with 2.4 GHz client.

Overall, I think AQL and fq_codel works well, at least with ath10k.
The current target value of 20 ms is a reasonable default.  It is
relatively conservative that helps stations with weak signal to
maintain stable throughput. Although, a debugfs entry that allows
runtime adjustment of target value could be useful.

On Tue, Nov 26, 2019 at 6:13 PM Dave Taht <dave@taht.net> wrote:
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
> > Kan Yan <kyan@google.com> writes:
> >
> >>> Yeah, bpftrace can be a bit of a pain to get running; but it may be
> >>> worth the investment longer term as well. It really is quite useful! =
:)
> >>
> >> My attempt to build bpftrace didn't work out, so I just got the
> >> sojourn time using old fashioned trace event.
> >> The raw trace, parsed data in csv format and plots can be found here:
> >> https://drive.google.com/open?id=3D1Mg_wHu7elYAdkXz4u--42qGCVE1nrILV
> >>
> >> All tests are done with 2 TCP download sessions that oversubscribed
> >> the link bandwidth.
> >> With AQL on, the mean sojourn time about ~20000us, matches the default
> >> codel "target".
> >
> > Yeah, since CoDel is trying to control the latency to 20ms, it makes
> > sense that the value is clustered around that. That means that the
> > algorithm is working as they're supposed to :)
> >
> > While you're running tests, could you do one with the target changed to
> > 10ms, just to see what it looks like? Both sojourn time values and
> > throughput would be interesting here, of course.
> >
> >> With AQL off, the mean sojourn time is less than 4us even the latency
> >> is off the charts, just as we expected that fd_codel with mac80211
> >> alone is not effective for drivers with deep firmware/hardware queues
>
> I hope to take a close look at the iwl ax200 chips soon. Unless
> someone beats me to it. Can we get these sort of stats out of it?
>
> Has anyone looked at the marvell chips of late?
>
> >
> > Yup, also kinda expected; but another good way to visualise the impact.
> > Nice!
> >
> > -Toke
> >
> > _______________________________________________
> > Make-wifi-fast mailing list
> > Make-wifi-fast@lists.bufferbloat.net
> > https://lists.bufferbloat.net/listinfo/make-wifi-fast
