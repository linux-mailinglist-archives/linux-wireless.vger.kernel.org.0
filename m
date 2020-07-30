Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA523326A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG3MwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:52:09 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53574 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3MwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:52:09 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0C08013C2B0;
        Thu, 30 Jul 2020 05:52:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0C08013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596113528;
        bh=YD0ml/DrnFJAA5185UgsiaEjNg/14S8YGWdEnFURXIs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FgRd0jPjwI69wU/ClJ9L7qXOYXTgONMbfdTTtn7x6aWaSK7YjwSpX4NYgedfZQzwD
         aD2c1FCL7twISY6YcMBDTInQAIddFPEd/uVEgkcmWs7j8qeoqyKMxHVmKaiwelv8S3
         BJxxJTaoWb3iiyxvL95B91rdl4skmRd9Rsclzhf0=
Subject: Re: [PATCH] mac80211: Fix kernel hang on ax200 firmware crash.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200610204017.4531-1-greearb@candelatech.com>
 <62c74ddba571af59b2aeba116ff78ecc3b9b9710.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <fffa6cc5-99b6-f598-e20f-b30270ecd04c@candelatech.com>
Date:   Thu, 30 Jul 2020 05:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <62c74ddba571af59b2aeba116ff78ecc3b9b9710.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 5:33 AM, Johannes Berg wrote:
> On Wed, 2020-06-10 at 13:40 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> I backported out-of-tree ax200 driver from backport-iwlwifi to my
>> 5.4 kernel so that I could run ax200 beside other radios (backports
>> mac80211 otherwise is incompatible and other drivers will crash).
>>
>> Always possible that upstream kernel doesn't suffer from exactly this
>> case, but upstream ax200 is too unstable to even get this far, so...
>>
>> The ax200 firmware crash often causes the kernel to deadlock due to the
>> while (sta->sta_state == IEEE80211_STA_AUTHORIZED)
>> loop in __sta_info_Destroy_part.  If sta_info_move_state does not
>> make progress, then it will loop forever.  In my case, sta_info_move_state
>> fails due to the sdata-in-driver check.
> 
> Interesting. I don't think I've seen this in our testing before.

So, put a few ax200 NICs (two is plenty) in a system and run any significant
upload.  It crashes FW in < 1 minute on stock 5.7, like completely and utterly
unstable.  The out-of-tree backports ax200 (which is what I was actually using here)
is a bit better, closer to 5.2 kernel ax200 stability,
but still crashes reliably on upload traffic with 2+ radios
in a chassis.  It will crash on download too, but less often.

If you actually test this and have any trouble reproducing problems, please
let me know.

The firmware hard crash that causes ax200 phy to go away and cause the
sdata-in-driver / EIO busy spin is a bit harder to reproduce, but certainly
it happens often enough.

> 
>> iwlwifi 0000:12:00.0: dma_pool_destroy iwlwifi:bc, 00000000d859bd4c busy
> 
> Ugh, yeah, as an aside - we still leak stuff there... need to dig into
> that.
> 
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   net/mac80211/sta_info.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
>> index e2a04fc..31a3856 100644
>> --- a/net/mac80211/sta_info.c
>> +++ b/net/mac80211/sta_info.c
>> @@ -1092,6 +1092,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
>>   	struct ieee80211_sub_if_data *sdata = sta->sdata;
>>   	struct station_info *sinfo;
>>   	int ret;
>> +	int count = 0;
>>   
>>   	/*
>>   	 * NOTE: This assumes at least synchronize_net() was done
>> @@ -1104,6 +1105,13 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
>>   	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
>>   		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
>>   		WARN_ON_ONCE(ret);
>> +		if (++count > 1000) {
>> +			/* WTF, bail out so that at least we don't hang the system. */
>> +			sdata_err(sdata, "Could not move state after 1000 tries, ret: %d  state: %d\n",
>> +				  ret, sta->sta_state);
>> +			WARN_ON_ONCE(1);
>> +			break;
>> +		}
> 
> I guess that should be
> 
> if (WARN_ON_ONCE()) ...

If we spin 1000 times, it is worth a second warning.  Or do you mean the WARN_ON_ONCE(ret) should have if in front of it?

> 
> 
> etc.
> 
>>   		int err = drv_sta_state(sta->local, sta->sdata, sta,
>>   					sta->sta_state, new_state);
>> -		if (err)
>> -			return err;
>> +		if (err == -EIO) {
>> +			/* Sdata-not-in-driver, we are out of sync, but probably
>> +			 * best to carry on instead of bailing here, at least maybe
>> +			 * we can clean this up.
>> +			 */
> 
> It _could_ be the driver itself returning -EIO, so why not check the
> sdata-in-driver flag?

Right, but if driver is complaining here, we need to bail out regardless of
sdata-in-driver or not, unless you think a driver could return EIO and then
a small bit later start working for the same request?

> 
> 
> Anyway, that mostly looks good and would make mac80211 more robust, but
> like I just said in the other patch I think you need to consider
> mac80211 changes more from mac80211's POV, not from an arbitrary
> driver's POV.
> 
> Really here that mostly applies to the commit log, which should probably
> say something like
> 
> 	mac80211: deadlock due to driver misbehaviour
> 
> or so, and then go on to explain what it does in *mac80211*, and show
> the iwlwifi parts only as an *example*.

Its not really driver mis-behaviour per se.  The root cause is that the
firmware crashes too badly for the driver to recover (ok, so driver might
could be better, but I've also seen cases where ath10k NIC falls off the PCI
bus, so nothing the driver can do in that case I think).

Per my other patches, I've seen this sdata-in-driver crap in the past, so
I think I probably hit a similar bug in both ax200 and ath10k, but since
ax200 is so easy to crash, it is much more likely to hit this bug than any
other driver I'm aware of.

I'll try to re-word the commit message though, I don't really care what it
says so long as the code gets in.

Thanks,
Ben

> 
> Thanks,
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
