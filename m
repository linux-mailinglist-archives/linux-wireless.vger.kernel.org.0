Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740681B386B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDVHDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 03:03:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17104 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgDVHDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 03:03:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587539033; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lGnhYcnoMr/yBC95QuUOw/8wiNVMXgiMmeF+YdM1/vI=;
 b=N/Z2fzPyf05Ick8EJrl8mKIaD3mRegmsT0Dr633SQhJssk1gmrY3ulYUb/UscSNsgSmGCpAB
 bj9g8ploNgKlj+vuFleBGY5ALfxObvwzTPooLXTTy0JHMRUpUsRgzSFTU6GYJhGp8fUdzkLs
 GJuMWUfJ6Qo+64dmoikcXJtIDtk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fec58.7f4af6a07730-smtp-out-n02;
 Wed, 22 Apr 2020 07:03:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09E23C433BA; Wed, 22 Apr 2020 07:03:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11DD5C433D2;
        Wed, 22 Apr 2020 07:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11DD5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: drop the TX packet which size exceed credit size for
 sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ea7014696-55ae954e-6272-4899-bd03-d8012e217b9e-000000@us-west-2.amazonses.com>
References: <0101016ea7014696-55ae954e-6272-4899-bd03-d8012e217b9e-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200422070352.09E23C433BA@smtp.codeaurora.org>
Date:   Wed, 22 Apr 2020 07:03:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> sdio chip use DMA buffer to receive TX packet from ath10k, and it has
> limitation of each buffer, if the packet size exceed the credit size,
> it will trigger error in firmware.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

This doesn't apply anymore, please rebase.

error: patch failed: drivers/net/wireless/ath/ath10k/htc.c:846
error: drivers/net/wireless/ath/ath10k/htc.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11261695/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
