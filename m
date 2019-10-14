Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B873D5DEB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfJNIxj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 04:53:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfJNIxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 04:53:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A81760721; Mon, 14 Oct 2019 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571043218;
        bh=6KBLNPEabNm8adjApQO4Q9uCQ5Tqng3fu2jIQnGKskQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P0jSq8qaY0GYjm7CwojN9mfnH6HHtqlysPQMJXtbo0dQuBbAMvY1UKyZn2n5AtGZP
         wAG844NllzvEjW3CJF4WMIqtZK6HcXyZZpsTBh4+cBNKVy5SBW6wWvcTxbk/ee39GN
         beStYXb5aM7F+kyASllRPBnu9vDVprwDku2mi0PM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C9CC6039C;
        Mon, 14 Oct 2019 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571043217;
        bh=6KBLNPEabNm8adjApQO4Q9uCQ5Tqng3fu2jIQnGKskQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ot7rNVQJEZjcA8tm8hTNMdKlZwepQNtgqiZ3AT2YWC/7ruQpkv7W9oD0PQNzBXAFA
         Kjrvo8qwhc2AMnG0bLjI9gpg2lkiAQSrbdV1q9ofk875loMwUHEvL0EzedTObh0OPU
         XXueYZnBDVK4SqwhT5CFSvXBEnsRWhfcEu7DXbOE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C9CC6039C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     ath10k@lists.infradead.org, Wen Gong <wgong@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: fix disabling of UART debugging
References: <d492617ed38eb7953401c3171bb3e08c48b7b431.1570976384.git.ps@pks.im>
Date:   Mon, 14 Oct 2019 11:53:34 +0300
In-Reply-To: <d492617ed38eb7953401c3171bb3e08c48b7b431.1570976384.git.ps@pks.im>
        (Patrick Steinhardt's message of "Sun, 13 Oct 2019 16:20:08 +0200")
Message-ID: <875zkrzp0x.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Patrick Steinhardt <ps@pks.im> writes:

> Starting with v5.3.0, it was observed that throughput of an access point
> with QCA988x-based wireless chip is severely degraded from at least
> 10MB/s to roughly 200KB/s. A bisect of the issue points to commit
> 4504f0e5b571 (ath10k: sdio: workaround firmware UART pin configuration
> bug, 2019-04-19), which employs a workaround for a firmware bug in some
> QCA6174 SDIO devices.
>
> If UART debugging is disabled via the "ath10k.uart_print" module
> parameter, then the UART initialization code is skipped. With the new
> workaround introduced in the mentioned commit, devices that need the
> workaround will also re-set the UART pin of the device to avoid a
> failing SDIO interrupt. But in fact, the change effectively removed the
> early return for all devices that do not use the workaround, and as a
> result UART debugging is now unconditionally turned on disregarding the
> value of "ath10k.uart_print", causing the decrease in throughput.
>
> Fix the issue by re-introducing the early return for all devices again,
> independent of the UART pin workaround. Tests show that throughput is
> back to normal levels again with this fix.
>
> Fixes: 4504f0e5b571 ("ath10k: sdio: workaround firmware UART pin configuration bug")
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index dc45d16e8d21..8e4ca231634d 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2125,9 +2125,10 @@ static int ath10k_init_uart(struct ath10k *ar)
>  			ath10k_warn(ar, "failed to set UART TX pin: %d", ret);
>  			return ret;
>  		}
> +	}
>  
> +	if (!uart_print)
>  		return 0;
> -	}

This was fixed in -next with a similar (but not identical) patch, but as
there have been multiple reports of this issues I have now cherry picked
it also for v5.4:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=d79749f7716d9dc32fa2d5075f6ec29aac63c76d

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
