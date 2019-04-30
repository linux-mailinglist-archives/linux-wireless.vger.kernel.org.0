Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495A0F391
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfD3J6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 05:58:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3J6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 05:58:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 86E5F608BA; Tue, 30 Apr 2019 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556618320;
        bh=/OB55PwLiN+VY5sC2w4AVwUugT8v9nOotaENEpSmz7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gMQbRksY8T57Ip78YeZvtOJRdCC1Za9wYgJ7tJJJhqhXWd3NAroPEPrCA4vSniv9k
         rLBDD0fGjVCkcCGFHWcrgu/nN6pN4Azd2dNhUr5/oL1SQTKo8LQzoJYNJ7kuKV1gtQ
         XMvlI0OF/zImV7UllUC2yA3v8lE90cnelV5kInTw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 35A49607DF;
        Tue, 30 Apr 2019 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556618320;
        bh=/OB55PwLiN+VY5sC2w4AVwUugT8v9nOotaENEpSmz7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gMQbRksY8T57Ip78YeZvtOJRdCC1Za9wYgJ7tJJJhqhXWd3NAroPEPrCA4vSniv9k
         rLBDD0fGjVCkcCGFHWcrgu/nN6pN4Azd2dNhUr5/oL1SQTKo8LQzoJYNJ7kuKV1gtQ
         XMvlI0OF/zImV7UllUC2yA3v8lE90cnelV5kInTw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Apr 2019 15:28:40 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv5 5/9] nl80211: Add netlink attribute to configure TID
 specific tx rate
In-Reply-To: <d9135c6be42425424e4c3fd606c7e5aaf9dac1e9.camel@sipsolutions.net>
References: <1553592550-15282-1-git-send-email-tamizhr@codeaurora.org>
 <1553592550-15282-6-git-send-email-tamizhr@codeaurora.org>
 <d9135c6be42425424e4c3fd606c7e5aaf9dac1e9.camel@sipsolutions.net>
Message-ID: <f70f928923e9623e63b27d590956cb42@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-04-26 15:07, Johannes Berg wrote:
>> @@ -13354,6 +13367,42 @@ static int parse_tid_conf(struct 
>> cfg80211_registered_device *rdev,
>>  			nla_get_u8(attrs[NL80211_ATTR_TID_CONFIG_RTSCTS_CTRL]);
>>  	}
>> 
>> +	if (attrs[NL80211_ATTR_TID_CONFIG_TX_RATES_TYPE]) {
>> +		int idx;
>> +		enum nl80211_attrs attr;
>> +
>> +		if (!wiphy_ext_feature_isset(&rdev->wiphy,
>> +				NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK))
>> +			return -EOPNOTSUPP;
>> +
>> +		if (peer &&
>> +		    !wiphy_ext_feature_isset(&rdev->wiphy,
>> +				NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK))
>> +			return -EOPNOTSUPP;
>> +
>> +		idx = NL80211_ATTR_TID_CONFIG_TX_RATES_TYPE;
>> +		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
>> +
>> +		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_TX_BITRATE;
>> +		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
>> +			tid_conf->mask =
>> +				kzalloc(sizeof(struct cfg80211_bitrate_mask),
>> +					GFP_KERNEL);
> 
> You leak this
> 
>> +			if (!tid_conf->mask)
>> +				return -ENOMEM;
>> +
>> +			attr = NL80211_ATTR_TID_CONFIG_TX_RATES;
>> +			ret = nl80211_parse_tx_bitrate_mask(attrs, rdev, attr,
>> +							    tid_conf->mask);
>> +			if (ret) {
>> +				kfree(tid_conf->mask);
>> +				return ret;
>> +			}
>> +		} else {
>> +			tid_conf->mask = NULL;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>> 
>> @@ -13407,7 +13456,7 @@ static int nl80211_set_tid_config(struct 
>> sk_buff *skb,
>>  		}
>> 
>>  		ret = parse_tid_conf(rdev, attrs, &tid_conf->tid_conf[conf_idx],
>> -				     tid_conf->peer);
>> +				     info, tid_conf->peer);
>>  		if (ret)
>>  			goto bad_tid_conf;
> 
> Practically everywhere, but particularly in the bad case in the next
> loop iteration etc?
> 
Yeah. I will fix this in next version.
