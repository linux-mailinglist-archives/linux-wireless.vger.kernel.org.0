Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4261BCE98
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgD1VYg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 17:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1VYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 17:24:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F6C03C1AC
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 14:24:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so23442548qkg.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQ48yejej/2CpQ2/euVAVFYjvaWIvTEf9J0038bBjKc=;
        b=nDb3XX4UYrDn5DoJJz3CYcPdIDUVj8UAYBVn4vpM3/LaiQn/C4SMAIMHAcGVMKHT9x
         Ok6w0cQHJF632btm+njg1WiLGax0xx2mLu+xiLFnCS00pBJKJjvlnzisCNljFi7Wf1Hv
         hqUWhcDRBTZkHdML+85OZHJEDjAPtd/joI8pUdA9ks6w/KC7Tlgi2beDe8/RooVfH8Bd
         ll4BvRuk+iHlyxz9ajGqBs+F9jgZTIonuKxLEJxn+hyn53i5BrrDQrrukSdGI9Y5HVkw
         NrceJrc5TOHZgld42Ajkx6rRtdxWRE0rr1wv+L1pudiSwtsRpv1ZXGpGM5XzLJiwfk7/
         cb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQ48yejej/2CpQ2/euVAVFYjvaWIvTEf9J0038bBjKc=;
        b=H5qHgpYlqYAeOttT4qomGJvNlWTEnKyVzXpNGwXhig/W/3hlITwLWvsj1Fck7ope9r
         aDXbZeCggCzPnzw9ZichDt9w7lISHPF7DgRSvJk7vDCuL8JdpFufBp53st5bILAQNm8u
         VsUIR69t4e/wcSZxAlYsus0D84Mw5Mb5zSrFgnOM2+vO7tjChg0HPp6iOSNLkaxPA/i3
         MaOV6EsMdrEvL56JonY23cr0hchEnHvXe7Ge2BDvPrISN4AxqToDIvWF+dZTLPyLBolQ
         IKx6gny+lQ2AyLvlO4XEJb6ObDBFIhirW3yy6ImNI0Dvnqxms6IlUmgYcdGrufgiu/aK
         qE0Q==
X-Gm-Message-State: AGi0PuY3wycXKW0ovANSMvViqKa4GhovVna59MshKfDKHtxxjUXmeGqa
        vTioL0EdxhQpgdXGZZuLEPLuAjYhvN+gW0PvIAlmyo3u
X-Google-Smtp-Source: APiQypKTbVPZvStje4mrTO7Ney7rc6P2EXEhKFp0v2flJlCfS6yZT0m3HYdo0L59yMrqwtr7esOJQZc/7ERy0/zbkHk=
X-Received: by 2002:a37:a6d1:: with SMTP id p200mr29880998qke.198.1588109074611;
 Tue, 28 Apr 2020 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145435.13151-1-greearb@candelatech.com>
 <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
 <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com> <87k11zv1ux.fsf@toke.dk>
 <CAA93jw7exafEx3YkvR5uaaBm5kxzYp3nw14zMfgT=2SwUjaQFg@mail.gmail.com>
 <f0f8b69f-3c1e-2f11-77fe-5c881120cca4@candelatech.com> <874kt3uy33.fsf@toke.dk>
In-Reply-To: <874kt3uy33.fsf@toke.dk>
From:   Steve deRosier <derosier@gmail.com>
Date:   Tue, 28 Apr 2020 14:23:58 -0700
Message-ID: <CALLGbRJrZojQQF-MaUr1HYVZ0=i8CbqR=gfq14KznAc74pzUeg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     Ben Greear <greearb@candelatech.com>,
        Dave Taht <dave.taht@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 1:58 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke=
