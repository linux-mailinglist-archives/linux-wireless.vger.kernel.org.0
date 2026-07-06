Return-Path: <linux-wireless+bounces-38665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PO37D6x/S2qiSQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:13:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564470EF66
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:12:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Su6QmA+4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38665-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38665-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3302304231A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8A422543;
	Mon,  6 Jul 2026 09:56:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10485434E50
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 09:56:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331789; cv=none; b=hHuK8fUXY2lgz2lgS4xBqN8/uAWb76LCCIlY4bDBs1CM3yj6wrOIDpG0phFmblxXuILrNnsIkzWbl93YTUmBzlvhgIboqWWMp3nH5J1LDcQ1ZRp7vT5BFzLA2iEtrlknzXQlGjuasPOcABe83+l+VvD3ZGMDLfMtC8Fgq7WHZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331789; c=relaxed/simple;
	bh=eENoCQXIymb1FX7G0TZzWrzmNSnvnJFIBqcP19wClZk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2uhI4ipt1cgmTbaHxANf7Beikhi/AwahlNeMC6qZgv3wu2j6jJeZJUtWr0YHp2QQQkst9xwb6Ltk6zdqCePi7gItJusCq8ocFQMntBBSu0WO1wQAf+ZKIifjr1NM7p6sCsBxjCAbaJrHogk6qKl4oamVCRDLPnc7/BuMNctqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su6QmA+4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BEB1F00ADE
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331785;
	bh=mvohprdb7yYHFpRfAfE7wCAqKcQVAUnlIPGzv9lPscM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Su6QmA+4j5hjr4j7jhc0GUVYNGV1Sd8dMRVYzwPGySS3lXXPrmDHWZ+ZFIgJPmknW
	 /yegVrb0o2DzYz1N2m5SqKouQedeLEvy2rrOErEIO+Rl0mrQab1esD8edy8eL9AQjO
	 DPxzFO2QfYjoRA9ygCp52oiq1fqrkKzi6OMJDNx7W8eJk3ZIzxgINUABRXDmpiC1gI
	 BU5cuTFB1fl3U8LlnVanwAz6Nu08HNK9FoM8+8g1KjqCxIXw2RLUtbO2BtyGQwY1yp
	 lz4WArEWODfFCrvSo8CYg/XZ21c0MD0Ih1Ko2avF0niRb3rCXUJCrwEs6Cxm11LI2f
	 fj1tDjb1rD+vQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39b03d41976so23036601fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 02:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqV4qKyxGyK/0GzxCtU5NxXCpruD6ih8xl76m94Y8Y4HDhC0AIoZjHZNSYRX8iR2U0Xok4d7qmXKFtPsic4ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyioW44q6x5Tn+WUwuWWsKUWKpFc3KfvjdHgSRp0ouvnFRZ6f8J
	Uwi4094bbEzjqOIsgBUEgkEcxOSY9Grl3H725+aPyml8enUDGYg1PmRkQ2ktzA7Xb+ErwwhS0xz
	Sltj/vt4xy4/WoIxMGdMM9whY3NDq63KJMFtUiXCbvQ==
X-Received: by 2002:a05:651c:2227:b0:399:87c9:459a with SMTP id
 38308e7fff4ca-39b53cd5cf2mr19262101fa.9.1783331783978; Mon, 06 Jul 2026
 02:56:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 05:56:22 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 05:56:22 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260704-b4-bcm47xx-swnode-v1-1-730d59340237@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-b4-bcm47xx-swnode-v1-0-730d59340237@gmail.com> <20260704-b4-bcm47xx-swnode-v1-1-730d59340237@gmail.com>
Date: Mon, 6 Jul 2026 05:56:22 -0400
X-Gmail-Original-Message-ID: <CAMRc=McxZ3GQLJabxtyUCUoAEWBX0czSSRFYYkiPBeQNZJpFkg@mail.gmail.com>
X-Gm-Features: AVVi8CdPffyo_M9BGr1tovBbAAGtZnCO-dyCb3YY--piU-sCDUsCzgdujNxKHbc
Message-ID: <CAMRc=McxZ3GQLJabxtyUCUoAEWBX0czSSRFYYkiPBeQNZJpFkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bcma: gpio: Add and register software node for GPIO controller
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Michael Buesch <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38665-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,vger.kernel.org,gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3564470EF66

On Sun, 5 Jul 2026 07:25:08 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> We want to convert the legacy gpio-keys platform device on BCM47XX
> boards to use software nodes. To do this properly and allow
> referencing the GPIO controller by address rather than relying on
> name-based matching (which is being removed from the gpiolib core),
> we need to associate the GPIO controller with a software node.
>
> Introduce bcma_gpio_swnode, register it if the device does not
> already have a firmware node, and associate it with the gpio_chip.
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/bcma/driver_gpio.c | 17 ++++++++++++++++-
>  include/linux/bcma/bcma.h  |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
> index 658c7e2ac8bf..0dad8d6dbe5a 100644
> --- a/drivers/bcma/driver_gpio.c
> +++ b/drivers/bcma/driver_gpio.c
> @@ -19,6 +19,11 @@
>
>  #define BCMA_GPIO_MAX_PINS	32
>
> +const struct software_node bcma_gpio_swnode = {
> +	.name = "bcma-gpio",
> +};
> +EXPORT_SYMBOL_GPL(bcma_gpio_swnode);
> +
>  static int bcma_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
>  {
>  	struct bcma_drv_cc *cc = gpiochip_get_data(chip);
> @@ -190,7 +195,15 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>  	chip->direction_input	= bcma_gpio_direction_input;
>  	chip->direction_output	= bcma_gpio_direction_output;
>  	chip->parent		= bus->dev;
> -	chip->fwnode		= dev_fwnode(&cc->core->dev);
> +
> +	if (!dev_fwnode(&cc->core->dev)) {
> +		err = software_node_register(&bcma_gpio_swnode);
> +		if (err)
> +			return err;
> +		chip->fwnode = software_node_fwnode(&bcma_gpio_swnode);
> +	} else {
> +		chip->fwnode = dev_fwnode(&cc->core->dev);
> +	}
>
>  	switch (bus->chipinfo.id) {
>  	case BCMA_CHIP_ID_BCM4707:
> @@ -234,5 +247,7 @@ int bcma_gpio_unregister(struct bcma_drv_cc *cc)
>  {
>  	bcma_gpio_irq_exit(cc);
>  	gpiochip_remove(&cc->gpio);
> +	if (cc->gpio.fwnode && is_software_node(cc->gpio.fwnode))
> +		software_node_unregister(&bcma_gpio_swnode);
>  	return 0;
>  }
> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
> index f02cb3909375..aa88c2d64bfb 100644
> --- a/include/linux/bcma/bcma.h
> +++ b/include/linux/bcma/bcma.h
> @@ -486,4 +486,7 @@ extern u32 bcma_core_dma_translation(struct bcma_device *core);
>
>  extern unsigned int bcma_core_irq(struct bcma_device *core, int num);
>
> +struct software_node;

Maybe move the forward declaration to the top of the file as is customary?

> +extern const struct software_node bcma_gpio_swnode;
> +
>  #endif /* LINUX_BCMA_H_ */
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
>

Bart

