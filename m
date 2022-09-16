Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655AF5BB126
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIPQjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIPQi7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 12:38:59 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F78580EB8
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 09:38:57 -0700 (PDT)
Message-ID: <1a1d993e-58cd-6f42-38c9-ea7a9fe6456f@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1663346334;
        bh=Utbi4rfqZk71EVBH8r0qtna/1I21yMd7d8to3UoEWYw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RhuMOr4NSBRwiZfQoA/ilZe2nuwio37QOoSvHw6FfOkD1zF2aDgQEsQL5ysqigy98
         N0iyFKiFzwNulqyTOtUGy1+u0r/5MdiRGTyWXvBCusr7c22Q7kGzzNz4GwL7YBSyVj
         xzh/chFsut3MAoIhTVlmZEhXeQRQ4BNRrsz+kSko=
Date:   Fri, 16 Sep 2022 18:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
To:     Ben Greear <greearb@candelatech.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
 <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
 <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
 <0b342479-d04a-a45e-d63b-73eec5a1fb40@wetzel-home.de>
 <4f77c10b-a6ea-2b79-cada-deefb2a3a07b@candelatech.com>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <4f77c10b-a6ea-2b79-cada-deefb2a3a07b@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15.09.22 22:39, Ben Greear wrote:

>  From reading the original patch description, it was to stop an NPE when 
> AP was stopped.  I have been testing
> this patch below and it fixes the problems I saw with multiple vdevs.  I 
> was worried that
> the code in the 'list_for_each_entry_rcu(sta, &local->sta_list, list) {' 
> might still need to run
> to keep everything in sync (and my patch allows that to happen), but I 
> do not know if that is true or not.
> 

I'm not sure if it's still save to wake the queues for the vif we are 
tearing down and assumed the intend was to skip those, too.

But it looks like all stations for the vif are deleted prior to setting 
sdata->bss = NULL, so the outcome should be the same.

Your solution removes potentially set IEEE80211_TXQ_STOP_NETIF_TX flags, 
reducing the risk that a queue restart during vif setup ends up with 
inoperable queues.
But the only way to set IEEE80211_TXQ_STOP_NETIF_TX seems to be during 
ieee80211_tx_dequeue(). Which should not be possible to be called as 
long as SDATA_STATE_RUNNING was never set for the vif.

But I'm on thin ice here:-)

Alexander
