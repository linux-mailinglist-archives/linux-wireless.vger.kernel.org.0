Return-Path: <linux-wireless+bounces-9052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E890A8F7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C980AB25D42
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F191473;
	Mon, 17 Jun 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBua7iJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FF190686;
	Mon, 17 Jun 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615037; cv=none; b=OVRpqGzu8q4glaUJ0L9zXt+AS1MmasIsZkARIY64QcRXub1B6KBXb3CbErwjjXlNwvgBpLMNC+ZmrpTwEZud7q9AvLtPT2JkIDg/r8aaSv1zRNC0j1H//C7lCwwTNQkZcnSUsKjK6AslqCszQq3ODNE3jhY/ycvSRhEJ/MCZZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615037; c=relaxed/simple;
	bh=THa1cIbc5tm8begwrxwa5OJJ+G0okx8FqtWT7e7BWZU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pEbE02fwC9aqwxwuE2164LZs6xYwIqxsQvSVi2Xl3S/YV5tjimu/JXwrwAu2oUv5qoIDG36kmjoe/sy+llhahiE5q2gw6E0W+OCLAr2SphrD/v0X563fUOPKKGaAGuhjvHqyn11L1GmIABnE5gDewWLYWj8QKlRy4M6T81dogfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBua7iJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82926C2BD10;
	Mon, 17 Jun 2024 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615036;
	bh=THa1cIbc5tm8begwrxwa5OJJ+G0okx8FqtWT7e7BWZU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tBua7iJDkc8Y2cmXCtRKuJMl9ctDCr7nY0rG4J98jFn/eV49vtr8e9uORP/aGFGGK
	 0jiqol8vvv18U/pB3BBqL5CCIDjWhN/oB17eKeoAjlfyLMCxomP8RMTdN7jluyCG6i
	 H9oFOrB0tiz4eHlZuJX7Uvdc0wlPwAfg3cSrceUGT3ZORNQntkwuwb5JNA7z79W28e
	 bmvpZMul7+vOjz9jOv+JXucDCYS7EwFKvx0N1Ym7uHj1MELLeQLKtLPuCqY/5mcbwv
	 X0u0MPrzEj6niTGf6wDm8S7bjuVri1tBD0jzzJ7cAEr4urDeqqioMeF+gy8g5U6QBd
	 WFj1dpewcfjTw==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-wireless@vger.kernel.org,  Felix Fietkau <nbd@nbd.name>,  Lorenzo
 Bianconi <lorenzo@kernel.org>,  Ryder Lee <ryder.lee@mediatek.com>,
  Shayne Chen <shayne.chen@mediatek.com>,  Sean Wang
 <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  netdev@vger.kernel.org,  horms@kernel.org,  kees@kernel.org,
  kuba@kernel.org,  Bo Jiao <Bo.Jiao@mediatek.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Alexander Couzens <lynxis@fe80.eu>,  Deren Wu
 <deren.wu@mediatek.com>,  Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
  Leon Yen <leon.yen@mediatek.com>,  Quan Zhou <quan.zhou@mediatek.com>,
  Ingo Rohloff <lundril@gmx.de>,  Sujuan Chen <sujuan.chen@mediatek.com>,
  StanleyYP Wang <StanleyYP.Wang@mediatek.com>,  Benjamin Lin
 <benjamin-jw.lin@mediatek.com>,  Peter Chiu <chui-hao.chiu@mediatek.com>,
  linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
  linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support),  linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek
 SoC support)
Subject: Re: [PATCH] wifi: mt76: un-embedd netdev from mt76_dev
References: <20240614115317.657700-1-leitao@debian.org>
Date: Mon, 17 Jun 2024 12:03:49 +0300
In-Reply-To: <20240614115317.657700-1-leitao@debian.org> (Breno Leitao's
	message of "Fri, 14 Jun 2024 04:52:42 -0700")
Message-ID: <87cyogkkju.fsf@kernel.org>
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
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>
> PS: Due to the lack of hardware, this patch was not tested on a real
> hardware, unfortunately.
>
> PS2: this is the last driver that is still using embedded netdevices.

Is this patch a dependency to other patches? I'm asking because it will
be _slow_ to get this patch to net-next via wireless trees. If there's
urgency then it's much better to take it directly to net-next (of course
with acks from Felix and Lorenzo).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

