Return-Path: <linux-wireless+bounces-17636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B98A14E83
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C52168856
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528171FDE04;
	Fri, 17 Jan 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZMFOecu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB751D8E12
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113640; cv=none; b=BWNmk5pqBJgLoyvTIbrOtba5p0DinZkbwwESitBnkK7XhPA2WPIohwuwXRI8S4BQs6K6hYrWO4Si63c2yV/h7yM7hWzHSlBdjCUmhWS2gckbmWjPIMXobSuuNLkVctVeVJiFoyfYBc8+Amc0s2uPlwnN+82R6pJffOX6i9WvPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113640; c=relaxed/simple;
	bh=cral7K8HGXuJ5gTB3kx6CYy2wP/os+Q0/GYPuRHBlEo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O1adR8fZhtH90IUoud8WovD7rNBSFXUFFNGloHqd/DGiRfCslNXmTLqlZa67Alm3uC+9rkHcnQlkZ9Rqtwdykoa+8zC73SGodTICNNu4WDAPxVNmIxEaTLjPZ/eTfqVk0fuSqgu+/bKGsJH9M0REx9bGBIE6MLPkdffu64eggZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZMFOecu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283dedso18925655e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 03:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737113637; x=1737718437; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ODjOBO9MtIgABgcwAyfoWf9VIwAipEtpPJ9eBhJRg8=;
        b=HZMFOecu+fS5wPsiPudDZcNpF9eC9yJNZuQI+GFjQnvK5RiiBJ0MPMo7FblzeXTkmQ
         kgBk3a8KYMMziq4ChgX65WKxIjVbnd4Ej5+73XnTU/qahckPy0QHzNQWnOIepq+oOO3x
         nMKoeFEx0pQ+syGc9sEN2Aby2p+iALWktiKuY0ZAD6uFXFGoUWi3knZF/v+NaK4xFWPY
         wcdidVeZH2difNCXEwv6YgBQrwrFRsu50TR96dkhLWYRMIOwJ8XtkzCOsVNRwKiJU785
         LqWwtzHPZKC64kay79n3jWnw9p7uI61DccrLK9QtXhNfpDY7KUplqmUhjt0qH6dtRXkP
         pNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737113637; x=1737718437;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ODjOBO9MtIgABgcwAyfoWf9VIwAipEtpPJ9eBhJRg8=;
        b=MZipNoOeXL+RDBqZVad8tCRsMwb4+gRotrWhoYq4FcuMAHGa1wSNHq1JiK62MVYa6A
         iK/K+V14L0P4ZbiIcmY4a7BBwYZFA4dzdCkbDlcsRVkBiteXJ0kGwkUAAuGLdfi4DHxj
         M6zWIZbWrH9Yx1assKC9WLVv9kRKMEiZqTXJHgpDrhdZME/TdO/X75AjuWuzrRqWp3Ms
         d0564LHlFx3b7/rBs6Z/s5Y5vTrgnruEqmRH8bBS+J0crAZwBYOiYsa2d3NroXMsHywb
         BcJy2uzGaMoQ4K7AJjLOYJ2vIvLV5dGlM9ZZBbhyoYEgvay2avCa1ySyX3ixbUWA2VAO
         Kpmw==
X-Gm-Message-State: AOJu0Yz8kcjv/rE8PIXKo3Q+zy36T12SDqRQzf+j0vm8ePR5HJanYqBQ
	vrhgUtD9LoLOevn1oqNiQ2/+VhYAuUPU3zIJVs9B24vxxjd2UX+kwF0BMQ==
X-Gm-Gg: ASbGncsjzc4FUpPSkMR43T3Q4T8aFm+HfBaydzjybMKSR8Y4HXWqHkw0+iB523bCL5z
	QVdCLV1xk8hSb+ybnF8ImrhUZABKlYVAXSygPgxnVmFa/SC7hj1YpkalEiiV8UGEEtn6bnT1+iP
	DH1P/eQ8oSklw8sYg7r9fkQGcr6J/qTzJ5pg34DyZCj/CAlaVhlFCRmvNQ07NWXdFwCb5w08dqd
	jXZMRRBBKq1q7V9KwWXSaFr4pZkcwzTT+ulx6iPqkWDaa5rTpQWI/NU5P7KpI+QgiyYQykhgPU=
X-Google-Smtp-Source: AGHT+IGvLIKvsqNW/P9Ywv7yw9j5IjfOYKM/JKR7riVV1MLqP/1HvyFrpjCQqxtjOMT0cR+RZvT7fw==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-4389141c12emr20626775e9.22.1737113636530;
        Fri, 17 Jan 2025 03:33:56 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c73e7140sm92797595e9.0.2025.01.17.03.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 03:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 12:33:55 +0100
Message-Id: <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "P Praneesh"
 <quic_ppranees@quicinc.com>
Subject: Re: [PATCH 7/7] wifi: ath12k: add monitor interface support on
 QCN9274
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <20250107021017.3857555-8-quic_periyasa@quicinc.com>
In-Reply-To: <20250107021017.3857555-8-quic_periyasa@quicinc.com>

On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
>
> Currently, the monitor interface is not supported. To support the monitor
> interface, configure the monitor vdev state identifier, configure the HTT
> filter setup, subscribe the mac80211 WANT_MONITOR_VIF feature and prevent
> monitor interface to transmit packet. Therefore, add these procedures to
> add monitor interface support and enable the monitor interface support on
> the QCN9274 platform through the hardware parameter.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-3
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
[...]
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wirele=
ss/ath/ath12k/dp_tx.c
> index b8f0df6f7a05..81d1ff918f48 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights r=
eserved.
>   */
> =20
>  #include "core.h"
> @@ -1277,6 +1277,8 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(st=
ruct ath12k *ar, bool reset)
>  					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
>  					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
>  					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
> +	} else {
> +		tlv_filter.rxmon_disable =3D true;
Shouldn't this be
	tlv_filter =3D ath12k_mac_mon_status_filter_default;
To match de default value ?
>  	}
> =20
>  	if (ab->hw_params->rxdma1_enable) {
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/=
ath/ath12k/hw.c
> index a106ebed7870..021a4b565e8b 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights r=
eserved.
>   */
> =20
>  #include <linux/types.h>
> @@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params ath12k_hw_para=
ms[] =3D {
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT) |
>  					BIT(NL80211_IFTYPE_AP_VLAN),
> -		.supports_monitor =3D false,
> +		.supports_monitor =3D true,
> =20
>  		.idle_ps =3D false,
>  		.download_calib =3D true,
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index abf7c7ed8967..27d44b508884 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1264,6 +1264,12 @@ static int ath12k_mac_monitor_start(struct ath12k =
*ar)
>  		return ret;
>  	}
> =20
> +	ret =3D ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
This is already done a few lines after. Shouldn't the one after be removed
> +	if (ret) {
> +		ath12k_warn(ar->ab, "fail to set monitor filter: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ar->monitor_started =3D true;
>  	ar->num_started_vdevs++;
>  	ret =3D ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
[...]

And this is probably out of the scope of this patch but the code in
ath12k_dp_tx_htt_rx_monitor_mode_ring_config could be simplified by returni=
ng
early if (!ab->hw_params->rxdma1_enable) like in
ath12k_mac_config_mon_status_default.

And that brings the question for me as shouldn't theese two functions shoul=
d be
refactored to share more code

