Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D8E2BD7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438039AbfJXIOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 04:14:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJXIOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 04:14:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C64F60FB7; Thu, 24 Oct 2019 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571904883;
        bh=5mC2bcaVDbhxJnEGAHvlCjQq62O7TRVKlkrwqnUNv18=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KvHNlICxmAl0QOloGWboxxs7bTdjZDfMoe544Lcbm/MRj6mYK3AB+2EYNIapdFNwG
         akTWFO3P7w4i5z9rthzfHde5abREo7TSfyJlI/HRpQpWuIUcJpcnhTTLzwC8YZmeIW
         y1oae5WEogAJQMy0J3v9VeIa3xvZxdo2WMYpgBJ0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D47166081C;
        Thu, 24 Oct 2019 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571904882;
        bh=5mC2bcaVDbhxJnEGAHvlCjQq62O7TRVKlkrwqnUNv18=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D2P8+6uHO7/w0aunlzHk9QkeWcReoADnBdEv7j/b72XafqbGRdiWwNDKAyq7bsaIM
         bxb/fs7NezZsApRWxsq3zszaK5HWvkxk8v9hdPLCeix9EgxWMPf2xf+wzI5Gk8tN4u
         vnA5bw0xpXFQOtQM8nz1SmGEM+4+wjo8RAyhH1HA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D47166081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
Date:   Thu, 24 Oct 2019 11:14:39 +0300
In-Reply-To: <1569402639-31720-4-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:39 +0800")
Message-ID: <871rv2tv9s.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> For RX, it has two parts, one is to read data from sdio, another
> is to indicate the packets to upper stack. Recently it has only
> one thread to do all RX things, it results that it is sequential
> for RX and low throughout, change RX to parallel for the two parts
> will increase throughout.
>
> This patch move the indication to a workqueue, it results in
> significant performance improvement on RX path.
>
> Udp rx throughout is 200Mbps without this patch, and it arrives
> 400Mbps with this patch.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/sdio.h
> +++ b/drivers/net/wireless/ath/ath10k/sdio.h
> @@ -98,6 +98,12 @@
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_ON 0x10000
>  
> +struct ath10k_sdio_rx_request {
> +	struct list_head list;
> +	struct sk_buff *skb;
> +	struct ath10k_htc_ep *ep;
> +};

This is not used anymore, I removed it in the pending branch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
