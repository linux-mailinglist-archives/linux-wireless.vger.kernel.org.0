Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B886541B144
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhI1Nz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 09:55:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19422 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbhI1Nz4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 09:55:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632837257; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Xg9M50LR2M8PjOn9o4C3D1UQ4OrdmK9CBl06sbqFgoU=;
 b=rOaDpUHq1V3LRLn3ZQBl8wD+TS7bOGLkXSyjkqzx/bdpCXdxl8myCQAWsNtLmtv1SlSUEBA8
 PEtblhSZBaRxBJrSgoYh+pA4i/o/Rwe/4KtK85ZgFlB2qa+tdx5RJLRCu6dmDzVz61R7y+HB
 3bBBXkIr+6Cv8JhSgippNNahJ+w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61531e68713d5d6f960cf6f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 13:53:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF95AC4360D; Tue, 28 Sep 2021 13:53:43 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73D91C4360D;
        Tue, 28 Sep 2021 13:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 73D91C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] ath11k: Rename macro ARRAY_TO_STRING to
 PRINT_ARRAY_TO_BUF
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913223148.208026-2-jouni@codeaurora.org>
References: <20210913223148.208026-2-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928135343.AF95AC4360D@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 13:53:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Renaming of macro is done to describe the macro functionality
> better as the macro functionality is modified in next patch-sets.
> No functional changes are done.
> 
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

5 patches applied to ath-next branch of ath.git, thanks.

9e2e2d7a4dd4 ath11k: Rename macro ARRAY_TO_STRING to PRINT_ARRAY_TO_BUF
6f442799bcfd ath11k: Replace HTT_DBG_OUT with scnprintf
74327bab6781 ath11k: Remove htt stats fixed size array usage
6ed731829cf8 ath11k: Change masking and shifting in htt stats
ac83b6034cfa ath11k: add HTT stats support for new stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913223148.208026-2-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

