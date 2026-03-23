Return-Path: <linux-wireless+bounces-33733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF1xGvebwWmFUAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:00:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AC2FCC43
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A81D30EAEA4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070423DCD9A;
	Mon, 23 Mar 2026 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf3lvA+G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649053DBD59;
	Mon, 23 Mar 2026 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294651; cv=none; b=RblQWd9zpUzAhWzs4THcLZKm1TjTSB5GuBAJcmSGPhciLht3LWQiypzIe0SjmfZBugBLcKSQwrzSu6nsVWp3f3p+bZEdGypk1d8y04Z83w07eB2sQa94+aDz4oi1YnayFAypo+gabGruq01/VwO9PS+ZqhnaBY/dqh/OcHLiyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294651; c=relaxed/simple;
	bh=YNOY/10bL1EV7q2Imm4uWe0CYApalti2dt5cIVqYu88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJNdNussuP8b1duWatQtLvC0mtBHfg1nkT9uTv22gHk1h9q++AQI/FzV+Pse7IGAZfv5Av1Pfa0ISIX1tqrNvnQS/Z+nyt2MqgMvHWiMhR92jTgGnFlFnVEYPEZ1jXwhyYE9ksdFpUqEJJNzW2nVaOXvdkhgHdW/W6EoNTRYlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf3lvA+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6F8C4CEF7;
	Mon, 23 Mar 2026 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294651;
	bh=YNOY/10bL1EV7q2Imm4uWe0CYApalti2dt5cIVqYu88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf3lvA+GH/GQJEW785Yo559nDoXleT8uPH40hxJfta5Zz2n/wmJIYAPsSBHWs/par
	 SNch8HOXTjI3xocXCxzZSyg4lUavveInbw5bpnX89woONwx5Jnf5SnjCkKb8EIVxTC
	 /IYKO2SYn11ENt2U4n7aSemuvRok2VgCekr2hMFYb0k2z35fOtrp96Q/ziP+wS23k+
	 U79sYg+3OTnESUCQ95yTcLRiKERECazxOoZqXJCbelhVBDq4DnthtOy28EP8omsGLc
	 rcwzYGmbU6GqaNp3xmuCIKDuxl+38SyZ/Vkl6dumETkOzvyKagwtqH8ZBYLOAG+vdb
	 v03QCoJU3zQcQ==
Date: Mon, 23 Mar 2026 19:37:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 8/9] dt-bindings: net: wireless: brcm: Add compatible
 for bcm43752
Message-ID: <20260323-hardhat-bladder-0c83339de3bd@spud>
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr>
 <20260323-add-emmc-t7-vim4-v3-8-5159d90a984c@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LJrZXED2O+23fWg"
Content-Disposition: inline
In-Reply-To: <20260323-add-emmc-t7-vim4-v3-8-5159d90a984c@aliel.fr>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33733-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 088AC2FCC43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--8LJrZXED2O+23fWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:55:33AM +0100, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8LJrZXED2O+23fWg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGWdQAKCRB4tDGHoIJi
0mLYAQDKVk2X94u3DdOJf1xVZS1DjAAOaqRhxQmCavFb8iljzgD/a7q4+h0ExxYk
1S35bjSvl2V4D0hADEYDx1qRaOas3QQ=
=yoc+
-----END PGP SIGNATURE-----

--8LJrZXED2O+23fWg--

