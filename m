Return-Path: <linux-wireless+bounces-498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C88070B9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0361C20AA6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B5374EA;
	Wed,  6 Dec 2023 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xaLQFagE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F4AC;
	Wed,  6 Dec 2023 05:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9xb/j8079N30XiCpQfsE2XSQRB8MrOJjvILD0qCjplA=;
	t=1701868581; x=1703078181; b=xaLQFagEZqYh1tkDzaYFr8lElv1xj6gKYaOCl34tQDuzj+9
	GXWnOkKrvJAfp/R6yc71cWAoR4TfsFniWYvyDtg896k0KhHQySv4bUwPjfl1Sxyy0b/yUC6cHBirM
	tFB3rFR9B9ljB5loCeut7ilBwFQ12YKtFdBj5t9hqEwYZC1fnnyppx5A0kgNW/rf/7Typa8qtdToU
	vsYWyTXXmrCCRRpgP23d2LUA7gRqJXxK70nxclSu/YaEGMrC3hK0AuPTqB+I2YXDYIpUejcxN1AwZ
	Z2tXEt3kCX1XjkbIoLFHlOsJxmbzhT9jfJFZAgxK9/VX9/tU4nie9zmqOK/z7OXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rArlB-000000004Nm-0dCe;
	Wed, 06 Dec 2023 14:16:17 +0100
Message-ID: <cd25fd96fa391d3c8a5811d995d166cbb0b0efe5.camel@sipsolutions.net>
Subject: Re: [PATCH] net: rfkill: gpio: set GPIO direction
From: Johannes Berg <johannes@sipsolutions.net>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>, Josua Mayer
 <josua@solid-run.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de, stable@vger.kernel.org, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Wed, 06 Dec 2023 14:16:15 +0100
In-Reply-To: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-12-06 at 14:13 +0100, Rouven Czerwinski wrote:
>=20
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct platform_device =
*pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (rfkill->reset_gpio)
> +		ret =3D gpiod_direction_output(rfkill->reset_gpio, true);
> +	if (ret)
> +		return ret;
> +
> +	if (rfkill->shutdown_gpio)
> +		ret =3D gpiod_direction_output(rfkill->shutdown_gpio, true);
> +	if (ret)
> +		return ret;
>=20

That's weird, you need ret to be inside the if. It's even entirely
uninitialized if you don't have ACPI, if you don't have reset/shutdown.

johannes

