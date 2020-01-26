Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8725B149A00
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAZKXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:23:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59668 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729107AbgAZKXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:23:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580034226; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iWXmW163STiS69ZQzqM26+VjqGPhdChfwDJKLC2/k8k=;
 b=p3f3fJC1/DI5q95y0caLsm6GP9VHmdAlFxsu6kNwRIQhJFuTQmJX16prRmFSpyxsDCebFuiK
 joTU7ezoZ7vWKrxQ19Uu5pf1rq3dxPniXS7B6pnMfkeXWMF6Mq449kt7SCqd52L4xK4g7av3
 AC1B77lSh3eIJqZlADZ70Vabrns=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d68b0.7f979e18e110-smtp-out-n02;
 Sun, 26 Jan 2020 10:23:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7A4DC4479F; Sun, 26 Jan 2020 10:23:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10FE4C433CB;
        Sun, 26 Jan 2020 10:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10FE4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG
 when safe
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
References: <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     akolli@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126102344.C7A4DC4479F@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:23:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> ath10k_pci_dump_memory_reg() will try to access memory of type
> ATH10K_MEM_REGION_TYPE_IOREG however, if a hardware restart is in progress
> this can crash a system.
> 
> Individual ioread32() time has been observed to jump from 15-20 ticks to >
> 80k ticks followed by a secure-watchdog bite and a system reset.
> 
> Work around this corner case by only issuing the read transaction when the
> driver state is ATH10K_STATE_ON.
> 
> Tested-on: QCA9988 PCI 10.4-3.9.0.2-00044
> 
> Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

d239380196c4 ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG when safe
63ec5cbc31f7 ath10k: pci: Fix comment on ath10k_pci_dump_memory_sram

-- 
https://patchwork.kernel.org/patch/11303563/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
