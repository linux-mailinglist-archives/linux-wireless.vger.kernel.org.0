Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029F1171276
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgB0IYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 03:24:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41627 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgB0IYe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 03:24:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id y17so1393690lfe.8
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KSdeGwYCtFLH7o7hPMmZuggWDg+clP+M0P4fendM5Ek=;
        b=Otj4hm6QeTJRrfwkO76ykmE/ifE+MPb/dKDUprXwIR+u5G2q9EJGcnP4VkTDDnl1NA
         TmgSDWj7TWBoHS1sI2lm0xI3p5aJUqzM/iox4X3F7D68cT+dDg2s1eWTR0YaWjXODb6w
         +Rf11xo0nG6iRF+kammGW+zQvTUWNWSj5finoPLllDZX/Rn9NTNH5xAffyt26h0H+laJ
         JwheIY2VnqePSw1wEeAHn46GnvMoSfFZP794Aj7YbW0hNp7LiELlOkhN82LAY9jqSD4K
         et6pRlsMeyAQnNDI4xEwBpdXuPN58oCWCQcEhxXnz6WSODDwrR4MePqbKfx2sMdZRmUM
         yzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KSdeGwYCtFLH7o7hPMmZuggWDg+clP+M0P4fendM5Ek=;
        b=LJHPxckxvGO4MuUNwCszSR6sxr5/L4Wr8Z9T/CnRBnLCJOFpvIXkRSjFxNNJNFi6B2
         cFDe35ZGZ30rkCpOruCXao0H5WMYrkg0K/QTIetSjyuIJByUjk3S8sholkrWH9hcTwVa
         BYui/bskq1/3DMUidSxZzgGwVE9iOtWr0sNedNvfdVp3Pf6UBknfRUN+HWE0pIZlNYYm
         /jcbbd9Y7V/Mtm7B/GsapsiYO/OPETAwhwBGvA+khg4440vveQrbcYoXzF4XTX5y8DN5
         CiZ50ftNJBwBzOBbQJDJ46RYJByDIsmGvXyvphrl+ouoKK1a8jdarZCveDusmCheYDqe
         OfVg==
X-Gm-Message-State: ANhLgQ3zN65dJLQEEDRu5MSgejhLDrpxWcW+6BYvleEwip9oDOQTr4lC
        XbSb/ZRawI9D28gz+2ICiWeRi2naBIrfFs10S932Kw==
X-Google-Smtp-Source: ADFU+vt2hd8kh+Ro9gzg7dg2MwlDba+5Wu3X8aF3EGyf2t6Z9hXfySkvi8Ih4toHoPiDdVFfCcOEjxoMEOvyfglieHA=
X-Received: by 2002:a19:c106:: with SMTP id r6mr1592136lff.10.1582791869902;
 Thu, 27 Feb 2020 00:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com>
 <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name> <87k149xbb4.fsf@toke.dk>
In-Reply-To: <87k149xbb4.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 27 Feb 2020 00:24:18 -0800
Message-ID: <CA+iem5vcz4PqJR+hj9CyS4pJMD4RpNz2RHxQyUy+-qT9y2WhyQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
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

> - AQL estimated airtime does not take into account A-MPDU, so it is
> significantly overestimating airtime use for aggregated traffic,
> especially on high rates.
> My proposed solution would be to check for a running aggregation session
> and set estimated tx time to something like:
> expected_airtime(16 * skb->len) / 16.

Yes, that's a known limitation that needs to be improved. I actually
post a comment for this patch:
"[PATCH v10 2/4] mac80211: Import airtime calculation code from mt76"
>
> When a txq is subjected to the queue limit,
> there is usually a significant amount of frames being queued and those
> frames are likely being sent out in large aggregations. So, in most
> cases when AQL is active, the medium access overhead can be amortized
> over many frames and the per frame overhead could be considerably
> lower than 36, especially at higher data rate. As a result, the
> pending airtime calculated this way could be higher than the actual
> airtime. In my test, I have to compensate that by increasing
> "aql_txq_limit" via debugfs to get the same peak throughput as without
> AQL.


