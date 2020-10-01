Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A449D2807B9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJAT1D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:27:03 -0400
Received: from z5.mailgun.us ([104.130.96.5]:56502 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgJAT1D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:27:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580422; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zliNTwJnatixXoxg1jg+IQLMPUYmQap7/igTDtXYrJk=;
 b=oeq9xmR7QHLG6aQRtR7t2s+YHI+ACb1rTbsYfmqSguBHFwotoIRl5mFO5p4cfGdABw/zMNDQ
 rag8SXUp0mlr/6KCLalIp/yz5QAV7sZdDZdJ2JCQwUdfPS1nOTMSdsRrA/2PBqrqEUm/snyq
 3ZGmExqrJdXIB7LzGPFBjquvwmg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f762d85726b122f31fb170a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:27:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9085EC433CB; Thu,  1 Oct 2020 19:27:00 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF51FC433CA;
        Thu,  1 Oct 2020 19:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF51FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: remove auto_start from channel config struct
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1601369799-22328-1-git-send-email-kvalo@codeaurora.org>
References: <1601369799-22328-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        sfr@canb.auug.org.au, govinds@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, davem@davemloft.net
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001192700.9085EC433CB@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:27:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Recent change in MHI bus removed the option to auto start the channels
> during MHI driver probe. The channel will only be started when the MHI
> client driver like QRTR gets probed. So, remove the option from ath11k
> channel config struct.
> 
> Fixes: 1399fb87ea3e ("ath11k: register MHI controller device for QCA6390")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

To avoid breaking ath11k we decided to postpone this change after the
merge window, it's a lot easier to deal at that time.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11805307/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

