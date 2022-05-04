Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E051A27E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbiEDOuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiEDOuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 10:50:07 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480413EBE
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 07:46:30 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.203])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7E4671C0063;
        Wed,  4 May 2022 14:46:28 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 44173AC0071;
        Wed,  4 May 2022 14:46:28 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.37.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8811713C2B0;
        Wed,  4 May 2022 07:46:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8811713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1651675587;
        bh=J/uNRDe8xG/4dtPLx3Zc1eG72pdkmnvgHfPSBsvdS1c=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=a4NeQ3lGd42ZELoPrnOuG9w7wUnACtV7SganSBxSCoC9pD4WXLwv7PLPCfE3wwdHv
         O2CMHLcjYBPpIfCD+7XOeQ3tAua7VnEJA8LFqxmgM0r0sDc/PUgV6R4W4drQhxHOZA
         imQ9FZpIrK5r+1qI//WdE8GY4XA8jVjicbORRo3g=
Subject: Re: [PATCH 2/2] iwlwifi: RX signal improvements.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220225232842.32028-1-greearb@candelatech.com>
 <20220225232842.32028-2-greearb@candelatech.com>
 <175612fa5385cf2c30207df9012074df2c65f551.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d93c5295-d57d-9352-a484-548da937fb1a@candelatech.com>
Date:   Wed, 4 May 2022 07:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <175612fa5385cf2c30207df9012074df2c65f551.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1651675589-0icPkGi8jWJu
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/22 3:57 AM, Johannes Berg wrote:
> On Fri, 2022-02-25 at 15:28 -0800, greearb@candelatech.com wrote:
>>
>> -	if (mvmsta->avg_energy) {
>> -		sinfo->signal_avg = -(s8)mvmsta->avg_energy;
>> +	if (iwl_mvm_has_new_rx_api(mvm)) { /* rxmq logic */
>> +		/* Grab chain signal avg, mac80211 cannot do it because
>> +		 * this driver uses RSS.  Grab signal_avg here too because firmware
>> +		 * appears go not do DB summing and/or has other bugs. --Ben
>> +		 */
> 
> That "--Ben" really seems inappropriate ... please take more care when
> sending patches to the list.

I figure if I am submitting a patch that is blaming firmware, and I have no access
to firmware to actually back up my assertion, then I should put my name on it
so that folks looking at the driver don't think it is Intel disparaging it's own firmware.

> 
>>   		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
>> +		sinfo->signal_avg = -ewma_signal_read(&mvmsta->rx_avg_signal);
>> +
>> +		if (!mvmvif->bf_data.bf_enabled) {
>> +			/* The firmware reliably reports different signal (2db weaker in my case)
> 
> 
> dB, but I guess we'll want to fix that instead or so ...
> 
>> +static inline int iwl_mvm_sum_sigs_2(int a, int b)
>> +{
> 
> Feels like that calls for a helper function somewhere else, and a
> comment explaining it :)

Yes, most drivers have these issues, but each driver may have a different
way of specifying that 'a' or 'b' is valid signal or not, so simple helper method
is not so simple to write efficiently.

> 
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
>> @@ -278,14 +278,26 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
>>   static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
>>   					struct ieee80211_rx_status *rx_status,
>>   					u32 rate_n_flags, int energy_a,
>> -					int energy_b)
>> +					int energy_b, struct ieee80211_sta *sta,
>> +					bool is_beacon, bool my_beacon)
>>   {
>>   	int max_energy;
>>   	u32 rate_flags = rate_n_flags;
>> +	struct iwl_mvm_sta *mvmsta = NULL;
>> +
>> +	if (sta && !(is_beacon && !my_beacon)) {
>> +		mvmsta = iwl_mvm_sta_from_mac80211(sta);
>> +		if (energy_a)
>> +			ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
>> +		if (energy_b)
>> +			ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
>> +	}
> 
> This is obviously racy for the exact same reason that mac80211 doesn't
> give you averages ... you cannot do that.

I was thinking about that.  The ewma code is pretty simple and has some read_once
logic and on-stack variables.  So, since it is a running avg anyway, I did not see how it could race
and actually cause any significantly invalid result.

At any rate, in testing under load and otherwise, my patch gave expected results
that were more accurate than what I had before.  A 1 / billion chance of temporarily
bad RSSI avg report is fine trade-off for me if it keeps locking out of the hot rx path
and reports better values the other billion times it is read.

> 
> Without locking, you have to rely on the firmware, and I don't think we
> want any locking here.
> 
>> @@ -295,6 +307,15 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
>>   		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
>>   	rx_status->chain_signal[0] = energy_a;
>>   	rx_status->chain_signal[1] = energy_b;
>> +
>> +	if (mvmsta) {
>> +		if (is_beacon) {
>> +			if (my_beacon)
>> +				ewma_signal_add(&mvmsta->rx_avg_beacon_signal, -max_energy);
>> +		} else {
>> +			ewma_signal_add(&mvmsta->rx_avg_signal, -max_energy);
>> +		}
>> +	}
> 
> Why would you ignore "is_beacon && !my_beacon" cases, but handle all
> other management frames from everyone?

I want RSSI to report signal from the peer device (AP in STA mode).  Would the
driver actually receive any other mgt frames (aside from beacons) from non-peer transmitters at this
level of code?  I'm assuming we are not in monitor mode, as reporting RSSI in
that case doesn't make much sense anyway.

> 
>> @@ -1878,6 +1899,16 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
>>   		goto out;
>>   	}
>>   
>> +	is_beacon = ieee80211_is_beacon(hdr->frame_control);
>> +	if (is_beacon && sta) {
>> +		/* see if it is beacon destined for us */
>> +		if (memcmp(sta->addr, hdr->addr2, ETH_ALEN) == 0)
>> +			my_beacon = true;
> 
> don't use memcmp() for that.
> 
> 
> Anyway this really needs a lot of work, it cannot work as is.

Thanks for the comments.

--Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
