Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD9FFB96
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Nov 2019 21:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQUZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Nov 2019 15:25:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45591 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfKQUZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Nov 2019 15:25:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so16370700ljg.12
        for <linux-wireless@vger.kernel.org>; Sun, 17 Nov 2019 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ql6OPsK4uQYSkaAsGyBu94gd3BNPrccgvPAvpalrUQQ=;
        b=ZPoAuICAkjxKQgHPGL+AyFKDAZTJ/RODCKSZyZQsYEh6LdpYJ/u7vQiYPUhupoMhAI
         TlD7L+W4j7LiGb5I2eAx0CQx9DiuZU7b1QNUf/MfGqFG80Y9tEAjsYnQ/dsXRzRg94h8
         NitnzK7p10yjnqfmVLUcJQ4eomZ7v/gDqJ2Re3wBqMj1bODmxZriGDwDv1uIgaNM2kkQ
         Awwkc7Qfn/XIp6GZ6NDZhrqbOXidR9ye1RLt1BJ4D9XGvQif3RCskt37XF7D3QDSzhJW
         MtqwO2us/w5OYOraunBCV9PLbSzJvChKRQ6H+6/5g/0mcWzleihT04816Yzwu8LQPqO3
         8Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ql6OPsK4uQYSkaAsGyBu94gd3BNPrccgvPAvpalrUQQ=;
        b=NbvpZ73WTfUJ2U4UlDVdcLGJXAzGGnKJkUW4kdpCW8aojqa8L2XeObtv3AJqvwN9Qp
         0zslYDEdZimitF2fOyk6jqs73LtNTKN/qHh2/PiGEiwelAC/T/oI3QbGeAcnBnPff7EL
         6epnftuDVwxeoGfMrs7oSW3yM2MzReutoXmMCMkNKbS6MEmiQymVsa+iOruILUZZ5f0U
         852z+JK6uS70dmGwbrGjW0D4UVBu4rFigG9albrRyE0qmvGsXp8rhfApD4bkagWyDBfa
         spB9ZzB7Vx/SFA/xiepCpBsVzUSXrSo7cMqi6Mr7FQc5HONjyfCJqTGHaicVVsjyGC94
         7PCg==
X-Gm-Message-State: APjAAAVLji7nDL/RDhZLuDSKZYzcNEH/Uo/JUjk0/Z4Vz7UNM0HKtGM3
        ezSf9Y5vk9P60rhmwrZdA++u+afjSn27wAznBfphZQ==
X-Google-Smtp-Source: APXvYqxzsZMoMt7ussfhZ81q9Qzzfp+hPUHwHwDwXa5B5t/Rm64rKUAT1TzDysvU7bbQyn5VqFKYBy5YQFLS8gcB4N0=
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr7233950ljj.114.1574022302590;
 Sun, 17 Nov 2019 12:25:02 -0800 (PST)
MIME-Version: 1.0
References: <157382403672.580235.12525941420808058808.stgit@toke.dk>
 <157382404118.580235.14216392299709793599.stgit@toke.dk> <CA+iem5tF+TN-osfGxu=EU5Xt1Uq+PcKgBVaoAmZY3a3JzS5JzQ@mail.gmail.com>
 <87y2wgjas4.fsf@toke.dk>
In-Reply-To: <87y2wgjas4.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Sun, 17 Nov 2019 12:24:51 -0800
Message-ID: <CA+iem5vVhwTsTvAgnC_HF0utMDSfgyLCe2M=gfUOFU2VjjCB8Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > Given the fact that AQL is only tested in very limited platforms,
> > should we set the default to disabled by removing this change in the
> > next update?
> >
> > -       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> > +
> > +       local->airtime_flags =3D AIRTIME_USE_TX |
> > +                              AIRTIME_USE_RX |
> > +                              AIRTIME_USE_AQL;
> > +       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> > +       atomic_set(&local->aql_total_pending_airtime, 0);
> Well, we have the whole -rc series to get more testing in if we merge it
> as-is. It's up to the maintainers, of course, but I would be in favour
> of merging as-is, then optionally backing out the default before the
> final release if problems do turn up. But I would hope that the limits
> are sufficiently conservative that it would not result in any problems :)

Sounds good. The current default limits are reasonably conservative
and are tunable via debugfs.

I will give the v10 version of this patch serial a quick test and
hopefully we can wrap it up soon.

-Kan


On Sat, Nov 16, 2019 at 3:55 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> >> +static inline u16
> >> +ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx=
_time_est)
> >> +{
> >> +       /* We only have 10 bits in tx_time_est, so store airtime
> >> +        * in increments of 4us and clamp the maximum to 2**12-1
> >> +        */
> >> +       info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
> >> +       return info->tx_time_est;
> >> +}
> >> +
> >> +static inline u16
> >> +ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
> >> +{
> >> +       return info->tx_time_est << 2;
> >> +}
> >> +
> >
> > set_tx_time_est() returns airtime in different units (4us) than
> > get_tx_time_est(), this will cause the pending_airtime out of whack.
>
> Huh, you're quite right; oops! I meant to shift that back before
> returning. Will fix.
>
> > Given the fact that AQL is only tested in very limited platforms,
> > should we set the default to disabled by removing this change in the
> > next update?
> >
> > -       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> > +
> > +       local->airtime_flags =3D AIRTIME_USE_TX |
> > +                              AIRTIME_USE_RX |
> > +                              AIRTIME_USE_AQL;
> > +       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> > +       atomic_set(&local->aql_total_pending_airtime, 0);
>
> Well, we have the whole -rc series to get more testing in if we merge it
> as-is. It's up to the maintainers, of course, but I would be in favour
> of merging as-is, then optionally backing out the default before the
> final release if problems do turn up. But I would hope that the limits
> are sufficiently conservative that it would not result in any problems :)
>
> -Toke
>
