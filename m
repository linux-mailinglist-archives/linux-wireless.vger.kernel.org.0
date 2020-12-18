Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0233C2DE2E3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLRMmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 07:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgLRMmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 07:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608295265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDDeanCkz9wakKFLetbN+NCCDMaieNN2AFP/Wz9UXDM=;
        b=hQWHJxSBuF913rfGBk6Fh5dyyN3zXTju/QO8h4HOGmNa6vNKZO02HYRfNZVyrPXkukUTac
        z227qYRLrsYrA3Jx668XjxIWryJCaI/0+YyAkS/Ji2nMLTl+k+4jBXkR/NwWlMHTRmfzb4
        h9aNn66d6qeW5f1Y7svuZLTRbbNBUL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Fn5a0OCtOYyuo-1_eRXKlQ-1; Fri, 18 Dec 2020 07:41:04 -0500
X-MC-Unique: Fn5a0OCtOYyuo-1_eRXKlQ-1
Received: by mail-wr1-f71.google.com with SMTP id r11so1110552wrs.23
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 04:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nDDeanCkz9wakKFLetbN+NCCDMaieNN2AFP/Wz9UXDM=;
        b=KUc8CZBFPNiKwf9upNIdt47vmrIquj11UGmUgCjdYGKq0s1lWj7p0MiA/bm4aNzpNr
         KlOt2Pjz/y0mhNuVFxhCTnrxvO4R5uKaDK37kn7gLEd5zoIGMjFmopuQihvdxbJ+Zo5F
         n2W8a4mVT9NREzXo80rNrg3QRbb6nIdxBAwr4JDBhzwmsGqgNyKYwuYzawmfjLE1T6WM
         uZJhthr7nkz0k4x4w/ZDhkay3yyQ/OOB3XUyOqWJXESEykJxvpz8tn6Q76/cI1ueRrLl
         gzdUqjhZVdbI+Zz2uJsix5xTcuiRqSsM969RBNCoJeqOzgIhY/R6kxwfBalCUJJyix35
         OtaQ==
X-Gm-Message-State: AOAM530Fz/ERDxnHQ/s7owjr6lDJmJ62yV8QL0aMXUxsCHPFbDXj4nnl
        c3DkCAHcbUHTXAYeMuSWvqAfohtgXP8V0FHzjmU09Ndn4oIr+0DGFWK65YPbZrGAqkizxOlZ+3a
        DFnxS0nBUMwk8vCS3JImDyi/tnVY=
X-Received: by 2002:a5d:6944:: with SMTP id r4mr4296571wrw.134.1608295262089;
        Fri, 18 Dec 2020 04:41:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPavV8hetLrvTtrmYAsGO8bkuoWbOBi93Ltcc/J/gMSO3Aa0zV2ldQXwF08xttOOy1TYSP8Q==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr4296562wrw.134.1608295261883;
        Fri, 18 Dec 2020 04:41:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v4sm9932344wrw.42.2020.12.18.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:41:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B63571802A9; Fri, 18 Dec 2020 13:41:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
In-Reply-To: <eb5ffa8e-0ebc-381f-12c5-02b96bcea64e@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
 <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name> <874kkk9wep.fsf@toke.dk>
 <eb5ffa8e-0ebc-381f-12c5-02b96bcea64e@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Dec 2020 13:41:00 +0100
Message-ID: <87h7ojb82r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-17 18:26, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>> If this becomes a problem, I think we should add a similar patch to
>>> wireguard, which already calls skb_get_hash before encapsulating.
>>> Other regular tunnels should already get a proper hash, since the flow
>>> dissector will take care of it.
>>=20
>> But then we'd need to go around adding this to all the places that uses
>> the hash just to work around a particular piece of broken(ish) hardware.
>> And we're hard-coding a behaviour in mac80211 that means we'll *always*
>> recompute the hash, even for hardware that's not similarly broken.
>>=20
>>> The reason I did this patch is because I have a patch to set the hw flow
>>> hash in the skb on mtk_eth_soc, which does help GRO, but leads to
>>> collisions on mac80211 fq.
>>=20
>> So wouldn't the right thing to do here be to put a flag into the RX
>> device that makes the stack clear the hash after using it for GRO?
> I don't think the hardware is broken, I think fq is simply making
> assumptions about the hash that aren't met by the hw.
>
> The documentation in include/linux/skbuff.h mentions these requirements
> for the skb hash:
>  * 1) Two packets in different flows have different hash values
>  * 2) Two packets in the same flow should have the same hash value
>
> FWIW, I think the 'should' from 2) probably belongs to 1), otherwise it
> makes no sense. Two packets of the flow must return the same hash,
> otherwise the hash is broken. I'm assuming this is a typo.

There's some text further down indicating this is deliberate:

 * A driver may indicate a hash level which is less specific than the
 * actual layer the hash was computed on. For instance, a hash computed
 * at L4 may be considered an L3 hash. This should only be done if the
 * driver can't unambiguously determine that the HW computed the hash at
 * the higher layer. Note that the "should" in the second property above
 * permits this.

So the way I'm reading that whole section, either the intent is that
both properties should be fulfilled, or that the first one (being
collision-free) is more important...

> In addition to those properties, fq needs the hash to be
> cryptographically secure, so that it can use reciprocal_scale to sort
> flows into buckets without allowing an attacker to craft collisions.
> That's also the reason why it used to use skb_get_hash_perturb with a
> random perturbation until we got software hashes based on siphash.
>
> I think it's safe to assume that most hardware out there will not
> provide collision resistant hashes, so in my opinion fq cannot rely on a
> hardware hash. We don't need to go around and change all places that use
> the hash, just those that assume a collision resistant one.

I did a quick grep-based survey of uses of skb_get_hash() outside
drivers - this is what I found (with my interpretations of what they're
used for):

net/core/dev.c           : skb_tx_hash() - selecting TX queue w/reciprocal =
scale
net/core/dev.c           : RX flow steering, flow limiting
net/core/dev.c           : GRO
net/core/filter.c        : BPF helper
include/net/ip_tunnels.h : flowi4_multipath_hash - so multipath selection?
net/ipv{4,6}/route.c     : multipath hashing (if l4)
net/ipv6/seg6_iptunnel   : building flow labels
net/mac80211/tx.c        : FQ
net/mptcp/syncookies     : storing cookies (XOR w/net_hash_mix())
net/netfilter/nft_hash.c : symhash input (seems to be load balancing)
net/openvswitch          : flow hashing and actions
net/packet/af_packet.c   : PACKET_FANOUT_HASH
net/sched/sch_*.c        : flow hashing for queueing

Apart from GRO it's not obvious to me that a trivially
attacker-controlled hash is safe in any of those uses?

-Toke

