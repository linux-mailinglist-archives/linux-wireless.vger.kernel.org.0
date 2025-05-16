Return-Path: <linux-wireless+bounces-23040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B40AB9330
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67497A189A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474C4B1E47;
	Fri, 16 May 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kb+Gq6+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D808C611E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747355320; cv=none; b=KqWKZf6vtmsSeqwnGUvDItWlh/tuzVZ1t/v3u5gLazYjNHjwRPo8ZE9yNHpXP1VzE/C4ccRe6NZ6CJBrX+SoGq29kKULo3HqWUiah7VTFLPQIzFMkai7uixp6h1dfXdFrcp8DtptJHw1wQGiy4/FoIKXiAzIZEJjgzoGRQHl0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747355320; c=relaxed/simple;
	bh=wrFswCpRw3b3/tACeqUiwJNFhkcSIA1Se/h/9ZIj96Q=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=B7xZgpkN0YNQCJucwj6+8GoOKoDGR6xybDOcp9fFyzj0bT4mh+KKmW6+Nbt1CHyR6jdQZwrwfh6unpYWbtW2/TIdLJfZnXAgIITD2Qa2JbnNUtIqr/zMaRE2/TNOxVfoZy7l+sPe9ES6bjMKKBLZbfDGHLLgGQPM2XepWzE41Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kb+Gq6+u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0SVbdC033829, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747355311; bh=wrFswCpRw3b3/tACeqUiwJNFhkcSIA1Se/h/9ZIj96Q=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=kb+Gq6+uhv1Ux/horYrz3Vu7U0WFbMkW4tecrYR0TgFnK59sFM3f5NXk9eLgXbGtW
	 jMOY84bjSp2rN9ZrbW2bPz4lu2KQ4gozuX06oPUHYYJBcE4P14iq6/iMIqiQUfUGww
	 U/rD5O3GpUxUxQ/xon0Rk/Sp06chuKemdGRfuAX/Ral491RgcfFK8fD/c0lY2LVbtA
	 D+VH9jPq7BfKR2p6RPOWALHy/FR8vaNnzanqI8WyE6Ok92zggcyWpqSexQzR0oT6nZ
	 yJsg34d4+GbiI5cXJEdM26CxYzctYUdjhr6qdINjbCxQxWtrRSExiKtDl6Phxrjj//
	 zknYpw2u4ka2g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0SVbdC033829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:28:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:28:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:28:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: pci: configure manual DAC mode via PCI config API only
In-Reply-To: <20250506015356.7995-1-pkshih@realtek.com>
References: <20250506015356.7995-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a400148f-9d5b-4de4-ad2a-fec5356eed37@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:28:31 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To support 36-bit DMA, configure chip proprietary bit via PCI config API
> or chip DBI interface. However, the PCI device mmap isn't set yet and
> the DBI is also inaccessible via mmap, so only if the bit can be accessible
> via PCI config API, chip can support 36-bit DMA. Otherwise, fallback to
> 32-bit DMA.
> 
> With NULL mmap address, kernel throws trace:
> 
>   BUG: unable to handle page fault for address: 0000000000001090
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0002 [#1] PREEMPT SMP PTI
>   CPU: 1 UID: 0 PID: 71 Comm: irq/26-pciehp Tainted: G           OE      6.14.2-061402-generic #202504101348
>   Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   RIP: 0010:rtw89_pci_ops_write16+0x12/0x30 [rtw89_pci]
>   RSP: 0018:ffffb0ffc0acf9d8 EFLAGS: 00010206
>   RAX: ffffffffc158f9c0 RBX: ffff94865e702020 RCX: 0000000000000000
>   RDX: 0000000000000718 RSI: 0000000000001090 RDI: ffff94865e702020
>   RBP: ffffb0ffc0acf9d8 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000015
>   R13: 0000000000000719 R14: ffffb0ffc0acfa1f R15: ffffffffc1813060
>   FS:  0000000000000000(0000) GS:ffff9486f3480000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000001090 CR3: 0000000090440001 CR4: 00000000000626f0
>   Call Trace:
>    <TASK>
>    rtw89_pci_read_config_byte+0x6d/0x120 [rtw89_pci]
>    rtw89_pci_cfg_dac+0x5b/0xb0 [rtw89_pci]
>    rtw89_pci_probe+0xa96/0xbd0 [rtw89_pci]
>    ? __pfx___device_attach_driver+0x10/0x10
>    ? __pfx___device_attach_driver+0x10/0x10
>    local_pci_probe+0x47/0xa0
>    pci_call_probe+0x5d/0x190
>    pci_device_probe+0xa7/0x160
>    really_probe+0xf9/0x370
>    ? pm_runtime_barrier+0x55/0xa0
>    __driver_probe_device+0x8c/0x140
>    driver_probe_device+0x24/0xd0
>    __device_attach_driver+0xcd/0x170
>    bus_for_each_drv+0x99/0x100
>    __device_attach+0xb4/0x1d0
>    device_attach+0x10/0x20
>    pci_bus_add_device+0x59/0x90
>    pci_bus_add_devices+0x31/0x80
>    pciehp_configure_device+0xaa/0x170
>    pciehp_enable_slot+0xd6/0x240
>    pciehp_handle_presence_or_link_change+0xf1/0x180
>    pciehp_ist+0x162/0x1c0
>    irq_thread_fn+0x24/0x70
>    irq_thread+0xef/0x1c0
>    ? __pfx_irq_thread_fn+0x10/0x10
>    ? __pfx_irq_thread_dtor+0x10/0x10
>    ? __pfx_irq_thread+0x10/0x10
>    kthread+0xfc/0x230
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x47/0x70
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Fixes: 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/ccaf49b6-ff41-4917-90f1-f53cadaaa0da@gmail.com/T/#u
> Closes: https://github.com/openwrt/openwrt/issues/17025
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a70cf04b08f4 wifi: rtw89: pci: configure manual DAC mode via PCI config API only

---
https://github.com/pkshih/rtw.git


