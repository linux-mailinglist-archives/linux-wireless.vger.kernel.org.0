Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E22C019F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKWIje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 03:39:34 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:41563 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKWIjd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 03:39:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606120773; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4Wpkh5UOukf1syg57KeN1VizU4VC+Zbvv8wU/CDreo0=;
 b=wqrSiL7XjdOrGLkbfqGaNn4INaijfqGqgkn+/2eBwjEMRk3mRuA8kd9R6ZGCoBqreYjrYGes
 nwkFn9jByiVIWBNDl+Qify7jCAk6qA68QUVcVU0n5LXr70nIxW8qhqIOGC2GRyf3m6g4fNLD
 V75KgCQa1yFbIMGEJ9V7yLMk+HM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fbb75440c9500dc7b76b712 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 08:39:32
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EAE2C43460; Mon, 23 Nov 2020 08:39:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12412C433ED;
        Mon, 23 Nov 2020 08:39:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Nov 2020 16:39:32 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
In-Reply-To: <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-15-thomas@adapt-ip.com>
 <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
Message-ID: <9d1e20d1124883bd1a2a64c1c62d7975@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

add more to know it.
On 2020-11-23 16:38, Wen Gong wrote:
> On 2020-09-22 10:28, Thomas Pedersen wrote:
> ...
>> @@ -3446,6 +3453,42 @@ bool ieee80211_chandef_he_6ghz_oper(struct
>> ieee80211_sub_if_data *sdata,
>> 
>>  	*chandef = he_chandef;
>> 
>> +	return false;
>> +}
> This change the "return true" to "return false" by default of
> ieee80211_chandef_he_6ghz_oper.
> It should be typo mistake.
>> +
>> +bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie 
>> *oper,
>> +				struct cfg80211_chan_def *chandef)
>> +{
>> +	u32 oper_freq;
>> +
>> +	if (!oper)
>> +		return false;
>> +
>> +	switch (FIELD_GET(S1G_OPER_CH_WIDTH_OPER, oper->ch_width)) {
>> +	case IEEE80211_S1G_CHANWIDTH_1MHZ:
>> +		chandef->width = NL80211_CHAN_WIDTH_1;
>> +		break;
>> +	case IEEE80211_S1G_CHANWIDTH_2MHZ:
>> +		chandef->width = NL80211_CHAN_WIDTH_2;
>> +		break;
>> +	case IEEE80211_S1G_CHANWIDTH_4MHZ:
>> +		chandef->width = NL80211_CHAN_WIDTH_4;
>> +		break;
>> +	case IEEE80211_S1G_CHANWIDTH_8MHZ:
>> +		chandef->width = NL80211_CHAN_WIDTH_8;
>> +		break;
>> +	case IEEE80211_S1G_CHANWIDTH_16MHZ:
>> +		chandef->width = NL80211_CHAN_WIDTH_16;
>> +		break;
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	oper_freq = ieee80211_channel_to_freq_khz(oper->oper_ch,
>> +						  NL80211_BAND_S1GHZ);
>> +	chandef->center_freq1 = KHZ_TO_MHZ(oper_freq);
>> +	chandef->freq1_offset = oper_freq % 1000;
>> +
>>  	return true;
>>  }
>> 
> ....
