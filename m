Return-Path: <linux-wireless+bounces-16113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416F9E9F40
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 20:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E0A161C78
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CA198842;
	Mon,  9 Dec 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="iN27mpf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468B1946DA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771717; cv=none; b=NBB7WsG5QXyrSVLBTmpf3Cxz/P+tYgPJ7KRUx4FZlmSD9palJZYM90xHcxapIOBiWTA7bj3iuSJqttSl/eGF93KwtFWjZLVhdYD+VENWVTIPibfxJZxnKcEgjWk/rf97ZQJVD31aPhgnEmQJ653MIF1ApWw+n21fCrDgkjfSPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771717; c=relaxed/simple;
	bh=V3Lot97r1vXyev3SYHCUBIR8IfuPtsIyk6738RhXCsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DisNEbR10pKkt/YmDPeLB1g2/JPYvg/jbvOvxEymdK7Y5Bs1sUEGgCA2/0ynd0SR/YWtqku1xex5VdBbNDDEy54GemZPtrcP2bui4K/pb1Tpimp3q9HVDyAqBHtD6mgOlrVBFlefwSgdBWZqPmJrofeQo1JTpFGAs1ZR61XZvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=iN27mpf6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e398273d6ffso3659982276.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1733771714; x=1734376514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kLjgnxaHMn5y0gTT+3dvOLNzEd5yWQ0Er4eRA/5e+Q=;
        b=iN27mpf6UI+BA5V1+ot8f82iKDgQz9r3sWGxZZE3mES8u6LnDB+lVyg9wQK1ayMovm
         24gawwH3Xf3LKYiskXQU0ShtFvyhTjfwPw9Wn1UVT4mNSdy2+O1ZjFZoxiiYtpEI3gFd
         wIGZtGrbo6AIv/1pK1DN2WbvO1NL69NIGgGQf1lezXWDfwr2+sDTx4rzCns0oXmfmupD
         69j8iGrPTKJdj+Svif0/GBk0TLrGaVAD+mW7dc1nvcAxoAj0/xHISGT5XosB9zInMmvk
         UiV8RXwU5baQsqwFz7J3jMcHcVcLhtqC7dvP+S3W72SryvnpiwxuXYptPvERigNksra7
         rXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771714; x=1734376514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kLjgnxaHMn5y0gTT+3dvOLNzEd5yWQ0Er4eRA/5e+Q=;
        b=MNSTSL731XfJDQtsss39J5CgVO/bjwwJrFB2/0GOQCVR8QSW4vFxIYOWR++EqwaDcs
         fS8bBxE2nEa8FBm2ftjrCq0Qrd1Do+uDyAfJKHUvZ9qW5bSNpQbYV17KOcDzHwpTnPs0
         ym/zoaAkpUQDvdk0ZR4Kop7QrXdsHIRiBm61vebnvU5YNUxwCp1S41u+JzaEew8+LJ0q
         fPJ71lO7G7/RqjFKH3/1ttHGHT4YPzEFeVGcszgv8QQi2WHXsHE3ziWRfdu5kdJCJezG
         h5x1hfaeJu5LYUL/xkl0tEJl7xHZTT6tfHI7gbOeMgc606IDyUAx9S/IOewCw897cFoU
         eCHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXyG3NKZoeTjRfwLHjPmlJ1kjY34A0eUluQPy47z1dwOd2zRAB5Bpqvio4nwAhTNXuok2Sf+t3Vw9nSiQbDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uWu5dcS9n9rQtcX1BWXzDfv0dK5/79v79Qmn1501WnqlKa3p
	8Qsdw1ffrCzDPjn+moj/zpLbCeXIWTlh/Kp5jE/ZQn746D617aUNq/CvvXOnAuA667fGta2eLau
	8pIKvz6La8hq2mAJUwfWy5NTGSedxHYN8Rj2J2Q==
X-Gm-Gg: ASbGnctFR7fADLdZqKyvNEu9Pdhh4psk0W/7nLgPt86nhMekocd5ip7x2Nz16YCVyDP
	CxnOgi35MVwFCycCuQ/nq2BnaaCwpaJw=
