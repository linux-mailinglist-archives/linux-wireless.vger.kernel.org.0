Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D860451A236
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351322AbiEDOe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbiEDOe6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 10:34:58 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8219291
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 07:31:22 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.122])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8A64A20090;
        Wed,  4 May 2022 14:31:20 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5C0BD4008C;
        Wed,  4 May 2022 14:31:20 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.37.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 99EE713C2B0;
        Wed,  4 May 2022 07:31:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 99EE713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1651674680;
        bh=NLQo6FsVgLWA6QI9aSjma2FgI1ym/vSf0XYEOkEtwuI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HuM+UIxXkod74hWlbpMGDdmakHobi1s9L6pKhlr4B8EljPIgGQ2qiXegQlaiNKysH
         sVcukQ6hCtqDc7RZ4PU+O/kc/ZdhQWOChr4a2sGU/9y3Goh+rkPTRAzwq4sLm41yPE
         qpnAwnKEAZAWr9X7EPNt4fiKVy2vHvIpZX2R1og4=
Subject: Re: [PATCH 1/2] mac80211: Allow drivers to report avg chain signal.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220225232842.32028-1-greearb@candelatech.com>
 <b11b11c0dab8e4eb527bba7b332287efe0bc2cbc.camel@sipsolutions.net>
 <d2c03c10-70cf-81a5-f2fa-73ad58b81a92@candelatech.com>
 <1001665f4de469761c4f786954912c40d0c88e72.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <562596f2-5c69-367d-5359-0a79f0e52a2f@candelatech.com>
Date:   Wed, 4 May 2022 07:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1001665f4de469761c4f786954912c40d0c88e72.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1651674681-Y00PlvlPoS3i
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/22 6:53 AM, Johannes Berg wrote:
> On Wed, 2022-05-04 at 06:49 -0700, Ben Greear wrote:
>>
>>>> +	/* Check if chain signal is not filled, for cases avg was filled by
>>>> +	 * driver bug last chain signal was not.
>>>> +	 */
>>>> +	if (last_rxstats->chains &&
>>>> +		 !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)))) {
>>>> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
>>>> +
>>>> +		sinfo->chains = last_rxstats->chains;
>>>> +
>>>> +		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
>>>> +			sinfo->chain_signal[i] =
>>>> +				last_rxstats->chain_signal_last[i];
>>>> +		}
>>>> +	}
>>>>
>>>
>>> Now you've duplicated this code ... you can remove it above, no?
>>
>> The conditional check in this second block is different.  It is one reason
>> why I added the other comment in the preceeding code.
> 
> Oh, sure, I get that.
> 
> But I mean you can end up setting sinfo->chains and all of the values in
> sinfo->chain_signal[i] with both cases: when "both are unset" or when
> "just chain signal is unset"?
> 
> So wouldn't it be more or less equivalent to do
> 
>   if (!signal-filled) { fill signal }
> 
> which is your new code here, and thus have
> 
>   if (!signal-filled) { fill signal }
>   if (!signal-avg-filled) { fill avg signal }
> 
> rather than
> 
>   if (!signal-filled && !signal-avg-filled) {
>      fill signal, fill avg-signal
>   }
>   if (!signal-filled) {
>      fill signal
>   }
> 
> or am I misreading that?

You may be correct, but once that first clause happens, the second will not since the
first should set the signal-is-filled flag.

So maybe just put it in an else clause to save the second check.

I'll take a close look at it soon while re-working the typo and white-space.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
