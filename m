Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8E273BD7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgIVH3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:29:17 -0400
Received: from z5.mailgun.us ([104.130.96.5]:49058 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbgIVH3R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:29:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600759757; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=SvlE0mA3dJo5mwgXPMDvV4q0G1c6TviAdWnZANpVdMc=; b=erbf6U4UiyP+hem6wT68bMAul3mhNSH7lAJgKvVsgN9BOfNzPsZ9dp01wBjBfQQZyZ7JiHbA
 6rYyT2DBREBKlbXVuQp5zA0hmKRheXSJyPfWy3Pc6/LmRr5S549g8wrxjgppXk8oc4iY7eqk
 M8t3TDLg69CwCbCx+9COpG23wFg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f69a7c491755cb92b3f1d7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:29:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18955C433FE; Tue, 22 Sep 2020 07:29:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D0F1C433C8;
        Tue, 22 Sep 2020 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D0F1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
Subject: Re: [PATCH v5 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
References: <20200910150708.2179043-2-bryan.odonoghue@linaro.org>
        <20200922072324.C8B91C433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 10:29:02 +0300
In-Reply-To: <20200922072324.C8B91C433C8@smtp.codeaurora.org> (Kalle Valo's
        message of "Tue, 22 Sep 2020 07:23:24 +0000 (UTC)")
Message-ID: <87a6xi1d8h.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>
>> Adds HW_VALUE_CHANNEL(hw_value) an access macro that will be used to
>> extract the channel number from struct ieee80211_channel->hw_value in
>> preparation for also storing PHY settings for 802.11ac in the upper bits of
>> hw_value.
>> 
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> 5 patches applied to ath-next branch of ath.git, thanks.
>
> 59b5c8447c14 wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
> f779a92f7b69 wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
> 235b9ae0265b wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
> fc4d4008f810 wcn36xx: Encode PHY mode for 80MHz channel in hw_value
> e042bc19aace wcn36xx: Set PHY into correct mode for 80MHz channel width

Just as a tip for the future, I think this patchset could have been
easily just one patch. Also I have noticed the same with other patchsets
from you. Splitting the patches to one function per patch is too much,
the recommend rule is "one logical change per patch".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
