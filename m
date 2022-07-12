Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DC572731
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGLU05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGLU04 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 16:26:56 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5CFC921F
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 13:26:55 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D6B801C0063;
        Tue, 12 Jul 2022 20:26:53 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6953680082;
        Tue, 12 Jul 2022 20:26:53 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9C8BA13C2B0;
        Tue, 12 Jul 2022 13:26:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9C8BA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1657657612;
        bh=bNUdmHk+1BCTHMCL0ZrFq2s8EH37xU9XsxornGqT6Tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mKB6oAbAzeRxDmjmNnZbq4KXtXzy7/A7zW8rrx0FvD/162HWzznEKO/zIR1Z25IwC
         oeQRDdigaXmJjcY3J5z5Gf7eH8LUe+47veGuRRoCmc6mRE0wsTvG/NtEZIzT1srtkD
         z+PNBXxKUkTPyNQawpcUwyKjn5SaE8pIEOzbg2yo=
Subject: Re: [PATCH] mac80211: do not wake queues on a vif that is being
 stopped
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20220531190824.60019-1-nbd@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <5d6df29d-5c72-64b7-5fcd-183458bcdc5a@candelatech.com>
Date:   Tue, 12 Jul 2022 13:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220531190824.60019-1-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1657657614-2Vwgx3h4yf_8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/31/22 12:08 PM, Felix Fietkau wrote:
> When a vif is being removed and sdata->bss is cleared, __ieee80211_wake_txqs
> can still be called on it, which crashes as soon as sdata->bss is being
> dereferenced.
> To fix this properly, check for SDATA_STATE_RUNNING before waking queues,
> and take the fq lock when setting it (to ensure that __ieee80211_wake_txqs
> observes the change when running on a different CPU

I patched this into my 5.17+ kernel, and in a test that brings up 16 virtual
station vdevs on an mtk7915, 4 of them on each of two radios will not associate.
They get 4-way timeouts.

So, I think there must be something wrong with assumptions in this patch, or
maybe it depends on some other patch I am missing.  I'll remove it from my tree...

Thanks,
Ben

> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/iface.c | 2 ++
>   net/mac80211/util.c  | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 41531478437c..15a73b7fdd75 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -377,7 +377,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
>   	bool cancel_scan;
>   	struct cfg80211_nan_func *func;
>   
> +	spin_lock_bh(&local->fq.lock);
>   	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
> +	spin_unlock_bh(&local->fq.lock);
>   
>   	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
>   	if (cancel_scan)
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 1e26b5235add..dad42d42aa84 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -301,6 +301,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
>   	local_bh_disable();
>   	spin_lock(&fq->lock);
>   
> +	if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
> +		goto out;
> +
>   	if (sdata->vif.type == NL80211_IFTYPE_AP)
>   		ps = &sdata->bss->ps;
>   
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

