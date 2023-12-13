Return-Path: <linux-wireless+bounces-499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0668070CD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B9AB20D9C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B7381AB;
	Wed,  6 Dec 2023 13:24:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883790
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 05:24:20 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <r.czerwinski@pengutronix.de>)
	id 1rArsv-0002sd-JQ; Wed, 06 Dec 2023 14:24:17 +0100
Message-ID: <6e3049e37b00e2e5a5f02bff7b75d6c9282973b5.camel@pengutronix.de>
Subject: Re: [PATCH] net: rfkill: gpio: set GPIO direction
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>, Josua Mayer
 <josua@solid-run.com>,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Date: Wed, 06 Dec 2023 14:24:16 +0100
In-Reply-To: <cd25fd96fa391d3c8a5811d995d166cbb0b0efe5.camel@sipsolutions.net>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
	 <cd25fd96fa391d3c8a5811d995d166cbb0b0efe5.camel@sipsolutions.net>
Autocrypt: addr=r.czerwinski@pengutronix.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Johannes,

On Wed, 2023-12-06 at 14:16 +0100, Johannes Berg wrote:
> On Wed, 2023-12-06 at 14:13 +0100, Rouven Czerwinski wrote:
> >=20
> > +++ b/net/rfkill/rfkill-gpio.c
> > @@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct
> > platform_device *pdev)
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > =C2=A0
> > +	if (rfkill->reset_gpio)
> > +		ret =3D gpiod_direction_output(rfkill->reset_gpio,
> > true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (rfkill->shutdown_gpio)
> > +		ret =3D gpiod_direction_output(rfkill-
> > >shutdown_gpio, true);
> > +	if (ret)
> > +		return ret;
> >=20
>=20
> That's weird, you need ret to be inside the if. It's even entirely
> uninitialized if you don't have ACPI, if you don't have
> reset/shutdown.

Thanks for the review, you are totally right, I didn't look at the ret
initialization. I moved it inside the if for v2.

Thanks,
Rouven

