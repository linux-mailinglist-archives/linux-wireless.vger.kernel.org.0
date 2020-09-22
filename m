Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0091273C08
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgIVHcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:32:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:20377 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgIVHcF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:32:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600759924; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=exojvpgqdBclhSkIIN+Eg1DMQwvP6hSCsCX6UXL5BjQ=;
 b=S1TmGrpJHObCdpKrh1ONWrWI26ggTeAg9aY5bvte0emPl42/xSqSAfGPURFHu6N09S/9CE5H
 R7acniRQvDGHoj0I+GZNAJOZiUiw7N5uJ/I2Lx1JwLikDcXbJgycipGRmFvC/ovC6UfI+nSA
 JoOppC094n2sOSxMnHt9xqSRGds=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f69a83c4a8a578ddc0e56c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:31:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C583CC433FF; Tue, 22 Sep 2020 07:31:08 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C291FC433C8;
        Tue, 22 Sep 2020 07:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C291FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/4] wcn36xx: Extend HAL param config list
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150747.2179122-2-bryan.odonoghue@linaro.org>
References: <20200910150747.2179122-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922073108.C583CC433FF@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:31:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> In order to get 802.11ac working the way we want, additional parameters
> need to be passed down to the firmware.
> 
> This patch takes the full remaining set of parameters defined in the
> downstream riva/inc/wlan_hal_cfg.h and imports them into hal.h with some
> minor name length adjustments.
> 
> This addition will allow us to pass a larger firmware configuration set
> later on.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

8ec5568b4e2e wcn36xx: Extend HAL param config list
3e977c5c523d wcn36xx: Define wcn3680 specific firmware parameters
2f0c0e3b856d wcn36xx: Add ability to download wcn3680 specific firmware parameters
52054ebd0532 wcn36xx: Latch VHT specific BSS parameters to firmware

-- 
https://patchwork.kernel.org/patch/11768917/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

