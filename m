Return-Path: <linux-wireless+bounces-37335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MDisGiX0H2qytAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:30:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EF6362B5
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37335-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37335-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340943054F6F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310B3FBB79;
	Wed,  3 Jun 2026 09:28:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA03A1D07
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 09:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478899; cv=none; b=qri5IUUmAFHRCl7fc6RKt4y0ALqJmxXSFFXI2bD5pFAjHs7EUqtJNN2rJyNIK+zj9foTidEqTswPmpf/nvOQfN8te1cxI0tUK5KnTs78wYqXICMGmgDXab4ncBRVgvv746p2eD5lgVqSNFwbPd3PVGjYM4tbuP+OXqFiIZEG5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478899; c=relaxed/simple;
	bh=0INONot60+NB/3Y6SrZWLNmW13aQx5ky62mxcs8WEoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ijl6eZJ8GjQtd6h7kkKCLHbwJ0mT1OCWZgXbNC7BAB7dkBf2JwReDYuW7EfwSIvVnpOyhL8vApmmwLnwFigV8eB0Nh/dkggNReG1tUZaPW4V+CCfkVqJS4RphRapyEAK7WcZQ/FGIfrLvDIVdX8XRgTcdPK0cUhuu+FpKFPFDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUhtT-0002Zh-Sg; Wed, 03 Jun 2026 11:28:11 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUhtT-000tGs-0y;
	Wed, 03 Jun 2026 11:28:11 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUhtT-000000004kG-0vVD;
	Wed, 03 Jun 2026 11:28:11 +0200
Message-ID: <67d859a23c788e2d74606c9be65cf2114ef45ad2.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] bus: add BCM6362 on-chip WLAN SHIM bridge driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Alessio Ferri <alessio.ferri@mythread.it>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
	 <zajec5@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
	 <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 03 Jun 2026 11:28:11 +0200
In-Reply-To: <20260529-add-bcm6362-wlan-v1-4-722242777f58@gmail.com>
References: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
	 <20260529-add-bcm6362-wlan-v1-4-722242777f58@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37335-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:alessio.ferri@mythread.it,m:zajec5@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[mythread.it,gmail.com,kernel.org,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[p.zabel@pengutronix.de,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mythread.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:from_mime,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091EF6362B5

On Fr, 2026-05-29 at 02:06 +0200, Alessio Ferri wrote:
> Add the bridge driver that brings up the BCM6362 on-chip WLAN SHIM
> and then populates a brcm,bus-axi child whose backplane is
> enumerated by drivers/bcma/host_soc.c.
>=20
> Add myself as MANTAINER for this shim.
>
[...]
>=20
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
> ---
>  MAINTAINERS                     |   7 ++
>  drivers/bus/Kconfig             |  13 +++
>  drivers/bus/Makefile            |   1 +
>  drivers/bus/bcm6362-wlan-shim.c | 252 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 273 insertions(+)
>=20
[...]
> diff --git a/drivers/bus/bcm6362-wlan-shim.c b/drivers/bus/bcm6362-wlan-s=
him.c
> new file mode 100644
> index 000000000000..a2de03cf8ff7
> --- /dev/null
> +++ b/drivers/bus/bcm6362-wlan-shim.c
> @@ -0,0 +1,252 @@
[...]
> +static int bcm6362_wlan_bringup(struct bcm6362_wlan *priv)
> +{
> +	int ret;
> +
> +	dev_info(priv->dev, "bring-up: start\n");

Too verbose.

> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(priv->dev, "clk_prepare_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +	dev_info(priv->dev, "bring-up: clock enabled, rate=3D%lu Hz\n",
> +		 clk_get_rate(priv->clk));
> +	mdelay(10);

Why is this a delay instead of a sleep? Why is it there at all?
Prefer using msleep() or fsleep() if possible.

> +
> +	/* Reset toggle (brcm,bcm6345-reset hides the active-low softResetB
> +	 * encoding, so assert/deassert read naturally here).
> +	 */
> +	reset_control_assert(priv->rst_shim_ubus);
> +	reset_control_assert(priv->rst_shim);
> +	mdelay(1);
> +	reset_control_deassert(priv->rst_shim_ubus);
> +	reset_control_deassert(priv->rst_shim);

Switch deassert order for consistency with teardown, if possible.
Or use reset_control_bulk_(de)assert() API.

[...]

> +static int bcm6362_wlan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct of_dev_auxdata auxdata[2];
> +	struct bcm6362_wlan *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev =3D dev;
> +
> +	priv->shim =3D devm_platform_ioremap_resource_byname(pdev, "shim");
> +	if (IS_ERR(priv->shim))
> +		return PTR_ERR(priv->shim);
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->rst_shim =3D devm_reset_control_get_exclusive(dev, "shim");
> +	if (IS_ERR(priv->rst_shim))
> +		return PTR_ERR(priv->rst_shim);
> +
> +	priv->rst_shim_ubus =3D devm_reset_control_get_exclusive(dev,
> +							       "shim-ubus");
> +	if (IS_ERR(priv->rst_shim_ubus))
> +		return PTR_ERR(priv->rst_shim_ubus);

Consider using devm_reset_control_bulk_get_exclusive().

regards
Philipp

