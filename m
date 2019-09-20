Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB1B900F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfITMyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 08:54:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36288 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbfITMyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 08:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568984087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj0kXppzYIiVfnx8T0bfeEtq0X35Qn2Fzk6PJ8DM6R4=;
        b=A031Ja7IjHv7W7p+D+M0uZdbuNiM+Vo4cTSjMsF7zRmD/BL7sWizPYC1PyLSMEakh/jFPW
        PH5P4yyPX0vDWjU0sBDj/Auk+jb5aWkoLdvAr/MJI41KC4Pn3eShKn3CIdW/6egyN621dU
        Ck5bnN3zYzXt9qeSZzs5ADVNoXkgWUo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-pysASFPEPHqk4j5wWxFYjw-1; Fri, 20 Sep 2019 08:54:45 -0400
Received: by mail-ed1-f69.google.com with SMTP id n12so4121753edr.22
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4qSSTX+s/ax1TmheJO7FKdRpYSoJxpSQtSu3oU5qOUQ=;
        b=jzpkARk+HpM7rpDv0vJDUcv25Cxp9wgvA/Ca33roDmCgcMMJ0Ezgpw/LW6OHokDNPn
         AHVlVbE7ucRAyvjx8w0JugLytGQbMSwm+KTGK3Q0LhiSd5aMA5DXzBseswJp/VzHB337
         l2t0GNbA5YDdxAuFy414tNc0+3TevmNEX4mO0NCdXrdQLG3hL8LFNgoE56InF/Z+jxxs
         o2HmiGCfdgEGH2t2cF3z7wBjyk2ZveGfhQ7xNJi1rFE1SOhkI3ZwxJdfh0t/jv7Czjn3
         YsBpbve0yeDIL5s63RvLba865386/eCaqI0zTlm1ddfcRg9TPetMvHeN6f3bUFnEZinG
         uCYQ==
X-Gm-Message-State: APjAAAXXzEj9IvQqcMjdtQAIqD+KOmfAvTjJbSfhfcMKGHNQsFtFZbZD
        gIjjSmXLUXwbBDLh24gyVL+J0AXlBIq5F6g1TTOsrEq3GpBrPD+ieDuKVZQOIOqn6aZuRg7YPKL
        /HNTko90+zB+7MsTuIQvVbH+QYrQ=
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr2231073ejm.3.1568984083654;
        Fri, 20 Sep 2019 05:54:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlFlF+QahWq9VK24J1/aC/Hpcg9tp5iNVElx1MT8Na0o5V8z/MsOXk4XRIZ5lIb3nOekU/Ew==
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr2231040ejm.3.1568984083354;
        Fri, 20 Sep 2019 05:54:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i1sm225643ejv.92.2019.09.20.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 05:54:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2172918063E; Fri, 20 Sep 2019 14:54:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <20190920120639.GA6456@localhost.localdomain>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <20190920120639.GA6456@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Sep 2019 14:54:42 +0200
Message-ID: <87k1a39lgt.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: pysASFPEPHqk4j5wWxFYjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

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
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
>>  net/mac80211/ieee80211_i.h |    7 +++++++
>>  net/mac80211/status.c      |   22 ++++++++++++++++++++++
>>  net/mac80211/tx.c          |   38 +++++++++++++++++++++++++++++++++++++=
-
>>  4 files changed, 90 insertions(+), 1 deletion(-)
>
> Hi Toke,
>
> Thx a lot for working on this. Few comments inline.
>
> Regards,
> Lorenzo
>
>>=20
>> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
>> index 568b3b276931..c846c6e7f3e3 100644
>> --- a/net/mac80211/debugfs.c
>> +++ b/net/mac80211/debugfs.c
>> @@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =3D {
>>  =09.llseek =3D default_llseek,
>>  };
>> =20
>
> [...]
>
>> @@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8=
0211_hw *hw,
>>  =09tx.skb =3D skb;
>>  =09tx.sdata =3D vif_to_sdata(info->control.vif);
>> =20
>> -=09if (txq->sta)
>> +=09pktlen =3D skb->len + 38;
>> +=09if (txq->sta) {
>>  =09=09tx.sta =3D container_of(txq->sta, struct sta_info, sta);
>> +=09=09if (tx.sta->last_tx_bitrate) {
>> +=09=09=09airtime =3D (pktlen * 8 * 1000 *
>> +=09=09=09=09   tx.sta->last_tx_bitrate_reciprocal) >> IEEE80211_RECIPRO=
CAL_SHIFT;
>> +=09=09=09airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
>
> Here we are not taking into account aggregation burst size (it is done
> in a rough way in chromeos implementation) and tx retries. I have not
> carried out any tests so far but I think IEEE80211_AIRTIME_OVERHEAD
> will led to a significant airtime overestimation. Do you think this
> can be improved? (..I agree this is not a perfect world, but .. :))

Hmm, yeah, looking at this again, the way I'm going this now, I should
probably have used the low 16-us IFS overhead for every packet.

I guess we could do something similar to what the chromeos thing is
doing. I.e., adding a single "large" overhead value when we think the
packet is the first of a burst, and using the smaller value for the
rest.

One approach could be to couple the switch to the "scheduling rounds" we
already have. I.e., first packet after a call to
ieee8021_txq_schedule_start() will get the 100-us overhead, and every
subsequent one will get the low one. Not sure how this will fit with
what the driver actually does, though, so I guess some experimentation
is in order.

Ultimately,  I'm not sure it matters that much whether occasionally add
80 us extra to the estimate. But as you say, adding 100 us to every
packet is probably a bit much ;)

> Moreover, can this approach be affected by some interrupt coalescing
> implemented by the chipset?

Probably? Ultimately we don't really know what exactly the chipset is
doing, so we're guessing here, no?

-Toke

