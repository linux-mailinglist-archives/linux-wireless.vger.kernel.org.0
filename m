Return-Path: <linux-wireless+bounces-28392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34568C1E11C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 02:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8EA3A8D98
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086992E8B77;
	Thu, 30 Oct 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh4ILMBq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB72E762D;
	Thu, 30 Oct 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789415; cv=none; b=VVvkO6nWzozsPV+GwVJQ8Vu19iAwe0IKuAPKhnRuSPO/NPdXcOtR3LlfLA3ymmC2MZzYh4KhUVJD4kIwGUBLKDttPLksEdLrgMbFuihtVVMJ4OUg5eE6/40UeyOuN3CTbF3CuGDV7mNM+3ef8HP5AFriL63laHgKTajibhrOhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789415; c=relaxed/simple;
	bh=HRpBacWvcERcW6Qv0x09GJHb3Ah9hMytMcYGZZIFbVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbxQ4BJH8kBJVOw88ekca6+JHxeKM9UwuPtZvkuCqh6uFQUEBmUBk/7Zkl/8izyM40hbp4U44kcJNpA5lB6QQW47/XpQ8UnpvbmfTyIlmJKVvHBFSpX1TUUENLIDWhVgN1t/oUC3kB2qenCfl1uXAnlcxuzMIW2isfrefHtkBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh4ILMBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF82EC4CEFD;
	Thu, 30 Oct 2025 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789415;
	bh=HRpBacWvcERcW6Qv0x09GJHb3Ah9hMytMcYGZZIFbVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gh4ILMBqEHUxbzVxPNqMOyFKoBk1D/2dQepMJwwn7MC+LxPe8bWzlFc0eOlE3GmMs
	 GjyszMZWKU+BKnqE3gljkkBM8c2E3CgG2lA3V8BGoiqAsrCoiDbdpA4LmayHj9+2ct
	 btpzGcp+9t29UohHNXRtpOZ22usFiprhf4Q0VHOdumxE8QVL/n8lNGeWrnDzN98pwL
	 o96amkoTXFSNP+m+eKA5tRAB0mUJXoaZMs/1ZkRbVT+miZRfxHASMkTAxQ6wyGwkfx
	 bw9x/TVL5KywwZOQnv89h5iDMO1jIqg+5uAiBwFh8onEhOd2lCVQWvC35MEHJiKewk
	 AdpETnV8lF1Xw==
Date: Wed, 29 Oct 2025 18:56:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Paul Barker
 <paul@pbarker.dev>, Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Alex Elder <elder@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Stephan Gerhold <stephan@gerhold.net>, Loic
 Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Chiranjeevi
 Rapolu <chiranjeevi.rapolu@linux.intel.com>, Liu Haijun
 <haijun.liu@mediatek.com>, Ricardo Martinez
 <ricardo.martinez@linux.intel.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Michael Nemanov <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Roopni
 Devanathan <quic_rdevanat@quicinc.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] net: ethernet: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20251029185652.14483c58@kernel.org>
In-Reply-To: <20251027120559.GA365372@ragnatech.se>
References: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
	<20251027120559.GA365372@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 13:05:59 +0100 Niklas S=C3=B6derlund wrote:
> >  out_rpm_put:
> >  	if (!priv->wol_enabled) {
> > -		pm_runtime_mark_last_busy(dev);
> >  		pm_runtime_put_autosuspend(dev);
> >  	} =20
>=20
> You could drop the { } here. With this fixed for RAVB,

fixed when applying, the wireless patch needs to go to linux-wireless.
You may want to repost that once again if it's not in linux-next by
next week.

