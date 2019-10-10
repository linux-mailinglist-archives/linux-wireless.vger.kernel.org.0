Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4BD1E7F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 04:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJJCfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 22:35:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33191 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJJCfU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 22:35:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so4566711ljd.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xNOk7RHs2NX231yJ4vn1jUbJI6Vg12VmhwZvxDf3llU=;
        b=BxwrlrJYW5KCzwrH2ymFZOFiqA2U16Y9AQbAkSScJraAZWewvUSoi9Ur+Fj0oUwxYu
         yHKfU0MOzjkOE9iFBJoQo8FjrMsRyzTOaLL5FaquJCpEdqbvf8Lsdr6uDcIuBhOKwKCv
         s5o2RnleG5+7V9L6BmuhPwMx1uzCXVxQUacrrtUSMEoVtO++6pKdKXh0CS6D5848f8bk
         pks1O/Gv2cmp80L3fWyivc8UbwEEA+kPcq2ypPlKwkM6BbGf4ZVwyjpSZLTJ5gUv1yX7
         YQ+Z96xnKURYMB6ar5vXhRGK4avzaY0P32RIQoKONyEHVcSnzeVqm4jLuC9ra/uTmUa0
         iZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNOk7RHs2NX231yJ4vn1jUbJI6Vg12VmhwZvxDf3llU=;
        b=bDoP2n3FYhwZ+dqm6hNUGDJ02DHnVc5oxu6Q9Nb2m33Kw6vEUaQnV9rUQK153yXyhC
         RhS/jQcfZtEDU5zC32C1L6Huh907mV9Q3M+HLmWX0x4KHmqgh8Y2MLgCNFjrxRzKRZEi
         PZZ5LlkBTiV1laAV2vYIm3sIHQF07tKn00lSN5jhDih88pTmPs3wxwSV4Yi4P2PIx4y4
         cmh2h+/EhiiHNJl3dsTelCWcslELXRYYSLQSOR3viZL2HjwzVoxLlQjQj8HmAUbMXfzp
         SaJoJdaIkJL0HMhD+u9zAQxIvJc3B36yZLwkN+k5xJKR3ZP+qDzgYaAAMIPpN09BAs8g
         H03A==
X-Gm-Message-State: APjAAAUOjnXEbqBO+fbwgj1FT/cmhS5CgLp1x/zGudUySie1w0TrCJk7
        LkqkxPwDVrY4ju50aAyWjCOWkrj5nrZuOPLY5WsSWMNTwGQ=
X-Google-Smtp-Source: APXvYqwwrdPan2+uHY+XBfFTybHUsvN8bh1ZbFKWi6AkQkilSDfV/jCIK6QipEjOGXZh5r2z8+XgmGx6kLQOYqbGUcE=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr4229753ljo.193.1570674918128;
 Wed, 09 Oct 2019 19:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com>
 <87imp4o6qp.fsf@toke.dk> <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
 <87pnj9n55y.fsf@toke.dk> <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
 <878spwmjif.fsf@toke.dk> <600f64e1e673fff25d2be71ac767d7332db0452a.camel@sipsolutions.net>
In-Reply-To: <600f64e1e673fff25d2be71ac767d7332db0452a.camel@sipsolutions.net>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 9 Oct 2019 19:35:06 -0700
Message-ID: <CA+iem5uemV7YB=DPry5UdgLgi0USXG-e3My2=3256EWtFkye4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Yibo Zhao <yiboz@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> I'd like to use the new rate calculation code that Felix added to mt76.
> Is the arsta->txrate info in ath10k suitable to be passed up to mac80211
> and used in that, do you think? Because then that would probably be the
> easiest way to go about it...

Do you mean the mt76 patch that using the EWMA to smooth estimate data
rate? It would be great if you can move that to mac80211.
Yes, arsta->txrate info in ath10k is a good place to extract latest date ra=
te.



On Mon, Oct 7, 2019 at 12:43 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Mon, 2019-10-07 at 21:40 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
> > > > So if and when we start supporting true multi-band devices we'll ha=
ve to
> > > > change these things anyway. So might as well keep everything togeth=
er so
> > > > it all gets fixed :)
> > >
> > > I guess I'm OK with that, but I'm pretty sure this will come up soone=
r
> > > rather than later ...
> > >
> > > What else is there though?
> >
> > By "it all" I meant "all the airtime fairness stuff". Other than that, =
I
> > didn't have anything in particular in mind. I just kinda assumed there
> > would be lots of places that had an implicit assumption that all device=
s
> > on the same phy shares a channel...
>
> Not _that_ much - we do have the channel contexts after all. But except
> for hwsim (*cough cough* I was lazy) nothing actually implements real
> concurrent multi-channel yet, obviously, but uses a single radio with
> channel hopping...
>
> johannes
>
