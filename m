Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E525B2D8487
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 05:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438260AbgLLEjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 23:39:44 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:19929 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391778AbgLLEjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 23:39:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607747939; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/x2LtGpj30Hkf0GdTWkerOIMa0moRtDzX9WHmubZeas=;
 b=ASXeiFdm34QcvAqcPfXhiZQi8nSNx/BCN9drufH0+CwyoQKbUPngbbgNUvGbw/GFgRx1tn6H
 LB077fJW51toD+0vPBfZHO06gBHG869h0vGKps4FELIuHTssbSn1FaDbfI+gOfqYtMhEByGC
 OJSHbTQyNG75VA4MFUzV21MGziE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fd4494353d7c5ba607cc9c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Dec 2020 04:38:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 946B7C433CA; Sat, 12 Dec 2020 04:38:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34627C433C6;
        Sat, 12 Dec 2020 04:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34627C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] ath10k: add atomic protection for device recovery
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <010101746bead6a0-d5e97c66-dedd-4b92-810e-c2e4840fafc9-000000@us-west-2.amazonses.com>
References: <010101746bead6a0-d5e97c66-dedd-4b92-810e-c2e4840fafc9-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201212043827.946B7C433CA@smtp.codeaurora.org>
Date:   Sat, 12 Dec 2020 04:38:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When it has more than one restart_work queued meanwhile, the 2nd
> restart_work is very easy to break the 1st restart work and lead
> recovery fail.
> 
> Add a flag to allow only one restart work running untill
> device successfully recovered.
> 
> It already has flag ATH10K_FLAG_CRASH_FLUSH, but it can not use this
> flag again, because it is clear in ath10k_core_start. The function
> ieee80211_reconfig(called by ieee80211_restart_work) of mac80211 do
> many things and drv_start(call to ath10k_core_start) is 1st thing,
> when drv_start complete, it does not mean restart complete. So it
> add new flag and clear it in ath10k_reconfig_complete, because it
> is the last thing called from drv_reconfig_complete of function
> ieee80211_reconfig, after it, the restart process finished.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5dadbe4e3718 ath10k: add atomic protection for device recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/010101746bead6a0-d5e97c66-dedd-4b92-810e-c2e4840fafc9-000000@us-west-2.amazonses.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

