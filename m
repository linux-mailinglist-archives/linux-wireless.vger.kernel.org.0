Return-Path: <linux-wireless+bounces-29069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DABC67074
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C45822414D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14392F1FD2;
	Tue, 18 Nov 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O3bpxUv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A585464D;
	Tue, 18 Nov 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433151; cv=none; b=GAvfduGyGQNifD43zZVI/hGZSuyX8y48ske1QDAcD3binN5GbkkY0ooINFgf/CGCkPjyFWvetyrjuS3AIxrimEkMszPZxK+YVEOkRiLpUHH/tuROJt6R73WTv7hB/dUJmVk5i+gY2wtCuwdE0zYjVyOlatyclvzVr7Wt+XHfPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433151; c=relaxed/simple;
	bh=vHiCSjlfP9eCTFRWOJdzuuYGUVThcwt8WvdvJqDjauE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=bjpqDWKEKNuV6f70LxMGAjQi8KwPQq1R+9bD14BbcJembwcH5lvWQhbHkIIPGxnpNo7ZIbQ9hjxo4EOi6WthZ6s3HPVnv+xL4avu8CI5xntb2m2DKMO149OXRj0y5/Iai/MIfy9UxhKTUcJ5GpOtmKYaLtkkoR5VRBulEgs0FNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O3bpxUv5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2WOM20647615, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763433144; bh=xyzebF3GH/Anv/p/d2o0IbpFR7eG6djc9oaNxumHa/A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=O3bpxUv5MwJuMqlqJwno7HpD34l19qODk1TgTLMBYk9CVuzB7T/DBawwqgNFibG71
	 ZEPJeFCL1HFUMhM0ELcDIgWyO5A70sFvMYZQ1T4+pwVkFTWy1oCXnx/MS1lBduk4iY
	 Bc9hhs0twE1tlBUmQLSdN9QGayNJIhFFyl1tWBglSSxSq/KVNlV7RVOuBsgFXFAfZa
	 fuQKObaAQM6eFmdfF8xvFBbtwdDCJ7/d5AOKHcFXEY5hC4Ji+0LEFpYmOXpf3cxzPp
	 ntES9nrI7mdhzy0YcB4l4LIfQxQuG2r1n8cBZ/UqLHNydvMAkiq3xZCIX2j+IoUaa5
	 lg3urIwEZ5AYw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2WOM20647615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:32:24 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:32:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:32:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 18 Nov 2025 10:32:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, Ping-Ke Shih <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
CC: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtl818x_pci: Fix potential memory leaks in rtl8180_init_rx_ring()
In-Reply-To: <20251114094527.79842-1-nihaal@cse.iitm.ac.in>
References: <20251114094527.79842-1-nihaal@cse.iitm.ac.in>
Message-ID: <fbfa6fa1-0a07-4be6-8b3f-b9caa27e892f@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 18 Nov 2025 10:32:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:

> In rtl8180_init_rx_ring(), memory is allocated for skb packets and DMA
> allocations in a loop. When an allocation fails, the previously
> successful allocations are not freed on exit.
> 
> Fix that by jumping to err_free_rings label on error, which calls
> rtl8180_free_rx_ring() to free the allocations. Remove the free of
> rx_ring in rtl8180_init_rx_ring() error path, and set the freed
> priv->rx_buf entry to null, to avoid double free.
> 
> Fixes: f653211197f3 ("Add rtl8180 wireless driver")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9b5b9c042b30 wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()

---
https://github.com/pkshih/rtw.git


