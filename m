Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57C2807C5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJATbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:31:42 -0400
Received: from z5.mailgun.us ([104.130.96.5]:43550 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgJATbm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:31:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580701; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VJaCDMp5KsvxidsYPFuPXtqGv8+zjxKF7cPSFVc/4kU=;
 b=rzBLcl1j2YBgx5QhFisg0ApNAbcDYoWbOd3ri5icoE8mAzdZd20JK8qaXR3Vvvc9mAxPDRBF
 boCnuCdz0W4fVKDYlBxkKInMD/6dylss28NXdDFvSsUCYCMzFA+sBRImBIOSuuk/zqnarbyL
 kYx50wycRHuW6QYFh0pdF7Ul4MA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f762e9d213a72d9e5ab6a3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:31:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91B3DC433CA; Thu,  1 Oct 2020 19:31:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C40CC433C8;
        Thu,  1 Oct 2020 19:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C40CC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] ath11k: support loading ELF board files
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1601399736-3210-2-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001193141.91B3DC433CA@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:31:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> The QCA6390 board I have, model 8291M-PR comes with an ELF board file.  To get
> this to at least somewhat work, I renamed bdwlan.e04 to 'board.bin' and then
> added this patch to check for ELF magic string in the beginning of the file.
> If that is found, use type ELF.  After this the driver loads.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> [kvalo@codeaurora.org: use elf.h, minor cleanup]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

8 patches applied to ath-next branch of ath.git, thanks.

616c16a4b26a ath11k: support loading ELF board files
b09199248905 ath11k: fix AP mode for QCA6390
2626c269702e ath11k: add interface_modes to hw_params
18ac1665e785 ath11k: pci: check TCSR_SOC_HW_VERSION
3f6e6c3291ed ath11k: disable monitor mode on QCA6390
df648808c6b9 ath11k: change to disable softirqs for ath11k_regd_update to solve deadlock
6a8be1baa911 ath11k: Use GFP_ATOMIC instead of GFP_KERNEL in ath11k_dp_htt_get_ppdu_desc
87e8497a7d46 ath11k: Use GFP_ATOMIC instead of GFP_KERNEL in idr_alloc

-- 
https://patchwork.kernel.org/patch/11806385/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

