Return-Path: <linux-wireless+bounces-16202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B39EBEF1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 00:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224251887D8A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B32451EF;
	Tue, 10 Dec 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="fp0rOm4H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F561AAA2F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872005; cv=none; b=DnjyVlEPthL88Y3drd/bHAET93oZHpTz1njftRXgHY8qRUcST8cqmzkWIqUcxq71mOMslkr3iNVc+dWBdnOIYH2zs4uT3r7EIlugIjV4w0PfhxFvvXQaYZypLlvVJ4JZjd4gfN5L1dHIq6zRT/ZDzYZ60HH1KRd+wN9gjcrcos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872005; c=relaxed/simple;
	bh=sVYXJXSzW6YUxCJsxxrtVnqQTqgEA8N5VXF4bXIS/Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKaOdjZsG8Y/+yb0qNMWHERUAs/+x1H0rwEbJeU6m6a3Dp/IpXp40gCan77hrUnIZt/WolcqFx4oXnT5ZFDMH+lp/AVYbpvNS8Zfm13/lRrIE2EDrd+TSYWpVYZvSHYoa19bsj2HnSXhFEXZZ/P9G4MEz4vcQYSCnWz8vIqfxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=fp0rOm4H; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f006748fd1so28824837b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1733872002; x=1734476802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqT6g0W8wBftvp6aSxR69K7dIiruVpolHF6yT66BzYA=;
        b=fp0rOm4H/NWQSLEw4WejfyfqwKpbqPa2p4CQyF00SAwNWydLw+H+Xh+R4KCHWdc0qy
         8me6se4LgVVVobxbPHkJyr5ha7rcxF/Yrvz9VmHn4RVmRp5+eS27rNGqIlHTvpl6scwb
         S0xrWK7z3RIDtEhnw1NQdr76L6Qa5TX67mR+bzYGlfZdBMieugtdgv2JUyrCJn/7JGzB
         sHQCRfp+ss2EDJgt/HqFr5A4NuthZNJn7aksmJteA3torGa3JWhgKPgsHDVZPkqMTYyv
         7AO61/zjdWmGEZnFkI1/NMWD/i4SW8jaArz1DtyiMtt9sMOc7TkORddvIcXOh1pkQ6nR
         wBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733872002; x=1734476802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqT6g0W8wBftvp6aSxR69K7dIiruVpolHF6yT66BzYA=;
        b=ZGFX9/CntIZuC3BsiIUYCyG+icjmOFgarrCUFUawADCHOZQH8l/H0fuenleGud23pe
         XfJQRoH+zQXmm9CYsa1cYIkBh7wygljEvoH8VXIv3zZtcIvVUJdeApJXekmmO8Wmn3vU
         A4yYLrnhz3961ClfNyFrSt/SdoFmc9VLGWJezjLd3Yfi6EYyEMYMPoQ28/gwFRTseYcg
         jgepqm8Y3wjyKEKqa2Ez4a3A7CqWiWftcn7r3b6LCHxQjL26kO9yXSQTYjnNn6oXQ9ef
         tjAbupWImu03DekKw6nMHFer0na7Hk0iiThCcKSEmIIGV4N87KWbxaJ3UcCpHaTL1lU3
         rOrw==
X-Forwarded-Encrypted: i=1; AJvYcCV1BrFHmy5wu6k0bfpywBT3NQraFjmU6aw3hK0PaqYd4BfD8C4iAAVB9rQ2z9rdaQwnlTOY9Ku5QV5VMYiKaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrG1jvP0+BG3fax6K9zM5Zl+fe7up7cfQYl/t6lqfFPUwrCbv
	1sPTYAS9imdMTCUSBUkqMWYmG7HGsk2RKXVLF1DDqqjuS34keRxCopyEZw3VAj9TEdb1EmrpMYg
	LD/xXVznBTXzsNkhP6dfB3r8Ce9gs7o9No6dqIQ==
X-Gm-Gg: ASbGnctwkGNxg2ewPLG3riOK+gxOlQBoUUK/ACdBmc24AfKizuciwBAJ2DGvas/imWS
	xjWPfehTSr/6F3OxbdGkl+C43nwoUuSs8wmA=
X-Google-Smtp-Source: AGHT+IHDSE8vWTo5AI2GRtvcRlxTgl5Sv9MW1qFpKY2BPLTbrUME85VaPcnBA4mMZTf7UD9AjbDzT6zqXJ7grktQ4+s=
X-Received: by 2002:a05:6902:260c:b0:e39:8f3e:30a1 with SMTP id
 3f1490d57ef6-e3c8e645ca4mr949108276.46.1733872002729; Tue, 10 Dec 2024
 15:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com> <20241210041133.GA17116@lst.de>
In-Reply-To: <20241210041133.GA17116@lst.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 10 Dec 2024 15:06:31 -0800
Message-ID: <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	ath11k@lists.infradead.org, linux-wireless <linux-wireless@vger.kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:11=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
> > After a lot of back and forth and investigation this is due to the
> > IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
> > is requesting some buffers that are too large for swiotlb to provide.
> > There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
> > to cacheable memory that could be reverted to fix this but the concern
> > was that it would impact performance moving those buffers to
> > non-cacheable memory (there are three ~1MiB buffers being allocated):
> > commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
> > cacheable memory").
>
> The combination of "buffers" and "swiotlb" sounds like Robin was right
> below.
>
> > The chain of events as best I can tell are:
> >
> > commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
> > cacheable memory")
> > - Nov 12 2021 (made it into Linux 5.17)
> > - changes allocation of reo_dst rings to cacheable memory to allow
> > cached descriptor access to optimize CPU usage
> > - this is flawed because it uses virt_to_phys() to allocate cacheable
> > memory which does not work on systems with an IOMMU enabled or using
> > software IOMMU (swiotlb); this causes a kernel crash on client
> > association
>
> And this is where it started to take a wrong turn, that everyhing
> later basically made worse.  If you have long living and potentially
> large DMA allocations, you need to use dma_alloc_* interfaces.
>
> 5.17 already had dma_alloc_pages for quite a while which was and still is
> the proper interface to use.  For much older kernel you'd be stuck
> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
> but even that would have been much better.

Christoph,

I'm not clear what you are suggesting be done here. Are you suggesting
that ath11k has been using the wrong mechanism by calling
dma_map_single for cached DMA buffers? I'm not all that familiar with
ath11k so I can't tell what buffers are considered long living.

Best Regards,

Tim

