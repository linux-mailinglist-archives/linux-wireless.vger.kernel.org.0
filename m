Return-Path: <linux-wireless+bounces-26188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174AFB1CD2E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DDB6227DC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0D2C0327;
	Wed,  6 Aug 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp+CeLOy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F92C08A2
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510554; cv=none; b=ghzK6xiUOmkbD5uZdDCWH5HSHEDMlk+xAM00o2hNTbutOC7mKZ6rW8Be5JBF0Ac9B2IRU02k3lrJhxOS+WX62Z3viFa3q0Xz+VeIuERDCPojI1pjyWXRTkyWP66zthz/Z8z6h3TS8KrEwItOG4bGnH2RT1hNdloCZJuC3+meLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510554; c=relaxed/simple;
	bh=SFkKIGdJvhjOnT27q+Zj3UdEmh3wehAbPU30mAMtZwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XwOvRF1trc3SoEpE5c/NCtclz5e6nM2kTiTV08+OAJpDb00jw4lAHKCy2ogExr62cIr8Q1yJ+R7F8/TocRZf/jhMQ+vC8CC8kuAO1Arr7Ck5aDIbAL59clUrUQL8fXaEHmzZ/pHwan4Up53AIJMt6UpB86XY/kcHD+VW2wdNl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp+CeLOy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso1704235e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510550; x=1755115350; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwHQj2S4iE5W8V5r1sARLF//FzzcxejJevd8ib6r6Bk=;
        b=Qp+CeLOyH3D+wZm42pEw6FKMju9rl6a2FBrIQmCEbssDMYqLIR0jEhLOzvkJP6G9KT
         hqH8GL17amfdup637GrLgmfKia0ro+OSg1AiTt+t+fzAzLE2FmEnLsPjrccKFgTBIcpg
         2iNakJ4H3TUveU672g8aFWim7H1zVF2b0FE9vOGboOfqGYHdpKB2q7DvDHozmQKuS2ps
         AbdaEoiCT/RJZaUpFuatuItPQJSqZeURlMA9YuuIwaanmR3kJwIUxkRPhhS9Ci2huge+
         DfBMzHS6z6NKq09wSx3bBAz1Z5vqfUaevQNmXXdJ1BjpQwVT9laj6PuWjfaynIhXc1a6
         /c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510550; x=1755115350;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QwHQj2S4iE5W8V5r1sARLF//FzzcxejJevd8ib6r6Bk=;
        b=OPG4oAhB4rtY13VPdpiZmYCM5LTM75i+ZSginoBk19jMWhxe798DVfB+V6UbSz54ih
         KIHFnZARmreds+T9+SCAKE2SbQRN50YDy+Ynq9CVsAz7euNCPsc44PvQU0DqRhQW6f2w
         vj3AOi9XzxNKboU4/PXjMafAnRjw8bz4NyuNEKfp2q/3R3QdQcZKuJvyi3V6ZjxbzAuW
         6lboCvCxb9bJpE7h+dwQD+BMPxSsoemWjTxmCwFreYR+a4WA9xvRvfC1sl1XbLCc1pIy
         NWclDuT0amK1Sp/gg5kH0cnyx3jOWQzQ/GFHmmrVOfd+Oki5PZl0UpC+5pKlNtaSEqyi
         NnfA==
X-Gm-Message-State: AOJu0YzKOPTSxWeBIejn0ehbntWzLZGaU8P4w83Rh+8WEKxJQM4DIgri
	GGz+JqQ/GEOQnJVFotTeWNSYSQFp1nyEt2AQ7OqfDEgdx4Z5Fhfgnn6seOm36A==
