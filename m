Return-Path: <linux-wireless+bounces-10661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8739406BD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 07:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0771C226E8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798511662E8;
	Tue, 30 Jul 2024 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GtUlpQMk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8B79B8E;
	Tue, 30 Jul 2024 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316279; cv=none; b=jC7QSwqzyKb89U30soja6HgripiXna//x2uWXYGz6jrHpjqNJUGWRx6podiFopJ7dxk1a8dZSlt9G6ZYiA8/bz9oPjosTVnMH8VJ0p+r9DS0zdVKh8sjVxsnp3vCwiy1yo/4iNotbR811GN0xM8y8FZewSUrBwA1HPYuAajT+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316279; c=relaxed/simple;
	bh=y+xJg/pVcJ1y/GxBn6qUhLzXw2h4YczuJeQD8VE2xG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiGKsBPqC8OiW/M2w3nbc/ajZDlKdE0vqZWtTF7d+snQXLGkLcRKiJPl4HHTQwEUaaIP2XWRBcitBCTDIwylvBtMjwMmcc9YkBtyNStc6lqPVeXwXCeUI9Ck0rQIzlqlG1N2uxOQn9rxgBX0kfVgp003j/eeCotDMunnlj+CSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GtUlpQMk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722316220; x=1722921020; i=wahrenst@gmx.net;
	bh=g2qT0PqPzss90wszs6Vw/sUubex/AK94mW4YSO8z+6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GtUlpQMkqXYlCdfWx8/dX0Wq2i6sof9gWcfWs64aI6BJI3qKXo5+AodwEWK9DWlA
	 qdbZJl00uu9DO9wgVIbwnYx8jfGZ0s5QYVYeOwxNJA+3dXSLSlFhuhDug0PkV83LI
	 HJciUHdFGIpJrkMfT/yjUkyP2mR+cXomXFm8XaIxS0emkgkyso5T4BJaNqAGSLz59
	 nOlEZfPY3HD72EzVhl0enqT6jUq16emh66uYAHxezsQUB4wiCFoo0pOsoa+Rf/bCu
	 kBQoB3127MY4K+K1SOFniXT7bztwsts/ohM52GHds0Ccj8kU6eJts9Agn1FN2l546
	 ZO3uZL9hAi5j4qWOdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1rvQLd2h8b-00m67u; Tue, 30
 Jul 2024 07:10:20 +0200
Message-ID: <0b2cb5ca-f134-4733-a931-9e192e47c65d@gmx.net>
Date: Tue, 30 Jul 2024 07:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-5-jacobe.zang@wesion.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240730033053.4092132-5-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8WNkQqDKD6KnO7CaHnNyvZKHD2ZLfpHZ1KvW+8D6yIJ+YdzOq/6
 CLWdUvzbu9l6YctXbf1haRex8PX2JKcQU7WhDqvAMzzMsm0/6HAKqHK0DRnctKDabAs5BFZ
 vthC6Ht7+pR02+u8OGMUjdtgk+oE3lYNkxhNpFYnAVOFycdKUFvB88ZkSJ5bFY724iQYRV+
 Tuwsjq0ksT2Qcf7t1diEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nd+W6xGWmI4=;A2cfTUJ99aOtAX+YCl0i1dYvdGn
 gY8LRgEJiagSJAvzjLo+cxqcN9VESNtTRJi9hoM9ziTMuej/tBgQQsP7MgG43c40YNV2JIIUP
 zJQFD680l97chT4EvmvCycxhn5qU8JNSfYHBmonmQbC+Q+T+WAW9pfNm6U1KDt0E/AwS3jhrc
 r718kLHUxjeK6MA3cvv4UC9gUMdLBhC7wST4tXu4K4L5qK1z60i6ln4DDJgBJNrlj56OMv8ld
 qijT74jCjIf8yOKIhlve+/bOCvFONfBKh/JuVlefEOABQ5PRQmOLya0XNtfq8Q0Jixif/gCxd
 TWUKlZfKnL2AuXXzl8Yu5KViNX+fbBCnCGf4CzPSXT0jiOcOfPYTHdwDjWilOFt3we5aik5Oe
 uxoPvt6CpHUkI7VwX2vqi2zcR8EkoPH5FnzzdDfF+VwO1U6LOEPpmhIL3QGfiiFNvkfCQKXaO
 FcEG7Fn8ScOcG+THZNobY1VgeafUJ1OhS69VcarqU4FbT8BRZPx24o7KZE9Z462ljJl5GX6UH
 Uu+0n+E/BZkcjksmo3oQcJB+eXADkhWdTJ1u0xWIThc5Nh3OOS2RPam8/a/dbsb/G8/zsAWlV
 vhzkPh/Q9RK8j2MYXuKWi+nFZenzFU9KZG+XjmdjhhwaWVNqsAtwLW/DnEJTjDhLctPatGuTS
 GEtSWP5tZtmgB6E3SKFlOghoSCAj3xz8VXIZpJilYua+EbRkvmuwmUMb+trLyL6DU/sLz19QK
 42yut5KRB/w5+tWdzdB4rt20sjl8bNwO10reoIKWt31a1oYp96fRXkeoKb/dWStZ1yI7rk+2S
 k0ufOL0hbl5TsgctUT3VJ2Sg==

Hi Jacobe,

Am 30.07.24 um 05:30 schrieb Jacobe Zang:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index e406e11481a62..6246e3fd7399f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -6,6 +6,7 @@
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_net.h>
> +#include <linux/clk.h>
>
>   #include <defs.h>
>   #include "debug.h"
> @@ -70,6 +71,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus=
_type bus_type,
>   {
>   	struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
>   	struct device_node *root, *np =3D dev->of_node;
> +	struct clk *clk;
>   	const char *prop;
>   	int irq;
>   	int err;
> @@ -113,6 +115,12 @@ void brcmf_of_probe(struct device *dev, enum brcmf_=
bus_type bus_type,
>   		of_node_put(root);
>   	}
>
> +	clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> +	if (!IS_ERR_OR_NULL(clk)) {
> +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> +		clk_set_rate(clk, 32768);
> +	}
even if the clock is optional, there should be a proper error handling
(e.g. the -EPROBE_DEFER case).

Best regards
> +
>   	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>   		return;
>


