Return-Path: <linux-wireless+bounces-35575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC/pNyS98WkHkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:11:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBC491065
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE4F305D6C4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7D3A784E;
	Wed, 29 Apr 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNjpzERF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80B35C1B6;
	Wed, 29 Apr 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450063; cv=none; b=hGIGV2UHiLbuPTzmP9YRaxmR0dbv+Ekb471dkBQBZzpbMMxMBMNxIOGNipgMs07YguPE0HRNMSQaxTmaYIQFSv08K6T+AsnbVWvF1YUCEt0B5eRxJKb/aSREPTofSdzS0PWmvQlVrAbvY1d5xt9xeNtIKb67agdADdO4HupGDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450063; c=relaxed/simple;
	bh=BPtgstPyJu9Z1XyYiv+Qqirlz2ojBbfdDJaNCno6c0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAy/EClWN0Wp4t5f2CCWjJJo8IAS/9KB/acWa2K9eMX2JQL/vpQWr2n9UFPNWyKA+6x1F3A8r8Ud1J9Q8aC5pMnsJro4P02ts8b9iZa3WmNzdpkpE4EN3UkGkwpHUIk+k6lGrccmPfpLDILV1vQQper3BQxVISVi2hKlj8qDtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNjpzERF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8744BC19425;
	Wed, 29 Apr 2026 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777450063;
	bh=BPtgstPyJu9Z1XyYiv+Qqirlz2ojBbfdDJaNCno6c0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qNjpzERFgA7GRrt3yoEzQ93KlfHO4r4qXsOOf6AFpc1HP7dYlsen6xWW+g6ViIsV2
	 BfC2cKTxEWNWm/DdyUJuoNAaglqHUG5gR6MCh+q1TscaCrlZRA5t2APQ6XbSCs2fGS
	 lSUzjRW24WJ1bZJf4trJNpKRCpkSyjrjdBzqjFy9dLIGYQlALweX7nFtP1phi6FhKD
	 RcoBzMz/Zugrf+4cKAzBPRK4NirMen2MaV8ay8GZhtdPS+ivdE3BsoKqwmYdl0wazA
	 2YQrgkHQWa+IbDp/2n73SAqVMsD1RFEVV5xWs2kB8EoYd77NIbYSw32MNDlZQslPGZ
	 2ZfiK1BOS3umw==
Message-ID: <e4a7e9d8-7091-4520-a634-ff0a44eb5139@kernel.org>
Date: Wed, 29 Apr 2026 10:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] p54spi: convert to devicetree
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Bartosz Golaszewski
 <brgl@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Felipe Balbi <balbi@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>
References: <20260427142355.2532714-1-arnd@kernel.org>
 <20260427142355.2532714-4-arnd@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260427142355.2532714-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 76EBC491065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35575-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 27/04/2026 16:23, Arnd Bergmann wrote:
>  
> -	ret = gpio_request(p54spi_gpio_power, "p54spi power");
> -	if (ret < 0) {
> -		dev_err(&priv->spi->dev, "power GPIO request failed: %d", ret);
> +	priv->gpio_powerdown = gpiod_get(&spi->dev, "powerdown", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->gpio_powerdown)) {
> +		ret = PTR_ERR(priv->gpio_powerdown);
> +		dev_err(&priv->spi->dev, "powerdown GPIO request failed: %d", ret);

Binding said it is optional, so this cannot be a failure.

Also, please use ret = dev_err_probe syntax.


>  		goto err_free;
>  	}
>  
> -	ret = gpio_request(p54spi_gpio_irq, "p54spi irq");
> -	if (ret < 0) {
> -		dev_err(&priv->spi->dev, "irq GPIO request failed: %d", ret);
> -		goto err_free_gpio_power;
> -	}
> -
> -	gpio_direction_output(p54spi_gpio_power, 0);
> -	gpio_direction_input(p54spi_gpio_irq);
> -
> -	ret = request_irq(gpio_to_irq(p54spi_gpio_irq),
> -			  p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi",
> -			  priv->spi);
> +	ret = request_irq(spi->irq, p54spi_interrupt, IRQF_NO_AUTOEN, "p54spi", priv->spi);
>  	if (ret < 0) {
>  		dev_err(&priv->spi->dev, "request_irq() failed");
> -		goto err_free_gpio_irq;
> +		goto err_free_gpio_power;
>  	}
>  
> -	irq_set_irq_type(gpio_to_irq(p54spi_gpio_irq), IRQ_TYPE_EDGE_RISING);
>  
>  	INIT_WORK(&priv->work, p54spi_work);
>  	init_completion(&priv->fw_comp);
> @@ -659,11 +636,9 @@ static int p54spi_probe(struct spi_device *spi)
>  
>  err_free_common:
>  	release_firmware(priv->firmware);
> -	free_irq(gpio_to_irq(p54spi_gpio_irq), spi);
> -err_free_gpio_irq:
> -	gpio_free(p54spi_gpio_irq);
> +	free_irq(priv->irq, spi);
>  err_free_gpio_power:
> -	gpio_free(p54spi_gpio_power);
> +	gpiod_put(priv->gpio_powerdown);
>  err_free:
>  	p54_free_common(priv->hw);
>  	return ret;
> @@ -675,10 +650,8 @@ static void p54spi_remove(struct spi_device *spi)
>  
>  	p54_unregister_common(priv->hw);
>  
> -	free_irq(gpio_to_irq(p54spi_gpio_irq), spi);
> -
> -	gpio_free(p54spi_gpio_power);
> -	gpio_free(p54spi_gpio_irq);
> +	free_irq(priv->irq, spi);
> +	gpiod_put(priv->gpio_powerdown);
>  	release_firmware(priv->firmware);
>  
>  	mutex_destroy(&priv->mutex);
> @@ -686,10 +659,19 @@ static void p54spi_remove(struct spi_device *spi)
>  	p54_free_common(priv->hw);
>  }
>  
> +struct of_device_id p54spi_of_ids[] = {

static const

> +	{ .compatible = "cnxt,3110x", },
> +	{ .compatible = "isil,p54spi", },
> +	{ .compatible = "st,stlc4550", },
> +	{ .compatible = "st,stlc4560", },

At least last two devices are then compatible, so this should be
expressed in the binding with fallback and drop stlc4560 here. Maybe all
of them are compatible.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, p54spi_of_ids);
>  
>  static struct spi_driver p54spi_driver = {
>  	.driver = {
>  		.name		= "p54spi",
> +		.of_match_table = p54spi_of_ids,
>  	},


Best regards,
Krzysztof

