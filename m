Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B883BFD46
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 04:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfI0CnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 22:43:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfI0CnD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 22:43:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so968904ljd.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrHwv1QQUeiC42oVHpqwP74xGjPRmObHx4uIOne6Cu4=;
        b=tdvS3NVNNn3tMYy4CaM7RI74yRDg4dwzCMH69CXrwt8fQQNu830e08t/MiZjw/bj+b
         nZoXBQPZ2h/UKSfzqVDearlUdq0xabSEQYnbZAX4CV/kMXPsoe2+VTGhcdOWF3meOIoD
         cuUkWORZIpU80mDBWnpoccc7mlBAIQCpMDa0/fSIUHv8/9gZ/cS1ZjMA2giMk+M/SbkU
         KZ5o8427sv8NloNratir+PfNWKZ33rbR4nikJ6vEaaogeP9MoO8ppPotYYKHlUxI8nnN
         Ji8+hspACWSseycOEK0BIc3C4x+9SPyGHsnrLlp1lIW1YHeSTDdbUy2XSv7RKTq9NFJV
         lFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrHwv1QQUeiC42oVHpqwP74xGjPRmObHx4uIOne6Cu4=;
        b=gTdPMPDvSV1SF62pzQcR5iDFmsDz8Y5thWGqpoCzVoI7ybRz9akMB7h34VntCMn71r
         boXhmSGW928OcBkcq9m9YSGRlxbqqA6dxRrTdA366//ZfB5z37vw+bh/U1WgSv9mOuU9
         HcLzTaSh1Zl7x2yRuKLj4hx+l/vVbuHwqstj5gshZvg2JVn9Ezq+vvaxKVXP+1Iw7uIA
         RbUPTEdOBNKMFror12wOH8MhdEfXlO+09LdeoP0Uf/cQh3vDnWrfjCYpNyt7bDzdfQVo
         vL6iOYJ04qML38ujfPOSNfxhm4hi6TME6SM7gbqPhUz6Ih9UCVwdczmCy9MeEUoQwVHE
         G4jA==
X-Gm-Message-State: APjAAAVcODNGLXu39V5ahHTuImbrL/seL0kvvAjI8xbwu6zMf+C5kk/p
        g70RA/M5SWMKjq5pK2S/YoaRvoTmRjHk94LLlCT3XibrtshLwQ==
X-Google-Smtp-Source: APXvYqzzUvriMKt4p3ObGA7gNvvSxyVvkv0hSZR+Zse97m02ivgxNRgQp8H7aqVDK47SlnUAFqocVbHaB6Ze5zWd1LI=
X-Received: by 2002:a2e:808c:: with SMTP id i12mr1083535ljg.78.1569552180749;
 Thu, 26 Sep 2019 19:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
 <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name> <87tv8z13wv.fsf@toke.dk>
In-Reply-To: <87tv8z13wv.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 26 Sep 2019 19:42:49 -0700
Message-ID: <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> No, but on tx_completion we could do something like this:
> airtime = CB(skb)->tx_time ?: CB(skb)->tx_time_est;
> ieee80211_report_airtime(sta, airtime);
> That way, if the driver sets the tx_time field to something the firmware
> reports, we'll use that, and otherwise we'd fall back to the estimate.
> Of course, there would need to be a way for the driver to opt out of
> this, for drivers that report out of band airtime like ath10k does :)

I doubt that will work, unless firmware can do per frame airtime
update in the skb. It is more likely that firmware provides out of
band airtime update for a period of time, like an aggregation. That's
the case for ath10k: https://patchwork.kernel.org/patch/10684689

Regarding handling frame for station enters power saving mode:
>
> >> Oh, right. Didn't know that could happen (I assumed those would be
> >> flushed out or something). But if we're going to go with Kan's
> >> suggestion of having per-station accounting as well as a global
> >> accounting for the device, we could just subtract the station's
> >> outstanding balance from the device total when it goes into powersave
> >> mode, and add it back once it wakes up again. At least I think that
> >> would work, no?
> >Yes, I think that would work.
> Great! Will incorporate that, then.

I think that could work but things could be a bit more complicated.
Not sure I fully understand the usage of airtime_weight_sum in  [PATCH
V3 1/4] mac80211: Switch to a virtual time-based airtime scheduler:

in ieee80211_schedule_txq():
   local->airtime_weight_sum[ac] += sta->airtime_weight;

in ieee80211_sta_register_airtime():
   weight_sum = local->airtime_weight_sum[ac] ?: sta->airtime_weight;
   local->airtime_v_t[ac] += airtime / weight_sum;
   sta->airtime[ac].v_t += airtime / sta->airtime_weight;

in  __ieee80211_unschedule_txq
 local->airtime_weight_sum[ac] -= sta->airtime_weight;

I assume the purpose of airtime_weight_sum is to count station's
virtual airtime proportional to the number of active stations for
fairness.  My concern is the per interface
local->airtime_weight_sum[ac] get updated when packets are released
from a txq to lower layer, but it doesn't mean the airtime will be
consumed (packets get transmitted) shortly, due to events like station
enter power save mode, so the weight_sum used in
ieee80211_sta_register_airtime() maybe inaccurate. For architects
using firmware/hardware offloading, firmware ultimately controls
packet scheduling and has quite a lot of autonomy. The host driver's
airtime_weight_sum may get out of sync with the number of active
stations actually scheduled by firmware even without power saving
events.

Is this a correct understanding? I kind of think the original method
of airtime accounting using deficit maybe more robust in this regard.
