Return-Path: <linux-wireless+bounces-9242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598690EB3F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1046A282EEF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69A143752;
	Wed, 19 Jun 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9Ny1vBf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4F14373F;
	Wed, 19 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800624; cv=none; b=JWa9YKVPc4ysrpFtctL7ZpW1XOFWSlKwBvJhElBXW7LYHXnyCuGnsOocE2QemHHDIJOw7ylRCIXP5XIDxShkItZrM2ldXc0qAW1VkE+ifVSEFLxFv+cWam3t9m3Y32myFWU7my/cvV36i/T4jCkF/GylF4umIJLPtkPBvgyBZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800624; c=relaxed/simple;
	bh=G/1QD6sxX4K16RM7mh/Kh/CPatatOc0PRN9T+Q9l3ho=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I/rJwthUMTQKFvPO23f0od+Z3M2AK6kF3mjR36hFFXLo7qLrtdM4tj8/U4uQbdN0Qh4HhcY9dksycqrPH3jnEvWm/QnkLV3DVeZCEOxSpZ1rqYBY9TMIlGY5CyCA3GDcIarWEyJM3Cqos4WYbB6zb5BytTLpDskSeIU+ASrJ4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9Ny1vBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1316EC32786;
	Wed, 19 Jun 2024 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718800623;
	bh=G/1QD6sxX4K16RM7mh/Kh/CPatatOc0PRN9T+Q9l3ho=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=p9Ny1vBfTquUva0eyQD4qFh1bVMBzMXb7Txe93yOkDr19G9vFfBwKs1TNXuwXpg4q
	 JGByEOYw+S4FBLwq5auCFg/tMpjH6+HyvAiwAV7jes41arn7P4T/iQmg4Q4qa9WHhJ
	 NNuY9ctilj+0MC415cdJcimeVh2KHjkCPtRgZfhyGIVb0M+wlsz6lIkbZaTOO3E89Q
	 XjXWHyDwwg7ihGkZ+dVc0Habiw607B3Q1pd3uWnUrXSELSdm9ZrTup5UolBvt6ECoA
	 FQBNB6JNJeZyp0j4tbOnZiwLpwc+dJpui2Aqmgu+sDGeneREUEVUrO74tiTHcJx2+h
	 a8+bKJb7A8jcA==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-wireless@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  Felix Fietkau <nbd@nbd.name>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  netdev@vger.kernel.org,  horms@kernel.org,  kees@kernel.org,  Bo Jiao
 <Bo.Jiao@mediatek.com>,  Alexander Couzens <lynxis@fe80.eu>,  Deren Wu
 <deren.wu@mediatek.com>,  Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
  Leon Yen <leon.yen@mediatek.com>,  Quan Zhou <quan.zhou@mediatek.com>,
  Ingo Rohloff <lundril@gmx.de>,  Sujuan Chen <sujuan.chen@mediatek.com>,
  Peter Chiu <chui-hao.chiu@mediatek.com>,  StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Benjamin Lin
 <benjamin-jw.lin@mediatek.com>,  linux-kernel@vger.kernel.org (open
 list:ARM/Mediatek SoC support),  linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/Mediatek SoC support),
  linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support)
Subject: Re: [PATCH net-next v2] wifi: mt76: un-embedd netdev from mt76_dev
References: <20240619105311.3144908-1-leitao@debian.org>
Date: Wed, 19 Jun 2024 15:36:56 +0300
In-Reply-To: <20240619105311.3144908-1-leitao@debian.org> (Breno Leitao's
	message of "Wed, 19 Jun 2024 03:52:36 -0700")
Message-ID: <87o77xkt1z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
>
> Un-embed the net_devices from struct mt76_dev by converting them
> into pointers, and allocating them dynamically. Use the leverage
> alloc_netdev_dummy() to allocate the net_device object at
> mt76_dma_init().
>
> The free of the device occurs at mt76_dma_cleanup().
>
> Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

As discussed in v1, feel free to take this to net-next to speed things
up:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