X-Google-Smtp-Source: AGHT+IGEl64T8fh4w41xF5QeO5D03WN4PRl4tWrD5C7XLi4pHuR/6CFrIf/3ED6k/l9Dz+t1Bywo3Kx6XChWXHllhco=
X-Received: by 2002:a05:6902:124b:b0:e3a:32a9:82cc with SMTP id
 3f1490d57ef6-e3a59bade21mr1582408276.36.1733771714002; Mon, 09 Dec 2024
 11:15:14 -0800 (PST)
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
In-Reply-To: <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Dec 2024 11:15:02 -0800
Message-ID: <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	P Praneesh <ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:49=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 09/12/2024 8:17 am, Christoph Hellwig wrote:
> > I scrolled three pages before giving up as it was just quotes over
> > quotas.  Can you please write an email that contains whatever you're
> > trying to tell instead of just quotes?  Same for the person replying.
>

Christoph,

Understood; there was a lot of back and forth and likely some
misinformation from my early replies. Let me recap here.

The issue I run into is that with Linux 6.9 and beyond on an IMX8M
Mini SoC (no IMOMMU) with >3GiB DRAM (which requires more than 32 bits
of address due to IMX8M's DRAM base being at 0x40000000) the ath11k
driver will fail to register a netdev and errors out with 'ath11k
swiotlb buffer is full':
[    8.057077] ath11k_pci 0000:04:00.0: BAR 0 [mem
0x18200000-0x183fffff 64bit]: assigned
[    8.057151] ath11k_pci 0000:04:00.0: enabling device (0000 -> 0002)
[    8.091920] ath11k_pci 0000:04:00.0: MSI vectors: 16
[    8.091960] ath11k_pci 0000:04:00.0: qcn9074 hw1.0
[    8.832924] ath11k_pci 0000:04:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[    8.832951] ath11k_pci 0000:04:00.0: fw_version 0x270206d0
fw_build_timestamp 2022-08-04 12:48 fw_build_id
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
[   10.194343] ath11k_pci 0000:04:00.0: swiotlb buffer is full (sz:
1048583 bytes), total 32768 (slots), used 2529 (slots)
[   10.194406] ath11k_pci 0000:04:00.0: failed to set up tcl_comp ring (0) =
:-12
[   10.194781] ath11k_pci 0000:04:00.0: failed to init DP: -12

After a lot of back and forth and investigation this is due to the
IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
is requesting some buffers that are too large for swiotlb to provide.
There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
to cacheable memory that could be reverted to fix this but the concern
was that it would impact performance moving those buffers to
non-cacheable memory (there are three ~1MiB buffers being allocated):
commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
cacheable memory").

> TBH I'm hesitant to look too closely since everything those Atheros WiFi
> drivers do with DMA tends to be sketchy, but from what I could make out
> from skimming until I also gave up, I think it might be an attempt to
> reinvent dma_alloc_pages(), or possibly dma_alloc_noncoherent().

Robin,

Agreed - I'm not sure how much attention, review, or testing these
ath11k patches originally got due to the fact that there appears to be
breakage for a couple of years here.

The chain of events as best I can tell are:

commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
cacheable memory")
- Nov 12 2021 (made it into Linux 5.17)
- changes allocation of reo_dst rings to cacheable memory to allow
cached descriptor access to optimize CPU usage
- this is flawed because it uses virt_to_phys() to allocate cacheable
memory which does not work on systems with an IOMMU enabled or using
software IOMMU (swiotlb); this causes a kernel crash on client
association

commit d0e2523bfa9c ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
cacheable memory)
- Nov 12 2021 (made it into Linux Linux 5.17)
- furthers the previous patch by also including the WBM2SW buffers in
cacheable memory which are about 1MiB in size

commit aaf244141ed7 ("wifi: ath11k: fix IOMMU errors on buffer rings")
- Dec 20 2023 (made it into Linux 6.9)
- resolves the issue from commit 6452f0a3d565 (but missing a Fixes
tag) by changing the virt_to_phys calls to dma_map_single() but on
systems that need software IOMMUC (IMX8MM > 3GiB) this exposes the
'swiotlb buffer is full' limitation due to commit d0e2523bfa9c which
allocates buffers exceeding the 256KiB limit imposed by swiotlb

Therefore in the case of an IOMMU'less system with DMA address
limitations of 32bit and >3GiB DRAM (as many IMX8M boards have) the
ath11k driver has been broken since 5.17.

Best Regards,

Tim

