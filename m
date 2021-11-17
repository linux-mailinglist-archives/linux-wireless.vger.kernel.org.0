Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2273F4541D5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhKQHbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:31:48 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:28239 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhKQHbo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:31:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134126; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=uRTKDUbn59MI/DX7yiQ4Ke7Mo2N9hD+tEqivvCXbxzQ=;
 b=w6KvZgxplbD/hdmoPyDoU46aw3KizwPG2eAbV08gsmo82+slTLUsUGpO3LpdSKgZxAI8t3Ta
 nW3faeu3/ENPztG4QVSt5N+GpN9uR+bkulAjK7lZTPPggYK9KaplmxNWS5JgxRUNXATnPlRr
 Zx8gYeYXy+jun+macpr27gw3xjk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6194af2d638a2f4d6116fd0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:28:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 529EDC43617; Wed, 17 Nov 2021 07:28:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9871C4360C;
        Wed, 17 Nov 2021 07:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A9871C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: use cache line aligned buffers for dbring
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1635831693-15962-1-git-send-email-quic_ramess@quicinc.com>
References: <1635831693-15962-1-git-send-email-quic_ramess@quicinc.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713412147.31320.14390592409999795508.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:28:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> The DMA buffers of dbring which is used for spectral/cfr
> starts at certain offset from original kmalloc() returned buffer.
> This is not cache line aligned.
> And also driver tries to access the data that is immediately before
> this offset address (i.e. buff->paddr) after doing dma map.
> This will cause cache line sharing issues and data corruption,
> if CPU happen to write back cache after HW has dma'ed the data.
> 
> Fix this by mapping a cache line aligned buffer to dma.
> 
> Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

bd77f6b1d710 ath11k: use cache line aligned buffers for dbring

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1635831693-15962-1-git-send-email-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

