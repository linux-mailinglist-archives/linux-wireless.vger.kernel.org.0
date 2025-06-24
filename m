Return-Path: <linux-wireless+bounces-24409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F8AE5DDA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6167A1E53
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B942561C5;
	Tue, 24 Jun 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pxcT+AjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B3252906;
	Tue, 24 Jun 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750465; cv=none; b=QsAHx9K2u2CC4ZMygGzazil1T/jjWi/o0740bIDc4YXWV7C+OVDlbCD/oIYepXjo8Ht0FfCxG4fnED96YoT0pL14nh3rAw4NKK4bPHTpPOwdw1M8ojbbUFe9+3vck2BPzIaI34v9js0jnULA4vDFln/V4zvNpNqWvmhbRN7iQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750465; c=relaxed/simple;
	bh=4L4p8mzQIrawtPvkgMyDPHn1DG4pqUKquaAb1QnlhgU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=PtcLUkvlsaeWHli6FHiKPfgWDVE5h7+uj9lMd0nwsxgH3mHtmYusf4Y+UDzUUEKHdOwvITHjYOtogkdU/3K8d8FzgXN7yzGmIo8KqtwMTDYqLBJawBD7N0zGIG0wxWFHc7errkVcVDne5ZslakxuH5hZHmNw/e+BJhpQ7vZF2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pxcT+AjY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O7X4Qp83232313, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750750385; bh=+E+259xMEjdlVbAqk5TSc75UapVAIhlftohVhdBf7Hw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=pxcT+AjYRzNsJxtH/yCu7DK16gT7BoQXfkbldezyvQBXBdrsgtB1qXtGoVWYAUpJw
	 FWgUUQwFDd9m8stUZG7tQfN9nX/VCvB3BUaaHQiLu17i9tjGJxO5J7Pquu2OhrVxFX
	 bsRWECyw3Y/RXbVqT2lOcJ9KC/ctn4CikLNdAVrHp2AfemKnaO3AMoC6fp41CVj9+Y
	 MyDPg8MIJcpMtCsaFEcY+KA6l6IHGmnGNF23lrH8h/1ZnCozOp/is1XvlBtHGfQpwM
	 x5jJsoCf88BY1q+TOK73fkbaHBgxv1LB91LpgAfpAaLmYpyGp4PAPhnXLOAqPCqXfJ
	 M7fuOIIVyWMrQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O7X4Qp83232313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:33:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 15:33:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Jun
 2025 15:33:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Hin-Tak Leung <hintak.leung@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "John W. Linville"
	<linville@tuxdriver.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: Re: [PATCH v2] rtl818x: Kill URBs before clearing tx status queue
In-Reply-To: <20250617135634.21760-1-d.dulov@aladdin.ru>
References: <20250617135634.21760-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <08206e08-f59f-4819-91c1-14e871fde06f@RTEXDAG02.realtek.com.tw>
Date: Tue, 24 Jun 2025 15:33:17 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Daniil Dulov <d.dulov@aladdin.ru> wrote:

> In rtl8187_stop() move the call of usb_kill_anchored_urbs() before clearing
> b_tx_status.queue. This change prevents callbacks from using already freed
> skb due to anchor was not killed before freeing such skb.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000080
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(voluntary)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>  RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
>  Call Trace:
>   <IRQ>
>   rtl8187_tx_cb+0x116/0x150 [rtl8187]
>   __usb_hcd_giveback_urb+0x9d/0x120
>   usb_giveback_urb_bh+0xbb/0x140
>   process_one_work+0x19b/0x3c0
>   bh_worker+0x1a7/0x210
>   tasklet_action+0x10/0x30
>   handle_softirqs+0xf0/0x340
>   __irq_exit_rcu+0xcd/0xf0
>   common_interrupt+0x85/0xa0
>   </IRQ>
> 
> Tested on RTL8187BvE device.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

16d8fd74dbfc wifi: rtl818x: Kill URBs before clearing tx status queue

---
https://github.com/pkshih/rtw.git


