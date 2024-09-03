Return-Path: <linux-wireless+bounces-12400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343896A67B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DE71C2425D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F831917C0;
	Tue,  3 Sep 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTDHsxHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277A188936;
	Tue,  3 Sep 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388114; cv=none; b=E02GeagIDuQ5jGBmFWvxY6cJGl+RVf7jV14mtrFkeDgelzNRxQF9n2Lkz7EDgtJXFtE7qrQU/AzftVP6hVilT8ufv1SB3Z+ISlL+ZD4jslsKD/hbUixzvWidPX6c09WAmUsktaohNsMn56LHyct3VejVHChdyp/e2V8GyaKp/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388114; c=relaxed/simple;
	bh=vI2bYW4z4lwdz3NmwDNGx5Rnf4p5mBY486fg1g3GR58=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jJg4qEaKvVq6cKhWqDCS2EGKchGfoOLjsdzujhjkFpMsXOS32CH8C/AgAosspnpbfXfk30L0gd3hsef576pBimgkywUd/D0BVQ8e6bwxptl4K4R1xmdqncdwLRPLSj3hEEg/MQdGQRJTmG1HVq6sYgMiHKPhn5PYRt6fKoYphec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTDHsxHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714C0C4CEC4;
	Tue,  3 Sep 2024 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388113;
	bh=vI2bYW4z4lwdz3NmwDNGx5Rnf4p5mBY486fg1g3GR58=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PTDHsxHl2wrUtC8QkmC4w7Ps3XyCQfh4f+9kQMNHZeGpa2vYu+ub60LDe8jDB2sYO
	 WhgwuJoff0Ke2WjSNK+zkDUIOZ9o+DIWNw6lEJIO9xcgao6B8R5NDPeMCWSWfIFUT+
	 JDkpWP6Uyj+7lvquU1gNK+4no9IY/sTZ9luUr4Qz7EIWWi/bT2eKXVJjyfCccuk3Eo
	 8XJ/WBc207cqCJj8OjloFxJZSQsDgICkfSFEdCUtIBr/61ypA6qA1V7sU6hIg9F2Lv
	 R8eD+yQD1OqB0+WyECc4ebL6WW8TAhjthzk/LstHr30PkbYv1WIA16Z4elS+2ll99R
	 K5UWLW/OsgL3A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/1] dt-bindings: net: wireless: convert
 marvel-8xxx.txt to
 yaml format
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240820142143.443151-1-Frank.Li@nxp.com>
References: <20240820142143.443151-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), linux-kernel@vger.kernel.org (open list), imx@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538810845.1029035.7505899712659095427.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:28:30 +0000 (UTC)

Frank Li <Frank.Li@nxp.com> wrote:

> Convert binding doc marvel-8xxx.txt to yaml format.
> Additional change:
> - Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
> - Remove mmc related property in example.
> - Add wakeup-source property.
> - Remove vmmc-supply and mmc-pwrseq.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
> failed to match any schema with compatible: ['marvell,sd8997']
> 
> Acked-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Patch applied to wireless-next.git, thanks.

25f855413885 dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240820142143.443151-1-Frank.Li@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


