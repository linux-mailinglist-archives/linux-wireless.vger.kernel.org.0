Return-Path: <linux-wireless+bounces-37328-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AxTPLFvWH2oQqwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37328-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:23:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C52635288
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jN/ry5oC";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37328-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37328-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4603C30D94FB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75439B979;
	Wed,  3 Jun 2026 07:17:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1039BFE5;
	Wed,  3 Jun 2026 07:17:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471023; cv=none; b=Wn1uWHMK5JzB/1+VH2GIbox2sx8wTWxKpxUQBuzwh1PqHDfZLNgSVVq3XDfgUGw+1fJopYk9GLfkSVKWR2/4BLbjFWoUHx+taiUF9rSLiDa04P95xyNCJottKVZ6JkstYrDisMHexJU/1P8R24+jHp4Lvw+xLgywqTh/xd7RkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471023; c=relaxed/simple;
	bh=Tv6HCRIHKg3T+9QBcnUv7zYmy7M3lPX5MIXOUnJE+yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hNRT5hyIT1Zjz8ZUlmcW1esrutMeKxAyaGcgm/0rDlmn4+4XarFtA7W7LxSoiZWX1R2/8osSCHmGTEMc0lFwMS99QMwH0fzqXtxszRJ1eO0udR4nSysXranGFXWxGglqqAhdeEjid9yVHFEy7ort3xTb/Wrk39GNigEijnnixTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN/ry5oC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBBD1F00893;
	Wed,  3 Jun 2026 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780471022;
	bh=+nWUDLiP30W/RSvphRKxxD5tUXTNQPMjw7/UNGHo4UY=;
	h=Date:From:To:Cc:Subject;
	b=jN/ry5oC4t3CThAXvX5NISEhf5lE0BlIlfC9mer8doqd3j3YryrMRXBVrDRbnCfzI
	 vCi1GQW7s5T+/37zceHZfWUpkY2kZimlqzU8nbQjDNqHCDSxGoioHq/DxKgXa2G1vG
	 tGiQ0/kmRRNn1wSL9jjPWdaM1JJZyJi2RQADFvFXTxW63+weuFdAwEKM6TpQkBI5wh
	 7zYAV625y/9uBg0xaOxTYhHTUYRB1p+AqaigPMFzqwllzI+ah8QeIeBH4f/eXbpVtO
	 eRkold+rb0vXr2tzDLG6eKrJcDmGGzuZToLLnUFZcZPtTPnraSinK6l6c51BN7tKFJ
	 u/f24y3qHKcaw==
Date: Wed, 3 Jun 2026 08:16:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Wireless <linux-wireless@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the wireless tree
Message-ID: <ah_U6xEhq5GSebBc@sirena.org.uk>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	Wireless <linux-wireless@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UDz1/u8MxfU41vlN"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37328-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47C52635288


--UDz1/u8MxfU41vlN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  1b659e979685b ("wifi: mac80211: fix NULL dereference of eht_oper in ieee80211_start_ap()")

is missing a Signed-off-by from its author

--UDz1/u8MxfU41vlN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmof1OoACgkQJNaLcl1U
h9B6QAf/RubJMbmTNInUgIsCqZKNhdqvAW5vTyqejhp5W1aVyZ0dRAwYooAcDR1y
XWHdKHa4YxAzgIOjWVlxRBFVwjfoKCdXQPynQDqrfi4Nyy1o4oLRU9Njw4lAny4a
w1B941m4eTwxBa8JnWjFqaahL8aMfi2CPAXM5wS4kcKfHv3XZM6UUT6MQuGYgzyn
UA04krFqvNzQMykM03cyajLZ+5Gtvb8mwNFpfimAVBB1+h61yacU/LY8wnNbid9r
nU20jEVTcTeZKlsxfqPK47dBq4Eh+VpF9oed5NA+WjNVEU1oUHKrc2gTg5pnvMGu
3GbIShD+KqGau+KFzYFURRIs3OaiPA==
=qxje
-----END PGP SIGNATURE-----

--UDz1/u8MxfU41vlN--

