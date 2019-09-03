Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B086A6A47
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfICNpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:45:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfICNpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:45:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E92A4602A9; Tue,  3 Sep 2019 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518316;
        bh=SZXWTCjqpiIvW/RjC2cgF+Cvh3PDxr4gm1GoQYsANAc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ca/rZzPT9MLVZHKOPL3uysvDFsKMDFKuSjvOacfGIKIOsFXeqR/qvNUItwL6ZAlxg
         zC9/NWHEqikTyeFP3EySLqAmsO9dO617jwtOAXAuoUX4/FhXEqcXOwXuTAxSJd3iek
         RbE4TDyTuF846kTtcFB4InWk2yRHyZIHYnN+eXhw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C481160159;
        Tue,  3 Sep 2019 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518316;
        bh=SZXWTCjqpiIvW/RjC2cgF+Cvh3PDxr4gm1GoQYsANAc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Y48Wol2ZIk4AgKtysBFOfSSNGlW2PxCXTzFESqk9tq9NKJGWVZtAZzYwkEG0XUxqZ
         H237KLtBaDoadnQJpfxF4oY687CvJn+ADi3z31/LWcuB90+xuwNBf0Aj0JS5NHd0am
         M2D04K0HTvTqHIsX/7aKy/KaArjTXaDYhbdHku1s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C481160159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] brcmfmac: get chip's default RAM info during PCIe
 setup
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190829082701.1715-1-zajec5@gmail.com>
References: <20190829082701.1715-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903134516.E92A4602A9@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:45:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Getting RAM info just once per driver's lifetime (during chip
> recognition) is not enough as it may get adjusted later (depending on
> the used firmware). Subsequent inits may load different firmwares so a
> full RAM recognition is required on every PCIe setup. This is especially
> important since implementing hardware reset on a firmware crash.
> 
> Moreover calling brcmf_chip_get_raminfo() makes sure that RAM core is
> up. It's important as having BCMA_CORE_SYS_MEM down on BCM4366 was
> resulting in firmware failing to initialize and following error:
> [   65.657546] brcmfmac 0000:01:00.0: brcmf_pcie_download_fw_nvram: Invalid shared RAM address 0x04000001
> 
> This change makes brcmf_chip_get_raminfo() call during chip recognition
> redundant for PCIe devices but SDIO and USB still need it and it's a
> very small overhead anyway.
> 
> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Patch applied to wireless-drivers-next.git, thanks.

82f93cf46d60 brcmfmac: get chip's default RAM info during PCIe setup

-- 
https://patchwork.kernel.org/patch/11120633/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

