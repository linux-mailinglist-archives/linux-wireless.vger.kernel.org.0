Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B046F1A7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhLIR2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhLIR2I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:28:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA75C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 09:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7FA17CE2736
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E665C341C7;
        Thu,  9 Dec 2021 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639070671;
        bh=VSoKfdOMvZ0Mat+gtRItv2IWHD8WwiWIfUocuzs8l4k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=e787boEWcioch69eFTNAHUsKQtIPcb0BEMYqF+lyCkf9tYVgcsU2bbuii+F6BfqNa
         Yd8nz1eDJCaIvYW6UbcBD7senIRWObe1UencknH1kl5w19/h73LonM/tbRtWivDVJM
         PUEyAGOS1u5X3wbrNJvcm2D3dkHggXDx/wbU5Q2Rht/0aWSAaw5SivekGMkVRIe0IU
         k0e2G0U0oUyeDjkQQ0Qvxrd/kkcjpMgRfQr5RNB1fa1XnZBNvNcDgu7ts9zI3rSVtX
         u8ytIpS2cx13gArlrRU8AVWiaP4ty+CZMn5hNNNeUiCef3YoJt8zFBDmdluDk5hftA
         qBw1oh0P3YIdw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/15] ath11k: allow only one interface up simultaneously for WCN6855
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-5-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:24:28 +0200
In-Reply-To: <20211026111913.7346-5-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:02 -0400")
Message-ID: <877dcdwv1v.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Currently ath11k support both station/AP mode for WCN6855, and it is
> configured with single_pdev_only, it means it has only one ath11k
> and one ieee80211_hw which registered in mac80211 and one wiphy
> registered in cfg80211. Now it does not have requirement to start
> up both station and AP interface simultaneously for WCN6855, this
> is to disable station and AP concurrency mode.
>
> After this patch, when station interface is up, then AP interface
> can not start up. AP interface can start up after station interface
> down. Also when AP interface is up, station interface can not start
> up. station interface can start up after AP interface down.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.h |  5 +++++
>  drivers/net/wireless/ath/ath11k/mac.c  | 17 ++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index a65f7d00eea2..e6c4963e41ac 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -972,4 +972,9 @@ static inline bool ath11k_support_cc_ext(struct ath11k_base *ab)
>  	       test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT, ab->wmi_ab.svc_map);
>  }
>  
> +static inline bool ath11k_support_6G_cc_ext(struct ath11k *ar)
> +{
> +	return ath11k_support_cc_ext(ar->ab) && ar->supports_6ghz;
> +}

All lower case and please move also this to hw.h:

ath11k_hw_supports_6g_cc_ext()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
