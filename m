Return-Path: <linux-wireless+bounces-17651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3824A15061
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F22188AE8E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706E91FCCEE;
	Fri, 17 Jan 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlX5b9WS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF61FC0FE
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120057; cv=none; b=X3GPnmYy+vMJM6zETulexsd9yV4dRj3qY5jMUP1gpME/ouqjYuTv/iinmIP/uFvJ0swwcTEuzPI3fotycwHaSLBRgmwqv+HCnaA0GsfA1aDnHJ6pSV8ishsyrgCwH0GtJt6x5EkPYQrJIGodOj0RIRws6ZbCKnUvbFHI2RslKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120057; c=relaxed/simple;
	bh=INNt2iN7dhkuHHGQULUSI896yoE8LadU1uscSaKaf+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YVT/h1Zd4yyhPSlfjr3a4SF5aLm2jUDfvEK3eoeDzKfymsVEapXvYXHCfInUjRcl/tYUTkdiHn8G6JJq7vpFBdu1VtKEGHqonsumBSs+UxeIL1+9Teaw9KMLELaGO0SmE2CiXCqD+X3OTVGJhrum8uOCcXNe09a4/Drn/RabNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlX5b9WS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1148049f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 05:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737120054; x=1737724854; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfJlQTQQhWbDiL9fmUkK21l5xX6jcHy8qrdZG/LzuZI=;
        b=LlX5b9WSbNnG3AXq2wNqtPYGa+F1H6AO/EYkRkBTx2N+kLc4TXnlo00xwZoaC306tx
         8sMUJf3RWuM27SBp6drp+g2SViIJOrVjl6mBvSJZZ7iQTsPuHBsg4ZVLq5M/Rza2niI4
         HBtxKv5vXVIx5nwKW6XRSMLNM6YJAMNLbhz13xCcMHCnr5F3/+lOhusaUqyTOhdQE/xK
         jB2/ygNEllzZ6sTjHQWn5H1h80Ix5v2jYHa9lGbmFtoGkhEYS0gf7E/Z9ic3f7XZZN0d
         uEpOsKVLK5tX3IBNZOqTuZQHpW4zBr8DFvyoy7kQ4DoDqlZDgQU7D61Y8gjX0LCtAu3y
         /HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737120054; x=1737724854;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hfJlQTQQhWbDiL9fmUkK21l5xX6jcHy8qrdZG/LzuZI=;
        b=GPIcqb++dytGxmvbVhpeYgJBStH0SeSRuIz93VqrWB9n+0/sQJiw3f1jfRgUkFJink
         jGgNvs3/dVk3tnsKApBhPvymCRk6F94XRAC7TVtJML5khr01O83y8NtRc63PV1rSgFsT
         hFL11DcLjJA6kGHqOUtWuD7Qna4DiFrW/1Fx0Wb5JP8SlBkfATz7yZve8ZxqsXQhclTC
         T4V9rz0Vgus4R6kEwfVKA2RRrR0SeyMKJP8cktfJRsegCU6F9KZJb5PMOIdJ3A0jf+nA
         pp+syVx6/N4Zx4wWIy41uXiElLwzvyHMtVwZzs68oQp1IVMwJLXCY4yon/F1an6GpEFm
         zqWw==
X-Gm-Message-State: AOJu0YxriPgX4itAkquXWA65jUDlHenMpkPMJir8ATVx3k1iYSZcpuE/
	R60z/G8Mq11imEkCwhjGtzH3z8t6Uzdbd+wMEweMyS0w4GJWKQ2SRuv0mQ==
X-Gm-Gg: ASbGnctzVSdZO3S7CjyqK94WrU3PwAoCHLHrTwmyL/ADIH24/uUSLdwJnRfM9JiKXCk
	0u+zhFts55NfGOr3eep8TyoO/uZeJFXjLZSj0zyCjKCWKkMSiDVKyAaeehioXiBVC3YzB4I1t9W
	QuZ1gvSdJZttLYiplrG2whXJbtFMIdG2mutioMo0QvG3zMewnG4wZp5IU70lKYnEIRVCh/Fg4FM
	NFOZFPkQV5Ls0oynGf6gtrMOYt2JPDTQyTtLmf9lJ8jusUhZliVCmdBZzYQpQZncWX2hJovuG8=
