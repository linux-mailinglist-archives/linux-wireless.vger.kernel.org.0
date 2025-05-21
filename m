Return-Path: <linux-wireless+bounces-23223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C8ABF264
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5436A4E34E4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B325E83F;
	Wed, 21 May 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbS0oiJC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240A233D7C;
	Wed, 21 May 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825683; cv=none; b=U9X9/qldcYil0umgLK+wPRhaejM7ZOz0I7tFHFdj1BiF01iSA9qjUqEvJVx4T+utIJRTuCPr7NLRRM0t3QgEGzJEFoIV6lN2EWwNl6jjG7apmI7jK5vesZlcZSLsE6xaWq1gq3wLI/sq0U4ZdyDeQorU1eKTi2OV6Flt6OGoZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825683; c=relaxed/simple;
	bh=SgqtN2QJnSYj697kaLFqHOFNfE6uupsWuUcmLGOP5so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCEtEk1bVMAzc3bzBxUHKaMzjk/Mi0PugaLDF0+zANlDD1AI9ORQOfrKm9PgkrGy+veijrxNOop7givze2Vk6yuFu8UVQC1UTqemgbg1SkePQao2feuB9Rke18KxcEXdOJ2Iqkgg5/mpeC7w3p/+Ruvv3QprDBxDsaph8SjYXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbS0oiJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70558C4CEE4;
	Wed, 21 May 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747825683;
	bh=SgqtN2QJnSYj697kaLFqHOFNfE6uupsWuUcmLGOP5so=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZbS0oiJCCpnsbwyLezGXZdVcbEifd/2JL8ymn24pJ3jTf85SDaNN+ELcHmCVY0LNx
	 5+QPHIskaSE+iDB8Yqg0/DwTeQYHSxUJPeanhfwBFNgKh7VkF/vPOrSiopcpLNoveJ
	 /shH29htC61uCJFvL4eQFs4T6OYngtuVaASB7ezNcSP89GY+Q0ltdkJVcmWgttVYzO
	 avvu7/0SSR1M237y3FKe8l79rf402WFGqjClkR4F1EgdtZzJXV4E66mZOdmbYoxerT
	 5Q1MEHqszcJ6qM2MI/33r8g9Kwz+PDApuj0O93W2T12z8Wwx9s0Exgrv6yQq8RduYu
	 W/xhzaCj31Aaw==
Message-ID: <5de13266-d6d4-4497-8913-e442080702ed@kernel.org>
Date: Wed, 21 May 2025 13:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath9k: ahb: replace id_table with of
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250521021557.666611-1-rosenp@gmail.com>
 <20250521021557.666611-4-rosenp@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250521021557.666611-4-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 04:15, Rosen Penev wrote:
> -		.name = "qca955x_wmac",
> -		.driver_data = AR9300_DEVID_QCA955X,
> -	},
> -	{
> -		.name = "qca953x_wmac",
> -		.driver_data = AR9300_DEVID_AR953X,
> -	},
> -	{
> -		.name = "qca956x_wmac",
> -		.driver_data = AR9300_DEVID_QCA956X,
> -	},
> +static const struct of_device_id ath9k_of_match_table[] = {
> +	{ .compatible = "qca,ar9130-wmac", .data = (void *)AR5416_AR9100_DEVID },
> +	{ .compatible = "qca,ar9330-wmac", .data = (void *)AR9300_DEVID_AR9330 },
> +	{ .compatible = "qca,ar9340-wmac", .data = (void *)AR9300_DEVID_AR9340 },
> +	{ .compatible = "qca,qca9530-wmac", .data = (void *)AR9300_DEVID_AR953X },
> +	{ .compatible = "qca,qca9550-wmac", .data = (void *)AR9300_DEVID_QCA955X },
> +	{ .compatible = "qca,qca9560-wmac", .data = (void *)AR9300_DEVID_QCA956X },

Undocumented ABI.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.


>  	{},
>  };
>  
> @@ -72,20 +55,16 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
>  
>  static int ath_ahb_probe(struct platform_device *pdev)
>  {
> -	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	const struct of_device_id *match;
>  	struct ieee80211_hw *hw;
>  	struct ath_softc *sc;
>  	struct ath_hw *ah;
>  	void __iomem *mem;
>  	char hw_name[64];
> +	u16 dev_id;
>  	int irq;
>  	int ret;
>  
> -	if (!dev_get_platdata(&pdev->dev)) {
> -		dev_err(&pdev->dev, "no platform data specified\n");
> -		return -EINVAL;
> -	}
> -
>  	mem = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mem)) {
>  		dev_err(&pdev->dev, "ioremap failed\n");
> @@ -118,7 +97,9 @@ static int ath_ahb_probe(struct platform_device *pdev)
>  		goto err_free_hw;
>  	}
>  
> -	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
> +	match = of_match_device(ath9k_of_match_table, &pdev->dev);

There is a wrapper for getting data, use it.

> +	dev_id = (uintptr_t)match->data;

And dev_id is enum? Then you want kernel_ulong_t.




Best regards,
Krzysztof

