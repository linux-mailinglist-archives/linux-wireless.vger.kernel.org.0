Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1187CFC9B5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKNPSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:18:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKNPSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:18:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 256D160736; Thu, 14 Nov 2019 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744695;
        bh=PhV7oLv4l2SMi2vA2YKiYb+ka7PetcgtcZMZ/81Qzww=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ovnhMp+DoPDGDkGPJ93+03tKcotKPHIVjGC9wi0XRGFUM4ou6JqW8p9wUT9+tzkU4
         9Be61m2Se3XsX/8ii+iBg+gHpLbhiv9M/uwEyYDp/SCwqFfgrpqBDdI4sJ4BPjy7y4
         w9ns59zl9yvOniinREdJlE6qNfKHdK02v9FejFXY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91C2160117;
        Thu, 14 Nov 2019 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744694;
        bh=PhV7oLv4l2SMi2vA2YKiYb+ka7PetcgtcZMZ/81Qzww=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q3R0wG9rYXu/DyvgstAvwiX9FPiE7VRHTIqoa2M6hlER3G9/3SJ1m9no/u+tj4s/H
         iXTm7dax2MR7h284pqp+5cCzFCGJFr+l5dfiywf+WioaNWXkQKzvxjBCFJI7zkXUB9
         LB07NCiekYuPtOM9ufd5sHEplQId+HSqYB/KRJX4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91C2160117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     <linux-wireless@vger.kernel.org>, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: Re: [PATCH 1/2] mwifiex: fix requesting zero memory for firmware dump
References: <1573622132-16181-1-git-send-email-gbhat@marvell.com>
Date:   Thu, 14 Nov 2019 17:18:10 +0200
In-Reply-To: <1573622132-16181-1-git-send-email-gbhat@marvell.com> (Ganapathi
        Bhat's message of "Wed, 13 Nov 2019 10:45:31 +0530")
Message-ID: <87v9rmbi6l.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> writes:

> From: Sharvari Harisangam <sharvari@marvell.com>
>
> mwifiex_pcie_fw_dump would read firmware scratch registers, to
> get the size of the dump. It does a vmalloc of memory_size + 1,
> read above, to save the dump. It is possible that the value read
> by  memory_size scratch register be invalid, i.e 0xffffffff. This
> would pass an invalid size(0) to vmalloc. To fix this check for
> invalid scratch register read.
>
> Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
> index fc1706d..483b521 100644
> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
> @@ -2727,6 +2727,13 @@ static void mwifiex_pcie_fw_dump(struct mwifiex_adapter *adapter)
>  			break;
>  		}
>  
> +		if (memory_size == 0xffffffff) {
> +			mwifiex_dbg(adapter, ERROR,
> +				    "Invalid dump size: 0x%x, for %s\n",
> +				    memory_size, entry->mem_name);
> +			return;
> +		}
> +
>  		mwifiex_dbg(adapter, DUMP,
>  			    "%s_SIZE=0x%x\n", entry->mem_name, memory_size);
>  		entry->mem_ptr = vmalloc(memory_size + 1);

So 0xfffffffe would be a valid length for vmalloc()? I doubt that :) A
proper fix would be to add a reasonable maximum for memory_size and
return if it's anything bigger than the limit. Never trust the firmware.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
