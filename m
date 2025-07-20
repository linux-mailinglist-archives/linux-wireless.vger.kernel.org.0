Return-Path: <linux-wireless+bounces-25686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C014B0B385
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 06:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6A47A738C
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jul 2025 04:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4419DF4D;
	Sun, 20 Jul 2025 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hues/3N8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A687260A;
	Sun, 20 Jul 2025 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752985494; cv=none; b=R36AQKxs+EW/bzPxSU2lP39rVhvCuqJq85eSfsEXupBjPbenaEOe4PYE5oCvHok8/4JxxxfpZWJQOfzBKpqHeD7w3taLDcwEII7Pg1I7I7GYklEb7EddptGiaeHMBRge23U3Jhe8HXde1wh1Xl6/HNaxS6Mk0iwcPFJCKZBQV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752985494; c=relaxed/simple;
	bh=BAiS+5L1aoOna4clIV4XORs7TOaMn2H/5GNlaa5gSKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfUMI7pXrsXXv03RqpHacURVaWTHbc0agQ49LlHvFi2X5If+YxOeZUr83Xm4jIPxjyZiknqjQ5uCkGLW8tRq3sU6bp2srYNh0VFypvZfGTbOlZTIMYtOvMVd51bh8QEEep9Uifi8Mg9qzzeqDuqd/YYUQ+6Xekjmhnqo5ek5DDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hues/3N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3D1C4CEEB;
	Sun, 20 Jul 2025 04:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752985493;
	bh=BAiS+5L1aoOna4clIV4XORs7TOaMn2H/5GNlaa5gSKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hues/3N8LDK8NbIKKerIvu2ZL5XDm9nJMyJygi1KB2NFouDNZMVQGEIkYRkNrQzAV
	 OuPrtbiL7wm6lO3OxkfUsONFQLpXGvxLkhDW3SpCiufumcGmFORUzqsRiqNFLiRd48
	 kf1FvrBfAT1uD1eIPlg04rzyqsjsI5Kymv+VFbvj8advrAvTrdfJla/vVtHrBCIDrD
	 ORlpjWAhQ6dtW2flVHfGiiPCFI8Dj/Z7DAWyCJPEy//6NY7OtOd3d8LVaFbJ0E10Ol
	 vyYpm7EaqfjebHSdu3Xv+ZuAFt5/o1Av2LeEiW6WYPLKaDG0RU0a5PJa1nlFByj4qB
	 y6euF3y2iX0WQ==
Date: Sat, 19 Jul 2025 23:24:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/11] wifi: ath12k: Fix endianness handling in QMI
Message-ID: <a2sjvescdtdo75lpt6e7tnf7c46sj6g3mlakva5nzsa2p643w2@ie4scpc5vhv7>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
 <833ce5f1-51b2-4d4c-a839-38989ea10344@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833ce5f1-51b2-4d4c-a839-38989ea10344@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 08:13:20AM -0700, Jeff Johnson wrote:
> On 7/16/2025 12:50 AM, Alexander Wilhelm wrote:
> > Fix endianness handling in QMI firmware transfer on big-endian
> > platforms. Without this fix, the firmware download fails due to
> > misinterpreted data structures exchanged between the host and the
> > wireless module.
> > 
> > The issue occurs during early bring-up on big endian systems, where QMI
> > messages are not correctly parsed by the driver, leading to failed
> > initialization sequences. Ensure all relevant fields are properly
> > converted between CPU and little-endian format in request and response
> > messages, as expected by the firmware. Attached logs showing the failure
> > before the fix:
> > 
> >     ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
> >     ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
> >     ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
> >     ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
> >     ath12k_pci 0001:01:00.0: request MSI one vector
> >     ath12k_pci 0001:01:00.0: MSI vectors: 1
> >     ath12k_pci 0001:01:00.0: msi base data is 0
> >     ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
> >     ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
> >     ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
> >     ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
> >     ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
> >     ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
> >     ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
> >     ath12k_pci 0001:01:00.0: features
> >     ath12k_pci 0001:01:00.0: using fw api 2
> >     ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
> >     ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
> >     ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
> >     ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
> >     ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
> >     ath12k_pci 0001:01:00.0: irq:18 group:0
> >     ath12k_pci 0001:01:00.0: irq:18 group:1
> >     ath12k_pci 0001:01:00.0: irq:18 group:2
> >     ath12k_pci 0001:01:00.0: irq:18 group:3
> >     ath12k_pci 0001:01:00.0: irq:18 group:4
> >     ath12k_pci 0001:01:00.0: irq:18 group:5
> >     ath12k_pci 0001:01:00.0: irq:18 group:6
> >     ath12k_pci 0001:01:00.0: irq:18 group:7
> >     ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
> >     ath12k_pci 0001:01:00.0: cookie:0x0
> >     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
> >     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
> >     ath12k_pci 0001:01:00.0: soc reset cause:0
> >     ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
> >     ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
> >     ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
> >     ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
> >     ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
> >     ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
> >     ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
> >     ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
> >     ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
> >     ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap
> > 
> > Alexander Wilhelm (11):
> >   wifi: ath12k: fix endianness handling in QMI host capability request
> >   wifi: ath12k: fix endianness handling in QMI phy capability response
> >   wifi: ath12k: fix endianness handling in QMI firmware indication
> >   wifi: ath12k: fix endianness handling in QMI firmware memory indication
> >   wifi: ath12k: fix endianness handling in QMI respond firmware memory
> >   wifi: ath12k: fix endianness handling in QMI firmware capabilities
> >   wifi: ath12k: fix endianness handling in QMI bdf download
> >   wifi: ath12k: fix endianness handling in QMI firmware m3 info
> >   wifi: ath12k: fix endianness handling in QMI firmware wlan mode
> >   wifi: ath12k: fix endianness handling in QMI wlan configuration
> >   wifi: ath12k: fix endianness handling in QMI response
> > 
> >  drivers/net/wireless/ath/ath12k/qmi.c | 149 ++++++++++++++------------
> >  drivers/net/wireless/ath/ath12k/qmi.h | 106 +++++++++---------
> >  include/linux/soc/qcom/qmi.h          |   4 +-
> >  3 files changed, 136 insertions(+), 123 deletions(-)
> > 
> 
> Frankly I'm shocked that the low-level QMI encode/decode is not doing the
> endian conversion. Since the Qualcomm internal tool that generates the data
> structures has always generated structs with cpu endianess (i.e. u8, u16, u32,
> etc) I just assumed that endian conversion was handled at a low level.
> 

I'm suspecting that those tools, just like this implementation, is
exclusively tested on little endian machines...

> So should this issue be pushed down to the QMI encode/decode rather than foist
> it upon every client's read & write?
> 

It's been a while since I looked at the implementation, but conceptually
I'm in favor of this.

Regards,
Bjorn

> /jeff

