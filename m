Return-Path: <linux-wireless+bounces-10117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9792B4F0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E43D281A28
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FB13DB92;
	Tue,  9 Jul 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlNbXPs2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5C38FA5;
	Tue,  9 Jul 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520113; cv=none; b=TM5aNLBqUku47RO1QPNUrNw3NKNa5eJicOtPkFGddmRAdvqnrxpA41BXXOLrpofDsoCWGRut1BcrkSaKtwcSXuQ20wYfhFQ6Btl8/RP6taiSRkAOLEKkkJK1m1RSGSqqFU8alFpd/ENRIl8u9qVay8TDdOq8HJmhgV+rD/CXM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520113; c=relaxed/simple;
	bh=tKueqsxqE+0OrUIuFqh4Rl4FDN8EBWKmezJndP6hr30=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ignyPmve+3iRU3Jwu71o48tuetcHcpnRA56Yere/9fwCT2y1Lah7FOdm4GSF4Er0xFrZuywqBcSGLYdeigYNeO21sHM9MqG+CTcbCYPqBwUhXfBUK3UO8Wq0soW07lCM7QU7bAuK9zmPnTfDp8rAQ3GVHonuWJg8TdwEsgA3HTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlNbXPs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D7DC3277B;
	Tue,  9 Jul 2024 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720520113;
	bh=tKueqsxqE+0OrUIuFqh4Rl4FDN8EBWKmezJndP6hr30=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rlNbXPs2nEIFRDCoEcpY9/SHyt6VBtndqvip3jyIXEn/08GS7M2ta7QI0m4k6hDl1
	 7Mznz/YtMGNbx0mlYUqU+1L0mNFB13LK66Y7YfFygOefTOlBAuJZ2dJdQ7GQidTMXn
	 StqVQMherfjSEpZ0iKv+B98XgGJgm16sMJJXINamvDnlkS+uJI9h+psMobPeQ3G8vL
	 54/lHUSJQpEYIBW1qpHBffdoz5F51m8h4eVXSFVzoErUrvwAcBTKkDcVGn47w8RAKu
	 vvShMwiaSAhZH0iC096ueb+yaqKPh12sGxtZtiMGUJU+k581qOU3TuTU0JtdJyHoec
	 0MuugLI+V0Cww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: Do not return unused priv in
 mwifiex_get_priv_by_id()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240703072409.556618-1-s.hauer@pengutronix.de>
References: <20240703072409.556618-1-s.hauer@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lin <yu-hao.lin@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 Brian Norris <briannorris@chromium.org>, kernel@pengutronix.de,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172052010908.761847.2107697007150958943.kvalo@kernel.org>
Date: Tue,  9 Jul 2024 10:15:10 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> mwifiex_get_priv_by_id() returns the priv pointer corresponding to
> the bss_num and bss_type, but without checking if the priv is actually
> currently in use.
> Unused priv pointers do not have a wiphy attached to them which can
> lead to NULL pointer dereferences further down the callstack.  Fix
> this by returning only used priv pointers which have priv->bss_mode
> set to something else than NL80211_IFTYPE_UNSPECIFIED.
> 
> Said NULL pointer dereference happened when an Accesspoint was started
> with wpa_supplicant -i mlan0 with this config:
> 
> network={
>         ssid="somessid"
>         mode=2
>         frequency=2412
>         key_mgmt=WPA-PSK WPA-PSK-SHA256
>         proto=RSN
>         group=CCMP
>         pairwise=CCMP
>         psk="12345678"
> }
> 
> When waiting for the AP to be established, interrupting wpa_supplicant
> with <ctrl-c> and starting it again this happens:
> 
> | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000140
> | Mem abort info:
> |   ESR = 0x0000000096000004
> |   EC = 0x25: DABT (current EL), IL = 32 bits
> |   SET = 0, FnV = 0
> |   EA = 0, S1PTW = 0
> |   FSC = 0x04: level 0 translation fault
> | Data abort info:
> |   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> |   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> | user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046d96000
> | [0000000000000140] pgd=0000000000000000, p4d=0000000000000000
> | Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> | Modules linked in: caam_jr caamhash_desc spidev caamalg_desc crypto_engine authenc libdes mwifiex_sdio
> +mwifiex crct10dif_ce cdc_acm onboard_usb_hub fsl_imx8_ddr_perf imx8m_ddrc rtc_ds1307 lm75 rtc_snvs
> +imx_sdma caam imx8mm_thermal spi_imx error imx_cpufreq_dt fuse ip_tables x_tables ipv6
> | CPU: 0 PID: 8 Comm: kworker/0:1 Not tainted 6.9.0-00007-g937242013fce-dirty #18
> | Hardware name: somemachine (DT)
> | Workqueue: events sdio_irq_work
> | pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> | lr : mwifiex_get_cfp+0x34/0x15c [mwifiex]
> | sp : ffff8000818b3a70
> | x29: ffff8000818b3a70 x28: ffff000006bfd8a5 x27: 0000000000000004
> | x26: 000000000000002c x25: 0000000000001511 x24: 0000000002e86bc9
> | x23: ffff000006bfd996 x22: 0000000000000004 x21: ffff000007bec000
> | x20: 000000000000002c x19: 0000000000000000 x18: 0000000000000000
> | x17: 000000040044ffff x16: 00500072b5503510 x15: ccc283740681e517
> | x14: 0201000101006d15 x13: 0000000002e8ff43 x12: 002c01000000ffb1
> | x11: 0100000000000000 x10: 02e8ff43002c0100 x9 : 0000ffb100100157
> | x8 : ffff000003d20000 x7 : 00000000000002f1 x6 : 00000000ffffe124
> | x5 : 0000000000000001 x4 : 0000000000000003 x3 : 0000000000000000
> | x2 : 0000000000000000 x1 : 0001000000011001 x0 : 0000000000000000
> | Call trace:
> |  mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> |  mwifiex_parse_single_response_buf+0x1d0/0x504 [mwifiex]
> |  mwifiex_handle_event_ext_scan_report+0x19c/0x2f8 [mwifiex]
> |  mwifiex_process_sta_event+0x298/0xf0c [mwifiex]
> |  mwifiex_process_event+0x110/0x238 [mwifiex]
> |  mwifiex_main_process+0x428/0xa44 [mwifiex]
> |  mwifiex_sdio_interrupt+0x64/0x12c [mwifiex_sdio]
> |  process_sdio_pending_irqs+0x64/0x1b8
> |  sdio_irq_work+0x4c/0x7c
> |  process_one_work+0x148/0x2a0
> |  worker_thread+0x2fc/0x40c
> |  kthread+0x110/0x114
> |  ret_from_fork+0x10/0x20
> | Code: a94153f3 a8c37bfd d50323bf d65f03c0 (f940a000)
> | ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Patch applied to wireless-next.git, thanks.

c145eea2f75f wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240703072409.556618-1-s.hauer@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


