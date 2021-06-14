Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF3A6A4E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhFNPaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 11:30:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19906 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhFNP3k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623684457; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=nUv0sq9JJwdOUvHq8KJYWA65M9Kenj6mpHlLCoEo154=;
 b=m3LJ3wh+oumFCFEcIw4i//CnUidBQGeUH32ZGZk6MhhO44BfM+vwMJxzv9zC+M9+UldNAIUE
 c6wXscQIyh1RpDOMmDZacrbwssWD/b8s9b85oDQj02WQzDAcEOMJ0qi8fLyztxeI2/EUixbV
 M+zfXaaIgMfOFPqHfQQmz/Imv3U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c7755ded59bf69cc4a06d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 15:27:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5CDAC4360C; Mon, 14 Jun 2021 15:27:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A90AC43145;
        Mon, 14 Jun 2021 15:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A90AC43145
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Move hal_buf allocation to devm_kmalloc in probe
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
References: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210614152725.A5CDAC4360C@smtp.codeaurora.org>
Date:   Mon, 14 Jun 2021 15:27:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Right now wcn->hal_buf is allocated in wcn36xx_start(). This is a problem
> since we should have setup all of the buffers we required by the time
> ieee80211_register_hw() is called.
> 
> struct ieee80211_ops callbacks may run prior to mac_start() and therefore
> wcn->hal_buf must be initialized.
> 
> This is easily remediated by moving the allocation to probe() taking the
> opportunity to tidy up freeing memory by using devm_kmalloc().
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ef48667557c5 wcn36xx: Move hal_buf allocation to devm_kmalloc in probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210605173347.2266003-1-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

