Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9573F43979B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJYNeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 09:34:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27906 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhJYNeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 09:34:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635168711; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Q+EuWps8rmPtj67M30S3+jCa9JnykjZ6g5xdZ8g3qag=;
 b=PvNYjWQfjG+mFCzg6MQWjKp5Ioxv71+xlRisB5/tpL4ntqT6lpr7SABi+4cW/N0yCp9iUbx/
 G8J2LZmQZZQG/KGUTh1NBtROUC4F69UokGZxYN0EJmfOXAsGsTJzQBJmlWkDoa3cpqp5DPUU
 J/LBjqgfjBLdILbXcPKvUGdfo/U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6176b1c4b03398c06cac37f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 13:31:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27A2EC4338F; Mon, 25 Oct 2021 13:31:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CAB8C4338F;
        Mon, 25 Oct 2021 13:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8CAB8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] wcn36xx: Fix dxe lock layering violation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211018231722.873525-2-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163516870123.24395.17474261493641612011.kvalo@codeaurora.org>
Date:   Mon, 25 Oct 2021 13:31:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> We are looking at some interesting crashes with wcn36xx in the wild, with
> some of the data appearing to indicate multiple instances of "WARNING
> Spurious TX complete indication".
> 
> Looking at the code here we see that txrx.c is taking the dxe.c lock to set
> and unset the current TX skbuff pointer.
> 
> There is no obvious logical bug however, it is a layering violation to
> share locks like this.
> 
> Lets tidy up the code a bit by making access functions to set and unset the
> TX sbuff. This makes it easier to reason about this code without having to
> switch between multiple files.
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Failed to apply, please rebase on top of ath.git master branch. But
please wait few days as there are quite a few wcn36xx patches pending.

error: patch failed: drivers/net/wireless/ath/wcn36xx/dxe.c:878
error: drivers/net/wireless/ath/wcn36xx/dxe.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/wcn36xx/dxe.h:468
error: drivers/net/wireless/ath/wcn36xx/dxe.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/wcn36xx/txrx.c:584
error: drivers/net/wireless/ath/wcn36xx/txrx.c: patch does not apply
stg import: Diff does not apply cleanly

5 patches set to Changes Requested.

12568271 [v2,1/5] wcn36xx: Fix dxe lock layering violation
12568273 [v2,2/5] wcn36xx: Fix DMA channel enable/disable cycle
12568275 [v2,3/5] wcn36xx: Release DMA channel descriptor allocations
12568277 [v2,4/5] wcn36xx: Functionally decompose DXE reset
12568279 [v2,5/5] wcn36xx: Put DXE block into reset before freeing memory

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211018231722.873525-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

