Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17CD2DD1CA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 14:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQNCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 08:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgLQNCf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 08:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608210069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3btdC8Ib+nc1YRjIp7Bv/qq+C1KrupIw6hpcJ5w7MKs=;
        b=e5WTZc/M/uwYAFgXlCrsYogJ9F9QtIM4lVCi8EuTxwjOqhVmV1aKQsNNEf/m92isATwTDa
        SplHQUhQvJjNIXk1HtgshpdiLdjijZM4AKG7b+jYbInHze0pr828t/hzvX10K5+3n8PwgA
        BrveuqNnc+TLVFbR2EugGb2G7/SN3Uc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-OxbfjTm5PaiLtA9XoDayFg-1; Thu, 17 Dec 2020 08:01:08 -0500
X-MC-Unique: OxbfjTm5PaiLtA9XoDayFg-1
Received: by mail-wm1-f70.google.com with SMTP id a205so1529601wme.9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 05:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3btdC8Ib+nc1YRjIp7Bv/qq+C1KrupIw6hpcJ5w7MKs=;
        b=GbZt/9OZt8yuJ4kSz5OQrFrWOuu5dzRb2Dl4FyOKxxmrYAiT80zUoj/QRhUi+y0DRe
         Uu+Ud5cy8AcEU+0kFrDbMcmICMDw300UHczVui1Hpl0scja2juunURlAf+Rfk5611GJJ
         mZwXo6IE2wQ8EefYkN3hPUmjqRZdr6XUL+ZDBHiYaXiOEvv1C7T1CD2rr+NWwJCQfTjZ
         JkpZjgljICKFkPwgGAizBE/A16WbPtmT5J2+M5h2hFN73t2yn1wa1ECQowPOBZhy9LHX
         +lPHWLEa9wSZzSiuQUX1xl3HWxCJS37YJQBQoMlvAkMn3tycyc1iB44XGjUpHR6owAOv
         0RLA==
X-Gm-Message-State: AOAM5322SE11PzdrtNWANnedgaiTqRu31NRv6JTU2gX1swiuhiJeyyoI
        RRQ/KDcew7hs98SYMdpHXLn9o85YvbqD2z/k3luYZVLE4KfnAZoBKd9d4R8y/ReKg6hF+HbNHc7
        St5H3f3Gdu4OFtxIAX43Reph450Q=
X-Received: by 2002:a5d:540f:: with SMTP id g15mr43756745wrv.397.1608210065407;
        Thu, 17 Dec 2020 05:01:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmxy4s1F7mQbMJr0K6WoCAqlpLJHcHz1wMQecQOUJ/UygWggAzxtKYDeRP7a2ZdZczRlYN6A==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr43756715wrv.397.1608210065175;
        Thu, 17 Dec 2020 05:01:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t13sm9215188wrs.26.2020.12.17.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 05:01:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3F6001802A7; Thu, 17 Dec 2020 14:01:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
In-Reply-To: <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 14:01:03 +0100
Message-ID: <871rfobn8w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-17 12:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> Depending on the source, a hardware calculated hash may not provide the
>>> same level of collision resistance.
>>=20
>> This seems like it would have performance implications?
>>=20
>> Also, this can potentially discard information from tunnels that
>> preserve the hash before encapsulation (we added support for this to
>> Wireguard which had some nice effects on queueing of encapsulated
>> traffic).
> If the hash was calculated in software using the flow dissector, it will
> be preserved, even if it went through a few virtual interfaces.
> The only hashes discarded are hardware generated ones.

Yeah, but I was thinking something like:

Packet comes in with HW hash -> gets encapsulated (preserving the hash)
-> gets to mac80211 which discards the HW hash. So now you're replacing
a (possibly bad-quality) HW hash with a software hash of the *outer*
encapsulation header...

-Toke

