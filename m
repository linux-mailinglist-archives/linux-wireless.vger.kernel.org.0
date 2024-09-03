Return-Path: <linux-wireless+bounces-12443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1469696ABF1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9730C287B40
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7D126C16;
	Tue,  3 Sep 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctev56XH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331031EBFE4;
	Tue,  3 Sep 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401812; cv=none; b=jCIwumUGaHU/zbHbLuHMHLkKLMVMOebCnh9/E7TKU0Zaa4wSFatnDMfim3/1/CBSzIa3yctnLbOm98lBj2HyZqzkb6bW6URb/7TTwU0CvVwz9oOpqf35FaaFdCMBI/QelrBlNuQOt/1tkZwBrrgocK37jaxTmZr9rIyorpaENwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401812; c=relaxed/simple;
	bh=u/TGDgT9nMGoSIjabJLW3PnQ9BU6/qBVyJyzNBpjKA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGwykmQbKa2OvaFKaVH2qhLfUIBsVl7dtrac5wwpZYTo3mTo1b6u+5+UMCL9l0ufzljBKMbZf8R+C6KC+mSMXPVM2nVkhfdKij3CC4NTapS2kIss9YZXCr3QEHSVerd3kgQQR0I99GzVIOaNCO9UvMLQjCz595Ixbup6bSitvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctev56XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8034BC4CEC4;
	Tue,  3 Sep 2024 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401811;
	bh=u/TGDgT9nMGoSIjabJLW3PnQ9BU6/qBVyJyzNBpjKA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ctev56XHYQrMTxPIN36pvA5ji059bJWHtvJO4u3nY/6RQ1NKpLkf3wmKgjl0pn3Hm
	 GA0XR5S0Ix9Fs8eEHOaU0HoInL/Z4zW9M0SU0aYcHSX+16A/xh6c7sCIt6ZmgEFoGK
	 vv9THsKS/7EtDD7qXK3wNxvcpvRMA8OePdoMwhzgC/7D7bWlkAhwQdtHnrfWOHynCW
	 /+NIm/AEoNbl0jAgj8qn1/vSMXAolEUFLuYLgE/mX+byeMC+cLHMUkI5tkqROCjiPJ
	 HlEdinz/2+T6DVUkaMLEJro5qq+Z5rkTdcYGmJ3N8FUqON2c2mAxfAsyFDy19Uj0K+
	 Nf1uOZQD3k+0g==
Date: Tue, 3 Sep 2024 15:16:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: <florian.fainelli@broadcom.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
 <heiko@sntech.de>, <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
 <mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
 <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
 <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <kvalo@kernel.org>, <u.kleine-koenig@pengutronix.de>,
 <jacky_chou@aspeedtech.com>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next 09/12] net: ethernet: sunplus: Convert using
 devm_clk_get_enabled() in spl2sw_probe()
Message-ID: <20240903151649.1b466145@kernel.org>
In-Reply-To: <20240831021334.1907921-10-lizetao1@huawei.com>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
	<20240831021334.1907921-10-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 10:13:31 +0800 Li Zetao wrote:
> +	comm->clk = devm_clk_get_enabled(&pdev->dev, NULL);

You can remove clk from the driver struct now.
Please check if the same applies to other patches.
-- 
pw-bot: cr

