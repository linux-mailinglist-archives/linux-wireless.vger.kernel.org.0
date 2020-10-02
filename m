Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0BC281D06
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBUjI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 16:39:08 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:55464 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgJBUjI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 16:39:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id D37394FA0E0;
        Fri,  2 Oct 2020 20:39:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sAQOFNHcOvsl; Fri,  2 Oct 2020 20:39:05 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D2C7C4FA0C5;
        Fri,  2 Oct 2020 20:39:04 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 02 Oct 2020 13:39:04 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] mac80211: handle lack of sband->bitrates in rates
In-Reply-To: <f8d1c99d-f678-309a-80fb-0f886d1531c8@candelatech.com>
References: <20201002175308.16374-1-thomas@adapt-ip.com>
 <f8d1c99d-f678-309a-80fb-0f886d1531c8@candelatech.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <58e16c9d04eb12fcd817027bde2b6769@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-02 11:55, Ben Greear wrote:
> On 10/2/20 10:53 AM, Thomas Pedersen wrote:
>> Even though a driver or mac80211 shouldn't produce a
>> legacy bitrate if sband->bitrates doesn't exist, don't
>> crash if that is the case either.
>> 
>> This fixes a kernel panic if station dump is run before
>> last_rate can be updated with a data frame when
>> sband->bitrates is missing (eg. in S1G bands).
>> 
>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>> ---
>>   net/mac80211/cfg.c      | 3 ++-
>>   net/mac80211/sta_info.c | 4 ++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>> index da70f174d629..e40160114824 100644
>> --- a/net/mac80211/cfg.c
>> +++ b/net/mac80211/cfg.c
>> @@ -709,7 +709,8 @@ void sta_set_rate_info_tx(struct sta_info *sta,
>>   		u16 brate;
>>     		sband = ieee80211_get_sband(sta->sdata);
>> -		if (sband) {
>> +		WARN_ON(sband && !sband->bitrates);
> 
> Maybe WARN_ON_ONCE to keep the spam down in case this is hit repeatedly
> for some reason?

Thanks, I originally had it as WARN_ON_ONCE(), then changed it. Not sure 
why,
I don't feel strongly about it either way :)

I'll make them both WARN_ON_ONCE().

> 
>> +		if (sband && sband->bitrates) {
>>   			brate = sband->bitrates[rate->idx].bitrate;
>>   			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
>>   		}
>> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
>> index f2840d1d95cf..0efb66b8f185 100644
>> --- a/net/mac80211/sta_info.c
>> +++ b/net/mac80211/sta_info.c
>> @@ -2122,6 +2122,10 @@ static void sta_stats_decode_rate(struct 
>> ieee80211_local *local, u32 rate,
>>   		int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);
>>     		sband = local->hw.wiphy->bands[band];
>> +
>> +		if (WARN_ON(!sband->bitrates))
>> +			break;
>> +
>>   		brate = sband->bitrates[rate_idx].bitrate;
>>   		if (rinfo->bw == RATE_INFO_BW_5)
>>   			shift = 2;
>> 

-- 
thomas
