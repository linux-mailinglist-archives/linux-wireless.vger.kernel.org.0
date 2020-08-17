Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A66246431
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgHQKPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 06:15:35 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54529 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgHQKPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 06:15:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659333; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fuNBwC0msFti1eZ9hSK4W46yyf8aoKLP8ISRQvXZqGQ=;
 b=ZEkIKG3fULnW1CjbMqRqp+rEAuepvag/jMh4/U2sOw+iI0R5H6fQxRDWf85XwW2Jl1iU4vmq
 Qb6EcvbBxWOwlqILL2HK0AHdut1ZLhzKiTKwzdL1EVgr4K9FYcMCAOT4jO5pxgTakJAPI9Sp
 rUCfrFS5IF28kQAWb6PDCtF3reU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3a58b161f1d41834363d02 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:15:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2949C43387; Mon, 17 Aug 2020 10:15:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1C0EC433C6;
        Mon, 17 Aug 2020 10:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1C0EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] ath11k: do not depend on ARCH_QCOM for ath11k
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597309466-19688-2-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817101512.C2949C43387@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:15:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> With only IPQ8074 supported ath11k was only usable on Qualcomm architectures.
> But now that we are adding QCA6390 PCI support to ath11k that's not the case
> anymore and it can be used on any architecture supporting PCI. So remove the
> dependency on ARCH_QCOM. After that there is also no need to depend on
> COMPILE_TEST.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

10 patches applied to ath-next branch of ath.git, thanks.

322b60ceb0f3 ath11k: do not depend on ARCH_QCOM for ath11k
9de2ad43d46c ath11k: add hw_params entry for QCA6390
34d5a3a88436 ath11k: move ring mask definitions to hw_params
6e0355afaeb2 ath11k: add simple PCI client driver for QCA6390 chipset
5762613ededb ath11k: pci: setup resources
5697a564d369 ath11k: pci: add MSI config initialisation
b8246f884684 ath11k: implement ath11k_core_pre_init()
1399fb87ea3e ath11k: register MHI controller device for QCA6390
7f4beda2ba03 ath11k: pci: add HAL, CE and core initialisation
1ff8ed786d5d ath11k: use remoteproc only with AHB devices

-- 
https://patchwork.kernel.org/patch/11712273/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

