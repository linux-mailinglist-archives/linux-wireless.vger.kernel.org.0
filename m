Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45A307C1
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 06:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaEd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 00:33:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaEd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 00:33:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0172260850; Fri, 31 May 2019 04:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559277236;
        bh=qXlhARbJSh/xw9a52/AzsnLYQECZHrxof4Z5a1NWRBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dpiIM7wDlc5Z43C2nNhvM6Q7kcoyNPzyQTkCiA6Ga5CNid2uNKof2jxIxA8vx6hLF
         u4meWGp4rF4nl8thcjyt2hTrzFnR2YG6gevyfRakrG4TAzTcamU80bvQWXxsRf2k2v
         C0TJL+p0mWU8D3+jAdn5SHeXjnQMqvFd6bXtxRqQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.201.26.44] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D29686028C;
        Fri, 31 May 2019 04:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559277235;
        bh=qXlhARbJSh/xw9a52/AzsnLYQECZHrxof4Z5a1NWRBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cbmEQgroXwjYsNNl86HKMLcGr3eVjy9zjq8NRKWV8UfcOAfWO1X8f/cs9BDIrYeJH
         Ml9FstSZ9Kxgt+x8UCgdg7MxsnIZYHwyn9UbdJW9Zc05tb04uBpb8tKLlF+Ohr8Xx/
         0fI9a2E8+9vXRdezmgLHLVqgdxcTbRnMXyyu8zBs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D29686028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
 <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
Message-ID: <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
Date:   Fri, 31 May 2019 10:03:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/14/2019 2:08 PM, Johannes Berg wrote:
> On Wed, 2019-05-08 at 14:55 +0530, Manikanta Pubbisetty wrote:
>> +++ b/net/mac80211/util.c
>> @@ -3795,7 +3795,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>>   	}
>>   
>>   	/* Always allow software iftypes */
>> -	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
>> +	if (local->hw.wiphy->software_iftypes & BIT(iftype) ||
>> +	    (iftype == NL80211_IFTYPE_AP_VLAN &&
>> +	     local->hw.wiphy->flags & WIPHY_FLAG_4ADDR_AP)) {
>>   		if (radar_detect)
>>   			return -EINVAL;
> Shouldn't this check if 4addr is actually enabled too, like here:


Sure Johannes, I'll look into it.


>>   	case NETDEV_PRE_UP:
>> -		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)))
>> +		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)) &&
>> +		    !(wdev->iftype == NL80211_IFTYPE_AP_VLAN &&
>> +		      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP &&
>> +		      wdev->use_4addr))
>>   			return notifier_from_errno(-EOPNOTSUPP);
> ?
> Or is there some reason it doesn't matter?
>
>> @@ -3439,6 +3438,11 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
>>   			return err;
>>   	}
>>   
>> +	if (!(rdev->wiphy.interface_modes & (1 << type)) &&
>> +	    !(type == NL80211_IFTYPE_AP_VLAN && params.use_4addr &&
>> +	      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP))
>> +		return -EOPNOTSUPP;
>> +
> I also wonder if we shouldn't go "all in" and actually make the check
> something like
>
>    check_interface_allowed(iftype, 4addr):
>      if (iftype == AP_VLAN && 4addr)
>        return wiphy.flags & WIPHY_FLAG_4ADDR_AP;
>
>      else return wiphy.interface_modes & BIT(iftype);
>
> i.e. make it "you must have WIPHY_FLAG_4ADDR_AP to use 4-addr AP_VLAN
> interfaces", rather than "also allow it in this case".
>
> That would seem like the clearer semantics to me?


Yeah, it can be better; I'll check if this is feasible.


Thanks,

Manikanta

