Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E898ABA67
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbfIFOLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:11:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbfIFOLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:11:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF5606118D; Fri,  6 Sep 2019 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779113;
        bh=87O41lyZfEnUjjdEeuKeDT+ml8txqow14NjWrIcm7qw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HJLSFNKPdmvw04PKT7kHon9Y8doTz5Hq188H5U8Ks61nGyl+bNixDY1vd8YXXWXdt
         9zIha18A5/8Q5QEOtfcx4zOw5dz957c9pmq15Mmj12aL2Wzyn8RcworXW11kchrTwC
         69DASwnhgmgvcD2pkWetU2mss8CXnZ/2uossVBcg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2651D6030B;
        Fri,  6 Sep 2019 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779113;
        bh=87O41lyZfEnUjjdEeuKeDT+ml8txqow14NjWrIcm7qw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=cYuShNFDgyOE4CfRJJK9cR7fjS1j8XJ/Wy/F9Z2fpl/bPY9MaTAADQIJKS3AHGvV8
         VxliY0v8PGyJ+BeDj2kDity11tLVMBCZSjzLoKktGE32inYfLB3DTD3hd330hutVV3
         L/ya+yadH3feCK/xoFY50hQnbkFCtEfzzauuHJ9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2651D6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: Fix file release memory leak
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190904141611.4780-1-weiyongjun1@huawei.com>
References: <20190904141611.4780-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190906141153.CF5606118D@smtp.codeaurora.org>
Date:   Fri,  6 Sep 2019 14:11:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> When using single_open() for opening, single_release() should be
> used instead of seq_release(), otherwise there is a memory leak.
> 
> This is detected by Coccinelle semantic patch.
> 
> Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

4c3e48794dec rtlwifi: Fix file release memory leak

-- 
https://patchwork.kernel.org/patch/11130357/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

