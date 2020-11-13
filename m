Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60722B1799
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKMIzo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:55:44 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:38730 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMIzo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:55:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605257743; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=C7nQWuK3FlsYgR47fV8JnuCoxHm63yRXNVweW5gdKrk=;
 b=Dl0spEVBqyIW3z0WuUBrHJYDc5jqnvMAQ8WPiqwc6I/CpZM0TYDl5aVRPIFQOaZ/tmEJFY7D
 dX5GdFU3Be21L6c4tM6BzVuYrjOl/K6e41Yq/VIY9TvB2M5hK55aY7DLfQDh1hYFxNCOi7qc
 +aTP41G2u/bbinFVyIyVbOp2C7U=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fae4a00d6e6336a4e42657f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 08:55:28
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32ED2C433C8; Fri, 13 Nov 2020 08:55:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0954C433C9;
        Fri, 13 Nov 2020 08:55:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 16:55:26 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linville@tuxdriver.com,
        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>,
        Mathias Kretschmer <mathias.kretschmer@fokus.fraunhofer.de>,
        linux-wireless-owner@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCHv3 1/2] nl80211: add support for mcs masks
In-Reply-To: <b7a64b13d38792a97708675dcd8e5f69@codeaurora.org>
References: <1327767935-16984-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1327767935-16984-2-git-send-email-siwu@hrz.tu-chemnitz.de>
 (sfid-20120128_172604_145461_197131DD)
 <b7a64b13d38792a97708675dcd8e5f69@codeaurora.org>
Message-ID: <621967ef7bc9209efaa027b7e574c586@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-12 18:38, Wen Gong wrote:
> On 2012-01-29 00:25, Simon Wunderlich wrote:
>> Allow to set mcs masks through nl80211. We also allow to set MCS
>> rates but no legacy rates (and vice versa).
>> 
>> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>> Signed-off-by: Mathias Kretschmer 
>> <mathias.kretschmer@fokus.fraunhofer.de>
>> ---
>>  include/linux/nl80211.h |    4 +++
>>  include/net/cfg80211.h  |    3 +-
>>  net/wireless/nl80211.c  |   61 
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 65 insertions(+), 3 deletions(-)
>> 
> ...
>> @@ -5421,12 +5451,20 @@ static int nl80211_set_tx_bitrate_mask(struct
>> sk_buff *skb,
>>  		sband = rdev->wiphy.bands[i];
>>  		mask.control[i].legacy =
>>  			sband ? (1 << sband->n_bitrates) - 1 : 0;
>> +		if (sband)
>> +			memcpy(mask.control[i].mcs,
>> +			       sband->ht_cap.mcs.rx_mask,
>> +			       sizeof(mask.control[i].mcs));
> when use command: "iw wlan0 set bitrates legacy-5 6", I want to set it
> fixed in 6M rate.
> this copy mcs rate will add the mcs rate here and condition "if
> (tb[NL80211_TXRATE_MCS])"
> is false, then mcs rate will not clear and lead a mistake result.
>> +		else
>> +			memset(mask.control[i].mcs, 0,
>> +			       sizeof(mask.control[i].mcs));
>>  	}
>> 
>>  	/*
>>  	 * The nested attribute uses enum nl80211_band as the index. This 
>> maps
>>  	 * directly to the enum ieee80211_band values used in cfg80211.
>>  	 */
>> +	BUILD_BUG_ON(NL80211_MAX_SUPP_HT_RATES > IEEE80211_HT_MCS_MASK_LEN * 
>> 8);
>>  	nla_for_each_nested(tx_rates, info->attrs[NL80211_ATTR_TX_RATES], 
>> rem)
>>  	{
>>  		enum ieee80211_band band = nla_type(tx_rates);
>> @@ -5442,7 +5480,28 @@ static int nl80211_set_tx_bitrate_mask(struct
>> sk_buff *skb,
>>  				sband,
>>  				nla_data(tb[NL80211_TXRATE_LEGACY]),
>>  				nla_len(tb[NL80211_TXRATE_LEGACY]));
>> -			if (mask.control[band].legacy == 0)
>> +		}
>> +		if (tb[NL80211_TXRATE_MCS]) {
> 
> false for "iw wlan0 set bitrates legacy-5 6", so ht_rateset_to_mask
> will not enter and mcs rate will not clear.
If no tb[NL80211_TXRATE_HT]/tb[NL80211_TXRATE_VHT], it should clear the 
data like this:
memset(mcs, 0, IEEE80211_HT_MCS_MASK_LEN) which is in ht_rateset_to_mask 
and
memset(mcs, 0, sizeof(u16) * NL80211_VHT_NSS_MAX) which is in 
vht_set_mcs_mask.
> 
>> +			if (!ht_rateset_to_mask(
>> +					sband,
>> +					nla_data(tb[NL80211_TXRATE_MCS]),
>> +					nla_len(tb[NL80211_TXRATE_MCS]),
>> +					mask.control[band].mcs))
>> +				return -EINVAL;
>> +		}
>> +
>> +		if (mask.control[band].legacy == 0) {
>> +			/* don't allow empty legacy rates if HT
>> +			 * is not even supported. */
>> +			if (!rdev->wiphy.bands[band]->ht_cap.ht_supported)
>> +				return -EINVAL;
>> +
>> +			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
>> +				if (mask.control[band].mcs[i])
>> +					break;
>> +
>> +			/* legacy and mcs rates may not be both empty */
>> +			if (i == IEEE80211_HT_MCS_MASK_LEN)
>>  				return -EINVAL;
>>  		}
>>  	}
