Return-Path: <linux-wireless+bounces-11801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49295B4B7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E361C22EE7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2B1C93DB;
	Thu, 22 Aug 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p1EE1/Sx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E871C93C9;
	Thu, 22 Aug 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328636; cv=none; b=GuXvv4NeM40IsNCV/m973JrDMkYTrecQYWRwqIYUZQM6hzC/83iVSIBF7u/xB0HJGD20+ZsEnO/Rq7z38aHWjNvC4RFriIieye65Jx4/9a1g/+9StDDJbROEzz8/Me0cJGOf+rf/cvmP7mcayFWAX7LWYBsc7lUQyvLeUUhjYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328636; c=relaxed/simple;
	bh=Eqs5aJUrX030Wb7akJ+hJ7s+60DDzMm03GCV8YQDW8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4tl2xyh9Wc5VuW/p+zHpQpppGu0cRYPskYeUeZv7/Lc9d1jkIj3HVUoEJ50hw1c40unJ0HBb8lTTsCF3adC+KLiqy5bhR/0c+d/fguho36LFMjCXawPamnO5YzMiDgnWgCq8IaNb6Bg8Q6u1ebGABRbz2PQII4AHGov1PFzul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p1EE1/Sx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AD4D1C0006;
	Thu, 22 Aug 2024 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724328626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IA2jpiRqv2jkOr6vAQ5LkEUg6XJ95e5T7MH6yDvbU/o=;
	b=p1EE1/SxXmWpsoKR0zk9qAucc7Ze7gcXR8RUxXr6Hxl9R0esEDJl95DnHk56A+0NhxUAyQ
	GVod+0YXGXa0ezKJnoXB3ryRltWy1xxIqft07OF4YAV9HlO/8B6EUBf/5mUKVtDTeAd/Zg
	jCIzzcI6gQigSFua2753+gtBq+tszc+WUwwF2iIG9/M/xqKXXD/rQvSvMDSwwrUOJHeJUe
	r65E/bPYq36O3fCH7Zg1Bh7rNY15nX2r1eH/OqikGC19GY90DXBZ2rMUdf7nW48fY95St5
	XzRDWTuQRGgLtb3I2wg98uDoXuqOPvVc2l8rA9i6hCDrd3ImgDwQxd6HusN7tA==
Message-ID: <bbaf1b15-2d0e-4699-91cc-17fa7a18559b@bootlin.com>
Date: Thu, 22 Aug 2024 14:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240821184356.163816-1-marex@denx.de>
 <20240821184356.163816-2-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240821184356.163816-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

I was coincidentally working on adding wilc3000 support upstream too. My work is
also based on downstream tree, so my comments will likely reflect the reworks I
was doing or intended to do.
For the record, I have some wilc1000 and wilc3000 modules, in both  sdio and spi
setups.

On 8/21/24 20:42, Marek Vasut wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>

[...]

>  	if (!resume) {
> -		ret = wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
> -		if (ret) {
> -			dev_err(&func->dev, "Fail cmd read chip id...\n");
> +		chipid = wilc_get_chipid(wilc, true);
> +		if (is_wilc3000(chipid)) {
> +			wilc->chip = WILC_3000;
> +		} else if (is_wilc1000(chipid)) {
> +			wilc->chip = WILC_1000;
> +		} else {
> +			dev_err(&func->dev, "Unsupported chipid: %x\n", chipid);
>  			return ret;
>  		}

I wonder if this additional enum (enum wilc_chip_type)  is really useful. We
already store the raw chipid, which just needs to be masked to know about the
device type. We should likely store one or the other but not both, otherwise we
may just risk to create desync without really saving useful info.

Also, this change makes wilc1000-sdio failing to build as module (missing symbol
export on wilc_get_chipid)

[...]

> -	/* select VMM table 0 */
> -	if (val & SEL_VMM_TBL0)
> -		reg |= BIT(5);
> -	/* select VMM table 1 */
> -	if (val & SEL_VMM_TBL1)
> -		reg |= BIT(6);
> -	/* enable VMM */
> -	if (val & EN_VMM)
> -		reg |= BIT(7);
> +	if (wilc->chip == WILC_1000) {

wilc1000 should likely remain the default/fallback ?

[...]

> @@ -1232,10 +1234,7 @@ static int wilc_validate_chipid(struct wilc *wilc)
>  		dev_err(&spi->dev, "Fail cmd read chip id...\n");
>  		return ret;
>  	}
> -	if (!is_wilc1000(chipid)) {
> -		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
> -		return -ENODEV;
> -	}
> +

Instead of dropping any filtering (and then making the function name become
irrelevant), why not ensuring that it is at least either a wilc1000 or a wilc3000 ?

>  	return 0;
>  }
>  
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 533939e71534a..a7cc8c0ea5de4 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -555,7 +555,7 @@ static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
>  	return rqe;
>  }

