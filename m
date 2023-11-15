Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F17EC821
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 17:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjKOQGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 11:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjKOQGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 11:06:15 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B395
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 08:06:11 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 512AFB80070;
        Wed, 15 Nov 2023 16:06:08 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 06CCE13C2B0;
        Wed, 15 Nov 2023 08:01:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 06CCE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1700064064;
        bh=EmimStlLWzZ1oPQ8Ea8Mt6uvMdSWobvDaIPHtDJdC9U=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OXJphScecvcYCgneudNQk7maz6heMcrA1eiBh5nGfxRltFZuJ3apLXP/wP7P1TcTK
         PwB31S6VCpZpSK6vX3jnsDKhBKzMMihVkHHPgh5y29R0UGpoPpLHEdKQbRkZwqFFEl
         uxwLAHGOtUmI5jjRnup9m2TwNqClue9yyyUTkpa4=
Message-ID: <7a76305b-dd42-b866-f64f-93b7c8811f97@candelatech.com>
Date:   Wed, 15 Nov 2023 08:01:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: Add debugging around scan failure warning.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231114212309.2180281-1-greearb@candelatech.com>
 <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1700064369-3TbTFP5nZzpd
X-MDID-O: us5;at1;1700064369;3TbTFP5nZzpd;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/15/23 00:57, Johannes Berg wrote:
> On Tue, 2023-11-14 at 13:23 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Provide additional information that may help debugging why
>> the WARN_ON is seen.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>> index 75c5c58e14a5..ec24ece7c877 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>> @@ -2356,7 +2356,10 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
>>   			link_id = ffs(vif->active_links) - 1;
>>   
>>   		link_info = scan_vif->link[link_id];
>> -		if (!WARN_ON(!link_info))
>> +		if (WARN_ON(!link_info))
>> +			IWL_ERR(mvm, "scan failure: Cannot find link info for link-id: %d active-links: 0x%x\n",
>> +				link_id, vif->active_links);
>>
> 
> It would make sense to put the data *into* the warning, rather than
> separately? Though I'm not sure I see so much value in the long string
> (vs. just the data).

I assume IWL_ERR will provide some extra context in systems with multiple radios,
so more useful than what I could easily put into WARN_* directly.

> 
> But honestly I'm not sure this really even is a problem at all? Some
> confusion can happen during firmware restart here, and not sure we can
> really fix that. Though maybe with the new locking we can.

I see the splat, not sure why.  It would be nice to know if link-id is
corrupted somehow, or if active links is zero, etc.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


