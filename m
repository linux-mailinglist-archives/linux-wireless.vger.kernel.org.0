Return-Path: <linux-wireless+bounces-1631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCD828702
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7711C2400A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB59938F8C;
	Tue,  9 Jan 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5rpfoXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04ED38F8A
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E22C433C7;
	Tue,  9 Jan 2024 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704806727;
	bh=hWfC3nwISNlU43qKaia8bNnTVYDPxraQ0ILBp0ZN2G8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=L5rpfoXxeKVSgRUX6cjdFvnqnvKJ+/DcNjUzTM/KiJfiakgtGLh2clmsc9LzSIdVY
	 1a0iry9fYA7Y090SR8z+1XVu7MjUfXtFq+a1Eifg49qtNyDsGYsWzsHc8TaAytnmlC
	 ASFiCqAQI3/LwpPYoph1LrqmFPGXOY6W5l1viCTMguJ8OAIYVjXnywJjpnho5YAExF
	 FbUXxWZB6SXQm6Zqfd63LUbBqnok0tM/C+L04f2gSsobHaWYQMM1qxrDS+vJdOYLL6
	 eiofV7zDX2xO6jWTPU6qmrqmR3PWNff9RoHpRHdNXOyrpM86vxlFBc9iBKoKzO/Gg/
	 4d8E91iVLLPHg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper function
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
	<20231206034920.1037449-5-quic_periyasa@quicinc.com>
Date: Tue, 09 Jan 2024 15:25:24 +0200
In-Reply-To: <20231206034920.1037449-5-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Wed, 6 Dec 2023 09:19:20 +0530")
Message-ID: <87bk9uej0b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the mac80211 hw registration procedure is tightly coupled with
> the handling of link/radio (ar). Define a new helper function to separate
> the link/radio handling from the mac80211 hw registration procedure for
> improved code readability. Also, it can be easy to scale these
> functionality to support single/multi link operation in the future.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c |  61 +++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.c  | 132 ++++++++++---------------
>  drivers/net/wireless/ath/ath12k/mac.h  |   4 +-
>  3 files changed, 109 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index e10c5f2cd8eb..d1ac00c59b8c 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -498,11 +498,62 @@ static void ath12k_core_soc_destroy(struct ath12k_base *ab)
>  	ath12k_qmi_deinit_service(ab);
>  }
>  
> +static int ath12k_core_mac_register(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	struct ath12k_pdev *pdev;
> +	int i;
> +	int ret;
> +
> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
> +		return 0;
> +
> +	/* Initialize channel counters frequency value in hertz */
> +	ab->cc_freq_hz = 320000;
> +	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		pdev = &ab->pdevs[i];
> +		ar = pdev->ar;
> +
> +		ret = ath12k_mac_hw_register(ar);
> +		if (ret)
> +			goto err_cleanup;
> +	}
> +
> +	return 0;
> +
> +err_cleanup:
> +	for (i = i - 1; i >= 0; i--) {
> +		pdev = &ab->pdevs[i];
> +		ar = pdev->ar;
> +		ath12k_mac_hw_unregister(ar);
> +	}
> +
> +	return ret;
> +}

Is there a reason why you moved these two functions from mac.c to
core.c? This is mac level code anyway, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

