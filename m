Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF7BB0E7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfIWJFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 05:05:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfIWJFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 05:05:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0B5560256; Mon, 23 Sep 2019 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569229522;
        bh=J0jAn93L8O6H3rjtmdAp2j3w5to8tTtp09OT+wjNbwY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=B/VeetzCNpYJW+/3tRk3t8aGIjk4kCpKSKA+XKEv+YPiyOfh6IXGzO/z8WM3ZR6JD
         itsoPgnqk8AnmA6rT7ZyogWU6E/hXMV7tr1EJgHhkISHWbW5zlAPRvT3W6hcOm2CEk
         sGDxVF4NxiOT8VWcxVge/j3pi1lyJq1PKqZgjwMk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E23BF60256;
        Mon, 23 Sep 2019 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569229522;
        bh=J0jAn93L8O6H3rjtmdAp2j3w5to8tTtp09OT+wjNbwY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=B/VeetzCNpYJW+/3tRk3t8aGIjk4kCpKSKA+XKEv+YPiyOfh6IXGzO/z8WM3ZR6JD
         itsoPgnqk8AnmA6rT7ZyogWU6E/hXMV7tr1EJgHhkISHWbW5zlAPRvT3W6hcOm2CEk
         sGDxVF4NxiOT8VWcxVge/j3pi1lyJq1PKqZgjwMk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E23BF60256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <1567679893-14029-4-git-send-email-wgong@codeaurora.org>
Date:   Mon, 23 Sep 2019 12:05:17 +0300
In-Reply-To: <1567679893-14029-4-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:08 +0800")
Message-ID: <871rw79ycy.fsf@codeaurora.org>
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
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -39,7 +39,7 @@
>   * 4-byte aligned.
>   */
>  
> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
>  
>  enum ath10k_htc_tx_flags {
>  	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
> @@ -48,10 +48,16 @@ enum ath10k_htc_tx_flags {
>  
>  enum ath10k_htc_rx_flags {
>  	ATH10K_HTC_FLAGS_RECV_1MORE_BLOCK = 0x01,
> -	ATH10K_HTC_FLAG_TRAILER_PRESENT = 0x02,
> -	ATH10K_HTC_FLAG_BUNDLE_MASK     = 0xF0
> +	ATH10K_HTC_FLAG_TRAILER_PRESENT = 0x02
>  };
>  
> +#define ATH10K_HTC_FLAG_BUNDLE_MASK 0xF0
> +#define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
> +
> +#define ATH10K_HTC_GET_BUNDLE_COUNT(flags) \
> +	    (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
> +	    (FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, (flags)) << 4))

When using FIELD_GET() there should be no need to use '<<', the main id
of FIELD_GET() and BITMASK() is that there's no need do any manual
shifting. So I suspect something is wrong here, but didn't have time to
investigate.

-- 
Kalle Valo
