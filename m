Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072C82DE6F0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLRPu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 10:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgLRPu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 10:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608306571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdrAHEfIJSq5BfsquB4o+vTwZH5hbPjbo+jbTjFSMzY=;
        b=Ful6kHaQ24q1FCyEHglKzzlkPfMXeHXam3V1P18UeueuAkWvTQ8NWNRYofNvTlyIWxb5Tx
        oEmYBEcnwDiMy3r7GIisvysyz7VSssYRpLk/83QLyK3KPvA6YAdNO667KRHu4p3tElY+V8
        Ko5aRQ4XJ6CxwHISGnSu6aIw0wYLsqY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-dLwtmmgPOU6K3K_djGQLcw-1; Fri, 18 Dec 2020 10:49:29 -0500
X-MC-Unique: dLwtmmgPOU6K3K_djGQLcw-1
Received: by mail-wr1-f70.google.com with SMTP id i4so1370084wrm.21
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 07:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LdrAHEfIJSq5BfsquB4o+vTwZH5hbPjbo+jbTjFSMzY=;
        b=FUcMzkYL6ywsGYKDuh3c4kt57y8EMy4xlVlYNO/6pVJale1lpE+GVZhKk44SDNc6s7
         q9I5AGOAkQUvp+emkO32byzR+krGUEWWu/cZKGtgFeWMGsiOapkGWfB4tnSc+rF+dyID
         Ab+Cx3oty9LqEROxFz7sv7HEs5p2RL7P+oXQMD1DxLNWnglo8O5U5CJBjGHw4Jt41hRs
         zjTwYKklC2KYRFwO9UNgW70x3aModqk9X15qXW1NWr17N43Qu7HZ+qncjsdYlj7VV/8I
         k/JYa6NaT6pk3d7bxcs7Y8olCv2aO+cn9EEqaxD0O4RVSUdXCjTWX0FOzzoiEpKQZ/Iy
         SSmw==
X-Gm-Message-State: AOAM533fjz95CyeugfYLdBXp0TMubSLNZQ4OdIaitI3zdyAwTYvMcv2V
        aD65pXd/hnEZsFQQyz+jQlQKfz6lFApxZ0hyz4rF8EdnN1KEFD7DnURvCO5W6h7aONbp2X3cCUO
        tFiAPE7llvfTAWJ5+agAzgjpX/xs=
X-Received: by 2002:adf:ca0c:: with SMTP id o12mr5291282wrh.154.1608306568205;
        Fri, 18 Dec 2020 07:49:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgoFU8XlHJhneA4B5eEb4+Z4G9ha5HPwiyLUVwQQIB/P69JWeKoFADBb7vw7ECmrsJXfV8dQ==
X-Received: by 2002:adf:ca0c:: with SMTP id o12mr5291264wrh.154.1608306567981;
        Fri, 18 Dec 2020 07:49:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r13sm14211771wrs.6.2020.12.18.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 07:49:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D77061802A9; Fri, 18 Dec 2020 16:49:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
In-Reply-To: <2a7a3049-61c1-2932-cf43-425bb15af9e7@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
 <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name> <874kkk9wep.fsf@toke.dk>
 <eb5ffa8e-0ebc-381f-12c5-02b96bcea64e@nbd.name> <87h7ojb82r.fsf@toke.dk>
 <2a7a3049-61c1-2932-cf43-425bb15af9e7@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Dec 2020 16:49:26 +0100
