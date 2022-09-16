Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBA5BB181
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIPRK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPRK1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 13:10:27 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009177548
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 10:10:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.119])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 327CC1C0097;
        Fri, 16 Sep 2022 17:10:24 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B729F7C0087;
        Fri, 16 Sep 2022 17:10:22 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EB22D13C2B0;
        Fri, 16 Sep 2022 10:10:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EB22D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1663348222;
        bh=/n5qZLf61TXqJCbR4HJVxfzirKtKoGc3WyqmwnwJOjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=q/W/0WmPipwTJOs8RksNa69KIDYXbCmuRB2Ue25nrnWhm4zM1rlj0TpGpRLsfDtRE
         2d6GKyHwmffCPANmNa7DF0BbJsh1zZAOu480qorBd2WMqzQ/aXWPvZSNl6yLTYZSzi
         h097qx9GmReBfA2JWkCqBE39fd8Eset6ZFIlwzI8=
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
 <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
 <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
 <0b342479-d04a-a45e-d63b-73eec5a1fb40@wetzel-home.de>
 <4f77c10b-a6ea-2b79-cada-deefb2a3a07b@candelatech.com>
 <1a1d993e-58cd-6f42-38c9-ea7a9fe6456f@wetzel-home.de>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <243e00a7-9945-dc81-e5dc-9206958c78a1@candelatech.com>
Date:   Fri, 16 Sep 2022 10:10:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1a1d993e-58cd-6f42-38c9-ea7a9fe6456f@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1663348224-VstBi9OCJqyE
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/16/22 9:38 AM, Alexander Wetzel wrote:
> On 15.09.22 22:39, Ben Greear wrote:
> 
>>  From reading the original patch description, it was to stop an NPE when AP was stopped.  I have been testing
>> this patch below and it fixes the problems I saw with multiple vdevs.  I was worried that
>> the code in the 'list_for_each_entry_rcu(sta, &local->sta_list, list) {' might still need to run
>> to keep everything in sync (and my patch allows that to happen), but I do not know if that is true or not.
>>
> 
> I'm not sure if it's still save to wake the queues for the vif we are tearing down and assumed the intend was to skip those, too.
> 
> But it looks like all stations for the vif are deleted prior to setting sdata->bss = NULL, so the outcome should be the same.
> 
> Your solution removes potentially set IEEE80211_TXQ_STOP_NETIF_TX flags, reducing the risk that a queue restart during vif setup ends up with inoperable queues.
> But the only way to set IEEE80211_TXQ_STOP_NETIF_TX seems to be during ieee80211_tx_dequeue(). Which should not be possible to be called as long as 
> SDATA_STATE_RUNNING was never set for the vif.
> 
> But I'm on thin ice here:-)

I spent two days debugging this and have only barest understanding of how all of the atf/fq/txq logic
is supposed to work.

But, I think my test case was a bit different from yours, and in my test case, before my patch,
it failed 100% of the time:

create two station vdevs on same (mtk7916) radio
admin one up (this works)
admin second one up (this fails, tx path is hung, because sdata->vif.txqs_stopped[ac] was true).

In general, I'd like to keep start/stop state as in-sync everywhere as possible, and I think my patch
might be better at that than yours since it goes through the sta list (and, maybe too, I'm completely
wrong about that).

Potentially, static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
should just be called each time a vdev goes admin up.
But since my original test case failed so reliably, the __ieee80211_wake_txqs method must not actually be
called when secondary vdevs go admin up.  I am not sure if that is per design or some other
bug.

Hoping the 2-3 people who understand this logic well will chime in :)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

