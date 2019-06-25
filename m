Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF054F5B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfFYMxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:53:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfFYMxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:53:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EDA660709; Tue, 25 Jun 2019 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467191;
        bh=Ja3ss3tOr/5lIm/1YGtE2FnzM0hoMOhF+xDDrh6TtbQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VqcDb7BgoWFo8R5Izl+chhhfeWCkX8EC1O8CmhjbBS4JR74wWOkBETIlHBs+nJH5W
         zdq8QKC4ObHfd5fk9mGb98E0uy3+fPeNA3bBHJ2VqN2xIica9If0ZRJyvEJ6OsKYrs
         96dTKJFcsTxjNIuAAbe5TfUYbVrmXSSOhOywLCxY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 063B660254;
        Tue, 25 Jun 2019 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467190;
        bh=Ja3ss3tOr/5lIm/1YGtE2FnzM0hoMOhF+xDDrh6TtbQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=FeeceCQYNwVgkCO4j9Xb8+5ew72HK3AVgg2EPzjLMHBdIC48usQTQWlBzJzNuvnl0
         S2d7uke7dW6yLXeOPwBOapJgFQM5KKf1sY+efvf26uLbHUhaWKKwbFng+Grl69PS5U
         TV1s6JDOav90UkBFmPXRPLOpGr5B3/XPgDmBTLKU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 063B660254
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: add support for firmware crash recovery on
 SDIO chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1558506776-19702-1-git-send-email-wgong@codeaurora.org>
References: <1558506776-19702-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125311.4EDA660709@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:53:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> The command to simulate firmware crash:
> echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
> 
> It will send WMI_FORCE_FW_HANG_ASSERT to firmware, then it will trigger
> CPU interrupt status register for SDIO chip, ath10k driver need to
> configure it while enable SDIO interrupt, otherwise ath10k driver will
> not get the assert error info.
> 
> After this change, it will success for simulate firmware crash.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Tested-by: Claire Chang <tientzu@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0f132ba7ac64 ath10k: add support for firmware crash recovery on SDIO chip

-- 
https://patchwork.kernel.org/patch/10955189/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

