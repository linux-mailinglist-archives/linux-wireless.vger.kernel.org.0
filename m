Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E50273C29
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgIVHjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:39:46 -0400
Received: from z5.mailgun.us ([104.130.96.5]:61569 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgIVHjq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:39:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760385; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yU+vxW8VBCvgS3UGYyQkdrgwe96xUiceYQILLoVxTAQ=;
 b=XIMORC3tM0UCEP/Bt2WTucLOZqB80Yz3fQtrriBQ2v8+QUrexk8gLDHmyQHwwTiJ4PXmNIEK
 A9aQgqz7VK49vKmcKTUhuN6ENVKDzO0viOiLukYiQZdBrK/LpiEYu5r30kyUDJSjldtaG2Kg
 sgjeWFVSTcdJRE9AmQ7OrFlci8A=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f69aa1c1b4c6991364db47c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:39:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70F7CC433CB; Tue, 22 Sep 2020 07:39:07 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3F8DC433CA;
        Tue, 22 Sep 2020 07:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3F8DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/4] wcn36xx: Define INIT_HAL_MSG_V1()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150822.2179261-2-bryan.odonoghue@linaro.org>
References: <20200910150822.2179261-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922073907.70F7CC433CB@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:39:07 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> In order to pass 802.11ac VHT parameters from the SoC to wcn36xx we need to
> use the V1 data structures associated with BSS and STA parameters.
> 
> The means of identifying a V1 data-structure is via the SMD version field.
> This patch defines a INIT_HAL_MSG_V1() which operates the same way as
> INIT_HAL_MSG() with the exception that it defines VERSION1 as opposed to
> VERSION0.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

f97fe43a9495 wcn36xx: Define INIT_HAL_MSG_V1()
d961fdfaa208 wcn36xx: Convert to VHT parameter structure on wcn3680
87d3f1f34157 wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
b421d04e4978 wcn36xx: Advertise ieee802.11 VHT flags

-- 
https://patchwork.kernel.org/patch/11768953/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