Message-ID: <87zh2b9ks9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-18 13:41, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> On 2020-12-17 18:26, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Felix Fietkau <nbd@nbd.name> writes:
>>>>> If this becomes a problem, I think we should add a similar patch to
>>>>> wireguard, which already calls skb_get_hash before encapsulating.
>>>>> Other regular tunnels should already get a proper hash, since the flow
>>>>> dissector will take care of it.
>>>>=20
>>>> But then we'd need to go around adding this to all the places that uses
>>>> the hash just to work around a particular piece of broken(ish) hardwar=
e.
>>>> And we're hard-coding a behaviour in mac80211 that means we'll *always*
>>>> recompute the hash, even for hardware that's not similarly broken.
>>>>=20
>>>>> The reason I did this patch is because I have a patch to set the hw f=
low
>>>>> hash in the skb on mtk_eth_soc, which does help GRO, but leads to
>>>>> collisions on mac80211 fq.
>>>>=20
>>>> So wouldn't the right thing to do here be to put a flag into the RX
>>>> device that makes the stack clear the hash after using it for GRO?
>>> I don't think the hardware is broken, I think fq is simply making
>>> assumptions about the hash that aren't met by the hw.
>>>
>>> The documentation in include/linux/skbuff.h mentions these requirements
>>> for the skb hash:
>>>  * 1) Two packets in different flows have different hash values
>>>  * 2) Two packets in the same flow should have the same hash value
>>>
>>> FWIW, I think the 'should' from 2) probably belongs to 1), otherwise it
>>> makes no sense. Two packets of the flow must return the same hash,
>>> otherwise the hash is broken. I'm assuming this is a typo.
>>=20
>> There's some text further down indicating this is deliberate:
>>=20
>>  * A driver may indicate a hash level which is less specific than the
>>  * actual layer the hash was computed on. For instance, a hash computed
>>  * at L4 may be considered an L3 hash. This should only be done if the
>>  * driver can't unambiguously determine that the HW computed the hash at
>>  * the higher layer. Note that the "should" in the second property above
>>  * permits this.
>>=20
>> So the way I'm reading that whole section, either the intent is that
>> both properties should be fulfilled, or that the first one (being
>> collision-free) is more important...
> A hash - by definition - cannot be collision free.
> But that's beside the point. On my hw, the hash itself seems collision
> free for the flows that I'm pushing, but the result of the
> reciprocal_scale isn't.
> I took another look and figured out the reason for that:
> The hw delivers a 14 bit hash. reciprocal_scale assumes that the values
> are distributed across the full 32 bit range. So in this case, the lower
> bits are pretty much ignored and the result of the reciprocal_scale is 0
> or close to 0, which is what's causing the collisions in fq.

Ah, right, that makes sense!

> Maybe the assumption that the hash should be distributed across the full
> 32 bit range should be documented somewhere :)

Yeah, I agree. Maybe just updating that comment in skbuff.h? Do you want
to fold such an update into your series? Otherwise I can send a patch
once net-next opens...

>>> In addition to those properties, fq needs the hash to be
>>> cryptographically secure, so that it can use reciprocal_scale to sort
>>> flows into buckets without allowing an attacker to craft collisions.
>>> That's also the reason why it used to use skb_get_hash_perturb with a
>>> random perturbation until we got software hashes based on siphash.
>>>
>>> I think it's safe to assume that most hardware out there will not
>>> provide collision resistant hashes, so in my opinion fq cannot rely on a
>>> hardware hash. We don't need to go around and change all places that use
>>> the hash, just those that assume a collision resistant one.
>>=20
>> I did a quick grep-based survey of uses of skb_get_hash() outside
>> drivers - this is what I found (with my interpretations of what they're
>> used for):
>>=20
>> net/core/dev.c           : skb_tx_hash() - selecting TX queue w/reciproc=
al scale
>> net/core/dev.c           : RX flow steering, flow limiting
>> net/core/dev.c           : GRO
>> net/core/filter.c        : BPF helper
>> include/net/ip_tunnels.h : flowi4_multipath_hash - so multipath selectio=
n?
>> net/ipv{4,6}/route.c     : multipath hashing (if l4)
>> net/ipv6/seg6_iptunnel   : building flow labels
>> net/mac80211/tx.c        : FQ
>> net/mptcp/syncookies     : storing cookies (XOR w/net_hash_mix())
>> net/netfilter/nft_hash.c : symhash input (seems to be load balancing)
>> net/openvswitch          : flow hashing and actions
>> net/packet/af_packet.c   : PACKET_FANOUT_HASH
>> net/sched/sch_*.c        : flow hashing for queueing
>>=20
>> Apart from GRO it's not obvious to me that a trivially
>> attacker-controlled hash is safe in any of those uses?
> I looked at some of those uses you mentioned here.
> Most of them fit into 2 categories:
> 1. Sort into power-of-2 buckets and use hash & (size-1), effectively
> using the lower bits only.
> 2. Use reciprocal_scale - effectively using the higher bits only.
> For the hash that my hw is reporting, type 1 is working and type 2 is
> broken.
>
> So it seems to me that the solution would involve running a simple hash
> on the 14 bit values to get the bits distributed to the full 32 bit
> range without adding too much bias.
> I will do this in the driver and drop this patch.

Yes, this seems like a reasonable solution; great!

> Thanks for looking into this,

You're welcome :)

-Toke

