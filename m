Return-Path: <linux-wireless+bounces-7935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E68CBBFB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47366B214CD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A137D40D;
	Wed, 22 May 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faLlnfOR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B87D08F
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362890; cv=none; b=pqRxciBoadLZMWGcr/IovYPhFhuM4CgFismsZJXMg7rpBl//FRw1zZZaHvtzK2RzaskHK4OVUI3OmsGPfMWOt9FZki1wXu/Q7jcRc0vRHKsWTYm4HStPAOmRdv/FRumRHcshdEFbonm//0Y+nit+RIdHJb6Qe7tDFiFuPhEsx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362890; c=relaxed/simple;
	bh=keS0ljyEXXFim6EZayKTEPLiYbz/imuxMPI6znYog5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WQfS13POS53ALJaOqRZ5pll0EzKhuql6OB6M+qw0Vdu54q4JKfNtSZwJzvbzNh8YxF8c8lg7f3mf9EGDhnTqC3sRgAfmVy6SA4lki408Fmnq6jABWRyC7lBB8YdjeMSuW7YMz72y0djN5iPg41ERadxO/vSzG7+FKLZuA8Gu0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faLlnfOR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5210684cee6so6448788e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716362887; x=1716967687; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64AnY6F3RdWDInMyOjMvRf1vmka0/6tUbxzfZZCY5iY=;
        b=faLlnfORGBljVMhwIpKqpjZk3dweP7PW53LQHyP4SZK3sfO8swTZ++oV5NHPOn8Xhj
         bvsl0KvNyTYfEyc9LMMXCKpriMHomnZm+Narn3k0Fp7QFxNRAv5AYYLNl8obgVfDyFi9
         c9T5Z4zYGQkoYVNknyKofXgZQKtm3caxkoZ4R8VefcYMwNIeSQZ+IC940XbFXYwd35M5
         v1kYPO1lYfoeuC187WAjh1n419WOrU9JyFtipIbzUrCSXVeMUTSktU0ev5uJ3O54bdGF
         qtsd7UpfUQMdT/K6ieWXUUIaskPdPZNhZ3YtO3Jnb/OUK3J81ikk8r77AeUa7yhFE11E
         FAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716362887; x=1716967687;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64AnY6F3RdWDInMyOjMvRf1vmka0/6tUbxzfZZCY5iY=;
        b=I7l279fGBYWNhMfGmEJvBigLYpSqoJsd/iU21ygamm3PWRAYV7SN7SGz29Id72fIob
         aJ9FFA2vzjIXBdOBrY1wMlPZp4WUAt86ikiXb1rbguy9TboKWOiRTIAWWZFbASIe/sn3
         qh0qDCSLwN7+gkhAWWot594tbiQ/Iq2REr56El1bMIAtBEUd21MazPVxL9hHXDO4L/Rk
         vmgpYIogiubz+wEjLIjdS8f1WpvQZqokQcoD6btk7ITU2e6O1zUAY3oudhP6Nv8Tru/w
         OuyuWpu2ypLFtaIoNLQg2FBRdtQxNSnbOIDLr2Bb6xE5FnNFF0vU9yPw8ts5eJ8dRqfy
         ifcw==
X-Gm-Message-State: AOJu0Yw3sGRmPKidK+vP5Dfyz9LrJ2rflvOPu/o0spvRh2ce3kgS0HKS
	f5MvQFlgzPDB6QwbGOErM1Kw+EfHSdIB59KPxg5/YnXd1pBwux0r
X-Google-Smtp-Source: AGHT+IGMkE7CI24VJe+1teST6wVn87Qp5VhfR81Aytb16FIJmsIScvNTAjXSWyt0wEFhcFXjWQLs0Q==
X-Received: by 2002:ac2:59d9:0:b0:51e:41a1:4d5 with SMTP id 2adb3069b0e04-526be6ea7c3mr619614e87.9.1716362886504;
        Wed, 22 May 2024 00:28:06 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe9080sm493255405e9.5.2024.05.22.00.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 00:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 09:28:05 +0200
