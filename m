Return-Path: <linux-wireless+bounces-2329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A9836537
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8F5B21619
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A243D0AB;
	Mon, 22 Jan 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c0nRGhya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD01DDC3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933175; cv=none; b=G7nQ8exhY7LejdIBkMzbPdwXCKFsp4BOaeChZNpyrSXAvzB2hmtpQMR7zhfjjQD0mlxXRbmF6cXQKyVNiUVzE4LJr693tqKQDuth7uFefmXezrv+7mCmJb4n22nKD0LE1yZGzGJo5BeHQoIsZ0Cs84Goi1r6COw7zsr8fzzXnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933175; c=relaxed/simple;
	bh=z69wS00VOxfH5JHd5UCUZFpThScYsupiWduF5QS+Xyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWaUFGe+wcCFE1dmKeUUWtQeWL8UJdY2S2UGnadHkFOJ4er4+K+J0PAHTe1zGpgkHs98OpW8gFQw6AynvhB7sIRCwUQYuDoBtaEnvXh4TvSJN+UNaU5PdXsq+LK1wWy9x1Zm62gZ7OfTCpMMlisfnlYN/XO+1cJRwz9F7pCrFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c0nRGhya; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D72B1BF207;
	Mon, 22 Jan 2024 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705933170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf3OswWX/Ocoei0x0vl31Z6FX69gP7BtzOKjxkE32tg=;
	b=c0nRGhyaHOcqNsXMMcaGQAzDKF4TjUrJnUPGqfOpzgBt0B8qsU484AhlYgXtqSwztyqe2G
	3l6p6pQfuS1K54DBYfG3+KnAC+rSDq/Q33f2Ku32zH9nnL0g+acZ2m1E7NCl0xX4A0dHw5
	vNKpbVNUuNn2dCopcV3PIxOgEa4d/LgIieOs8nWKGi6WphuZ4fAV5l3ePSBfpouSg6wJpW
	+lYCOQG4HP1+Yl4O5AZ39an+roSOdHRUIvgfnxnQoXcZ2q31XRvI/oEVBgR3BtXoBzSSX6
	jO3QOUVfhmI2068QvER04rzoPb6wzxBhwjP+8MVdHcx/3rqny2VV/azKZ6iItw==
Message-ID: <e17d654a-8bd5-4327-8bf2-ad81c2f7355b@bootlin.com>
Date: Mon, 22 Jan 2024 15:19:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
Content-Language: en-US
To: David Mosberger-Tang <davidm@egauge.net>, Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 1/19/24 22:51, David Mosberger-Tang wrote:
> The current version of the wilc1000 driver has a probe function that simply
> assumes the chip is present. It is only later, in wilc_spi_init(), that the
> driver verifies that it can actually communicate with the chip. The result of
> this is that the net device (typically wlan0) is created and remains in place as
> long as the wilc1000-spi driver is loaded, even if the WILC1000 chip is not
> present or not working.
> 
> Is there any reason not to detect the chip's present in wilc_bus_probe()? The
> patch below (relative to 5.15.147) works for me, but perhaps I'm missing
> something? Would it make sense to merge something along these lines into
> mainline?

The general statement sounds relevant to me, it looks not so useful to register
the corresponding netdevice if we can not even detect the chip at probe time.
I have a series under work which, by "side effect", accomplishes the same kind
of detection: it aims to fix faulty mac address (00:00:00:00:00:00) which is set
correctly only after interface has been brought up. The series tries to read the
mac address from NV memory right at probe time. If it fails, it can make the
probe procedure fail and not register the wireless device. Nonetheless,
validating chip presence with chip id sounds better than with mac address from
NV memory.

Aside from that, I have a few more specific comments below

> 
>  --david
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c

[...]

> + /* we need power to configure the bus protocol and to read the chip id: */
> +
> + wilc_wlan_power(wilc, true);
> +
> + ret = wilc_spi_configure_bus_protocol(wilc);
> +
> + wilc_wlan_power(wilc, false);
> +
> + if (ret) {
> + ret = -ENODEV;

I would keep wilc_spi_configure_bus_protocol original error instead of
rewriting/forcing it to -ENODEV here. I mean, if something fails in
wilc_spi_configure_bus_protocol but not right at the first attempt to
communicate with the chip, it does not translate automatically to an absence of
chip, right ?

> + goto netdev_cleanup;
> + }
> +
>  return 0;
>  netdev_cleanup:

[...]

> @@ -1187,16 +1189,38 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
>  ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
>  if (ret) {
>  dev_err(&spi->dev, "Fail cmd read chip id...\n");
> - goto fail;
> + return ret;
> + }
> + return 0;
> +}
> +
> +static int wilc_spi_init(struct wilc *wilc, bool resume)
> +{
> + struct spi_device *spi = to_spi_device(wilc->dev);
> + struct wilc_spi *spi_priv = wilc->bus_data;
> + u32 chipid;
> + int ret;
> +
> + if (spi_priv->isinit) {
> + /* Confirm we can read chipid register without error: */
> + ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> + if (ret == 0)
> + return 0;
> +
> + dev_err(&spi->dev, "Fail cmd read chip id...\n");
> + }
> +
> + wilc_wlan_power(wilc, true);

I guess something will break here. This updates now mark the chip as initialized
(sp_priv->isinit) at probe time, but unpower the chip before finishing probe, so
this wilc_wlan_power(wilc, true) needs more likely to be called earlier in
wilc_spi_init (ie: before trying to read again the chip id). More generally,
there is an important change about the meaning of this flag (meant: chip is on
and configured, now means: I know chip is here but it may be unpowered), and
since wlan.c can check for this flag to know if it can communicate with the
chip, there will be an issue here.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


