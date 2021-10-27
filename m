Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6193F43C43A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhJ0HqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:46:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18914 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbhJ0HqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:46:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320636; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+XIbprEOIu5YSf75PIFw0TUkVKIhB23Tg3uWD4HExoA=;
 b=JuflVsiYlT37q72fmF0q/kpyqevsmr62MYWyQw7nSVtd8qLVNDryOtRtP4OCfqQ8SzFdN654
 1zYXzsX+hQKR3OZDR2yuKUlZ7BBcM1OjvH68mkVxPpgHnXGVRmHdtX4dTlhVhp2WLrY4srIq
 B2Kl9PyQzRFF6QJUPY6cD/PYiHw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61790330bd6886bdf711fb6c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:43:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F6A8C4360C; Wed, 27 Oct 2021 07:43:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A2C3C4338F;
        Wed, 27 Oct 2021 07:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2A2C3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wcn36xx: Treat repeated BMPS entry fail as connection
 loss
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211022140447.2846248-2-bryan.odonoghue@linaro.org>
References: <20211022140447.2846248-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163532062026.19793.8485601808997088450.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:43:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> On an open AP when you pull the plug on the AP, if we are not already in
> BMPS mode then the firmware will not generate a disconnection event.
> 
> Instead we need to monitor for failure to enter BMPS and treat a string of
> failures as connection loss.
> 
> Secure AP connections don't appear to demonstrate this behavior so the
> work-around is limited to open APs only.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

2f1ae32f736d wcn36xx: Treat repeated BMPS entry fail as connection loss
285bb1738e19 Revert "wcn36xx: Disable bmps when encryption is disabled"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211022140447.2846248-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

