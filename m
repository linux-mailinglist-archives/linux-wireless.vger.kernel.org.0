Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F226B2DD916
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 20:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgLQTIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 14:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgLQTIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 14:08:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B05C061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ilhWMgwi8RDi79jZRibgCVlyWoi9TCxB7IGa52NNEaw=; b=AQcZjhjEKkQPs21FN3D7Iw1wei
        FGOBIQxdINgtPXHpHyls2yA4Kn2QnofqXqCUGQe+1GGpOr8wg5oKnd8J0wrx2vhxh1oPZHD6rklUc
        usDdJfw3WIqoQaGfD7aF8wqcNv79PrZekJQkR3rir1LSpIH2wdY42JRSDoD0qQgGq8mI=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpycb-0008V4-Hb; Thu, 17 Dec 2020 20:07:29 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
 <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name> <874kkk9wep.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
Message-ID: <eb5ffa8e-0ebc-381f-12c5-02b96bcea64e@nbd.name>
Date:   Thu, 17 Dec 2020 20:07:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <874kkk9wep.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-12-17 18:26, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
>> If this becomes a problem, I think we should add a similar patch to
>> wireguard, which already calls skb_get_hash before encapsulating.
>> Other regular tunnels should already get a proper hash, since the flow
>> dissector will take care of it.
> 
> But then we'd need to go around adding this to all the places that uses
> the hash just to work around a particular piece of broken(ish) hardware.
> And we're hard-coding a behaviour in mac80211 that means we'll *always*
> recompute the hash, even for hardware that's not similarly broken.
> 
>> The reason I did this patch is because I have a patch to set the hw flow
>> hash in the skb on mtk_eth_soc, which does help GRO, but leads to
>> collisions on mac80211 fq.
> 
> So wouldn't the right thing to do here be to put a flag into the RX
> device that makes the stack clear the hash after using it for GRO?
I don't think the hardware is broken, I think fq is simply making
assumptions about the hash that aren't met by the hw.

The documentation in include/linux/skbuff.h mentions these requirements
for the skb hash:
 * 1) Two packets in different flows have different hash values
 * 2) Two packets in the same flow should have the same hash value

FWIW, I think the 'should' from 2) probably belongs to 1), otherwise it
makes no sense. Two packets of the flow must return the same hash,
otherwise the hash is broken. I'm assuming this is a typo.

In addition to those properties, fq needs the hash to be
cryptographically secure, so that it can use reciprocal_scale to sort
flows into buckets without allowing an attacker to craft collisions.
That's also the reason why it used to use skb_get_hash_perturb with a
random perturbation until we got software hashes based on siphash.

I think it's safe to assume that most hardware out there will not
provide collision resistant hashes, so in my opinion fq cannot rely on a
hardware hash. We don't need to go around and change all places that use
the hash, just those that assume a collision resistant one.

- Felix
