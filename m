Return-Path: <linux-wireless+bounces-30838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50148D220B3
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 02:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B81E3019953
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 01:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575907260A;
	Thu, 15 Jan 2026 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cYkOnUhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339972629D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441149; cv=none; b=tVBt68kxtSwMvvyhM2v/8lObTvkCvweIkm0Q3UbKqqIeX2bbK3qeUM7y14aZwIUzqc6YmPdPlb834/MlVdAElSRjF9EK0hyoLstq92CYinI7SWvTZBiiuAOOLoIXMncXNoQyQp1RNHaR+WXwVObzaGF/9H1GngTgvcJ5Lp8DbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441149; c=relaxed/simple;
	bh=zfT2CIANEKRSRGGV9c0KzMLDPa3G/h28yTWtNaEOhfM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=EY9ktTBBpr+p2FU7gPyrGcwrF0so0kHTZiLdTZT6JcgWANNKWH/Bx0ohDaHI8Rm3AGuzllqmwZkMcu0CPY5Gc+jtk4+C4jGd+Dpb2VcOAYtYNyCR/Hejk1xcrec/0wkrGSkeEUzQJO8FnDp8GciX20eGVm0YXQ//nFI0OOF6Vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cYkOnUhf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60F1d4qB52088093, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768441144; bh=pAjqqNxfvT87eenZCubDfqq0ygyUQnZLXwgP8nAOIGU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=cYkOnUhfju4G8yOIfrb/ukFg0Zam4zgX4WLReEuE4jJhePjfXbham8pAOu9mrJXZm
	 sj6O3Ovv4X1ituUir7fSllHC8FafUBG9YjVdXzDPg12vnbpZDmTnoqtQiwgZYuyrgC
	 3s66qqy0lAv03SZzVhtX2ZNSxk1OY0mN/UDKHJlzbQAHKeIdJ4W9bvPLl0HncSkhhg
	 8Vvlkoixl/1C2oLmJY84rpHgOirhrznBIqVk/6BOpgEmfmv7Jq9p9OEfkO0csIEwl7
	 kd0R/Nfjk9dA0EZVfZEPN1Qpf8OtRPFmgQ9vPOZwyKnXTMPdwzvqKkSctJ4MeENOqc
	 zujlqPiNLSJFg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60F1d4qB52088093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 09:39:04 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 15 Jan 2026 09:39:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Jan 2026 09:39:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/8] wifi: rtw89: pci: validate sequence number of TX release report
In-Reply-To: <20260110022019.2254969-2-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com> <20260110022019.2254969-2-pkshih@realtek.com>
Message-ID: <6301a6df-92cf-4670-981e-4d96b9fde610@RTKEXHMBS04.realtek.com.tw>
Date: Thu, 15 Jan 2026 09:39:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hardware rarely reports abnormal sequence number in TX release report,
> which will access out-of-bounds of wd_ring->pages array, causing NULL
> pointer dereference.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 1085 Comm: irq/129-rtw89_p Tainted: G S   U
>              6.1.145-17510-g2f3369c91536 #1 (HASH:69e8 1)
>   Call Trace:
>    <IRQ>
>    rtw89_pci_release_tx+0x18f/0x300 [rtw89_pci (HASH:4c83 2)]
>    rtw89_pci_napi_poll+0xc2/0x190 [rtw89_pci (HASH:4c83 2)]
>    net_rx_action+0xfc/0x460 net/core/dev.c:6578 net/core/dev.c:6645 net/core/dev.c:6759
>    handle_softirqs+0xbe/0x290 kernel/softirq.c:601
>    ? rtw89_pci_interrupt_threadfn+0xc5/0x350 [rtw89_pci (HASH:4c83 2)]
>    __local_bh_enable_ip+0xeb/0x120 kernel/softirq.c:499 kernel/softirq.c:423
>    </IRQ>
>    <TASK>
>    rtw89_pci_interrupt_threadfn+0xf8/0x350 [rtw89_pci (HASH:4c83 2)]
>    ? irq_thread+0xa7/0x340 kernel/irq/manage.c:0
>    irq_thread+0x177/0x340 kernel/irq/manage.c:1205 kernel/irq/manage.c:1314
>    ? thaw_kernel_threads+0xb0/0xb0 kernel/irq/manage.c:1202
>    ? irq_forced_thread_fn+0x80/0x80 kernel/irq/manage.c:1220
>    kthread+0xea/0x110 kernel/kthread.c:376
>    ? synchronize_irq+0x1a0/0x1a0 kernel/irq/manage.c:1287
>    ? kthread_associate_blkcg+0x80/0x80 kernel/kthread.c:331
>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>    </TASK>
> 
> To prevent crash, validate rpp_info.seq before using.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

957eda596c76 wifi: rtw89: pci: validate sequence number of TX release report
2fd8f953f251 wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode
432b26382db2 wifi: rtw89: support EHT GI/LTF setting
7fd36ffedeed wifi: rtw89: disable EHT protocol by chip capabilities
91fb4007018f wifi: rtw89: align CUSTID defined by firmware
aa2a44d0d22d wifi: rtw89: mac: correct page number for CSI response
8e47ae078693 wifi: rtw89: mac: consider RTL8922D in MAC common flow
5e632c7ca9e1 wifi: rtw89: pci: consider RTL8922D in PCI common flow

---
https://github.com/pkshih/rtw.git


