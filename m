Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAFC54FA2
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfFYNDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:03:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfFYNDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:03:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 31D9F60300; Tue, 25 Jun 2019 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467812;
        bh=um0kHOu56NQbK5nO8lUc7zcQhQj4obdC0w6F4FGf9D4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KgXcpo5rkLVxVfTZeUZybrFUh2lr8YmlVrInBwI0DEIQZHuiMu7O/A6ZiFii4co1V
         ehqVMRJDhhhJGLNAoh5ox2jk5kmd4De3whC4eOuowy+FWEWGNBbArkjYhRciV2Zkup
         +EXWjGqIdqw0GpgajwRLLNmnl3dkIbdGFZ0fWhUM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB62360254;
        Tue, 25 Jun 2019 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467811;
        bh=um0kHOu56NQbK5nO8lUc7zcQhQj4obdC0w6F4FGf9D4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Hhe28dB69sZBItE+56FZ02t2jUHK37GZ4DS8o801xrm5hq1L7vEkvMSUPrae35iXP
         TmEGYaa35xrRDPDyIe+qRuf1gsIuvBBqzRDgyK/Wbi9PwVHJ0sqUB3HpvUUm0HwoLn
         oMaN0oXh+Wjd0D4qCGfDnmGL+Mm90/baxBmuN30Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB62360254
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix PCIE device wake up failed
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1559180960-13565-1-git-send-email-miaoqing@codeaurora.org>
References: <1559180960-13565-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625130332.31D9F60300@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:03:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> Observed PCIE device wake up failed after ~120 iterations of
> soft-reboot test. The error message is
> "ath10k_pci 0000:01:00.0: failed to wake up device : -110"
> 
> The call trace as below:
> ath10k_pci_probe -> ath10k_pci_force_wake -> ath10k_pci_wake_wait ->
> ath10k_pci_is_awake
> 
> Once trigger the device to wake up, we will continuously check the RTC
> state until it returns RTC_STATE_V_ON or timeout.
> 
> But for QCA99x0 chips, we use wrong value for RTC_STATE_V_ON.
> Occasionally, we get 0x7 on the fist read, we thought as a failure
> case, but actually is the right value, also verified with the spec.
> So fix the issue by changing RTC_STATE_V_ON from 0x5 to 0x7, passed
> ~2000 iterations.
> 
> Tested HW: QCA9984
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

011d4111c8c6 ath10k: fix PCIE device wake up failed

-- 
https://patchwork.kernel.org/patch/10968039/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

