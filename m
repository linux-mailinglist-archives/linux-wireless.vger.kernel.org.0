Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81CCC121E
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2019 22:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfI1UYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Sep 2019 16:24:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36434 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfI1UYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Sep 2019 16:24:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so5671553ljj.3
        for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2019 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tyi0evHwLfwcwD83LLykSn2INcl6iYElhwIbGVcXvmU=;
        b=R6HvMUW4CRnHUtG1JCtqs5AXp+xpihW3b1yQsoZXFWvd+PVHMDvukf6ufyUTdRupZf
         60U4o17S2GfRZSURcs7TQR4fuXExzaHFdKLqLxOKFts1jiUCIRsfOFbImjyAG72nOl1k
         YH1mRyOQCCL1mwFrOhD0fMcVDL43nKghzQ0zfJvV2S4Di5M/FUvhO/YnOWVwLL+BF4cH
         jcQmUsX+9gjKbUoSVppw/GZ99kYf/9IeEAyeoxEJQ3PGQtURi4KH/N6EvGb4NDFdremd
         tYQt4hmN667muaTrb6+IrHdl3ZBkMVNHV8grOB0td1Pxi1gjg7HVU5yuVoT5dF4pZh3o
         xBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tyi0evHwLfwcwD83LLykSn2INcl6iYElhwIbGVcXvmU=;
        b=Y31Af37UhtBmwZTwpaa7daVVXW34OggumWBTrQk78F+vSkJmmCbM7bxhzSBo5ZvYrI
         fv9Sq5HeFvLrna4Eau4WfUOHcDEjxy9aaNCgNy4YV6gOlwIbl+NVyCW4AX7CBevyFDXY
         UIax184lLguFQcJ30R+khFCPP2EPHNNkuzdLBh4sbm+a1VgxZv1M1h3uFDuk3uFZMR+Y
         +6euH6N/WKZOyVMP7WfAOu4KzFNz8NB/XICbr4dx6wx3hoMcbKwdHZV0dBF233S+GSWN
         +1SRtEKzN08VONMljZSWwqukg1SnMoucvKhOzpKW3nS5RG8XwhlpUBLPv59qGIMclnZ2
         4t4Q==
X-Gm-Message-State: APjAAAXwgNXUFwHomNbXhjDJY+SBH96FBsJ7HwFGFXB1sHCGTNR3HZHl
        fV01+wb4H5dq6YRExQzolzeDkxJbIu64ggSrE0QHiw==
X-Google-Smtp-Source: APXvYqxsABMBaDzterU+6wYBk9HVTry+ZaNYDeJzZ47g4qMdesihazyOGYOT51vsC1ofo4VFj2H1MI8XJiMXVEpFfss=
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr5161437lji.51.1569702284718;
 Sat, 28 Sep 2019 13:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
 <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name>
 <87tv8z13wv.fsf@toke.dk> <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
 <87r2421d4f.fsf@toke.dk> <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org>
In-Reply-To: <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org>
From:   Kan Yan <kyan@google.com>
Date:   Sat, 28 Sep 2019 13:24:32 -0700
Message-ID: <CA+iem5sGkRQy4B=Mz-C90sfqgFmuywa=W7Yjy2CDd8hfppQkvQ@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> No, ath10k would continue to do what it was always doing. Drivers that
> can report after-the-fact airtime usage per-frame (like ath9k) will
> continue to do that. In both of those cases, the airtime estimate is
> only used to throttle the queue, not to schedule for fairness.
You are right, I didn't realize ath9k reports per frame airtime usage.

> Yeah, I was wondering about that. Makes sense. Why 24ms, exactly?
The per interface 24 ms queue limit is an empirical number that works
well for both achieve low latency when there is a lot of stations and
get high throughput when there is only 1-2 stations.  We could make it
configurable.

