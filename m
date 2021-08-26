Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227A73F85F0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhHZK6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:58:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31378 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241491AbhHZK6H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:58:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629975440; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=gxMTA0fwRG33Rk4J/3HwnKfgjAGL7e7W9ikb7mKuAUU=;
 b=B3wnrOKplqG9Bi1ELFzJo34B7rD7ba1U9Sum49W4g2ZX8cAqjppxwanQToIYZMRIMSl9XQFv
 TagWQsRLSBzPrqq8qpjw4YPbG6nFVYzsWrmQX6Dww2Ru0V7mYOvH/R+mVHZ59SG4Dq3gld0N
 oPzo6R7SNmLSpOTctN+d2x/uuEk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6127737e096d475c7c1f85b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 10:57:02
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7454EC4360D; Thu, 26 Aug 2021 10:57:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2960CC43460;
        Thu, 26 Aug 2021 10:57:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Aug 2021 18:57:02 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
In-Reply-To: <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-2-wgong@codeaurora.org>
 <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
Message-ID: <e6006814059d085a1f57af24b9561dde@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 16:20, Johannes Berg wrote:
>>  struct cfg80211_chan_def {
>>  	struct ieee80211_channel *chan;
>> @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
>>  	u32 center_freq2;
>>  	struct ieee80211_edmg edmg;
>>  	u16 freq1_offset;
>> +	enum nl80211_ap_reg_power power_type;
> 
> I'm not sure why this should be in the chandef, there's no way that
> anything in cfg80211 is ever using it there, at least in your patches.
> 
It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse regulatory 
info in 6 GHz operation information.
should i move it to mac80211's .h file?
>> +/**
>> + * enum nl80211_ap_reg_power - regulatory power for a Access Point
>> + *
>> + * @NL80211_REG_UNSET_AP: Access Point has no regulatory power mode
>> + * @NL80211_REG_LPI: Indoor Access Point
>> + * @NL80211_REG_SP: Standard power Access Point
>> + * @NL80211_REG_VLP: Very low power Access Point
>> + */
>> +enum nl80211_ap_reg_power {
>> +	NL80211_REG_UNSET_AP,
>> +	NL80211_REG_LPI_AP,
>> +	NL80211_REG_SP_AP,
>> +	NL80211_REG_VLP_AP,
>> +	NL80211_REG_AP_POWER_AFTER_LAST,
>> +	NL80211_REG_AP_POWER_MAX =
>> +		NL80211_REG_AP_POWER_AFTER_LAST - 1,
>> +};
> 
> Similarly here (and the other enum), why is this in nl80211 if it's
> never used in nl80211?
> 
It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse regulatory 
info in 6 GHz operation information.
should i move it to mac80211's .h file?
> johannes
