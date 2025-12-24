Return-Path: <linux-wireless+bounces-30105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9FCDD183
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 22:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F263018F4A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B92BF002;
	Wed, 24 Dec 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzzNtQe7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A452E5427
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766613243; cv=none; b=ihaMD/R/D8IHaIK7IGyjaFUM/0cC7BoEy4C1hZ02TLM8ju8CfiLhFbf3C3rjOcncTU/l0/SBjwcH7dbLiNUboP0wHGniIS8DPta942r0XxDn+sC5K8OUyPaZmLOXj5YdPJD9IRIv2L4Mxo1LyOkZ7Mq+jXFXKdYEqwLEsEOb4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766613243; c=relaxed/simple;
	bh=NfW/eEskPhFcMrhPcxVvIhq+PWDTdI+r0hr8iuXgXv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGt/CoQXwH4+TEXA1xVhyvXoQljkBJILMcFjhaoIzCb08476AzaS82xEAXCe+C64jsjbhawqyHf/CSs1kkRqAuaQom7dqmkbAWL4RhYO/S6S1GXhH8E4eRkPamFAfjwL3Qz10VnCW/J//P2iUIg9hHaUo2WESlvgeGou7knZnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzzNtQe7; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fc7893c93so35006307b3.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766613241; x=1767218041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTWNttZGcaoPC4e1j/utiv4zbSB6TRNZbwodr2K9LRg=;
        b=jzzNtQe7sYBPvA8690F/PAiBc4vnMuZo35SqWyxWOlTtbuQynXHPLwpUAkXaiQjzBz
         K1i/i0gddq0XTTQ0pSP+wzV5LmpsccUE2yNy6PyigwIx88G8WivfJzl76X+pAk9F/snj
         c2FyNSzQ8KJ2I2/+ntC4t24VAoz1bidFr6E3iqZIhst+QClILYG36GliM5FVZ5Ap2Dy8
         14B9NysGsIfmb7LYR8QTsr4w182XmAzqZGzEoa1q3jhkBFoNk5JP3eXt9wlRAi+VBRn/
         +gcSU5+rr7V4Xj5BpoaV4je39QURuAG+8q2CckFqaKYp5PfxDPIpYPwzGBU97WJbd/XI
         o01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766613241; x=1767218041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTWNttZGcaoPC4e1j/utiv4zbSB6TRNZbwodr2K9LRg=;
        b=OHmK7lNCddWNzdF4ay4vZw+lqbJVVj4WdtbmKKQFID5bDDuinXhnNHYO/wTZLTWBL2
         Bn1QFJlYflTMig0HiIvrTe+gN11mEoBO6Sh7OwSEcYOlq8XfGU38i5oF47FSxNvkc0JY
         iAeS96L6Ky8o49ExvrkYE2PteqcVfIloaSfJKyWrSSeLIxXOxCv1/Hups5KjJSg2fTlG
         FuO+wZCwRd80n8tEvV+nJiIrJpQVTL7nmQU+Xu3PHoDdq1paCxNzGbT1EGTMXSgb7Txs
         64cnoN8HJev3hJ+kFk2jRYZgGSSAHz3bBoyrV5eueQn5T/90a8FeXGUgBpNatFjtjQwE
         70eQ==
X-Gm-Message-State: AOJu0Yw8hC2oA90hzQbcl7QNb/QEMIsvfjv7LDo4QlyEJOGMRtc22WZw
	bGl9b4WY+EQ2PNJdIcT0kiaQ84WkmjNHAVm/cJ6bEWm1oZEOXb60TktS
