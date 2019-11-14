Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A582AFBDE1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 03:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfKNC0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 21:26:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43481 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfKNC0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 21:26:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id q5so3656290lfo.10
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 18:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2AzPip2wNlHnWQBu5Yn46ogrlZeHHT/hT0CNfhYHRdE=;
        b=CeYJyehBP064i+rJ2JRTBFaQm7jQqublCEC0plurkBbx2dEukQK+b8lYiyXwEC36xI
         gANqyP6fuhp48UQg+PpyqMIdqcrFFaVfqhC1xEsui9NBUdF1+pwlpTGxI6hdV/t4tQXL
         Ri/OYdYph58hCswOS9dBQ1mGXVCDJTCCqDUu8u3hlPZ5917noALrhhxzxRW9B1PmhLev
         bcccEAMNiW4BlpV58liOLZ6CVKgZVWZZeat2TElF4IlB+1CUb9r66LhAVGUlIUm7T0an
         /r+NGHg0DHwukM5w1ci8LDO2Hizp5q9l48aTsoPIXitp14spDJqnjiAjyS69qfSWgoRM
         0pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2AzPip2wNlHnWQBu5Yn46ogrlZeHHT/hT0CNfhYHRdE=;
        b=n5v4FNBAeTjtn0Ru+Vzx9HweTqxXYhMgVOaCX6pO3n8F0Hgs2Jps7pX2m+CWqBc13T
         BXlkivYUJkm4YyEdpIDxOtOEDJ5G4actYMf+evwPqnKSdTxBcTiD0s0ACfLZRW5ZeSaI
         J2J6bEsNLKD4O+ff1IwmpZcSrAIolJ7uWVFcaYLJkjmpCdKimW/E2C2tDwswHVOsr0Nv
         ymtYGOsmLTzAdyFdOL17iaC+NkhJBeGyFbu8KP/0bZmZvh4atyIuUhmv8iAME0jfnrd/
         IzGSCsHiKuIQSBZCJtfbm7tctgy3D4WCdv0g3CemHt3Z5uRizZIdXF/w9K8eg5aNJMPp
         vh0Q==
X-Gm-Message-State: APjAAAXnZ4idojD4s6ccdO39KUzVEQ1J9joI7Y0PjI0+w3r5OAo5vVtF
        Ffr3Sz58k1C+zYABxXF2CRI0B6HlwEPo63yLl1Glww==
X-Google-Smtp-Source: APXvYqyCWIxaniuIj6s5m5kPF1/oNo8q8ob4E8fvTlr4eMlYacxrAxBw18FBbRuXb4JeaE/cP56tFuev1W1FpStr7qU=
X-Received: by 2002:a19:22d3:: with SMTP id i202mr4659966lfi.69.1573698394962;
 Wed, 13 Nov 2019 18:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20191112021136.42918-1-kyan@google.com> <20191112021136.42918-2-kyan@google.com>
 <871rudqpsg.fsf@toke.dk> <CA+iem5vrM0iF+yvS9m==UWnhp=DFV924ir-0nHcn6cwarEjZNA@mail.gmail.com>
 <87woc3oowq.fsf@toke.dk>
In-Reply-To: <87woc3oowq.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 13 Nov 2019 18:26:23 -0800
Message-ID: <CA+iem5sp+52tT3u+uzCgv0fvfP1WX85-U31wzQ6wNKyt34RFpQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Felix Fietkau <nbd@nbd.name>, Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Oh, right, I see. But in that case, should writing the default really
> stomp on all the per-station values? If I set the value of a station, I
> wouldn't expect it to change just because I changed the default value
> afterwards?

Will persevere the value for stations with customized queue limit in
the next version.

> > That's indeed not right. However, if a potential aql_tx_pending
> > underflow case is detected here (It should never happen), reset it to
> > 0 maybe not the best remedy anyway. I think it is better  just
> > WARN_ONCE() and skip updating aql_tx_pending all together, so the
> > retry or loop can be avoided here. What do you think?
> If we don't reset the value to zero may end up with a device that is
> unable to transmit. Better to reset it I think, even if this is never
> supposed to happen...

I mean not updating the pending airtime to prevent it from going
negative when the tx_airtime is larger than aql_tx_pending.
Will reset it to 0 in next version, which is simpler and cleaner.



On Wed, Nov 13, 2019 at 6:02 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> > Thanks for the review. I will pick up your new patches and give it a
> > try tomorrow.
> >
> >> Why is this setting sta and device limits to the same value?
> >
> > local->aql_txq_limit_low is not the per device limit, but the default
> > txq_limit for all STAs. Individual stations can be configured with
> > non-default value via debugfs entry
> > "netdev:interface_name_x/stations/mac_addr_x/airtime". "aql_threshold"
> > is the device limit for switching between the lower and higher per
> > station queue limit.
>
> Oh, right, I see. But in that case, should writing the default really
> stomp on all the per-station values? If I set the value of a station, I
> wouldn't expect it to change just because I changed the default value
> afterwards?
>
> >> Also, are you sure we won't risk write tearing when writing 32-bit
> >> values without locking on some architectures?
> >
> > Does mac80211 ever runs in any 16-bit architectures? Even in an
> > architecture that write to 32-bit value is not atomic, I don't think
> > there is any side-effect for queue limit get wrong transiently in rare
> > occasions. Besides, the practical value of those queue limits should
> > always fit into 16 bits.
>
> I'm not sure about the platform characteristics of all the weird tiny
> MIPS boxes that run OpenWrt; which is why I'm vary of making any
> assumptions that it is safe :)
>
> But yeah, I suppose you're right that since we're just setting the
> limit, it is not going to be a huge concern here...
>
> >> I don't think this is right; another thread could do atomic_inc()
> >> between the atomic_read() and atomic_set() here, in which case this
> >> would clobber the other value.
> >> I think to get this right the logic would need to be something like
> >> this:
> >> retry:
> >>   old =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
> >>   if (warn_once(tx_airtime > old))
> >>      new =3D 0;
> >>   else
> >>      new =3D old - tx_airtime;
> >>   if (atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending, old, new) !=3D =
old)
> >>      goto retry;
> >> (or use an equivalent do/while).
> >
> > That's indeed not right. However, if a potential aql_tx_pending
> > underflow case is detected here (It should never happen), reset it to
> > 0 maybe not the best remedy anyway. I think it is better  just
> > WARN_ONCE() and skip updating aql_tx_pending all together, so the
> > retry or loop can be avoided here. What do you think?
>
> If we don't reset the value to zero may end up with a device that is
> unable to transmit. Better to reset it I think, even if this is never
> supposed to happen...
>
> -Toke
>
