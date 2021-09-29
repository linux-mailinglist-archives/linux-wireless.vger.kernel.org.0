Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FD41BD8B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 05:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbhI2DjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 23:39:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59864 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhI2DjL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 23:39:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632886649; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1Unl2lezQTicVBS8bzk/jaEWIlMos5NW7fIeXLB5YeA=;
 b=SezyoVkfNE788Yc5RIwJoS0sPdiAY1A6ETvytddApUqSj9yw2yG+bnkgtMj2YBaoryPmwg9B
 Alf0JtILxM4xUjyh/xCK01bg8r04UR8YxnQv1gGYrKIgOg9tNQEz4EZSIzDPrEdR5/lsBxVf
 ShOU5uygwbqhnWe8MGrvcgmg1S8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6153df6f713d5d6f9697fc60 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 03:37:19
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1A67C43617; Wed, 29 Sep 2021 03:37:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11944C4338F;
        Wed, 29 Sep 2021 03:37:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 11:37:17 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     vnaralas@codeaurora.org
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
Message-ID: <cb20427eae96c4551084e4c899618b94@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 21:12, vnaralas@codeaurora.org wrote:
> On 2021-09-28 14:22, Wen Gong wrote:
>> 6 GHz regulatory domains introduces power spectral density(psd).
>> The power spectral density(psd) of regulatory rule should be take
>> effect to the channels. Save the values to the channel which has
>> psd value and add nl80211 attributes for it.
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> ---
...
>> 
>> @@ -2540,6 +2554,9 @@ static void handle_channel_custom(struct wiphy 
>> *wiphy,
>>  			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
>>  	}
>> 
>> +	if (chan->flags & IEEE80211_CHAN_PSD)
>> +		chan->psd = reg_rule->psd;
>> +
>>  	chan->max_power = chan->max_reg_power;
> 
> What about the case AP + STA concurrency? are we going to overwrite
> the PSD power and channel flags?
> 

Hi Venkateswara,

This patch is not relation with AP + STA concurrency.
For example, it also has other power intersection in 
handle_channel_adjacent_rules().

		chan->max_reg_power =
			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
			      MBM_TO_DBM(power_rule2->max_eirp));

For AP + STA concurrency, it should to maintain 2 group of reg rules, 
one is for AP, another is for STA.
This patch is to handle PSD info in the same reg rules.
It is to process only one reg rule in the reg rules.
AP + STA concurrency is a higher level things than this patch.
>>  }
