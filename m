Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24B4B9D97
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 13:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437789AbfIUL1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 07:27:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437766AbfIUL1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 07:27:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7437061418; Sat, 21 Sep 2019 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065219;
        bh=d523pat/7HXfX/N5O6ps4NSPZ+ok2hHb1PagZE1tirw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OISB6SPxffcXVcKIvxL0uw4yL4foYrJKrjpPnT8cRndX1lRyuTaPLzZKgjh0oThV1
         LaqFXQDT/eNUexvuGbVwVeSP3yR+EgrD/iUGsI0jHNLXTfYfIk8z5vVzOACL/rwxKd
         tSE01pJqO6em1hUCdA4J7XlM31DfYwqsYFkGa5FI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D09D560790;
        Sat, 21 Sep 2019 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065218;
        bh=d523pat/7HXfX/N5O6ps4NSPZ+ok2hHb1PagZE1tirw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W51W8DnOe38vsZ2nMMsOQUMDUKMIRpxbQMj0DTjns72OPHgFn9RBGPQxI1IDuPgxL
         8RjjyO8L4kmci0WeX8x/uMef2U3gGdORK7SL9+x95rxAgG4O4U4UqtWxRTSiFIMR4t
         uNRin/Y+0owrtE3eh2kOIn0QtD7b+RWR0u3a/cHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D09D560790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 14:26:54 +0300
In-Reply-To: <1567132338-7407-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Fri, 30 Aug 2019 10:32:18 +0800")
Message-ID: <87d0ftc2kh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When firmware assert, it need coredump to analyze, this patch will
> collect the register and memory info for sdio chip.
>
> The coredump configuration is different between PCIE and SDIO for
> the same reversion, so this patch add bus type to distinguish PCIE
> and SDIO chip for coredump.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

I think this patch should be split into two, the first patch preparing
coredump layouts to support different bus types and the second patch
adding coredump support for SDIO.

> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -11,6 +11,7 @@
>  #include "targaddrs.h"
>  
>  enum ath10k_bus {
> +	ATH10K_BUS_ANY,
>  	ATH10K_BUS_PCI,
>  	ATH10K_BUS_AHB,
>  	ATH10K_BUS_SDIO,

I don't think we need add this type ANY. From a quick look QCA4019 is
AHB and all the rest are PCI, right? So in the first patch you only need
to add correct bus type for each entry and everything should work as
before.

-- 
Kalle Valo
