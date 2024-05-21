Return-Path: <linux-wireless+bounces-7878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72998CAA5C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4443C1F21A9E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06438DC3;
	Tue, 21 May 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVG5ZsQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984154CDE0
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281447; cv=none; b=KJEfdJKtAuEUZBfLc7OFXiTb3QFo4lzrDq+t4lKP8P0Et4Ter8NR+7yGBgvnyNok4fSRTZ7duTV0AHtIPCrd0KlY7pyOowsYT6HXWi5CoXLi9W01YuTxDi6THESLhYnceuLxswFe/wP+NcnOuzCRdBCFmrTFB5PwTqWn0Sw643g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281447; c=relaxed/simple;
	bh=yNrNYlo9qmk9OZQyJAR8XVV4pVO1EIrO/iBqlHWIJTc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NvlgBFm1f3PZzffHEZtBM/T2B88k6ECaZacG/ioRbkH653nlzaIw4a6qp1c/6tKwYphwWaHfK3PoOrANIOgAohDuAwvxD9EwBaffSiuCgpEA9E6GaQ/3UL/5JLs164zHNVbauLQieyH053eh1W7Jw+RteJdTgQ5RaadgPN05/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVG5ZsQM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202ca70289so28056365e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716281444; x=1716886244; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8E6p7Y+ouLSYIiXoIeFn2ZMIwfFJft8t7wvd/QdN3s=;
        b=XVG5ZsQM1rKvdzZTFYAdSZdXIUxrnV1H+Y31cBIk5SF7vML184g9c9B64Fi6y+8WiP
         RQwNLzIh2d6t5JYMvRjjXWP+Qbp/3tntIhMTTaNnnmyhFG8x0kGvWx0Z5fQTEZNQO8CO
         W1JWA2TaLFZS6gbds7JcF5kee6VkYbtLupL2D5K9Py4ZgTQyCoeSYOC3CgU7ulFlvVxI
         lIdA9nPhGHWzzb09iNYr0g0Ox+NWz4GSDyoQs5Oc3OvH3/Fk9F6RoL41O+zeDhaknkSQ
         K9ZJppznmPGRt95qDxyo6G1/99mdbF4KBnzQqEdxMst/YE4CftPTVd1ugRTSQR+eT8DB
         ZWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716281444; x=1716886244;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8E6p7Y+ouLSYIiXoIeFn2ZMIwfFJft8t7wvd/QdN3s=;
        b=cHCBgMWMaSNnewfbJxjrcpWgyyGXIRkZs4lkGKpaq8KJfM3UQp2AsfIbxvKCNYT/19
         83iyv3fUB+1KfFWRvPVphuAUdX8v/2b8gR4lHAqC4R7mDMgMyccUtEkGYh6wn1bANlNv
         9A86H5kbkQcwfQax8Z2Q9x7XE2GDLDBSy579yPbE0FuC0bkWO5avc9Rp/C2FG6Mwxi8x
         TVqKdqSG6/98MkoFLW1TjRnLF6OW83JVjuTHYu/tDiWLCbLPfA+hntplFjolGRNKvV0u
         UQnqzrbwgac3yZxRvT2obWWxMY/qY8HRwjwCpXIsrHra/DyswaNPNSIEeqdXTK1tJFus
         NqxQ==
X-Gm-Message-State: AOJu0YyxbgTNn4RzhJD++tLUTkR0tgVyBpQt4vqNgxDHIuOyFiM1Ic8k
	qYDu5PynxOlBcoQOGAUb11YBNY0DImT4HWqTTI+Smoz+Yh2n/3dq
X-Google-Smtp-Source: AGHT+IEg/FD3vmCrHSoKeq7lm5iF6Dw6sxIoc/VEcAkFAmQqWfIfIBzp/KhMcfxlcqVmlnUr61qRDQ==
X-Received: by 2002:a05:600c:468c:b0:420:1067:d698 with SMTP id 5b1f17b1804b1-4201067d80bmr222351055e9.23.1716281443688;
        Tue, 21 May 2024 01:50:43 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d3bdad9bsm14709572f8f.46.2024.05.21.01.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 01:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 10:50:42 +0200
Message-Id: <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo
 reinject
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "P Praneesh" <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-4-quic_ppranees@quicinc.com>
In-Reply-To: <20240520070045.631029-4-quic_ppranees@quicinc.com>

On Mon May 20, 2024 at 9:00 AM CEST, P Praneesh wrote:
> When handling fragmented packets, the ath12k driver reassembles each
> fragment into a normal packet and then reinjects it into the HW ring.
> However, a firmware crash occurs during this reinjection process.
> The issue arises because the driver populates peer metadata in
> reo_ent_ring->queue_addr_lo, while the firmware expects the physical
> address obtained from the corresponding peer=E2=80=99s queue descriptor. =
Fix it
> by filling peer's queue descriptor's physical address in queue_addr_lo.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
>
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wirele=
ss/ath/ath12k/dp_rx.c
> index 2bfcc19d15ea..2adb6c7d4a42 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2967,7 +2967,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struc=
t ath12k *ar,
>  	struct hal_srng *srng;
>  	dma_addr_t link_paddr, buf_paddr;
>  	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
> -	u32 cookie, hal_rx_desc_sz, dest_ring_info0;
> +	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
>  	int ret;
>  	struct ath12k_rx_desc_info *desc_info;
>  	enum hal_rx_buf_return_buf_manager idle_link_rbm =3D dp->idle_link_rbm;
> @@ -3060,13 +3060,11 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(str=
uct ath12k *ar,
>  	reo_ent_ring->rx_mpdu_info.peer_meta_data =3D
>  		reo_dest_ring->rx_mpdu_info.peer_meta_data;
> =20
> -	/* Firmware expects physical address to be filled in queue_addr_lo in
> -	 * the MLO scenario and in case of non MLO peer meta data needs to be
> -	 * filled.
> -	 * TODO: Need to handle for MLO scenario.
> -	 */
> -	reo_ent_ring->queue_addr_lo =3D reo_dest_ring->rx_mpdu_info.peer_meta_d=
ata;
> -	reo_ent_ring->info0 =3D le32_encode_bits(dst_ind,
> +	reo_ent_ring->queue_addr_lo =3D cpu_to_le32(lower_32_bits(rx_tid->paddr=
));
> +	queue_addr_hi =3D upper_32_bits(rx_tid->paddr);
Shouldn't there be a cpu_to_le32 somewhere here ? It just seems asymetrical
between the two values extracted from rx_tid->paddr
> +	reo_ent_ring->info0 =3D le32_encode_bits(queue_addr_hi,
> +					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
> +			      le32_encode_bits(dst_ind,
>  					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
> =20
>  	reo_ent_ring->info1 =3D le32_encode_bits(rx_tid->cur_sn,