X-Gm-Gg: AY/fxX4rWo99twReNHCWrroHQBbUlVsXgNuWPpVt0yIV2dMzf3C9mnnkYHAL4OFg1l9
	2MC2r/YInLXXnGpZedhmGCAhqXONxZK+V/E2PpE019e6iHZ1km02UezGzi8jnfdU9ZHacuBOE3m
	D8d2jM5eWsyGCWUXLI69w5lhdOVsjyAuS3PYnwxq89Pzlm0XBXE5l7CauxjRYzzs9f1a7kxbW2W
	gmOz0IUaUG4d5rwQyzs6CBL9+/CWq6bukR2lSMjREAnYPWc0I+e55+V3mn6ik+X98815lbP68TF
	/8iw/G61wIUpbNrMzm4IGIWoDB9QRPcLVvobRMdBF3FDSZIhzipIuTxq4Ba4UYXOhdR5ihHDvga
	lFGabBzLfQnRnkb/etWw14YsLvSlhyNHSxM06c6anIRdofgSJcG/k8keE1PerRvwz4PgheMkTYJ
	uRMuYhlWANP9r8TC3wr9GOixYSYVcMd5FJ6qrB/WWbGEh1WNWOSHLhPNsd7+wCn6KebJQYzO4N9
	Cuo7NqB4PzP9yxlGA2T3DnBSAprldQ=
X-Google-Smtp-Source: AGHT+IFtS5CRBe4+CFpf0UsLdfArJUYMurpeS1NNo46ug0+dk8xpSG9mCbqy9e8AJspTPNqIYDfYYQ==
X-Received: by 2002:a05:690c:7403:b0:78d:6a71:76c5 with SMTP id 00721157ae682-78fb3efa0ffmr155097187b3.10.1766613240637;
        Wed, 24 Dec 2025 13:54:00 -0800 (PST)
