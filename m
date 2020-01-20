Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4CC142472
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgATHtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 02:49:15 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:33551 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgATHtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 02:49:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579506554; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uZgHgiVXVyoqGSSn5GF1zo6e1fmH75gjeV3cXdoJwz4=;
 b=AXx7TSxNy+hkqWEtLNyMEH8xFNztnuHT5o2d+SnGjdrzYMQFPjMUgQCda6jelxtrMPy3SICH
 4kxd2ZOtpq49pVJlbioXFTzqR8pJqfyq9Y2h0z2eRsS1hFMfaOQ4gN8kfjBeNjzIr1BgI4gv
 aAYs+DVwLPGp837HS9uTUJSOsw0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e255b79.7f4ca69a9d18-smtp-out-n01;
 Mon, 20 Jan 2020 07:49:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95288C43383; Mon, 20 Jan 2020 07:49:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09BC0C433CB;
        Mon, 20 Jan 2020 07:49:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 13:19:11 +0530
From:   tamizhr@codeaurora.org
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv9 5/6] nl80211: Add support to configure TID specific
 txrate configuration
In-Reply-To: <20200114123108.5mrzvyqkjp7defln@bars>
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
 <1578921090-9758-6-git-send-email-tamizhr@codeaurora.org>
 <20200114123108.5mrzvyqkjp7defln@bars>
Message-ID: <c1f8ed5c0d001d2647a8ef23c0329fab@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-14 18:01, Sergey Matyukevich wrote:
>> This patch adds support to configure per TID txrate configuration
>> configuration through the NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE
>> and NL80211_TID_CONFIG_ATTR_TX_RATE
>> attribute. TX bitrate mask values passed
>> in NL80211_ATTR_TX_RATES attribute and 
>> NL80211_TID_CONFIG_ATTR_TX_RATES
>> attribute will have types of the TX rate should be applied. This uses
>> nl80211_parse_tx_bitrate_mask to validate and calculate the bitrate
>> mask.
>> 
>> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
>> ---
>>  include/net/cfg80211.h       |    5 +++
>>  include/uapi/linux/nl80211.h |   24 +++++++++++++
>>  net/wireless/nl80211.c       |   76 
>> ++++++++++++++++++++++++++++++++----------
>>  3 files changed, 88 insertions(+), 17 deletions(-)
> 
> ...
> 
>> @@ -13936,6 +13947,37 @@ static int parse_tid_conf(struct 
>> cfg80211_registered_device *rdev,
>>  			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
>>  	}
>> 
>> +	if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE]) {
>> +		int idx;
>> +		enum nl80211_attrs attr;
>> +
>> +		err = nl80211_check_tid_config_support(rdev, extack, peer,
>> +						       attrs, tid_conf,
>> +						       TX_RATE);
>> +		if (err)
>> +			return err;
>> +		idx = NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE;
>> +		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
>> +		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
>> +			tid_conf->mask =
>> +				kzalloc(sizeof(struct cfg80211_bitrate_mask),
>> +					GFP_KERNEL);
>> +			if (!tid_conf->mask)
>> +				return -ENOMEM;
>> +
>> +			attr =
>> +			(enum nl80211_attrs)NL80211_TID_CONFIG_ATTR_TX_RATE;
>> +			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
>> +							    tid_conf->mask);
>> +			if (err) {
>> +				kfree(tid_conf->mask);
>> +				return err;
>> +			}
> 
> IIUC we have to free all the allocated tid_conf->mask entries in the 
> end of
> nl80211_set_tid_config, right before tid_config is freed.
Yeah, this needs to be take care by the driver, since it will be sent 
with multiple
configuration. I have added that in the comment in next patchset.
> Alternatively,struct ieee80211_tid_cfg can be modified to keep 
> cfg80211_bitrate_mask
> value rather than pointer.
I have just reused the nl80211_parse_tx_bitrate_mask, so I feel using 
the similar approach
should be good.

> 
>> +		} else {
>> +			tid_conf->mask = NULL;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
> 
Thanks,
Tamizh.
