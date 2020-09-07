Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278725F8AD
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgIGKnm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:43:42 -0400
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:35908
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgIGKnl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599475418;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=BmjUyQoq0rw+Yy2ywElfw+Z4XNqZZ009J9ibudq+jxI=;
        b=AGm4S86+KmyZu7HQvX1D5FFlvnsGz6A6HFmqvhkJYWZdyvpxFuZWxjSbt202N6uR
        Mr0qJQVZZOGcbsIzULwgKtFraZVJmZEqoVgDP0Ay7gPrXBSm0xC9a7nQkwwYU4vmK72
        Rc1jV1Y/XkwtU1NFfGfLHHS433rRt8xpeDIOYrvg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599475418;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=BmjUyQoq0rw+Yy2ywElfw+Z4XNqZZ009J9ibudq+jxI=;
        b=RhdqFmT6gTAxcsgvaMzWhtqZdCK5s7LzyQ4cFT8MnwXesCJ44Et+NVT5TN5HCi/p
        oo4COz1Rr3nunFBVpmuOkvbeAb+ZRFr5oi2iAYuoTJHM8+M2/+WASJJrY85Ow8HA3Ov
        JcCdaQs6UGpGpjXg59qMWtFLTEGyphv80AAgVkHk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53E40C43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add raw mode and software crypto support
References: <1592281555-31556-1-git-send-email-vnaralas@codeaurora.org>
Date:   Mon, 7 Sep 2020 10:43:38 +0000
In-Reply-To: <1592281555-31556-1-git-send-email-vnaralas@codeaurora.org>
        (Venkateswara Naralasetty's message of "Tue, 16 Jun 2020 09:55:55
        +0530")
Message-ID: <01010174682a05d3-dfa28960-8a01-4b5c-996c-7af937de2db9-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> writes:

> From: Manikanta Pubbisetty <mpubbise@codeaurora.org>
>
> Adding raw mode tx/rx support; also, adding support
> for software crypto which depends on raw mode.
>
> To enable raw mode tx/rx:
> insmod ath11k.ko frame_mode=0
>
> To enable software crypto:
> insmod ath11k.ko cryptmode=1
>
> These modes could be helpful in debugging crypto related issues.
>
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Adds new warnings:

drivers/net/wireless/ath/ath11k/core.c:23:14: warning: symbol 'cryptmode' was not declared. Should it be static?
drivers/net/wireless/ath/ath11k/mac.c:46:14: warning: symbol 'ath11k_frame_mode' was not declared. Should it be static?

> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -13,10 +13,16 @@
>  #include "debug.h"
>  #include "hif.h"
>  
> +extern unsigned int ath11k_frame_mode;

Please move this to core.h

>  unsigned int ath11k_debug_mask;
>  module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
>  MODULE_PARM_DESC(debug_mask, "Debugging mask");
>  
> +unsigned int cryptmode;

static unsigned int ath11k_crypto_mode;

> +module_param_named(cryptmode, cryptmode, uint, 0644);

module_param_named(crypto_mode, ath11k_crypto_mode, uint, 0644);

[...]

> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -34,7 +34,7 @@
>  }
>  
>  /* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
> -static unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
> +unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
>  module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
>  MODULE_PARM_DESC(frame_mode,
>  		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)"

Better to move this to core.c so that all module parameters are in one
place.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
