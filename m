Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDEE2E1A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbfJXKGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 06:06:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJXKGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 06:06:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D07A60134; Thu, 24 Oct 2019 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571911559;
        bh=KzgCcuMZO8K844GlsK2yNsEGh+11mPBRcWET/19MD+E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kdf88FKGc45bWbymtLiitwLwaG+CbtpUdXFdWnqsLhbeof9SQFxGDhjyqvu8N5eU9
         +UT7tpQMCuMD9xFJ1oQcKA61a9id+vjDQZbtgsy9ca9NLY0G7VqqlVmp6keTObwiJE
         r6eKQ+82bWyDN3TjZD2cfukqD0WTkucAMrWv6FSc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C31C6606CF;
        Thu, 24 Oct 2019 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571911556;
        bh=KzgCcuMZO8K844GlsK2yNsEGh+11mPBRcWET/19MD+E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cYHopb926186KOTXqqPmy74r7zwUKy0qcZqNZsAmCYvUzno4sZtF+DQ6UlPIdL40t
         wsH01wvxHMQMubeC3wKp2/xy1zriQulFKHicO7+KsrmLbhFiOtF2VxGMe7Lz94qDJH
         3VvXlhjkd9qIpr6k/hCOnwTCWoZFNknUkWoVLBV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C31C6606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
Date:   Thu, 24 Oct 2019 13:05:53 +0300
In-Reply-To: <1569402639-31720-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:38 +0800")
Message-ID: <87h83ysbjy.fsf@kamboji.qca.qualcomm.com>
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

I left the comma in ATH10K_HTC_FLAG_TRAILER_PRESENT to make the diff cleaner.

> +#define ATH10K_HTC_FLAG_BUNDLE_MASK 0xF0
> +#define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
> +
> +#define ATH10K_HTC_GET_BUNDLE_COUNT(flags) \
> +	    (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
> +	    (FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, (flags)) << 4))

I think I asked you about the shift of 4 bits earlier but now I figured
it out (I hope) and documented it like this:

#define ATH10K_HTC_FLAG_BUNDLE_MASK GENMASK(7,4)

/* bits 2-3 are for extra bundle count bits 4-5 */
#define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
#define ATH10K_HTC_BUNDLE_EXTRA_SHIFT 4

static inline unsigned int ath10k_htc_get_bundle_count(u8 flags)
{
	unsigned int count, extra_count;

	count = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, flags);
	extra_count = FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, flags) <<
		ATH10K_HTC_BUNDLE_EXTRA_SHIFT;

	return count + extra_count;
}

As you can see I also changed the macro to a function, as I prefer C
over CPP :) And changed ATH10K_HTC_FLAG_BUNDLE_MASK to use GENMASK().

But this only compiled tested, please do properly test the patches from
pending branch and let me know if I broke something:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=afd85ca1b086695cfd26bf484442eaf3bccb6bdd

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4225b4d50a4f6a1159dc3316d068398f1b5edb57

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=911e0fc846cfc46fb4ccd1d223cb153681ff05bd

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
