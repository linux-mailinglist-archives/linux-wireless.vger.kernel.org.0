Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24F211ABF2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 14:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfLKNU7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 08:20:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43256 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfLKNU6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 08:20:58 -0500
Received: by mail-yw1-f66.google.com with SMTP id s187so8896648ywe.10
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 05:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRXn05EvZDJbwUzyXT6y9YLR6uAiKpjp/2mFYSI5pjc=;
        b=F2iFnpn2BspGC//2MtJ+JBClm87TvWCjt2MkbLMkO6IPhbqOQoo8y59byM5sfea+Oy
         kMTZaz8VdVPp0Gt7NB7RZ71rtl5E1Hpi3hkRkR1x4LlIBDBwroM00828A0K7iQZMgz7l
         I0fM1XWVplZJ3l+FehUfP1YKZRSr3kVqLdOLeMk1EHNW0pd0GYz+RpVj5rDLAqT7uFHi
         vXxC17DhuTfTf6kZaZUOFnivYulr9NSQNkIvFBCASK4RPhuvX/IvOoG6P9pcyB8oOn0O
         U9BAPfOFG3o8/JbeIc5wwtLIWYDCgCicUANlNCjaxbpvrWkEcSVCvqZ5CdLwvWGTlbxQ
         jIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRXn05EvZDJbwUzyXT6y9YLR6uAiKpjp/2mFYSI5pjc=;
        b=YLcSXBE2JMmxmmtOvKy+uHcE+hoZOiwn1b7shQBWLUnCvLg8z7M3YwusvwrGQMvZfy
         jzzlVplQykdYIBLcMi4lGu6P0vrLdZLGqqizDyrNGmC9p+bQF+/K5WRYgEfnskJx/vUm
         i7IrM5ZXcHXAfVvI2Khd8aGP49is+890a8uuv/rks8oi9uADk7lpar+5YwTaraxE/H48
         ku4y2yAzcwmvmpDrLnXVpFE/Dd6GiPgw28ZHuz/BRB3bVf1I52VGFK3b70pO+wyfAncJ
         V/P9daAUwnAWPlN+v1tUDoumOlSTKPdfVu4HLnXwz/UFCP7n5xkHCc0NL40COEaZwTd5
         dZeg==
X-Gm-Message-State: APjAAAX+Hujzh9aAlqplV9y1b8Ke7fJSzdh0Dx6hcE5Nwxjx7yGs7uD3
        HMe/lNWDKUibMVXbUeRSVUB+8sV4zodC4nVyQNc=
X-Google-Smtp-Source: APXvYqxykaiA7OtxPZvwHMT3EslSY9GPKEoGAlVjv8nxesZctB+B02RLU6rNdG8TwIqMUvnhA2673RIBohPYvwysWXw=
X-Received: by 2002:a0d:d994:: with SMTP id b142mr2404670ywe.148.1576070457717;
 Wed, 11 Dec 2019 05:20:57 -0800 (PST)
MIME-Version: 1.0
References: <CACyXjPzq-ePB1ux6wi_Rv3onPKXomcJcm15XJwA51u0E4W2txw@mail.gmail.com>
 <38F46E1D-1C4A-48DC-A906-9522006E8474@alum.mit.edu> <1606812C-649C-4C06-ABE0-AE2F4474BCD0@alum.mit.edu>
 <1440402013.3735.1.camel@sipsolutions.net> <CACyXjPwSZPV+U_=zQpDBpeBnhMntzEFhyJnBOw3-N8qPfyHc1A@mail.gmail.com>
 <55DE44EB.6080603@superduper.net> <126B842D-05EA-4510-BC9B-DB1A4AABEC12@alum.mit.edu>
 <1135A126-6A5A-4C84-A52D-13C0387609CC@alum.mit.edu> <1442507879.2821.9.camel@sipsolutions.net>
 <C5FF46C6-BDEE-41D8-B7E1-1EFFE9411DE3@alum.mit.edu> <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
 <CABPxzY+0v-Rb-GWkL-iwCfefzhFE5AiGBh2xxV_U_OC0Q+eoVQ@mail.gmail.com> <8f7c0c22c9732cc831686df4b93dedf37e72d219.camel@sipsolutions.net>
In-Reply-To: <8f7c0c22c9732cc831686df4b93dedf37e72d219.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Wed, 11 Dec 2019 18:50:46 +0530
Message-ID: <CABPxzY+BCcjFvQtPPdeBBOY1zcXzVd23GsSPKbd5BRsKRsTeog@mail.gmail.com>
Subject: Re: Correct radiotap header for 802.11ad
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Guy Harris <guy@alum.mit.edu>,
        "radiotap@netbsd.org" <radiotap@netbsd.org>,
        Simon Barber <simon@superduper.net>,
        Richard Sharpe <realrichardsharpe@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 11, 2019 at 6:28 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2019-12-11 at 15:09 +0530, Krishna Chaitanya wrote:
> >
> > > For both the Linux userspace reporting and radiotap then, this
> > > completely ignores the existence of the MCSes 9.1 and 12.1-12.6, which
> > > cannot be captured in either format right now. Maybe the extended SC
> > > MCSes are just not used by equipment in the field?
> > >
> > They are used. Unfortunately, Linux-wireless doesn't have native support for DMG
> > wil6210 and our driver has to workaround by using HT IE's
> > (ieee80211_supported_band).
>
> You make it sound like that some sort of thing that Linux cannot really
> do better. That's far from the truth! We keep extending this (HT, VHT,
> HE recently) and there's no fundamental reason we couldn't do extensions
> for DMG. It's just that nobody who actually has a driver for Linux
> bothered doing so!
Sorry, that wasn't my intent, as there is a single upstream driver I guess
it was easier to workaround than to properly add support. I agree that
it shouldn't
be hard, may be we can do it properly for 11ay.
> > > In any case, to capture DMG properly I'd say we need a new radiotap
> > > field with at least
> > >  * (base) MCS
> > >  * Extended SC MCS bit
> > > and it should probably optionally cover the other possible fields as
> > > well
> > >  * Scrambler Initialization
> > >  * Length (?)
> > >  * Additional PPDU bit
> > >  * PPDU type bit
> > >  * Training Length
> > >  * Beam Tracking Request
> > >  * Last RSSI
> > >  * Turnaround
> > yes, we definitely need this, there are some additional fields in
> > 11ay, but I guess that
> > discussion is for another time.
>
> Somebody (@QCA I guess, I don't have any functioning driver/hardware for
> Linux for this) really should sit down and define the extensions to
> cfg80211/nl80211 to capture the data properly, and a radiotap extension.
> None of that is hard, I've done it for VHT before and HE recently.
