Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBFFC0A7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 08:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKNHUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 02:20:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfKNHUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 02:20:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F5F060B6E; Thu, 14 Nov 2019 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573716003;
        bh=yXtMsCFZj64lkn19kFfvFiXQi6xby875799XxjE2Wto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=noLak5ZZWTTXdC94rTP96QLYWKIDdyJSnXXu4L6jwGq4rIwQbwGzQ6rNVLkzj4cBJ
         CW8xM85FQVNlCgQZOE41jd5vbBBliVLmV1h1BgygqcFKXoVimKvjOM2kUhqXst8vIS
         8oausrKfja6nqbQfao/kyCY03uURQZ9d4EhUhTTE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E02F160AE0;
        Thu, 14 Nov 2019 07:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573716002;
        bh=yXtMsCFZj64lkn19kFfvFiXQi6xby875799XxjE2Wto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PU5GagHH8rJL+MIWJamV/fBpgQ+NRIoEjSQULfxJDnN9x7I3ny2C8oWNzfqyeStAk
         DE54I04CKSkZX2U/qz2qc4Y213VU/r8VnfBk6zOXglfYD9t5vOUzkDhOMcB3ilbdns
         Q6KQOFUQZfXaBL7EV0Hvey5geO+mxAsfRE+GgEGk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 12:50:02 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCHv8 2/6] nl80211: Add new netlink attribute for TID
 speicific retry count
In-Reply-To: <03dc8fd244558b6c08875be0b497a6d3bdf595c8.camel@sipsolutions.net>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <1572957714-16085-3-git-send-email-tamizhr@codeaurora.org>
 <03dc8fd244558b6c08875be0b497a6d3bdf595c8.camel@sipsolutions.net>
Message-ID: <7a1ad257f052f4218bb4bdc37f4cb90f@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-08 15:30, Johannes Berg wrote:
>> + *	Station specific retry configuration is valid only for STA's
>> + *	current connection. i.e. the configuration will be reset to 
>> default when
>> + *	the station connects back after disconnection/roaming.
>> + *	when user-space does not include %NL80211_ATTR_MAC, this 
>> configuration
>> + *	should be treated as per-netdev configuration. This configuration 
>> will
>> + *	be cleared when the interface goes down and on the disconnection 
>> from a
>> + *	BSS. When retry count has never been configured using this 
>> command, the
>> + *	other available radio level retry configuration
>> + *	(%NL80211_ATTR_WIPHY_RETRY_SHORT and 
>> %NL80211_ATTR_WIPHY_RETRY_LONG)
>> + *	should be used. Driver supporting this feature should advertise
>> + *	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG and supporting per 
>> station
>> + *	retry count configuration should advertise
>> + *	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG.
> 
> Here you pretty much copy-pasted all this text ... that's why I think 
> it
> should be in some other section. We want *everything* to be like that,
> not have to check every single thing for different validity rules.
> 
Sure, I will add these things in DOC: section.

>> + * @NL80211_TID_CONFIG_ATTR_RETRY_SHORT: Number of retries used with 
>> data frame
>> + *	transmission, user-space sets this configuration in
>> + *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
>> + *	the max value should be advertised by the driver through
>> + *	max_data_retry_count. when this attribute is not present, the 
>> driver
>> + *	would use the default configuration.
>> + * @NL80211_TID_CONFIG_ATTR_RETRY_LONG: Number of retries used with 
>> data frame
>> + *	transmission, user-space sets this configuration in
>> + *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
>> + *	the max value should be advertised by the driver through
>> + *	max_data_retry_count. when this attribute is not present, the 
>> driver
>> + *	would use the default configuration.
> 
> I'm almost thinking that these should be a struct with two u8 values
> instead of two separate attributes, and then renamed to
> NL80211_TID_CONFIG_ATTR_RETRY, to carry both and really ensure thaty
> they're always together as a single configuration.
> 
This will make mandatory for user to send both values know ? I have did 
it similar to
NL80211_ATTR_WIPHY_RETRY_SHORT and NL80211_ATTR_WIPHY_RETRY_LONG. This 
way we can have
option to configure single parameter know ?

> This only really works right if we go for the reset= approach I 
> outlined
> in the previous patch though, since you otherwise need
> NL80211_TID_CONFIG_ATTR_RETRY for the reset ... but that's a pretty
> weird thing.
> 
> (there are also some typos here like "notfiy")
> 
I will fix this.

>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
>> @@ -326,6 +326,9 @@ static int validate_ie_attr(const struct nlattr 
>> *attr,
>>  	[NL80211_TID_CONFIG_ATTR_TID] = { .type = NLA_U8 },
>>  	[NL80211_TID_CONFIG_ATTR_NOACK] =
>>  			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
>> +	[NL80211_TID_CONFIG_ATTR_RETRY] = { .type = NLA_FLAG },
>> +	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = { .type = NLA_U8},
>> +	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},
> 
> The min value of 1 should be reflected in the policy.
> 
Yeah, It was there in the previous patchset and removed due to 
confusion.
Do you want to keep MIN value of 1 policy ?

>> +		if (rdev->wiphy.max_data_retry_count) {
>> +			if (nla_put_u8(msg, NL80211_ATTR_MAX_RETRY_COUNT,
>> +			    rdev->wiphy.max_data_retry_count))
> 
> bad indentation
I will fix this.
> 
>> +				goto nla_put_failure;
>> +		}
>> +
>>  		state->split_start++;
>>  		if (state->split)
>>  			break;
> 
> Also not sure which section you put this in, but it looks almost like
> it's under "case 1:" where it really shouldn't be ... move it to the 
> end
> please.
> 
Sure.

Thanks,
Tamizh.
