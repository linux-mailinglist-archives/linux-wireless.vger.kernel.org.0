Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0ED302D7F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 22:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbhAYVXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 16:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732629AbhAYVXC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 16:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611609694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rd28uFgkWfVAPZ9+IJSx0LzXiPxSrrojDnszzeejnYY=;
        b=iX98bxAn4JBalgj9KOTZdEbpjC/G4xyqtzDbrFDqw1dUMJ3B+UsVs6hk0A81k14F38OArE
        UFBlDEGDREG0tnV0tbCxCxaarMBkDnGRA9PwEZoi5lB6kY3ul5kKceBGVf2jhCkr9ZUiZf
        cFV03ZOxpNLO7wKClPjE2m4PbL7+Kkk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-MQfieMVNMKaFBDHMFR8jhA-1; Mon, 25 Jan 2021 16:21:33 -0500
X-MC-Unique: MQfieMVNMKaFBDHMFR8jhA-1
Received: by mail-ej1-f72.google.com with SMTP id ox17so4295391ejb.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 13:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rd28uFgkWfVAPZ9+IJSx0LzXiPxSrrojDnszzeejnYY=;
        b=WMxqDrn4JxeC5q7qTjgcUhHLK4ZUr8gzjfhs338Cb9JNMtt2e04LrYNehSVXhw/R8W
         xzuS+dA8KpZJgVJgSDKkb1kkrsqcC0ojTC1VmT3ONjIVw3b7zZtPMGEdsIb8TNYfZz4k
         Rig86UnJI5LXjUU7sO+TSVutnzQXH+ED8tf8madoBhEU0luNc4we1kKPfnq+FYSFOigg
         90DEiBxAqdklNlbCFtxmyorBh78g+B0dwx7Y3NySb0xbz2kbYVHCkx7iDSfmtwEOceNC
         WAufkVOtEABhdEkbpsa+dQksyQpUnoLvYQs3PhvdLTiH9t8pMbdSr3fHy7fb+SemLAcI
         BThQ==
X-Gm-Message-State: AOAM532PGiqKzFVfpULAgY5Mq75GOLy+fGO1TDCw1bHZ6SVN3f7A7bHV
        6kuT2heq4ukKA+KylRdZoNuWpQA7601KaJAMdm5c5SOssXMnUiQ/cRb1DyPFdYZ8oIdOyduS2I7
        aomKb25ts/kmrAAXHckeX+7g2Z6I=
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr2061669edq.72.1611609691915;
        Mon, 25 Jan 2021 13:21:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8rAa592wt8fi1IxBQe8qCYTxeccx00WgqFkS2U7n7qerc91eFx7EPPacSnT5AvylOAxaedA==
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr2061663edq.72.1611609691765;
        Mon, 25 Jan 2021 13:21:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ke7sm8857587ejc.7.2021.01.25.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:21:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AA6EF18033A; Mon, 25 Jan 2021 22:21:30 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 4/6] mac80211: minstrel_ht: significantly redesign the
 rate probing strategy
In-Reply-To: <3ac94bcf-4c76-9c1e-c903-0810d2067b3a@nbd.name>
References: <20210124122812.49929-1-nbd@nbd.name>
 <20210124122812.49929-4-nbd@nbd.name> <87o8hdmdqs.fsf@toke.dk>
 <3ac94bcf-4c76-9c1e-c903-0810d2067b3a@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Jan 2021 22:21:30 +0100
Message-ID: <87eei8d86d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2021-01-25 12:56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> The biggest flaw in current minstrel_ht is the fact that it needs way t=
oo
>>> many probing packets to be able to quickly find the best rate.
>>> Depending on the wifi hardware and operating mode, this can significant=
ly
>>> reduce throughput when not operating at the highest available data rate.
>>>
>>> In order to be able to significantly reduce the amount of rate sampling,
>>> we need a much smarter selection of probing rates.
>>>
>>> The new approach introduced by this patch maintains a limited set of
>>> available rates to be tested during a statistics window.
>>>
>>> They are split into distinct categories:
>>> - MINSTREL_SAMPLE_TYPE_INC - incremental rate upgrade:
>>>   Pick the next rate group and find the first rate that is faster than
>>>   the current max. throughput rate
>>> - MINSTREL_SAMPLE_TYPE_JUMP - random testing of higher rates:
>>>   Pick a random rate from the next group that is faster than the current
>>>   max throughput rate. This allows faster adaptation when the link chan=
ges
>>>   significantly
>>> - MINSTREL_SAMPLE_TYPE_SLOW - test a rate between max_prob, max_tp2 and
>>>   max_tp in order to reduce the gap between them
>>>
>>> In order to prioritize sampling, every 6 attempts are split into 3x INC,
>>> 2x JUMP, 1x SLOW.
>>>
>>> Available rates are checked and refilled on every stats window update.
>>=20
>> Very cool!
>>=20
>>> With this approach, we finally get a very small delta in throughput when
>>> comparing setting the optimal data rate as a fixed rate vs normal rate
>>> control operation.
>>=20
>> Can you quantify this "very small delta"? Would love to see some
>> benchmark data :)
> Based on a quick test it seems to be around 5% (sometimes less) at VHT80
> MCS6 nss=3D4 with ~350 mbit/s TCP throughput. I guess I might be able to
> bring that down even further, once I optimize it some more.

Cool! And pre-patch?

-Toke

