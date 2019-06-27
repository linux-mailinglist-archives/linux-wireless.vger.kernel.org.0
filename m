Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287DD58960
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0R7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0R7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:59:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6BF8B60A0A; Thu, 27 Jun 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561658354;
        bh=TDt+TsIJojoSi3nFbwHzrAxp6vhuwRTs7dV6p+GiuOQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dVC46lenHyoEMljBFU9ZsiUt93wtfp0geWHqWvkX3+6/e3A3RFV1PPhbiISMiGvUi
         uu7b79vx8/gPCg40agLksbKrS9+XD3oI2h8luPOAfBFQv1VumHXaBedgBftDJT7gTz
         0Ln0++VueDQ9BuwqqG9U+4RIdj9OMBncXEwjKrI8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5031B60741;
        Thu, 27 Jun 2019 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561658354;
        bh=TDt+TsIJojoSi3nFbwHzrAxp6vhuwRTs7dV6p+GiuOQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=cNkHgbLRUj1HY7Cqf9E1ov5EEVCB4M/ylnsuvpElf5ItxEpVwcygxkW4BJ9aNt0vi
         jwrQtiOp4Or8IBR7NAkoo315jD8jMdOuL13pFVeXL5ycRVeVknzMKHFkhJCKVBJH7D
         lJWvtjwyxvKDAoGIiuGJHrSVYejyW+gkLc62MaPM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5031B60741
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add new hw_ops for sdio chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1560757048-19223-1-git-send-email-wgong@codeaurora.org>
References: <1560757048-19223-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627175914.6BF8B60A0A@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:59:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> It report error message while suspend/resume test.
> dmesg log:
> [  150.749962] ath10k_sdio mmc1:0001:1: hif read32 not supported
> [  150.755728] ath10k_sdio mmc1:0001:1: failed to set coverage class: expected integer microsecond value in register
> 
> Reason is sdio chip does not support set_coverage_class as well as
> pcie chip, remove the set_coverage_class handler will avoid it.
> 
> callstack of the error message:
> OUTLINED_FUNCTION_6+0xc/0x14 [ath10k_core]
> ath10k_mac_op_set_coverage_class+0x2c/0x40 [ath10k_core]
> ieee80211_reconfig+0x5d0/0x108c [mac80211]
> ieee80211_resume+0x34/0x6c [mac80211]
> wiphy_resume+0xbc/0x13c [cfg80211]
> dpm_run_callback+0xa4/0x168
> device_resume+0x1d4/0x200
> async_resume+0x1c/0x34
> async_run_entry_fn+0x48/0xf8
> process_one_work+0x178/0x2f8
> worker_thread+0x1d8/0x2cc
> kthread+0x11c/0x12c
> ret_from_fork+0x10/0x18
> 
> the error log will not happen after this patch applied.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6b4021deb03f ath10k: add new hw_ops for sdio chip

-- 
https://patchwork.kernel.org/patch/10998099/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

