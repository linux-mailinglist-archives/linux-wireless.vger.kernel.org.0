Return-Path: <linux-wireless+bounces-9055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB290A98D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3C2889CA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642A1922C9;
	Mon, 17 Jun 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/mPGHpM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E54288BD;
	Mon, 17 Jun 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616589; cv=none; b=PooSObC+4rR/ebvgtjay64wdfEfB8d4xVK/QEYgm3TqiMW9ufN12XbOrBnDtTEHet72fKLxBt8GTuR5ns0Rs+Q6F94CANgAIOGV72iGLSi8Tj44xdVnA4BarAL12OPnUrbcilOzq7oW4Z35g6ApQTjulEldX/Cdgtr7jy7y5Z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616589; c=relaxed/simple;
	bh=at9csQjhwS6i1s/d4XG/8Zpj8DRi4xJ/ag+5eIwgDXc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GSJFgkvGeupIyIzEJXIbnsmB8IXKlNlJMaoG9zkUfvA1d9nQRIe5fYDvpxVUxzGcDt9LgTgRA6oZPBk9zOWCO/PMKOR9/AJLxwJW1a/jYUZxpydEFCnn48vSqptRGigrQmkHFIgYjNAFYncGlSzvI6F/CPCfX26vBN7QdoiJY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/mPGHpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7837C2BD10;
	Mon, 17 Jun 2024 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718616588;
	bh=at9csQjhwS6i1s/d4XG/8Zpj8DRi4xJ/ag+5eIwgDXc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=E/mPGHpMeIKgElg+Cpbw7Fc4U13Fmjr/ou+tMopM8OI/rDuDdPcOl4diV6dshwHhQ
	 3sNv1Ke/lo5tm3ytKne5KNNO2Yd/NG5GnuCLOuBIioWeNHZSFi6d0iSOde+dXx/B6j
	 3whdRSvwmZH1N2Ue9vGwp3EaecJaqm5pKb/q6LtrvJI6tJpV93fkKvzL9+vkwzp6vx
	 8L8/gSlYRXdmAFPtQ01t2G0VPY93VsyiGdmB1XI/MsoVst8nV+XnNF86IcCpni81i9
	 xHSp07ojBZM0bm9x6EbEbQmOcqic7F7aUAtsulWym9myGefvcAHF9vMNFWTPJf/CQK
	 v1oZos6Ur+BYg==
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
  "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
  "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,  "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: un-embedd netdev from mt76_dev
References: <20240614115317.657700-1-leitao@debian.org>
	<87cyogkkju.fsf@kernel.org> <ZnAAT/a3DKnTgUoz@gmail.com>
Date: Mon, 17 Jun 2024 12:29:42 +0300
In-Reply-To: <ZnAAT/a3DKnTgUoz@gmail.com> (Breno Leitao's message of "Mon, 17
	Jun 2024 02:22:23 -0700")
Message-ID: <874j9rlxx5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Hello Kalle,
>
> On Mon, Jun 17, 2024 at 12:03:49PM +0300, Kalle Valo wrote:
>> Breno Leitao <leitao@debian.org> writes:
>> 
>> > Embedding net_device into structures prohibits the usage of flexible
>> > arrays in the net_device structure. For more details, see the discussion
>> > at [1].
>> >
>> > Un-embed the net_devices from struct mt76_dev by converting them
>> > into pointers, and allocating them dynamically. Use the leverage
>> > alloc_netdev_dummy() to allocate the net_device object at
>> > mt76_dma_init().
>> >
>> > The free of the device occurs at mt76_dma_cleanup().
>> >
>> > Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
>> > Signed-off-by: Breno Leitao <leitao@debian.org>
>> > ---
>> >
>> > PS: Due to the lack of hardware, this patch was not tested on a real
>> > hardware, unfortunately.
>> >
>> > PS2: this is the last driver that is still using embedded netdevices.
>> 
>> Is this patch a dependency to other patches? I'm asking because it will
>> be _slow_ to get this patch to net-next via wireless trees. If there's
>> urgency then it's much better to take it directly to net-next (of course
>> with acks from Felix and Lorenzo).
>
> Since this is the last patch for the whole flexible netdev work, I would
> prefer to have it through net-next then, so, we finish the whole work
> sooner rather than later.

Ok, even though I hate dealing with conflicts between trees I still
think it's better to get this directly to net-next. I hate "hurry up!"
emails even more ;)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

