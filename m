Return-Path: <linux-wireless+bounces-37485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fwo2Mt9pJmqeWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:06:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B24653614
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=nxlILKUV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37485-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37485-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC8F330138B9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8638888F;
	Mon,  8 Jun 2026 07:02:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9F3876C1;
	Mon,  8 Jun 2026 07:02:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902173; cv=none; b=Cvoz48FwNi6iqO2jWhLfnsL89xy3Qqg7XjEGJZyzU5Dfx6ifwKUW/d2E1QB7gX0J8AZmOATqzpiHPTYGQT6ITMks5VQFysDthibv66H4VXJ0/IdAGXCl+XrnuxXSeYP7MMm9oFKLcR5Lzjkkx4iHxwbHoZR4xOhiMyX3cShfMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902173; c=relaxed/simple;
	bh=wRghMpT235GXEl1TbhyuxwYqE0P/NK7WwDJy9fQ4rjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWtibi3wC8QQC4ZDZWvIES+opIqXDE3rVnneh12wDA3K2eO4wkLf1IG9K19JfCJEWVoh6hw44bO1mYP10CYdrNNmO/nwicdfUmrxo1+CtuCZMfZ9pmpyVITUAjiCU3GdW63HWIDgV/kRSZv42nNiAQ/ZNfa5LKnWQlVVT1WUYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nxlILKUV; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wRghMpT235GXEl1TbhyuxwYqE0P/NK7WwDJy9fQ4rjU=;
	t=1780902170; x=1782111770; b=nxlILKUVOcmYqnvmu5P/FmVlgcXkEqmFjtQXNT0qqaSjHuB
	g5Qvn7JLuE4fY3eYVuv+O8wl/O/tIAqCw5ZoSvFGAPsi+vBaQJIc1uAkF9Pr99nBpFH2R8i+FRTF4
	zfR2cGTE8frx4hQ/oERxnqTDkr4Lht9X60VqzyFr8HG1s8P+P/8FsgaTmOIAGl5KoQYx0RG0BwLSr
	Kd6BgK5jzETHH76vxyd6d1x02KQsMC07IAaC6Y05XiCkprvnSgVx/Pgg71+fC7VD3d3+4/iUFixZW
	XzueKNzx9p+jq0uwf5gzG3i+DbLkHER1yLtaiHYrzkJRO4KkgcBF20yckDVhK41A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWTdt-00000005WkD-41kV;
	Mon, 08 Jun 2026 08:39:26 +0200
Message-ID: <dea3dc8bee50dd5eaa1327fb8ea83658f73d323d.camel@sipsolutions.net>
Subject: Re: [PATCH v12 00/22] wifi: nxpwifi: create nxpwifi to support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de, 
	ulf.hansson@linaro.org
Date: Mon, 08 Jun 2026 08:39:24 +0200
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.chen_1@nxp.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37485-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31B24653614

On Sat, 2026-06-06 at 00:13 +0800, Jeff Chen wrote:
>=20
> Firmware binaries can be obtained from:
> https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwImage=
_IW612_SD/

Are you going to send this for inclusion in linux-firmware with an
appropriate (redistributable) license? I'm not entirely convinced that
the license (that appears to be attached to) the repository is really
one that could be used there?

johannes

