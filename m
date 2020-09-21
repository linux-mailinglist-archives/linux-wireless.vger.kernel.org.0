Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CB271A4A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 07:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUFGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 01:06:53 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:45856 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgIUFGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 01:06:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id BD50B4F9809;
        Mon, 21 Sep 2020 05:06:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7H1o3x3G7A67; Mon, 21 Sep 2020 05:06:50 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D14CC4F9297;
        Mon, 21 Sep 2020 05:06:49 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 22:06:49 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 07/22] mac80211: s1g: choose scanning width based on
 frequency
In-Reply-To: <43afe1ee1067d77aa6be5765e02f3cf0549c7c8f.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-8-thomas@adapt-ip.com>
 <43afe1ee1067d77aa6be5765e02f3cf0549c7c8f.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b9024051fc27cae56173eef488e503e3@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:40, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> An S1G BSS can beacon at either 1 or 2 MHz and the channel
>> width is unique to a given frequency. Ignore scan channel
>> width for now and use the allowed channel width.
>> 
>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>> ---
>>  net/mac80211/scan.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
>> index 5ac2785cdc7b..5002791fe165 100644
>> --- a/net/mac80211/scan.c
>> +++ b/net/mac80211/scan.c
>> @@ -905,6 +905,17 @@ static void 
>> ieee80211_scan_state_set_channel(struct ieee80211_local *local,
>>  	local->scan_chandef.center_freq1 = chan->center_freq;
>>  	local->scan_chandef.freq1_offset = chan->freq_offset;
>>  	local->scan_chandef.center_freq2 = 0;
>> +
>> +	/* For scanning on the S1G band, ignore scan_width (which is 
>> constant
>> +	 * across all channels) for now since channel width is specific to 
>> each
>> +	 * channel. Detect the required channel width here and likely 
>> revisit
>> +	 * later. Maybe scan_width could be used to build the channel scan 
>> list?
>> +	 */
>> +	if (chan->band == NL80211_BAND_S1GHZ) {
>> +		local->scan_chandef.width = ieee80211_s1g_channel_width(chan);
>> +		goto  set_channel;
>> +	}
> 
> nit: double space after 'goto'
> 
> but really I came to say that this probably changes then, if you don't
> convince me about the stuff in the previous patch review? :)
> 
> So I'm leaving this patch also for now - have applied 1-5 so far.

Thanks. I'm not really sure what else would make sense here? 
scan_req->scan_width is constant across all channels in 
scan_req->channels so for S1G we can either filter the scan_req channels 
list based on scan_width (kind of strange and unexpected), or deduce the 
correct chanenl width for each channel in the list and ignore scan_width 
(mostly correct). It seems like scan_width is currently only used for 
scanning at 5 or 10MHz anyway?

-- 
thomas
