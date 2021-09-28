Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4841AB72
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhI1JHG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 05:07:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34680 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239883AbhI1JHF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 05:07:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632819926; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AEADEe6Ao53VNzkjzr4ASMukE0IbDTiq22jiTURIqwU=;
 b=wuxX+If9QDXDrh7AKKpcJGAyjneAkQDDgzi3bpcVEH7rvFYQR7Wc5RamMMLcHkZ7iQjpqb24
 qoCv9tltl5S4HKifYQ1MzRTPUskUPRimjcBKPSi98t024Mn9je2/zAhWAJ60Kb9fMSF7GNIR
 OTkI9Lx4eE7IWH84wEOiaUrlwwM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6152dacd9ffb413149962f05 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 09:05:17
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E02F6C4360C; Tue, 28 Sep 2021 09:05:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87F1EC43460;
        Tue, 28 Sep 2021 09:05:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 Sep 2021 17:05:16 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 4/6] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <a4e56dbbe88771456bcf3051a0891d66d5e34fd4.camel@sipsolutions.net>
References: <20210924100052.32029-1-wgong@codeaurora.org>
 <20210924100052.32029-5-wgong@codeaurora.org>
 <a4e56dbbe88771456bcf3051a0891d66d5e34fd4.camel@sipsolutions.net>
Message-ID: <5b40dee9ca9d91bb0ca6aaa82deae370@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-27 19:27, Johannes Berg wrote:
> On Fri, 2021-09-24 at 06:00 -0400, Wen Gong wrote:
>> The power spectral density(psd) of regulatory rule should be take
>> effect to the channels. This patch is to save the values to the
>> channel which has psd value.
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> ---
>>  net/wireless/reg.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
>> index df87c7f3a049..8f765befb9bc 100644
>> --- a/net/wireless/reg.c
>> +++ b/net/wireless/reg.c
>> @@ -1590,6 +1590,8 @@ static u32 map_regdom_flags(u32 rd_flags)
>>  		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
>>  	if (rd_flags & NL80211_RRF_NO_HE)
>>  		channel_flags |= IEEE80211_CHAN_NO_HE;
>> +	if (rd_flags & NL80211_RRF_PSD)
>> +		channel_flags |= IEEE80211_CHAN_PSD;
> 
> I went to go squash this with patch 3 and took a closer look, and then 
> I
> realized you're doing this weird.
> 
> Please when you resend also squash this - it's a bit weird to read in
> two patches.
> 
> However, I think this is missing a lot of things - we already talked
> about the regulatory database, and while that'd be nice, I guess I
> conceded that you don't really have to do it now.
> 
> However, for visibility reasons, I *really* think you need to add
> nl80211 attributes for all of this data - when the regdomain is dumped
> in nl80211_put_regdom() you would have the flag now (it dumps the value
> of reg_rule->flags in NL80211_ATTR_REG_RULE_FLAGS), but you didn't add
> the value of reg_rule->psd which you've added.
> 
> Similarly, you're not adding the PSD flag nor the PSD value for the
> *channel* in nl80211_msg_put_channel(), both of which I think you 
> should
> have for visibility into what's going on in the kernel/driver.
> 
> I've applied all the other patches, so please just resend 3 and 4,
> squashed into a single patch, with the fixes.
> 

Thanks

I have sent "[PATCH v5] cfg80211: save power spectral density(psd) of 
regulatory rule"
for this.

> johannes
