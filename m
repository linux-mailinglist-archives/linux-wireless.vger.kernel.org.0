Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B456B1BECD2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD3ACe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 20:02:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20687 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgD3ACe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 20:02:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588204953; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6PGUCS98u711yAY1Z9NrOcIXGDI/Ahc9ZsTpR7krXxk=;
 b=bcHTwQjbQTjBNraQwXjB7FxTWxLDgGr3TSYK/YQx55Aar7IEraR9oA924GFgQ3nHVahsXLjr
 4h6licFAW+7KP85yhZrxr2ZnaQf5GwT5+aDXyuazutkUcB9WLEgHqoZaR65BXcBB4EkzWSrW
 3cv5cB2Vsw3mj9Hm+7nmc+k0Y5w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaa1592.7f04ae8ca538-smtp-out-n04;
 Thu, 30 Apr 2020 00:02:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97BABC433BA; Thu, 30 Apr 2020 00:02:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8BB8C433D2;
        Thu, 30 Apr 2020 00:02:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 17:02:24 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 02/10] cfg80211: validate 6 GHz chandef
In-Reply-To: <73a4e63e16bffb69cd9b62fd904b926dd5278fbf.camel@sipsolutions.net>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
 <1587768108-25248-3-git-send-email-rmanohar@codeaurora.org>
 <73a4e63e16bffb69cd9b62fd904b926dd5278fbf.camel@sipsolutions.net>
Message-ID: <f7fa5618844630a3315acad53765e5e5@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 07:26, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
>> 
>> +static inline bool
>> +cfg80211_chandef_is_6ghz(const struct cfg80211_chan_def *chandef)
>> +{
>> +	return (chandef->center_freq1 > 5940 && chandef->center_freq1 < 
>> 7105);
>> +}
> 
> Seems like this
> 
>> +++ b/net/wireless/chan.c
>> @@ -19,6 +19,29 @@ static bool cfg80211_valid_60g_freq(u32 freq)
>>  	return freq >= 58320 && freq <= 70200;
>>  }
>> 
>> +static bool cfg80211_is_6ghz_freq(u32 freq)
>> +{
>> +	return (freq > 5940 && freq < 7105);
>> +}
> 
> should use this, by also exposing it, or something.
> 
Sure. Export this and remove the above one.

>> +static enum nl80211_chan_width cfg80211_chan_to_bw_6ghz(u8 idx)
>> +{
>> +	/* channels: 1, 5, 9, 13... */
>> +	if ((idx & 0x3) == 0x1)
>> +		return NL80211_CHAN_WIDTH_20;
>> +	/* channels 3, 11, 19... */
>> +	if ((idx & 0x7) == 0x3)
>> +		return NL80211_CHAN_WIDTH_40;
>> +	/* channels 7, 23, 39.. */
>> +	if ((idx & 0xf) == 0x7)
>> +		return NL80211_CHAN_WIDTH_80;
>> +	/* channels 15, 47, 79...*/
>> +	if ((idx & 0x1f) == 0xf)
>> +		return NL80211_CHAN_WIDTH_160;
>> +
>> +	return NL80211_CHAN_WIDTH_20;
>> +}
> 
> We haven't really done that for anything else - is that really
> necessary?
> 
Hmm.. to check whether give center_freq1 chan_idx is allowed to operate 
in given bandwidth.
Similar to center_idx_to_bw_6ghz of hostapd, this API is used to chandef 
bw.

[...]
>> @@ -213,6 +255,10 @@ bool cfg80211_chandef_valid(const struct 
>> cfg80211_chan_def *chandef)
>>  	    !cfg80211_edmg_chandef_valid(chandef))
>>  		return false;
>> 
>> +	if (cfg80211_chandef_is_6ghz(chandef) &&
>> +	    !cfg80211_6ghz_chandef_valid(chandef))
>> +		return false;
> 
> You only get there if it was in range ...
> 
> Not sure about this whole patch, it seems a bit pointless?
> 

Don't we have to check chandef bw? If not, I will drop the change.

-Rajkumar
