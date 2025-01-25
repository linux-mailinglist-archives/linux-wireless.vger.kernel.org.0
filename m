Return-Path: <linux-wireless+bounces-17939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C873A1C52E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 21:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A5164F42
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DABA78F49;
	Sat, 25 Jan 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl+s4PVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D51862A
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737837212; cv=none; b=pWq7miWekr5eSW5G4sDaps7gx0fuTWVvgcH7ypHQodABmNcsPqEQOW8Ij0PKhfX/qpBWcBCuGH9WBqUV9Qp37415xi3InDMk4ulwaGrZfM52X8z3dalN1QGHVtbBJqjNjpJ6gK2J02kwhTuTKpaK0hRyRYmR9z4ish96ZoDJFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737837212; c=relaxed/simple;
	bh=lVNY90KsjLOXDT872NK/IHsvJsZWqQwj+7GTpiYZvRw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cyznZmnzYjCu1VtNv5dqqBtROebDFhMKMO/BXaDSsQ5L/DDRa/KdCTKzTNCs6o1vatlNjt4XykaUDBbtVwIERBTnqpPvREiakvIOpQvQg4Z+mXg+/R6bke3dUZmM9XzTFqhmBAa9R7fHRdJrPrSDD9YcZLZ2VjjR/Kr3UPO5IAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl+s4PVk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361815b96cso21252485e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737837209; x=1738442009; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc3fJA8PcltY1mYa3Gco6h17ujJWBhmbRWOgQCakVFs=;
        b=Xl+s4PVks1jlxPXjonAlclQdmTOHrThnnKYHwPXGfNdqyf1ufOUb0VFl5Pbbca1syq
         LmmNEc/9nNnenhbCmmR40xCUtnocCZAFQNwsskQnf14mB5tiuIS2kCRlr/GLNiaFDG/u
         1UoePSjWBX5eN68+3GHsYD3xA/4Gh0usBa3rsSc4hzByq1m0EwlPCDYoiNxV+jmlA8x3
         NqKD8ZwvOaZIRT5JkRsjre+RIyFizWdh20cZrVORrS+H24U8xyLMFdLNYFCBA4J9YIB6
         H7Z4rClEe/Pw28D1Kf1XiCaIfgbn++HBGm/XEMHECISrrgiWzVISrNR+FvYd9DUaR2Jn
         FVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737837209; x=1738442009;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uc3fJA8PcltY1mYa3Gco6h17ujJWBhmbRWOgQCakVFs=;
        b=SyNBEwWs+2Ane9PjMatS7v0DprMZcIvlZzFjIOQh48rrjFdmOV6Mr3QHEL5vURfR+L
         p/5kuxvd897T4+mWFgZMHaSMxwesi5abntjfq6fyibjvU3QXMkxCJsoWObFlQIYA+gZY
         tlObQzDYVbBgLUnGo+4Jarb8JEXTHlL4eGAxfFCX8n7Pe4cY9Ty8F9ifbvFIiLL/mYMx
         XN93XspgRZZiDHCtxCxJTjW+ZcCuN1O1gE/E1HhasSmsH0WgWT7Jdny5EgPZ4ipmvz2s
         c1Y8FWKHQvlxYM4f5yxPG96F7RRQqUjvWOOoRK8Mt6qZJ7zBDKlmzYYGa7avTUFS6VxW
         A/UA==
X-Gm-Message-State: AOJu0YzprkMn79zTRkjQPnew+mUFwfpEXIoiYZzwUq5iTlJnJHXNJa1E
	iO781T5ek3/nVeIqGeBj8wuQwCWNwSVkZyfFCxpXEehbQw5m007k
X-Gm-Gg: ASbGncvOeIXCtG1anaFIaE/gfzbsgcluKUmOBCfdJBZz4/WCmn8ljtRmZprvX3fvV2x
	G3uftcIK9A+MEalf9uOEBkWp/ZwG3ak7jSVzVks8AcS8WsggmLKnVkd/4U42Q7JRjo0Pnuc/eZT
	bqNl1weM1Lo+6hQ8JElauRNzKoEo+DQYnQ2yv9klhSzJ7+RXQlTpdji3iVK8DzYLAzXYqYq2HZj
	rhPlWApys222yr0YZOETMV/FA2gPpkMMimcvwOmp57eEBMzJ+IdGjbMoxbdJF/oGGfQ3BOu42RZ
	AJtm9/cfIgs56xYdbOE2jJE=
X-Google-Smtp-Source: AGHT+IHTdd78oq7Xr5vV2iGB1xzykwyYBhthtOv76Oc4OyXeszdbUfb0nsHG8L/UKDs7E7QpZPSoeA==
X-Received: by 2002:a05:600c:35cf:b0:436:1be4:c9b4 with SMTP id 5b1f17b1804b1-4389143698amr287833995e9.27.1737837209371;
        Sat, 25 Jan 2025 12:33:29 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48574csm72843655e9.9.2025.01.25.12.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 12:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:33:27 +0100
Message-Id: <D7BFVJJDJJAD.2HAR34N0MNXBW@gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast
 handling in driver
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Balamurugan Mahalingam" <quic_bmahalin@quicinc.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
 <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
In-Reply-To: <20250109184932.1593157-3-quic_bmahalin@quicinc.com>

On Thu Jan 9, 2025 at 7:49 PM CET, Balamurugan Mahalingam wrote:
[...]
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wirele=
ss/ath/ath12k/dp_tx.c
> index 76626d925adf..9d05fe7a870c 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -217,7 +217,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_b=
ase *ab,
>  }
> =20
>  int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
> -		 struct sk_buff *skb)
> +		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
>  {
>  	struct ath12k_base *ab =3D ar->ab;
>  	struct ath12k_dp *dp =3D &ab->dp;
> @@ -290,13 +290,24 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_l=
ink_vif *arvif,
>  		msdu_ext_desc =3D true;
>  	}
> =20
> +	if (gsn_valid) {
> +		ti.meta_data_flags =3D
> +			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
> +					HTT_TCL_META_DATA_TYPE) |
> +			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
> +	}
> +
>  	ti.encap_type =3D ath12k_dp_tx_get_encap_type(arvif, skb);
>  	ti.addr_search_flags =3D arvif->hal_addr_search_flags;
>  	ti.search_type =3D arvif->search_type;
>  	ti.type =3D HAL_TCL_DESC_TYPE_BUFFER;
>  	ti.pkt_offset =3D 0;
>  	ti.lmac_id =3D ar->lmac_id;
> -	ti.vdev_id =3D arvif->vdev_id;
> +	if (gsn_valid)
> +		ti.vdev_id =3D arvif->vdev_id +
> +			     HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
> +	else
> +		ti.vdev_id =3D arvif->vdev_id;
>  	ti.bss_ast_hash =3D arvif->ast_hash;
>  	ti.bss_ast_idx =3D arvif->ast_idx;
>  	ti.dscp_tid_tbl_idx =3D 0;

And this is nit picking but I find the following would be even more readabl=
e:
	ti.vdev_id =3D arvif->vdev_id;
	if (gsn_valid)
		ti.vdev_id +=3D HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;

On the plus side, it's even less lines of modified code :)