[...]

> +static int chip_allow_sleep_wilc3000(struct wilc *wilc)
> +{
> +	u32 reg = 0;
> +	int ret;
> +	const struct wilc_hif_func *hif_func = wilc->hif_func;
> +
> +	if (wilc->io_type == WILC_HIF_SDIO) {
> +		ret = hif_func->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
> +		if (ret)
> +			return ret;
> +		ret = hif_func->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
> +					      reg & ~WILC_SDIO_WAKEUP_BIT);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = hif_func->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
> +		if (ret)
> +			return ret;
> +		ret = hif_func->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> +					      reg & ~WILC_SPI_WAKEUP_BIT);
> +		if (ret)
> +			return ret;
>  	}
> +	return 0;
> +}
> +
> +void chip_allow_sleep(struct wilc *wilc)
> +{
> +	if (wilc->chip == WILC_1000)
> +		chip_allow_sleep_wilc1000(wilc);
> +	else
> +		chip_allow_sleep_wilc3000(wilc);
>  }
>  EXPORT_SYMBOL_GPL(chip_allow_sleep);
>  
> -void chip_wakeup(struct wilc *wilc)
> +static void chip_wakeup_wilc1000(struct wilc *wilc)
>  {
>  	u32 ret = 0;
>  	u32 clk_status_val = 0, trials = 0;
> @@ -627,15 +662,15 @@ void chip_wakeup(struct wilc *wilc)
>  	if (wilc->io_type == WILC_HIF_SDIO) {
>  		wakeup_reg = WILC_SDIO_WAKEUP_REG;
>  		wakeup_bit = WILC_SDIO_WAKEUP_BIT;
> -		clk_status_reg = WILC_SDIO_CLK_STATUS_REG;
> -		clk_status_bit = WILC_SDIO_CLK_STATUS_BIT;
> +		clk_status_reg = WILC1000_SDIO_CLK_STATUS_REG;
> +		clk_status_bit = WILC1000_SDIO_CLK_STATUS_BIT;
>  		from_host_to_fw_reg = WILC_SDIO_HOST_TO_FW_REG;
>  		from_host_to_fw_bit = WILC_SDIO_HOST_TO_FW_BIT;
>  	} else {
>  		wakeup_reg = WILC_SPI_WAKEUP_REG;
>  		wakeup_bit = WILC_SPI_WAKEUP_BIT;
> -		clk_status_reg = WILC_SPI_CLK_STATUS_REG;
> -		clk_status_bit = WILC_SPI_CLK_STATUS_BIT;
> +		clk_status_reg = WILC1000_SPI_CLK_STATUS_REG;
> +		clk_status_bit = WILC1000_SPI_CLK_STATUS_BIT;
>  		from_host_to_fw_reg = WILC_SPI_HOST_TO_FW_REG;
>  		from_host_to_fw_bit = WILC_SPI_HOST_TO_FW_BIT;
>  	}
> @@ -674,12 +709,80 @@ void chip_wakeup(struct wilc *wilc)
>  	if (wilc->io_type == WILC_HIF_SPI)
>  		wilc->hif_func->hif_reset(wilc);
>  }
> +
> +static void chip_wakeup_wilc3000(struct wilc *wilc)
> +{
> +	u32 wakeup_reg_val, clk_status_reg_val, trials = 0;
> +	u32 wakeup_reg, wakeup_bit;
> +	u32 clk_status_reg, clk_status_bit;
> +	int wake_seq_trials = 5;
> +	const struct wilc_hif_func *hif_func = wilc->hif_func;
> +
> +	if (wilc->io_type == WILC_HIF_SDIO) {
> +		wakeup_reg = WILC_SDIO_WAKEUP_REG;
> +		wakeup_bit = WILC_SDIO_WAKEUP_BIT;
> +		clk_status_reg = WILC3000_SDIO_CLK_STATUS_REG;
> +		clk_status_bit = WILC3000_SDIO_CLK_STATUS_BIT;
> +	} else {
> +		wakeup_reg = WILC_SPI_WAKEUP_REG;
> +		wakeup_bit = WILC_SPI_WAKEUP_BIT;
> +		clk_status_reg = WILC3000_SPI_CLK_STATUS_REG;
> +		clk_status_bit = WILC3000_SPI_CLK_STATUS_BIT;
> +	}
> +
> +	hif_func->hif_read_reg(wilc, wakeup_reg, &wakeup_reg_val);
> +	do {
> +		hif_func->hif_write_reg(wilc, wakeup_reg, wakeup_reg_val |
> +							  wakeup_bit);
> +		/* Check the clock status */
> +		hif_func->hif_read_reg(wilc, clk_status_reg,
> +				       &clk_status_reg_val);
> +
> +		/* In case of clocks off, wait 1ms, and check it again.
> +		 * if still off, wait for another 1ms, for a total wait of 3ms.
> +		 * If still off, redo the wake up sequence
> +		 */
> +		while ((clk_status_reg_val & clk_status_bit) == 0 &&
> +		       (++trials % 4) != 0) {
> +			/* Wait for the chip to stabilize*/
> +			usleep_range(1000, 1100);
> +
> +			/* Make sure chip is awake. This is an extra step that
> +			 * can be removed later to avoid the bus access
> +			 * overhead
> +			 */
> +			hif_func->hif_read_reg(wilc, clk_status_reg,
> +					       &clk_status_reg_val);
> +		}
> +		/* in case of failure, Reset the wakeup bit to introduce a new
> +		 * edge on the next loop
> +		 */
> +		if ((clk_status_reg_val & clk_status_bit) == 0) {
> +			hif_func->hif_write_reg(wilc, wakeup_reg,
> +						wakeup_reg_val & (~wakeup_bit));
> +			/* added wait before wakeup sequence retry */
> +			usleep_range(200, 300);
> +		}
> +	} while ((clk_status_reg_val & clk_status_bit) == 0 && wake_seq_trials-- > 0);
> +	if (!wake_seq_trials)
> +		dev_err(wilc->dev, "clocks still OFF. Wake up failed\n");
> +}
> +
> +void chip_wakeup(struct wilc *wilc)
> +{
> +	if (wilc->chip == WILC_1000)
> +		chip_wakeup_wilc1000(wilc);
> +	else
> +		chip_wakeup_wilc3000(wilc);
> +}
>  EXPORT_SYMBOL_GPL(chip_wakeup);

This new support makes a few places in wlan.c, netdev.c and in bus files
(sdio.c, spi.c) install (sometimes big) branches on the device type (chip init,
sleep, wakeup, read interrupt, clear interrupt, txq handling, etc), because the
registers are different, the masks are different, the number of involved
registers may not be the same, wilc3000 may need more operations to perform the
same thing... I feel like it will make it harder in the long run to maintain the
driver, especially if some new variants are added later. Those branches tend to
show that some operations in those files are too specific to the targeted
device. I was examining the possibility to start creating device-type specific
files (wilc1000.c, wilc3000.c) and move those operations as "device-specific"
ops. Then wlan/netdev would call those chip-specific ops, which in turn may call
the hif_func ops. It may need some rework in the bus files to fit this new
hierarchy, but it may allow to keep netdev and wlan unaware of the device type,
and since wilc3000 has bluetooth, it may also make it easier to introduce the
corresponding support later. What do you think about it ? Ajay, any opinion on
this ?

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


