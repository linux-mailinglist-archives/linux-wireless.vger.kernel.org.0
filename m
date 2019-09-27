Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB50BFEE7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfI0GMn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 02:12:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfI0GMm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 02:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569564760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yV6HCuv4uCqxbUGYhHUQYMipPglcbXRT48IF3MGcg2k=;
        b=AE/455czXedUyMRQPa4bqDEu7CNXEuUbb8t6CQM8VFX/MH8clNYGHjxo0gNqb7pBklmWFr
        c3Mpaz73XJ+ZaTwV9KkMsKxnMauvHYvx+oyuI9dTlhrahHXW7Y1J7q7VuH9eyuGpFShx2d
        SX6ZYEZX9VMbrSYV37opvgY4bWWIKK0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-LboyJ9VdMvWwKq6NMHtcrg-1; Fri, 27 Sep 2019 02:12:36 -0400
Received: by mail-ed1-f69.google.com with SMTP id m2so959513eds.12
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 23:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ucwMhFdmFOvGG2zJ05eqZy7ChbinSfntZ3YWhitAHvo=;
        b=kuGc5MCkdawCRVPS3uO0+5F1KGQjDC/MkihWUoFI4pUEOMw/pNi9hw5/D2gqcz8TFD
         u9J+YL1lUWfjpCHRc525qZqvI0D80eYw0iH3tO1V1lxuk4kv1Vb0Xc6T2R/I8fa8xW49
         wOxkYPMpBziGqBsohWUY0zgN2K51cyHUtrKnafsCTHYGOQdzp9nFuhZosGvgzAw6spbx
         bMa/n19QeknYQVl8ZtLGiggt5oylFVA6gq8kWaA4ZVZx1ARNTWgYLbLxtHRjT7Lm4Hs+
         2O6n2Kzr8ZFkZz1Hwe1mfhOsdt4Cjpk+78/OtTOD1Lf4f7B5MS3yeGQkqt44vQB944oO
         R6eQ==
X-Gm-Message-State: APjAAAX4ZYtNGJBenMZMmtV2J6sSb/CgrLRRSgg1S0WcjR+Rj8JAO21j
        lda6IxinsPxS0sJ7v8ibiekuPXFSKXG2m1LItOorRypdRnrSHioc9e9aHFsK0z2taBdxJGdSyYk
        Z9tuLZjLDv1nUlWzZxSXAnsx0ksE=
X-Received: by 2002:a50:d949:: with SMTP id u9mr2681900edj.142.1569564755531;
        Thu, 26 Sep 2019 23:12:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnnyNLnBVc8+L5vDU31pAbIPMUdpBDZFRuT8rrznK7JQVoez802/l2Q++UC51aJj9OLVP66A==
X-Received: by 2002:a50:d949:: with SMTP id u9mr2681889edj.142.1569564755326;
        Thu, 26 Sep 2019 23:12:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z39sm311623edd.46.2019.09.26.23.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 23:12:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5D5218063D; Fri, 27 Sep 2019 08:12:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name> <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name> <87tv8z13wv.fsf@toke.dk> <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 08:12:32 +0200
Message-ID: <87r2421d4f.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: LboyJ9VdMvWwKq6NMHtcrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> No, but on tx_completion we could do something like this:
>> airtime =3D CB(skb)->tx_time ?: CB(skb)->tx_time_est;
>> ieee80211_report_airtime(sta, airtime);
>> That way, if the driver sets the tx_time field to something the firmware
>> reports, we'll use that, and otherwise we'd fall back to the estimate.
>> Of course, there would need to be a way for the driver to opt out of
>> this, for drivers that report out of band airtime like ath10k does :)
>
> I doubt that will work, unless firmware can do per frame airtime
> update in the skb. It is more likely that firmware provides out of
> band airtime update for a period of time, like an aggregation. That's
> the case for ath10k: https://patchwork.kernel.org/patch/10684689

No, ath10k would continue to do what it was always doing. Drivers that
can report after-the-fact airtime usage per-frame (like ath9k) will
continue to do that. In both of those cases, the airtime estimate is
only used to throttle the queue, not to schedule for fairness.

My point is just that for drivers that have *no* mechanism to report
airtime usage after-the-fact, we can add a flag that will allow the
values estimated by mac80211 to also be used for the fairness
scheduler...

> Regarding handling frame for station enters power saving mode:
>>
>> >> Oh, right. Didn't know that could happen (I assumed those would be
>> >> flushed out or something). But if we're going to go with Kan's
>> >> suggestion of having per-station accounting as well as a global
>> >> accounting for the device, we could just subtract the station's
>> >> outstanding balance from the device total when it goes into powersave
>> >> mode, and add it back once it wakes up again. At least I think that
>> >> would work, no?
>> >Yes, I think that would work.
>> Great! Will incorporate that, then.
>
> I think that could work but things could be a bit more complicated.
> Not sure I fully understand the usage of airtime_weight_sum in  [PATCH
> V3 1/4] mac80211: Switch to a virtual time-based airtime scheduler:
>
> in ieee80211_schedule_txq():
>    local->airtime_weight_sum[ac] +=3D sta->airtime_weight;
>
> in ieee80211_sta_register_airtime():
>    weight_sum =3D local->airtime_weight_sum[ac] ?: sta->airtime_weight;
>    local->airtime_v_t[ac] +=3D airtime / weight_sum;
>    sta->airtime[ac].v_t +=3D airtime / sta->airtime_weight;
>
> in  __ieee80211_unschedule_txq
>  local->airtime_weight_sum[ac] -=3D sta->airtime_weight;
>
> I assume the purpose of airtime_weight_sum is to count station's
> virtual airtime proportional to the number of active stations for
> fairness.

Yup, the proportion between the station's airtime weight and the total
scheduled airtime weight indicates the station's fair share.

> My concern is the per interface local->airtime_weight_sum[ac] get
> updated when packets are released from a txq to lower layer, but it
> doesn't mean the airtime will be consumed (packets get transmitted)
> shortly, due to events like station enter power save mode, so the
> weight_sum used in ieee80211_sta_register_airtime() maybe inaccurate.
> For architects using firmware/hardware offloading, firmware ultimately
> controls packet scheduling and has quite a lot of autonomy. The host
> driver's airtime_weight_sum may get out of sync with the number of
> active stations actually scheduled by firmware even without power
> saving events.
>
> Is this a correct understanding? I kind of think the original method
> of airtime accounting using deficit maybe more robust in this regard.

You are right that this could happen, yes. However, the station is only
unscheduled when its mac80211 queue runs completely empty. So the
assumption is that stations that transmit continuously (which are really
the ones we care about for fairness purposes), would keep being
scheduled most of the time.

Now, you're quite right that this assumption might be wrong, which would
lead to bad results. I think the other (queue throttling) patch set
would help, though; that should push the queues up into mac80211 and
give the stations a higher probability of being scheduled when they are
in fact backlogged. I've only tested the virtual time scheduler on
ath9k, which inherently has shallow buffers in the hardware.

So yeah, it may be that the virtual time-thing turns out to not work
well. But the results looked encouraging on ath9k, and since it will
make it easier to schedule multiple stations, I think it has some merit
that makes it worth trying out. We should probably get the AQL stuff
done first, though, and try the virtual time scheduler on top of that.

BTW, I think Felix' concern about powersave was in relation to AQL: If
we don't handle power save in that, we can end up in a situation where
the budget for packets allowed to be queued in the firmware is taken up
entirely by stations that are currently in powersave mode; which would
throttle the device completely. So we should take that into account for
AQL; for the fairness scheduler, stations in powersave are already
unscheduled, so that should be fine.

-Toke

