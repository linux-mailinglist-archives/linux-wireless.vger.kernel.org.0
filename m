Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572B67BE61
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGaK2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:28:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbfGaK2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:28:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE7B060721; Wed, 31 Jul 2019 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564568922;
        bh=Hohr4y8oZKjtr+w8imCjvXreoghIOPTdQmGwNkT6eB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dOan4vPE6rmloHZV9oEP0RGZWY/GgGgGdgAtdooTlOkhp6T/Ctas9hdHzZrSjlzd/
         ZokiXtJxdNnT2n2pblFdtJ3S6wxq1VmSULKTMHc6JWXWuQgQKpAbqcucDBeVauSy9R
         XRlIf2j2+WLjdLK26F8iA6RoXQT2YVzQSmvXQqRw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9BF07601D3;
        Wed, 31 Jul 2019 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564568922;
        bh=Hohr4y8oZKjtr+w8imCjvXreoghIOPTdQmGwNkT6eB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dOan4vPE6rmloHZV9oEP0RGZWY/GgGgGdgAtdooTlOkhp6T/Ctas9hdHzZrSjlzd/
         ZokiXtJxdNnT2n2pblFdtJ3S6wxq1VmSULKTMHc6JWXWuQgQKpAbqcucDBeVauSy9R
         XRlIf2j2+WLjdLK26F8iA6RoXQT2YVzQSmvXQqRw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Jul 2019 15:58:42 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
In-Reply-To: <428fec1c2dd6f6d9345323f272eef423a214bc39.camel@sipsolutions.net>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
 <428fec1c2dd6f6d9345323f272eef423a214bc39.camel@sipsolutions.net>
Message-ID: <19a236986ca5c91c232769989f9d6950@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> 
>> + * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
>> + *	nested attribute with %NL80211_TID_ATTR_* sub-attributes.
> 
> Please use NL80211_TID_CONFIG_ATTR_* throughout, also for
> 
>> +/* enum nl80211_tid_attr_config - TID specific configuration.
> 
> the enum name
> 
>> +enum nl80211_tid_attr_config {
>> +	__NL80211_TID_ATTR_INVALID,
>> +	NL80211_TID_ATTR_CONFIG_TID,
>> +	NL80211_TID_ATTR_CONFIG_NOACK,
>> +
>> +	/* keep last */
>> +	__NL80211_TID_ATTR_CONFIG_AFTER_LAST,
>> +	NL80211_TID_ATTR_CONFIG_MAX = __NL80211_TID_ATTR_CONFIG_AFTER_LAST - 
>> 1
> 
> and all the things in it.
sure.
> Also, as you can see above, the kernel-doc comment isn't formatted
> right.
> 
sure, I will fix it.
> 
>> +	nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
>> +			    rem_conf) {
>> +		ret = nla_parse_nested_deprecated(attrs, 
>> NL80211_TID_ATTR_CONFIG_MAX,
>> +						  tid, NULL, NULL);
> 
> You shouldn't use _deprecated.
> 
Okay.
>> +		ret = parse_tid_conf(rdev, attrs,
>> +				     &tid_config->tid_conf[conf_idx],
>> +				     tid_config->peer);
> 
> and yeah, this should compile.
> 
My bad. Sorry about this. I will fix this in the next version.

Thanks,
Tamizh.
