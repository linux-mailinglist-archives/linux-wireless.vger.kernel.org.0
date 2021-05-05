Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC79E373DA6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhEEO2r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:28:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27829 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhEEO2q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:28:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620224870; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=10W8JpKllbkaXdTAT7CM0Hm+0iZGJXV5CAgR1GWuops=;
 b=uDBtS3TYPKVwNk4K5hGlc7qMAD2gAWf4bpVOcSK9mjpjqvpDPwHpfd/BuFdzbHdihABRHsnA
 2rwV1RHsBfNIEYejSck8miqUfMbgwpaUMLgdfU9ooKnxOvfIfNQyYQitRK6xjwdOUTJgsc07
 TBXxl5d72uaHxj5UpdLRwwXwYkE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6092ab5479b6f9e57bf4f3fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 14:27:32
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AE00C433D3; Wed,  5 May 2021 14:27:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A67F6C433F1;
        Wed,  5 May 2021 14:27:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 07:27:31 -0700
From:   jjohnson@codeaurora.org
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <cc2182041c5fc8f1c168a262e3a3263c@codeaurora.org>
References: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
 <1619696874-30072-2-git-send-email-mkenna@codeaurora.org>
 <445ba573b519b9434d0e009eb9ff6f45@codeaurora.org>
 <cc2182041c5fc8f1c168a262e3a3263c@codeaurora.org>
Message-ID: <ce40ca27c3af5efd27a64415538d5b63@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-05 00:18, Maharaja Kennadyrajan wrote:
> On 2021-05-03 22:54, jjohnson@codeaurora.org wrote:
>> On 2021-04-29 04:47, Maharaja Kennadyrajan wrote:
>> [..snip..]
>>> +/**
>>> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
>>> + *      Used to configure beacon staggered mode or beacon burst 
>>> mode.
>>> + */
>>> +enum nl80211_beacon_tx_mode {
>>> +	NL80211_BEACON_STAGGERED_MODE = 1,
>>> +	NL80211_BEACON_BURST_MODE = 2,
>>> +};
>>> +
>> [..snip..]
>>> @@ -5330,6 +5331,10 @@ static int nl80211_start_ap(struct sk_buff 
>>> *skb,
>>> struct genl_info *info)
>>>  	params.dtim_period =
>>>  		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
>>> 
>>> +	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
>>> +		params.beacon_tx_mode =
>>> +
>>> nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
>>> +
>> 
>> Note that in the case where NL80211_ATTR_BEACON_TX_MODE is not 
>> specified that
>> beacon_tx_mode will be zero, which is not a valid
>> nl80211_beacon_tx_mode enumeration.
>> 
>> Should you renumber the nl80211_beacon_tx_mode enumerations so that 
>> the default
>> mode has a value of 0? Or add NL80211_BEACON_DEFAULT_MODE = 0 and
>> allow the driver
>> to select a default mode?
> 
> [Maha]: Yes, it will select the default mode as STAGGERED mode when the 
> user set
> beacon_tx_mode as 0 in the hostapd conf file.
> Also, it will select the default mode as STAGGERED mode when the user 
> didn't add
> beacon_tx_mode config in the hostapd conf file.
> This is how it is handled here already.

Regardless of how it is handled, I still assert that there is a
coding/logic error here since in the case the attribute is not
present you send an invalid enumeration (0) to the driver. I'm
suggesting to fix that logic/coding error either by renumbering
the existing enumerations or by adding a new enumeration so that
0 is a valid enumeration.

