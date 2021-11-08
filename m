Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3944802E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbhKHNYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 08:24:22 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:41856 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbhKHNYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 08:24:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636377697; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TfjOXO8nzh/hp5f9S4qe4MUirXMncj1/dfFWSJOXehw=;
 b=A/1/PI6ap/7SH9qGU1ocWP5u35ziATJV1icHz0NztElRJAEY3OVfr7TTpH2VJWQc6x6TM2KM
 /Kq3xSEdNwFLfk/PYImGGk9BnCur2dcqo6lX3wNm7QRm99+G7vNjJtoJt0YFgFreE2Dwho+b
 OjICTzy91UAiz9XZGNOf3CRNFJ0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6189245a6b778b5a1992bc92 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 13:21:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6EE5AC43616; Mon,  8 Nov 2021 13:21:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BECCAC4338F;
        Mon,  8 Nov 2021 13:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BECCAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wcn36xx: Fix DMA channel enable/disable cycle
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211105122152.1580542-2-bryan.odonoghue@linaro.org>
References: <20211105122152.1580542-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163637768555.12783.6992853094190522078.kvalo@codeaurora.org>
Date:   Mon,  8 Nov 2021 13:21:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Right now we have a broken sequence where we enable DMA channel interrupts
> which can be left enabled and never disabled if we hit an error path.
> 
> Worse still when we unload the driver, the DMA channel interrupt bits are
> left intact. About the only saving grace here is that we do remember to
> disable the wcnss interrupt when unload the driver.
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

89dcb1da611d wcn36xx: Fix DMA channel enable/disable cycle
3652096e5263 wcn36xx: Release DMA channel descriptor allocations
ed04ea76e69e wcn36xx: Put DXE block into reset before freeing memory

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211105122152.1580542-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