.dk> wrote:
>
> Ben Greear <greearb@candelatech.com> writes:
>
> > On 04/28/2020 12:39 PM, Dave Taht wrote:
> >> On Tue, Apr 28, 2020 at 12:37 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@toke.dk> wrote:
> >>>
> >>> Ben Greear <greearb@candelatech.com> writes:
> >>>
> >>>> On 04/28/2020 07:56 AM, Steve deRosier wrote:
> >>>>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
> >>>>>>
> >>>>>> From: Ben Greear <greearb@candelatech.com>
> >>>>>>
> >>>>>> While running tcp upload + download tests with ~200
> >>>>>> concurrent TCP streams, 1-2 processes, and 30 station
> >>>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
> >>>>>> around 20% of the CPU according to perf-top, which other locking
> >>>>>> taking an additional ~15%.
> >>>>>>
> >>>>>> I believe the issue is that the ath10k driver would unlock the
> >>>>>> txqueue when a single frame could be transmitted, instead of
> >>>>>> waiting for a low water mark.
> >>>>>>
> >>>>>> So, this patch adds a low-water mark that is 1/4 of the total
> >>>>>> tx buffers allowed.
> >>>>>>
> >>>>>> This appears to resolve the performance problem that I saw.
> >>>>>>
> >>>>>> Tested with recent wave-1 ath10k-ct firmware.
> >>>>>>
> >>>>>
> >>>>> Hey Ben,
> >>>>>
> >>>>> Did you do any testing with this patch around latency?  The nature =
of
> >>>>> the thing that you fixed makes me wonder if it was intentional with
> >>>>> respect to making WiFi fast - ie getting rid of buffers as much as
> >>>>> possible.  Obviously the CPU impact is likely to be an unintended
> >>>>> consequence. In any case, I don't know anything for sure, it was ju=
st
> >>>>> a thought that went through my head when reading this.
> >>>>
> >>>> I did not, but on average my patch should make the queues be less fu=
ll,
> >>>> so I doubt it will hurt latency.
> >>>
> >>> I would tend to agree with that.
> >>
> >> Well, I don't, as it's dependent on right sizing the ring in the first=
 place.
> >
> > My patch, barring strange issues elsewhere, can only make the firmware =
tx queues less full on
> > average.
> >
> > If you want to test with different ring sizes, you can play with the tx=
_desc
> > setting in the ath10k-ct driver 'fwcfg' options.
> >
> > http://www.candelatech.com/ath10k-10.4.php#config
> >
> > My testing shows that overall throughput goes down when using lots of p=
eers
> > if you have smaller numbers of txbuffers.  This is because the firmware
> > will typically spread its buffers over lots of peers and have smaller a=
mpdu
> > chains per transmit.  An upper stack that more intelligently fed frames
> > to the firmware could mitigate this, and it is not all bad anyway since
> > giving everyone a 64 ampdu chains will increase burstiness at least
> > somewhat.
>
> Making each transmission shorter is arguably the right thing to do in
> the "extremely congested" scenario, though. If you have to wait your
> turn behind 100 other stations for your next TXOP you'd generally want
> each of those other stations to only transmit (say) 1ms instead of their
> full 4ms. Yes, this will hurt aggregate throughput somewhat, but I'd
> argue that in most cases the overall application performance would be
> better. You're right, though, that ideally this would be managed a bit
> smarter than by just running out of buffers :)
>
> > I've always envisioned that the stuff you and Toke and others have been
> > working on would help in this area, but I don't understand your stuff w=
ell
> > enough to know if that is true or not.
>
> It might, although as per above I'm not quite sure what "helps" really
> means in this context. What would you expect a good behaviour to be
> here? I think what you're alluding to is to limit the total number of
> stations that will be allowed to have outstanding data in the firmware
> at the same time, right? Here it would help a bit to know some more
> details of how the firmware manages its internal queueing, and how it
> schedules stations (if at all)?
>
> BTW, are you running any of these tests with AQL enabled?
>

I don't know if Ben is doing so, but I will be doing so here very
soon. I've got some unrelated things in the way to clear up first, but
within a couple of weeks we hope to be testing AQL with ath10k-ct
firmware and driver.

And everyone thanks for the discussion, it's been very interesting and
useful to me. Hopefully we can improve ath10k even more with this
information.

- Steve
