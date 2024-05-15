Return-Path: <linux-wireless+bounces-7665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521E8C601B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471E1C22229
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2239ADD;
	Wed, 15 May 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2eiE7ru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FB36AF5;
	Wed, 15 May 2024 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750302; cv=none; b=teLw24kChxPOkDUgwHEnlibmH1Amf0IQM+CH3Wog5v/ZqfV5U6FwVzgCCV4u4yku7YZUOeFFVqvAjuZ651wh51lMmfDaNagZLS3yEhjIOyr5BTXoFXJq9oBRF6+al0nAeLLnk96HkZ33lRwY0+yQqqBgFnJLcpMfqmQ8fDf2wL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750302; c=relaxed/simple;
	bh=pfGH+jZh96pLnw4AOvxaMZ9eBTglQ+T1HiwE848Yk3E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Yb5/kZC1GEYPg3Lv4QNrRc2shmEhk/5IngfoNdjLEowQZhT8m7UArkT6R/IHtHH1Fl5mAOHJdBE6TnEncpwH4fcnO/mj77jmv0pmpR17kVsjrluiwRsTiPqqRz6GWFAV+f8mcaZ69iZtoZAQ7/szYuJpZKGyQwBE9mQMcs57LFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2eiE7ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC3C116B1;
	Wed, 15 May 2024 05:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715750301;
	bh=pfGH+jZh96pLnw4AOvxaMZ9eBTglQ+T1HiwE848Yk3E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V2eiE7ruo0tGAGMwLasu7rmCOrV00BqN3Zt98BuZfOuqBuyWInZt0/vKTst7Ib/ft
	 QnFFDt3al5+S1xF7UgnabhgchQsko+cMMErRtvGUbYmuKmfx8fCI9uqlMlur3cE0I0
	 H1nuno4m9bYoM2RUwqhmsGTLhgi6Nsok1S28dnfUKLeIahig+qACKWtuzAB1MVYeQE
	 px+ASAGpyJ/gCnLu2FNElh4NmdmWlGn85yOIRrVXNgly7Sie+7dIMLwSewx+Lk9ZgJ
	 92qBxuc6LX/bT1rW0IbrB2REq3c2SZiuLMBpaSavGVJ5E56Nb/pF4K1NnUvai41dUU
	 A2WWhovzEawbA==
From: Kalle Valo <kvalo@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
  linux-mediatek@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Felix Fietkau <nbd@nbd.name>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  Peter Chiu <chui-hao.chiu@mediatek.com>,  StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
References: <6061263.lOV4Wx5bFT@natalenko.name>
Date: Wed, 15 May 2024 08:18:16 +0300
In-Reply-To: <6061263.lOV4Wx5bFT@natalenko.name> (Oleksandr Natalenko's
	message of "Wed, 15 May 2024 00:43:40 +0200")
Message-ID: <87le4birfr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleksandr Natalenko <oleksandr@natalenko.name> writes:

> Hello Felix, Lorenzo et al.
>
> With v6.9 kernel the following card:
>
> 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax
> PCI Express Wireless Network Adapter [14c3:7915]
>
> doesn't work any more. Upon mt7915e module insertion the following splat happens:
>
> mt7915e 0000:01:00.0: enabling device (0000 -> 0002)
> WARNING: CPU: 3 PID: 1648 at net/mac80211/main.c:794
> ieee80211_alloc_hw_nm+0x9a3/0x9f0 [mac80211]
> Call Trace:
>  <TASK>
>  mt76_alloc_device+0x24/0x290 [mt76 46e2c4f11be089903469a4d6045c71cb7842b4cd]
>  mt7915_mmio_probe+0x33/0x1d0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
>  mt7915_pci_probe+0xe1/0x3a0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
>  pci_device_probe+0xf0/0x2d0
>  really_probe+0xde/0x3b0
>  __driver_probe_device+0x78/0x110
>  driver_probe_device+0x1f/0x130
>  __driver_attach+0x91/0x1e0
>  bus_for_each_dev+0x105/0x160
>  bus_add_driver+0x137/0x270
>  driver_register+0x72/0xd0
>  mt7915_init+0x44/0xff0 [mt7915e 9657e1926e619568545a08636674805d5e665c85]
>  do_one_initcall+0x5b/0x310
>  do_init_module+0x60/0x220
>  init_module_from_file+0x89/0xe0
>  idempotent_init_module+0x121/0x2b0
>  __x64_sys_finit_module+0x5e/0xb0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> mt7915e 0000:01:00.0: probe with driver mt7915e failed with error -12
>
> and the card stays non-functional. Re-inserting the module triggers
> the same behaviour.
>
> The following condition is triggered:
>
>  794                 if (WARN_ON(!ops->add_chanctx ||
>  795                             !ops->remove_chanctx ||
>  796                             !ops->change_chanctx ||
>  797                             !ops->assign_vif_chanctx ||
>  798                             !ops->unassign_vif_chanctx))
>  799                         return NULL;
>
> This worked with v6.8 and earlier just fine.

Thanks for the report. I'll add this to regzbot for easier tracking:

#regzbot introduced: v6.8..v6.9 ^

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

