Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2412443822F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhJWHa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 03:30:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34981 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhJWHa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 03:30:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634974087; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cRwxiIPJGhWEJr0HkrYeTMcEwKzczcyAW4Uio715snw=;
 b=R1Wcw8sON3TlcgipAl+Y10irDGuhAzEVVoDdEE3AW54MFl8HTH6wqL6eFWxqfVBRdTZ/W9Q2
 iPGtit36oe/CrHvkU99vj0K85yT3z4E+wNKt8DZ+5R0LFD2yLUS8/i4PK+GIqL7fQPBHOS72
 uCj3bb9fYtSTExsAiB7d28Ll6Rg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6173b987fd91319f0f072d77 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 23 Oct 2021 07:28:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEF98C43617; Sat, 23 Oct 2021 07:28:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7823EC4338F;
        Sat, 23 Oct 2021 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7823EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mt76: mt7921: fix mt7921s Kconfig
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org>
References: <1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, rdunlap@infradead.org,
        sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163497407995.29616.16947842370256097491.kvalo@codeaurora.org>
Date:   Sat, 23 Oct 2021 07:28:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add missing MMC dependency in mt7921s Kconfig:
> 
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_rr':
> sdio.c:(.text+0x1263): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x1278): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x12c8): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1327): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x134d): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x138c): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x140f): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1498): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x14e5): undefined reference to `sdio_release_host'
> ld: drivers/net/wireless/mediatek/mt76/sdio.o: in function `mt76s_wr':
> sdio.c:(.text+0x1599): undefined reference to `sdio_claim_host'
> ld: sdio.c:(.text+0x15ae): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x15f9): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x1646): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x16a5): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x16cb): undefined reference to `sdio_writel'
> ld: sdio.c:(.text+0x170a): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x1782): undefined reference to `sdio_readl'
> ld: sdio.c:(.text+0x17e9): undefined reference to `sdio_release_host'
> 
> Fixes: 48fab5bbef409 ("mt76: mt7921: introduce mt7921s support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

8603caaec98f mt76: mt7921: fix mt7921s Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

