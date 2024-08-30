Return-Path: <linux-wireless+bounces-12244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E29658EF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A331F24850
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8DE158544;
	Fri, 30 Aug 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K60/ssKV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD216D4D0;
	Fri, 30 Aug 2024 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003809; cv=none; b=NeAtiCcxocTK/M80eF5z/se0MO4No8/L37WKeoS0V+qf1y5zmJcG/bc3OjyBOIzPdFHwzfPQRWvkvfkFG3bvzwuoiHC/EKkFqvaYV5STA7Cp21lTfacPkzHSfQx8Q6LsVtdw8pQRhaMdKRblfVoObqY+JGcrAa+lMNHgU62VlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003809; c=relaxed/simple;
	bh=SGppUcr3XcDzCZT35NF9reldjtBurwIRnByI8W4UlK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8cYqe8YRg6g/abBo7T5SeGesXWA0+CckwSjKpJRpPjQTgDFS9+cWCQs1lad4uTyfZSgrmBpZUDROARCm46AXFdJLFnenyfy/FoRn99XxNWEcl1A0FfZtwpVAqFVcFiYsa5MhNZgnkHsx73ToAwo8FmbrE1MTU+xGBsADRSUBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K60/ssKV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B88D40010;
	Fri, 30 Aug 2024 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725003805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYDF/qFiFyKUZMLDs2FqY4OyzGLxagNS91tJHlcxSSE=;
	b=K60/ssKVG65HW2bGYxyZ7uSdjk+XLrBgxnduxGwqi5TuDvKQTjFLKJPdM7N6OvaR1ChJPs
	tgVdZLy8GNaBLbkG7f4bItSegRW4GRw9n72ClsCR/IcDoaHXmBLf+6h2b6P2Bi2cfetoY2
	witJju4T0r3cZzNP8nm6TnfrLVsN9YQpbPtWFP0d1oqwzlfttRkvV3MzVfgJdL5rky1hSF
	WqUhniEoykKkxctojqPmKwE4uMWoV3Tt2cjhtjP9HgrJhSbF4LkxubIYpX8jbGP1127ind
	9V853RFiwqLdnEzMkRi1n/gBIFbE0o6520zLYvHCBNcNHMwHVPLhJzD3dG8NLw==
Message-ID: <c16370e5-2b65-4288-9f99-50e8faa9c8ea@bootlin.com>
Date: Fri, 30 Aug 2024 09:43:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: fix potential RCU dereference issue in
 wilc_parse_join_bss_param
To: Jiawei Ye <jiawei.ye@foxmail.com>, ajay.kathat@microchip.com,
 claudiu.beznea@tuxon.dev, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 8/29/24 10:17, Jiawei Ye wrote:
> In the `wilc_parse_join_bss_param` function, the TSF field of the `ies`
> structure is accessed after the RCU read-side critical section is
> unlocked. According to RCU usage rules, this is illegal. Reusing this
> pointer can lead to unpredictable behavior, including accessing memory
> that has been updated or causing use-after-free issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> To address this, the TSF value is now stored in a local variable
> `ies_tsf` before the RCU lock is released. The `param->tsf_lo` field is
> then assigned using this local variable, ensuring that the TSF value is
> safely accessed.
> 
> Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>

I guess you are right, that indeed looks like a miss from 205c50306acf. And I
guess it needs wilc to receive packets with P2P info in it to trigger a RCU splat.

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


