Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA0DC5A3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410199AbfJRNB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 09:01:27 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:60632 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410165AbfJRNB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 09:01:26 -0400
Received: from [192.168.1.47] (unknown [50.34.216.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 54019137566;
        Fri, 18 Oct 2019 06:01:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 54019137566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1571403685;
        bh=05vVSmqtLW47sf9Rc6MdFNX56EEXBS4FCPBzksR0BBU=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=jxDuiSzx/ZZgjhMYWzw/B71/TOWFpvnWECNzIr6qxryERkzE1+Fw9kS1pqDf/yr3o
         IGFVVCEcNuMXsBkhxj2jqgpXAM0r3i7bhotOF0WDtqVhi0D+JskMCsNC65jXKiYbnz
         0kvJfMOB4fPHiXbEddzWdHBOLHGo0BbujnDa1e3E=
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room
 for tx_time_est
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
 <157115993866.2500430.13989567853855880476.stgit@toke.dk>
 <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
 <87sgnqe4wg.fsf@toke.dk>
 <4bc17c32337888a57a78a0e2c874abd462faef21.camel@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <237a3110-69c1-6679-6ffb-892c3815049c@candelatech.com>
Date:   Fri, 18 Oct 2019 06:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4bc17c32337888a57a78a0e2c874abd462faef21.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/18/2019 05:35 AM, Johannes Berg wrote:
> On Fri, 2019-10-18 at 12:15 +0200, Toke Høiland-Jørgensen wrote:
>> Kan Yan <kyan@google.com> writes:
>>
>>> The "tx_time_est" field, shared by control and status, is not able to
>>> survive until the skb returns to the mac80211 layer in some
>>> architectures. The same space is defined as driver_data and some
>>> wireless drivers use it for other purposes, as the cb in the sk_buff
>>> is free to be used by any layer.
>>>
>>> In the case of ath10k, the tx_time_est get clobbered by
>>> struct ath10k_skb_cb {
>>>         dma_addr_t paddr;
>>>         u8 flags;
>>>         u8 eid;
>>>         u16 msdu_id;
>>>         u16 airtime_est;
>>>         struct ieee80211_vif *vif;
>>>         struct ieee80211_txq *txq;
>>> } __packed;
>>
>> Ah, bugger, of course the driver that actually needs this is using the
>> full driver_data space :P
>
> Looks like you could shrink *this* fairly easily though.
>
> E.g. most likely vif == txq->vif unless txq==NULL, so it's down to 22
> bytes plus a bit/flag for knowing whether the pointer is a vif directly
> (if no TXQ) or a TXQ.

And of course you get two bits in every pointer (0x3) and likely the
dma addr too.  Plenty of space!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
