Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BF1C34FF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgEDIxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:53:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44256 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbgEDIxy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:53:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588582433; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Xy2FBIOAu6LLXua4xA27xe48v0ZGand+xjnnNbBK9dQ=;
 b=hgnl2ueAlLiJf9WYbzfgLVK39t8C0PLeKMKaJPnQpT1EAi+S/P3JvK6n1BJZA3v45uB3yFoy
 eJ5B0Y6c6Tvf+8AHsK4B7lm8LyW7qO0DQ/WYEJgWu89IcUllR1w+wjxK/ar85W4VwwRsNICb
 UiV3+Lnz2VbcW/zcA+Y6/ZbHQME=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafd811.7f1674029618-smtp-out-n02;
 Mon, 04 May 2020 08:53:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D74AC44788; Mon,  4 May 2020 08:53:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD92DC433F2;
        Mon,  4 May 2020 08:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD92DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] ath11k: fix error return code in
 ath11k_dp_alloc()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200427104621.23752-1-weiyongjun1@huawei.com>
References: <20200427104621.23752-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     John Crispin <john@phrozen.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504085336.3D74AC44788@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 08:53:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: d0998eb84ed3 ("ath11k: optimise ath11k_dp_tx_completion_handler")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f76f750aeea4 ath11k: fix error return code in ath11k_dp_alloc()

-- 
https://patchwork.kernel.org/patch/11511849/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
