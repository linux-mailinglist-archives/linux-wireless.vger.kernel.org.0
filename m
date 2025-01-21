Return-Path: <linux-wireless+bounces-17798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26EBA182DC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DE23A7F7E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641E1BF7E8;
	Tue, 21 Jan 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="nlj0lE9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF307187FE4
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480411; cv=none; b=Nx3BOknhhjws57XVtjeib3e30bmNR9RQZP/JgQ4qz+sHB4bR3G8BoSQt39Vk/7DSX1vpzMcQLzgcewuYjbTPpAEi6dE5ioa8wLNknVcbPaSecMVxprOplk5HtkFjmRJ5/Oz8tXzWZQVDo48tPJJDOLjqGtQauo/mcfjYKmwQsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480411; c=relaxed/simple;
	bh=iVknQhSzg6caTnx1MsedpjNX5WbQMQxKCW8lMbzykcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsQScmMdINx35J4JD8x8/ejBt61BUm3+HH5dPLZmaGlLLWZ5AhTnptRTgYOk2y/5nGl/ZCy545+C8CF8a1BhxXvVF4+zx6/cPr4B+ye88Keo60BCd4oIa7cY/HTjHoHdm640ofQZplTDjKfrsCAxSoUyVhT0l8lIG9vzhdOF1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=nlj0lE9M; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4a6b978283so16671276.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1737480408; x=1738085208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU/S9Sk4m3Cf1n01L5292fNIPyUryfbIotTDKW9l8eY=;
        b=nlj0lE9MTWU7ZdX9w4L6Jcl10bAFcPynEpNyv3wHRvJ83Kjc8kUlRSgsgQns3xSpzJ
         Q3lr1cu5jQumzAxKcEsn08dX5Gf+4cYM7BE9/NagfBf4EmF+JBAjUuszITpuH9vHm58w
         LRNnGShkowWXPnivXuyT0orMrV+JbI3AjB4NVisTJP1YFllLcyyjpxkmks4YiEhlGf1I
         +wfmz9HYSEzP4PZeOXxQxYFPazjKejHPFO3kTOgCm7SjGSYGjSNFn7lcnbF2WM8sUwvE
         KTi3rna4BYGYbNHl2HUhPsl0FNEdNpBSVlbfpi+rUJAPUizClDHdlRSKaZdpkOYClvcI
         wupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480408; x=1738085208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XU/S9Sk4m3Cf1n01L5292fNIPyUryfbIotTDKW9l8eY=;
        b=Tb9zjbloIVNWzLCsMgo1OPFVRd99KDpVUcLikH/nmdv0G8qGnugyXtBf0SfWvrybcJ
         gGsywnrvTjgkixsH6PqVgZIZj6yaNleCxY3s5M4HsJaXYh4Fn7hdQE1Yws8396hUPqsV
         6ys8NbNm8JFsHDy/0JEY5GPzCkY1JaqXVEfe/lW0Dt/mR25iljXmdUZwTEf5LWQ+XNZc
         QLLnORFyHYX8XPO5czS60olGOI32x7hVagt74ZcnkGKDdGVf6MpvWmsZKcx4HXX7rSqR
         t9NorRUJiOqPzyfAvG4NX2rqas68RU0UozgQKCRp6y70ol1j95C27BmibLS9DCD5GYf4
         Fwbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZtCj6FRQj6Y+TaqLXmi6TMeUtONigRbHMoxhBYq6Y/W3HTpuWNDVtXXMqAhZFwhLLWXjS9UMWORv7pmeqrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Qa/u2MCAYzGgeuHXK2XzudvD4I7/sLIl4YufgfSLODL2aguI
	ePWnGtpK4ELVPY+TUq11PvxlWDte+vtinkYe9aRIwZQ8Ns+57QJdC3uI5d9adjbh0Azxe38CoY+
	UmD6V9H/kvGMH85NMc0Em/CK81nQx2sJjajyJfQ==
X-Gm-Gg: ASbGncvfojemeJUCwLeSRb71qtco9DINzYiV8M3ewqxNiiTdOStx79jPI/EyEbGQX/Z
	8xZchlbfLmtK/WfAPi5BU+uxU495aMEJyrahfRghBVPeLgjjDWXg=
