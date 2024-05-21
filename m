Return-Path: <linux-wireless+bounces-7874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F298CA976
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F77BB221FA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECBD5E22C;
	Tue, 21 May 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUXgJErR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0AF5E099
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278265; cv=none; b=LcixYHsVY1JWkNQ+ycdld2iKloT4bSE2Aht7ecNepLGSOcumpqFPIA49JSvN3x7wVIakvcpYfYrb9on4boP9Eedol3NQpSrc0JiNwzHb66pfXQTQNTz0pv4Dy2PYMFMtMGofpUa+VqN9qurUj4TElR47bzb8Jikd5aXNrgOAOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278265; c=relaxed/simple;
	bh=MAdx8Mdn59U5MBMX6ChvO9+b/TWwcpyF+wMtPtUy4X4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GjWnpB/VUTKASboXAdr0NyTKZjeFpw/NsCRAycTuJ2INacWGTB11myhZhI6KSMnGVEO60iuU05HjLZdyLzVTTE+7RHuxxJSxbbdnU84M4XhRCQgHCymEwv5MwhE6p2iXN3sparJyPaceb8ZkHruotUxb3xFVy93rAwESkMOkOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUXgJErR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8ACC2BD11;
	Tue, 21 May 2024 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716278264;
	bh=MAdx8Mdn59U5MBMX6ChvO9+b/TWwcpyF+wMtPtUy4X4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AUXgJErRpQChC99frxsYW/Z8RGKJhzwHy1ZjZktzWV0XH9SiOZPso0FGH4GnjAwqU
	 +3owAbbqxaxxKJxe/+RWXU68AXW5zMEfBzKf7tqhMzvuBlKQ/gavhfedxyI8eT1DcS
	 JLI+yN9wddNByT162UzqFv9f9qg68pc60QBpL3rMEr5TTqEGJto7A2YXhJY3wTf+b0
	 xewdENv/Og0rSSZDqt3lqJbg2DJNgETCmZKX5SWXFP9l97PjhqxrADR9Q+wPd0iCPa
	 phjcE19mkSFLb0PbwJxZzUkIXQVapzWyiATgLPXANnzsQaMe8M1w0Httpzw+34/ZGq
	 XN5+Ba72gaE2Q==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,  Lingbo
 Kong <quic_lingbok@quicinc.com>
Subject: Re: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request
 for WCN7850
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-4-quic_rgnanase@quicinc.com>
Date: Tue, 21 May 2024 10:57:42 +0300
In-Reply-To: <20240510050806.514126-4-quic_rgnanase@quicinc.com> (Ramya
	Gnanasekar's message of "Fri, 10 May 2024 10:38:04 +0530")
Message-ID: <87pltfd2bt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> From: Lingbo Kong <quic_lingbok@quicinc.com>
>
> Pdev id from mac phy capabilities will be sent as a part of
> HTT stats request to firmware. This causes issue with single pdev
> devices where fimrware does not respond to the stats request
> sent from host.
>
> Single pdev devices firmware expects pdev id as 1 for 5GHz/6GHz
> phy and 2 for 2GHz band. Handle pdev id for single phy device
> while sending HTT stats request message to firmware.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

[...]

> @@ -1029,7 +1030,12 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
>  	memset(cmd, 0, sizeof(*cmd));
>  	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
>  
> -	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
> +	if (ab->hw_params->single_pdev_only)
> +		pdev_id = ath12k_mac_get_target_pdev_id(ar);
> +	else
> +		pdev_id = ar->pdev->pdev_id;

Wouldn't it be cleaner to have the single_pdev_only check in
ath12k_mac_get_target_pdev_id()?

> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	struct ath12k_pdev *pdev;
> +	struct ath12k_vif *arvif;
> +	int i;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		pdev = &ab->pdevs[i];
> +		ar = pdev->ar;
> +		list_for_each_entry(arvif, &ar->arvifs, list) {
> +			if (arvif->is_up)
> +				return arvif;
> +		}
> +	}
> +
> +	return NULL;
> +}

I'm not seeing any protection here, is that on purpose?

> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar)
> +{
> +	struct ath12k_vif *arvif;
> +
> +	arvif = ath12k_mac_get_vif_up(ar->ab);
> +
> +	if (arvif)
> +		return ath12k_mac_get_target_pdev_id_from_vif(arvif);
> +	else
> +		return ar->ab->fw_pdev[0].pdev_id;
> +}

No need to have else after return.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

