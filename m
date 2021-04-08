Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9E359016
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhDHXAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 19:00:47 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:51994 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHXAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 19:00:45 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6FB2B13C2B3;
        Thu,  8 Apr 2021 16:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6FB2B13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617922832;
        bh=GhkpKjH1TAl+8ec4Wv++8P2uy3TcIovSuGEk1LPj06k=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=UBLz2AAUm+6cdGl43y18Z3K11MD6NXYYQihJZZboB4uSSUq8PM14xcO64GEbur+Yw
         hDQdDw81s54uYIwuvnlVEVzcIEO1RVAp8WNYnvLHJSDXf4fPsTy6EHWyO8rZPj2GpT
         g8EaJIxGqB+pHZS05QcYyjVs9kna1Mmu7LE56isA=
Subject: Re: [PATCH] wireless: Allow disabling TWT
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20210306162010.16706-1-greearb@candelatech.com>
 <0b89f56b37073b633b343a71a098247a53ec89f9.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <3ce23e62-a9f7-013f-9eb7-578f5ca5c9dd@candelatech.com>
Date:   Thu, 8 Apr 2021 16:00:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0b89f56b37073b633b343a71a098247a53ec89f9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/8/21 6:25 AM, Johannes Berg wrote:
> On Sat, 2021-03-06 at 08:20 -0800, greearb@candelatech.com wrote:
>>
>> +	/* Apply overrides as needed. */
>> +	if (ifmgd->flags & IEEE80211_STA_DISABLE_TWT) {
>> +		if (ext_capa) {
>> +			if (ext_capa && ext_capa->datalen > 10) {
>> +				ext_capa->data[9] &= ~(WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT);
> 
> So apart from the useless code (checking "ext_capa" twice, unnecessary
> nested ifs, unnecessary parentheses), this can already be done entirely
> by userspace, since it controls the ext capa we send.

So we don't even need HE overrides in this case?

>>
>> -static bool ieee80211_twt_req_supported(const struct sta_info *sta,
>> +static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
>> +					const struct sta_info *sta,
>>   					const struct ieee802_11_elems *elems)
>>
> 
> This code here seems possibly wrong anyway since it doesn't take local
> capabilities into account, maybe it should, and then these changes
> wouldn't be necessary? >
>> +	/* Apply overrides as needed. */
>> +	if (ifmgd->flags & IEEE80211_STA_DISABLE_TWT) {
>> +		struct ieee80211_he_cap_elem *hec;
>> +		hec = (struct ieee80211_he_cap_elem *)(pos);
>> +		hec->mac_cap_info[0] &= ~(IEEE80211_HE_MAC_CAP0_TWT_REQ);
>> +		hec->mac_cap_info[0] &= ~(IEEE80211_HE_MAC_CAP0_TWT_RES);
>> +	}
> 
> Wait, we actually have TWT capability *twice*, once in HE and once in
> extended capabilities?! Fun.

Evidently, like maybe the spec was planning to add TWT to VHT or
something like that?

> 
> But for this shouldn't we have the more general "HE capability override"
> stuff that we have also for HT and VHT?

Maybe this can be done, but since TWT is in several different places, it
is going to be a pain to code up that way.

The way I see it, if we do go with overrides, the API is going to be pretty
tricky, basically passing a bunch of u8 around to represent different sets of IE
contents and their mask.  So I think it is cleaner to pass in specific flags such as 'disable-twt'.
Now, maybe those types of flags can be passed in as part of a nested netlink attribute
or a 'override-flags-1' u32 so that each time we add a new one it doesn't need to grow
the main netlink enum...

And, I'd still like to see a way to set station config
while it is still admin down, so that we have all of the desired local config overrides set
before we ever even start scanning...  That would be a better way to do overrides in
general in my opinion.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