X-Google-Smtp-Source: AGHT+IFd+gQREMHIvmFV2ABqWuaQze36LJac8HuI3AKKMlj9TsP1Mn9ZzCv+ubSsFiiVOFtV8rpoSb8WeDuDgZ70Nz8=
X-Received: by 2002:a05:690c:9a03:b0:6f0:23c9:2989 with SMTP id
 00721157ae682-6f6eb6b7e9amr136374417b3.11.1737480407727; Tue, 21 Jan 2025
 09:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119164219.647059-1-quic_ppranees@quicinc.com> <20250119164219.647059-3-quic_ppranees@quicinc.com>
In-Reply-To: <20250119164219.647059-3-quic_ppranees@quicinc.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 21 Jan 2025 09:26:36 -0800
X-Gm-Features: AbW1kvY37jZxQhLj0pk5NfHgGJvx3igq3RoIAPWuvZN3v5GGeaYgIFT3UVgPnfc
Message-ID: <CAJ+vNU2HR2=7i4yocQqKf2Ce8bap1fAaKYC3QxNwD5h-Z9PbAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: Use dma_alloc_noncoherent for rx_tid
 buffer allocation
To: P Praneesh <quic_ppranees@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 8:42=E2=80=AFAM P Praneesh <quic_ppranees@quicinc.c=
om> wrote:
>
> Currently, the driver allocates cacheable DMA buffers for the rx_tid
> structure using kzalloc() and dma_map_single(). These buffers are
> long-lived and can persist for the lifetime of the peer, which is not
> advisable. Instead of using kzalloc() and dma_map_single() for allocating
> cacheable DMA buffers, utilize the dma_alloc_noncoherent() helper for the
> allocation of long-lived cacheable DMA buffers, such as the peer's rx_tid=
.
> Since dma_alloc_noncoherent() returns unaligned physical and virtual
> addresses, align them internally before use within the driver. This
> ensures proper allocation of non-coherent memory through the kernel
> helper.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ=
_LITE-3
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp.h    |   6 +-
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 117 +++++++++++-------------
>  2 files changed, 58 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/=
ath/ath11k/dp.h
> index f777314db8b3..7a55afd33be8 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All ri=
ghts reserved.
>   */
>
>  #ifndef ATH11K_DP_H
> @@ -20,7 +20,6 @@ struct ath11k_ext_irq_grp;
>
>  struct dp_rx_tid {
>         u8 tid;
> -       u32 *vaddr;
>         dma_addr_t paddr;
>         u32 size;
>         u32 ba_win_sz;
> @@ -37,6 +36,9 @@ struct dp_rx_tid {
>         /* Timer info related to fragments */
>         struct timer_list frag_timer;
>         struct ath11k_base *ab;
> +       u32 *vaddr_unaligned;
> +       dma_addr_t paddr_unaligned;
> +       u32 unaligned_size;
>  };
>
>  #define DP_REO_DESC_FREE_THRESHOLD  64
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wirele=
ss/ath/ath11k/dp_rx.c
> index 029ecf51c9ef..5e71e5d9ecb7 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights r=
eserved.
>   */
>
>  #include <linux/ieee80211.h>
> @@ -675,11 +675,11 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_b=
ase *ab)
>         list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
>                 list_del(&cmd->list);
>                 rx_tid =3D &cmd->data;
> -               if (rx_tid->vaddr) {
> -                       dma_unmap_single(ab->dev, rx_tid->paddr,
> -                                        rx_tid->size, DMA_BIDIRECTIONAL)=
;
> -                       kfree(rx_tid->vaddr);
> -                       rx_tid->vaddr =3D NULL;
> +               if (rx_tid->vaddr_unaligned) {
> +                       dma_free_noncoherent(ab->dev, rx_tid->unaligned_s=
ize,
> +                                            rx_tid->vaddr_unaligned,
> +                                            rx_tid->paddr_unaligned, DMA=
_BIDIRECTIONAL);
> +                       rx_tid->vaddr_unaligned =3D NULL;
>                 }
>                 kfree(cmd);
>         }
> @@ -689,11 +689,11 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_b=
ase *ab)
>                 list_del(&cmd_cache->list);
>                 dp->reo_cmd_cache_flush_count--;
>                 rx_tid =3D &cmd_cache->data;
> -               if (rx_tid->vaddr) {
> -                       dma_unmap_single(ab->dev, rx_tid->paddr,
> -                                        rx_tid->size, DMA_BIDIRECTIONAL)=
;
> -                       kfree(rx_tid->vaddr);
> -                       rx_tid->vaddr =3D NULL;
> +               if (rx_tid->vaddr_unaligned) {
> +                       dma_free_noncoherent(ab->dev, rx_tid->unaligned_s=
ize,
> +                                            rx_tid->vaddr_unaligned,
> +                                            rx_tid->paddr_unaligned, DMA=
_BIDIRECTIONAL);
> +                       rx_tid->vaddr_unaligned =3D NULL;
>                 }
>                 kfree(cmd_cache);
>         }
> @@ -708,11 +708,11 @@ static void ath11k_dp_reo_cmd_free(struct ath11k_dp=
 *dp, void *ctx,
>         if (status !=3D HAL_REO_CMD_SUCCESS)
>                 ath11k_warn(dp->ab, "failed to flush rx tid hw desc, tid =
%d status %d\n",
>                             rx_tid->tid, status);
> -       if (rx_tid->vaddr) {
> -               dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size=
,
> -                                DMA_BIDIRECTIONAL);
> -               kfree(rx_tid->vaddr);
> -               rx_tid->vaddr =3D NULL;
> +       if (rx_tid->vaddr_unaligned) {
> +               dma_free_noncoherent(dp->ab->dev, rx_tid->unaligned_size,
> +                                    rx_tid->vaddr_unaligned,
> +                                    rx_tid->paddr_unaligned, DMA_BIDIREC=
TIONAL);
> +               rx_tid->vaddr_unaligned =3D NULL;
>         }
>  }
>
> @@ -749,10 +749,10 @@ static void ath11k_dp_reo_cache_flush(struct ath11k=
_base *ab,
>         if (ret) {
>                 ath11k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cm=
d, tid %d (%d)\n",
>                            rx_tid->tid, ret);
> -               dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
> -                                DMA_BIDIRECTIONAL);
> -               kfree(rx_tid->vaddr);
> -               rx_tid->vaddr =3D NULL;
> +               dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
> +                                    rx_tid->vaddr_unaligned,
> +                                    rx_tid->paddr_unaligned, DMA_BIDIREC=
TIONAL);
> +               rx_tid->vaddr_unaligned =3D NULL;
>         }
>  }
>
> @@ -802,10 +802,10 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k=
_dp *dp, void *ctx,
>
>         return;
>  free_desc:
> -       dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
> -                        DMA_BIDIRECTIONAL);
> -       kfree(rx_tid->vaddr);
> -       rx_tid->vaddr =3D NULL;
> +       dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
> +                            rx_tid->vaddr_unaligned,
> +                            rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
> +       rx_tid->vaddr_unaligned =3D NULL;
>  }
>
>  void ath11k_peer_rx_tid_delete(struct ath11k *ar,
> @@ -831,14 +831,16 @@ void ath11k_peer_rx_tid_delete(struct ath11k *ar,
>                 if (ret !=3D -ESHUTDOWN)
>                         ath11k_err(ar->ab, "failed to send HAL_REO_CMD_UP=
DATE_RX_QUEUE cmd, tid %d (%d)\n",
>                                    tid, ret);
> -               dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size=
,
> -                                DMA_BIDIRECTIONAL);
> -               kfree(rx_tid->vaddr);
> -               rx_tid->vaddr =3D NULL;
> +               dma_free_noncoherent(ar->ab->dev, rx_tid->unaligned_size,
> +                                    rx_tid->vaddr_unaligned,
> +                                    rx_tid->paddr_unaligned, DMA_BIDIREC=
TIONAL);
> +               rx_tid->vaddr_unaligned =3D NULL;
>         }
>
>         rx_tid->paddr =3D 0;
> +       rx_tid->paddr_unaligned =3D 0;
>         rx_tid->size =3D 0;
> +       rx_tid->unaligned_size =3D 0;
>  }
>
>  static int ath11k_dp_rx_link_desc_return(struct ath11k_base *ab,
> @@ -982,10 +984,9 @@ static void ath11k_dp_rx_tid_mem_free(struct ath11k_=
base *ab,
>         if (!rx_tid->active)
>                 goto unlock_exit;
>
> -       dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
> -                        DMA_BIDIRECTIONAL);
> -       kfree(rx_tid->vaddr);
> -       rx_tid->vaddr =3D NULL;
> +       dma_free_noncoherent(ab->dev, rx_tid->unaligned_size, rx_tid->vad=
dr_unaligned,
> +                            rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
> +       rx_tid->vaddr_unaligned =3D NULL;
>
>         rx_tid->active =3D false;
>
> @@ -1000,9 +1001,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, con=
st u8 *peer_mac, int vdev_id,
>         struct ath11k_base *ab =3D ar->ab;
>         struct ath11k_peer *peer;
>         struct dp_rx_tid *rx_tid;
> -       u32 hw_desc_sz;
> -       u32 *addr_aligned;
> -       void *vaddr;
> +       u32 hw_desc_sz, *vaddr;
> +       void *vaddr_unaligned;
>         dma_addr_t paddr;
>         int ret;
>
> @@ -1050,49 +1050,40 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, c=
onst u8 *peer_mac, int vdev_id,
>         else
>                 hw_desc_sz =3D ath11k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX=
, tid);
>
> -       vaddr =3D kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMI=
C);
> -       if (!vaddr) {
> +       rx_tid->unaligned_size =3D hw_desc_sz + HAL_LINK_DESC_ALIGN - 1;
> +       vaddr_unaligned =3D dma_alloc_noncoherent(ab->dev, rx_tid->unalig=
ned_size, &paddr,
> +                                               DMA_BIDIRECTIONAL, GFP_AT=
OMIC);
> +       if (!vaddr_unaligned) {
>                 spin_unlock_bh(&ab->base_lock);
>                 return -ENOMEM;
>         }
>
> -       addr_aligned =3D PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
> -
> -       ath11k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz,
> -                                  ssn, pn_type);
> -
> -       paddr =3D dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
> -                              DMA_BIDIRECTIONAL);
> -
> -       ret =3D dma_mapping_error(ab->dev, paddr);
> -       if (ret) {
> -               spin_unlock_bh(&ab->base_lock);
> -               ath11k_warn(ab, "failed to setup dma map for peer %pM rx =
tid %d: %d\n",
> -                           peer_mac, tid, ret);
> -               goto err_mem_free;
> -       }
> -
> -       rx_tid->vaddr =3D vaddr;
> -       rx_tid->paddr =3D paddr;
> +       rx_tid->vaddr_unaligned =3D vaddr_unaligned;
> +       vaddr =3D PTR_ALIGN(vaddr_unaligned, HAL_LINK_DESC_ALIGN);
> +       rx_tid->paddr_unaligned =3D paddr;
> +       rx_tid->paddr =3D rx_tid->paddr_unaligned + ((unsigned long)vaddr=
 -
> +                       (unsigned long)rx_tid->vaddr_unaligned);
> +       ath11k_hal_reo_qdesc_setup(vaddr, tid, ba_win_sz, ssn, pn_type);
>         rx_tid->size =3D hw_desc_sz;
>         rx_tid->active =3D true;
>
> +       /* After dma_alloc_noncoherent, vaddr is being modified for reo q=
desc setup.
> +        * Since these changes are not reflected in the device, driver no=
w needs to
> +        * explicitly call dma_sync_single_for_device.
> +        */
> +       dma_sync_single_for_device(ab->dev, rx_tid->paddr,
> +                                  rx_tid->size,
> +                                  DMA_TO_DEVICE);
>         spin_unlock_bh(&ab->base_lock);
>
> -       ret =3D ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_=
mac,
> -                                                    paddr, tid, 1, ba_wi=
n_sz);
> +       ret =3D ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_=
mac, rx_tid->paddr,
> +                                                    tid, 1, ba_win_sz);
>         if (ret) {
>                 ath11k_warn(ar->ab, "failed to setup rx reorder queue for=
 peer %pM tid %d: %d\n",
>                             peer_mac, tid, ret);
>                 ath11k_dp_rx_tid_mem_free(ab, peer_mac, vdev_id, tid);
>         }
>
> -       return ret;
> -
> -err_mem_free:
> -       kfree(rx_tid->vaddr);
> -       rx_tid->vaddr =3D NULL;
> -
>         return ret;
>  }
>
> --
> 2.34.1
>

I tested this with qcn9074 on an imx8mm (no iommu) with 4GiB DRAM and
verified swiotlb was not being used and infrastructure mode worked
fine.

Tested-By: Tim Harvey <tharvey@gateworks.com>

Best regards,

Tim

