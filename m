Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B243E1030D0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 01:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKTAk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 19:40:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42432 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfKTAk3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 19:40:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so25470211ljc.9
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 16:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/BS/LrpSdTcgQ0U148xi1gCiG593vmyt6vgaYhjAqQ4=;
        b=EA36m/2xRVrPFtvpP9iXeOsZruukneOIS7FZVq/i1C9N8x/BpIOnSseyyHYFgUPEmz
         vED1G21MF+C0D7siSDWUok3DJjwqABNsNRqXQiMyLJlNdILtN4GRPdtyz3srF6J/UMSg
         RmAxyFLkIxHnmcuIMBe+1r8EtBVVw/dSk5klWLw5kQLE+C7J1u0kMT6a8yKmzG578U8u
         n9HGSbRTRFBUSmJfm7QYuziGGEJGSlEWuQG9zkWsL9M5YO3iHewRCJiznbrBoptUKu4/
         dOu4MglRCtMI21ZcUHLQCizcuNa5yUr/LqlIAOTVD74/fgNXTYeUWBqETjwQ8ZWFz+sv
         iopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/BS/LrpSdTcgQ0U148xi1gCiG593vmyt6vgaYhjAqQ4=;
        b=peMM0joK4Ljbj44UOO+/crP4yDERPCCMLbX7mi7Ppk1CuvlPShiPBFeq2RN3oMNwfY
         50vOAfNZWu0QoZBWgWjzp0e+5/mv4vrIH0kwt3BnPllB+AtnM6YXEGkQLhWrKEdJIggq
         e02t1k7QHNWd4cc7YDIHMr11/En6NHpbmyWCTPPbkQfY6dPp6BC8Q9wgXmAydPBddzDb
         HOUmZ1TpmCXByu42S6kg+Uz1++S1wclEpRZ3Ux6BL3pAgZdioWQi0W2RCvz+ShNUD+BK
         /3v9ryWQZDA0Ozn8+O+7orT0l0/vjwels3FUq6FpVQDT1jZGVWKgveMnkM4nG8eZFMmz
         J3Ng==
X-Gm-Message-State: APjAAAUAubvyu4Acr73wKPKIpe1NQfZWjl9w8k4WoHy3WNZL+fD/U7Td
        HXgHoBZA4LSrABV0xu2lTLiy1jycGsEEqgJNp86k8GqXQRs91A==
X-Google-Smtp-Source: APXvYqzX4ViEpQhH6mWMJMwYJXGdhc+gtYLoTIQMmTlfKKOPuAe5cqwo8NrSFWd38Fb7BuBmAt6uuOro3Srcltp1S2g=
X-Received: by 2002:a2e:9904:: with SMTP id v4mr185760lji.211.1574210424273;
 Tue, 19 Nov 2019 16:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
 <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
 <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com> <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
In-Reply-To: <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
From:   Kan Yan <kyan@google.com>
Date:   Tue, 19 Nov 2019 16:40:13 -0800
Message-ID: <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
To:     Dave Taht <dave.taht@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Those were lovely, thanks!!!! Big win. Since you are on patch v10
> now.... Any chance you could turn ecn on and off and give it a go
> again in your next test run?
>
>
> Also:
>
> --step-size=3D.04 --socket-stats # the first is helpful to gain more
> detail, the second as to the behavior of the tcp stack.

Thanks for the feedback! I will do more tests in a few days.


> Secondly - and AFTER this patchset stablizes, I'd like us to look into
> returning the codel default to 10ms or less
> from it's currently 20ms or worse setting. Tis another easy test

Smaller CoDel "target" doesn't work well with wireless because the
dequeue behavior in wireless driver is very bursty. It is quite often
dequeues dozens of packets in one burst after one large aggregation is
completed, so smaller CoDel "target" can cause unnecessary packet
drop.


