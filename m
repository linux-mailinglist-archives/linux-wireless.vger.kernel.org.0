Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD01A05FB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 06:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDGEzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 00:55:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44429 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGEzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 00:55:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586235353; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=X/GZBrPjzhohs2EciwYj8PzkEbWiJ7M/xZcNnceLXxM=;
 b=I5AZ5vYy4992dyqv/JewqHlsoCUj3Lk9NOR32NNvpDelIYtWzRrFjg3F2pqF0+PPUNJqtd9M
 GQQHZtI2uRPG0z/Rg6m5kM8jsVzgstrbwDIBmgyA9opeTenaRLcM0tLyocQ+GvcolojzOikv
 Oc4L4kIzS7AekiFii/DBYpOtHTQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c07c1.7fb8da182928-smtp-out-n01;
 Tue, 07 Apr 2020 04:55:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08D90C433BA; Tue,  7 Apr 2020 04:55:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FA3AC433D2;
        Tue,  7 Apr 2020 04:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FA3AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix kernel null pointer dereference
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585736290-17661-1-git-send-email-vnaralas@codeaurora.org>
References: <1585736290-17661-1-git-send-email-vnaralas@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200407045528.08D90C433BA@smtp.codeaurora.org>
Date:   Tue,  7 Apr 2020 04:55:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> wrote:

> Currently sta airtime is updated without any lock in case of
> host based airtime calculation. Which may result in accessing the
> invalid sta pointer in case of continuous station connect/disconnect.
> 
> This patch fix the kernel null pointer dereference by updating the
> station airtime with proper RCU lock in case of host based airtime
> calculation.
> 
> Proceeding with the analysis of "ARM Kernel Panic".
> The APSS crash happened due to OOPS on CPU 0.
> Crash Signature : Unable to handle kernel NULL pointer dereference
> at virtual address 00000300
> During the crash,
> PC points to "ieee80211_sta_register_airtime+0x1c/0x448 [mac80211]"
> LR points to "ath10k_txrx_tx_unref+0x17c/0x364 [ath10k_core]".
> The Backtrace obtained is as follows:
> [<bf880238>] (ieee80211_sta_register_airtime [mac80211]) from
> [<bf945a38>] (ath10k_txrx_tx_unref+0x17c/0x364 [ath10k_core])
> [<bf945a38>] (ath10k_txrx_tx_unref [ath10k_core]) from
> [<bf9428e4>] (ath10k_htt_txrx_compl_task+0xa50/0xfc0 [ath10k_core])
> [<bf9428e4>] (ath10k_htt_txrx_compl_task [ath10k_core]) from
> [<bf9b9bc8>] (ath10k_pci_napi_poll+0x50/0xf8 [ath10k_pci])
> [<bf9b9bc8>] (ath10k_pci_napi_poll [ath10k_pci]) from
> [<c059e3b0>] (net_rx_action+0xac/0x160)
> [<c059e3b0>] (net_rx_action) from [<c02329a4>] (__do_softirq+0x104/0x294)
> [<c02329a4>] (__do_softirq) from [<c0232b64>] (run_ksoftirqd+0x30/0x90)
> [<c0232b64>] (run_ksoftirqd) from [<c024e358>] (smpboot_thread_fn+0x25c/0x274)
> [<c024e358>] (smpboot_thread_fn) from [<c02482fc>] (kthread+0xd8/0xec)
> 
> Tested HW: QCA9888
> Tested FW: 10.4-3.10-00047
> 
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

acb31476adc9 ath10k: fix kernel null pointer dereference

-- 
https://patchwork.kernel.org/patch/11468873/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
