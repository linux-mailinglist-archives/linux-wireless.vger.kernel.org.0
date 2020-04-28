Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCB1BCC7F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgD1TkD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728392AbgD1TkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 15:40:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913B5C03C1AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 12:40:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i16so12175ils.12
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8dNzZoo6BwE+y+2RELR9+ATC7jomEHgy2WoRWlyh2FU=;
        b=CNnd4biDRTlpugOR+JeLwdaPq06suwFCr1Tpbdb6GDqNuerNxu6UxPy7tPsmsRcwFR
         GalKdOyppHefB/clrjruuKdEpxpFzBoFhp2IjSuFpjSysdHgnG+iOKLBZWgwXc8WbSnU
         d8zfSnT19SD8mM8MRvPj4Zc1EXymHDL61g1WcJN0Bm+VKqq0RHIhFxA0DsbeW5zZev3c
         s/DDSp2jwenXQQaABBvfQC2avtfAA4E3JQCD75o4chybpZXYgTwiwQLyKx36Gk8460dg
         Hp4hdG1iw/7JOBrOCTNwoQYqi7FRMlqTL+ecr/W+YPvAKn3Sbb+7/TD55EYe/aM5jejR
         J+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dNzZoo6BwE+y+2RELR9+ATC7jomEHgy2WoRWlyh2FU=;
        b=NG8HjMa5Oxf3xYliPu3rwMiphp9veWjlWW5MCxZngwXMeIKaU/UCjAWQEnoiNze56z
         h37iD4qCQIdBWMe7z3oreB4q8ATALxXeCLHLl9/vj3zQbqVP1exD/sUhxQGQLR10c/zo
         4Op1tY9759GjhKkEtrOeL4x5ER+ThjTIt05cf9m9ipCrzmPShLg8fWvsa2oVpXrDJzVD
         5EV2t8xeGwHAId1sAcZIKx4AppUSjFXilyXWN3fZuFCmLHt1zFWwxnldPU/H0pwSos6x
         kZWY4r17chmaaxP15lPyIdG+C7I26qUPaNAT+a/tLyj+qCWmBqiHJAH9VHSBuG4NeeL8
         vQvQ==
X-Gm-Message-State: AGi0PuaR37dhyboPQzGwlpuPLhJsKsug67LX3JvHIMdpRr6AEHT3cqjA
        knh/CVG8fbWjMT0wi+FeBB2+F9QvsuPPRtfHNSYsJqvg
X-Google-Smtp-Source: APiQypJfkfBkqp187Q8LPG0WPvJQF4n7JahPG2lN6dwPaCjx2ULinA+dIL9hbrui32Gos1ZWWhr1YO2xL/7JP3wohoo=
X-Received: by 2002:a92:dc0d:: with SMTP id t13mr28368019iln.287.1588102801835;
 Tue, 28 Apr 2020 12:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145435.13151-1-greearb@candelatech.com>
 <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
 <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com> <87k11zv1ux.fsf@toke.dk>
In-Reply-To: <87k11zv1ux.fsf@toke.dk>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Tue, 28 Apr 2020 12:39:50 -0700
Message-ID: <CAA93jw7exafEx3YkvR5uaaBm5kxzYp3nw14zMfgT=2SwUjaQFg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     Ben Greear <greearb@candelatech.com>,
        Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 12:37 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@tok=
e.dk> wrote:
>
> Ben Greear <greearb@candelatech.com> writes:
>
> > On 04/28/2020 07:56 AM, Steve deRosier wrote:
> >> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
> >>>
> >>> From: Ben Greear <greearb@candelatech.com>
> >>>
> >>> While running tcp upload + download tests with ~200
> >>> concurrent TCP streams, 1-2 processes, and 30 station
> >>> vdevs, I noticed that the __ieee80211_stop_queue was taking
> >>> around 20% of the CPU according to perf-top, which other locking
> >>> taking an additional ~15%.
> >>>
> >>> I believe the issue is that the ath10k driver would unlock the
> >>> txqueue when a single frame could be transmitted, instead of
> >>> waiting for a low water mark.
> >>>
> >>> So, this patch adds a low-water mark that is 1/4 of the total
> >>> tx buffers allowed.
> >>>
> >>> This appears to resolve the performance problem that I saw.
> >>>
> >>> Tested with recent wave-1 ath10k-ct firmware.
> >>>
> >>
> >> Hey Ben,
> >>
> >> Did you do any testing with this patch around latency?  The nature of
> >> the thing that you fixed makes me wonder if it was intentional with
> >> respect to making WiFi fast - ie getting rid of buffers as much as
> >> possible.  Obviously the CPU impact is likely to be an unintended
> >> consequence. In any case, I don't know anything for sure, it was just
> >> a thought that went through my head when reading this.
> >
> > I did not, but on average my patch should make the queues be less full,
> > so I doubt it will hurt latency.
>
> I would tend to agree with that.

Well, I don't, as it's dependent on right sizing the ring in the first plac=
e.

But testing is in order! :)

> -Toke
>
> >>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> >>> ---
> >>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
> >>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
> >>>  2 files changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wire=
less/ath/ath10k/htt.h
> >>> index 31c4ddbf45cb..b5634781c0dc 100644
> >>> --- a/drivers/net/wireless/ath/ath10k/htt.h
> >>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> >>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
> >>>
> >>>         u8 target_version_major;
> >>>         u8 target_version_minor;
> >>> +       bool needs_unlock;
> >>>         struct completion target_version_received;
> >>>         u8 max_num_amsdu;
> >>>         u8 max_num_ampdu;
> >>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/w=
ireless/ath/ath10k/htt_tx.c
> >>> index 9b3c3b080e92..44795d9a7c0c 100644
> >>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> >>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> >>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt=
 *htt)
> >>>         lockdep_assert_held(&htt->tx_lock);
> >>>
> >>>         htt->num_pending_tx--;
> >>> -       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx - 1)
> >>> +       if ((htt->num_pending_tx <=3D (htt->max_num_pending_tx / 4)) =
&& htt->needs_unlock) {
> >>> +               htt->needs_unlock =3D false;
> >>>                 ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL)=
;
> >>> +       }
> >>>  }
> >>>
> >>>  int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
> >>> @@ -157,8 +159,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt =
*htt)
> >>>                 return -EBUSY;
> >>>
> >>>         htt->num_pending_tx++;
> >>> -       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx)
> >>> +       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx) {
> >>> +               htt->needs_unlock =3D true;
> >>>                 ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
> >>> +       }
> >>>
> >>>         return 0;
> >>>  }
> >>> --
> >>> 2.20.1
> >>>
> >>
> >
> > --
> > Ben Greear <greearb@candelatech.com>
> > Candela Technologies Inc  http://www.candelatech.com



--=20
Make Music, Not War

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-435-0729
