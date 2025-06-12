Return-Path: <linux-wireless+bounces-24068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F4AD6FC4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 14:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235E63A7D97
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40720C485;
	Thu, 12 Jun 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb2rJ2Dm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5A135A53
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730222; cv=none; b=Y6KYw+4+K+CaH7d30HaYQO00R2k8omN9iH6OVNXE1Z8ZT8QrmYAYHKJlzWiPZUiDygdm1uia0s2Z7zk9AHVR1HIHt4hbwFAjkXzBVLxGYkCwd7mO5c2aCYto4T33qxDYU3T/ilLL2TQZunCBK8vzEzyhpyJYKFeaWBbRE9txqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730222; c=relaxed/simple;
	bh=Qj/1nnvdJ5JrgJB8hNsaOzfB/BewysoaOQSHoNHeSro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Cf45kD14+XNYWCM5mfk7ld70uHmmGbfBtukACUFS4s5SxUeJMXx3WHQ6Kfn0h4aYVAiyuMO8XQQm4Vk+QlmF0FPayPpyWBBz4uDZ0GQSWWXR2H/+fPBV9C4kqPFSnwiwLKasETPX+tL5ZVJSLyxX3BUME9Zzan4CPxqOmTb76Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb2rJ2Dm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54690d369so874099f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749730217; x=1750335017; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2Df3rjHwe0FG/vDkCe6qdIJH8gKqNp37jgiKCjMZZ8=;
        b=Rb2rJ2DmMVvMtSn6nyz1CKA8DM9xxFb0XuIOO5hAQ/yUZTUdzyOgOAFQp0ENXIXXkX
         Z0kBAGlK+G4q3d2pKp4PGLbbLTm4Q//JnJJB6ZA6J08iTKwVu5M8tzBeU25Kdl+eseK/
         DdrqMZY+/r+DG2MQ8KIwbc3w2vkEy5qmjwaojV6aPf8jZDeVpyObdhqNbb3DHsFADLfv
         KZinQQBSOmDEiNV2ugemT/p16qExRSbbgVV1Sbpxs97pOwcJnbztT8A58S+0JVjeQ4dd
         YJUo57GRmRtAuZj/ab5Dm6Z0I6VZZiggIDaUK/LdiLKe799HSRdJOa621bheiGaFhJz/
         BPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730217; x=1750335017;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2Df3rjHwe0FG/vDkCe6qdIJH8gKqNp37jgiKCjMZZ8=;
        b=gyZkSwdCgnA7f/dtadT6aSNs3ckrhIKVGD1xmPKAJcdEVbzObjatt12ooGPuYVD5+B
         t92RLiPFkEmQwnnJcd3/TdDRAuwP4W8ZLweKBLS7XYrik8Ful33t9IJW2CD5BZ5CyvcW
         kSMEnNJioHddmY+iSR5Jhf5+8KEnarGyQefhenD70/3KlKhzcR6uJY9LkEOksog05ROH
         WlQNJDjmdJIQ32q9uLsFr3HNCH1y6HHI2Zj9q1VZgcpP3FVY8GsNd4Hys/5hFWsRWKnU
         RcUoMk2QFepU55U2UOjwAz5AVh8uy5ntNfJteXljnvYU28xC4yYt8f7gl+7jrFp8C2pW
         nYHQ==
X-Gm-Message-State: AOJu0Yz1IqsjGSLK6zNGeCPjLSpje/JYElW4rCUJ72VeYfIMT9d8Ofgj
	xUQjAsqLGFWxU8GmiMntfe3wSQA1M43UF/oEoGuNnWY2R/v/ToQzS6+E
X-Gm-Gg: ASbGncuUqPQHmZeBHiYlGkuNICnPlezGp/ZO5IldupfwBX/Y4aNlwtV2D8QXV9K+0pd
	TpNGYZABPpsfOtOggQqrdjYdilB5SX/VPULqN8N8DcGQ+miqEotGev5dvBijOSZptjE5A65yTz/
	iHDrqez9cQxQ3VpC8HOS413LLmnNSynALfVe4nLGvRKiEgAfdyh5JqsJHB+DfkbShURKJFbNDZs
	zQNweBP1XVHFgsK3M3j7xhtnBuqJgE5CQeZn3NJ8q40jRv22BOCqyTTmAKClobJM1pXJlu5yzpm
	o7PzGf512UvOGt97xgowPsxa4xKxwhJl9He4JDWRu3O5aMNSpTSpOBE18bi1gnawsvgHql5IA3s
	gjfC6
