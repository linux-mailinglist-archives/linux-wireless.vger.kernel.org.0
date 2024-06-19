Return-Path: <linux-wireless+bounces-9235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61990E52C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 10:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A5F284DC2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA178286;
	Wed, 19 Jun 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVykuycm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263177F12;
	Wed, 19 Jun 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784332; cv=none; b=UmwsCs4pZscqGQjpFtHE8B4KpvLuBm2CGZuo7lBgXaoahR8OIRvw+cDtlTKCjfUUT+j6Y0/bxPw64sWI160NYrN5a54G25Ot4rIKMq3SVGb2tzycA4Q2Lu0jmpb6ADaFXBlEe2s5fh1p55/bJfYFW/JyjZDWjWKTQd9a8lzhz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784332; c=relaxed/simple;
	bh=Pozoj6qv+Vp/UO1RPeTwW2rV8ca42eOTPcUD5Xy7Ftc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oKY3EJ8aCRV75BZPStqInFhS3aUvcVcJFpgH9PDCcf5vQdzNk40r2Xwe2i0cz8FbjKQBSD9rtKYhmKZ2VjgaHQhWZcvFwhcy34NmA+pxq8ASIz/kmctxIhtUATNSoVRuogO5mTWKJ60nE2IHp50io4aTHeiVbxxx3v7hpxD6jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVykuycm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F29BC2BBFC;
	Wed, 19 Jun 2024 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718784331;
	bh=Pozoj6qv+Vp/UO1RPeTwW2rV8ca42eOTPcUD5Xy7Ftc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pVykuycmWT5HhGPmaV1bKKbl7B2dqSeLGH9rL0PVXfuzzsP3HUGQsfeX4/+wt8B+8
	 hfCApwdGmMOaGOIazqnroYpWJl4O9Ssgx8jd5u4p+mD2KYBjjkkKO26f1fYlf/Qth3
	 NY6QEGPEJCaTPt+Bw5DENkv82Mo/cQP/7kli+Wxme926v2YTZZMvsdm9tkYng8pkm3
	 OIfHlui+gVUj/jYvW38sHNJB7dj0l5JNz7FHHkzoZh7fsHt8bTmKO0L581ZqKzVL0u
	 tC3AoNLzzXaGoXSMYiSpDaO0ndGwsYfOLH6iH0xSDEEPZXembleEeHCoDybXZJJlf5
	 nFundW6NoEeaw==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  David
 Lin <yu-hao.lin@nxp.com>,  Francesco Dolcini <francesco@dolcini.it>,
  Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
Date: Wed, 19 Jun 2024 11:05:28 +0300
In-Reply-To: <20240619070824.537856-1-s.hauer@pengutronix.de> (Sascha Hauer's
	message of "Wed, 19 Jun 2024 09:08:24 +0200")
Message-ID: <87wmmll5mf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> When an Access Point is repeatedly started it happens that the
> interrupts handler is called with priv->wdev.wiphy being NULL, but
> dereferenced in mwifiex_parse_single_response_buf() resulting in:
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
> | Modules linked in: caam_jr caamhash_desc spidev caamalg_desc crypto_engine authenc libdes mwifiex_sdio mwifiex crct10dif_ce cdc_acm onboard_usb_hub fsl_imx8_ddr_perf imx8m_ddrc rtc_ds1307 lm75 rtc_snvs imx_sdma caam imx8mm_thermal spi_imx error imx_cpufreq_dt fuse ip_tables x_tables ipv6
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
> Fix this by adding a NULL check before dereferencing this pointer.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> ---
>
> This is the most obvious fix for this problem, but I am not sure if we
> might want to catch priv->wdev.wiphy being NULL earlier in the call
> chain.

I haven't looked at the call but the symptoms sound like that either we
are enabling the interrupts too early or there's some kind of locking
problem so that an other cpu doesn't see the change.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