On Mon, Nov 18, 2019 at 1:08 PM Dave Taht <dave.taht@gmail.com> wrote:
>
> On Fri, Nov 15, 2019 at 4:10 PM Kan Yan <kyan@google.com> wrote:
> >
> > > I do keep hoping for pretty pictures. Got any? :-P
> >
> > Certainly! I do have some :). Here is the link:
> > https://drive.google.com/corp/drive/folders/14OIuQEHOUiIoNrVnKprj6rBYFN=
Z0Coif
>
> Those were lovely, thanks!!!! Big win. Since you are on patch v10
> now.... Any chance you could turn ecn on and off and give it a go
> again in your next test run?
>
> Also:
>
> --step-size=3D.04 --socket-stats # the first is helpful to gain more
> detail, the second as to the behavior of the tcp stack. You might need
> to run as root (and It's only useful on the tcp_nup test) for the
> latter (and have the right ss utility)
>
> Secondly - and AFTER this patchset stablizes, I'd like us to look into
> returning the codel default to 10ms or less
> from it's currently 20ms or worse setting. Tis another easy test
>
> And y'all know how much I love the rrul_be and rrul tests.....
>
>
> > >
> > > Is there an ax QCAXXXX platform, m.2 card, or mini-pci card worth
> > > testing at this point?
> >
> > It will be great if someone with 11.ax platform can help give it a try.
> >
> > > How are they handling mu-mimo?
> >
> > I think it should still work. The queue length in airtime for each indi=
vidual queue is unchanged, even the multiple queues are allowed to transmit=
 concurrently with mu-mimo.
> >
> >> I have a round of tests scheduled for intel's ax200 chips, soon. Not s=
ure
> >> what, if any, of this new work might apply.
> >
> > It will be very interesting to know how it performance on 802.11ax plat=
forms. Supposedly 802.11ax already fixed the latency problem so the benefit=
 of this patch should be less significant.
> >
> >
> > On Thu, Nov 14, 2019 at 6:07 PM Dave Taht <dave.taht@gmail.com> wrote:
> >>
> >> On Thu, Nov 14, 2019 at 6:04 PM Kan Yan <kyan@google.com> wrote:
> >> >
> >> > I have tested it with Toke's patch "[PATCH v6 4/4] mac80211: Use
> >> > Airtime-based Queue Limits (AQL) on packet dequeue", but didn't
> >> > include it here, as it is self contained and Toke has plan to update
> >> > it.
> >> >
> >> > The platform (QCA9984) used in my test
> >>
> >> I do keep hoping for pretty pictures. Got any? :-P
> >>
> >> >  doesn't support 802.11ax, so I
> >> > was not able to test the HE mode support added in v7 update of "Impo=
rt
> >> > airtime calculation code from mt76" from Toke.
> >>
> >> Is there an ax QCAXXXX platform, m.2 card, or mini-pci card worth
> >> testing at this point?
> >>
> >> How are they handling mu-mimo?
> >>
> >> I have a round of tests scheduled for intel's ax200 chips, soon. Not s=
ure
> >> what, if any, of this new work might apply.
> >>
> >> > On Thu, Nov 14, 2019 at 5:48 PM Kan Yan <kyan@google.com> wrote:
> >> > >
> >> > > This patch series port the Airtime Queue Limits concept from the o=
ut-of-tree
> >> > > ath10k implementation[0] to mac80211. This version takes my patch =
to do the
> >> > > throttling in mac80211, and replaces the driver API with the mecha=
nism from
> >> > > Toke's series, which instead calculated the expected airtime at de=
queue time
> >> > > inside mac80211, storing it in the SKB cb field.
> >> > >
> >> > > This version has been tested on QCA9984 platform.
> >> > >
> >> > > [0] https://chromium-review.googlesource.com/c/chromiumos/third_pa=
rty/kernel/+/1703105/7
> >> > >
> >> > > Changelog:
> >> > >
> >> > > v8:
> >> > >   - Includes Toke's v7 version of "mac80211: Import airtime calcul=
ation code from mt76"
> >> > >   - Don't clobber sta's customized queue limit when configuring th=
e default via debugfs
> >> > >   - Fix a racing condition when reset aql_tx_pending.
> >> > >
> >> > > v7:
> >> > >   - Fix aql_total_pending_airtime underflow due to insufficient lo=
cking.
> >> > >
> >> > > v6:
> >> > >   - Fix sta lookup in ieee80211_report_used_skb().
> >> > >   - Move call to ieee80211_sta_update_pending_airtime() to a bit l=
ater in
> >> > >     __ieee80211_tx_status()
> >> > > v5:
> >> > >   - Add missing export of ieee80211_calc_rx_airtime() and make
> >> > >     ieee80211_calc_tx_airtime_rate() static (kbuildbot).
> >> > >   - Use skb_get_queue_mapping() to get the AC from the skb.
> >> > >   - Take basic rate configuration for the BSS into account when ca=
lculating
> >> > >     multicast rate.
> >> > > v4:
> >> > >   - Fix calculation that clamps the maximum airtime to fit into 10=
 bits
> >> > >   - Incorporate Rich Brown's nits for the commit message in Kan's =
patch
> >> > >   - Add fewer local variables to ieee80211_tx_dequeue()
> >> > > v3:
> >> > >   - Move the tx_time_est field so it's shared with ack_frame_id, a=
nd use units
> >> > >     of 4us for the value stored in it.
> >> > >   - Move the addition of the Ethernet header size into ieee80211_c=
alc_expected_tx_airtime()
> >> > > v2:
> >> > >   - Integrate Kan's approach to airtime throttling.
> >> > >   - Hopefully fix the cb struct alignment on big-endian architectu=
res.
> >> > >
> >> > >
> >> > >
> >> > > Kan Yan (1):
> >> > >   mac80211: Implement Airtime-based Queue Limit (AQL)
> >> > >
> >> > > Toke H=C3=B8iland-J=C3=B8rgensen (1):
> >> > >   mac80211: Import airtime calculation code from mt76
> >> > >
> >> > >  include/net/cfg80211.h     |   7 +
> >> > >  include/net/mac80211.h     |  41 +++
> >> > >  net/mac80211/Makefile      |   3 +-
> >> > >  net/mac80211/airtime.c     | 597 ++++++++++++++++++++++++++++++++=
+++++
> >> > >  net/mac80211/debugfs.c     |  85 ++++++
> >> > >  net/mac80211/debugfs_sta.c |  43 ++-
> >> > >  net/mac80211/ieee80211_i.h |   8 +
> >> > >  net/mac80211/main.c        |  10 +-
> >> > >  net/mac80211/sta_info.c    |  38 +++
> >> > >  net/mac80211/sta_info.h    |   8 +
> >> > >  net/mac80211/tx.c          |  47 ++-
> >> > >  11 files changed, 872 insertions(+), 15 deletions(-)
> >> > >  create mode 100644 net/mac80211/airtime.c
> >> > >
> >> > > --
> >> > > 2.24.0.rc1.363.gb1bccd3e3d-goog
> >> > >
> >> > _______________________________________________
> >> > Make-wifi-fast mailing list
> >> > Make-wifi-fast@lists.bufferbloat.net
> >> > https://lists.bufferbloat.net/listinfo/make-wifi-fast
> >>
> >>
> >>
> >> --
> >>
> >> Dave T=C3=A4ht
> >> CTO, TekLibre, LLC
> >> http://www.teklibre.com
> >> Tel: 1-831-205-9740
>
>
>
> --
>
> Dave T=C3=A4ht
> CTO, TekLibre, LLC
> http://www.teklibre.com
> Tel: 1-831-205-9740
