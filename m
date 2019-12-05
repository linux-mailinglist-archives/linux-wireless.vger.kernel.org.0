Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5C1144F0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 17:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfLEQhI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 11:37:08 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:37680 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 11:37:07 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2EF12137531;
        Thu,  5 Dec 2019 08:37:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2EF12137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575563827;
        bh=mP5CugRci/NLlrWmjZiv4fTb+UhEhXdaDqCu0CpN2CY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KVFJQ7JpUO9YUmTogzt4J8cN+tvxWB3Pbs/Kjp/3Rj9HNiaH6x5GV0BlXNG8l60kg
         YrZ7qs1i2zBxKTWM3HYfv+0v+NTkUxLdv2ca1Ofn9BQYE1D/QzXBCpEozlAssNFpy9
         oUXTKqMytjr81a5Bi2MdLyXTRGb9WonElU1Ee+VU=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
Date:   Thu, 5 Dec 2019 08:37:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/19 8:34 AM, Johannes Berg wrote:
> Hi Toke, all,
> 
> I'm debugging some throughput issues and wondered if you had a hint.
> This is at HE rates 2x2 80 MHz, so you'd expect ~1Gbps or a bit more,
> I'm getting ~900 Mbps. Just to set the stage.
> 
> What I think is (part of) the problem is that I see in the logs that our
> hardware queues become empty every once a while.
> 
> This seems to be when/because ieee80211_tx_dequeue() returns NULL, and
> we hit the
>                          skb = ieee80211_tx_dequeue(hw, txq);
> 
>                          if (!skb) {
>                                  if (txq->sta)
>                                          IWL_DEBUG_TX(mvm,
>                                                       "TXQ of sta %pM tid %d is now empty\n",
>                                                       txq->sta->addr,
>                                                       txq->tid);
> 
> printout, e.g.
> iwlwifi 0000:00:14.3: I iwl_mvm_mac_itxq_xmit TXQ of sta 0c:9d:92:03:12:44 tid 0 is now empty
> 
> This isn't always bad, but in most cases I see it happen the hardware
> queue actually is rather shallow at the time, say only 57 packets in
> some instance. Then we can basically send all the packets in the queue
> in one or two aggregations (see I here an example with 57 packets in the
> queue, ieee80211_tx_dequeue() returns NULL, and we then send an A-MPDU
> with 38 followed by one with 19 packets, making the HW queue empty.)
> 
> This is with 10 simultaneous TCP streams, so there *shouldn't* be any
> issues with that, I did indeed try to lower the pacing shift and it had
> no effect. I couldn't try with just one or two streams (actually one
> stream is not enough because the AP has only GBit LAN ... so in the
> ideal case wireless is faster than ethernet!!) - somehow the test hangs
> then, but I'll get back to that later.
> 
> 
> Anyhow, do you have any tips on debugging this? This is still without
> AQL code. The AQM stats for the AP look fine, basically everything is 0
> except for "new-flows", "tx-bytes" and "tx-packets".
> 
> One thing that does seem odd is that the new-flows counter is increasing
> this rapidly - shouldn't we expect it to be like 10 new flows for 10 TCP
> sessions? I see this counter increase by the thousands per second.
> 
> I don't see any calls to __ieee80211_stop_queue() either, as expected
> (per trace-cmd).
> 
> CPU load is not an issue AFAICT, even with all the debugging being
> written into the syslog (or journal or something) that's the only thing
> that takes noticable CPU time - ~50% for systemd-journal and ~20% for
> rsyslogd, <10% for the throughput testing program and that's about it.
> The system has 4 threads and seems mostly idle.
> 
> All this seems to mean that the TCP stack isn't feeding us fast enough,
> but is that really possible?

Does UDP work better?

or pktgen?

Thanks,
Ben

> 
> Any other ideas?
> 
> Thanks,
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

