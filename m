Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019A2BF3EC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfIZNRl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 09:17:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726106AbfIZNRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 09:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569503860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fHt9hMMQ9w20DhXUGLUHzXPaBqepejvOHd5R4R+dMM=;
        b=C3lVwJzTaxGP+8RDzcdteHEUcfaOowe2+RkEsTwXTYGbQIR5AexfHZo9CWfM8WOMhrqvvw
        fiYuQfBWaIK1efPniOwA8m0lbH7/btSdJbyoVvmAYLJZyQw9hViZtD6htkkjaorhfXNFpA
        IzuEGLYCo16HK+pglT3T3hzBIjfUJyU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-e6p2ACzQO4OX9aAi3pbQfQ-1; Thu, 26 Sep 2019 09:17:37 -0400
Received: by mail-ed1-f70.google.com with SMTP id p55so1339836edc.5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 06:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=d5emT88HnX0Wz5aHzSDSckG8r3WZyvmiapWTnRvA1Qs=;
        b=r95JnGUnRlH5ZzQzH/b7a50n0yQhhmH7/kUBsRO7k2qz5/JPveQ++Kpmq6mWBG3IHj
         OQ3q2Oa5ta6hDyLJfNnuWrL1thxul0TdEgohZNH/G+PDQK3YsdEb3RzFmL3zCKOpkR77
         UmqUdtzaTj7YOe9K1hojwzB2HcTMIR+H6dyQTsXlv0NhtRXReCVWoDcSkQUKKIs/Z/K7
         0BkR23+nC7ydS0BrT69JPJk3CsYuYb0qh8rvGRGwue7l4Kv9aoKCVSQgsR7nJ+PU2MA0
         2NbutVxSBzGq0WYNv0V2u7JdOBmSIVYje7LjsgXRe5Wq6fiPahnsC3gbj6eXmzEbpDME
         7Edg==
X-Gm-Message-State: APjAAAXh/yjHEYG5pZURPGRtTbBVpudZ/TL5Iy8T+yE1byrVlGq1ILsx
        QrL1TKl5g+oYzGRnvrsCzjomAK8oqrs1SX3b8XiA72Nfqs8jd2F6D6W9hLqxp9PmAetb6tr9yPr
        8CyoshIXyWoNi5rpIJggqZQL22+w=
X-Received: by 2002:a05:6402:2d8:: with SMTP id b24mr3541109edx.222.1569503856286;
        Thu, 26 Sep 2019 06:17:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4MpaRGM4uGtZrPqmhhNl8GIWFjLTG/COPVgj/873mgSiv535jFkTl14Kdns8wOz9yYvC23Q==
X-Received: by 2002:a05:6402:2d8:: with SMTP id b24mr3541082edx.222.1569503856077;
        Thu, 26 Sep 2019 06:17:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z24sm236136ejw.57.2019.09.26.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 06:17:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AD56618063D; Thu, 26 Sep 2019 15:17:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 15:17:34 +0200
Message-ID: <87wodv19jl.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: e6p2ACzQO4OX9aAi3pbQfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-19 14:22, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Some devices have deep buffers in firmware and/or hardware which prevent=
s
>> the FQ structure in mac80211 from effectively limiting bufferbloat on th=
e
>> link. For Ethernet devices we have BQL to limit the lower-level queues, =
but
>> this cannot be applied to mac80211 because transmit rates can vary wildl=
y
>> between packets depending on which station we are transmitting it to.
>>=20
>> To overcome this, we can use airtime-based queue limiting (AQL), where w=
e
>> estimate the transmission time for each packet before dequeueing it, and
>> use that to limit the amount of data in-flight to the hardware. This ide=
a
>> was originally implemented as part of the out-of-tree airtime fairness
>> patch to ath10k[0] in chromiumos.
>>=20
>> This patch ports that idea over to mac80211. The basic idea is simple
>> enough: Whenever we dequeue a packet from the TXQs and send it to the
>> driver, we estimate its airtime usage, based on the last recorded TX rat=
e
>> of the station that packet is destined for. We keep a running per-AC tot=
al
>> of airtime queued for the whole device, and when that total climbs above=
 8
>> ms' worth of data (corresponding to two maximum-sized aggregates), we
>> simply throttle the queues until it drops down again.
>>=20
>> The estimated airtime for each skb is stored in the tx_info, so we can
>> subtract the same amount from the running total when the skb is freed or
>> recycled. The throttling mechanism relies on this accounting to be
>> accurate (i.e., that we are not freeing skbs without subtracting any
>> airtime they were accounted for), so we put the subtraction into
>> ieee80211_report_used_skb().
>>=20
>> This patch does *not* include any mechanism to wake a throttled TXQ agai=
n,
>> on the assumption that this will happen anyway as a side effect of whate=
ver
>> freed the skb (most commonly a TX completion).
>>=20
>> The throttling mechanism only kicks in if the queued airtime total goes
>> above the limit. Since mac80211 calculates the time based on the reporte=
d
>> last_tx_time from the driver, the whole throttling mechanism only kicks =
in
>> for drivers that actually report this value. With the exception of
>> multicast, where we always calculate an estimated tx time on the assumpt=
ion
>> that multicast is transmitted at the lowest (6 Mbps) rate.
>>=20
>> The throttling added in this patch is in addition to any throttling alre=
ady
>> performed by the airtime fairness mechanism, and in principle the two
>> mechanisms are orthogonal (and currently also uses two different sources=
 of
>> airtime). In the future, we could amend this, using the airtime estimate=
s
>> calculated by this mechanism as a fallback input to the airtime fairness
>> scheduler, to enable airtime fairness even on drivers that don't have a
>> hardware source of airtime usage for each station.
>>=20
>> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/ke=
rnel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
> One thing that might be missing here is dealing with airtime accounting
> of frames that remain queued in the driver/hardware because the station
> is in powersave mode.

Oh, right. Didn't know that could happen (I assumed those would be
flushed out or something). But if we're going to go with Kan's
suggestion of having per-station accounting as well as a global
accounting for the device, we could just subtract the station's
outstanding balance from the device total when it goes into powersave
mode, and add it back once it wakes up again. At least I think that
would work, no?

-Toke

