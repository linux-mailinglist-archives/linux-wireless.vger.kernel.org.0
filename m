Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF6428B13
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhJKKxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:53:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38199 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhJKKxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:53:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633949467; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nc1TDV60QwmynKUq9rir3JrVGO3b0CrRN8D+EYDttNo=; b=i+VcrzfRMrbQdZcz3XJgCO7yCPqwA3U3kWCBbF3c0EOP820JSinNclVXYjHH1IsXuL4pvJ1e
 nobWJ6q4TqtdP2lL7ML9ndNCwMsnEL4THkUiwR4n6qj9uE+EYGaCR1ELX/drZiOxHHCPjFqW
 aLugFf07Y/e8kmAjFrIBrMfTHSE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6164171aff0285fb0afe092f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 10:51:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6816C4338F; Mon, 11 Oct 2021 10:51:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6C21C4338F;
        Mon, 11 Oct 2021 10:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E6C21C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting custom regulatory
References: <20201129153055.1971298-1-luca@coelho.fi>
        <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
        <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
Date:   Mon, 11 Oct 2021 13:51:03 +0300
In-Reply-To: <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
        (Nicolas Cavallari's message of "Tue, 15 Jun 2021 16:42:20 +0200")
Message-ID: <87ily325t4.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr> writes:

> On 29/11/2020 16:30, Luca Coelho wrote:
>> From: Ilan Peer <ilan.peer@intel.com>
>>
>> When custom regulatory was set, only the channels setting was updated, but
>> the regulatory domain was not saved. Fix it by saving it.
>>
>> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>>   net/wireless/reg.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
>> index a04fdfb35f07..094492b62f8a 100644
>> --- a/net/wireless/reg.c
>> +++ b/net/wireless/reg.c
>> @@ -2547,6 +2547,7 @@ static void handle_band_custom(struct wiphy *wiphy,
>>   void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>>   				   const struct ieee80211_regdomain *regd)
>>   {
>> +	const struct ieee80211_regdomain *new_regd, *tmp;
>>   	enum nl80211_band band;
>>   	unsigned int bands_set = 0;
>>   @@ -2566,6 +2567,13 @@ void wiphy_apply_custom_regulatory(struct
>> wiphy *wiphy,
>>   	 * on your device's supported bands.
>>   	 */
>>   	WARN_ON(!bands_set);
>> +	new_regd = reg_copy_regd(regd);
>> +	if (IS_ERR(new_regd))
>> +		return;
>> +
>> +	tmp = get_wiphy_regdom(wiphy);
>> +	rcu_assign_pointer(wiphy->regd, new_regd);
>> +	rcu_free_regdom(tmp);
>>   }
>>   EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
>>   
>>
>
> Hello,
>
> This patch somehow appears to break ath9k's eeprom hints and restrict
> it to the world regulatory domain on v5.12.10.
>
> ath9k calls wiphy_apply_custom_regulatory() with its own kind of world
> regulatory domain, before it decodes hints from the eeprom and uses
> regulatory_hint() to request a specific alpha2.
>
> With this patch, applying the hint fails because wiphy->regd is already set.
> If i revert this patch, ath9k works again.

I have lost track, is this regression fixed now or is it sill
unresolved?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
