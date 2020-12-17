Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FED2DD61E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgLQR1j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 12:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727723AbgLQR1i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 12:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608225971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xV3PQej53DHScga/o3zNGKC62Rcf9XvEpfu0uG8/7Jg=;
        b=gCxRd4r7+ssKi69t5WWcI4k+y4Pgca/Yg9uD+sQW5BcLStF2o6K2kjZZpx3mkE6TvJ9Xz2
        8XkxLZpzLf/3mqe2EsFMjN+JMQ0XE24QXx49uPlLe+SpRa3c41nWR1bts2xCbq2/YpgqFB
        s5kE3HvT90kW5aPC+tOkbDAKUysEkGY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-IO-T6wMvNxqAP1iYXgnA5Q-1; Thu, 17 Dec 2020 12:26:09 -0500
X-MC-Unique: IO-T6wMvNxqAP1iYXgnA5Q-1
Received: by mail-ed1-f69.google.com with SMTP id bo22so13666684edb.15
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 09:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xV3PQej53DHScga/o3zNGKC62Rcf9XvEpfu0uG8/7Jg=;
        b=WN427r/S3hvC92jHyhJoAK7HrFYX2yG8z2MQMLcnxjrh1iJ6IodXTHRS9DQwkt9f4w
         vd+W+oLON5kn6MHtTq6MYOi/EJpXBgUiohJd8cBR/wjmoIHCsZwvtGH8HsVCe50Szt3k
         H7kMKQNEiEYb8JfDWtZHsYQnQhPJhg7eTiWQUKNvvtMOR3upW20F9K2Q3mZLOyLgVdH0
         t6543yV1F9s3euKl6oby5ZR41hJ2xEwTCIgmys8U1XCSJ3Y3IJ+9anqHRbGqklALWRwy
         3oUlZVC/xLdSWnvvCFGNm4eB8NsiG4TFcNdcJ5ImVQqy+y57kgfb3lmaaB2UTUXU5pzx
         tb4w==
X-Gm-Message-State: AOAM533IFpm2iH6C6o2vTzSlT50US77HOSjYXhPDOVq5y1Fupz/VT1Wu
        zpuIk3pe9tv1HaW90bZNz/16OonytZySrF8ZSerBMOgJCFK5fB3rzlov46sq3zV4Zfd0qW+gUBX
        9eEnnxrRYwrN2GPr3gid03zy0Q3Y=
X-Received: by 2002:a17:906:da08:: with SMTP id fi8mr35878776ejb.517.1608225967685;
        Thu, 17 Dec 2020 09:26:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg/Q+lMnR/fzRbibM8mjQGX6QKyewG/fhi/t94valr2ARGVSHbpEPfaentW5RxprTSwDguLA==
X-Received: by 2002:a17:906:da08:: with SMTP id fi8mr35878746ejb.517.1608225967257;
        Thu, 17 Dec 2020 09:26:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h15sm23776051edz.95.2020.12.17.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 09:26:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C8701802A7; Thu, 17 Dec 2020 18:26:06 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
In-Reply-To: <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
 <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 18:26:06 +0100
Message-ID: <874kkk9wep.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-17 14:01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> On 2020-12-17 12:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>=20
>>>>> Depending on the source, a hardware calculated hash may not provide t=
he
>>>>> same level of collision resistance.
>>>>=20
>>>> This seems like it would have performance implications?
>>>>=20
>>>> Also, this can potentially discard information from tunnels that
>>>> preserve the hash before encapsulation (we added support for this to
>>>> Wireguard which had some nice effects on queueing of encapsulated
>>>> traffic).
>>> If the hash was calculated in software using the flow dissector, it will
>>> be preserved, even if it went through a few virtual interfaces.
>>> The only hashes discarded are hardware generated ones.
>>=20
>> Yeah, but I was thinking something like:
>>=20
>> Packet comes in with HW hash -> gets encapsulated (preserving the hash)
>> -> gets to mac80211 which discards the HW hash. So now you're replacing
>> a (possibly bad-quality) HW hash with a software hash of the *outer*
>> encapsulation header...
> If this becomes a problem, I think we should add a similar patch to
> wireguard, which already calls skb_get_hash before encapsulating.
> Other regular tunnels should already get a proper hash, since the flow
> dissector will take care of it.

But then we'd need to go around adding this to all the places that uses
the hash just to work around a particular piece of broken(ish) hardware.
And we're hard-coding a behaviour in mac80211 that means we'll *always*
recompute the hash, even for hardware that's not similarly broken.

> The reason I did this patch is because I have a patch to set the hw flow
> hash in the skb on mtk_eth_soc, which does help GRO, but leads to
> collisions on mac80211 fq.

So wouldn't the right thing to do here be to put a flag into the RX
device that makes the stack clear the hash after using it for GRO?

-Toke

