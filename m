Return-Path: <linux-wireless+bounces-12675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C2971CD8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C802F285047
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC951BAED7;
	Mon,  9 Sep 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcYK562c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE181B5EB7;
	Mon,  9 Sep 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892772; cv=none; b=j30kFamDpIxlpwAu7pnyXuKyQta+FZqCbR/PvRwSQbpRd8tRNOHaIW4lI9MrEPnppuA10mK+YaaXlNzpUHO+GDdDesk8e4zOrQWZWhC+POLJFOTY7z4unYcwsgiCUmf2ppV1RXQ49j6cTlK1TzBjvnT9rU67I6hWlmplK09r5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892772; c=relaxed/simple;
	bh=8FeXibhiPA67qxomm7l8x3gLeT2tSXAYWaxMb2sDIrg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UeHjNWMrBlAMbz9eFzX+XhdajcdR0XLerhLCgQyJtT7GE+QgdLJOn+0we+CQeWZlcV2jGEgh61uBSF4o4kOyb2YsL0mhEEg2hS9meBw0xJu/5dCX9pkuJ53Wn+6EKEueCyZRECn2EZz0+Ip6p30fu9Pqdbc/N+OH2vnDoWHTyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcYK562c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A643AC4CEC5;
	Mon,  9 Sep 2024 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892771;
	bh=8FeXibhiPA67qxomm7l8x3gLeT2tSXAYWaxMb2sDIrg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BcYK562clRLjPjIL1TwE/GoqBY2kxlMSNzUj59e7A+yhPSZdwYKOGE+dpidRLGcl/
	 px1TecD19E+oGfU/e7zMQYHdj6NHAJNDfjgyU7QlIx7iW+X1EdLROFqspdTfUvrdHJ
	 0nxkYFvVw91g1gckgpj8b5QhOkfi5xzCHEhMpVxPxjwOJuWhmoxDzPorjvHDAGkdb9
	 efFi1Fvb596hLzjOZmBYZljhXZllGM2Fct9oYgBCru/pz4f8cey0oSsz8pt7Irtjmd
	 KyOabJkFUEY/o2SjQ1GNZfVeHjOnPXc7lypu4HX6isipZhy8uFCGTWH+T8GSOo2cCP
	 V//AaIE2qOKRg==
From: Kalle Valo <kvalo@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <davem@davemloft.net>,  <edumazet@google.com>,  <kuba@kernel.org>,
  <pabeni@redhat.com>,  <claudiu.manoil@nxp.com>,
  <vladimir.oltean@nxp.com>,  <louis.peens@corigine.com>,
  <stefan@datenfreihafen.org>,  <alex.aring@gmail.com>,
  <miquel.raynal@bootlin.com>,  <chunkeey@googlemail.com>,
  <briannorris@chromium.org>,  <francesco@dolcini.it>,
  <set_pte_at@outlook.com>,  <damien.lemoal@opensource.wdc.com>,
  <mpe@ellerman.id.au>,  <horms@kernel.org>,  <yinjun.zhang@corigine.com>,
  <fei.qin@corigine.com>,  <johannes.berg@intel.com>,
  <ryno.swart@corigine.com>,  <krzysztof.kozlowski@linaro.org>,
  <leitao@debian.org>,  <liuxuenetmail@gmail.com>,
  <netdev@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <oss-drivers@corigine.com>,  <linux-wpan@vger.kernel.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/7] net: Use IRQF_NO_AUTOEN flag in request_irq()
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
Date: Mon, 09 Sep 2024 17:39:24 +0300
In-Reply-To: <20240909133034.1296930-1-ruanjinjie@huawei.com> (Jinjie Ruan's
	message of "Mon, 9 Sep 2024 21:30:27 +0800")
Message-ID: <87seu8c2n7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> said, reqeust_irq() and then disable_irq() is unsafe.
>
> And the code below is subobtimal:
> 	 irq_set_status_flags(irq, IRQ_NOAUTOEN);
> 	 request_irq(dev, irq...);
>
> IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
> the automatic enabling of the requested interrupt in the same safe way.
> With that the usage can be simplified and corrected.
>
> Only compile-tested.
>
> Jinjie Ruan (7):
>   net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
>   net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
>   nfp: Use IRQF_NO_AUTOEN flag in request_irq()
>   net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
>   wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
>   wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
>   wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()
>
>  drivers/net/ethernet/apple/bmac.c                   | 3 +--
>  drivers/net/ethernet/freescale/enetc/enetc.c        | 3 +--
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
>  drivers/net/ieee802154/mcr20a.c                     | 5 +----
>  drivers/net/wireless/intersil/p54/p54spi.c          | 4 +---
>  drivers/net/wireless/marvell/mwifiex/main.c         | 4 ++--
>  drivers/net/wireless/ti/wl1251/sdio.c               | 4 ++--
>  7 files changed, 10 insertions(+), 18 deletions(-)

Wireless patches go to wireless-next, please submit them in a separate
patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

