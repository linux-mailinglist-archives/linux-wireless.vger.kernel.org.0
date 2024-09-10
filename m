Return-Path: <linux-wireless+bounces-12753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD596973575
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFDE1C25115
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD818C002;
	Tue, 10 Sep 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="BSKZ3agC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F1C8DF;
	Tue, 10 Sep 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965376; cv=none; b=LsVR8FtQYSWcTe8lH/JmchCilxpwxF4jdsZ/8fb3wX7UQ99qPSnQZxySb5y3S4DJ06Tz/N7UR7CTJnoaDaIQszYGW5GYI6olOHu0FkOBjeUA2t5t8+rIMbvlY8OO34xhOjkfLnT4rsi5JC4bvL7bDt25U0T/Ele6vCCQCCvOD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965376; c=relaxed/simple;
	bh=4h9ugKqamWguH6j/Qqkh5uCQAVj+/GDplf6he6MaF4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h5w3BnxKunl3NAaUOWepOYCJfIkPl66aZYXIxMH+KT7MykSOT8cTIEgyLPRvSfOzBtcSvr/Qh/bNuXv+2UGOgRr6CrVZeftVNz0qmmSn0yW73FfrS0oLvgG1V/MZzfXrMM9MowjQ+LQ0Bn+49CnKofrE5xCDi59Ovovxw5K4sC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=BSKZ3agC; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 65B8AC04EC;
	Tue, 10 Sep 2024 12:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1725965369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4Njp4aZmAUi+ZgiJdMyb8GGh61pN9VCyJUoqbzXl1U=;
	b=BSKZ3agC4GpavxSIHoc/ZoYIB6yBE8Kwp4xzIlpt1EgbCaWjRRucXutcGpi9ZBYNQMkc17
	xZgmGcDOEr/Qw5ikntGCiq2JVvVt4yuNF2bae8oygxsvG4xdbkHGMIXj3dv0FoH3lW7e5E
	Mz2Gs9DWSMPQG9Cu+1uRjf3BEkzqTp9bhYTURDLIBy16p9DUvXaoR4wPrvIAbXkJvySXgM
	tlMkZvsBPl17hgYSSzN8Mtp/iU0bMWjz8Loc5QPLXm0gtx3+LKZFuoVitSQ7L20xgvX09S
	y/k1ahmrogEDp8oZry3tIF8WQ+6Qut7c9rI+QuAGybu5jZs+DA4r74vKxWUAWQ==
Message-ID: <75bfcd83-4b71-4fee-a560-5ca112e6fbb0@datenfreihafen.org>
Date: Tue, 10 Sep 2024 12:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in
 request_irq()
To: Jinjie Ruan <ruanjinjie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, louis.peens@corigine.com,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, chunkeey@googlemail.com,
 kvalo@kernel.org, briannorris@chromium.org, francesco@dolcini.it,
 set_pte_at@outlook.com, damien.lemoal@opensource.wdc.com,
 mpe@ellerman.id.au, horms@kernel.org, yinjun.zhang@corigine.com,
 fei.qin@corigine.com, johannes.berg@intel.com, ryno.swart@corigine.com,
 krzysztof.kozlowski@linaro.org, leitao@debian.org, liuxuenetmail@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, linux-wpan@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
 <20240909133034.1296930-5-ruanjinjie@huawei.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240909133034.1296930-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjie Ruan.

On 9/9/24 3:30 PM, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/net/ieee802154/mcr20a.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 433fb5839203..020d392a98b6 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -1302,16 +1302,13 @@ mcr20a_probe(struct spi_device *spi)
>   		irq_type = IRQF_TRIGGER_FALLING;
>   
>   	ret = devm_request_irq(&spi->dev, spi->irq, mcr20a_irq_isr,
> -			       irq_type, dev_name(&spi->dev), lp);
> +			       irq_type | IRQF_NO_AUTOEN, dev_name(&spi->dev), lp);
>   	if (ret) {
>   		dev_err(&spi->dev, "could not request_irq for mcr20a\n");
>   		ret = -ENODEV;
>   		goto free_dev;
>   	}
>   
> -	/* disable_irq by default and wait for starting hardware */
> -	disable_irq(spi->irq);
> -
>   	ret = ieee802154_register_hw(hw);
>   	if (ret) {
>   		dev_crit(&spi->dev, "ieee802154_register_hw failed\n");


Dave, Eric, Jakub, if you are taking them into net/net-next directly 
here is my ack (and Miquel's review as well).

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt

