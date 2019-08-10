Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60D388B2F
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 14:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJMGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 08:06:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJMGt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 08:06:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDA4660770; Sat, 10 Aug 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565438807;
        bh=Met/C+m7Iw2xBZHZk3vs+mDj3dNjzE5/kmxgi5wNi/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAp2UXyEGRoTNq6q3M+CD6VMaUqaDkR78mXMzOyjzcEq3kwDhz1vG2zdl3ehCVpv6
         2I6BLaqOJ78e/wsG0FKBeI2JjBvth5QwD52Ag3qYH9hZjYY4OyCMhFAZ0pyFzf+Ndw
         iT9TqFwi6vg2L9YgaxHgtK6Gpv1trFaLipuaa8LM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4738C60721;
        Sat, 10 Aug 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565438807;
        bh=Met/C+m7Iw2xBZHZk3vs+mDj3dNjzE5/kmxgi5wNi/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAp2UXyEGRoTNq6q3M+CD6VMaUqaDkR78mXMzOyjzcEq3kwDhz1vG2zdl3ehCVpv6
         2I6BLaqOJ78e/wsG0FKBeI2JjBvth5QwD52Ag3qYH9hZjYY4OyCMhFAZ0pyFzf+Ndw
         iT9TqFwi6vg2L9YgaxHgtK6Gpv1trFaLipuaa8LM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 10 Aug 2019 17:36:47 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv6 2/9] nl80211: Add new netlink attribute for TID
 speicific retry count
In-Reply-To: <6351a05f5c205db47740116b4bec5a6476317792.camel@sipsolutions.net>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-3-git-send-email-tamizhr@codeaurora.org>
 <6351a05f5c205db47740116b4bec5a6476317792.camel@sipsolutions.net>
Message-ID: <66f9219ed5bd03f96f23947c2bb6f990@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-31 14:54, Johannes Berg wrote:
> ^^ there's a typo in the subject
> 
I will fix it in next version.
>> @@ -3951,6 +3957,7 @@ enum wiphy_flags {
>>  	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
>>  	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
>>  	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
>> +	WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT	= BIT(25),
> 
> This is never used, so that doesn't make sense? You probably want to
> advertise the max_data_retry_count value contingent on this flag (*) in
> some attribute, so that userspace can also detect the presence/absence
> of the flag for the feature?
> 
> (*) doesn't really need to be contingent on the flag - could just be
> contingent on max_data_retry_count being non-zero and then you don't
> need the flag.
> 
Sure, I will remove this flag.

>> + * @NL80211_ATTR_MAX_RETRY_COUNT: The upper limit for the retry count
>> + *	configuration that the driver can accept.
>>   *
>>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>> @@ -2823,6 +2825,7 @@ enum nl80211_attrs {
>>  	NL80211_ATTR_TWT_RESPONDER,
>> 
>>  	NL80211_ATTR_TID_CONFIG,
>> +	NL80211_ATTR_MAX_RETRY_COUNT,
> 
> You already have the attribute, but again, aren't using it.
> 
I will use this in nl80211_get_wiphy to notify userspace.

>> + * @NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG: Driver supports per TID 
>> data retry
>> + *	count functionality.
>> + * @NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG: Driver supports STA 
>> specific
>> + *	data retry count functionality.
> 
> and if you have these you don't need the WIPHY_FLAG anyway?
> 
Sure.
>> +	[NL80211_TID_ATTR_CONFIG_RETRY] = { .type = NLA_FLAG },
>> +	[NL80211_TID_ATTR_CONFIG_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 0),
>> +	[NL80211_TID_ATTR_CONFIG_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 0),
> 
> min of 0 doesn't make sense, maybe you meant 1? otherwise just don't 
> set
> anything here.
> 
The min value changed to 0 from 1 as per the previous discussions, since 
this is a retry count and not a tx count.
Or Shall I remove this min value to avoid the confusion ?
> 
>> +					    "TID specific configuration not "
>> +					    "supported");
> 
> This applies to all the patches - please don't break strings across
> multiple lines, even if they cross 80 columns. Even checkpatch won't
> give you any warning on this.
> 
Yeah, sure.
>> +		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RETRY;
>> +		if (attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]) {
>> +			tid_conf->retry_short =
>> +			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]);
>> +			if (tid_conf->retry_short >
>> +					rdev->wiphy.max_data_retry_count)
>> +				return -EINVAL;
>> +		} else {
>> +			tid_conf->retry_short = -1;
>> +
> 
> I guess you should document that -1 means no changes? Not sure how the
> IEEE80211_TID_CONF_RETRY comes in, you're always setting it, so that's
> useless - better remove that and document that -1 means no changes?
> 
The value -1 is to notify the driver to use default value by removing 
peer specific retry count.

Thanks,
Tamizh.