> My proposed solution would be to check for a running aggregation session
> and set estimated tx time to something like:
> expected_airtime(16 * skb->len) / 16.

I think that's a reasonable approximation, but doubts aggregation
information is available in all architectures. In some architecture,
firmware may only report aggregation information after the frame has
been transmitted.

In my earlier version of AQL for the out-of-tree ChromeOS kernel,
A-MPDU is dealt this way:  The the medium access overhead is only
counted once for each TXQ for all frames released to the hardware over
a 4ms period, assuming those frames are likely to be aggregated
together.

Instead of calculating the estimated airtime using the last known phy
rate, then try to add some estimated overhead for medium access time,
another potentially better approach is to use average data rate, which
is byte_transmited/firmware_reported_actual_airtime. The average rate
not only includes medium access overhead, but also takes retries into
account.

> - We need an API that allows the driver to change the pending airtime
> values, e.g. subtract estimated tx time for a packet.
> mt76 an ath9k can queue packets inside the driver that are not currently
> in the hardware queues. Typically if the txqs have more data than what
> gets put into the hardware queue, both drivers will pull an extra frame
> and queue it in its private txq struct. This frame will get used on the
> next txq scheduling round for that particular station.
> If you have lots of stations doing traffic (or having driver buffered
> frames in powersave mode), this could use up a sizable chunk of the AQL
> budget.

Not sure I fully understand your concerns here. The AQL budget is per
STA, per TID, so frames queued in the driver's special queue for one
station won't impact another station's budget. Those frames are
counted towards the per interface pending airtime, which could trigger
AQL to switch to use the lower queue limit. In this case, that could
be the desirable behavior when there is heavy traffic.

Regards,
Kan



On Wed, Feb 26, 2020 at 1:56 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Felix Fietkau <nbd@nbd.name> writes:
>
> > Hi,
> >
> > I've take a closer look at the AQL implementation, and I found some
> > corner cases that need to be addressed soon:
> >
> > - AQL estimated airtime does not take into account A-MPDU, so it is
> > significantly overestimating airtime use for aggregated traffic,
> > especially on high rates.
> > My proposed solution would be to check for a running aggregation sessio=
n
> > and set estimated tx time to something like:
> > expected_airtime(16 * skb->len) / 16.
>
> This seems reasonable. Not sure if it'll do anything for ath10k (does
> mac80211 know the aggregation state for that?), but maybe this is not
> such a big issue on that hardware?
>
> > - We need an API that allows the driver to change the pending airtime
> > values, e.g. subtract estimated tx time for a packet.
> > mt76 an ath9k can queue packets inside the driver that are not currentl=
y
> > in the hardware queues. Typically if the txqs have more data than what
> > gets put into the hardware queue, both drivers will pull an extra frame
> > and queue it in its private txq struct. This frame will get used on the
> > next txq scheduling round for that particular station.
> > If you have lots of stations doing traffic (or having driver buffered
> > frames in powersave mode), this could use up a sizable chunk of the AQL
> > budget.
>
> I'm a bit more skeptical about this. If the driver buffers a bunch of
> packets that are not accounted that will hurt that station due to extra
> latency when it wakes up. For ath9k, this is the retry_q you're talking
> about, right? The number of packets queued on that is fairly limited,
> isn't it? What kind of powersave buffering is the driver doing, and why
> can't it leave the packets on the TXQ? That would allow them to be
> scheduled along with any new ones that might have arrived in the
> meantime, which would be a benefit for latency.
>
> I can see how it can be a problem that many stations in powersave can
> block transmissions for *other* stations, though. Maybe an alternative
> to the driver subtracting airtime could be to have mac80211 do something
> like this when a station is put into powersave mode:
>
> local->aql_total_pending_airtime -=3D sum(sta->airtime[ac].aql_tx_pending=
)
>
> (where sum is the summation over all ACs)
>
> and the reverse when the station wakes back up? That should keep the
> whole device from throttling but still prevent a big queue building up
> for that sta when it wakes back up. Would that work, do you think?
>
> -Toke
>
