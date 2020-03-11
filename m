Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505C9181E12
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgCKQjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:39:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60493 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729675AbgCKQjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:39:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583944749; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dCBcc6LZO8xfZtNdDvLx2GB/dl+F8fo9sw7SEiiJKNo=;
 b=hElY3pZjbRCIvVONiuvzisEzX2SdheaUzlZ89qDEevz1gxRSrhPg57fZ2JYYdrbA/quf8ggE
 /jgE3bfWipWUarqXB7qUPrSXZ5n8+2YsG4xesEnXr5j4PVTf4Ov7XIb9NVYRqs5+wqNCidqI
 olwXvL2dAoqDHAWAT57ruEma6m8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69142b.7ff86615d688-smtp-out-n01;
 Wed, 11 Mar 2020 16:39:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68302C44788; Wed, 11 Mar 2020 16:39:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02675C433BA;
        Wed, 11 Mar 2020 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02675C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: start recovery process when read int status fail
 for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200214034007.24512-1-wgong@codeaurora.org>
References: <20200214034007.24512-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311163906.68302C44788@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:39:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When running simulate crash stress test, it happened
> "failed to read from address 0x800: -110".
> 
> Test steps:
> 1. Run command continuous
> echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
> 
> 2. error happened and it did not begin recovery for long time.
> [74377.334846] ath10k_sdio mmc1:0001:1: simulating soft firmware crash
> [74378.378217] ath10k_sdio mmc1:0001:1: failed to read from address 0x800: -110
> [74378.378371] ath10k_sdio mmc1:0001:1: failed to process pending SDIO interrupts: -110
> 
> It has sdio errors since it can not read MBOX_HOST_INT_STATUS_ADDRESS,
> then it has to do recovery process to recovery ath10k.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

37b7ecb75627 ath10k: start recovery process when read int status fail for sdio

-- 
https://patchwork.kernel.org/patch/11381639/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
