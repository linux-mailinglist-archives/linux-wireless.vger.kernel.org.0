Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D665837CB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiG1ELi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 00:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiG1ELg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 00:11:36 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662C32BAE
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 21:11:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 082411C007D;
        Thu, 28 Jul 2022 04:11:34 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B4BDA780065;
        Thu, 28 Jul 2022 04:11:33 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.35.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0919013C2B0;
        Wed, 27 Jul 2022 21:11:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0919013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658981493;
        bh=HNyRrCaorSFW+MEd4arfewESxvjx5MZtBRtkP2ufrFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r3t/ySdc0lo7lFqHO+HFQa0hkX7UJFk93opPZSLFjIbuR9AG7YfaUZ8nJongUuesd
         HYMfs0jOUSZSYXI3poPzdvNaAZkD/UW60OG8uHtrfDIyRubw54F/MKHAG68nrqZgLc
         A8biBs6CZ2sXZlLPhIVYylyDblH67fzBp2VC0ZSs=
Subject: Re: [PATCH 05/12] wifi: mt76: mt7915: report tx-retries
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name
References: <20220727230122.29842-1-greearb@candelatech.com>
 <20220727230122.29842-5-greearb@candelatech.com>
 <7f5284ae5f78f59dcf0d1cf559bf444e237eadbe.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <309601ec-2b09-fc99-c003-882a895469d0@candelatech.com>
Date:   Wed, 27 Jul 2022 21:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7f5284ae5f78f59dcf0d1cf559bf444e237eadbe.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1658981494-ukzufTmA-FYj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/22 8:20 PM, Ryder Lee wrote:
> On Wed, 2022-07-27 at 16:01 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> mac80211 stack will only report tx-status for skb claiming to be
>> ampdu heads, so lie a bit in mt7915 and set the flag so that mac80211
>> will record status for each skb.
>>
>> mt7915 appears to report retry status on an individual per-skb
>> manner,
>> so that method above seems to work.
>>
>> Re-constitute the txinfo status rate info so that the rix and flags
>> is also at least close to correct.  No direct way to report HE
>> rates that way, so mac80211 might could use some tweaking in
>> the ieee80211_tx_status_ext to take both info and status->rate
>> into account.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +
>>   drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +
>>   .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
>>   .../net/wireless/mediatek/mt76/mt7915/mac.c   | 95
>> ++++++++++++++++++-
>>   .../net/wireless/mediatek/mt76/mt7915/mac.h   |  6 +-
>>   .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +
>>   .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +
>>   drivers/net/wireless/mediatek/mt76/tx.c       | 18 +++-
>>   8 files changed, 129 insertions(+), 8 deletions(-)
> 
> Hi Ben,
> 
> Looks like we have a similar goal but I don't use txs_for_no_skb.
> 
> What about directly switching to PPDU bases reporting (it should
> include MPDUs total/failed/retries counts/bytes) and using
> .sta_statistics? I think this might simplify the codes and can use
> mac80211 ethtool as is.

I like per-packet tx-status because then I can do histograms up in mac80211
(and the driver) to show distributions of nss, mcs, encoding types, etc.

I have not actually coded against the histograms I put in mac80211, but instead I'm using ethtool
to get the histograms directly out of mt76 driver.

At least for 7915, I think you have to enable txs-for-no-skb logic to get
details on mcs, nss and similar rate info?

Thanks,
Ben

> 
> I made these changes for .net_fill_forward_path (WED) cases. We're
> doing some throughput tests.
> https://pastebin.com/raw/qCzNNDzw
> https://pastebin.com/raw/25Vsk2xs
> 
> 
> Ryder
> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
