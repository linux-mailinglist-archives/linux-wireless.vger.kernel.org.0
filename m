Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C27769AF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHIUR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHIUR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 16:17:28 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4F910E0
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 13:17:28 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D7F86300073;
        Wed,  9 Aug 2023 20:17:25 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 303AD13C2B0;
        Wed,  9 Aug 2023 13:17:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 303AD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1691612245;
        bh=tR4b5rG5ty/z3c6pA8Ttplik4JulLtoc63Zeya4BVWI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=K6cQMaVlNl/rlfcA0gN8fiXAuPJkWWMNf5dnircgFn4h8quwKs0UZoOs5O9pYhywi
         W8hR/jJhmcDCivG8N/dqQ0dlSmAXOE7jxFNKscvx1w+OqtML5FeyPFBxhRP/74Zpyf
         n445opAP5kEmC5sxk1KLp7YUCxVg92Rf8cvS+No0=
Message-ID: <3dd0f26b-3c5b-8477-3cd4-5817b8c6c268@candelatech.com>
Date:   Wed, 9 Aug 2023 13:17:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] wifi: mac80211: add eht_capa debugfs field.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230519162324.1633120-1-greearb@candelatech.com>
 <1038a5fd7d658cc29d11a6eb8776255c50e8226c.camel@sipsolutions.net>
 <e81d4d8d-8076-00cc-cb72-8417dc8203ce@candelatech.com>
 <559120af6ed8cdfdee7eaa83531b35de2ce24a0f.camel@sipsolutions.net>
 <37a24557-2562-4891-e7ec-18b5527a54f0@candelatech.com>
 <d14e88a69c9ed48e46058299cf3136467ba6e054.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <d14e88a69c9ed48e46058299cf3136467ba6e054.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1691612246-xlQLGWFUseki
X-MDID-O: us5;at1;1691612246;xlQLGWFUseki;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/23 12:34, Johannes Berg wrote:
> On Wed, 2023-08-09 at 12:32 -0700, Ben Greear wrote:
>> On 6/14/23 13:08, Johannes Berg wrote:
>>> On Wed, 2023-06-14 at 09:39 -0700, Ben Greear wrote:
>>>> On 6/14/23 01:29, Johannes Berg wrote:
>>>>>
>>>>>> +	/* TODO:  Fix and re-add this.  It compiles in 6.4 but not against 'next'
>>>>>> +	 * according to the kernel build bot.
>>>>>> +	 * PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
>>>>>> +	 */
>>>>>>
>>>>>
>>>>> Well that's because the spec version was updated in wireless-next :)
>>>>>
>>>>> So please adjust according to the new fields there.
>>>>
>>>> It will be some time before I get a chance to revisit this.  If you can
>>>> accept as is, I'll fix the remaining bits when I move to 6.5 or whatever
>>>> mainline kernel has the updated spec.
>>>>
>>>
>>> Actually I think it was just this field, so maybe I can just take v1.
>>
>> After doing some more detailed testing, I notice that this capa logic is using
>> the AP's capability list, and is not showing lowest common features.  For instance,
>> a 2x2 STA radio shows as this when connected to 4x4 AP:
>>
>> ...
>> 		EHT bw <= 80 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
>> 		EHT bw <= 80 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
>> 		EHT bw <= 80 MHz, max NSS for MCS 12-13: Rx=4, Tx=4
>> 		EHT bw <= 160 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
>> 		EHT bw <= 160 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
>> 		EHT bw <= 160 MHz, max NSS for MCS 12-13: Rx=4, Tx=4
>> 		EHT bw <= 320 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
>> 		EHT bw <= 320 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
>> 		EHT bw <= 320 MHz, max NSS for MCS 12-13: Rx=4, Tx=4
>>
>> I would expect it to show Rx=2, Tx=2 in this case.
>>
>> Any opinions on how or whether to change this?  Do we already store a combined
>> capabilities list somewhere in mac80211 for EHT?
>>
> 
> We did this for HT and VHT, and then kind of stopped for HE because it
> got so asymmetric and complicated ... it ended up easier for drivers to
> do it because they have their own hardware limitations and all and know
> what they may or may not advertise, and mac80211 would have to do it
> _all_. Yeah, not ideal either. So dunno. I wouldn't mind the logic I
> guess and we could probably remove stuff from the drivers, but either
> we'd have to be really careful about what we do and don't handle, and
> probably check that against what drivers have, or handle everything
> which gets difficult.

Yeah, I'm not excited to write a large pile of new and mostly duplicated logic
just for better debugfs output.

The main thing I want out of this is current-negotiated-bandwidth and
current-negotiated-nss.  I can hack that in one way or another.

Another option:  If mac80211 already knows the STA's own capabilities, that could
be added to this debugfs file, and then user-space could deal with finding the
least common demoninator for that it cares about?  But does mac80211 even store
a precise capa list for the station's current association?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


