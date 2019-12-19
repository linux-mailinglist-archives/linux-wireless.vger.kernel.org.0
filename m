Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F01262CF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSNCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:02:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:33801 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfLSNCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:02:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576760539; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=G5+Jkm2dPR/VOa+pmA3els3GZLK825N+nliQuh2uYAg=;
 b=h8cS6cCFJYUdI0xPz9mJ/5W0L/JXWUhJJtjOPHwC6imgTsS8SV3RonOAkneX4jNBa8bcrdTC
 QFb0M4KWfyGQRzaUV6U1e4fDpfANAoqxEW7nX7rM5hLjqNd7hkFOfGCuutinQMA66RftGWNP
 kz+D1GZyOeclWb2EbjWxubSYgpY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb74d7.7f4d73ef0960-smtp-out-n03;
 Thu, 19 Dec 2019 13:02:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D097BC4479F; Thu, 19 Dec 2019 13:02:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90A83C43383;
        Thu, 19 Dec 2019 13:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90A83C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH,
 v3] Revert "ath10k: fix DMA related firmware crashes on multiple
 devices"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ef916f2e7-28683312-1d0b-4c2e-b967-c13c3e45ce31-000000@us-west-2.amazonses.com>
References: <0101016ef916f2e7-28683312-1d0b-4c2e-b967-c13c3e45ce31-000000@us-west-2.amazonses.com>
To:     Zhi Chen <zhichen@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191219130215.D097BC4479F@smtp.codeaurora.org>
Date:   Thu, 19 Dec 2019 13:02:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi Chen <zhichen@codeaurora.org> wrote:

> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> PCIe hung issue was observed on multiple platforms. The issue was 
> reproduced
> when DUT was configured as AP and associated with 50+ STAs.
> 
> For QCA9984/QCA9888, the DMA_BURST_SIZE register controls the AXI burst 
> size
> of the RD/WR access to the HOST MEM.
> 0 - No split , RAW read/write transfer size from MAC is put out on bus
>      as burst length
> 1 - Split at 256 byte boundary
> 2,3 - Reserved
> 
> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary 
> when
> issue happened. It broke PCIe spec and caused PCIe stuck. So revert
> the default value from 0 to 1.
> 
> Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
>           QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
>           Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040
> 
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath10k/hw.h:813
error: drivers/net/wireless/ath/ath10k/hw.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11287143/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
