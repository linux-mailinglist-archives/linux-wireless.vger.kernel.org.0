Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9737641AD69
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbhI1K5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 06:57:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49298 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240362AbhI1K5t (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 06:57:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826570; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BzIw2gqW3XboP6+x63I5TMHdKixIQoCk1euEID7NjiU=;
 b=EkIWWxzFAn7j1DmdYf2A55e4MS3NIRBA8JxCqpqwZH193P1W5fx8GVlG271cmSJ0OPVXZn7j
 E6xya7KneaWXGwh1ciFobQWeOzmxK1vE1A45dWSt/NmYIqSbjB5zabIEs5ASfdAZJKDzqcI3
 P52Lggrf8yA2vRJkth4IZlNNVqc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6152f4c0519bd8dcf01cefff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:56:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EAE19C43616; Tue, 28 Sep 2021 10:55:59 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11C50C4338F;
        Tue, 28 Sep 2021 10:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 11C50C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix some sleeping in atomic bugs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210812070434.GE31863@kili>
References: <20210812070434.GE31863@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928105559.EAE19C43616@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 10:55:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The ath11k_dbring_bufs_replenish() and ath11k_dbring_fill_bufs()
> take a "gfp" parameter but they since they take spinlocks, the
> allocations they do have to be atomic.  This causes a bug because
> ath11k_dbring_buf_setup passes GFP_KERNEL for the gfp flags.
> 
> The fix is to use GFP_ATOMIC and remove the unused parameters.
> 
> Fixes: bd6478559e27 ("ath11k: Add direct buffer ring support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

aadf7c81a077 ath11k: fix some sleeping in atomic bugs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210812070434.GE31863@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

