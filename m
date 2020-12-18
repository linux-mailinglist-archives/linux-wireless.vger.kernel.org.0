Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837AE2DE362
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLRNld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 08:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgLRNlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 08:41:32 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B7C0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F/gcl9+d4KFAF8PJcye+cVqMkI3EJoA8uoxN6eZmufw=; b=p3DRRTKuGl/3nlu3IQxKkjM3oo
        j4Fk4rGOxCH0Spa1csEk3aFSddpjBHOV9SLq5bBcXI5bMAm/OmW7rPs9cNXjcm7is9g/hswaeVA36
        jfAC/7ThvThP2rujLtjB7QG2dQaDMjPe4d3cLmoSV9TStrNuqH3M8g+ZsnjOhFIXcHNI=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kqFzz-0007Hn-Ow; Fri, 18 Dec 2020 14:40:47 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
 <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name> <874kkk9wep.fsf@toke.dk>
 <eb5ffa8e-0ebc-381f-12c5-02b96bcea64e@nbd.name> <87h7ojb82r.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
Message-ID: <2a7a3049-61c1-2932-cf43-425bb15af9e7@nbd.name>
Date:   Fri, 18 Dec 2020 14:40:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87h7ojb82r.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-18 13:41, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2020-12-17 18:26, Toke Høiland-Jørgensen wrote:
>>> Felix Fietkau <nbd@nbd.name> writes:
>>>> If this becomes a problem, I think we should add a similar patch to
>>>> wireguard, which already calls skb_get_hash before encapsulating.
>>>> Other regular tunnels should already get a proper hash, since the flow
>>>> dissector will take care of it.
>>> 
>>> But then we'd need to go around adding this to all the places that uses
>>> the hash just to work around a particular piece of broken(ish) hardware.
>>> And we're hard-coding a behaviour in mac80211 that means we'll *always*
>>> recompute the hash, even for hardware that's not similarly broken.
>>> 
>>>> The reason I did this patch is because I have a patch to set the hw flow
>>>> hash in the skb on mtk_eth_soc, which does help GRO, but leads to
>>>> collisions on mac80211 fq.
>>> 
>>> So wouldn't the right thing to do here be to put a flag into the RX
>>> device that makes the stack clear the hash after using it for GRO?
>> I don't think the hardware is broken, I think fq is simply making
>> assumptions about the hash that aren't met by the hw.
>>
>> The documentation in include/linux/skbuff.h mentions these requirements
>> for the skb hash:
>>  * 1) Two packets in different flows have different hash values
>>  * 2) Two packets in the same flow should have the same hash value
>>
>> FWIW, I think the 'should' from 2) probably belongs to 1), otherwise it
>> makes no sense. Two packets of the flow must return the same hash,
>> otherwise the hash is broken. I'm assuming this is a typo.
> 
> There's some text further down indicating this is deliberate:
> 
>  * A driver may indicate a hash level which is less specific than the
>  * actual layer the hash was computed on. For instance, a hash computed
>  * at L4 may be considered an L3 hash. This should only be done if the
>  * driver can't unambiguously determine that the HW computed the hash at
>  * the higher layer. Note that the "should" in the second property above
>  * permits this.
> 
> So the way I'm reading that whole section, either the intent is that
> both properties should be fulfilled, or that the first one (being
> collision-free) is more important...
A hash - by definition - cannot be collision free.
But that's beside the point. On my hw, the hash itself seems collision
free for the flows that I'm pushing, but the result of the
reciprocal_scale isn't.
I took another look and figured out the reason for that:
The hw delivers a 14 bit hash. reciprocal_scale assumes that the values
are distributed across the full 32 bit range. So in this case, the lower
bits are pretty much ignored and the result of the reciprocal_scale is 0
or close to 0, which is what's causing the collisions in fq.

Maybe the assumption that the hash should be distributed across the full
32 bit range should be documented somewhere :)

>> In addition to those properties, fq needs the hash to be
>> cryptographically secure, so that it can use reciprocal_scale to sort
>> flows into buckets without allowing an attacker to craft collisions.
>> That's also the reason why it used to use skb_get_hash_perturb with a
>> random perturbation until we got software hashes based on siphash.
>>
>> I think it's safe to assume that most hardware out there will not
>> provide collision resistant hashes, so in my opinion fq cannot rely on a
>> hardware hash. We don't need to go around and change all places that use
>> the hash, just those that assume a collision resistant one.
> 
> I did a quick grep-based survey of uses of skb_get_hash() outside
> drivers - this is what I found (with my interpretations of what they're
> used for):
> 
> net/core/dev.c           : skb_tx_hash() - selecting TX queue w/reciprocal scale
> net/core/dev.c           : RX flow steering, flow limiting
> net/core/dev.c           : GRO
> net/core/filter.c        : BPF helper
> include/net/ip_tunnels.h : flowi4_multipath_hash - so multipath selection?
> net/ipv{4,6}/route.c     : multipath hashing (if l4)
> net/ipv6/seg6_iptunnel   : building flow labels
> net/mac80211/tx.c        : FQ
> net/mptcp/syncookies     : storing cookies (XOR w/net_hash_mix())
> net/netfilter/nft_hash.c : symhash input (seems to be load balancing)
> net/openvswitch          : flow hashing and actions
> net/packet/af_packet.c   : PACKET_FANOUT_HASH
> net/sched/sch_*.c        : flow hashing for queueing
> 
> Apart from GRO it's not obvious to me that a trivially
> attacker-controlled hash is safe in any of those uses?
I looked at some of those uses you mentioned here.
Most of them fit into 2 categories:
1. Sort into power-of-2 buckets and use hash & (size-1), effectively
using the lower bits only.
2. Use reciprocal_scale - effectively using the higher bits only.
For the hash that my hw is reporting, type 1 is working and type 2 is
broken.

So it seems to me that the solution would involve running a simple hash
on the 14 bit values to get the bits distributed to the full 32 bit
range without adding too much bias.
I will do this in the driver and drop this patch.

Thanks for looking into this,

- Felix
