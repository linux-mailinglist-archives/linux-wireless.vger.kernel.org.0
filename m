Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCC41D1A5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbhI3Czu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 22:55:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23233 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347890AbhI3Czu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 22:55:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632970448; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZKMe67P/2Bw1eWMhwJ5iUv3ZOQW99FDE4dvGTY8GNEw=;
 b=GXTO0I73ZtWV+9vIyzi7Am7jZ1zIWfu/vXk0i3rpD6nth3G+n4MVBl2NPEyDLQRRYR9Ad6qF
 UwKHGY5wXWSXs6zm9Js/HigaB0A7RyIxLnrr7HswxMg1AWqKL54dXBQIxm9ARYPX+RNFsU3D
 nunINPz7xOV1GoU0TcuofddI2Yc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 615526c18578ef11ed8864f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Sep 2021 02:53:53
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC5EBC4360D; Thu, 30 Sep 2021 02:53:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C024C4338F;
        Thu, 30 Sep 2021 02:53:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Sep 2021 10:53:52 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
 <cb20427eae96c4551084e4c899618b94@codeaurora.org>
 <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
Message-ID: <2ed76cff292dcca18326de0407a93821@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-30 00:46, Venkateswara Naralasetty wrote:
> On 2021-09-29 09:07, Wen Gong wrote:
>> On 2021-09-28 21:12, vnaralas@codeaurora.org wrote:
>>> On 2021-09-28 14:22, Wen Gong wrote:
>>>> 6 GHz regulatory domains introduces power spectral density(psd).
>>>> The power spectral density(psd) of regulatory rule should be take
>>>> effect to the channels. Save the values to the channel which has
>>>> psd value and add nl80211 attributes for it.
>>>> 
>>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>>> ---
>> ...
>>>> 
>>>> @@ -2540,6 +2554,9 @@ static void handle_channel_custom(struct wiphy 
>>>> *wiphy,
>>>>  			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
>>>>  	}
>>>> 
>>>> +	if (chan->flags & IEEE80211_CHAN_PSD)
>>>> +		chan->psd = reg_rule->psd;
>>>> +
>>>>  	chan->max_power = chan->max_reg_power;
>>> 
>>> What about the case AP + STA concurrency? are we going to overwrite
>>> the PSD power and channel flags?
>>> 
>> 
>> Hi Venkateswara,
>> 
>> This patch is not relation with AP + STA concurrency.
>> For example, it also has other power intersection in
>> handle_channel_adjacent_rules().
>> 
>> 		chan->max_reg_power =
>> 			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
>> 			      MBM_TO_DBM(power_rule2->max_eirp));
>> 
>> For AP + STA concurrency, it should to maintain 2 group of reg rules,
>> one is for AP, another is for STA.
> 
> Can we maintain two power rules in the same channel one for AP and one
> for STA. In this way, we can update the power rules in the same
> channel for both AP and STA from the reg rules.
> 
> Otherwise, we need to maintain multiple channel lists in sband for all
> supported power mode combinations to apply the respective power rules
> and build channel flags from the multiple reg rules.
> right?

If AP+STA is up in the same wiphy/ieee80211_hw, and AP's reg rules is 
different
with STA, then it should maintain muti channel list for each band of the 
wiphy/ieee80211_hw
by my understand.

Currently there is only one "struct ieee80211_supported_band 
*bands[NUM_NL80211_BANDS]"
in "struct wiphy".

I advise to discuss the AP + STA concurrency in another mail thread 
since it is not
relative with this patch.

> 
>> This patch is to handle PSD info in the same reg rules.
>> It is to process only one reg rule in the reg rules.
>> AP + STA concurrency is a higher level things than this patch.
>>>>  }
