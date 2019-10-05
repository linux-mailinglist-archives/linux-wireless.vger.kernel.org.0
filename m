Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C26CC760
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2019 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJECTS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 22:19:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42931 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJECTS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 22:19:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so5718613lfg.9
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 19:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t04+r+jP0akghMGVhuHJWzelUGouvezZNXvOQOJy4Io=;
        b=sV2EjTuB4nQ0qZY6svoJ/I2BEqMlaR87JAQTpE8xFV9EO4y4giCr9bZemWsFPJN6t5
         jOZeJqwYFV/ueJVkIIO1VIng6UYr4UPnms3n4T9aZhI3zG+Wc3TK6iwFUFJfnhCFT1Q+
         c/bfe+Uf2yz/tO0X3BU9W9hjIglM7fvc1bnPHyMey55ApEHiTkNXg32ce39PyGMF8HKP
         T+K/wN1GB+8aKUGGFvIGNPBYB/vyg0aIwC+ysYjr+lS3QDtXx+ENUiRAvcg5IeAXX1Xb
         V5G8Zyvm41KakKGNQTDDTtMUjEUIv24jENDWyq+2Gv5IkKcC5n6Y3M6RASH1QxCHXj1T
         xVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t04+r+jP0akghMGVhuHJWzelUGouvezZNXvOQOJy4Io=;
        b=lxfAVGHAyZbqQXX0+nSs83ajXOLEmzHYXCt6/3CbfWwnWLQa2cWuByWR/kjSTY8vCK
         +05zOsK83mb++RhsS8OWwb3O4oYigyZOlYxv2xLCzR/MGeJksNL9DKe+1HA5RemjbEU6
         KWV0wWsWyaA6OkZy6dwu4LRP1Qnz4pbr/hjeSfqQrVYyVvpWkv1OXZUX6+9YZof2s4Gj
         hU4aNOSPa7d9w2t1nhEsM2ngCCDYEqfU5I2UMGp7wtfx8ZZFOO4bduPSuvjRPj2W1PRK
         +vRcILxESEeo0DJE1JeKKZppOolVEhYamxVTgJ40a6zJPYUYcp6TUdhpV6/iZPPmFCOe
         MmkQ==
X-Gm-Message-State: APjAAAX724dDMVCXiAqlVqUigVUxRKcwAFCRzDL7yWSrTb0PRde0JyC9
        0PYIWrt9V6jwnsrV8Kddla+7ATty6BkkFUNXE/v6Bw==
X-Google-Smtp-Source: APXvYqyZJbCL8cfEA37VL+1pA5c7sA8YxTEcDkUyFSoG528KrrAwd78EAD4HF2IyY6/iCnL551JDkVlRR/IdrToQsXU=
X-Received: by 2002:a19:9145:: with SMTP id y5mr10612825lfj.88.1570241954682;
 Fri, 04 Oct 2019 19:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com>
 <87imp4o6qp.fsf@toke.dk> <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
In-Reply-To: <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 4 Oct 2019 19:19:03 -0700
Message-ID: <CA+iem5tii+OVB7r9ecd0s=_-OdvF1xqpr3j76gf=1n_cr+-XJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Yibo Zhao <yiboz@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Toke,

> So I think it'll be better to pass up the last_rate and have mac80211
> calculate the airtime (like I did in my patch set). But we can keep the
> rest of your logic and just switch the calculation, I guess?
Sounds like a good plan to me. Moving the airtime calculation do makes
it easier to support multiple drivers. The only benefit of keep that
part in driver is we can avoid extending ieee80211_tx_info with a new
field "tx_time_est".

I will fix the "AIRTIME_USE_TX" part and prepare a new patch.

Thanks,
Kan

