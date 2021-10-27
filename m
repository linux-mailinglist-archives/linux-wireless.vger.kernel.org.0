Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6243C425
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhJ0Hoc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:44:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56155 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbhJ0Hoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:44:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320527; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CJOum80ywg5Po3OP9rpgEJL+iebnNVGCMAYmnrolgj0=;
 b=xMWxn/Ka9j6zEHzOnyz9fzJqZXWgDBPpWCw5u0vdi/IQrrD5XtRA/yczLapzGbllvAkzr8IN
 LoHcm3L7wrifd/xeKpsgMmrnDRAspdjZQ5t/TEXcleG6BgaonC4DED6BWa97mT+XEXb4A6RF
 gzX4MPbOhhTCxpV7v31fIJOs/0w=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 617902c65ca800b6c1cb3add (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:41:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0ACE1C43460; Wed, 27 Oct 2021 07:41:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B480BC4338F;
        Wed, 27 Oct 2021 07:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B480BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163532051121.19793.6973358846408709731.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:41:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> For packets originating from hardware scan, the channel and band is
> included in the buffer descriptor (bd->rf_band & bd->rx_ch).
> 
> For 2Ghz band the channel value is directly reported in the 4-bit
> rx_ch field. For 5Ghz band, the rx_ch field contains a mapping
> index (given the 4-bit limitation).
> 
> The reserved0 value field is also used to extend 4-bit mapping to
> 5-bit mapping to support more than 16 5Ghz channels.
> 
> This change adds correct reporting of the frequency/band, that is
> used in scan mechanism. And is required for 5Ghz hardware scan
> support.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

8a27ca394782 wcn36xx: Correct band/freq reporting on RX
2371b15f8eeb wcn36xx: Enable hardware scan offload for 5Ghz band

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1634554678-7993-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

