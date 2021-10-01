Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165D741F1A0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354664AbhJAP7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 11:59:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50568 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhJAP7F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 11:59:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633103841; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XLM2LfC4sJgcesDUGog/is9xx+HFPBiBUfH9x5Kj4+8=; b=akuOzjkLA2DDV10tMFMAq3uJHe8dvZ3Pj5XYCbvh9AJpUKziMkazpej3wk2xds0uHLcEzrsC
 uFNGEQGRzS8mVvtp43pRz0gTn19qPK+qdNftjhypmaq9G9MK+43qdJXLLOfHkf+bBmJRElRs
 4tPKO+EaC2Xax8frr+r8ajdqTds=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61572fd3713d5d6f96248575 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 15:57:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09CB2C4338F; Fri,  1 Oct 2021 15:57:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBBBCC4338F;
        Fri,  1 Oct 2021 15:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DBBBCC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 24/24] rtw89: add Kconfig and Makefile
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-25-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 18:57:03 +0300
In-Reply-To: <20210820043538.12424-25-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:38 +0800")
Message-ID: <87k0iwivqo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> With Kconfig and Makefile, we can build rtw89 and support 8852AE chip.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/Kconfig
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only

All other files are:

SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Only exception is this Kconfig file, any reason for that? I prefer that
a driver has consistent license.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
