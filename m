Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B02273C1D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgIVHht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:37:49 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:58007 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgIVHhr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:37:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760266; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BWhTRgSUYpwHNubKFFiz+FuXVsjWvQDmkJn09wHKTWE=; b=DN0irUd7/m2vjvZ+XCk8ZQiApGJqont5379CsL2tmVEMZUjK4lSKPocpanmJRfaR+nOGKu8f
 inZQsr7vumP7OIIxidwZ830poV8UPmtMHDG6csmhRjKnvAJl0BeZNhxu5bC+lpWftBfTzRmr
 zos174tmhWZNWXPmSH9hPLIa45o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f69a9b21c0775e750107134 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:37:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16B79C433C8; Tue, 22 Sep 2020 07:37:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AD78C433F1;
        Tue, 22 Sep 2020 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AD78C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
Subject: Re: [PATCH v5 1/4] wcn36xx: Extend HAL param config list
References: <20200910150747.2179122-2-bryan.odonoghue@linaro.org>
        <20200922073108.C583CC433FF@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 10:37:16 +0300
In-Reply-To: <20200922073108.C583CC433FF@smtp.codeaurora.org> (Kalle Valo's
        message of "Tue, 22 Sep 2020 07:31:08 +0000 (UTC)")
Message-ID: <875z861cur.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>
>> In order to get 802.11ac working the way we want, additional parameters
>> need to be passed down to the firmware.
>> 
>> This patch takes the full remaining set of parameters defined in the
>> downstream riva/inc/wlan_hal_cfg.h and imports them into hal.h with some
>> minor name length adjustments.
>> 
>> This addition will allow us to pass a larger firmware configuration set
>> later on.
>> 
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> 4 patches applied to ath-next branch of ath.git, thanks.
>
> 8ec5568b4e2e wcn36xx: Extend HAL param config list
> 3e977c5c523d wcn36xx: Define wcn3680 specific firmware parameters
> 2f0c0e3b856d wcn36xx: Add ability to download wcn3680 specific firmware parameters
> 52054ebd0532 wcn36xx: Latch VHT specific BSS parameters to firmware

Here also the first three patches could have been easily just one patch.
And the last patch, adding just one function call, most likely could
have been merged with some other patches.

The problem with splitting the patches to this small size is that it's
hard to review. I don't see the context and have to jump around between
patches to understand what's happening.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