Message-Id: <D1FZV4IMV3FE.UZTMPWY3J3KB@gmail.com>
Subject: Re: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo
 reinject
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Praneesh P" <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-4-quic_ppranees@quicinc.com>
 <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
 <e8e4a015-3610-4f12-9ed8-e8281af8bf4f@quicinc.com>
In-Reply-To: <e8e4a015-3610-4f12-9ed8-e8281af8bf4f@quicinc.com>

On Wed May 22, 2024 at 9:15 AM CEST, Praneesh P wrote:
>
>
> On 5/21/2024 2:20 PM, Nicolas Escande wrote:
> > On Mon May 20, 2024 at 9:00 AM CEST, P Praneesh wrote:
> >> When handling fragmented packets, the ath12k driver reassembles each
> >> fragment into a normal packet and then reinjects it into the HW ring.
> >> However, a firmware crash occurs during this reinjection process.
> >> The issue arises because the driver populates peer metadata in
> >> reo_ent_ring->queue_addr_lo, while the firmware expects the physical
> >> address obtained from the corresponding peer=E2=80=99s queue descripto=
r. Fix it
> >> by filling peer's queue descriptor's physical address in queue_addr_lo=
.
> >>
> >> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> >>
> >> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 device=
s")
> >> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> >> ---
> >>   drivers/net/wireless/ath/ath12k/dp_rx.c | 14 ++++++--------
> >>   1 file changed, 6 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wir=
eless/ath/ath12k/dp_rx.c
> >> index 2bfcc19d15ea..2adb6c7d4a42 100644
> >> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> >> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> >> @@ -2967,7 +2967,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(st=
ruct ath12k *ar,
> >>   	struct hal_srng *srng;
> >>   	dma_addr_t link_paddr, buf_paddr;
> >>   	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
> >> -	u32 cookie, hal_rx_desc_sz, dest_ring_info0;
> >> +	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
> >>   	int ret;
> >>   	struct ath12k_rx_desc_info *desc_info;
> >>   	enum hal_rx_buf_return_buf_manager idle_link_rbm =3D dp->idle_link_=
rbm;
> >> @@ -3060,13 +3060,11 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(=
struct ath12k *ar,
> >>   	reo_ent_ring->rx_mpdu_info.peer_meta_data =3D
> >>   		reo_dest_ring->rx_mpdu_info.peer_meta_data;
> >>  =20
> >> -	/* Firmware expects physical address to be filled in queue_addr_lo i=
n
> >> -	 * the MLO scenario and in case of non MLO peer meta data needs to b=
e
> >> -	 * filled.
> >> -	 * TODO: Need to handle for MLO scenario.
> >> -	 */
> >> -	reo_ent_ring->queue_addr_lo =3D reo_dest_ring->rx_mpdu_info.peer_met=
a_data;
> >> -	reo_ent_ring->info0 =3D le32_encode_bits(dst_ind,
> >> +	reo_ent_ring->queue_addr_lo =3D cpu_to_le32(lower_32_bits(rx_tid->pa=
ddr));
> >> +	queue_addr_hi =3D upper_32_bits(rx_tid->paddr);
> > Shouldn't there be a cpu_to_le32 somewhere here ? It just seems asymetr=
ical
> > between the two values extracted from rx_tid->paddr
> le32_encode_bits of queue_addr_hi does that conversion, so there is no=20
> need to explicitly convert cpu_to_le32 while fetching rx_tid->paddr's=20
> upper 32 bits.
OK, got it,
> >> +	reo_ent_ring->info0 =3D le32_encode_bits(queue_addr_hi,
> >> +					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
> >> +			      le32_encode_bits(dst_ind,
> >>   					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
> >>  =20
> >>   	reo_ent_ring->info1 =3D le32_encode_bits(rx_tid->cur_sn,
> >=20
Thanks

