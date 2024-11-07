Return-Path: <linux-wireless+bounces-15104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2B9C0B00
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1328B281157
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38754216E0F;
	Thu,  7 Nov 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIrPnG8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44A215F58
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995790; cv=none; b=GRh0kyhQBDGuIQ/5EDtNmS7ZM3OVMe5p1LnqR5KchzbyCF175KY4nT8Lum1sCNBL6LUhayjrsERhsWA9ZuJU+H/Epyli1/NCEPSNqe/hpUp7vV/l6N9x6rJU0JnExSKJTcwvXOuxjP/fSw/qlwuszmI/Ikr9kMOhbNn1MwtViMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995790; c=relaxed/simple;
	bh=9uYl92ESq+nadkWJZNuYCmrQzUN+fm/5Hmarg7Tf1/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jP0JJqIQRYp7pDc3s+ZOZ4he7wlEfl30U5cF7/YMCwES3OMva8/oAth+p21cryUNvPt3QeJHx5iyYNRlim2qEc34W+AC0630d7u7wQHCP8C+ZCY6NZhpT0tZOjj8a5lpnlGvJfW5Ofp+bLHjAO6vSvTwBISms3WOHotzbDCAtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIrPnG8p; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ec4a40e95bso533647eaf.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730995788; x=1731600588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9uYl92ESq+nadkWJZNuYCmrQzUN+fm/5Hmarg7Tf1/c=;
        b=lIrPnG8pmFIZK8EGlcSz3X2/v0Yn18hj7aY5Nkr3spfUtxxAlvyMBRqrktR/C9mNll
         y+rOLuR9j39/WOJMqMRls4ZxdxEMiJ3hC/WN2zb3MV8O0NDLRtGIUqaRQnz2vCuDQTJ2
         uyCTP+VcWUOgvHuDPH3cdbMSOcY0c97oK+LK7/RiEf7dThVFntZPHAAZQy0fo0ZZr5f/
         bgtE1JQuklQ4ftsk8nx72kd2IWcOE96MQqX/C1dyETb4DwsZSdUaTLhrDyhM2OEhv7Jh
         wEOUVuZdDIkvPgzKm9uGC9GkGxQJpKFmJsXv6ufoGef1IB85cKit/c7ylGLz0FSoGh2R
         RumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995788; x=1731600588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uYl92ESq+nadkWJZNuYCmrQzUN+fm/5Hmarg7Tf1/c=;
        b=m57P+XSBly6ZtONFr6UZRnsj6bgl89ZFsWrMopSULvYfEN0MAEKKzb+K6quvpQq/xV
         RLnGDi+mR7kNzebm0k+1ajJj2h9wPNzpBS7lutzWZAmeQVTJZz+YTz5dQaZXMsrs6VE8
         fc+3jXoyx1NmsoMm4/UAVHeuihsVb5zTrrf7sJM/u08ThxRM3MLFc+HHJnv2vCkp/YnL
         PRarNJS7lfJZe2JI/l+LYOpSGQWc517xwnntZDFz3vnZQYsYkj3Y8hPPdMNT2NPVHyTM
         LXkXfXjGN+ywf9+eZVAsYkqL4fM3bgTfjAD1Az9Z5DPw3LT6hDJ1G2qCTSFntEz9KSPZ
         tT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUQiiKJ/0nPd+pxMAuNJ5TX0uBmW1HmpUn1ps7GEaZ9kD6Lp3I9iQi4qYesBZTbidL2GFpw4IUWOsOe/n67bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyO4rlNQtacqpab/8c+b6ifREcaLNlllCQg3Cy8xaUE5Or3UQ1
	W0CmGkBE/hUdwMkA/fCLEXYEVtLjYuoawQBth2TxL0aHdLYf593DrG9bVnNksI2wz8ad6D/usp2
	Dux3ouY9gF74US5GvGCYdRZa/5vY=
X-Google-Smtp-Source: AGHT+IGQQIFZL+MrWbuYkkS7QZpc3zw9tWtjHqxeTsQBeP2mETzg4Sf07f4Ezu6h1CcSuzpKSFVcrRIxtftMCE+KO+M=
X-Received: by 2002:a05:6820:1b08:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5ee56982567mr60610eaf.3.1730995787702; Thu, 07 Nov 2024
 08:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107132903.13513-1-nvbolhuis@gmail.com> <87ed3n5dxu.fsf@kernel.org>
In-Reply-To: <87ed3n5dxu.fsf@kernel.org>
From: N van Bolhuis <nvbolhuis@gmail.com>
Date: Thu, 7 Nov 2024 17:09:36 +0100
Message-ID: <CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
To: Kalle Valo <kvalo@kernel.org>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	arend.vanspriel@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Op do 7 nov 2024 om 15:14 schreef Kalle Valo <kvalo@kernel.org>:
>
> nvbolhuis@gmail.com writes:
>
> > From: Norbert van Bolhuis <nvbolhuis@gmail.com>
> >
> > This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
> > when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
> > are sent from the pkt queue.
> >
> > The problem is the number of entries in the pre-allocated sgtable, it is
> > nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
> > Given the default [rt]xglom_size=32 it's actually 35 which is too small.
> > Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
> > is added for each original SKB if tailroom isn't enough to hold tail_pad.
> > At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
> > in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
> > NULL and this causes the oops.
> >
> > The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
> > the worst-case.
> > Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
> > additional bytes of memory.
> >
> > Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
>
> What changed from v1? Please include a list of changes after '--' line,
> but no need to resend because of this.
>

Nothing changed, I just added the s-o-b.

