Return-Path: <linux-wireless+bounces-10600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6E93EE32
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0668A2824AD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE412D747;
	Mon, 29 Jul 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YWMuSFkW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68E12CDBA;
	Mon, 29 Jul 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237146; cv=none; b=U2WrO/pMOdFsKYU1DXqLlxpJaz2NnZ5DIY5+lUBUyNhb0X1NtP8KzNwgkR6xbswT3oAj4ThJge6sDOLjZirCSXq7dLLkGi2PXfuELNYFOX1LH1RAtPxqVNvDFnuQDLWtSErTemnUv053/ck2IKf8trXw2I1VwYIKoOmp7F5QsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237146; c=relaxed/simple;
	bh=XKF2kEhTHUN6hW6xoC+05y0xjZYh08dSZhuKC7hZN3Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Daskbc8uYEghEX43ZVpZJskohOnYoPBz8P90WrZt/dEoa+/rwfc5xkwYG8VECAzO44i5FqwCgxC2s72mKeIdi5lciDJNAxgH3NMYE0J27ygRDJjoxPd3bJNHETIYzr/JcOdGg2miO9nf/ffZzhvgqYihNZN9cZBpZ0YtWJCrdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YWMuSFkW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722237142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+2pS+boxJyCrKP1vTl60pQQkVNX6E4kibCtVggIyA8=;
	b=YWMuSFkWIjcdD32gkPlvzOS5gUUR0xXeDQu6KZLhkHuGInsiP9buBZGq1mEIc+PdpbyYUZ
	rT5cHA0eOZH0h+7m3+RMArcE8ZgAOajHZacgdV6uDmr3HSJHpZeX10MHH4Lyw0vHssfX3g
	uJjKFnv/0w2HZNWidCZF7a7cK1MyBhvaEMbOsw68K3i+2g4dMnWSK8+eNU09vajoO9HO3Q
	2bmjQ3vYKETFDHd2twAmXwksAjFAF0R/EVaOBmJq9otPjjgyVz4jpDD+d2iL7GCbgX4LIS
	Mz8lomdhfKpVNXg52FWxSzku0OZUkFYlk4oDwfY6r2X3c85ry7m0J4f5BRuqSg==
Date: Mon, 29 Jul 2024 09:12:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor+dt@kernel.org, arend.vanspriel@broadcom.com,
 efectn@protonmail.com, jagan@edgeble.ai, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, arend@broadcom.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, megi@xff.cz,
 duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com
Subject: Re: [PATCH v4 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
In-Reply-To: <20240729070102.3770318-5-jacobe.zang@wesion.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-5-jacobe.zang@wesion.com>
Message-ID: <d7068c96e102eaf6c35a77eb76cd067d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jacobe,

Please see one comment below.

On 2024-07-29 09:01, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver.
> 
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index e406e11481a62..4db188a41fd52 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -6,6 +6,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_net.h>
> +#include <linux/clk.h>
> 
>  #include <defs.h>
>  #include "debug.h"
> @@ -70,6 +71,7 @@ void brcmf_of_probe(struct device *dev, enum
> brcmf_bus_type bus_type,
>  {
>  	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>  	struct device_node *root, *np = dev->of_node;
> +	struct clk *clk;
>  	const char *prop;
>  	int irq;
>  	int err;
> @@ -113,6 +115,13 @@ void brcmf_of_probe(struct device *dev, enum
> brcmf_bus_type bus_type,
>  		of_node_put(root);
>  	}
> 
> +	clk = devm_clk_get_optional_enabled(dev, "lpo");
> +	if (IS_ERR(clk))
> +	if (clk) {

These two lines looks really confusing.  Shouldn't it be just a single
"if (!IS_ERR(clk)) {" line instead?

> +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> +		clk_set_rate(clk, 32768);
> +	}
> +
>  	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>  		return;

