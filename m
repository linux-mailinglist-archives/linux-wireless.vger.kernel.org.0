Return-Path: <linux-wireless+bounces-15579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3379D5507
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 22:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A32AB20EF9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 21:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AF1BD9EC;
	Thu, 21 Nov 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="PC56+6qa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D91C8FD4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225866; cv=none; b=k9uskFfw6TYD+XTt+nEFZsumGc2GCro1G0ot4KrLjZTD73aUT/6/dLK8s/X6YRMOi4i55XHvTnOY87JAuzTy0Jc9yTen6UXzcBYksVGHY1pPXculfCN9vVBK0Bv5HFyQ8LDCboKft1grS+a+G9lrpOmxKgEHCMKNTtGi8lGSqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225866; c=relaxed/simple;
	bh=AxNwTJaWHYPrCDlMmf20f1tc/yV3Ur6Il39ZG9T1W5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQMpBSzwFJj1NEq6C22/7vroD2nEzEnHKPIISgNPdCCBuK1Sl6oLp+22BQAmw7fpLHNelCs/cAj4vPQMQNo0529xDXx/pUn0qYXJExao7Eo1eaFa+QxZNmbWR3bgyV4S7rTv90jqKVvYKUEnYicI7/gnfA+23jaJy/hS9c9e8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=PC56+6qa; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1201995276.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1732225863; x=1732830663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvmIls9HCf1U20S7b6n5QCCkIPZBuK7yX0Sytsb+ryQ=;
        b=PC56+6qaLwLerSc+yZEWptL6bmdnnmqbSrDU0zbhtczo1VAWEcvuf8/fAmiobYurxL
         vMla8XT3K/8LFkxT9FIef74nkx0CHcB6Fa4hd4KSeTJWDl1ZBPR7MG+XFT6zsQlvbnnf
         y5nL+ibCsIlkK+tPBsZs8XwZx1bZPLpezDArI+APmDDReiqwJFsGL2e2SbtOAcfkal5G
         GKZBCOaE5ZE+8DZRAgYWcmAfwESTKZMpFJlvMjQYaZILeU/gCYbhiDhOVkRg2l5vTkqJ
         a8/xYLVPrsyS/IAdjIiCXZIZ5C6gM+a8EdmzTAwEqV4RgcAYDIzFezVEj+LaN8yT3seb
         1r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225863; x=1732830663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvmIls9HCf1U20S7b6n5QCCkIPZBuK7yX0Sytsb+ryQ=;
        b=K08PEp0rgu0OaG2WbZTJLWEw9fH2EIT1fWGYG1fokfbfNRR8Geny6m85DxcJnhM3p/
         SqGUL6DzB2dYSQoieOWtuJ3xbrZMsSTqlzhO4NCp3HrNoETdb0lT4NcgOraPwXpbG6pG
         YHHDvsPYPSjuLbhv+qZU5yIbzVGuN8yARwrKS+g6qeTojhb1lzMECQ01jyQV0QlD20iG
         lWh6od8l2AGzGZxeK7HAWIyI053ZcpSLbf+/K+2a+dAFQr0IxilA2Wh+gY69wKU6VEWv
         BTTNDe2Sil5ucl7+spH9tWPch+FEUyY3f24CYlsXBHKBuuqpQs6QNSn6vllFNB1Iynom
         mXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbZi18YpEvuy+DmXg1FAh5yNnl2m6+Jjzpd3XDyFZpoMeZaZZDLx1mhwDfMlC0t1Cy3dKkvEVgFrg5dJdpXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNeQ4JuBZx+/813kZy0k1SPc2J8i2yjIkYTBPLK5oJ/kv09T8
	zuB8ZB/mqrg7UAxt4M07uuZ/a6D0IsAgMkApx16c+doNM2YELl3hhO9VPs8RHrs8b+U++0PbPo8
	4u1mQFbLa/VzuRaQNDAbW2ze3bhuGnFJAteP3Nwy4bjskL8JwNkjVMw==
X-Gm-Gg: ASbGnctVdVWQztIRihIcgNPZfD+F/kSlKm/D77uauqAfNRaaout9OzxWCja3AvcMa96
	JCUxMdUOUfMx37sx5Cm0IIWwlv/lvXeI=
