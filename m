Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8972CC5E5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgLBSvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:51:19 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:10081 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBSvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:51:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606935055; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=G89NwFW7ah34AJIOVhxvFyZ8HkwqMWet75bvZj3Nbeg=;
 b=o29jrEon2uR8I2GJXOborFnOPpGL6vbBWGd5h+G/qkYq3IAuam8laIvgQViBGtXPTHdrWJKg
 scULdUAi6K+lFXx1fwHFb9VIwDXkIm+z+u009rZ7n8tlJl5zFLL3uB91U2NyUJBcWxWfa9N4
 MllDTaW9Xh9u7j3Vqec3pyXT38Q=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fc7e204265512b1b287706e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:50:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD737C43460; Wed,  2 Dec 2020 18:50:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D1EFC433ED;
        Wed,  2 Dec 2020 18:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D1EFC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/17] wil6210: wmi: Correct misnamed function parameter
 'ptr_'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201126133152.3211309-2-lee.jones@linaro.org>
References: <20201126133152.3211309-2-lee.jones@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202185044.AD737C43460@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 18:50:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
>  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'
> 
> Cc: Maya Erez <merez@codeaurora.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: wil6210@qti.qualcomm.com
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Failed to apply:

error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:262
error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201126133152.3211309-2-lee.jones@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

