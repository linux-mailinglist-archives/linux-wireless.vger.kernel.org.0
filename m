Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB15BA1E3
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIOUkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 16:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOUj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 16:39:59 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564313E746
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 13:39:58 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A65FC1C0082;
        Thu, 15 Sep 2022 20:39:56 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 019EB780078;
        Thu, 15 Sep 2022 20:39:55 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 75A5613C2B0;
        Thu, 15 Sep 2022 13:39:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 75A5613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1663274395;
        bh=CXdSqgaZvbYZurzTR43KgBcueolrjK7Dkx4bmtPbzAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQP7+hKPRU8QAJW4SzZIHC1mMXD0G7ctmOyDdXMxh+yLc2gy1G2BOsLkZ2+RITv8W
         xaNmNLhcnyBZoFqOmuBHpu2c6+McZX2kRiivRVAKBxTbLHcdOSQn5Jgi8F3h6ocO1G
         lYrMoNFfwPSYn2ReIyi9KdgD7wJaLSxqfFPqZm9Q=
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
 <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
 <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
 <0b342479-d04a-a45e-d63b-73eec5a1fb40@wetzel-home.de>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <4f77c10b-a6ea-2b79-cada-deefb2a3a07b@candelatech.com>
Date:   Thu, 15 Sep 2022 13:39:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0b342479-d04a-a45e-d63b-73eec5a1fb40@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1663274397-b4AlKmjo3kZs
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/15/22 1:06 PM, Alexander Wetzel wrote:
>>
>> I've got some doubts that my fix is correct...
>> While it fixes the problem in my tests it looks like we'll need another queue restart to get the queues working again.
>>
>> After all IEEE80211_TXQ_STOP_NETIF_TX will not be cleared when it has been set by __ieee80211_stop_queue().
>>
>> I'll update the patch and skip setting vif.txqs_stopped when SDATA_STATE_RUNNING is not set. Not having IEEE80211_TXQ_STOP_NETIF_TX set looks harmless, having 
>> it set when it should less problematic...
> 
> Scratch that: The patch should be ok as it is: IEEE80211_TXQ_STOP_NETIF_TX is not set on stop, the patch should be ok as it is.
> 
> Sorry for the noise.
> 
> Alexander
> 

To add to the noise...

 From reading the original patch description, it was to stop an NPE when AP was stopped.  I have been testing
this patch below and it fixes the problems I saw with multiple vdevs.  I was worried that
the code in the 'list_for_each_entry_rcu(sta, &local->sta_list, list) {' might still need to run
to keep everything in sync (and my patch allows that to happen), but I do not know if that is true or not.

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c768e583aad4..2b5dafe9f4cc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -370,12 +370,6 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
         local_bh_disable();
         spin_lock(&fq->lock);

-       if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
-               goto out;
-
-       if (sdata->vif.type == NL80211_IFTYPE_AP)
-               ps = &sdata->bss->ps;
-
         sdata->vif.txqs_stopped[ac] = false;

         list_for_each_entry_rcu(sta, &local->sta_list, list) {
@@ -408,6 +402,10 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)

         txqi = to_txq_info(vif->txq);

+       if (test_bit(SDATA_STATE_RUNNING, &sdata->state))
+               if (sdata->vif.type == NL80211_IFTYPE_AP)
+                       ps = &sdata->bss->ps;
+
         if (!test_and_clear_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags) ||
             (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
                 goto out;


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

