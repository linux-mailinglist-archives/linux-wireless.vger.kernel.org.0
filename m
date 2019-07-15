Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79226895A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfGOMp1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 08:45:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfGOMp0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AF0461778; Mon, 15 Jul 2019 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563194725;
        bh=5ro4ix6SMvDbRoJMYAJMd+MA316+8J9xrgqnxiKcxPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BW11/0HHAEhXs5+g8vBxPvsKsMHA0XPLpoDj+WF+YxBjLsian4sw7IFcBgsmD1nBk
         3g2y7EnVVzINp5HfTK97/obYPH0+C0ipBYMEpRwOwjCJwB5udj0fxRD45p+rdCKcSG
         x3RbPp4eiev+5/CfDkpCl5RxhUEVx9vq4fLjNQkU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ED6D860769;
        Mon, 15 Jul 2019 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563194724;
        bh=5ro4ix6SMvDbRoJMYAJMd+MA316+8J9xrgqnxiKcxPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZrsCrvJ4A15w7ZRVO+oWITNF55pWWjtd4BZAOdSCZjvTBZ9hP+M+FKgSx+DbgO8iQ
         Iec2N5OMrwMwXgyyaVbERqCyrrzGZ3aAt/FOH9BmF8SVS8wmdfr5NXQ/ELURxU7p7S
         /0YESPTlM8qB3THBhfclLo4UAVLDNIn9J5n560NU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Jul 2019 15:45:23 +0300
From:   Alexei Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v4 1/2] nl80211: Add support for EDMG channels
In-Reply-To: <957f8c53224ff6479015519de39a49a6d127bff7.camel@sipsolutions.net>
References: <1562508727-17082-1-git-send-email-ailizaro@codeaurora.org>
 <1562508727-17082-2-git-send-email-ailizaro@codeaurora.org>
 <957f8c53224ff6479015519de39a49a6d127bff7.camel@sipsolutions.net>
Message-ID: <dcb4f42a00a827ed0b614b9cff5827f7@codeaurora.org>
X-Sender: ailizaro@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-12 11:35, Johannes Berg wrote:
> On Sun, 2019-07-07 at 17:12 +0300, Alexei Avshalom Lazar wrote:
>> 
>>  /**
>> + * struct ieee80211_edmg - EDMG configuration
>> + *
>> + * This structure describes most essential parameters needed
>> + * to describe 802.11ay EDMG configuration
>> + *
>> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
>> + *	that are allowed to be used for transmissions.
>> + *	Bit 0 indicates channel 1, bit 1 indicates channel 2, etc.
>> + *	Set to 0 indicate EDMG not supported.
>> + * @bw_config: Channel BW Configuration subfield encodes
>> + *	the allowed channel bandwidth configurations
>> + */
>> +struct ieee80211_edmg {
>> +	u8 channels;
>> +	u8 bw_config;
>> +};
> 
> So I think the enum here like I just said might be good. I don't know
> what to really the values in it, but having something that says "yes
> this is just a magic number from the spec" would be nice...

You are right, enum make more sense than hardcoded values, in addition
the description will help with the better understanding of the values.

> 
> Maybe also call it "struct ieee80211_edmg_chan" or something? Not sure,
> it's sort of covering both chan and cfg, so probably what you have is
> better.
> 
>> @@ -350,6 +369,7 @@ struct ieee80211_supported_band {
>>  	int n_bitrates;
>>  	struct ieee80211_sta_ht_cap ht_cap;
>>  	struct ieee80211_sta_vht_cap vht_cap;
>> +	struct ieee80211_edmg edmg_cap;
> 
> Yeah, I think if you have edmg_cap as the variable name, your naming is
> better :)
> 
>> + * @edmg: define the EDMG channels.
>> + *	This may specify multiple channels and bonding options for the 
>> driver
>> + *	to choose from, based on BSS configuration.
> 
> Here actually I don't understand how you'd specify *multiple* bonding
> options? The bw_config is an enum, right?
> 
> Or maybe this case should actually *not* be the same struct, but a
> different struct with a *bitmap* of the enum values?
> 
> But then it'd need a u16 anyway since the enum values go higher, up to
> 16 according to your code below:

