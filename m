Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E2373575
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEEHTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 03:19:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40578 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhEEHTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 03:19:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620199088; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=OpInw1Tew815TdwcqGzqmtmjFZ/n9U86KvmoBeOdH2U=;
 b=w1Ghn0YR8KU4rn/xQHDk/88jN/9m1UTWG22glxA40R8NKnm8F6QzrmHMlB0Ei5wPl5g7GeA9
 pmq+Y311YOt3WhqVazMnTi/fhsbC2Kk3NM+gunZ75eGEHXR5idkY8wDi0G6P84vWbA3IpvDD
 Ek7W8J1Awk3dXPG6K4PZ3ccg8WA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 609246acf34440a9d4140827 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 07:18:04
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F58AC433D3; Wed,  5 May 2021 07:18:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BDB3C4338A;
        Wed,  5 May 2021 07:18:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 12:48:03 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     jjohnson@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <445ba573b519b9434d0e009eb9ff6f45@codeaurora.org>
References: <1619696874-30072-1-git-send-email-mkenna@codeaurora.org>
 <1619696874-30072-2-git-send-email-mkenna@codeaurora.org>
 <445ba573b519b9434d0e009eb9ff6f45@codeaurora.org>
Message-ID: <cc2182041c5fc8f1c168a262e3a3263c@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-03 22:54, jjohnson@codeaurora.org wrote:
> On 2021-04-29 04:47, Maharaja Kennadyrajan wrote:
> [..snip..]
>> +/**
>> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
>> + *      Used to configure beacon staggered mode or beacon burst mode.
>> + */
>> +enum nl80211_beacon_tx_mode {
>> +	NL80211_BEACON_STAGGERED_MODE = 1,
>> +	NL80211_BEACON_BURST_MODE = 2,
>> +};
>> +
> [..snip..]
>> @@ -5330,6 +5331,10 @@ static int nl80211_start_ap(struct sk_buff 
>> *skb,
>> struct genl_info *info)
>>  	params.dtim_period =
>>  		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
>> 
>> +	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
>> +		params.beacon_tx_mode =
>> +
>> nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
>> +
> 
> Note that in the case where NL80211_ATTR_BEACON_TX_MODE is not 
> specified that
> beacon_tx_mode will be zero, which is not a valid
> nl80211_beacon_tx_mode enumeration.
> 
> Should you renumber the nl80211_beacon_tx_mode enumerations so that the 
> default
> mode has a value of 0? Or add NL80211_BEACON_DEFAULT_MODE = 0 and
> allow the driver
> to select a default mode?

[Maha]: Yes, it will select the default mode as STAGGERED mode when the 
user set
beacon_tx_mode as 0 in the hostapd conf file.
Also, it will select the default mode as STAGGERED mode when the user 
didn't add
beacon_tx_mode config in the hostapd conf file.
This is how it is handled here already.

Regards,
Maha
