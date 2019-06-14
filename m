Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA94615E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfFNOqV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:46:21 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53976 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfFNOqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:46:21 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0F8F0D936;
        Fri, 14 Jun 2019 07:46:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0F8F0D936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1560523581;
        bh=7ugvpFXth1TzJ89/Q2vsDsEG0TM+E83fhskO6/nc8Wg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kdwFwGAbcvhcCa/APgHMLHRjRoMKAACQnxiv9p2J34Lyftl6Cp0hSJQOuFpxSVX2K
         b5eTitfDwj/honqyzYN/wo/xvCCWqTkFQg+KzxnuB7klqSNuUBnO8ecZJCwNhtAewl
         1iQZvQVQvSC6hNMxIEGgSENIq+A0QRzzdmAc7hwo=
Subject: Re: [PATCH-v3 1/2] wireless: Support assoc-at-ms timer in sta-info
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190415172123.6532-1-greearb@candelatech.com>
 <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <3ad69c55-2b88-a96b-d21e-99f4418466ee@candelatech.com>
Date:   Fri, 14 Jun 2019 07:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/19 6:38 AM, Johannes Berg wrote:
> On Mon, 2019-04-15 at 10:21 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Report time stamp of when sta became associated.
> 
> I guess that makes sense.
> 
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   include/net/cfg80211.h       | 2 ++
>>   include/uapi/linux/nl80211.h | 2 ++
>>   net/wireless/nl80211.c       | 1 +
>>   3 files changed, 5 insertions(+)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index f49eb1464b7a..a3ad78b9d9f4 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -1268,6 +1268,7 @@ struct cfg80211_tid_stats {
>>    *	indicate the relevant values in this struct for them
>>    * @connected_time: time(in secs) since a station is last connected
>>    * @inactive_time: time since last station activity (tx/rx) in milliseconds
>> + * @assoc_at_ms: time in ms of the last association
> 
> I think the "_at_ms" doesn't really make sense. "time in ms" also
> doesn't make sense as documentation. I think you need to say what should
> be assigned here.
> 
> Also, you're actually using ktime_get_real() for this, which again
> doesn't make much sense. For exposing an absolute time, I think we're
> better off with CLOCK_BOOTTIME like we use elsewhere:

The point of my patch was to allow 'iw' to return a more precise time
that the station has been associated, so I am not sure that BOOTIME is
a good thing to use for that?

Here are the pertinent parts of my iw patches:


diff --git a/station.c b/station.c
index 25cbbc3..e7738cc 100644
--- a/station.c
+++ b/station.c
@@ -314,6 +314,12 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
                 [NL80211_STA_INFO_ACK_SIGNAL_AVG] = { .type = NLA_U8 },
         };
         char *chain;
+       struct timeval now;
+       unsigned long long now_ms;
+
+       gettimeofday(&now, NULL);
+       now_ms = now.tv_sec * 1000;
+       now_ms += (now.tv_usec / 1000);

         nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
                   genlmsg_attrlen(gnlh, 0), NULL);
@@ -557,8 +563,11 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
         if (sinfo[NL80211_STA_INFO_CONNECTED_TIME])
                 printf("\n\tconnected time:\t%u seconds",
                         nla_get_u32(sinfo[NL80211_STA_INFO_CONNECTED_TIME]));
+       if (sinfo[NL80211_STA_INFO_ASSOC_AT_MS])
+               printf("\n\tassociated at:\t%llu ms",
+                        (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_MS]));

-       printf("\n");
+       printf("\n\tcurrent time:\t%llu ms\n", now_ms);
         return NL_SKIP;
  }


Thanks,
Ben

> 
>   * @boottime_ns: CLOCK_BOOTTIME timestamp the frame was received at, this is
>   *      needed only for beacons and probe responses that update the scan cache.
> 
> 
>> + * @NL80211_STA_INFO_ASSOC_AT_MS: Timestamp of last association
> 
> _ASSOC_TIMESTAMP or something would make more sense too as the attribute
> name, and clearly the documentation needs to spell out the semantics
> here too.
> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

