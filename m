Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50851A152
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbiEDNxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241528AbiEDNxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 09:53:15 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F132EFA
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 06:49:38 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3A3052007E;
        Wed,  4 May 2022 13:49:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0A962780080;
        Wed,  4 May 2022 13:49:36 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.37.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0D4CE13C2B0;
        Wed,  4 May 2022 06:49:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0D4CE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1651672176;
        bh=dTvb4KTyYMEGR93Aflw+SqTWisw+dusY2LJSIxn1G4Q=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=M4dbbDMci0eTTplIsb8nDfX3kdKwCl0N1odbPR0h5AqQoJW/Y/LkkCTqjGhb1NseK
         ro+OaJwABye34dlCd2kqYnYYHWFKWvlr6u+YmvgSbo7IYBlsZLNheJGUHvcmtlX2iX
         87GTpy7RzhXQ3qUihv0AUpRVJmgldeUG6elOkLAE=
Subject: Re: [PATCH 1/2] mac80211: Allow drivers to report avg chain signal.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220225232842.32028-1-greearb@candelatech.com>
 <b11b11c0dab8e4eb527bba7b332287efe0bc2cbc.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d2c03c10-70cf-81a5-f2fa-73ad58b81a92@candelatech.com>
Date:   Wed, 4 May 2022 06:49:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b11b11c0dab8e4eb527bba7b332287efe0bc2cbc.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1651672177-oU9vvnQR_ACh
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/22 3:53 AM, Johannes Berg wrote:
> On Fri, 2022-02-25 at 15:28 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Drivers that use RSS cannot get the avg signal from mac80211.
>> So allow drivers to report the avg chain signal while letting
>> mac80211 take care of the last chain signal.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   net/mac80211/sta_info.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
>> index 43a58b30c6a4..00836f587b6d 100644
>> --- a/net/mac80211/sta_info.c
>> +++ b/net/mac80211/sta_info.c
>> @@ -2543,6 +2543,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>>   	if (last_rxstats->chains &&
>>   	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
>>   			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
>> +		/* Neither chain signal nor chain signal avg is filled */
>>   		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
> 
> I don't think that comment adds value, in fact, since it's _after_ the
> condition it applies to (rather than before), it's confusing? At least
> to me it was ... And if you read the condition that already says so
> pretty clearly anyway.
> 
>> @@ -2557,6 +2558,21 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>>   		}
>>   	}
>>   
>> +	/* Check if chain signal is not filled, for cases avg was filled by
>> +	 * driver bug last chain signal was not.
>> +	 */
>> +	if (last_rxstats->chains &&
>> +		 !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)))) {
>> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
>> +
>> +		sinfo->chains = last_rxstats->chains;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
>> +			sinfo->chain_signal[i] =
>> +				last_rxstats->chain_signal_last[i];
>> +		}
>> +	}
>>
> 
> Now you've duplicated this code ... you can remove it above, no?

The conditional check in this second block is different.  It is one reason
why I added the other comment in the preceeding code.

I can fix the typo (bug -> but) in the comment and the indentation.

If you still think code is duplicated, please let me know more precisely
what is duplicated...maybe I mis-understood your comment.

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
