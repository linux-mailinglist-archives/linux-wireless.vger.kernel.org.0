Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8DC1914
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfI2TSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 15:18:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42297 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728755AbfI2TSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569784710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmClTk6ZBeDnMUQqxWFXdnqlKIKLeLEMugsjxY3medI=;
        b=bD6BypPUn6KNKsMtsvXotrrriPYJ6LtUhT090/GjGbzTNMlp7sMXtBI0TH+wtlPPSt0bc5
        WZDhNzbNR/JoIXChykxwjNC7F1iuESqRnkNsCM7li4sQvvj/2rJX0WYfRy2ZJLXHIEedff
        QN6uzGhVQWJGGhG3jQSA9WFDvWOIZZU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-5bKUW-LoN2aCJw9b9-dRmQ-1; Sun, 29 Sep 2019 15:18:27 -0400
Received: by mail-lf1-f72.google.com with SMTP id r3so2116187lfn.13
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2019 12:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=l7VGnnlSPM+qdvP47z76jYbpQR9HF1SiHUYNg1d9q/Q=;
        b=Rvj9vj7TxF2d//itUwss4DNoMkBgVX8YJnEqYT8xZz0LyyEGs1RKpqnS8DfeuM1mw7
         TmU66Blqze+JTSRaoOa9qjXH1wLNlam8RrPlWOGxcB05m5xu27byreODDLvGI6x05F4b
         Y5fNYEtw57f9dg1CXzvRHiwYiMBBqSpAVCbRZSexigpvktf6o1YogNFTzWfjTtb9knwI
         y/Aea8rUduVIedyknGGGug/tCsaNaMoX/Wyc97dJgzbFQG7iMp9M5e4SQcP6puC3HInx
         6IxgZ6LkGYX0f+m4IxyL2xZF9PT/MYRo8GqpTEkIWcV4tc2n8I09dLvyA371fGly+aU8
         67Ew==
X-Gm-Message-State: APjAAAWmznfoROBgtfSYlkgaAaU2wa8+4aYS7TGbchLFUPJv4mvMvWR6
        eshjc8W3S9sZHqEb2AHJvJDNW9yRZsARzriJPDhhJfUcFZpyfj+MxtX95aEVxdUBAMCjKJE7QA/
        yeU4KOD7qdLuPQEARTqT13ui0dC0=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr9835471ljj.142.1569784706279;
        Sun, 29 Sep 2019 12:18:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuKThtVHIaZkeRIfxRmJqFrWP5oLP8/LYRgpK43G2sqqHQSjWRoJBhb9NyYJFDSUMjSUyH6w==
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr9835452ljj.142.1569784706098;
        Sun, 29 Sep 2019 12:18:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z72sm2469159ljb.98.2019.09.29.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 12:18:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4A27318063D; Sun, 29 Sep 2019 21:18:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5sGkRQy4B=Mz-C90sfqgFmuywa=W7Yjy2CDd8hfppQkvQ@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name> <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name> <87tv8z13wv.fsf@toke.dk> <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com> <87r2421d4f.fsf@toke.dk> <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org> <CA+iem5sGkRQy4B=Mz-C90sfqgFmuywa=W7Yjy2CDd8hfppQkvQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 29 Sep 2019 21:18:24 +0200
Message-ID: <87muemykqn.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 5bKUW-LoN2aCJw9b9-dRmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> No, ath10k would continue to do what it was always doing. Drivers that
>> can report after-the-fact airtime usage per-frame (like ath9k) will
>> continue to do that. In both of those cases, the airtime estimate is
>> only used to throttle the queue, not to schedule for fairness.
> You are right, I didn't realize ath9k reports per frame airtime usage.
>
>> Yeah, I was wondering about that. Makes sense. Why 24ms, exactly?
> The per interface 24 ms queue limit is an empirical number that works
> well for both achieve low latency when there is a lot of stations and
> get high throughput when there is only 1-2 stations.  We could make it
> configurable.

Right. "Found by trial and error" is a fine answer as far as I'm
concerned :)

But yeah, this should probably be configurable, like BQL is.

>> BTW, I think Felix' concern about powersave was in relation to AQL: If
>> we don't handle power save in that, we can end up in a situation where
>>the budget for packets allowed to be queued in the firmware is taken up
>> entirely by stations that are currently in powersave mode; which would
>> throttle the device completely. So we should take that into account for
>> AQL; for the fairness scheduler, stations in powersave are already
>> unscheduled, so that should be fine.
> I think the accounting for the airtime of frames in the power saving
> queue could affect both the fairness scheduler and AQL.
> For chipset with firmware offload, PS handling is mostly done by
> firmware, so host driver's knowledge of PS state could be slightly
> out-of-dated. The power save behavior also make it harder to the
> airtime_weight correct for the fairness scheduler.

Hmm, maybe. I'm not sure how significant this effect would be, but I
guess we'll need to find out :)


> Powersave mode's impact to AQL is much smaller. The lower per station
> queue limit is not impacted by other stations PS behavior, since the
> estimated future airtime is not weighted for other stations and a
> station won't get blocked due to others stations in PS mode.
> Station in PS mode do affects AQL's higher per interface limit, but in
> an inconsequential way. The per interface AQL queue limit is quite
> large (24 ms), hence airtime from packets in PS queue is unlikely to
> have a significant impact on it. Still, it will be better if the
> packet in power saving queue can be taken into account.

I guess the risk is lower when with a 24ms per-iface limit; but with
enough stations I guess it could still happen, no? So we should probably
handle this case...

>> > make it easier to schedule multiple stations, I think it has some meri=
t
>> > that makes it worth trying out. We should probably get the AQL stuff
>> > done first, though, and try the virtual time scheduler on top of that.
>> Agree that we should get the AQL stuff done first since I believe it
>> will help to fix the issue mentioned above.
> That sounds like a good plan. The virtual time scheduler is more
> involved and will take more work to get it right. It make sense to get
> AQL done first.

Cool. Are you going to submit a ported version of your implementation?
Then we can work from the two submissions and see if we can't converge
on something...

-Toke

