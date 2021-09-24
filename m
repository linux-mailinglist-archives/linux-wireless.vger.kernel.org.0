Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DCB4176E5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbhIXOg7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 10:36:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21967 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346795AbhIXOg7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632494126; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2VNIZefseQM+LWjqbdsB2hrCthMpgbRSBdCkmDgmon0=; b=KX9wIu1RgqmwIKYjK3mfRI/ohf7C0kU6P1XliEde27OahiZHi7DHuR17Y/OMCP09hQRYba4q
 9ZmeRy312D/tdrrx5N5Nw52cEIw7R2ArqiceQWphn2gJgrYlMGL+R9sT/Sw9edYdW+eFfk9S
 bl0H227yNiAyFErkJp5AL/Mp/eI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 614de22244830700e1e14b85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 14:35:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBBD2C43618; Fri, 24 Sep 2021 14:35:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D4B3C4338F;
        Fri, 24 Sep 2021 14:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3D4B3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: Re: [PATCH 1/4] ath11k: Refactor spectral FFT bin size
References: <20210721180809.90960-1-jouni@codeaurora.org>
        <20210721180809.90960-2-jouni@codeaurora.org>
Date:   Fri, 24 Sep 2021 17:35:07 +0300
In-Reply-To: <20210721180809.90960-2-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 21:08:06 +0300")
Message-ID: <87ee9erqhw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>
> In IPQ8074, actual FFT bin size is two bytes but hardware reports it
> with extra pad size of two bytes for each FFT bin. So finally each FFT
> bin advertise as four bytes size in the collected data. This FFT pad is
> not advertised in IPQ6018 platform. To accommodate this different
> behavior across the platforms, introduce the hw param fft_pad_sz and use
> it in spectral process. Also group all the spectral params under the new
> structure in hw param structure for scalable in future.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.4.0.1-00330-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.c     | 27 +++++++++++++++-------
>  drivers/net/wireless/ath/ath11k/hw.h       |  6 ++++-
>  drivers/net/wireless/ath/ath11k/spectral.c | 13 +++++------
>  3 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3179495cb3c9..2a81a544b6a9 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -59,8 +59,13 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.vdev_start_delay = false,
>  		.htt_peer_map_v2 = true,
>  		.tcl_0_only = false,
> -		.spectral_fft_sz = 2,
> -
> +		.spectral = {
> +			.fft_sz = 2,
> +			/* HW bug, expected BIN size is 2 bytes but HW report as 4 bytes.
> +			 * so added pad size as 2 bytes to compensate the BIN size
> +			 */
> +			.fft_pad_sz = 2,
> +		},
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT),
> @@ -101,8 +106,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.vdev_start_delay = false,
>  		.htt_peer_map_v2 = true,
>  		.tcl_0_only = false,
> -		.spectral_fft_sz = 4,
> -
> +		.spectral = {
> +			.fft_sz = 4,
> +			.fft_pad_sz = 0,
> +		},
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT),
> @@ -143,8 +150,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.vdev_start_delay = true,
>  		.htt_peer_map_v2 = false,
>  		.tcl_0_only = true,
> -		.spectral_fft_sz = 0,
> -
> +		.spectral = {
> +			.fft_sz = 0,
> +			.fft_pad_sz = 0,
> +		},
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  					BIT(NL80211_IFTYPE_AP),
>  		.supports_monitor = false,
> @@ -223,8 +232,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.vdev_start_delay = true,
>  		.htt_peer_map_v2 = false,
>  		.tcl_0_only = true,
> -		.spectral_fft_sz = 0,
> -
> +		.spectral = {
> +			.fft_sz = 0,
> +			.fft_pad_sz = 0,
> +		},
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  					BIT(NL80211_IFTYPE_AP),
>  		.supports_monitor = false,

QCN9074 hw1.0 didn't have an entry. I suspect what happened was that
support for wcn6855 was added between writing the patch and me
committing wcn6855 patches, which confused git.

I changed it so that both qcn9074 and wcn6855 have this:

		.spectral = {
			.fft_sz = 0,
			.fft_pad_sz = 0,
		},

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