X-Gm-Gg: ASbGncubM1zfRZN38vKvpo8kMpVO0meeXpgfy/qBWsDhBrWtuzlPN48fKL9gOVpzGID
	8CysyF8kEO2u6OSX3QuxfwrWKEJc3lA0UNGPQ42UjTJuEVNu3uNu1lktUDLWZ6LcJke8MzLIi2A
	VZ0vUopKPb6TR4fAT0wB0unfsABak99ajSZPda862HNKqGZPUHfRtRJOASBlaINanYgBIUzX+eP
	MtI607HqXPqmGVGDO4r7jRdgxBr4VRWhBZ+JAfdlAE4P2hJ9mMCTKYLOr3ugsaHdqsobApsXyRT
	RdSt4+fyE0d+6XoD+I5f9T1q87o/JbffAn9Ppfb1JDj/bP5NH7pwV/pffb2+GVpc2X7OiXzE7RU
	KAmj6aV6C1XIUAnl+4y+qpvyfptpLkbMoIsAnPFn6
X-Google-Smtp-Source: AGHT+IHtL9F719IgiXDejNDTx8YGjo5svHsCY0ACzaMi+/cqLe1D3DEUC4gd6a7hIVYKxpfLhuyzCg==
X-Received: by 2002:a05:600c:4f4c:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-459e95af955mr26598505e9.21.1754510549796;
        Wed, 06 Aug 2025 13:02:29 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ee17535bsm7889325e9.16.2025.08.06.13.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 22:02:28 +0200
Message-Id: <DBVM2YZDTS15.1WAPW69YQ5XOA@gmail.com>
To: "Nithyanantham Paramasivam"
 <nithyanantham.paramasivam@oss.qualcomm.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX
 Queue Updates
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>

On Wed Aug 6, 2025 at 1:17 PM CEST, Nithyanantham Paramasivam wrote:
> During stress test scenarios, when the REO command ring becomes full,
> the RX queue update command issued during peer deletion fails due to
> insufficient space. In response, the host performs a dma_unmap and
> frees the associated memory. However, the hardware still retains a
> reference to the same memory address. If the kernel later reallocates
> this address, unaware that the hardware is still using it, it can
> lead to memory corruption-since the host might access or modify
> memory that is still actively referenced by the hardware.
>
> Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
> command during TID deletion to prevent memory corruption. Introduce
> a new list, reo_cmd_update_rx_queue_list, in the dp structure to
> track pending RX queue updates. Protect this list with
> reo_rxq_flush_lock, which also ensures synchronized access to
> reo_cmd_cache_flush_list. Defer memory release until hardware
> confirms the virtual address is no longer in use, avoiding immediate
> deallocation on command failure. Release memory for pending RX queue
> updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
> if hardware confirmation is not received.
>
> Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
> likelihood of ring exhaustion. Use a 1KB cache flush command for
> QoS TID descriptors to improve efficiency.
>

Hello,

I'm not sure I fully understand so please correct where I'm wrong but from =
what
I got looking at the code:
  - you increase the ring size for reo cmd
  - you enable releasing multiple tid buffer at once
  - as soon as you allocate the tid you create an entry in the list flaggin=
g it
    as active
  - when you need to clean up a tid
    - you mark it as inactive in the list, then
    - try to process the whole list by
      - sending the reo command to release it
      - if it succeed you release it and remove the entry from the list
  - on core exit, you re process the list

What is bothering me with this is that when a vdev which has multiple sta g=
oes
down, you will have a lot of those entries to push to the firmware at once:

  - So increasing the ring size / being able to release multiple entries at=
 once
    in one reo cmd may or may not be enough to handle the burst. It seems
    that increasing those is just band aids on the underlying problem but I
    understand it's just to be on the safe side.
  - If entries do not get send/accepted by the firmware, we will need to wa=
it
    for another station removal before retrying, which could be a wile.
  - Or in the worst case (one vdev going down and needing to release tid of
    all its stations) the more entries we have in the list the less likely =
we
    will be to be able to push the delete of all stations + the ones still =
in
    queue

So, on station removal, why not make just things completely async. Push the=
 tid
deletes in a list and wake a workqueue that tries to push those to the firm=
ware.
If the ring is full, retry periodically.

Thanks

