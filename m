Return-Path: <linux-wireless+bounces-24035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82226AD6872
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B1A1BC19FA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C71DDC37;
	Thu, 12 Jun 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8gAj6f0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7A142E73
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711757; cv=none; b=KJ07IDCB3cqjZmriYYynAd5DvM5hNIwA9/g9dph1lP9fMv0RiNof4XMdtTn3VI6yK9FBF/Fiz2AY/2iv+/goYPgCXpqYtFxbR9aYOpFzQZ7NZQ1pG4g/HRjHkHhkYsuXO13hqJezUK4B9SPRX8FFHjbVQU0FsgPnVI+IzG7RXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711757; c=relaxed/simple;
	bh=yUbefScyV6fywDXKmFEH+kZ81+XHm2FI0cg9MiAUBlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSCeSPoeqnZE3qbfnHK3iwGiSHQSo/8YDnWoioCa5d6SnlolLWnTUa3P3aqhMpik/DMNFq5gYCrgsBNx/f9jzNPZZ+0Kcs8UbDrFKPCQ3Z3b9ysxhv5RreNs0P3AvoUHSWt3Uue/Ei8OB4jzCxHFrIzJmUBU2iDMdCAjZqnJPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8gAj6f0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c3d06de3so866745b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749711754; x=1750316554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr8kVjHr7X/135AkQtdC+yfxTrVr7FzRufaMrCUufQI=;
        b=k8gAj6f0uwIN7Frdx8PhMbnnAo7rk8FvcBducP9wjzlbXc5kQG4/atD//UzivPdQku
         pDi7GzXJ8gNwz9gVs5hC4nLsHrR7oFi+KbTd2Q6crBfvY4dXgIJ3dk9V5KvAVaDztABr
         U/ix4NEe8In9NcLt9dHgobMdOQrptBTvmE+EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711754; x=1750316554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr8kVjHr7X/135AkQtdC+yfxTrVr7FzRufaMrCUufQI=;
        b=kfqD77VPCnQJ0UJGqqIjbKAKEisWP7Opt9JUmGc4z8ddCxcfP+tbyo/BpzyL/Kvm5b
         XjQgrBqEgHKLmVU/aUyQ9guXWnwou49r37QN5MUa5U3bfNfJM5s26Ge6i9hI3b+XC0RW
         57WyUefaYmKNilV7JmEmddNvYNl5Po2ZgR2iMLBJEJRTdNsXW3zIZLbAa7bq/w0EGZSn
         1NiKZP1IVU3JhX+Dx4K+zUTqUAMfZzs0x7zxT1XkYKrhaAM7PovVHTf+MRSMs7KUIQ0M
         YH41rRayyBgOjN5REAxAHTfTgxGZb9DBiaeeXZpm055gA9uVASifsHtnIFpwc1fT8dD1
         YhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwY/5Lxrn24DAm+f2zQJyKoyZWzapbwAnXMcM6cxQ6KEycvAHC+JERpI6p2Iw4k998udTLhDLnQ+hbgHl42Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzugMrdnIrc7NtKSljDEh8qj8VkiWlntLjeWWqLg56PTQwhAVp6
	RraJt1N4JW3pQgmcgNL3F/zGHow94IBrbWAPkA6oTWDvgaPvwunNW7Pz+oE8923eXA==
X-Gm-Gg: ASbGnctGiHF+Shqc/7J7EiFxv5fSH5msKthvwDiV9RPwspJLep2Uqcoc9787c4e3JIS
	9v4OVW/YyHs28NIhQSmaR1/NQwngFH4Tidea63EyvSLRPQ1ThCE4mvCDoYscOz8lAVcmvBFSqXw
	waWWH0BPvYCLYkQmUz1Lx95Xzy+zwMF7HkPVtllsHdTAysA/yTJ6nb6Wi6WgFi4n0gwMi9/dGUd
	jgrPkSxPWj7axjL19XcR0l6rbEeyG9nVgQkOU8GzEXe9CBpidN+XT7Nm7QTZIgc0VlvIuipMUL6
	vu1SQ1XXbh1DEtbxe+UtOoPSxTXFbr7upR1JTKwnYxJLoO2Ri37rdPBtXAPAMGej
X-Google-Smtp-Source: AGHT+IHval7kzOTw8xt75tWclw0C5/vtH8Ex8hhouxzzQKZOiM32UWpl93/0+/Xgn6u1sHUzijj+fQ==
X-Received: by 2002:a05:6a00:8cb:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-7487c31bda1mr2941155b3a.15.1749711753751;
        Thu, 12 Jun 2025 00:02:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fcb5:79e0:99d6:8d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087e769sm755732b3a.11.2025.06.12.00.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:02:33 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:02:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
Message-ID: <xr3n5pbohquhaloonctfqvpb2r3eu6fi5jly7ms4pgcotqmqzh@msrgbaawafsj>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>

On (25/06/12 13:47), Baochen Qiang wrote:
> > [..]
> >>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> >>> index 8cb1505a5a0c..cab11a35f911 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/hal.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> >>> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
> >>>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
> >>>  {
> >>>  	struct ath11k_hal *hal = &ab->hal;
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
> >>> +		ab->hal.srng_list[i].initialized = 0;
> >>
> >> With this flag reset, srng stats would not be dumped in ath11k_hal_dump_srng_stats().
> > 
> > I think un-initialized lists should not be dumped.
> > 
> > ath11k_hal_srng_deinit() releases wrp.vaddr and rdp.vaddr, which are
> > accessed, as far as I understand it, in ath11k_hal_dump_srng_stats()
> > as *srng->u.src_ring.tp_addr and *srng->u.dst_ring.hp_addr, presumably,
> > causing things like:
> 
> But ath11k_hal_dump_srng_stats() is called before ath11k_hal_srng_deinit(), right?
> 
> The sequence is ath11k_hal_dump_srng_stats() is called in reset process, then restart_work
> is queued and in ath11k_core_restart() we call ath11k_core_reconfigure_on_crash(), there
> ath11k_hal_srng_deinit() is called, right?

My understanding is that the driver first fails to reconfigure

<4>[163874.555825] ath11k_pci 0000:01:00.0: already resetting count 2
<4>[163884.606490] ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
<4>[163884.606508] ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
<3>[163884.606550] ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery

so ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit(),
which destroys the srng lists, but leaves the stale initialized flag.
So next time ath11k_hal_dump_srng_stats() is called everything looks ok,
but in fact everything is not quite ok.

Regardless of that, I do think that resetting the initialized flag
when srng list is de-initialized/destroyed is the right thing to do.

