Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73AC2DD48C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQPtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 10:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQPtQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 10:49:16 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34FC0617A7
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kLRlpJ2TWLDPPAbeHaEFlx9t97OCc2bBAhpKSZjJPI0=; b=EfekbltB2eoVvC+9T8yVXdtZt1
        STQVDTg8G4oa+U1+cfZJPnItVDlkSKjXiSXuV1kVoyzSxHxGodDxj1VQ/f1kosFJ4FbCQszRtvs3N
        QE8n9W482xtl4m5jUC0M08CkGMwbHXZA3IlkSDA1CtQsJf2HbI7g+GiKGoSk/K8Z5/y0=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpvVo-0003um-Sd; Thu, 17 Dec 2020 16:48:16 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
 <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name> <871rfobn8w.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
Message-ID: <07ad2533-b477-abf1-5176-0521ca9ddf82@nbd.name>
Date:   Thu, 17 Dec 2020 16:48:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <871rfobn8w.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-12-17 14:01, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2020-12-17 12:54, Toke Høiland-Jørgensen wrote:
>>> Felix Fietkau <nbd@nbd.name> writes:
>>> 
>>>> Depending on the source, a hardware calculated hash may not provide the
>>>> same level of collision resistance.
>>> 
>>> This seems like it would have performance implications?
>>> 
>>> Also, this can potentially discard information from tunnels that
>>> preserve the hash before encapsulation (we added support for this to
>>> Wireguard which had some nice effects on queueing of encapsulated
>>> traffic).
>> If the hash was calculated in software using the flow dissector, it will
>> be preserved, even if it went through a few virtual interfaces.
>> The only hashes discarded are hardware generated ones.
> 
> Yeah, but I was thinking something like:
> 
> Packet comes in with HW hash -> gets encapsulated (preserving the hash)
> -> gets to mac80211 which discards the HW hash. So now you're replacing
> a (possibly bad-quality) HW hash with a software hash of the *outer*
> encapsulation header...
If this becomes a problem, I think we should add a similar patch to
wireguard, which already calls skb_get_hash before encapsulating.
Other regular tunnels should already get a proper hash, since the flow
dissector will take care of it.

The reason I did this patch is because I have a patch to set the hw flow
hash in the skb on mtk_eth_soc, which does help GRO, but leads to
collisions on mac80211 fq.

- Felix
