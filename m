Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA23A7EC5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFONOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:14:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60263 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONOh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:14:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623762753; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AX1p7vDmJIdYUbn8Nq45mmsSa4yHUoL9NYCBqalgGkY=;
 b=vRK+06fiw/vlY/7cdmX8q427aStkSxbCFK7kWmiR6XsFwxHo1RoAyI2SB0uYUoQ6m3Q+519l
 JJXmY7hrGxFCLoapqy+nNFOlVueDcoGouQwcfZV+bG15wV98fadlZX1cBTqnNYGI9wAGycRH
 vhKpAANJkUzK99WFswLXC2od1RM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c8a72aed59bf69ccd64df6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:12:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1599EC4338A; Tue, 15 Jun 2021 13:12:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C87A3C433D3;
        Tue, 15 Jun 2021 13:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C87A3C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [05/11] ipw2x00: Fix wrong function name in comments
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210517050141.61488-6-shenyang39@huawei.com>
References: <20210517050141.61488-6-shenyang39@huawei.com>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615131210.1599EC4338A@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:12:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Shen <shenyang39@huawei.com> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:5359: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6533: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6565: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

Failed to apply, please rebase:

Recorded preimage for 'drivers/net/wireless/intel/ipw2x00/ipw2100.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: ipw2x00: Fix wrong function name in comments
Using index info to reconstruct a base tree...
M	drivers/net/wireless/intel/ipw2x00/ipw2100.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/intel/ipw2x00/ipw2100.c
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/ipw2x00/ipw2100.c
Patch failed at 0001 ipw2x00: Fix wrong function name in comments

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210517050141.61488-6-shenyang39@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