> BTW, I think Felix' concern about powersave was in relation to AQL: If
> we don't handle power save in that, we can end up in a situation where
>the budget for packets allowed to be queued in the firmware is taken up
> entirely by stations that are currently in powersave mode; which would
> throttle the device completely. So we should take that into account for
> AQL; for the fairness scheduler, stations in powersave are already
> unscheduled, so that should be fine.
I think the accounting for the airtime of frames in the power saving
queue could affect both the fairness scheduler and AQL.
For chipset with firmware offload, PS handling is mostly done by
firmware, so host driver's knowledge of PS state could be slightly
out-of-dated. The power save behavior also make it harder to the
airtime_weight correct for the fairness scheduler.
Powersave mode's impact to AQL is much smaller. The lower per station
queue limit is not impacted by other stations PS behavior, since the
estimated future airtime is not weighted for other stations and a
station won't get blocked due to others stations in PS mode.
Station in PS mode do affects AQL's higher per interface limit, but in
an inconsequential way. The per interface AQL queue limit is quite
large (24 ms), hence airtime from packets in PS queue is unlikely to
have a significant impact on it. Still, it will be better if the
packet in power saving queue can be taken into account.

> > make it easier to schedule multiple stations, I think it has some merit
> > that makes it worth trying out. We should probably get the AQL stuff
> > done first, though, and try the virtual time scheduler on top of that.
> Agree that we should get the AQL stuff done first since I believe it
> will help to fix the issue mentioned above.
That sounds like a good plan. The virtual time scheduler is more
involved and will take more work to get it right. It make sense to get
AQL done first.