X-Google-Smtp-Source: AGHT+IET08LbJkQIdNwZn5g6V1QN+ENLUJkPyo7v6eJJj3nnTntFiYomed6Uvoworcy2Nk6SE8fOlg==
X-Received: by 2002:a5d:5f4d:0:b0:386:2aba:a7f6 with SMTP id ffacd0b85a97d-38bf57c0618mr2480861f8f.49.1737120053690;
        Fri, 17 Jan 2025 05:20:53 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm2547988f8f.10.2025.01.17.05.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 05:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 14:20:52 +0100
Message-Id: <D74DNZH2FACA.1EWK96IOHSY6I@gmail.com>
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
 <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
 <e713770a-2032-f007-f828-d24935b042e2@quicinc.com>
In-Reply-To: <e713770a-2032-f007-f828-d24935b042e2@quicinc.com>

On Fri Jan 17, 2025 at 2:06 PM CET, Karthikeyan Periyasamy wrote:
>
>
> On 1/17/2025 5:03 PM, Nicolas Escande wrote:
> > On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
> >> From: P Praneesh <quic_ppranees@quicinc.com>
> >>
> >> Currently, the monitor interface is not supported. To support the moni=
tor
> >> interface, configure the monitor vdev state identifier, configure the =
HTT
> >> filter setup, subscribe the mac80211 WANT_MONITOR_VIF feature and prev=
ent
> >> monitor interface to transmit packet. Therefore, add these procedures =
to
> >> add monitor interface support and enable the monitor interface support=
 on
> >> the QCN9274 platform through the hardware parameter.
> >>
> >> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> >> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.=
0_SILICONZ-3
> >>
> >> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> >> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> >> ---
> > [...]
> >> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wir=
eless/ath/ath12k/dp_tx.c
> >> index b8f0df6f7a05..81d1ff918f48 100644
> >> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> >> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> >> @@ -1,7 +1,7 @@
> >>   // SPDX-License-Identifier: BSD-3-Clause-Clear
> >>   /*
> >>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved=
.
> >> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All right=
s reserved.
> >> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All right=
s reserved.
> >>    */
> >>  =20
> >>   #include "core.h"
> >> @@ -1277,6 +1277,8 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config=
(struct ath12k *ar, bool reset)
> >>   					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
> >>   					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
> >>   					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
> >> +	} else {
> >> +		tlv_filter.rxmon_disable =3D true;
> > Shouldn't this be
> > 	tlv_filter =3D ath12k_mac_mon_status_filter_default;
> > To match de default value ?
>
> In standalone monitor case, this will enable the default filter=20
> unnecessary, no ?

I'm not too familiar with the driver but clearly this is the part that brea=
ks
sta info update when running a monitor while an ap is running.

And as this is a valid interface combination it should work right ?

So this change works around the problem I reported earlier, I just confirme=
d it
on my setup. But maybe this is not the right fix indeed but hopefully it
points towards the culprit.

>
>
> >>   	}
> >>  =20
> >>   	if (ab->hw_params->rxdma1_enable) {
> >> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wirele=
ss/ath/ath12k/hw.c
> >> index a106ebed7870..021a4b565e8b 100644
> >> --- a/drivers/net/wireless/ath/ath12k/hw.c
> >> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> >> @@ -1,7 +1,7 @@
> >>   // SPDX-License-Identifier: BSD-3-Clause-Clear
> >>   /*
> >>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved=
.
> >> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All right=
s reserved.
> >> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All right=
s reserved.
> >>    */
> >>  =20
> >>   #include <linux/types.h>
> >> @@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params ath12k_hw_p=
arams[] =3D {
> >>   					BIT(NL80211_IFTYPE_AP) |
> >>   					BIT(NL80211_IFT
>
> YPE_MESH_POINT) |
> >>   					BIT(NL80211_IFTYPE_AP_VLAN),
> >> -		.supports_monitor =3D false,
> >> +		.supports_monitor =3D true,
> >>  =20
> >>   		.idle_ps =3D false,
> >>   		.download_calib =3D true,
> >> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wirel=
ess/ath/ath12k/mac.c
> >> index abf7c7ed8967..27d44b508884 100644
> >> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >> @@ -1264,6 +1264,12 @@ static int ath12k_mac_monitor_start(struct ath1=
2k *ar)
> >>   		return ret;
> >>   	}
> >>  =20
> >> +	ret =3D ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
> > This is already done a few lines after. Shouldn't the one after be remo=
ved
>
> yes, will remove in the next version of the patch.


