Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885B1BECD3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 02:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD3AE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 20:04:59 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26101 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgD3AE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 20:04:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588205098; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LKLvZl1W2c76IG+Ptj58OeovO22+RzQ8ywtT07WK0k4=;
 b=irfHRTgBB4PeRMQ9l42UnCrIvn1UXQ+KK96DcmZPg6bnmAIwbmktz1RgL1j4sglqWTJ8+xoU
 BAEi2pHw5mNS/f2WH0eUlEKY8nnzNCWOX12LloPi/2BjO6magiiuuqq/Lr+DHHUzZntUD2Lu
 Ojk7jXbdb9F0k7ScEXEPMP0FIRI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaa1624.7f3d250350a0-smtp-out-n03;
 Thu, 30 Apr 2020 00:04:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCAC6C433D2; Thu, 30 Apr 2020 00:04:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3933C433CB;
        Thu, 30 Apr 2020 00:04:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 17:04:51 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 03/10] nl80211: add HE 6 GHz Band Capability support
In-Reply-To: <56500fd2b7c6b54e904567ba27171542027f2aea.camel@sipsolutions.net>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
 <1587768108-25248-4-git-send-email-rmanohar@codeaurora.org>
 <56500fd2b7c6b54e904567ba27171542027f2aea.camel@sipsolutions.net>
Message-ID: <92e6776c460982184b3d8077a4a3cc1a@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 07:28, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
>> Define new structures for HE 6 GHz band capabilities as per
> 
> per?
> 
Oops.. My bad. Accidentally removed the commit log.

>>  include/linux/ieee80211.h    | 57 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  include/net/cfg80211.h       |  2 ++
>>  include/uapi/linux/nl80211.h |  6 +++++
>>  net/wireless/nl80211.c       | 14 +++++++++++
> 
> This is a bit mixed up, I'd prefer the raw ieee80211.h definitions in a
> separate patch.
> 
Sure.

>> +	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
>> +		.type = NLA_EXACT_LEN_WARN,
>> +		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
>> +	},
> 
> Shouldn't use _WARN for a new attribute. Just reject it if userspace
> gets it wrong.
> 
Done. :)

>> @@ -6177,6 +6185,12 @@ static int nl80211_new_station(struct sk_buff 
>> *skb, struct genl_info *info)
>>  			return -EINVAL;
>>  	}
>> 
>> +	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
>> +	if (params.he_6ghz_capa) {
>> +		params.ht_capa = NULL;
>> +		params.vht_capa = NULL;
>> +	}
> 
> IMHO better to reject (with a message)
> 
Got it.

-Rajkumar
