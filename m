Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62C46F1F1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhLIRfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:35:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55184 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbhLIRfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:35:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41503B825CB
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBE0C004DD;
        Thu,  9 Dec 2021 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071100;
        bh=2sMKu6K0g4R58m4Hl+ABuM+nN6o644dd5GifgETmVFg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uCSste/0TXtDBvYlF6L5Wxhk0AWwxXF//nirLtSHU8PwnoS0dOQDK9ruJGGZcWFOL
         /DEnyTuUiIJ9WGmYhJerDPEgTKudNtK4ijGs2Z844emjTrhOKPEk0/fkiOc5EQbSee
         r/U4hbEgY+Rom2sBCoXIgMfWGBzQ7ER+pGlbsYMaSlzTHjvilYDJ/7XptAYC64rwlK
         zm47uGatO/zMsckbMeAP+E3PVxgLaqhJSemMY2qlq3sC1AJ/EorAdw+LHxhFbXqLBP
         o11qXCg5JcUdt/Q8BJRVo40AUVJGR8wcuUv9R2EYRzB5XnoiZcJrn1C/yLrCwb0ohz
         ZtgZ2fHRq3zBQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 05/15] ath11k: store cur_regulatory_info for each radio
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-6-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:31:35 +0200
In-Reply-To: <20211026111913.7346-6-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:03 -0400")
Message-ID: <8735n1wuq0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
> in ath11k now, the info should be saved in ath11k. Save the info for
> each radio and support switch regulatory rules dynamically.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c |   9 ++
>  drivers/net/wireless/ath/ath11k/core.h |   1 +
>  drivers/net/wireless/ath/ath11k/mac.c  |  11 +++
>  drivers/net/wireless/ath/ath11k/mac.h  |   2 +-
>  drivers/net/wireless/ath/ath11k/wmi.c  | 117 +++++++++++++++++--------
>  drivers/net/wireless/ath/ath11k/wmi.h  |   6 +-
>  6 files changed, 106 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 66ceef24532d..d8ac26f730db 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1115,6 +1115,15 @@ EXPORT_SYMBOL(ath11k_core_deinit);
>  
>  void ath11k_core_free(struct ath11k_base *ab)
>  {
> +	if (ab) {

Why this check? Is someone calling ath11k_core_free() with NULL?

> +		int i;
> +
> +		for (i = 0; i < ab->num_radios; i++)
> +			ath11k_reg_reset_info(&ab->reg_info_store[i]);
> +
> +		kfree(ab->reg_info_store);
> +	}
> +

I would expect ath11k_core_free() to free stuff allocated by
ath11k_core_alloc(), so I'm not sure if this is the right location. What
about ath11k_reg_free()?

> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -4205,6 +4205,10 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
>  		soc->pdevs[0].pdev_id = 0;
>  	}
>  
> +	soc->reg_info_store = kcalloc(soc->num_radios,
> +				      sizeof(*soc->reg_info_store),
> +				      GFP_ATOMIC);

What if there are two events from firmware? That means the first
allocation is lost, no? I think there should be some kind of error checking.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
