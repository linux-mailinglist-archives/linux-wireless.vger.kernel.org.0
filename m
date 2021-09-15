Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4B40BEB2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 06:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhIOEC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 00:02:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23565 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhIOEC2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 00:02:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631678470; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CtBfyVsrvDK1NgIZtGg8CEFSiwlgxiHn6b1r+pQg/zw=;
 b=ZFEQBbp1JgTkYB6xuufeEsONDRIhOkquzrYWC+xSkbZPkPLSKR8Pv888vCdEVzZJfYLgKzKD
 eO8Id/AR7ENKG4aSsE9/5oB9BeJkEhqp7BN/p4nZiYqCN0RBI0KIXe5ZbNBNg/gGF4q8S87D
 JEH5hL7DhUkpsVG6v5nUgBe3m0U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61416ffbd914b0518254cf53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Sep 2021 04:00:59
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B80DC4360D; Wed, 15 Sep 2021 04:00:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19F4DC4338F;
        Wed, 15 Sep 2021 04:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Sep 2021 21:00:27 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v11 1/4] nl80211: MBSSID and EMA support in AP mode
In-Reply-To: <46cbed48d41a7200cec3d7428abe7bc6746e14fe.camel@sipsolutions.net>
References: <20210715070745.5033-1-alokad@codeaurora.org>
 <20210715070745.5033-2-alokad@codeaurora.org>
 <46cbed48d41a7200cec3d7428abe7bc6746e14fe.camel@sipsolutions.net>
Message-ID: <a1d3ea130c11902bd772535eadd0ef47@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-17 03:33, Johannes Berg wrote:
> Hi,
> 
> I don't know if this issue was already present before, but it's
> certainly due to the locking changes I had made with the RTNL some time
> ago...
> 
>> +static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
>> +				       struct net_device *dev,
>> +				       struct nlattr *attrs,
>> +				       struct cfg80211_mbssid_config *config,
>> +				       u8 num_elems)
>> +{
>> +	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
>> +	struct net_device *tx_dev = dev;
> 
> Here tx_dev defaults to the dev, that's fine, it might be the
> transmitting interface.
> 
>> +	if (tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
>> +		tx_ifindex =
>> +			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]);
>> +
>> +		if (!config->index && tx_ifindex != dev->ifindex)
>> +			return -EINVAL;
>> +
>> +		tx_dev = __dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
> 
> Here you try to look up the other transmitting device, and use
> __dev_get_by_index() for that - but we don't hold any relevant lock
> here!
> 
> This is (only) called from nl80211_start_ap(), which doesn't hold the
> RTNL since commit a05829a7222e ("cfg80211: avoid holding the RTNL when
> calling the driver"):
> 
>         {
>                 .cmd = NL80211_CMD_START_AP,
>                 .validate = GENL_DONT_VALIDATE_STRICT | 
> GENL_DONT_VALIDATE_DUMP,
>                 .flags = GENL_UNS_ADMIN_PERM,
>                 .doit = nl80211_start_ap,
> -               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> -                                 NL80211_FLAG_NEED_RTNL,
> +               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
>         },
> 
> 
> I'd fix this, but it's not really trivial - we'd need to use
> dev_get_by_index() and ensure we dev_put() appropriately, but *only* if
> it's different from the original dev ... could probably do that in this
> function.
> 
> All told though this doesn't make me really very confident you tested
> this recently, seems like something would've complained here?
> 

I tested a flavored version, testing without that this time.

Other instances of calls to __dev_get_by_index() which don't already 
hold
RTNL explicitly call rtnl_lock()/unlock().

Is it okay to do same here?

Regarding the reference, I will call dev_hold() before assigning the 
value
to 'tx_dev' pointer if different than the current net_device,
and dev_put() after the processing is done.

Thanks.
