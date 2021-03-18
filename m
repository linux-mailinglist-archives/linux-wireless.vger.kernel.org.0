Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BEA341018
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 22:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCRV57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 17:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhCRV5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 17:57:36 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA70C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TP6KuCeVK8TNEtxfKrF+7v9fSMdANC12EI+U2jGs/Uw=; b=DvBw/zyuf6Lq6jozL5lIpDpwCw
        VUj4VgtLLfNecj/zMs8Ik9kDVBpPrXmPbHtChqUNTy+4UdewxtUhKX/ddMYWiaib6AzhFCy/Il7Fj
        LvMcVi2er9yG4r6bRt1WJZib/wWllb3hdSG+u1KX+Ji6T7D82d8HTn614rYLWMty0HtY=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lN0e3-0004B2-T3; Thu, 18 Mar 2021 22:57:31 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     make-wifi-fast@lists.bufferbloat.net,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
References: <20210318213142.138707-1-toke@redhat.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH mac80211-next v6] mac80211: Switch to a virtual time-based
 airtime scheduler
Message-ID: <a6ca1ab9-29a0-18fe-8097-20abc5f253bd@nbd.name>
Date:   Thu, 18 Mar 2021 22:57:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318213142.138707-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Toke,

Thanks for continuing to work on this! I just did a quick reading of the
code and haven't tested this yet - I might have some more comments in
the next few days.

On 2021-03-18 22:31, Toke Høiland-Jørgensen wrote:
> This switches the airtime scheduler in mac80211 to use a virtual time-based
> scheduler instead of the round-robin scheduler used before. This has a
> couple of advantages:
> 
> - No need to sync up the round-robin scheduler in firmware/hardware with
>   the round-robin airtime scheduler.
> 
> - If several stations are eligible for transmission we can schedule both of
>   them; no need to hard-block the scheduling rotation until the head of the
>   queue has used up its quantum.
> 
> - The check of whether a station is eligible for transmission becomes
>   simpler (in ieee80211_txq_may_transmit()).
> 
> The drawback is that scheduling becomes slightly more expensive, as we need
> to maintain an rbtree of TXQs sorted by virtual time. This means that
> ieee80211_register_airtime() becomes O(logN) in the number of currently
> scheduled TXQs because it can change the order of the scheduled stations.
> We mitigate this overhead by only resorting when a station changes position
> in the tree, and hopefully N rarely grows too big (it's only TXQs currently
> backlogged, not all associated stations), so it shouldn't be too big of an
> issue.
> 
> To prevent divisions in the fast path, we maintain both station sums and
> pre-computed reciprocals of the sums. This turns the fast-path operation
> into a multiplication, with divisions only happening as the number of
> active stations change (to re-compute the current sum of all active station
> weights). To prevent this re-computation of the reciprocal from happening
> too frequently, we use a time-based notion of station activity, instead of
> updating the weight every time a station gets scheduled or de-scheduled. As
> queues can oscillate between empty and occupied quite frequently, this can
> significantly cut down on the number of re-computations. It also has the
> added benefit of making the station airtime calculation independent on
> whether the queue happened to have drained at the time an airtime value was
> accounted.
> 
> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
> Respinning this has taken way too long, but assuming anyone actually remembers
> the previous version from a bit over a year ago, here's the changelog:
> 
> Changes since v5:
>   Rebase on latest mac80211-next.
> 
>   Fix issue with scheduling hanging because the schedule position was not
>   cleared when starting a new scheduling round.
> 
>   Switch the reciprocal calculation to use u32 (split 19/13) for per-station
>   weights and a u64 only for the weight sum (to cut down on the number of 64-bit
>   operations performed)
> 
>   Introduce the notion of time-based station activity when calculating weight
>   sums. This also gets rid of the need for a "grace time" when catching up
>   stations, since we now have a direct notion of when a station has been
>   inactive for a while.
Not sure if I'm misunderstanding the code, but this does not seem enough
to me. From what I can see, you consider a station active if it has been
scheduled in the last 100ms. Let's say we keep sending a single small
packet to a particular sta every 90ms (thus keeping it active) for a
long period of time and then suddenly start a really huge transfer.
What keeps it from then taking an unreasonably large share of the
airtime for as long as it takes for the virtual time to catch up?

Am I missing something or should we maybe use the new notion of
time-based activity *and* do a grace time catch up?

- Felix
