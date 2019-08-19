Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19895052
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfHSV6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 17:58:15 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:52533 "EHLO
        3.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfHSV6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 17:58:14 -0400
Received: from player756.ha.ovh.net (unknown [10.109.146.1])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 05B7413FDD4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 22:42:19 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id 9A215822A27A;
        Mon, 19 Aug 2019 20:42:16 +0000 (UTC)
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566247335;
        bh=JkJmf0f2qQYAH/UTva6yNj+o3ifCd17XHjteBcOJwyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=tF59v52XJxF8c1aIG9nhEaEToJwKxoUkQGJFOVFpNTPMhpaEuAZKzIREf0m4pKN2O
         XnFnZN++gvUqSmKubQFMtIlG5Q0J7affa4z+FA79DzqwC7xi3oMsb7dQvFS2BfwbnP
         l2/jMhAKlXIN5KNbTQMJYpN3V6eYL4OnlpvQgKHY=
To:     Johannes Berg <johannes@sipsolutions.net>, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
References: <20190819180540.2855-1-alexander@wetzel-home.de>
 <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
 <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
 <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <ae57dab8-a6c2-c0a5-194b-27cef4c55e16@wetzel-home.de>
Date:   Mon, 19 Aug 2019 22:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 696650569209158856
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Am 19.08.19 um 22:03 schrieb Johannes Berg:
> On Mon, 2019-08-19 at 21:57 +0200, Alexander Wetzel wrote:
>>>> +
>>>> +	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
>>>> +	 * the hw, preventing us to control which key(id) to use per MPDU.
>>>> +	 * Till that's fixed we can't use Extended Key ID for the newer cards.
>>>
>>> Technically we still don't need per MPDU, we just need to switch which
>>> one to use for TX after installing it for RX already.
>>
>> The Extended Key ID API we finally merged in mac80211 is not notifying
>> the driver when to switch the key over to the other id.
> 
> Oh, right, good point.
> 
>> The current API provides the key/keyid per MPDU and let's mac80211 have
>> the full control what's the correct key for each frame.
> 
> Yeah, but as you noticed we no longer have that control per MPDU with
> the new TX API in iwlmvm.
> 
>> That's especially critical for drivers setting
>> IEEE80211_KEY_FLAG_GENERATE_IV and/or supporting A-MPDU's. Allowing the
>> driver to override the mac80211 decision is only safe when the
>> driver/card generates the PNs itself and also handles the A-MPDU key
>> borders correctly.
> 
> Sure, the device does generate the PN itself now with the new TX API
> too. It doesn't care about A-MPDU key borders, but it probably could
> when taught to care about extended key ID.
> 
>> While less desirable we still could get that working: The mvm driver
>> would have to detect the key borders and then tell the firmware to
>> switch over to the other key. But we would have to make sure to not
>> re-enable A-MPDU aggregation till the card really has switched.
> 
> I'm not entirely sure off the top of my head how it works, but it seems
> possible that if we just assign a new PN to retransmits of the same
> frame but in a new A-MPDU after key switching, it wouldn't actually
> matter?

I was thinking about mac80211 re-enabling A-MPDU aggregation but the 
driver still using the old key for some frames and then switching to the 
new key within one A-MPDU, causing non-compliant A-MPDUs.

> But then again maybe somewhere it's stated that we must use the same key
> for all transmit attempts of a single frame? Not sure.

I know of course next to nothing how the hardware/firmware is handling 
that, but I'm surprised this could be a problem. I assumed the card 
would create a full MPDU (with the crypto headers) and use that for 
retransmit and not create the MPDU new... After all you still have to 
use the old PN and getting that right sounds tricky when you don't have 
the full MPDU cached somehow. But I guess the high bandwidth and the 
required buffer space forced you to extreme measures to conserve space...

> 
> I'm also not sure if we could actually assign a PN from the new key for
> the retransmit, the hardware has to store those back into memory
> normally.
> 
> So probably you're right, and we'd have to disable A-MPDUs until we have
> no outstanding old-key-retransmits, but that seems manageable.

Extending the A-MPDU block mac80211 is using to enforce the A-MPDU key 
borders should be not very hard. Figuring out the time when we safely 
can restart it - when re-transmits indeed are also an issue - I'm less 
sure about. I believe re-transmits are handled by the card and not the 
driver but so far had no reason to dig deeper into that topic. But I 
guess a call to switch over the keyid which blocks till that is done 
should take care of it.

Alexander

Alexander
