Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DA33FA9E1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhH2HOE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 03:14:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57245 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhH2HN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 03:13:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630221186; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AVWGNT7tRSSLenpvopz6gPJLfeDmo/Fgk1wnlvMrLcM=;
 b=uSTCmGmATuo0zmDxEqriu4MbYsXlAMSsWjMhY0HANZQAyOVd/5gKxghnyQgLDgXJokWqshJp
 pZFU8wMfuHHCe+9+KsEi0xNtmcSSUhJLu1DYQL8/IWJr8T+N0IUN6lXcJLiz6i1ioSNd6aKT
 2ssofSl97SssUZE9UrBMlVsKR4k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 612b337cd6653df7672df0ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 07:13:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9AE75C43616; Sun, 29 Aug 2021 07:12:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 949EEC43460;
        Sun, 29 Aug 2021 07:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 949EEC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: wmi: fix an error code in ath6kl_wmi_sync_point()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210813113438.GB30697@kili>
References: <20210813113438.GB30697@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Raja Mani <rmani@qca.qualcomm.com>,
        Vasanthakumar Thiagarajan <vthiagar@qca.qualcomm.com>,
        Suraj Sumangala <surajs@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829071259.9AE75C43616@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 07:12:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This error path is unlikely because of it checked for NULL and
> returned -ENOMEM earlier in the function.  But it should return
> an error code here as well if we ever do hit it because of a
> race condition or something.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fd6729ec534c ath6kl: wmi: fix an error code in ath6kl_wmi_sync_point()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210813113438.GB30697@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

