Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBF19B4B0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgDARaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 13:30:09 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:41996 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgDARaJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 13:30:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5D2F34F7A8D;
        Wed,  1 Apr 2020 17:30:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ae_PDTdpw-I1; Wed,  1 Apr 2020 17:30:05 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 4B9C14F7A4E;
        Wed,  1 Apr 2020 17:30:05 +0000 (UTC)
Subject: Re: [RFC 2/7] cfg80211: express channels with a KHz component
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <20200401062150.3324-3-thomas@adapt-ip.com>
 <52850c8eb3131ca742eea30a21a7e685a3a3045b.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <69451a0a-4bca-36f8-4295-9a386585c244@adapt-ip.com>
Date:   Wed, 1 Apr 2020 10:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <52850c8eb3131ca742eea30a21a7e685a3a3045b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/31/20 11:54 PM, Johannes Berg wrote:
> On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
>>
>> +/**
>> + * ieee80211_get_channel_khz - get channel struct from wiphy for specified
>> + * frequency
> 
> You can't line-break there, but I think I learned a while back that you
> can do
> 
> /**
>  * ieee80211_get_channel_khz -
>  * get channel ...
> 
> or something like that. Maybe try?

Looks like it renders ok though:

---
.. c:function:: struct ieee80211_channel * ieee80211_get_channel (struct wiphy * wiphy, int freq)

   get channel struct from wiphy for specified frequency

**Parameters**

``struct wiphy * wiphy``
  the struct wiphy to get the channel for

``int freq``
  the center frequency (in MHz) of the channel
---

Documentation/doc-guide/kernel-doc.rst says:

The brief description following the function name may span multiple lines, and
ends with an argument description, a blank comment line, or the end of the
comment block.

>> +/**
>> + * ieee80211_chandef_to_khz - convert chandef to frequency in KHz
>> + *
>> + * @chandef: the chandef to convert
>> + *
>> + * Returns the center frequency of chandef (1st segment) in KHz.
>> + */
>> +u32 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef);
> 
> Isn't this one trivial, and probably better inlined (mhz*1000 + khz)?

Do you mean open code the conversion? I would prefer not to. If you
meant make it an inline function then yes probably.

>> +u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
>> +{
>> +	return __ieee80211_channel_to_frequency(chan, band);
>> +}
>> +EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
>> +
>> +int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
>> +{
>> +	return KHZ_TO_MHZ(__ieee80211_channel_to_frequency(chan, band));
>> +}
>>  EXPORT_SYMBOL(ieee80211_channel_to_frequency);
>>  
>> -int ieee80211_frequency_to_channel(int freq)
>> +u32 ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
>> +{
>> +	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
>> +}
>> +EXPORT_SYMBOL(ieee80211_channel_to_khz);
> 
> Some of these should probably be inlines? Or maybe all of them, and
> 
>> +static int __ieee80211_frequency_to_channel(u32 freq)
> 
> export the double-underscore helpers like this one instead? That'd still
> be less code overall, IMHO.

I didn't want to change the interface for
ieee80211_frequency_to_channel(). It's a little confusing that one takes
MHz, but the __ieee80211_frequency_to_channel() takes KHz? By giving the
_khz() hint in the wrapper we were trying to make it explicit. Similar
to below.

>> +int ieee80211_freq_khz_to_channel(u32 freq)
>> +{
>> +	return __ieee80211_frequency_to_channel(freq);
>> +}
>> +EXPORT_SYMBOL(ieee80211_freq_khz_to_channel);
>> +
>> +int ieee80211_frequency_to_channel(int freq)
>> +{
>> +	return __ieee80211_frequency_to_channel(MHZ_TO_KHZ(freq));
>> +}
>>  EXPORT_SYMBOL(ieee80211_frequency_to_channel);
> 
> similarly here, I guess.
> 
>> +struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
>> +						    u32 freq)
>> +{
>> +	return __ieee80211_get_channel(wiphy, freq);
>> +}
>> +EXPORT_SYMBOL(ieee80211_get_channel_khz);
>> +
>> +struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy,
>> +						int freq)
>> +{
>> +	return __ieee80211_get_channel(wiphy, MHZ_TO_KHZ(freq));
>> +}
>>  EXPORT_SYMBOL(ieee80211_get_channel);
> 
> And maybe here? In fact, how is __ieee80211_get_channel() even different
> from ieee80211_get_channel_khz()?

It's not. I thought the _khz() hint was helpful for the reader to keep
the units straight.

>> @@ -1670,6 +1716,12 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
>>  }
>>  EXPORT_SYMBOL(ieee80211_chandef_to_operating_class);
>>  
>> +u32 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef)
>> +{
>> +	return MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
>> +}
>> +EXPORT_SYMBOL(ieee80211_chandef_to_khz);
> 
> That's like I thought above.
> 
> I think that'd have less code overall, don't you think?

What do you think about keeping the interfaces in place, but otherwise
converting them to inline functions (where it makes sense)?

I'd like to avoid open coding the conversions and otherwise keep the
gory internals of the channel structures hidden from the caller.

-- 
thomas
