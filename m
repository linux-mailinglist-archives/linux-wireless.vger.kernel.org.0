Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07774EBED2
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfKAIAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 04:00:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKAIAe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 04:00:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FD3560DA5; Fri,  1 Nov 2019 08:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572595233;
        bh=o5FfWkhParaDzFTMG7QMjzfSFztCVis7qeCkhTGKqic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2S9Mhl92qm5ymULDuqRb5dTuBoBTCO4RIBApTMYfssD2QcLKmMtE1MFywtyY9GIu
         NmugzKiv1aVafcpJUwb4LN/I9ZRMbs8dQgVstsYO9rklf2W2ONxszp9SMMDyV+1DNS
         Lgofw+/bcX2Tzfguyq1Hys62yQD0AfS6Hi7S8IK8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 762B960D83;
        Fri,  1 Nov 2019 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572595231;
        bh=o5FfWkhParaDzFTMG7QMjzfSFztCVis7qeCkhTGKqic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jv0JiUirv6+1j3ad47BfG0V343JayrH0Kzh+naJ6DTs3tDDXjlMcsg5Ypv3T2LLFn
         o8lMroLDHqhHYq+/5cIMyrgl1vcnXNORPLpzNVx1pOBMZNP8AwbsGUv0qp/jnXddkw
         ts093ZisGzJL7F4f+5VmRTYtrUKz2DPXvdV8hSr0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Nov 2019 16:00:31 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] ath10k: enable napi on RX path for sdio
In-Reply-To: <87tv7p1cz1.fsf@kamboji.qca.qualcomm.com>
References: <20191014114753.7459-1-wgong@codeaurora.org>
 <87tv7p1cz1.fsf@kamboji.qca.qualcomm.com>
Message-ID: <e9db35228a09ccc14ac0ec31e9a10552@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-31 17:27, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> For tcp RX, the quantity of tcp acks to remote is 1/2 of the quantity
>> of tcp data from remote, then it will have many small length packets
>> on TX path of sdio bus, then it reduce the RX packets's bandwidth of
>> tcp.
>> 
>> This patch enable napi on RX path, then the RX packet of tcp will not
>> feed to tcp stack immeditely from mac80211 since GRO is enabled by
>> default, it will feed to tcp stack after napi complete, if rx bundle
>> is enabled, then it will feed to tcp stack one time for each bundle
>> of RX. For example, RX bundle size is 32, then tcp stack will receive
>> one large length packet, its length is neary 1500*32, then tcp stack
>> will send a tcp ack for this large packet, this will reduce the tcp
>> acks ratio from 1/2 to 1/32. This results in significant performance
>> improvement for tcp RX.
>> 
>> Tcp rx throughout is 240Mbps without this patch, and it arrive 390Mbps
>> with this patch. The cpu usage has no obvious difference with and
>> without NAPI.
> 
> I have not done thorough review yet, but few quick questions:
> 
> This adds a new skb queue ar->htt.rx_indication_head to RX path, but on
> one of your earlier patches you also add another skb queue
> ar_sdio->rx_head. Is it really necessary to have two separate queues in
> RX path? Sounds like extra complexity to me.
it is because the ar_sdio->rx_head is for all rx of sdio bus, include 
wmi event, fw log event,
pkt log event, htt event... and ar_sdio->rx_head is a lower layer of 
stack,
but the NAPI it to improve htt rx data's performance, it is only for htt 
rx, also pcie has the same
queue in ath10k_htt for napi, but it only used for low latency.
> 
> The way I have understood that NAPI is used as a mechanism to disable
> interrupts on the device and gain throughput from that. But in your
> patch the poll function ath10k_sdio_napi_poll() doesn't touch the
> hardware at all, it just processes packets from
> ar->htt.rx_indication_head queue until budget runs out. I'm no NAPI
> expert so I can't claim it's wrong, but at least it feels odd to me.
The difference of this sdio NAPI and pcie NAPI is PCIE's napi_schedule 
is called in isr,
and sdio is called in indication_work of sdio rx, because ath10k's isr 
is not a real isr, it is
owned by sdio host, and actually it is a thread.
When napi_schedule called, it will raise a soft irq in the same context, 
it will block current thread
but not block current isr, in order not to block sdio host thread, so 
called napi_schedule in indication_work of sdio rx is the best choise.
