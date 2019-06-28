Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71575A4ED
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1TMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 15:12:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1TMW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 15:12:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9D5B6070D; Fri, 28 Jun 2019 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749141;
        bh=57OsG2MJk+mmMG66aedSpU3o/1LIsF95/LTgFx7hbvQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UibYhN2KCC85Zzyz6vK45oETr69eeQwmAzMPB3N9JXKaHK+8eIoM2GEH/Jw1WOVKJ
         cSeG5AvVMigoeCABptjQicgNRza8yiJMREowtaZPfgn32KWLmvyodwNZS/yDoBPF0c
         mEluRVJxQPoOEQtO/vkWUnaIcEiXCGpBYSFzgK98=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3890604BE;
        Fri, 28 Jun 2019 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749141;
        bh=57OsG2MJk+mmMG66aedSpU3o/1LIsF95/LTgFx7hbvQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=g69xoJ+ns/k2o4FbbMT/EKiPKodZFdUb7YgwDn6x5K8iubQcHhMWZEYUZb2EtYXkV
         iVHNLxn/XXfL7pVkkeGSETFhoiKwcQ+/eEVFOlcWMLkE6ofa07ao7zmdFZlBX6Moe9
         0xDcqqgz8FtBhsJcgUz7UOIPQSTW5H5x1vdqrpOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3890604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Move non-fatal warn logs to dbg level for SDIO
 chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561516175-13873-1-git-send-email-wgong@codeaurora.org>
References: <1561516175-13873-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190628191221.E9D5B6070D@smtp.codeaurora.org>
Date:   Fri, 28 Jun 2019 19:12:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> ath10k will receive some message with invalid peer id from firmware.
> reason is:
> There are incoming frames to MAC hardware that NOT find relative
> address search table, then peer id is invalid set by MAC hardware,
> it is hardware's logic, so fix it in ath10k will be more convenient.
> 
> log:
> ath10k_sdio mmc1:0001:1: Got RX ind from invalid peer: 65535
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

bd1a4ac556df ath10k: Move non-fatal warn logs to dbg level for SDIO chip

-- 
https://patchwork.kernel.org/patch/11016771/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

