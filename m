Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF170170AEB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2020 22:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBZV4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Feb 2020 16:56:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727584AbgBZV4X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Feb 2020 16:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582754181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Unsw819ZlLENJaKGEJ91QALL1o6hjUqKcn4mY+2vQKg=;
        b=KUaffwKsVYlr0iwo81j2/fcBJodvBa9xLZB/tJ3a//Yn4luyAkC8+J3Ecrtm5hJ9gXJBWt
        dhFLO0vvgKf/7mJlJTArCLNxdaAqUl+gtzYfWl9grn4mKFseYyS+562z1Cg6QmbeiLDAlO
        54tjl5nQYOJOpfM5vDmK1SH7MdHZzc4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-aPhLyqbhNZSzB7lTeQ9ifQ-1; Wed, 26 Feb 2020 16:56:19 -0500
X-MC-Unique: aPhLyqbhNZSzB7lTeQ9ifQ-1
Received: by mail-lj1-f200.google.com with SMTP id z17so153325ljz.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2020 13:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Unsw819ZlLENJaKGEJ91QALL1o6hjUqKcn4mY+2vQKg=;
        b=S7iYqL0tdClVvTaR5gEnszbP9p8SVryvChCmzBTxVpOUHZ1PelQEsJftDOIZMWluuk
         tmhVo5CU80Viq4jgaBLyxamYtiIHTxoE9cns9Ndf7uv+tQnpD6fNT1DJkwKzpKGOSXTU
         LLkn8czfJut+KgWATsTf9b/l5y/p8gPeXQ88rXnPOUdN5t3RSemJ7+zavwDlj6DI4b4L
         8GnQPf+lUzwOvT9CTTpfU9b+CO5UuxqI1si1TXngMxL+EOtIZbeDZp/0kV2HIOpo8SjZ
         yt60Y1ZALvK1BmwZTrybMFMqy4zp2NJyWSnSPdNBJhNJS7VStrrutAP2hfSnVVRSagMr
         lxUw==
X-Gm-Message-State: ANhLgQ3aoWqNVQpzyVKAOGMOs+wdfY5ky+wFqyCqpcewF4W6blyweP7g
        EbarwQdBbgnX/UXLOtqGQN42OEv25l7d+NDEOp02A8FvSo/WB5mN2LpuyJbwIaH6H2fjAO+e2zq
        uM+74uV0L32O+jpd7puogk2/WxmQ=
X-Received: by 2002:a19:4344:: with SMTP id m4mr365796lfj.140.1582754178231;
        Wed, 26 Feb 2020 13:56:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv7mT2wSSxpNUuDG0v/6vRyinArxOaNBJUg0oJa5cnHx1B4RIrcSc19US4V4D41tKBI/frpIw==
X-Received: by 2002:a19:4344:: with SMTP id m4mr365789lfj.140.1582754177967;
        Wed, 26 Feb 2020 13:56:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g78sm1595806lfd.21.2020.02.26.13.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:56:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1EC2E180362; Wed, 26 Feb 2020 22:56:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, yiboz@codeaurora.org,
        john@phrozen.org, lorenzo@kernel.org, rmanohar@codeaurora.org,
        kevinhayes@google.com
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com> <789d592c-5b1b-b785-6d9c-86b7cc7d57f4@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Feb 2020 22:56:15 +0100
Message-ID: <87k149xbb4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi,
>
> I've take a closer look at the AQL implementation, and I found some
> corner cases that need to be addressed soon:
>
> - AQL estimated airtime does not take into account A-MPDU, so it is
> significantly overestimating airtime use for aggregated traffic,
> especially on high rates.
> My proposed solution would be to check for a running aggregation session
> and set estimated tx time to something like:
> expected_airtime(16 * skb->len) / 16.

This seems reasonable. Not sure if it'll do anything for ath10k (does
mac80211 know the aggregation state for that?), but maybe this is not
such a big issue on that hardware?

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

I'm a bit more skeptical about this. If the driver buffers a bunch of
packets that are not accounted that will hurt that station due to extra
latency when it wakes up. For ath9k, this is the retry_q you're talking
about, right? The number of packets queued on that is fairly limited,
isn't it? What kind of powersave buffering is the driver doing, and why
can't it leave the packets on the TXQ? That would allow them to be
scheduled along with any new ones that might have arrived in the
meantime, which would be a benefit for latency.

I can see how it can be a problem that many stations in powersave can
block transmissions for *other* stations, though. Maybe an alternative
to the driver subtracting airtime could be to have mac80211 do something
like this when a station is put into powersave mode:

local->aql_total_pending_airtime -= sum(sta->airtime[ac].aql_tx_pending)

(where sum is the summation over all ACs)

and the reverse when the station wakes back up? That should keep the
whole device from throttling but still prevent a big queue building up
for that sta when it wakes back up. Would that work, do you think?

-Toke

