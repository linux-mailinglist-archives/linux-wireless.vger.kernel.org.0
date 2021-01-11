Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56F2F119D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhAKLj5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:39:57 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:51903 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhAKLj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:39:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365177; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=p/A8PH9dyRMYRGo1/8zt7SXLywa859suPpLMCMXAKvw=; b=kHc55c6UBkq2C1lRkk5roUcrb46YzuwIpWkWyfKIoI8fJbyGeL/fqjg/EpJO9FcS5k13LGLT
 uiHXqLbEGAEzRGAuxyww5euvPxgEGa8g7gsKJrb0VkJdza1Y6Efj9yxUxPvHlWQM+qFCC10K
 hNHJiW7qFBw9UAEQsCyREC+BuWM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ffc38f8d84bad354762ad1a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:39:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60DBAC43463; Mon, 11 Jan 2021 11:39:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36341C433C6;
        Mon, 11 Jan 2021 11:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36341C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 10/13] wcn36xx: Add GTK offload info to WoWLAN resume
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
        <20201228162839.369156-11-bryan.odonoghue@linaro.org>
Date:   Mon, 11 Jan 2021 13:39:32 +0200
In-Reply-To: <20201228162839.369156-11-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 28 Dec 2020 16:28:36 +0000")
Message-ID: <87k0sjk8i3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> Having enabled GTK rekey in suspend, we need to extract the replay counter
> from the firmware on resume and perform a ieee80211_gtk_rekey_notify() so
> that the STA remains verified from the perspective of the AP.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[...]

>  static const struct wiphy_wowlan_support wowlan_support = {
> -	.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_MAGIC_PKT
> +	.flags = WIPHY_WOWLAN_ANY |
> +		 WIPHY_WOWLAN_MAGIC_PKT |
> +		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY
>  };

I wonder should these also be in the last patch? So that the features
are enabled only after everything is implemented.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