In EDMG userspace can request connect with a configuration
(channels) that represents more than 1 option, as an outcome of AP
operating EDMG channels.
For example: Let's say userspace sees in the scan result that the AP
operating on CB3 (ChannelBonding X 3):
channels = 0x7 (channels 1,2,3)
bw_config = 6 (allow CB1, CB2 or CB3)
primary = 2
userspace then sends connection request with the same values
(assuming STA support this configuration).
The AP will decide the connection details, it can decide to operate
on CB2 (channels 1+2 or channels 2+3) or CB3 (channels 1+2+3).

Other option for this same scan result, but when the STA supports up to
CB2 (doesn't support CB3), userspace sends different connection request:
channels = 0x7 (channels 1,2,3)
bw_config = 5 (allow CB1 or CB2)
Again we have more than one option for connection but limited for 
bonding
up to 2 channels.

The general idea here is that the AP can choose what is the optimal
connection configuration for each STA, if 2 STA's able to connect on
CB2:
channels = 0x7 (channels 1,2,3)
bw_config = 5 (support CB1 or CB2)
The AP can choose to connect to one STA on CB2 channels 1+2 and to the
second STA with CB2 channels 2+3.

> 
>> +#define NL80211_EDMG_BW_CONFIG_MIN	4
>> +#define NL80211_EDMG_BW_CONFIG_MAX	15
> 
>> +static bool cfg80211_valid_60g_freq(u32 freq)
>> +{
>> +	return (freq >= 58320 && freq <= 70200);
> 
> nit: no need for the parentheses

Done.

> 
>> +static bool cfg80211_edmg_chandef_valid(const struct 
>> cfg80211_chan_def *chandef)
>> +{
>> +	int max_contiguous = 0;
>> +	int num_of_enabled = 0;
>> +	int contiguous = 0;
>> +	int i;
>> +
>> +	if (!chandef->edmg.channels && !chandef->edmg.bw_config)
>> +		return true;
>> +
>> +	if ((!chandef->edmg.channels && chandef->edmg.bw_config) ||
>> +	    (chandef->edmg.channels && !chandef->edmg.bw_config) ||
>> +	    !cfg80211_valid_60g_freq(chandef->chan->center_freq))
>> +		return false;
> 
> That's a bit hard to read, maybe pull out the valid_60g_freq into a
> separate if statement?
> 
> And after the "!channels && !bw_config" part, you don't actually need
> the whole condition that way, you just need
> 
> 	if (!channels || !bw_config)
> 		return false;
> 
> since both cannot be unset at this point.

Done.

> 
>> @@ -112,7 +206,7 @@ bool cfg80211_chandef_valid(const struct 
>> cfg80211_chan_def *chandef)
>>  		return false;
>>  	}
>> 
>> -	return true;
>> +	return cfg80211_edmg_chandef_valid(chandef);
> 
> 
> I *think* I might prefer the "could this be an EDMG channel" condition
> to be outside, i.e.
> 
> 	if ((chandef->edmg.channels || chandef->edmg.bw_config) &&
> 	    !cfg80211_edmg_chandef_valid(chandef))
> 		return false;
> 
> 	return true;
> 
> 
> That's clearly equivalent to what you have now, but I think it's easier
> to understand that we only enter the "edmg_chandef_valid()" when it
> looks like an EDMG channel and we thus need to validate it.

Agree, done.

> 
> I'd even go as far as saying that we should have an inline for it in
> cfg80211.h:
> 
> static inline bool cfg80211_chandef_is_edmg(...)
> {
> 	return chandef->edmg.channels || chandef->edmg.bw_config;
> }
> 
> and we use that in the code I wrote above, as well as other places that
> want to ask this question.

Done.

> 
> 
>> +	[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = { .type = NLA_U8 },
> 
> Since you say there are only 6 channels, this probably also has a lower
> bound of 1 (need to set at least one bit) and an upper bound of 63 (all
> lower 6 bits set)?

Actually the upper bound is 60, the Spec define that cannot be more than
4 bits "ON"
Updated the policy.

> 
> In any case, thanks for your work on this, and especially for your
> patience with me reviewing.
> 
> johannes

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a
Linux Foundation Collaborative Project