Received: from nukework.gtech (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43782bfsm69238267b3.5.2025.12.24.13.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 13:54:00 -0800 (PST)
From: "Alex G." <mr.nuke.me@gmail.com>
To: ath11k@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Wed, 24 Dec 2025 15:53:59 -0600
Message-ID: <3484871.yKVeVyVuyW@nukework.gtech>
In-Reply-To: <83c5bb41-ac0f-4f01-be38-ba536dc8b977@oss.qualcomm.com>
References:
 <20251216043555.628296-1-mr.nuke.me@gmail.com>
 <83c5bb41-ac0f-4f01-be38-ba536dc8b977@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, December 16, 2025 1:14:27 AM CST Baochen Qiang wrote:
> On 12/16/2025 12:35 PM, Alexandru Gagniuc wrote:
> > ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> > is initialized in, core.c, a different file than the array. This
> > spaghetti-like relation is fragile and not obvious. Accidentally
> > setting ".max_tx_ring" too high leads to a hard to track out-of-
> > bounds access and memory corruption.
> >=20
> > There is a small ambiguity on the meaning of "max_tx_ring":
> >  - The highest ring, max=3D3 implies there are 4 rings (0, 1, 2, 3)
> >  - The highest number to use for array indexing (there are 3 rings)
> >=20
> > Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> > ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
> > instead of #defines to initialize the length field.
> >=20
> > The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
> > so use a constant to express the correct value. Add a static_assert()
> > to fail compilation if the constant is accidentally set too high.
> >=20
> > The intent is to make the code easier to understand rather than fix
> > an existing bug.
> >=20
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > ---
> >=20
> > I am trying to make ath11k work on IPQ9574. My device uses a IPQ9570
> > with a QCN5024 as the 2.4 GHz wifi.
> >=20
> > I spent a few days tracking a memory corruption bug caused by
> > erroneously setting ".max_tx_ring" too high. I think I would not have
> > made this mistake if the initializations of .max_tx_ring and
> > .tcl2wbm_rbm_map were right next to each other.
> >=20
> > Changes since v1:
> >  - use "num_tx_rings" name instead of "map_len"
> >  - make sure debugfs.c is correctly updated
> >  - add a static_assert for ath11k_hw_hal_params_qca6390 special case
> > =20
> >  drivers/net/wireless/ath/ath11k/core.c    | 12 +-----------
> >  drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
> >  drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
> >  drivers/net/wireless/ath/ath11k/dp_tx.c   |  9 +++++----
> >  drivers/net/wireless/ath/ath11k/hw.c      | 19 +++++++++++++++++++
> >  drivers/net/wireless/ath/ath11k/hw.h      |  3 ++-
> >  drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
> >  7 files changed, 35 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/core.c
> > b/drivers/net/wireless/ath/ath11k/core.c index
> > 812686173ac8a..07199ceecbeb4 100644
> > --- a/drivers/net/wireless/ath/ath11k/core.c
> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > @@ -100,7 +100,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D false,
> >  		.fix_l1ss =3D true,
> >  		.credit_flow =3D false,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_ipq8074,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D true,
> >=20
> > @@ -184,7 +183,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D false,
> >  		.fix_l1ss =3D true,
> >  		.credit_flow =3D false,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_ipq8074,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D true,
> >=20
> > @@ -271,7 +269,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D false,
> >  		.fix_l1ss =3D true,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_qca6390,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > @@ -358,7 +355,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D false,
> >  		.fix_l1ss =3D true,
> >  		.credit_flow =3D false,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_ipq8074,
> >  		.supports_dynamic_smps_6ghz =3D true,
> >  		.alloc_cacheable_memory =3D true,
> >=20
> > @@ -445,7 +441,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D true,
> >  		.fix_l1ss =3D false,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_qca6390,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > @@ -533,7 +528,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D true,
> >  		.fix_l1ss =3D false,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_qca6390,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > @@ -619,7 +613,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D true,
> >  		.fix_l1ss =3D false,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_wcn6750,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > @@ -662,7 +655,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.qmi_service_ins_id =3D=20
ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
> >  		.ring_mask =3D &ath11k_hw_ring_mask_ipq8074,
> >  		.credit_flow =3D false,
> >=20
> > -		.max_tx_ring =3D 1,
> >=20
> >  		.spectral =3D {
> >  	=09
> >  			.fft_sz =3D 2,
> >  			.fft_pad_sz =3D 0,
> >=20
> > @@ -698,7 +690,7 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D false,
> >  		.idle_ps =3D false,
> >  		.supports_suspend =3D false,
> >=20
> > -		.hal_params =3D &ath11k_hw_hal_params_ipq8074,
> > +		.hal_params =3D &ath11k_hw_hal_params_ipq5018,
> >=20
> >  		.single_pdev_only =3D false,
> >  		.coldboot_cal_mm =3D true,
> >  		.coldboot_cal_ftm =3D true,
> >=20
> > @@ -789,7 +781,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D true,
> >  		.fix_l1ss =3D false,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_qca6390,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > @@ -876,7 +867,6 @@ static const struct ath11k_hw_params
> > ath11k_hw_params[] =3D {>=20
> >  		.supports_regdb =3D true,
> >  		.fix_l1ss =3D false,
> >  		.credit_flow =3D true,
> >=20
> > -		.max_tx_ring =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  		.hal_params =3D &ath11k_hw_hal_params_qca6390,
> >  		.supports_dynamic_smps_6ghz =3D false,
> >  		.alloc_cacheable_memory =3D false,
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c
> > b/drivers/net/wireless/ath/ath11k/debugfs.c index
> > 977f945b6e669..50f344803e8fd 100644
> > --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> > +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> > @@ -707,7 +707,7 @@ static ssize_t ath11k_debugfs_dump_soc_dp_stats(str=
uct
> > file *file,>=20
> >  	len +=3D scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
> >  	len +=3D scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:
\n");
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++)
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
> >=20
> >  		len +=3D scnprintf(buf + len, size - len, "ring%d: %u\n",
> >  	=09
> >  				 i, soc_stats-
>tx_err.desc_na[i]);
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/dp.c
> > b/drivers/net/wireless/ath/ath11k/dp.c index 56b1a657e0b0f..c940de28527=
6d
> > 100644
> > --- a/drivers/net/wireless/ath/ath11k/dp.c
> > +++ b/drivers/net/wireless/ath/ath11k/dp.c
> > @@ -344,7 +344,7 @@ void ath11k_dp_stop_shadow_timers(struct ath11k_base
> > *ab)>=20
> >  	if (!ab->hw_params.supports_shadow_regs)
> >  =09
> >  		return;
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++)
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
> >=20
> >  		ath11k_dp_shadow_stop_timer(ab, &ab-
>dp.tx_ring_timer[i]);
> >  =09
> >  	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
> >=20
> > @@ -359,7 +359,7 @@ static void ath11k_dp_srng_common_cleanup(struct
> > ath11k_base *ab)>=20
> >  	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
> >  	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
> >  	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		ath11k_dp_srng_cleanup(ab, &dp-
>tx_ring[i].tcl_data_ring);
> >  		ath11k_dp_srng_cleanup(ab, &dp-
>tx_ring[i].tcl_comp_ring);
> >  =09
> >  	}
> >=20
> > @@ -400,7 +400,7 @@ static int ath11k_dp_srng_common_setup(struct
> > ath11k_base *ab)>=20
> >  		goto err;
> >  =09
> >  	}
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		tcl_num =3D ab->hw_params.hal_params-
>tcl2wbm_rbm_map[i].tcl_ring_num;
> >  		wbm_num =3D ab->hw_params.hal_params-
>tcl2wbm_rbm_map[i].wbm_ring_num;
> >=20
> > @@ -782,7 +782,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
> >=20
> >  	int i, j;
> >  	int tot_work_done =3D 0;
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		if (BIT(ab->hw_params.hal_params-
>tcl2wbm_rbm_map[i].wbm_ring_num) &
> >  	=09
> >  		    ab->hw_params.ring_mask->tx[grp_id])
> >  		=09
> >  			ath11k_dp_tx_completion_handler(ab, i);
> >=20
> > @@ -1035,7 +1035,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
> >=20
> >  	ath11k_dp_reo_cmd_list_cleanup(ab);
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
> >  		idr_for_each(&dp->tx_ring[i].txbuf_idr,
> >  	=09
> >  			     ath11k_dp_tx_pending_cleanup, ab);
> >=20
> > @@ -1086,7 +1086,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
> >=20
> >  	size =3D sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		idr_init(&dp->tx_ring[i].txbuf_idr);
> >  		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
> >  		dp->tx_ring[i].tcl_data_ring_id =3D i;
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c
> > b/drivers/net/wireless/ath/ath11k/dp_tx.c index
> > 562aba66582f3..86e1e6c27b36c 100644
> > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> > @@ -91,6 +91,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif
> > *arvif,>=20
> >  	struct hal_srng *tcl_ring;
> >  	struct ieee80211_hdr *hdr =3D (void *)skb->data;
> >  	struct dp_tx_ring *tx_ring;
> >=20
> > +	size_t num_tx_rings =3D ab->hw_params.hal_params->num_tx_rings;
> >=20
> >  	void *hal_tcl_desc;
> >  	u8 pool_id;
> >  	u8 hal_ring_id;
> >=20
> > @@ -113,7 +114,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_v=
if
> > *arvif,>=20
> >  tcl_ring_sel:
> >  	tcl_ring_retry =3D false;
> >=20
> > -	ti.ring_id =3D ring_selector % ab->hw_params.max_tx_ring;
> > +	ti.ring_id =3D ring_selector % num_tx_rings;
> >=20
> >  	ti.rbm_id =3D
> >  	ab->hw_params.hal_params->tcl2wbm_rbm_map[ti.ring_id].rbm_id;
> >  =09
> >  	ring_map |=3D BIT(ti.ring_id);
> >=20
> > @@ -126,7 +127,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_v=
if
> > *arvif,>=20
> >  	spin_unlock_bh(&tx_ring->tx_idr_lock);
> >  =09
> >  	if (unlikely(ret < 0)) {
> >=20
> > -		if (ring_map =3D=3D (BIT(ab->hw_params.max_tx_ring) - 1) ||
> > +		if (ring_map =3D=3D (BIT(num_tx_rings) - 1) ||
> >=20
> >  		    !ab->hw_params.tcl_ring_retry) {
> >  		=09
> >  			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> >  			return -ENOSPC;
> >=20
> > @@ -244,8 +245,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_v=
if
> > *arvif,>=20
> >  		 * checking this ring earlier for each pkt tx.
> >  		 * Restart ring selection if some rings are not checked=20
yet.
> >  		 */
> >=20
> > -		if (unlikely(ring_map !=3D (BIT(ab-
>hw_params.max_tx_ring)) - 1) &&
> > -		    ab->hw_params.tcl_ring_retry && ab-
>hw_params.max_tx_ring > 1) {
> > +		if (unlikely(ring_map !=3D (BIT(num_tx_rings)) - 1) &&
> > +		    ab->hw_params.tcl_ring_retry && num_tx_rings > 1) {
> >=20
> >  			tcl_ring_retry =3D true;
> >  			ring_selector++;
> >  	=09
> >  		}
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/hw.c
> > b/drivers/net/wireless/ath/ath11k/hw.c index caa6dc12a790b..bbaacdf76af=
0a
> > 100644
> > --- a/drivers/net/wireless/ath/ath11k/hw.c
> > +++ b/drivers/net/wireless/ath/ath11k/hw.c
> > @@ -2707,6 +2707,14 @@ const struct ath11k_hw_regs wcn6750_regs =3D {
> >=20
> >  	.hal_reo1_misc_ctl =3D 0x000005d8,
> > =20
> >  };
> >=20
> > +static const struct ath11k_hw_tcl2wbm_rbm_map
> > ath11k_hw_tcl2wbm_rbm_map_ipq5018[] =3D { +	{
> > +		.tcl_ring_num =3D 0,
> > +		.wbm_ring_num =3D 0,
> > +		.rbm_id =3D HAL_RX_BUF_RBM_SW0_BM,
> > +	},
> > +};
> > +
> >=20
> >  static const struct ath11k_hw_tcl2wbm_rbm_map
> >  ath11k_hw_tcl2wbm_rbm_map_ipq8074[] =3D {> =20
> >  	{
> >  =09
> >  		.tcl_ring_num =3D 0,
> >=20
> > @@ -2822,19 +2830,30 @@ const struct ath11k_hw_regs ipq5018_regs =3D {
> >=20
> >  	.hal_wbm1_release_ring_base_lsb =3D 0x0000097c,
> > =20
> >  };
> >=20
> > +const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018 =3D {
> > +	.rx_buf_rbm =3D HAL_RX_BUF_RBM_SW3_BM,
> > +	.tcl2wbm_rbm_map =3D ath11k_hw_tcl2wbm_rbm_map_ipq5018,
> > +	.num_tx_rings =3D ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
> > +};
> > +
> >=20
> >  const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 =3D {
> > =20
> >  	.rx_buf_rbm =3D HAL_RX_BUF_RBM_SW3_BM,
> >  	.tcl2wbm_rbm_map =3D ath11k_hw_tcl2wbm_rbm_map_ipq8074,
> >=20
> > +	.num_tx_rings =3D ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074),
> >=20
> >  };
> > =20
> >  const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 =3D {
> > =20
> >  	.rx_buf_rbm =3D HAL_RX_BUF_RBM_SW1_BM,
> >  	.tcl2wbm_rbm_map =3D ath11k_hw_tcl2wbm_rbm_map_ipq8074,
> >=20
> > +	.num_tx_rings =3D DP_TCL_NUM_RING_MAX_QCA6390,
> >=20
> >  };
> >=20
> > +static_assert(ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074) >=3D
> > DP_TCL_NUM_RING_MAX_QCA6390); +
>=20
> instead of keeping this special handling, how about define its own
> tcl2wbm_rbm_map for ath11k_hw_hal_params_qca6390=EF=BC=9For even simply u=
se the
> newly introduced ath11k_hw_tcl2wbm_rbm_map_ipq5018? like
>=20
> const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 =3D {
> 	.rx_buf_rbm =3D HAL_RX_BUF_RBM_SW1_BM,
> 	.tcl2wbm_rbm_map =3D ath11k_hw_tcl2wbm_rbm_map_ipq5018,
> 	.num_tx_rings =3D ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018)
> };

Sure, I will do it this way.

I am ready to submit the IPQ9574 support, and this patch is a dependency.=20
Should I include v3 of this patch in the IPQ9574 series, or submit v3=20
independently?

Alex

> >  const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750 =3D {
> > =20
> >  	.rx_buf_rbm =3D HAL_RX_BUF_RBM_SW1_BM,
> >  	.tcl2wbm_rbm_map =3D ath11k_hw_tcl2wbm_rbm_map_wcn6750,
> >=20
> > +	.num_tx_rings =3D ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_wcn6750),
> >=20
> >  };
> > =20
> >  static const struct cfg80211_sar_freq_ranges
> >  ath11k_hw_sar_freq_ranges_wcn6855[] =3D {>=20
> > diff --git a/drivers/net/wireless/ath/ath11k/hw.h
> > b/drivers/net/wireless/ath/ath11k/hw.h index 52d9f4c13b136..9db984ac432=
1c
> > 100644
> > --- a/drivers/net/wireless/ath/ath11k/hw.h
> > +++ b/drivers/net/wireless/ath/ath11k/hw.h
> > @@ -134,6 +134,7 @@ struct ath11k_hw_tcl2wbm_rbm_map {
> >=20
> >  struct ath11k_hw_hal_params {
> > =20
> >  	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
> >  	const struct ath11k_hw_tcl2wbm_rbm_map *tcl2wbm_rbm_map;
> >=20
> > +	size_t num_tx_rings;
> >=20
> >  };
> > =20
> >  struct ath11k_hw_params {
> >=20
> > @@ -198,7 +199,6 @@ struct ath11k_hw_params {
> >=20
> >  	bool supports_regdb;
> >  	bool fix_l1ss;
> >  	bool credit_flow;
> >=20
> > -	u8 max_tx_ring;
> >=20
> >  	const struct ath11k_hw_hal_params *hal_params;
> >  	bool supports_dynamic_smps_6ghz;
> >  	bool alloc_cacheable_memory;
> >=20
> > @@ -291,6 +291,7 @@ extern const struct ce_ie_addr
> > ath11k_ce_ie_addr_ipq5018;>=20
> >  extern const struct ce_remap ath11k_ce_remap_ipq5018;
> >=20
> > +extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018;
> >=20
> >  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
> >  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
> >  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750;
> >=20
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> > b/drivers/net/wireless/ath/ath11k/mac.c index
> > 3276fe443502f..33ebe03380114 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -7392,7 +7392,7 @@ static void ath11k_mac_op_remove_interface(struct
> > ieee80211_hw *hw,>=20
> >  	idr_for_each(&ar->txmgmt_idr,
> >  =09
> >  		     ath11k_mac_vif_txmgmt_idr_remove, vif);
> >=20
> > -	for (i =3D 0; i < ab->hw_params.max_tx_ring; i++) {
> > +	for (i =3D 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
> >=20
> >  		spin_lock_bh(&ab->dp.tx_ring[i].tx_idr_lock);
> >  		idr_for_each(&ab->dp.tx_ring[i].txbuf_idr,
> >  	=09
> >  			     ath11k_mac_vif_unref, vif);





