Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29942563402
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiGANGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiGANGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 09:06:00 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB132E083
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 06:05:59 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.13])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 91B1CA0073;
        Fri,  1 Jul 2022 13:05:57 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 54965440066;
        Fri,  1 Jul 2022 13:05:57 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.36.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4A8C513C2B0;
        Fri,  1 Jul 2022 06:05:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4A8C513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1656680756;
        bh=XmTv5gDGy9MDp9Ny5xAtYI/QmrLqutwQ+eKFUryHNFc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NJ1BUb7J0G3JtSQEDWC4TklYf7lXYafdiJXMcPui2KQhLpNxOszrmUqPQDu8hygbx
         5AQi7bgor7yjJ7aIgODwaYWzOtEzAa2EAqUyJbhDwjFh7+n18TczPIZbH9zH1CVTrr
         scCxxpJPQTQP2YQXEWell5QtkLNgkYy6aWSvizlA=
Subject: Re: [PATCH] mac80211: report per-chain signal values through ethtool.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220329210228.8137-1-greearb@candelatech.com>
 <8542c3eac729563fef1bc78d28c740453fba88bd.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c7ee84a4-2be5-4176-2701-8c2e691a85fe@candelatech.com>
Date:   Fri, 1 Jul 2022 06:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8542c3eac729563fef1bc78d28c740453fba88bd.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1656680758-BUtElSCjh43a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/1/22 2:55 AM, Johannes Berg wrote:
> On Tue, 2022-03-29 at 14:02 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Combine them into a u64, each byte is one chain.
> 
> This only works up to 4 chains, but the specs at least support 8. I
> don't think we have any drivers for that, but ...

u64 gives 8 bytes, so the ethtool part can support 8 chains.
The mac80211 part only supports up to 4 chains currently though.

> 
> And it's also rather ugly, IMHO.
> 
> We're reporting these through nl80211 anyway though, no? Why should we
> prefer ethtool, which fundamentally limits to a single value for the AP
> rather than giving the full per-station view.

I already gather ethtool stats for STA vdevs, so adding another stat is
basically free as far as performance is concerned.  That is important
to me.  I do not currently program much against netlink API (just scrape
existing tools output).

I understand if you don't want it upstream though.

> 
>> Re-work the way that APs averaged stats to be more
>> efficient.
> 
> Isn't that completely unrelated?

At least somewhat unrelated.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
