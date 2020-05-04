Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A671C34FA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEDIxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:53:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63213 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgEDIxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:53:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588582396; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CMa1D9N18zuEsw1/L8ZNazrLaRo4UzCqb/YkDNYP7Rg=;
 b=FGQHxQu4r9h4BcESeohwPfTu5Pzidv4IAeiLZ8CZ5ea4ezCvKrL6geTfZNn7getQseumW1PP
 sAG35wB3zlCvtXKfKIqaYnoiKLypz1imPCJDY6TsaJnGr0DMBO89kJfrELu5wbt06AskeBLX
 f2NNFqqLP/lwoMwRHAHWnwb/oWU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafd7ed.7f7d8afef500-smtp-out-n02;
 Mon, 04 May 2020 08:53:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03736C433BA; Mon,  4 May 2020 08:53:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8E5AC433D2;
        Mon,  4 May 2020 08:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8E5AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] ath10k: fix possible memory leak in
 ath10k_bmi_lz_data_large()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200427104348.13570-1-weiyongjun1@huawei.com>
References: <20200427104348.13570-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Wen Gong <wgong@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504085300.03736C433BA@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 08:53:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> 'cmd' is malloced in ath10k_bmi_lz_data_large() and should be freed
> before leaving from the error handling cases, otherwise it will cause
> memory leak.
> 
> Fixes: d58f466a5dee ("ath10k: add large size for BMI download data for SDIO")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

2326aa011967 ath10k: fix possible memory leak in ath10k_bmi_lz_data_large()

-- 
https://patchwork.kernel.org/patch/11511841/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
