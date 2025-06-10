Return-Path: <linux-wireless+bounces-23911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04918AD2B63
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF6616ECB0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC091A23B0;
	Tue, 10 Jun 2025 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="p7wKhhh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369013C8F3;
	Tue, 10 Jun 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519858; cv=none; b=RRCrAwD5j35qvWHzvU1XoaH/vz1J/ndA/zC/u3Iw9RECPA/MhXVZiWn+RFppph1nSN3U4+8X9CyPgMxHo1J286M//264TuenEQ71CNT/tvUyPb2pZY+VDSN2ng5AA0PZ6v+2Gpkiw/zv02cvNZ9z7QKMNHqNBRNa9KUZG6G09Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519858; c=relaxed/simple;
	bh=pm8/8N9Vdv2JBzd0qFkGhXl2nqXqVPnPmFLAAluRwGs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cr1lXDV0z9ki9hlxWozntC6AHRqYH21EZ79vBFMv/U9mCJQW5ISUl7Wuj+z7XX9/uyGYvGjj8IOIvjupNAfn6P+lxpS6ym6X20icZqXHL9mVSotWr2SSa6sc2q9ZDbSCyKKem4tyWe85A5b0SQfidN3JOsg7qbv4OGn0B07cqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=p7wKhhh7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1i2D412064739, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749519842; bh=1apaVgw7L9r/islcGDUI9apKSuqsPpVxtOvbvuRqLLE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=p7wKhhh7JOlFcJshUW8QB0VxAuwDCvtUwVM2uHG8WCFbpbQV9CR21cfopMYMUVZKJ
	 IQTI2tvX9WsWk/lrxktIbMFZnaTAZeEiMG5xK2hd7dcl/dQs/9MqTVPbAfocAPCmfh
	 v/65+XCHCAlWNvkhHokUUxYaj+LdmplObyHRzzHXHdIE/bO9/Ub+4qWTgz/DiseycK
	 UKVMLjkj+4pqqgltxvB8HVm4msnAsgXqx0Om1Up04VQFRZdkQ91tSIWExvMVG/knlB
	 ZrtYojz0pBtllzzm6i7+AyGpbflsB9AvU1nl0BhbBzYmo80Tk45+qHauaBa7McgnW/
	 EaaIjTQc8tF9Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1i2D412064739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 09:44:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:44:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:44:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
In-Reply-To: <20250604161339.119954-1-pchelkin@ispras.ru>
References: <20250604161339.119954-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <59764dcc-eb0a-41af-880f-e7b41c15ec0a@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:44:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> The following assertion is triggered on the rtw89 driver startup. It
> looks meaningless to hold wiphy lock on the early init stage so drop the
> assertion.
> 
>  WARNING: CPU: 7 PID: 629 at drivers/net/wireless/realtek/rtw89/sar.c:502 rtw89_set_sar_from_acpi+0x365/0x4d0 [rtw89_core]
>  CPU: 7 UID: 0 PID: 629 Comm: (udev-worker) Not tainted 6.15.0+ #29 PREEMPT(lazy)
>  Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
>  RIP: 0010:rtw89_set_sar_from_acpi+0x365/0x4d0 [rtw89_core]
>  Call Trace:
>   <TASK>
>   rtw89_sar_init+0x68/0x2c0 [rtw89_core]
>   rtw89_core_init+0x188e/0x1e50 [rtw89_core]
>   rtw89_pci_probe+0x530/0xb50 [rtw89_pci]
>   local_pci_probe+0xd9/0x190
>   pci_call_probe+0x183/0x540
>   pci_device_probe+0x171/0x2c0
>   really_probe+0x1e1/0x890
>   __driver_probe_device+0x18c/0x390
>   driver_probe_device+0x4a/0x120
>   __driver_attach+0x1a0/0x530
>   bus_for_each_dev+0x10b/0x190
>   bus_add_driver+0x2eb/0x540
>   driver_register+0x1a3/0x3a0
>   do_one_initcall+0xd5/0x450
>   do_init_module+0x2cc/0x8f0
>   init_module_from_file+0xe1/0x150
>   idempotent_init_module+0x226/0x760
>   __x64_sys_finit_module+0xcd/0x150
>   do_syscall_64+0x94/0x380
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 88ca3107d2ce ("wifi: rtw89: sar: add skeleton for SAR configuration via ACPI")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

6fe21445f7e8 wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
dad7aafa5216 wifi: rtw89: sar: do not assert wiphy lock held until probing is done

---
https://github.com/pkshih/rtw.git