X-Google-Smtp-Source: AGHT+IFCoSh7suQDmF83a1vG2EqzA9vdNFU5UbI2JfZq+hnTFw9UCh56VNtgB5XyOCZ+cJityLBWZkUiH6+0KeY+Su8=
X-Received: by 2002:a05:6902:1022:b0:e38:b1d2:e784 with SMTP id
 3f1490d57ef6-e38f8b34554mr523758276.22.1732225862955; Thu, 21 Nov 2024
 13:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU0dCV7-2gFDPTiOjAV-HCeHZ3H1DjGdqYKo+MGadfrSbA@mail.gmail.com>
 <ac097ff6-5a17-4dad-89e7-cb4360e23e89@quicinc.com>
In-Reply-To: <ac097ff6-5a17-4dad-89e7-cb4360e23e89@quicinc.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 21 Nov 2024 13:50:51 -0800
Message-ID: <CAJ+vNU2q7jOMJvRK+3hwNWwy0oHwAR_aYKnwdOCn-Cn4=0ZT3Q@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 6:32=E2=80=AFPM Baochen Qiang <quic_bqiang@quicinc.=
com> wrote:
>
>
>
> On 11/20/2024 4:16 AM, Tim Harvey wrote:
> > Greetings,
> >
> > I've got an ath11k card that is failing to init on an IMX8MM system
> > with 4GB of DRAM:
> > [    7.551582] ath11k_pci 0000:01:00.0: BAR 0 [mem
> > 0x18000000-0x181fffff 64bit]: assigned
> > [    7.551713] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> > [    7.552401] ath11k_pci 0000:01:00.0: MSI vectors: 16
> > [    7.552440] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
> > [    7.887186] mhi mhi0: Loaded FW: ath11k/QCN9074/hw1.0/amss.bin,
> > sha256: 5ee1b7b204541b5f99984f21d694ececaec08fbce1b520ffe6fe740b02a4afd=
7
> > [    8.435964] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
> > board_id 0xff soc_id 0xffffffff
> > [    8.435991] ath11k_pci 0000:01:00.0: fw_version 0x270206d0
> > fw_build_timestamp 2022-08-04 12:48 fw_build_id
> > WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> > [    8.441700] ath11k_pci 0000:01:00.0: Loaded FW:
> > ath11k/QCN9074/hw1.0/board-2.bin, sha256:
> > dbf0ca14aa1229eccd48f26f1026901b9718b143bd30b51b8ea67c84ba6207f1
> > [    9.753764] ath11k_pci 0000:01:00.0: Loaded FW:
> > ath11k/QCN9074/hw1.0/m3.bin, sha256:
> > b6d957f335073a15a8de809398e1506f0200a08747eaf7189c843cf519ffc1de
> > [    9.789791] ath11k_pci 0000:01:00.0: swiotlb buffer is full (sz:
> > 1048583 bytes), total 32768 (slots), used 2528 (slots)
> > [    9.789853] ath11k_pci 0000:01:00.0: failed to set up tcl_comp ring =
(0) :-12
> > [    9.790238] ath11k_pci 0000:01:00.0: failed to init DP: -12
> > root@noble-venice:~# cat /proc/cmdline
> > console=3Dttymxc1,115200 earlycon=3Dec_imx6q,0x30890000,115200
> > root=3DPARTUUID=3D5cdde84f-01 rootwait net.ifnames=3D0 cma=3D196M
> >
> > The IMX8MM's DRAM base is at 1GB so anything above 3GB hits the 32bit
> > address boundary. If I pass in a mem=3D3096M the device registers just
> > fine.
> yeah ... that parameter makes kernel alloc memory below 32bit boundary, t=
hus swiotlb is not necessary.

Hi Baochen,

Yes, that makes sense as I step through the code. On IMX8M with DRAM
3GB or less dma_capable(...) is true so swiotlb bounce buffers are not
needed.

>
> >
> > I found this to be the case with modern kernels however I found
> > differing behavior with older kernels:
> > - 6.6 and 6.1 the device registers with 4GB DRAM but crashes on client =
connect
> > - 5.15 devices registers with 4GB DRAM and appears to work just fine
> are you using Linus' tree or the stable tree?
>

For 6.6 I tested stable.

