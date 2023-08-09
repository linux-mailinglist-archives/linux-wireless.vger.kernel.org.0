Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64DD7768C5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHITcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 15:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjHITcX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 15:32:23 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F81718
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 12:32:22 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A01E0500070;
        Wed,  9 Aug 2023 19:32:20 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1180D13C2B0;
        Wed,  9 Aug 2023 12:32:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1180D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1691609540;
        bh=UGa4IUDCn/xpeh1rMNBmRkCgIDvqgBgPKpcxXi+/kW0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JlPTPF+392X4Meax640zYQpnBvA5dhSd5J7m5dugnNCqOiwBpHIwtxO7fLNSH655Y
         /CPGtTNg/AxNIs+95pkNi8zNr2rdRu75W2TRAy9l5k3IRk7uadUPFMBnZbqO8oGrqi
         ark995VBV3KwlNzKOCHebJ86omG06DZO4P7pgPDU=
Message-ID: <37a24557-2562-4891-e7ec-18b5527a54f0@candelatech.com>
Date:   Wed, 9 Aug 2023 12:32:19 -0700
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
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <559120af6ed8cdfdee7eaa83531b35de2ce24a0f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1691609541-108yY6ieToIE
X-MDID-O: us5;ut7;1691609541;108yY6ieToIE;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/23 13:08, Johannes Berg wrote:
> On Wed, 2023-06-14 at 09:39 -0700, Ben Greear wrote:
>> On 6/14/23 01:29, Johannes Berg wrote:
>>>
>>>> +	/* TODO:  Fix and re-add this.  It compiles in 6.4 but not against 'next'
>>>> +	 * according to the kernel build bot.
>>>> +	 * PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
>>>> +	 */
>>>>
>>>
>>> Well that's because the spec version was updated in wireless-next :)
>>>
>>> So please adjust according to the new fields there.
>>
>> It will be some time before I get a chance to revisit this.  If you can
>> accept as is, I'll fix the remaining bits when I move to 6.5 or whatever
>> mainline kernel has the updated spec.
>>
> 
> Actually I think it was just this field, so maybe I can just take v1.

After doing some more detailed testing, I notice that this capa logic is using
the AP's capability list, and is not showing lowest common features.  For instance,
a 2x2 STA radio shows as this when connected to 4x4 AP:

...
		EHT bw <= 80 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
		EHT bw <= 80 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
		EHT bw <= 80 MHz, max NSS for MCS 12-13: Rx=4, Tx=4
		EHT bw <= 160 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
		EHT bw <= 160 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
		EHT bw <= 160 MHz, max NSS for MCS 12-13: Rx=4, Tx=4
		EHT bw <= 320 MHz, max NSS for MCS 8-9: Rx=4, Tx=4
		EHT bw <= 320 MHz, max NSS for MCS 10-11: Rx=4, Tx=4
		EHT bw <= 320 MHz, max NSS for MCS 12-13: Rx=4, Tx=4

I would expect it to show Rx=2, Tx=2 in this case.

Any opinions on how or whether to change this?  Do we already store a combined
capabilities list somewhere in mac80211 for EHT?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


