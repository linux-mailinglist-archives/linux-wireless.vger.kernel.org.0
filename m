Return-Path: <linux-wireless+bounces-17905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BDA1B4F1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 12:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B737A1C7F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54881B0429;
	Fri, 24 Jan 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz2gRqAI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E64A1D
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719137; cv=none; b=nTN2Bx48StYJq780owJHXrgJedTdnxGCTNRzjTJ/slv/qewVjI5VJem0RjL4lLDRkBFopDshWMqldHjRm7LaddPVWqTx/ZD//H5CTdCaUfuz6rWvntavllPI1NxRANgmn5caMIh1U29g59jTs1yxOIwEsmBwvbJuckHgdEAX+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719137; c=relaxed/simple;
	bh=Srtyap2Qb/mJlf576z126bLNL9kq55kIUbz1eiX9tS8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cZjnnk8k4QnsY6OsOiwIAA5rpNoEqXEQPbwma6ri1E2mbxOZ3p9OD5MLnCKp4IheEhDtqWBA9SKJtATlwxiO6C5D6Ai+UIBt4EhhDleoJTi5AODQJNr+RWUqwFnCPQ7FtqUgrEcbGdTwZ2rnueOhizMOCPqJ4V/+2v3W1RxM8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz2gRqAI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so1984196f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737719134; x=1738323934; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZzV7UQd3KYL5z123q5GLS6PMxoAVbzEGbiydCidK8E=;
        b=Pz2gRqAIobWi/jkZok87GRXlqaRLK+TCJfYZAp+rbgNCuYm7eKxJLrL64QmZStYDtC
         sc75kgJIDWDQ4Qi58g6UsLshiVnfsloQi0FZXcrEtrzdnrPttwBytomjdQsaS48eDD4J
         Byi+MpbIiTCWbzqGD9mXymr5hh0b3z0OQp07fDMZ9ROD6bl+HaHTXFJ3VQsoOkC4q0YB
         RmIMfKBtdSZUERpqKEjCYkf559ug+JPLDF0kt22aVUvbGnS0ZYGRzIpFqQk+KFK8bCbA
         tJM84dSw/0CQ4QIuwcpFtrB5OPKP5hhK4iRXVo9KLjpakJFdyE+ub4h7GlTRev9p2zUU
         P29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737719134; x=1738323934;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZzV7UQd3KYL5z123q5GLS6PMxoAVbzEGbiydCidK8E=;
        b=XoR4YKBjgsOZidgv2u2wGr3evh320559k+uP+q4wldiCYfhQZk54HYVyLwcptr3Rvw
         c57nZ7I+2n3Htc+HJpZzfnjaziWv/WrcyVZAXj+KU9iQpqLSU6IxgyRKBVjva/Yz7IQG
         VeStaRpyYAYIyApc9nN+bH5HYiTmGzsujyrjdgfOYUwOJzun38MM0RR8jbNzA0qNPx7O
         Z9RraWLGWo5CE7VHP/3khJ05WAwp9knEnd17xziSGMLqkSH4F8EIsepDffOQSj+TVNhi
         /CAI2heWPex56+IDppECLDy2vPDoTmAPkO8G298hz3s8FfaNzEYf7MHzMRxnfOWhNYMQ
         Visw==
X-Gm-Message-State: AOJu0Yy1YH0NYXsVg3Ta3IdTMd/89Y0kw8+JjxX/4I8Y+PUhCaL91L1P
	wZ6fxPGRxDyMEcfDdLAqREYoiE3sowutAb15sid/dqyveBXvxFYH
X-Gm-Gg: ASbGncsVEJHorcjXP+WgJJ/JugMibssH8ud0RUaigbUurwarCAL+zzk6zPEFh1HH8uN
	o8ZpZDmYTfwW6PO0ghJjYZmnU+bcBSPx3QLhA+3JcH3mk5pBh+Ym9lWV02IM9NzBetRBRqwV+Pq
	Zc+DVTZUOhc/c/frbixBCggAGAh5V/TjjxVpjWjdIxv861CtSHaObYjRVJ3/Ap4VVe94r1wHCuq
	LJyN25NXc/RAWxyD1O59kERpUfQObJAYKZW0hJ3gTLSUhiSEbkfmsP1orEN1mzdrOyYOc3o9a8o
	NfKkKOiz7TXjVplG+YXW/Qc=
X-Google-Smtp-Source: AGHT+IHd1Im2HgFGc4fQReF0n7kZNiHIb6VzYaAcl3sEiS8vJFHMmF6YXcPsTpzzWG4FJZdyJbTNuA==
X-Received: by 2002:a05:6000:2a3:b0:38a:88f8:aac8 with SMTP id ffacd0b85a97d-38bf57c0a41mr27541537f8f.54.1737719134079;
        Fri, 24 Jan 2025 03:45:34 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d5easm2407910f8f.25.2025.01.24.03.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 03:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 12:45:32 +0100
Message-Id: <D7AA0SSICNT4.3GU5SHWIXWH94@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast
 handling in driver
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Balamurugan Mahalingam" <quic_bmahalin@quicinc.com>,
 <ath12k@lists.infradead.org>
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
Hello,

As ti is zeroed initilised isn't safer to do 'ti.meta_data_flags |=3D'
instead of 'ti.meta_data_flags =3D'. This way if we add another flag in
meta_data_flag in the same func for another reason, we will have less risk =
of
overriding the said flags ?

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