On Fri, Oct 4, 2019 at 7:08 PM Kan Yan <kyan@google.com> wrote:
>
> Hi Johannes,
>
> Thanks for help review this patch.  I will fix all style errors.
>
> > > +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee8021=
1_txq *txq);
> > Why is it necessary to call this, vs. just returning NULL when an SKB i=
s
> > requested?
> This function is also called by ath10k, from ath10k_mac_tx_can_push(),
> which returns a boolean.
>
> > However, I'm not sure it *shouldn't* actually be per interface (i.e.
> > moving from
> >         local->aql_total_pending_airtime
> > to
> >
> >         sdata->aql_total_pending_airtime
> >
> > because you could have multiple channels etc. involved and then using a
> > single airtime limit across two interfaces that are actually on two
> > different channels (e.g. 2.4 and 5 GHz) doesn't make that much sense.
> >
> > Actually, it does make some sense as long as the NIC is actually
> > channel-hopping ... but that's in the process of changing now, there's
> > going to be hardware really soon (or perhaps already exists) that has
> > real dual-band capabilities...
>
> That's a good point.  I haven't thought about real simultaneous dual
> band chipset and such chipset do exists now. Is RSDB support coming to
> mac80211 soon? Just curious if it will be just virtual interfaces or
> something else. I chose "local" instead of "sdata" thinking about the
> case of several virtual interfaces (AP, STA, MESH) operates in the
> same channel, then the interface total could be a better choice.
>
> I am ok with moving the "aql_total_pending_airtime" into sdata, but
> afraid that's not the most optimal choice for the case of multiple
> virtual interfaces operates in the same channel.
> Maybe we could leave it in "local" for now. What do you think?
>
> Kan
>
> On Fri, Oct 4, 2019 at 8:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
> >
> > Kan Yan <kyan@google.com> writes:
> >
> > > In order for the Fq_CoDel integrated in mac80211 layer operates
> > > effectively to control excessive queueing latency, the CoDel algorith=
m
> > > requires an accurate measure of how long the packets stays in the
> > > queue, aka sojourn time. The sojourn time measured at mac80211 layer
> > > doesn't include queueing latency in lower layer (firmware/hardware)
> > > and CoDel expects lower layer to have a short queue. However, most
> > > 802.11ac chipsets offload tasks such TX aggregation to firmware or
> > > hardware, thus have a deep lower layer queue. Without a mechanism to
> > > control the lower layer queue size, packets only stays in mac80211
> > > layer transiently before being released to firmware due to the deep
> > > queue in the lower layer. In this case, the sojourn time measured by
> > > CoDel in the mac80211 layer is always lower than the CoDel latency
> > > target hence it does little to control the latency, even when the low=
er
> > > layer queue causes excessive latency.
> > >
> > > Byte Queue limits (BQL) is commonly used to address the similar issue
> > > with wired network interface. However, this method can not be applied
> > > directly to the wireless network interface. Byte is not a suitable
> > > measure of queue depth in the wireless network, as the data rate can
> > > vary dramatically from station to station in the same network, from a
> > > few Mbps to over 1 Gbps.
> > >
> > > This patch implemented an Airtime-based Queue Limit (AQL) to make CoD=
el
> > > works effectively with wireless drivers that utilized firmware/hardwa=
re
> > > offloading. It only allows each txq to release just enough packets to
> > > form 1-2 large aggregations to keep hardware fully utilized and keep =
the
> > > rest of frames in mac80211 layer to be controlled by CoDel.
> > >
> > > Change-Id: I1427db2c4c7fcb4162b087514dcb06d5613fa5d2
> > > Signed-off-by: Kan Yan <kyan@google.com>
> > > ---
> > >  include/net/cfg80211.h     |  7 ++++
> > >  include/net/mac80211.h     | 34 ++++++++++++++++
> > >  net/mac80211/debugfs.c     | 79 ++++++++++++++++++++++++++++++++++++=
++
> > >  net/mac80211/debugfs_sta.c | 43 +++++++++++++++------
> > >  net/mac80211/ieee80211_i.h |  4 ++
> > >  net/mac80211/main.c        |  7 +++-
> > >  net/mac80211/sta_info.c    | 23 +++++++++++
> > >  net/mac80211/sta_info.h    |  4 ++
> > >  net/mac80211/tx.c          | 60 ++++++++++++++++++++++++-----
> > >  9 files changed, 239 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > index 26e2ad2c7027..301c11be366a 100644
> > > --- a/include/net/cfg80211.h
> > > +++ b/include/net/cfg80211.h
> > > @@ -2499,6 +2499,13 @@ enum wiphy_params_flags {
> > >
> > >  #define IEEE80211_DEFAULT_AIRTIME_WEIGHT     256
> > >
> > > +/* The per TXQ firmware queue limit in airtime */
> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L    4000
> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H    8000
> > > +
> > > +/* The firmware's transmit queue size limit in airtime */
> > > +#define IEEE80211_DEFAULT_AQL_INTERFACE_LIMIT        24000
> > > +
> > >  /**
> > >   * struct cfg80211_pmksa - PMK Security Association
> > >   *
> > > diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> > > index d26da013f7c0..4d62aba3e4b2 100644
> > > --- a/include/net/mac80211.h
> > > +++ b/include/net/mac80211.h
> > > @@ -5543,6 +5543,40 @@ void ieee80211_send_eosp_nullfunc(struct ieee8=
0211_sta *pubsta, int tid);
> > >  void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8=
 tid,
> > >                                   u32 tx_airtime, u32 rx_airtime);
> > >
> > > +/**
> > > + * ieee80211_sta_register_pending_airtime - register the estimated a=
irtime for
> > > + * the frames pending in lower layer (firmware/hardware) txq.
> > > + *
> > > + * Update the total pending airtime of the frames released to firmwa=
re. The
> > > + * pending airtime is used by AQL to control queue size in the lower=
 layer.
> > > + *
> > > + * The airtime is estimated using frame length and the last reported=
 data
> > > + * rate. The pending airtime for a txq is increased by the estimated
> > > + * airtime when the frame is relased to the lower layer, and decreas=
ed by the
> > > + * same amount at the tx completion event.
> > > + *
> > > + * @pubsta: the station
> > > + * @tid: the TID to register airtime for
> > > + * @tx_airtime: the estimated airtime (in usec)
> > > + * @tx_commpleted: true if called from the tx completion event.
> > > + */
> > > +void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pu=
bsta,
> > > +                                         u8 tid, u32 tx_airtime,
> > > +                                         bool tx_completed);
> > > +
> > > +/**
> > > + * ieee80211_txq_aritme_check - check if the airtime limit of AQL (A=
irtime based
> > > + * queue limit) has been reached.
> > > + * @hw: pointer obtained from ieee80211_alloc_hw()
> > > + * @txq: pointer obtained from station or virtual interface
> > > + * Retrun true if the queue limit has not been reached and txq can c=
ontinue to
> > > + * release packets to the lower layer.
> > > + * Return false if the queue limit has been reached and the txq shou=
ld not
> > > + * release more frames to the lower layer.
> > > + */
> > > +bool
> > > +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee8021=
1_txq *txq);
> > > +
> >
> > So I think it'll be better to pass up the last_rate and have mac80211
> > calculate the airtime (like I did in my patch set). But we can keep the
> > rest of your logic and just switch the calculation, I guess?
> >
> > I'd like to use the new rate calculation code that Felix added to mt76.
> > Is the arsta->txrate info in ath10k suitable to be passed up to mac8021=
1
> > and used in that, do you think? Because then that would probably be the
> > easiest way to go about it...
> >
> > [...]
> >
> > > @@ -3726,9 +3733,7 @@ void __ieee80211_schedule_txq(struct ieee80211_=
hw *hw,
> > >                * get immediately moved to the back of the list on the=
 next
> > >                * call to ieee80211_next_txq().
> > >                */
> > > -             if (txqi->txq.sta &&
> > > -                 wiphy_ext_feature_isset(local->hw.wiphy,
> > > -                                         NL80211_EXT_FEATURE_AIRTIME=
_FAIRNESS))
> > > +             if (txqi->txq.sta && local->airtime_flags & AIRTIME_USE=
_TX)
> >
> > This is wrong. The USE_TX/USE_RX flags just set which types of airtime
> > will be subtracted from the deficit. We should still be running the
> > scheduler if *either* of them is set...
> >
> > >                       list_add(&txqi->schedule_order,
> > >                                &local->active_txqs[txq->ac]);
> > >               else
> > > @@ -3740,6 +3745,37 @@ void __ieee80211_schedule_txq(struct ieee80211=
_hw *hw,
> > >  }
> > >  EXPORT_SYMBOL(__ieee80211_schedule_txq);
> > >
> > > +bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
> > > +                          struct ieee80211_txq *txq)
> > > +{
> > > +     struct sta_info *sta;
> > > +     struct ieee80211_local *local =3D hw_to_local(hw);
> > > +
> > > +
> > > +     if (!(local->airtime_flags & AIRTIME_USE_TX))
> >
> > Ditto.
> >
> > > +             return true;
> > > +
> > > +     if (!txq->sta)
> > > +             return true;
> > > +
> > > +     sta =3D container_of(txq->sta, struct sta_info, sta);
> > > +     if (sta->airtime[txq->ac].deficit < 0)
> > > +             return false;
> > > +
> > > +     if (!(local->airtime_flags & AIRTIME_USE_AQL))
> > > +             return true;
> > > +
> > > +     if ((sta->airtime[txq->ac].aql_tx_pending <
> > > +          sta->airtime[txq->ac].aql_limit_low) ||
> > > +         (local->aql_total_pending_airtime < local->aql_interface_li=
mit &&
> > > +          sta->airtime[txq->ac].aql_tx_pending <
> > > +          sta->airtime[txq->ac].aql_limit_high))
> > > +             return true;
> > > +     else
> > > +             return false;
> > > +}
> > > +EXPORT_SYMBOL(ieee80211_txq_airtime_check);
> > > +
> > >  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
> > >                               struct ieee80211_txq *txq)
> > >  {
> > > @@ -3748,10 +3784,13 @@ bool ieee80211_txq_may_transmit(struct ieee80=
211_hw *hw,
> > >       struct sta_info *sta;
> > >       u8 ac =3D txq->ac;
> > >
> > > -     spin_lock_bh(&local->active_txq_lock[ac]);
> > > -
> > >       if (!txqi->txq.sta)
> > > -             goto out;
> > > +             return true;
> > > +
> > > +     if (!(local->airtime_flags & AIRTIME_USE_TX))
> >
> > Ditto.
> >
> >
> > -Toke
> >
