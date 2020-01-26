Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF6149B13
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAZO26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 09:28:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51002 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgAZO26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 09:28:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580048937; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=83aVOTOUDuQhoi2U4p9Ef9lBJTvA8Un2TrF11BYNdnM=;
 b=NwFRak9PUAvQgSct5GR1UAD3JmR2AVuMcRy9eIixZdLUxMMQe31uoMRxb3t319Oz1D1l7Lsk
 qqHmo8o0rQTLEu6vvpEMPvphZF+s/ywUkPTKePO3+O8Yjm6KbKggqEliEt6d3ennF60jiKNh
 nx/tzEA+0LNfPjKINiWjb/AgtP0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2da225.7fa6ac1d8a78-smtp-out-n03;
 Sun, 26 Jan 2020 14:28:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 696B1C4479C; Sun, 26 Jan 2020 14:28:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18990C433CB;
        Sun, 26 Jan 2020 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18990C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Correct the DMA direction for management tx
 buffers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1579590748-17883-1-git-send-email-pillair@codeaurora.org>
References: <1579590748-17883-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126142852.696B1C4479C@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 14:28:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> The management packets, send to firmware via WMI, are
> mapped using the direction DMA_TO_DEVICE. Currently in
> case of wmi cleanup, these buffers are being unmapped
> using an incorrect DMA direction. This can cause unwanted
> behavior when the host driver is handling a restart
> of the wlan firmware.
> 
> We might see a trace like below
> 
> [<ffffff8008098b18>] __dma_inv_area+0x28/0x58
> [<ffffff8001176734>] ath10k_wmi_mgmt_tx_clean_up_pending+0x60/0xb0 [ath10k_core]
> [<ffffff80088c7c50>] idr_for_each+0x78/0xe4
> [<ffffff80011766a4>] ath10k_wmi_detach+0x4c/0x7c [ath10k_core]
> [<ffffff8001163d7c>] ath10k_core_stop+0x58/0x68 [ath10k_core]
> [<ffffff800114fb74>] ath10k_halt+0xec/0x13c [ath10k_core]
> [<ffffff8001165110>] ath10k_core_restart+0x11c/0x1a8 [ath10k_core]
> [<ffffff80080c36bc>] process_one_work+0x16c/0x31c
> 
> Fix the incorrect DMA direction during the wmi
> management tx buffer cleanup.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: dc405152bb6 ("ath10k: handle mgmt tx completion event")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6ba8b3b6bd77 ath10k: Correct the DMA direction for management tx buffers

-- 
https://patchwork.kernel.org/patch/11343145/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
