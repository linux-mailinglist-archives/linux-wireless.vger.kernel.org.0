Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05B134108A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 23:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCRWzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 18:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232503AbhCRWzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 18:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616108110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7GywKLfURSd+q8sr3UF3ZwITBmk/iv8lpF0KGMPLLY=;
        b=FyLmQAHZze5Zcncu3ENSijFI/sRuC1RlEgIEh+UE9JVnCiPgot7czSKjoaNvb7zyoA64Yc
        6V6TUFy7OUj8kcLs1E+ehQUZYlIY+TLjGNswzsdUyn8N7kHjp5gPAyu7KWsgIvbX6uSJF8
        OEQhuXT2rRtFFG6LHhnHWhvtBsxkVCQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-aUGUPoFcNlO8n7q3sDyxOg-1; Thu, 18 Mar 2021 18:55:08 -0400
X-MC-Unique: aUGUPoFcNlO8n7q3sDyxOg-1
Received: by mail-ed1-f72.google.com with SMTP id q25so7246787eds.16
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 15:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=x7GywKLfURSd+q8sr3UF3ZwITBmk/iv8lpF0KGMPLLY=;
        b=i31zncbsk9e/HA+uEtgDgNZOYllbm1Tq9USFf1KeVGQr5q9WxhLBk3PvZ7AYubHWmy
         6mJrmzi0NDC9BkKHQmOtbg3PsMO+xeZBWAe3qYEDDXrZba14FzK/akfuiIpOvVSFPkuh
         tfPJWifb0jnbwfnjA07qqsw08ttj0c7Ll7qJBmon0mgQ2hUbg+HpwLWIlBqCFRwwB7pD
         64btrJwkR4rBfhhbIlKuVpvR0Skm82khtJyeDiLj10g3mqQp3yONyfZd08ODa0dV65/i
         EjvHsiAGRF/8sFgWEvNx0CNjd17Plvs6bgAubk7E5wAwshZDnikUI3DsMSzfxPTp/mbQ
         d/pQ==
X-Gm-Message-State: AOAM5314UzS9Ri6KmJlGtrRcK/Fi1BKp+CLwkeytpVpokJCH8N5ymQAY
        O7CEXpC4ykMRQlvZwIZz4aFTIaZR+FhfBR2cfiKCYxvlBT/PTCTmjJw7ipMydWbMWEQSudDDjQc
        pEx8q8O+yj37pH0wSlHim5BJMZ1w=
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr971332ejy.370.1616108106966;
        Thu, 18 Mar 2021 15:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq6xEhLrhVgTUYYs40P3QPdpXsxEltSN1rRSsoGupVNSEmgJv3//DIKjBDZ0ngO6vxOFJRzA==
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr971322ejy.370.1616108106801;
        Thu, 18 Mar 2021 15:55:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u24sm2615175ejr.34.2021.03.18.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:55:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C53CD181F54; Thu, 18 Mar 2021 23:55:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     make-wifi-fast@lists.bufferbloat.net,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH mac80211-next v6] mac80211: Switch to a virtual
 time-based airtime scheduler
In-Reply-To: <a6ca1ab9-29a0-18fe-8097-20abc5f253bd@nbd.name>
References: <20210318213142.138707-1-toke@redhat.com>
 <a6ca1ab9-29a0-18fe-8097-20abc5f253bd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Mar 2021 23:55:05 +0100
Message-ID: <87eegcax86.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Toke,
>
> Thanks for continuing to work on this! I just did a quick reading of the
> code and haven't tested this yet - I might have some more comments in
> the next few days.

Awesome! You're welcome, and thanks for taking a look :)

> On 2021-03-18 22:31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This switches the airtime scheduler in mac80211 to use a virtual time-ba=
sed
>> scheduler instead of the round-robin scheduler used before. This has a
>> couple of advantages:
>>=20
>> - No need to sync up the round-robin scheduler in firmware/hardware with
>>   the round-robin airtime scheduler.
>>=20
>> - If several stations are eligible for transmission we can schedule both=
 of
>>   them; no need to hard-block the scheduling rotation until the head of =
the
>>   queue has used up its quantum.
>>=20
>> - The check of whether a station is eligible for transmission becomes
>>   simpler (in ieee80211_txq_may_transmit()).
>>=20
>> The drawback is that scheduling becomes slightly more expensive, as we n=
eed
>> to maintain an rbtree of TXQs sorted by virtual time. This means that
>> ieee80211_register_airtime() becomes O(logN) in the number of currently
>> scheduled TXQs because it can change the order of the scheduled stations.
>> We mitigate this overhead by only resorting when a station changes posit=
ion
>> in the tree, and hopefully N rarely grows too big (it's only TXQs curren=
tly
>> backlogged, not all associated stations), so it shouldn't be too big of =
an
>> issue.
>>=20
>> To prevent divisions in the fast path, we maintain both station sums and
>> pre-computed reciprocals of the sums. This turns the fast-path operation
>> into a multiplication, with divisions only happening as the number of
>> active stations change (to re-compute the current sum of all active stat=
ion
>> weights). To prevent this re-computation of the reciprocal from happening
>> too frequently, we use a time-based notion of station activity, instead =
of
>> updating the weight every time a station gets scheduled or de-scheduled.=
 As
>> queues can oscillate between empty and occupied quite frequently, this c=
an
>> significantly cut down on the number of re-computations. It also has the
>> added benefit of making the station airtime calculation independent on
>> whether the queue happened to have drained at the time an airtime value =
was
>> accounted.
>>=20
>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> Respinning this has taken way too long, but assuming anyone actually rem=
embers
>> the previous version from a bit over a year ago, here's the changelog:
>>=20
>> Changes since v5:
>>   Rebase on latest mac80211-next.
>>=20
>>   Fix issue with scheduling hanging because the schedule position was not
>>   cleared when starting a new scheduling round.
>>=20
>>   Switch the reciprocal calculation to use u32 (split 19/13) for per-sta=
tion
>>   weights and a u64 only for the weight sum (to cut down on the number o=
f 64-bit
>>   operations performed)
>>=20
>>   Introduce the notion of time-based station activity when calculating w=
eight
>>   sums. This also gets rid of the need for a "grace time" when catching =
up
>>   stations, since we now have a direct notion of when a station has been
>>   inactive for a while.
> Not sure if I'm misunderstanding the code, but this does not seem enough
> to me. From what I can see, you consider a station active if it has been
> scheduled in the last 100ms. Let's say we keep sending a single small
> packet to a particular sta every 90ms (thus keeping it active) for a
> long period of time and then suddenly start a really huge transfer.
> What keeps it from then taking an unreasonably large share of the
> airtime for as long as it takes for the virtual time to catch up?
>
> Am I missing something or should we maybe use the new notion of
> time-based activity *and* do a grace time catch up?

Hmm, yeah, I guess you're right? I haven't seen this in practice, but I
haven't been looking for it either. And I suppose someone who set out to
trigger this would be able to. So adding back the grace time (but maybe
with a longer interval?) would probably be best.

I'll wait for your other comments before respinning, though...

-Toke

