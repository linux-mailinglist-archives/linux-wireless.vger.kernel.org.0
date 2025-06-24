Return-Path: <linux-wireless+bounces-24408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A82AE5D9A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57921B634A3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AC2522A2;
	Tue, 24 Jun 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cyNRVwuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA222505A9;
	Tue, 24 Jun 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749958; cv=none; b=HpZEl7668HLXIvnrH2BM+aPa2tzQCxDx5QTf5QNQDRHdYTL4fvIxwbKhVtlrEqoRN6VgWf+LKOdA9L5waqviqUkbw+B7MUpYoM06PzI6m+lLqb2kvUw+gTvHzpnAQcFe+vw/aK89+YwrVfiVJJ1Y3aDiNvk33jEgm+cCpPifURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749958; c=relaxed/simple;
	bh=Bz5Ii0zJE/ipZP4EElPEbkTnDBcsaTJ0zHf9gFoVsdo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ZtQll/04/L169qLfQQWGFmxOGXIi1vYYeIQaIqvEwVOpY/Aw1ENM2E4veDUxP8OvKDxQRCtF3VPU2DKPAguyOGD3EVwKk5lZZEgADaIKnW/MBh2guq1RJJ5ZWGhP9uHzWWYOTYQ/nfrQYMFlPR1xlLA6PKfanOWIH6AFtq1ULLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cyNRVwuN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O7PpfuE3226269, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750749951; bh=0PbM4X9eC5XjnZq9Hz1qoqvvcYIkuH5eCfqPQBYAm+s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=cyNRVwuN84R/GcEtfZsDdP3dtFuLu+9zzCGBRHUc7qzaMNvNcZOCiYqNvhZLotkYx
	 6Erynhlv6jB/KXpyzxmkaSnniXrUyLzQtAf8Y5s9BLQuRPj//46v89sDWBOG1xMkD/
	 G7VECfEZFKehIz8Bj/ttMwtETHjXdhA+lpKOcosp1cBSB5nENWLABEohd2NHeRFUzG
	 mablB9tppyDtjHtBDBx80TbVvYoI2jyEYkdO7cBHGaPh3+8ZDFdqXLUl8qHsraknzI
	 4OTVNtUbJGMyPxsUaLspwN7gzl+PjGOIi9Jmcsatj+y0tZ35qYk/snlvGorghGTChI
	 A0ea8XLT+Gz7A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O7PpfuE3226269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:25:51 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 15:26:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Jun
 2025 15:26:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Thomas Fourier <fourier.thomas@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
In-Reply-To: <20250616105631.444309-4-fourier.thomas@gmail.com>
References: <20250616105631.444309-4-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4029900f-164c-4acd-8bd1-86ae43ccca60@RTEXDAG02.realtek.com.tw>
Date: Tue, 24 Jun 2025 15:26:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Thomas Fourier <fourier.thomas@gmail.com> wrote:

> The function `_rtl_pci_init_one_rxdesc()` can fail even when the new
> `skb` is passed because of a DMA mapping error.  If it fails, the `skb`
> is not saved in the rx ringbuffer and thus lost.
> 
> Compile tested only
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

44c0e191004f wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.

---
https://github.com/pkshih/rtw.git


