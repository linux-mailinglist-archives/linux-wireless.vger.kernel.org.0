Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC36617956B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgCDQet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 11:34:49 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46978 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCDQet (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 11:34:49 -0500
Received: by mail-qv1-f65.google.com with SMTP id m2so1041712qvu.13
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcDeq6IhG5uUeWUfOdd7VqxhA7bdOG9fjQ/jLBFOJFU=;
        b=RlJjMYeu0/zZ4+gjgegGkBr2HaaaLWhkpHZfWcZJh4re5uYvFxjvurKDFQTVyFJHva
         kf/17eKKP9e87+C3XMliOBC6pj0mjn4JbPhwx29C8S08NWyvYa2ZYVT7iN1QGZWuLxXU
         hTvsVnCtwVyRdFcsoXQ+eflP8YKc1/fmKwxs1EZi1w/QNzqgjVgL6ia9KCZlb/LkdsWe
         DaMTYqz1/bGU1oS9Bp6vqa+oC1j11xT9cpSayzuoFbe2VQB1nimdxqqLBkidltYMit8O
         kavzKYRUxRllCHiTGOOAvO3S7ioDuBV/A2eMBERofgmuER9mPmCx+KpXjpi2Rlcmkc0E
         A2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcDeq6IhG5uUeWUfOdd7VqxhA7bdOG9fjQ/jLBFOJFU=;
        b=Xzxa9RFYeUYTryZRSDf5KISag3kqLugKBV+Qt4gxKz/UCq9Eu2dsG5JdgfYYRy95c9
         i51u82eJgrrORqxfCOanXg70SEF+K2qLgg7riWSSOs4qgG9Z4YNvj3EPogpwhZYUhJvm
         hGjEtTc/jHAXb9loxl6OPNXfSzJvOwRXgXYrf3YSB4ApIxOay0g7oBrebyF7xJ4V61bD
         tOT5HaLytLRkGS/bd/ne5gx5EvxF4yGQ9HoNfrrJxYyIu6LT9JCMR/QImCLc53kfG3rk
         T4PpRsb2GqtGcOdyn06duaCtbnBHFVdsjTy57nMiXLJnzmNqdmkrz484iwVPh3qiT7hP
         nSLQ==
X-Gm-Message-State: ANhLgQ3XcaNvYT4DHrJGiojq05fdcss4n12t+To8mbYbV7QTIC6dZyEY
        9jzERUWCYuDdTYQWhs0HatI6JmyigPMBsxbCAdI=
X-Google-Smtp-Source: ADFU+vuo6KGNAXf3FYk4vMRbNi1zHJfgFK3g603BG911ZB8TfjMImHCI57lbrI8seeR2CDfcnQx3v3n8oAjEI0eUUIM=
X-Received: by 2002:a0c:ed2d:: with SMTP id u13mr2822357qvq.146.1583339687934;
 Wed, 04 Mar 2020 08:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
 <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
 <CALLGbRKPCSZW8PFQXat+_=+iD_ED81j16vNtTbF=KW-B-tTWPQ@mail.gmail.com> <fe471ae5-bebf-a673-48ee-f06c47f3721d@tu-ilmenau.de>
In-Reply-To: <fe471ae5-bebf-a673-48ee-f06c47f3721d@tu-ilmenau.de>
From:   Steve deRosier <derosier@gmail.com>
Date:   Wed, 4 Mar 2020 08:34:05 -0800
Message-ID: <CALLGbR+Q_c5x-uNK41c-m3xUj_JtgtUVmWbLFs7d_2C=fmbNUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, nbd@nbd.name,
        lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 4, 2020 at 1:34 AM Markus Theil <markus.theil@tu-ilmenau.de> wrote:
>
>
> On 3/3/20 10:59 PM, Steve deRosier wrote:
> > On Tue, Mar 3, 2020 at 1:28 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >> On Tue, 2020-03-03 at 12:50 +0100, Markus Theil wrote:
> >>> Back in 2007 "mac80211: don't allow scanning in monitor mode"
> >>> (f27b62d3e7ec) disabled scanning in monitor mode, because hw
> >>> controlled by the zd1211rw driver got confused during this operation.
> >>>
> >>> Nevertheless, it can be useful to scan in monitor mode, e.g.
> >>> when building a tool which processes scans, channel surveys and
> >>> monitors the channel passively in monitor mode.
> >> Hmm. I'm not really sure that this makes sense.
> >>
> >> You're in monitor mode, so you won't get any scan processing as such
> >> (you will not be able to use nl80211 to retrieve the results!), and
> >> there will be a lot of confusion over sending probe requests (the code
> >> now looks like it would in fact attempt to do so ... but how?).
> >>
> > Additionally, I don't see what this solves for sure.  At least on an
> > ath10k device I've been using, I can have two interfaces on one phy
> > (phy0), wlan0 and mon0, and I can issue a `iw wlan0 scan` and it works
> > famously and then capture fine on mon0. Granted, I haven't tried doing
> > a scan while at the same time am actively capturing, but I wonder of
> > the meaning of that anyway as the capturing radio would have to then
> > go off channel and issue probe requests etc., sort of screwing up my
> > capture for that time period.  But anyway, can you not do this on your
> > radio?
> >
> > - Steve
>
> I was not able to use this combination of interfaces, when only interested in monitoring networks.
> The STA VIF can only scan when its put up, but then I cannot choose the operating frequency of the
> monitor interface freely. Sure, I can build workarounds, like changing the interface type when I need
> an active scan and chaning it back to monitor mode afterwards, but this also seems not very clean.
>

Hi Markus,

I'm trying to understand the semantics of what happens when I'm
actively doing a capture, and then issue a `iw mon0 scan` (or equiv).
What happens to the capture and how do I make sense of it?

Personally I prefer the explicit over the implicit with confusing
results.  The following sequence is clearer and explicit to me:

ifconfig wlan0 up
iw wlan0 scan
ifconfig wlan0 down
iw mon0 set channel 36 HT40+
tshark -i mon0 .....

Obviously I'm using command-line tools to illustrate, tools might use
the API instead.  In any case, there's no possible confusion over what
the semantics might be because it's not possible to have the confusing
state.

I hear what you're saying, and you're right, in userspace you have to
do multiple steps for your use-case.  In thinking about it, _should_
the kernel have changes in it to make your specific use-case easier?
And _should_ it do so for one particular NIC that works in a
particular way?  What happens with the other NICs that have different
capabilities and semantics than the mt76?  Seems to me that a clean
and straightforward mechanism in the kernel is "very clean" while it's
OK for userspace, which is where policy stuff is supposed to be, to
have to jump through a few hoops. Do we want to add complexity and
maintain that for all the drivers simply to avoid having two VIFs and
avoid the extra steps of bringing one up and down when we want to do a
scan? Your usecase is already possible, and IMHO, not that difficult
to achieve. But maybe I'm missing some terrible hole here as I've not
tried to write whatever app it is you're writing nor do I usually work
with the mt76.

Honestly, I don't have the answers, but I want to raise the questions
as they impact more than your one usecase and NIC. The semantics of
your mechanism don't seem very clean to me, and I worry that if other
people on NICs decide to enable your feature flag, we're going to have
a fun time supporting that. I'm sure the maintainers will sort it out.

Thanks,
- Steve
