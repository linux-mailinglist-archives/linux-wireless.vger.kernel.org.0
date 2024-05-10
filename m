Return-Path: <linux-wireless+bounces-7456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C798E8C25A9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544C8285710
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E54127E0D;
	Fri, 10 May 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dXEetvEQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853C5339E
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347606; cv=none; b=p6M67Kn2AYCq+bp3iXyOEgfKSJYRyVXAvkLbVltwwSiVMGAHmG0eP76aV5RiyYdr1wcDoptTC/hGw4z+0yXnboiY3EOTO2w1jMlbJ9T2ytcS4lcIRbKko76iBUZwRh2mXRUgLvKaW9t22QXb0LpTecdSkkDLtNIChWc7YKtftiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347606; c=relaxed/simple;
	bh=5d4vHDkLSPfLDV5AI9wfw6UEj/DZJ5Yv6/66yBGcwXE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X8LlvVIra2Lplcbh5LggFKzIeN8tQGOyxWBYTAK+2dTNFru42wO7fbqLIllBXpefX60LV9KVIamSj077rxNI8Uj3dNlIF8k0qTvlVCxsih9uBt81KywnKX5UBt6cBIFlvlpgpktg5dPEiDelTMa/xBafD2s3ZiBWDRiTIQMZgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dXEetvEQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a64db066so526517166b.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1715347603; x=1715952403; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iIlXXeFM7yBqzEBZlBlI1pxa1tOOAauSQu/IN4LvIo=;
        b=dXEetvEQ1WBtETVHEWou8PMjwjZUodkJnC6XMb59qh/2Iphs6ToCmfNQTRgfAWkcEy
         eReRyt4u/vC8v0cbq0VbY6tcNg5R+WV9a0Nhh8FGjwEP7QDVl/8GeBFwnD+JEbuWS5Wk
         9Arzzf4W1fB2yt0s/u1OL1YJlminwynV76ga/f7hg5g9ajEttiNR+6Ej1+oJ1Q8i1Ne+
         pHoqOVn3zqZtk7COA2qlLZiYpu875JTHlHRYnBbJRfCY142QimSd7CA70EoN5m13p9bT
         A3HHHAGfUvO2XMZ+4nIHud03YKAuoEOYKD246EPY+AB0W8YVWI0lf5phcClNOzn+UDV1
         +CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715347603; x=1715952403;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0iIlXXeFM7yBqzEBZlBlI1pxa1tOOAauSQu/IN4LvIo=;
        b=DlDjjj3ZHUekFnw1Qfn81dhQqWOZxbE+SzaFynq1RyxFJ3R1Cq9IYn56IjvYA/jprx
         Bm6YBKqOHof6Bb5UjeSfGmJ0/HeupQ/Ua0YCALcbKkfRTzZCzEfpBFLR9lci32zSmsib
         mRHnKAMSQjD5kvOnE+H9zaee94ry9HJaCKY3b5ntKVs7fHp/emdY4As7ArVMZ+4P8X89
         6Vgdza9AYwbDB5HHK67G6Jw7IPi/SxuyHLqWQmVfilVLo/JBaHP5AMZlyd1eM7O/bf/j
         R+9eF+7P0NcgzmIu6B/p4q6H7gpkxhe3nVU8Fm0d+aLFczvJsUvaOyO00yDKYV1Q/IVb
         4lsg==
X-Forwarded-Encrypted: i=1; AJvYcCWi79t6McQfeAJP348TVk7STdB/xb6KKu0JCCzud+uEqnhaklbXrLhT//+jO0VCkMKOhCAq++JQO7f70DDGEA2o+Vu8B57vWQAUWVJMB3o=
X-Gm-Message-State: AOJu0YwpKp+iu4Ve6nbQLk45uhBgeCQzRTCFfaRckHSed1oco/JJdXhv
	FjqdpjSel8frNONhxugYMUGDA0N7gjMjML+nX1B4iVG+R1twq99QjGj8RJWpAEM=
X-Google-Smtp-Source: AGHT+IGTi4pxk95vdybc0kHmR4dKJTKOp0Y7wf8e3ELehw3lkLTRS1ItaNDJRp+5wnTDxpAHk3wDmg==
X-Received: by 2002:a17:906:3183:b0:a59:b784:ced4 with SMTP id a640c23a62f3a-a5a2d67873fmr189388166b.75.1715347603450;
        Fri, 10 May 2024 06:26:43 -0700 (PDT)
