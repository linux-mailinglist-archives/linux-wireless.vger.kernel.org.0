Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6E1653E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEGN6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:58:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfEGN6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:58:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 68DE360A44; Tue,  7 May 2019 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237512;
        bh=UVrAVR71DeqnGsG77IgvmH4NMdGJDIS8VmhtMoLwRy8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PquEXDySxJX1ksEX6xIZ7PmL218LxHE838M7dZlqhkJPxyjkX/8dniepnkFsxotf9
         wLEsgpCfuuW0kCBJXNiB7rQpoXaJpHHiYB4woJUs5KxbIbXwv4FhCCwWa46dWciX/B
         iV71FRD11ndArRLiGFLmbJD34aw3lcNU5fmpYr84=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82B75608FC;
        Tue,  7 May 2019 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237511;
        bh=UVrAVR71DeqnGsG77IgvmH4NMdGJDIS8VmhtMoLwRy8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Wswpti8RiRXyjvxNrIjFLGsIZx+UOLVK90mMmw3Dbv8c2nhrLzN/hf9pjIxkDfoT8
         17T7VwfGMTdh7lyXR5ofRhNiw6R9ubsW7mkSDkaG3XO51roAC8sJPQK9e22MIEwctg
         glyYJ7/pXb7v/pYUyZEYninTV7xlZan4NXUMNKWc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82B75608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: change swap mail box config for UTF mode of SDIO
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1554870654-4236-1-git-send-email-wgong@codeaurora.org>
References: <1554870654-4236-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507135832.68DE360A44@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:58:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For SDIO chip, it does not have HTT connect step in boot phase of UTF
> mode, so it does not need the swap configuration for UTF mode, otherwise
> it will trigger UTF load fail. For normal mode, it is swap between HTT
> and WMI, for UTF mode, it does not have HTT, so it can not swap between
> HTT and WMI.
> 
> Disable swap mail box for UTF mode will let UTF mode load success.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8cdee1affe90 ath10k: change swap mail box config for UTF mode of SDIO

-- 
https://patchwork.kernel.org/patch/10893131/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

