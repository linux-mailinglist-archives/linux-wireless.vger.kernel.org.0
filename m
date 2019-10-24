Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632DAE2D59
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393045AbfJXJa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:30:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389413AbfJXJa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:30:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A0F260A34; Thu, 24 Oct 2019 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571909455;
        bh=2SfAZN67qACR4mjTRZZNqUaA1fycIXiYFgyuyNyBHq8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RiwyPWXlYfV6OU01uN+0knU8RttM//gPjyJm8nndPcTeM/nnTZ1gr4ae9K65zhPH/
         KGe0LAC4lHVxUp3iKSozGHwLJMwQKPOhhLktf3I+G5c+OYxqPFJIa5bkfGStBj/Y2X
         13mV4sw4ekQyNsNALmJR/70+noVBtSx3g4WLPgw0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65578607C3;
        Thu, 24 Oct 2019 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571909454;
        bh=2SfAZN67qACR4mjTRZZNqUaA1fycIXiYFgyuyNyBHq8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KvJb15DFDdqDHY7se6I6W6g54Q+V/cdnbNerQWWMoJ9lxJp6THV216YrXHzzqBZIK
         09H7I3BNDLMRMYj/daXGM7Dx5vKdsa7q0ty4il53lz20WoSdSHERyaB1i6GHJ+Wvte
         pUUjD3tfx65FX3NZN/2tmpR2f21oe1i6wU3rLe5w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65578607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
Date:   Thu, 24 Oct 2019 12:30:50 +0300
In-Reply-To: <1569402639-31720-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:38 +0800")
Message-ID: <87mudqsd6d.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The max bundle size support by firmware is 32, change it from 8 to 32
> will help performance. This results in significant performance
> improvement on RX path.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -24,7 +24,7 @@
>  #include "trace.h"
>  #include "sdio.h"
>  
> -#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)
> +#define ATH10K_SDIO_VSG_BUF_SIZE	(64 * 1024)

Is allocating 64 kb with kmalloc() reliable, especially on smaller
systems? I hope it is, but checking if someone else knows better. We
only do this only once in probe(), though.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