This likely has something to do with commit dbd73acb22d8 ("wifi:
ath11k: enable 36 bit mask for stream DMA") but it would seem to me
that patch was trying to avoid the entire 32bit DMA limitation. Maybe
that patch sets the ath11k device DMA mask to 36 bits but maybe the
IMX8M PCI DMA is only capable of 32bits?

> >
> > Could anyone explain what is going on here? Obviously there have been
> > changes at some point to start using swiotlb which I believe was all
> > about avoiding 32bit DMA limitations but I'm not clear how I should be
> > configuring this for IMX8MM with 4GB DRAM. Maybe my kernel IOMMU
> > configuration is incorrect somehow?
> there are quite some options associated with IOMMU, not sure which one mi=
ght be causing this. But basically you may check:
>
> CONFIG_IOMMU_IOVA
> CONFIG_IOMMU_API
> CONFIG_IOMMU_SUPPORT
> CONFIG_IOMMU_DMA=3Dy
>

These are enabled which I believe appropriate for IMX8M. If I want to
utilize the full 4GB DRAM on IMX then I must use IOMMU and swiotlb
which would mean a performance hit due to copying mem to/from bounce
buffers not to mention the fact that I can't figure out how to
configure the system to avoid the 'swiotlb swiotlb buffer is full'
issue.

Enabling CONFIG_SWIOTLB_DYNAMIC does not help nor does increasing the
number of slots - it has something to do with the number/size of DMA
buffers that ath11k is asking for:
# dmesg | grep swiotlb_tbl_map_single
[    5.237731] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16384 (slots=3D32768/    32)
[    5.247519] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16416 (slots=3D32768/    64)
[    5.261794] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16448 (slots=3D32768/    96)
[    5.275114] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16480 (slots=3D32768/   128)
[    5.287757] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16512 (slots=3D32768/   160)
[    5.299688] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16544 (slots=3D32768/   192)
[    5.312482] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16576 (slots=3D32768/   224)
[    5.324493] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16608 (slots=3D32768/   256)
[    5.337001] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16640 (slots=3D32768/   288)
[    5.346754] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16672 (slots=3D32768/   320)
[    5.356571] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16704 (slots=3D32768/   352)
[    5.366372] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16736 (slots=3D32768/   384)
[    5.376164] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16768 (slots=3D32768/   416)
[    5.385944] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16800 (slots=3D32768/   448)
[    5.395712] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16832 (slots=3D32768/   480)
[    5.408270] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16864 (slots=3D32768/   512)
[    5.419768] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16896 (slots=3D32768/   544)
[    5.430966] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16928 (slots=3D32768/   576)
[    5.442368] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16960 (slots=3D32768/   608)
[    5.452422] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 16992 (slots=3D32768/   640)
[    5.463507] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17024 (slots=3D32768/   672)
[    5.473536] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17056 (slots=3D32768/   704)
[    5.485661] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17088 (slots=3D32768/   736)
[    5.495404] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17120 (slots=3D32768/   768)
[    5.509626] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17152 (slots=3D32768/   800)
[    5.519353] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17184 (slots=3D32768/   832)
[    5.529077] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17216 (slots=3D32768/   864)
[    5.538799] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17248 (slots=3D32768/   896)
[    5.548517] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17280 (slots=3D32768/   928)
[    5.558238] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17312 (slots=3D32768/   960)
[    5.567965] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D 17344 (slots=3D32768/   992)
[    5.578943] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D     0 (slots=3D32768/   992)
[    5.578964] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8192 (slots=3D32768/   993)
[    5.599793] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D    32 (slots=3D32768/   992)
[    5.599861] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 68B index=3D  8193 (slots=3D32768/   993)
[    5.609589] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D    64 (slots=3D32768/   993)
[    5.628921] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D    96 (slots=3D32768/   992)
[    5.638703] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 68B index=3D 17376 (slots=3D32768/   993)
[    5.649602] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   128 (slots=3D32768/   992)
[    5.659389] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   160 (slots=3D32768/   992)
[    5.674038] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 96B index=3D 17377 (slots=3D32768/   993)
[    5.685016] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   192 (slots=3D32768/   992)
[    5.694819] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   224 (slots=3D32768/   992)
[    5.694831] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D 17378 (slots=3D32768/   993)
[    5.714194] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 40B index=3D 17379 (slots=3D32768/   994)
[    5.725089] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   256 (slots=3D32768/   992)
[    5.753507] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17380 (slots=3D32768/   996)
[    5.764668] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   288 (slots=3D32768/   992)
[    5.774456] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   320 (slots=3D32768/   992)
[    5.774620] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17384 (slots=3D32768/   996)
[    5.795091] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   352 (slots=3D32768/   992)
[    5.795241] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17388 (slots=3D32768/   996)
[    5.815724] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   384 (slots=3D32768/   992)
[    5.815884] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17392 (slots=3D32768/   996)
[    5.836357] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   416 (slots=3D32768/   992)
[    5.836368] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8194 (slots=3D32768/   993)
[    5.855856] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17396 (slots=3D32768/   997)
[    5.866818] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   448 (slots=3D32768/   992)
[    5.866978] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17400 (slots=3D32768/   996)
[    5.887451] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   480 (slots=3D32768/   992)
[    5.897231] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   512 (slots=3D32768/   992)
[    5.897389] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17404 (slots=3D32768/   996)
[    5.917866] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   544 (slots=3D32768/   992)
[    5.918026] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17408 (slots=3D32768/   996)
[    5.938489] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   576 (slots=3D32768/   992)
[    5.938642] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17412 (slots=3D32768/   996)
[    5.959121] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   608 (slots=3D32768/   992)
[    5.959135] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8195 (slots=3D32768/   993)
[    5.978619] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17416 (slots=3D32768/   997)
[    5.989588] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   640 (slots=3D32768/   992)
[    5.989738] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17420 (slots=3D32768/   996)
[    6.010215] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   672 (slots=3D32768/   992)
[    6.020001] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   704 (slots=3D32768/   992)
[    6.020158] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17424 (slots=3D32768/   996)
[    6.040643] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   736 (slots=3D32768/   992)
[    6.040798] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17428 (slots=3D32768/   996)
[    6.061287] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   768 (slots=3D32768/   992)
[    6.061437] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17432 (slots=3D32768/   996)
[    6.081918] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   800 (slots=3D32768/   992)
[    6.081929] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8196 (slots=3D32768/   993)
[    6.101409] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17436 (slots=3D32768/   997)
[    6.112375] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   832 (slots=3D32768/   992)
[    6.112528] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17440 (slots=3D32768/   996)
[    6.133004] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   864 (slots=3D32768/   992)
[    6.142785] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   896 (slots=3D32768/   992)
[    6.142949] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17444 (slots=3D32768/   996)
[    6.163426] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   928 (slots=3D32768/   992)
[    6.163576] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17448 (slots=3D32768/   996)
[    6.184058] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   960 (slots=3D32768/   992)
[    6.184208] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17452 (slots=3D32768/   996)
[    6.204691] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D   992 (slots=3D32768/   992)
[    6.204704] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8197 (slots=3D32768/   993)
[    6.224183] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17456 (slots=3D32768/   997)
[    6.235148] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1024 (slots=3D32768/   992)
[    6.235308] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
6224B index=3D 17460 (slots=3D32768/   996)
[    6.255777] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1056 (slots=3D32768/   992)
[    6.265552] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1088 (slots=3D32768/   992)
[    6.265633] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
2128B index=3D 17464 (slots=3D32768/   994)
[    6.286142] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1120 (slots=3D32768/   992)
[    6.286182] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 72B index=3D 17466 (slots=3D32768/   993)
[    7.574489] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1152 (slots=3D32768/   992)
[    7.584645] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 60B index=3D 17467 (slots=3D32768/   993)
[    7.595593] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1184 (slots=3D32768/   992)
[    7.595608] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  8198 (slots=3D32768/   993)
[    7.605359] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1216 (slots=3D32768/   993)
[    7.624703] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
452B index=3D  1248 (slots=3D32768/   993)
[    7.635603] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1280 (slots=3D32768/   992)
[    7.645344] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
 52B index=3D  1312 (slots=3D32768/   993)
[    7.656247] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1314 (slots=3D32768/   992)
[    7.683567] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=3D
65535B index=3D  1346 (slots=3D32768/   992)
[    7.696095] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single
size=3D1048583B index=3D    -1 (slots=3D32768/   992)

I'm still trying to understand the swiotlb allocation to see if there
is some configuration change I should be making.

To avoid using swiotlb is there some way to limit the memory region
used for DMA operations to below 32bit boundary yet still allow the
memory above 32bit to be useful in the system for userspace maybe?

Best Regards,

Tim

> >
> > I'm also unclear why there was no apparent problem with older kernels
> > such as 5.15.
> >
> > Best Regards,
> >
> > Tim
> >
>