Received: from localhost (2a02-a210-20ba-5a00-9ceb-707b-2d57-26f7.cable.dynamic.v6.ziggo.nl. [2a02:a210:20ba:5a00:9ceb:707b:2d57:26f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d2bsm183791166b.120.2024.05.10.06.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 May 2024 15:26:42 +0200
Message-Id: <D15ZZ5V3YU6Z.10FO9XK11WXFB@fairphone.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Carl Huang" <quic_cjhuang@quicinc.com>, "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.17.0
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com>
In-Reply-To: <4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com>

On Fri May 10, 2024 at 3:04 PM CEST, Carl Huang wrote:

<snip>

> > Kalle, looks we're not able to fix it before Sunday as I don't have=20
> > WCN6750 setup to verify the fix. The fix could be to define a dedicated=
=20
> > function ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the=20
> > patch out so others like Luca can have a try.
> >=20
> Sorry, I have problem to run "git send-email" as it prompts "5.7.60=20
> SMTP; Client does not have permissions to send as this sender".
>
> The patch looks like:
>
>  From 19bb7f1377a5e3c5d42ab2bedbaf9e976c1068b4 Mon Sep 17 00:00:00 2001
> From: Carl Huang <quic_cjhuang@quicinc.com>
> Date: Fri, 10 May 2024 19:40:37 +0800
> Subject: [PATCH] wifi:ath11k: fix WCN6750 firmware crash
>
> WCN6750 firmware crashed because of vdev_number changed to 3 from 4
> in commit f019f4dff2e4("wifi: ath11k: support 2 station interfaces").
>
> Fix it by defining a separate function ath11k_init_wmi_config_wcn6750()
> for WCN6750 to initialize its' specific parameters.
>
> Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
> Tested-on: WCN6855 hw2.0 PCI=20
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>

This seems to work fine also.

Tested-on: wcn6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1

Regards
Luca

> ---
>   drivers/net/wireless/ath/ath11k/hw.c | 49 +++++++++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/hw.c=20
> b/drivers/net/wireless/ath/ath11k/hw.c
> index caa6dc12a790..df8822ac3be1 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.c
> +++ b/drivers/net/wireless/ath/ath11k/hw.c
> @@ -102,6 +102,53 @@ static void ath11k_init_wmi_config_qca6390(struct=20
> ath11k_base *ab,
>   	config->flag1 |=3D WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
>   }
>
> +static void ath11k_init_wmi_config_wcn6750(struct ath11k_base *ab,
> +					   struct target_resource_config *config)
> +{
> +	config->num_vdevs =3D 4;
> +	config->num_peers =3D 16;
> +	config->num_tids =3D 32;
> +
> +	config->num_offload_peers =3D 3;
> +	config->num_offload_reorder_buffs =3D 3;
> +	config->num_peer_keys =3D TARGET_NUM_PEER_KEYS;
> +	config->ast_skid_limit =3D TARGET_AST_SKID_LIMIT;
> +	config->tx_chain_mask =3D (1 << ab->target_caps.num_rf_chains) - 1;
> +	config->rx_chain_mask =3D (1 << ab->target_caps.num_rf_chains) - 1;
> +	config->rx_timeout_pri[0] =3D TARGET_RX_TIMEOUT_LO_PRI;
> +	config->rx_timeout_pri[1] =3D TARGET_RX_TIMEOUT_LO_PRI;
> +	config->rx_timeout_pri[2] =3D TARGET_RX_TIMEOUT_LO_PRI;
> +	config->rx_timeout_pri[3] =3D TARGET_RX_TIMEOUT_HI_PRI;
> +	config->rx_decap_mode =3D TARGET_DECAP_MODE_NATIVE_WIFI;
> +	config->scan_max_pending_req =3D TARGET_SCAN_MAX_PENDING_REQS;
> +	config->bmiss_offload_max_vdev =3D TARGET_BMISS_OFFLOAD_MAX_VDEV;
> +	config->roam_offload_max_vdev =3D TARGET_ROAM_OFFLOAD_MAX_VDEV;
> +	config->roam_offload_max_ap_profiles =3D=20
> TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
> +	config->num_mcast_groups =3D 0;
> +	config->num_mcast_table_elems =3D 0;
> +	config->mcast2ucast_mode =3D 0;
> +	config->tx_dbg_log_size =3D TARGET_TX_DBG_LOG_SIZE;
> +	config->num_wds_entries =3D 0;
> +	config->dma_burst_size =3D 0;
> +	config->rx_skip_defrag_timeout_dup_detection_check =3D 0;
> +	config->vow_config =3D TARGET_VOW_CONFIG;
> +	config->gtk_offload_max_vdev =3D 2;
> +	config->num_msdu_desc =3D 0x400;
> +	config->beacon_tx_offload_max_vdev =3D 2;
> +	config->rx_batchmode =3D TARGET_RX_BATCHMODE;
> +
> +	config->peer_map_unmap_v2_support =3D 0;
> +	config->use_pdev_id =3D 1;
> +	config->max_frag_entries =3D 0xa;
> +	config->num_tdls_vdevs =3D 0x1;
> +	config->num_tdls_conn_table_entries =3D 8;
> +	config->beacon_tx_offload_max_vdev =3D 0x2;
> +	config->num_multicast_filter_entries =3D 0x20;
> +	config->num_wow_filters =3D 0x16;
> +	config->num_keep_alive_pattern =3D 0;
> +	config->flag1 |=3D WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
> +}
> +
>   static void ath11k_hw_ipq8074_reo_setup(struct ath11k_base *ab)
>   {
>   	u32 reo_base =3D HAL_SEQ_WCSS_UMAC_REO_REG;
> @@ -1102,7 +1149,7 @@ const struct ath11k_hw_ops wcn6855_ops =3D {
>
>   const struct ath11k_hw_ops wcn6750_ops =3D {
>   	.get_hw_mac_from_pdev_id =3D ath11k_hw_ipq8074_mac_from_pdev_id,
> -	.wmi_init_config =3D ath11k_init_wmi_config_qca6390,
> +	.wmi_init_config =3D ath11k_init_wmi_config_wcn6750,
>   	.mac_id_to_pdev_id =3D ath11k_hw_mac_id_to_pdev_id_qca6390,
>   	.mac_id_to_srng_id =3D ath11k_hw_mac_id_to_srng_id_qca6390,
>   	.tx_mesh_enable =3D ath11k_hw_qcn9074_tx_mesh_enable,