X-Google-Smtp-Source: AGHT+IHT68F9bp+GNEbJxJhqFGSxkFU0W/c0vw76DGIuCmFxVWqcf/3L6Wamnq5F9TS2vohA9+gDWA==
X-Received: by 2002:a05:6000:2403:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3a5614dc92bmr1631896f8f.51.1749730216786;
        Thu, 12 Jun 2025 05:10:16 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c2d2sm19947015e9.1.2025.06.12.05.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 14:10:15 +0200
Message-Id: <DAKJLG9RLFCQ.3H8XQHL8ZY3GT@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Sivashankari Madhavan"
 <quic_sivamadh@quicinc.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: support average ack rssi in
 station dump
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Sowmiya Sree Elavalagan" <quic_ssreeela@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
In-Reply-To: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>

On Thu Jun 12, 2025 at 1:46 PM CEST, Sowmiya Sree Elavalagan wrote:
> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>
> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
> management TX completion event from WMI. Update ACK RSSI value obtained
> in management and data frame completion path to ieee80211_tx_info. Also
> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
> register to mac80211 layer so that ACK RSSI is added to station dump
> message.
>
> Example output :
> Station 00:03:7f:01:5c:4b (on wlp88s0)
>         inactive time:  46584 ms
>         rx bytes:       955
>         rx packets:     10
>         tx bytes:       769
>         tx packets:     6
>         tx retries:     81
>         tx failed:      0
>         rx drop misc:   0
>         signal:         -39 dBm
>         signal avg:     -40 dBm
>         tx bitrate:     6.0 MBit/s
>         tx duration:    1185 us
>         rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-D=
CM 0
>         rx duration:    0 us
>         last ack signal:-41 dBm
>         avg ack signal: -40 dBm
>         authorized:     yes
>         authenticated:  yes
> 	.......
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-3
>
> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
[...]
> @@ -5651,6 +5655,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(stru=
ct ath12k_base *ab,
>  	param->pdev_id =3D ev->pdev_id;
>  	param->desc_id =3D ev->desc_id;
>  	param->status =3D ev->status;
> +	param->ppdu_id =3D ev->ppdu_id;
Hello,
It seems this ppdu_id is retrieved from frimware but not used in this patch=
set
Is this by design ?
> +	param->ack_rssi =3D ev->ack_rssi;
> =20
>  	kfree(tb);
>  	return 0;
> @@ -6552,7 +6558,8 @@ static void ath12k_mgmt_tx_compl_event(struct ath12=
k_base *ab, struct sk_buff *s
>  	}
> =20
>  	wmi_process_mgmt_tx_comp(ar, le32_to_cpu(tx_compl_param.desc_id),
> -				 le32_to_cpu(tx_compl_param.status));
> +				 le32_to_cpu(tx_compl_param.status),
> +				 le32_to_cpu(tx_compl_param.ack_rssi));
> =20
>  	ath12k_dbg(ab, ATH12K_DBG_MGMT,
>  		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d",
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless=
/ath/ath12k/wmi.h
> index ac18f75e0449..49010367dc06 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2486,6 +2486,7 @@ struct wmi_init_cmd {
>  #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
>  #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
>  #define WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET      BIT(9)
> +#define WMI_RSRC_CFG_FLAG1_ACK_RSSI	BIT(18)
> =20
>  struct ath12k_wmi_resource_config_params {
>  	__le32 tlv_header;
> @@ -4445,6 +4446,8 @@ struct wmi_mgmt_tx_compl_event {
>  	__le32 desc_id;
>  	__le32 status;
>  	__le32 pdev_id;
> +	__le32 ppdu_id;
> +	__le32 ack_rssi;
>  } __packed;
> =20
>  struct wmi_scan_event {
>
> base-commit: 9f92c4a01c5268f57fa19dd7cbcb1f59b0e66da6

