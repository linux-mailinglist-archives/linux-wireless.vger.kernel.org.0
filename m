Return-Path: <linux-wireless+bounces-30116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA860CDE5A2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC0630084C0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 05:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49FF19309C;
	Fri, 26 Dec 2025 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hiZFZYRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC312D1F1
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766727242; cv=none; b=gukvCe6ka9NpfoBKomCXEmiH6uOXlqo8dCpNL0hzqqU5IpiTEdi/37FBnL6F2BuuNP2Hg3OJ/YEGjN3NXFOttfGcSNIhEDiMUkKj3TJdnFqYt0wTtS4F1tIByj7bxv5YZ1oXlt7Xy/C5otP8mKzjHgzJbP9itDYcIQ12nMsxIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766727242; c=relaxed/simple;
	bh=khl5I4r8K5rdrG1OsDwJL8s0ztRiaQZDTm48d8DlirI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=BPZrK3iAqo+PonCIQ54ZrdR0IIsE0w5SH4XMCSZLOUGKeIjVuKH6iirpbzMTF8iuFWoR0HNZTyvHq8o0RK7yH2RWieQSYUCANjVhnBSAsUMWx06FyangGH3CRLU4Tl04iC6ueATRTUM6VviUWKBKEW1D7MfGuFYwUpC8eTV4oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hiZFZYRv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ5XuoF63038006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766727236; bh=6CjcK7rqgaQ2W+mYpH+S+Ot7INi6EbDZsDdBut5RAhg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=hiZFZYRvBTwIo9dW0aJWwbhP21Z3jADjwCz8EbDAoye164pWTJK87t7s5VYSNxjas
	 8/yPAi8WnYpc4NYjZekwOCgIroUdtKGDx/5cZHdSnoGb68bgdCJZc2NLBAnwcH0OpY
	 qux1w9zahbyHi5Nn7iDg7bh46Zf8od8tgnPaaZ6R3mfhDYRqZmq2iDo5DyKsHgdAaU
	 63vjT0IHUSgHgIR4pr/h0Wk6A2iSAkb+QuYX6+CPxndqRxbcHfsOnhysLJ9S333npd
	 k01ZX11r7Zkk8HXAl1meDWm4wflucAVguz6XE9njLREc+ynaAr6PKEhzlvKSTy8OvX
	 CBmVWMTHB7niw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ5XuoF63038006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 13:33:56 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 13:33:56 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 13:33:55 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 13:33:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next 1/3] wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()
In-Reply-To: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Message-ID: <1bf00e0e-de53-449f-a17a-a9df4fc85c41@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 26 Dec 2025 13:33:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtw_core_enable_beacon() reads 4 bytes from an address that is not a
> multiple of 4. This results in a crash on some systems.
> 
> Do 1 byte reads/writes instead.
> 
> Unable to handle kernel paging request at virtual address ffff8000827e0522
> Mem abort info:
>   ESR = 0x0000000096000021
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> Data abort info:
>   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000005492000
> [ffff8000827e0522] pgd=0000000000000000, p4d=10000001021d9403, pud=10000001021da403, pmd=100000011061c403, pte=00780000f3200f13
> Internal error: Oops: 0000000096000021 [#1]  SMP
> Modules linked in: [...] rtw88_8822ce rtw88_8822c rtw88_pci rtw88_core [...]
> CPU: 0 UID: 0 PID: 73 Comm: kworker/u32:2 Tainted: G        W           6.17.9 #1-NixOS VOLUNTARY
> Tainted: [W]=WARN
> Hardware name: FriendlyElec NanoPC-T6 LTS (DT)
> Workqueue: phy0 rtw_c2h_work [rtw88_core]
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : rtw_pci_read32+0x18/0x40 [rtw88_pci]
> lr : rtw_core_enable_beacon+0xe0/0x148 [rtw88_core]
> sp : ffff800080cc3ca0
> x29: ffff800080cc3ca0 x28: ffff0001031fc240 x27: ffff000102100828
> x26: ffffd2cb7c9b4088 x25: ffff0001031fc2c0 x24: ffff000112fdef00
> x23: ffff000112fdef18 x22: ffff000111c29970 x21: 0000000000000001
> x20: 0000000000000001 x19: ffff000111c22040 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffd2cb6507c090
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000007f10 x1 : 0000000000000522 x0 : ffff8000827e0522
> Call trace:
>  rtw_pci_read32+0x18/0x40 [rtw88_pci] (P)
>  rtw_hw_scan_chan_switch+0x124/0x1a8 [rtw88_core]
>  rtw_fw_c2h_cmd_handle+0x254/0x290 [rtw88_core]
>  rtw_c2h_work+0x50/0x98 [rtw88_core]
>  process_one_work+0x178/0x3f8
>  worker_thread+0x208/0x418
>  kthread+0x120/0x220
>  ret_from_fork+0x10/0x20
> Code: d28fe202 8b020000 f9524400 8b214000 (b9400000)
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: ad6741b1e044 ("wifi: rtw88: Stop high queue during scan")
> Cc: stable@vger.kernel.org
> Closes: https://github.com/lwfinger/rtw88/issues/418
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

0177aa828d96 wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()
2ba12401cc1f wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()
fcac0f23d4d2 wifi: rtw88: Fix inadvertent sharing of struct ieee80211_supported_band data

---
https://github.com/pkshih/rtw.git


