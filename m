Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CEE2D35
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408870AbfJXJ0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:26:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408862AbfJXJ0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:26:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE25A60E74; Thu, 24 Oct 2019 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571909162;
        bh=PEIzFpY5nGoLIIuQICN1TfB401FhrK5IFQmaG/eMnIw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nonE0+yPs0N9wR+WGHpRlkudTdHf95ffZa36svk3dWZpuk4RQznq4saHlb3V6iPXg
         J3F2HmV+KJOSDsC1cHh21WnahreT3k6CwzNuflkY9hJANpr0v6gGJK1TtNJCfmH5A2
         5Blo0FhrebGVd2SuVj2xLe5Bej3DR/ZaS2/1fRPA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2730A6081C;
        Thu, 24 Oct 2019 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571909162;
        bh=PEIzFpY5nGoLIIuQICN1TfB401FhrK5IFQmaG/eMnIw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nonE0+yPs0N9wR+WGHpRlkudTdHf95ffZa36svk3dWZpuk4RQznq4saHlb3V6iPXg
         J3F2HmV+KJOSDsC1cHh21WnahreT3k6CwzNuflkY9hJANpr0v6gGJK1TtNJCfmH5A2
         5Blo0FhrebGVd2SuVj2xLe5Bej3DR/ZaS2/1fRPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2730A6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
Date:   Thu, 24 Oct 2019 12:25:58 +0300
In-Reply-To: <1569402639-31720-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Wed, 25 Sep 2019 17:10:38 +0800")
Message-ID: <87r232sdeh.fsf@kamboji.qca.qualcomm.com>
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
> ---
>  drivers/net/wireless/ath/ath10k/htc.h  | 12 +++++++++---
>  drivers/net/wireless/ath/ath10k/sdio.c |  4 ++--
>  drivers/net/wireless/ath/ath10k/sdio.h |  4 ++--
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index f55d3ca..7055156 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -39,7 +39,7 @@
>   * 4-byte aligned.
>   */
>  
> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32

So how do I know that this change doesn't break any other hardware? I
did a quick review and I think it's safe, but the commit log mentions
nothing about this.

Please clarify and I can update the commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
