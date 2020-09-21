Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898B271A55
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 07:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIUFNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 01:13:01 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:45988 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgIUFNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 01:13:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 973B04F9B64;
        Mon, 21 Sep 2020 05:13:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T-yp0UyaMhTn; Mon, 21 Sep 2020 05:12:58 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D794D4F9809;
        Mon, 21 Sep 2020 05:12:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 22:12:57 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 11/22] cfg80211: parse S1G Operation element for BSS
 channel
In-Reply-To: <c0d5ddf778f4e8814195b6982275577a8803433f.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-12-thomas@adapt-ip.com>
 <c0d5ddf778f4e8814195b6982275577a8803433f.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <ef2b1e8b8b2755793a8db2b00e4130a7@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:45, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> Extract the BSS primary channel from the S1G Operation
>> element.
> 
> Out of curiosity, do you even need to?
> 
> I mean ... you know what channel you received it on, surely?

Consider the case where the BSS is operating @ 2Mhz, but primary is one 
of
the 1Mhz channels. The hardware (or driver) may not be able to tell you
exactly which primary channel (upper or lower) the packet came in on.

>> @@ -1318,15 +1318,26 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, 
>> const u8 *ie, size_t ielen,
>>  	tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
>>  	if (tmp && tmp[1] == 1) {
>>  		channel_number = tmp[2];
>> -	} else {
>> -		tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
>> -		if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
>> -			struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
>> +		goto found_channel;
>> +	}
>> 
>> -			channel_number = htop->primary_chan;
>> -		}
>> +	tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
>> +	if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
>> +		struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
>> +
>> +		channel_number = htop->primary_chan;
>> +		goto found_channel;
>> +	}
>> +
>> +	tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
>> +	if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
>> +		struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
>> +
>> +		channel_number = s1gop->primary_ch;
>> +		goto found_channel;
>>  	}
> 
> I *am* a bit worried about this though - do you really want to try to
> parse DS elements on S1G, or S1G elements on other bands? Seems like
> there ought to be a band check here?

OK. I'll rework this to handle garbage input a little better.

-- 
thomas
