Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252D0BEBD0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392694AbfIZGEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 02:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392682AbfIZGEa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 02:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569477865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJjKvUAiAvso3g67cfZxWoqpQkJ8lofBbPzkRMA+OUE=;
        b=eKPrhkHfFS7QIJ3uS/HnbQAbJQeZN3pxxWApzuJtqvkktV1KVDgp2G4se36Q3aG05Gl5se
        jfgdyqYx8TudQYvpTQAH80uFndDFwwNtnVcS6NbBsEumvaPb/2kdJIlAgG5TNY1xnlrpZO
        nTYmJJjE1qexH9rrhNMAWExwqcRUEfQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-xotYzooYO7CY0IpPNRNGIQ-1; Thu, 26 Sep 2019 02:04:22 -0400
Received: by mail-ed1-f71.google.com with SMTP id p55so646440edc.5
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 23:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xm/q5Y5mHbNgamTmjVPn/PJWoyBCasibiXbF7mGYw00=;
        b=GKVrEY4I24Bp1tqXoW2E/Z93zCKOZ7JOC5ITKEw6ruWrhde3C+sjVKxIdHT8J1JnNz
         3CyxwDu9UWSp6RuXlVIr4L7/hoJhDFen+OJ5QyE0JcUYk+jdaUavqowIhrzCDdX41XEh
         he6fFdVhqhmoGGDiZYxtKC6JU2UU+hI5NTDyEg2goQVuDbjC4PYUHkYmR5V7oHVLn5fH
         2JhZMl+KkuKK3bMXS4vQQ1LW2JLY741l09Ff4KuwwqscQmYwtfbdYPWveydv469BD/5J
         wCBqXH8/ehXSvF25+0EIjp+zJMF0PAzJdTuut/SvZEj+zNUHgzAOcqEIOLfD7fH36H/s
         2qlg==
X-Gm-Message-State: APjAAAVAAEK1Drw+DFCZKrK7yRniIXzRZ882c7ybQrMuu66x548TM/vE
        Vbb5rhwmNFxvh2bXcUdKiW90vYnW68nH1b8zaPDvPFRYM55WR3DJhKTQDHdaXKt7kMqRvrBti1P
        V5gV0z0ml8iIt0nOVYRIak8aVVnY=
X-Received: by 2002:a17:906:3281:: with SMTP id 1mr1590442ejw.181.1569477861003;
        Wed, 25 Sep 2019 23:04:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+xB2DKVEmhESC9/09VfXNNROZ2xYtoeQLKK28UnLuQWJP5zyp4zPW039QZOVh0Cm7zgiLkQ==
X-Received: by 2002:a17:906:3281:: with SMTP id 1mr1590417ejw.181.1569477860735;
        Wed, 25 Sep 2019 23:04:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v22sm263162edm.89.2019.09.25.23.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 23:04:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3167418063D; Thu, 26 Sep 2019 08:04:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org> <87y2yc3ieb.fsf@toke.dk> <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org> <87mues35d4.fsf@toke.dk> <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 08:04:19 +0200
Message-ID: <87h84z3864.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: xotYzooYO7CY0IpPNRNGIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> Yes, please do! AFAICT, the main difference is that your version keeps
>> the airtime calculation itself in the driver, while mine passes up the
>> rate and lets mac80211 do the calculation of airtime. Other than that,
>> the differences are minor, no?
>> I'm not actually sure which approach is best; I suspect doing all the
>> accounting in mac80211 will help with integrating this into drivers that
>> use minstrel; we can just add a hook in that and be done with it.
>> Whereas if the driver has to do the accounting, we would need to add
>> that to each driver (mt76, iwl(?)).
>
> Yes, they are essentially doing the same thing. I kept the airtime
> estimation code in the ath10k just because it is already there. It is
> better to do that in mac80211, so it doesn't have to be duplicated for
> each driver and avoids the overhead of updating the estimated airtime
> from host driver to mac80211.

Right, makes sense.

>> But of course, doing things in mac80211 depends on stuffing even more
>> stuff into the already overloaded cb field; and I'm not actually
>> entirely sure what I've done with that will actually work. WDYT?
> Either way a field in skb cb is needed to record the estimated
> airtime. The  'tx_time_est' shares the space with the codel
> 'enque_time' looks fine to me, as their lifetime doesn't overlap.

The kbuild bot pointed out that the current implementation doesn't work
as it's supposed to on m68k (which is big-endian, I think?). I guess
it's because the compiler puts the u16 in the "wrong half" of the space
being used by the u32 it shares with, so it doesn't line up? If so, that
may mean we'll need another layer struct/union wrapping; unless someone
else has an idea for how to force the compiler to put the u16 in a union
at the "start" of the u32 regardless of endianness?

> There is another minor difference in the ChromiumOs version, which
> actually address the issue Yibo just asked:
>> Meanwhile, airtime_queued will also limit the situation that we only
>> have a station for transmission. Not sure if the peak throughput will be
>> impacted. I believe it may work fine with 11ac in chromiumos, how about
>> 11n and 11a?
>
> My version has two AQL limits, a smaller per station limit (4ms) and a
> larger per interface limit (24 ms). When the per interface limit has
> not been reached, stations are allowed to transmit up to 1/3 of the
> interface limits (8ms). This way it balance the needs to control
> latency when there are a lot of stations and to get good throughput
> benchmark numbers with a single client. In my test, I found increasing
> the AQL limit to beyond 8 ms doesn't helps peak throughput on 4x4
> ath10k chipset.
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/1734867/3/net/mac80211/tx.c#b3734

Yeah, I was wondering about that. Makes sense. Why 24ms, exactly?

>> Of course we'll also have to eventually integrate this with the other
>> series that Yibo recently re-posted (the virtual time scheduler). I
>> think that will be relatively straight forward, except I'm not sure your
>> atomic patches will work when we also have to update the rbtree. Any
>> thoughts on that series in general?
> I do like the virtual time scheduler patchset. It makes it easier to
> schedule an arbitrary tx queue and handles ath10k's firmware pulling
> mode better. I will give it a try.

Yup, that was the idea. Note that the current version doesn't have the
more granular locking that Felix put in for the RR-based scheduler.
Guess I need to re-spin; will see if I can't get to that soon.

>> Yup, makes sense. Looking at the version you linked to, though, it seems
>> you're calling ieee80211_sta_register_airtime() with the estimated value
>> as well? So are you double-accounting airtime, or are you adjusting for
>> the accurate values somewhere else I don't see in that series?
> It does not double count airtime, just both the airtime fairness
> scheduler and AQL use the estimate airtime. It is on an older tree and
> still doesn't have the patch that provides the fw airtime:
> https://patchwork.kernel.org/patch/10684689

Ah, I see. I assumed that the other call to sta_register_airtime() was
still there...

-Toke

