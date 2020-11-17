Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51B2B5B7A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKQJCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 04:02:38 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:53108 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgKQJCh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 04:02:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605603756; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bVpGXpqeGT8iQyEhIe4p2xI76dSKbgiLTv9TvPy/Htc=;
 b=tDOMvN+QP7vDQi1KgGedI3Wlo+yd0WpJmT/y3bI5lq4fks+KEaDNsSI9jIwIJwJdftGBHruk
 rb99BU/u7mKjKe+IaaX2gWwT7jiufEGwydi4DhOldyE1EAnkitkkDvcmnkJxYrlRz3KNnvTY
 oZFRtniuwriUkYzOXyPzrWlY4B8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fb3919340d44461255d9bb4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 09:02:11
 GMT
Sender: kathirve=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 495F1C43460; Tue, 17 Nov 2020 09:02:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kathirve)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2D63C43461;
        Tue, 17 Nov 2020 09:02:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 14:32:10 +0530
From:   Karthikeyan Kathirvel <kathirve@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2] mac80211: choosing first channel from the list
In-Reply-To: <06b13326118d3fdeb3f665aa54af9c4e@codeaurora.org>
References: <1603884387-23757-1-git-send-email-kathirve@codeaurora.org>
 <06b13326118d3fdeb3f665aa54af9c4e@codeaurora.org>
Message-ID: <1d4bd5d785ff85819825d8b2a054f203@codeaurora.org>
X-Sender: kathirve@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-17 14:28, kathirve@codeaurora.org wrote:
> On 2020-10-28 16:56, Karthikeyan Kathirvel wrote:
>> Though the first channel from sband channel list is invalid
>> or disabled still mac80211 is choosing this disabled channel
>> as a default channel for monitor interface. This will end-up
>> in choosing wrong channel.
>> 
>> Fixed by assigning the first available valid or enabled channel
>> to the respective radios.
>> 
>> Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
>> ---
>> 
>> v2:
>> 	rebased
>> 
>>  net/mac80211/main.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>> index b4a2efe..a4aefd6 100644
>> --- a/net/mac80211/main.c
>> +++ b/net/mac80211/main.c
>> @@ -982,8 +982,15 @@ int ieee80211_register_hw(struct ieee80211_hw 
>> *hw)
>>  			continue;
>> 
>>  		if (!dflt_chandef.chan) {
>> +			/*
>> +			 * Assigning the first enabled channel to dflt_chandef from the
>> +			 * list of channels available specific to country
>> +			 */
>> +			for (i = 0; i < sband->n_channels; i++)
>> +				if (!(sband->channels[i].flags & IEEE80211_CHAN_DISABLED))
>> +					break;
>>  			cfg80211_chandef_create(&dflt_chandef,
>> -						&sband->channels[0],
>> +						&sband->channels[i == sband->n_channels ? 0 : i],
>>  						NL80211_CHAN_NO_HT);
>>  			/* init channel we're on */
>>  			if (!local->use_chanctx && !local->_oper_chandef.chan) {
> 
> Please ignore this.

Corrected my identity
