Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1336340C
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 08:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhDRGbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 02:31:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42853 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhDRGbM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 02:31:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618727445; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WUJ4kb1PidmEEPcbtgbYEBWBgLB8j+P6AtCQF0+blzg=;
 b=O17NRksfHayidN5a1RGozAKKCV6GRZAvRxodJt+hEJVXRvEAY65coZsqppsFrkSQEPBlUVcE
 JJT7/8x5g6j3Z2IJpzk/ePtoOFlFxcCn9sTUSZIE0vA+FDHYn/KLmNGcspYOZ0gTHW1wG6Zz
 viegXITAxAsNA9SwSdP57k5sNn0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 607bd20ee0e9c9a6b6fa7c3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 06:30:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D40F4C433F1; Sun, 18 Apr 2021 06:30:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A7C0C433D3;
        Sun, 18 Apr 2021 06:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A7C0C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtw88: 8822c: reorder macro position according to the
 register number
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210326072926.28313-2-pkshih@realtek.com>
References: <20210326072926.28313-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <vincent_fann@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210418063038.D40F4C433F1@smtp.codeaurora.org>
Date:   Sun, 18 Apr 2021 06:30:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Guo-Feng Fan <vincent_fann@realtek.com>
> 
> This patch doesn't change logic at all, just a refactor patch.
> 
> 1. Move BIT MASK and BIT definition along with the register definition
> 2. Remove redundant definition
> 3. Align macros with Tab key
> 
> Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase and resend.

fatal: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw88/rtw8822c.c).
error: could not build fake ancestor
Applying: rtw88: 8822c: reorder macro position according to the register number
Patch failed at 0001 rtw88: 8822c: reorder macro position according to the register number
The copy of the patch that failed is found in: .git/rebase-apply/patch

3 patches set to Changes Requested.

12165939 [1/3] rtw88: 8822c: reorder macro position according to the register number
12165945 [2/3] rtw88: 8822c: Add gap-k calibration to improve long range performance
12165943 [3/3] rtw88: 8822c: debug: allow debugfs to enable/disable TXGAPK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210326072926.28313-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

