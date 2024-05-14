Return-Path: <linux-wireless+bounces-7658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E48C5DB0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 00:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44FE1C20A48
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E093181D1F;
	Tue, 14 May 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="o1i/63AH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88410181D08;
	Tue, 14 May 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726642; cv=none; b=rOsckaiVLm7uMGkkwiljiex1DTstRzTQoyaH75cNbI3N1zSYBF7l2qELTuxT59cNMDq0pwVTXr96j7WuaNQaQCz0cUBzGvc8EETCvQijnKkJxL5WAfi/xtq/1xp+hNnXtAPeJLja05HvWdJ+5l9N95WbPXZDffn3FKeoI/1MGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726642; c=relaxed/simple;
	bh=38tNxLFx1OxlRM50Jm+1WZds6yWs3DvO0jLgDD/xZpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RkdeGzt9nObXzWakxTdSPM5D0gyEcXHme3f2YDX3JOVaH8KLR0qpYxOUJrUqRX0UKrBVVQrKOoxCNMpP6nprPLfRnN0vkESZRhWQTSQbyW3r0emH6PsYaOnJ+g4FlvYJVaz4TEIWH/ozbGuFJ7wQaO3q0xCudMXtpnxazw/hhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=o1i/63AH; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id CA43E6356CD1;
	Wed, 15 May 2024 00:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715726632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ymcQ45iu4hDaEHeH8btPmGyWeGOf494Z6bYBFnE1uQs=;
	b=o1i/63AH2YTXKLymJMF6Q/zPc71meESNMccl5+/RBSrzv0N5TQJpkDPPz9chEh18whhV43
	rIYJJawBbHrn+/VHzj0XYWPgt2G5OTcZ0AAj4zXhjxMk2io6dbESmQduunJtauVOUmPvYS
	BeICQKyTriIogps3Gp5RYa0ahRW2DW4=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 00:43:40 +0200
Message-ID: <6061263.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4936095.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4936095.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 00:43:40 +0200
Message-ID: <6061263.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0

Hello Felix, Lorenzo et al.

With v6.9 kernel the following card:

01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless Network Adapter [14c3:7915]

doesn't work any more. Upon mt7915e module insertion the following splat happens:

mt7915e 0000:01:00.0: enabling device (0000 -> 0002)
WARNING: CPU: 3 PID: 1648 at net/mac80211/main.c:794 ieee80211_alloc_hw_nm+0x9a3/0x9f0 [mac80211]
Call Trace:
 <TASK>
 mt76_alloc_device+0x24/0x290 [mt76 46e2c4f11be089903469a4d6045c71cb7842b4cd]
 mt7915_mmio_probe+0x33/0x1d0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
 mt7915_pci_probe+0xe1/0x3a0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
 pci_device_probe+0xf0/0x2d0
 really_probe+0xde/0x3b0
 __driver_probe_device+0x78/0x110
 driver_probe_device+0x1f/0x130
 __driver_attach+0x91/0x1e0
 bus_for_each_dev+0x105/0x160
 bus_add_driver+0x137/0x270
 driver_register+0x72/0xd0
 mt7915_init+0x44/0xff0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
 do_one_initcall+0x5b/0x310
 do_init_module+0x60/0x220
 init_module_from_file+0x89/0xe0
 idempotent_init_module+0x121/0x2b0
 __x64_sys_finit_module+0x5e/0xb0
 do_syscall_64+0x82/0x160
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
mt7915e 0000:01:00.0: probe with driver mt7915e failed with error -12

and the card stays non-functional. Re-inserting the module triggers the same behaviour.

The following condition is triggered:

 794                 if (WARN_ON(!ops->add_chanctx ||
 795                             !ops->remove_chanctx ||
 796                             !ops->change_chanctx ||
 797                             !ops->assign_vif_chanctx ||
 798                             !ops->unassign_vif_chanctx))
 799                         return NULL;

This worked with v6.8 and earlier just fine.

Please help.

Thank you.

-- 
Oleksandr Natalenko (post-factum)
--nextPart4936095.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmZD6RwACgkQil/iNcg8
M0t51w/8D3g7txAegNSZpXa63mdTbT+c29E+FV+JlJt/8IT9PXn5f5kRQbJ0JAEz
lbzLs5P7MP9zjlmeuugOjE0fya0bHpZ4RcPrlCG6/55mxFiIDTE4qMa6fxWGZych
U6uhme7uymB/Gw46VTkH8U+ybMYXj/hHc+lWVLmu8vy0NAuio4pShlq4bLtKR5qb
NtrbVhviTvSSpKvUMwYVDjHLcfjmRbaw2HWYINI6DUpEFxoR7QPmIxxjs7tW5cyS
OPGNm/JRltUBn6q+VGj8ksnEclmQK9dzCziCd1yIt2g0n8QCRPuv9heJV7dWC+N6
QVTRBsHlh+K+ZAnMCZVr6YYT9UhHOjkKs/2S6LkyH+xcTP7yGzspS5A4nxztgeYQ
n4YvEmZco3gsTsBEH3jzl+jYZ9knLbHUUSiG5FtpJdWaHON5+h+nXUfrAm9rQOcl
Is8YZuXK4BtpraLkvGW8aiKCTX637Q8q57kDI47ocaqQmRpgKGy67HEHQjcNvz2H
6BKvPwXObs/Zea8XtN5LgAGE58p1JKQZ+KgYNKQl0lD8QVGu0HpmPOeHG55MLyPN
MvU1iNzp7NHyMo5CMrXPcFgXp4CeFyv3cFO7L1/LCd5cAgRIlsEp6y9vbzLeUrBW
htLUVU2YrSv7AzrKg0Z+R73yT1kTNfnQYTxCcKDEKR37qmoS1rk=
=8/WF
-----END PGP SIGNATURE-----

--nextPart4936095.31r3eYUQgx--