On Fri, Sep 27, 2019 at 2:20 AM Yibo Zhao <yiboz@codeaurora.org> wrote:
>
> On 2019-09-27 14:12, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Kan Yan <kyan@google.com> writes:
> >
> >>> No, but on tx_completion we could do something like this:
> >>> airtime =3D CB(skb)->tx_time ?: CB(skb)->tx_time_est;
> >>> ieee80211_report_airtime(sta, airtime);
> >>> That way, if the driver sets the tx_time field to something the
> >>> firmware
> >>> reports, we'll use that, and otherwise we'd fall back to the
> >>> estimate.
> >>> Of course, there would need to be a way for the driver to opt out of
> >>> this, for drivers that report out of band airtime like ath10k does :)
> >>
> >> I doubt that will work, unless firmware can do per frame airtime
> >> update in the skb. It is more likely that firmware provides out of
> >> band airtime update for a period of time, like an aggregation. That's
> >> the case for ath10k: https://patchwork.kernel.org/patch/10684689
> >
> > No, ath10k would continue to do what it was always doing. Drivers that
> > can report after-the-fact airtime usage per-frame (like ath9k) will
> > continue to do that. In both of those cases, the airtime estimate is
> > only used to throttle the queue, not to schedule for fairness.
> >
> > My point is just that for drivers that have *no* mechanism to report
> > airtime usage after-the-fact, we can add a flag that will allow the
> > values estimated by mac80211 to also be used for the fairness
> > scheduler...
> >
> >> Regarding handling frame for station enters power saving mode:
> >>>
> >>> >> Oh, right. Didn't know that could happen (I assumed those would be
> >>> >> flushed out or something). But if we're going to go with Kan's
> >>> >> suggestion of having per-station accounting as well as a global
> >>> >> accounting for the device, we could just subtract the station's
> >>> >> outstanding balance from the device total when it goes into powers=
ave
> >>> >> mode, and add it back once it wakes up again. At least I think tha=
t
> >>> >> would work, no?
> >>> >Yes, I think that would work.
> >>> Great! Will incorporate that, then.
> >>
> >> I think that could work but things could be a bit more complicated.
> >> Not sure I fully understand the usage of airtime_weight_sum in  [PATCH
> >> V3 1/4] mac80211: Switch to a virtual time-based airtime scheduler:
> >>
> >> in ieee80211_schedule_txq():
> >>    local->airtime_weight_sum[ac] +=3D sta->airtime_weight;
> >>
> >> in ieee80211_sta_register_airtime():
> >>    weight_sum =3D local->airtime_weight_sum[ac] ?: sta->airtime_weight=
;
> >>    local->airtime_v_t[ac] +=3D airtime / weight_sum;
> >>    sta->airtime[ac].v_t +=3D airtime / sta->airtime_weight;
> >>
> >> in  __ieee80211_unschedule_txq
> >>  local->airtime_weight_sum[ac] -=3D sta->airtime_weight;
> >>
> >> I assume the purpose of airtime_weight_sum is to count station's
> >> virtual airtime proportional to the number of active stations for
> >> fairness.
> >
> > Yup, the proportion between the station's airtime weight and the total
> > scheduled airtime weight indicates the station's fair share.
> >
> >> My concern is the per interface local->airtime_weight_sum[ac] get
> >> updated when packets are released from a txq to lower layer, but it
> >> doesn't mean the airtime will be consumed (packets get transmitted)
> >> shortly, due to events like station enter power save mode, so the
> >> weight_sum used in ieee80211_sta_register_airtime() maybe inaccurate.
> >> For architects using firmware/hardware offloading, firmware ultimately
> >> controls packet scheduling and has quite a lot of autonomy. The host
> >> driver's airtime_weight_sum may get out of sync with the number of
> >> active stations actually scheduled by firmware even without power
> >> saving events.
> >>
> >> Is this a correct understanding? I kind of think the original method
> >> of airtime accounting using deficit maybe more robust in this regard.
> >
> > You are right that this could happen, yes. However, the station is only
> > unscheduled when its mac80211 queue runs completely empty. So the
> > assumption is that stations that transmit continuously (which are
> > really
> > the ones we care about for fairness purposes), would keep being
> > scheduled most of the time.
> >
> > Now, you're quite right that this assumption might be wrong, which
> > would
> > lead to bad results. I think the other (queue throttling) patch set
> > would help, though; that should push the queues up into mac80211 and
> > give the stations a higher probability of being scheduled when they are
> > in fact backlogged. I've only tested the virtual time scheduler on
> > ath9k, which inherently has shallow buffers in the hardware.
> >
> > So yeah, it may be that the virtual time-thing turns out to not work
> > well. But the results looked encouraging on ath9k, and since it will
>
> I am not familiar with ath9k but SFAIK, ath9k is fine with virtual
> time-thing because it does not have firmware/hardware offloading. Thus
> host can see the packets backlogged in host queue and TXQs stay on
> rbtree for the most of time if there is continuous transmission. As a
> result, the algo fully works. While for ath10k like Kan said, it has
> firmware/hardware offloading and host cannot see the packets backlogged
> in host queue because they are already sent to FW queue as long as the
> ingress load less than PHY rate. Then TXQs are removed from the rbtree
> which leads to the algo not working so well. For driver that has
> firmware/hardware offloading, I think the key is to keep some of the
> packets buffered in the host even if FW queue is not full at that time.
> Also I believe DRR may have the same issue since only TXQs in the list
> contend for Tx chance.
>
> > make it easier to schedule multiple stations, I think it has some merit
> > that makes it worth trying out. We should probably get the AQL stuff
> > done first, though, and try the virtual time scheduler on top of that.
>
> Agree that we should get the AQL stuff done first since I believe it
> will help to fix the issue mentioned above.
>
> >
> > BTW, I think Felix' concern about powersave was in relation to AQL: If
> > we don't handle power save in that, we can end up in a situation where
> > the budget for packets allowed to be queued in the firmware is taken up
> > entirely by stations that are currently in powersave mode; which would
> > throttle the device completely. So we should take that into account for
> > AQL; for the fairness scheduler, stations in powersave are already
> > unscheduled, so that should be fine.
> >
> > -Toke
>
> --
> Yibo
