Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAE271A43
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 06:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIUE7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 00:59:36 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:45754 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbgIUE7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 00:59:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9E7424F9809;
        Mon, 21 Sep 2020 04:59:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6w7BuDKrXTPr; Mon, 21 Sep 2020 04:59:32 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id A6D064F9297;
        Mon, 21 Sep 2020 04:59:32 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 21:59:31 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 06/22] {cfg,mac}80211: get correct default channel
 width for S1G
In-Reply-To: <c5b93cd207ce780a56ad2689d7660fee48683fe9.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-7-thomas@adapt-ip.com>
 <c5b93cd207ce780a56ad2689d7660fee48683fe9.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <18730e757068a05f6531ea204791eae8@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:38, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> 
>> +++ b/net/wireless/chan.c
>> @@ -33,6 +33,16 @@ void cfg80211_chandef_create(struct 
>> cfg80211_chan_def *chandef,
>>  	chandef->edmg.bw_config = 0;
>>  	chandef->edmg.channels = 0;
>> 
>> +	/* S1G allows a single width per channel, and since chan_type seems 
>> to
>> +	 * be for backwards compatibility only, ignore it and return the per
>> +	 * frequency width.
>> +	 */
>> +	if (chan->band == NL80211_BAND_S1GHZ) {
>> +		chandef->width = ieee80211_s1g_channel_width(chan);
>> +		chandef->center_freq1 = chan->center_freq;
>> +		return;
>> +	}
> 
> Hmm. I'm not sure I want to let you get away with this?
> 
> It might be ... convenient, but it's also confusing to see something
> like
> 
> 	cfg80211_chandef_create(&out, some_channel, NL80211_CHAN_HT40PLUS);
> 
> actually create an S1G channel width?

Yes I agree that looks like it should be an error.

> Yes, this is mostly for backward compatibility, but it's also used in
> few (21 in the stack) places. Many of those aren't relevant, e.g. in
> net/mac80211/ibss.c it would obviously be clearer to handle the new
> NL80211_CHAN_WIDTH_* values with e.g. a cfg80211_get_s1g_chandef()
> function or so that does this derivation, instead of running into the
> 
>         default:
>                 /* fall back to 20 MHz for unsupported modes */
>                 cfg80211_chandef_create(&chandef, cbss->channel,
>                                         NL80211_CHAN_NO_HT);

Yes, but then what would we pass to cfg80211_chandef_create()? We should
probably avoid adding an additional NL80211_CHAN_S1G if enum
nl80211_channel_type is legacy.

It seems like NL80211_CHAN_NO_HT is often used as "give me the default
channel width".  See cfg80211_get_chandef_type() when it throws up its 
hands
and returns NL80211_CHAN_NO_HT when encountering an unknown 
chandef->width.
Also IBSS passes NL80211_CHAN_NO_HT when the BSS is actually 5 or 10MHz.

Maybe (instead of adding a new nl80211_channel_type)
cfg80211_chandef_create() throws a warning if anything but 
NL80211_CHAN_NO_HT
is passed with an S1G frequency?

> IOW, it seems to me that this function should actually instead throw a
> warning (and then perhaps configure something sane?), but not be the
> default code path.

Yes, but I'd also like to avoid making the caller worry about the value 
of a
parameter which only exists for HT reasons (?).

-- 
thomas
