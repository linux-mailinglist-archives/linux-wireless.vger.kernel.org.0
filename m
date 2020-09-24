Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4A277666
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIXQQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 12:16:35 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60716 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQQe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 12:16:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600964193; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=soH5jJMO5irSI7C7R0xYTOtWc8nQEtt962+fo8q46+8=;
 b=QY44A3cTGSN5/g4HmpYcNexvPn1GbaAOHoqW+zTkY0afg6hqBbkvQMFMC6Rr2AHwKbOa/Tir
 knMtI0EVrZJnLAM7O46WL693p3M7BH9/gnnVPONjrCneUOjOqez694KzWYHuZC803m6lzYpE
 83wo8RtM30vljvBSqlLJPvZ0Y10=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6cc657d106659f820147de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 16:16:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B807FC433F1; Thu, 24 Sep 2020 16:16:23 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 398F1C433C8;
        Thu, 24 Sep 2020 16:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 398F1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: removing the ath11k debugfs dir properly
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600885519-29535-1-git-send-email-kathirve@codeaurora.org>
References: <1600885519-29535-1-git-send-email-kathirve@codeaurora.org>
To:     Karthikeyan Kathirvel <kathirve@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200924161623.B807FC433F1@smtp.codeaurora.org>
Date:   Thu, 24 Sep 2020 16:16:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <kathirve@codeaurora.org> wrote:

> ath11k_debug_pdev_destroy was not called for proper cleaning of debug
> files when destroying the pdev, this results in not removing the ath11k
> directory in debugfs folder even after rmmod of ath11k. So when next
> time doing insmod of ath11k prevents creating another ath11k directory,
> hence causing ipq8074_2 to get created in parent dir of debugfs.
> 
> Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>

Fails to apply, please rebase. Also Tested-on missing.

error: patch failed: drivers/net/wireless/ath/ath11k/debug.c:973
error: drivers/net/wireless/ath/ath11k/debug.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11795461/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

