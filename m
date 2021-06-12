Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0D3A4E45
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFLLHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:07:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20736 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLLHD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:07:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623495904; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=kjHxY9YDTUvdbQnJ/lulcSlCbEzIXndXJy3S2twb1II=; b=OXP6J/SzchQ3zk0ZvhukKx18JUUAHd8SzAgl2OIL/kwQcbquwO2iQGaYegS2t47tYOPvVdCB
 atZ64JrXdIpX3Tf3trrX1pXZgchzvvvr63ZeA1PjW9edQHuvHaCCBvjQjC6xuq0iHJdMM+1G
 CfEBo4RSMOnmz8dWGNr+3wiPTP0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c494bdabfd22a3dc554f0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 11:04:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5D74C43460; Sat, 12 Jun 2021 11:04:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46F8CC433D3;
        Sat, 12 Jun 2021 11:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46F8CC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH] wcn36xx: Move hal_buf allocation to devm_kmalloc in probe
References: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
Date:   Sat, 12 Jun 2021 14:04:21 +0300
In-Reply-To: <20210605173347.2266003-1-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Sat, 5 Jun 2021 18:33:47 +0100")
Message-ID: <875yyjz6mi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

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
> Fixes: 8e84c2582169 ('wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680
> hardware')

Fixes tag is wrong, it should be like this and all in one line:

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")

I fixed it in the pending branch, no need to resend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
