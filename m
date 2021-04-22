Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190CA36821A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhDVOGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Apr 2021 10:06:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38180 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236333AbhDVOGY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Apr 2021 10:06:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619100349; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=I4XwGNDATYls9g0XO/wHPfOU5OZR/ZYbaXk6AcN2vdM=;
 b=Q1HdkCiyk62ecgsa1NhHL63MXR0DeLA5kSH4UYuD7BxZRXXOeqHADHXtQbsZhra07x4Zz6ZI
 XsbJJNCnM14ugxouRTD504Aiu2af1aSADZNxSP8Q3ZbFmVRdI9B/G9iZYJvBlv8NCro1VE0q
 o0XA5/ay8Wjp+r2dLNiueaMWrf0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 608182b42cc44d3aea79190b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Apr 2021 14:05:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F06DC4338A; Thu, 22 Apr 2021 14:05:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1A0CC433F1;
        Thu, 22 Apr 2021 14:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1A0CC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix warning in ath11k_mhi_config
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1617857830-19315-1-git-send-email-akolli@codeaurora.org>
References: <1617857830-19315-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210422140540.3F06DC4338A@smtp.codeaurora.org>
Date:   Thu, 22 Apr 2021 14:05:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Initialize static variable ath11k_mhi_config for all hw_rev,
> return error for unknown hw_rev.
> This patch fixes below Smatch warning:
>     drivers/net/wireless/ath/ath11k/mhi.c:357 ath11k_mhi_register()
>     error: uninitialized symbol 'ath11k_mhi_config'.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a233811ef600 ("ath11k: Add qcn9074 mhi controller config")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ff9f732a87ca ath11k: fix warning in ath11k_mhi_config

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1617857830-19315-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

