Return-Path: <linux-wireless+bounces-38681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6KwIm+yS2rPYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:49:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA47117D7
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:49:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FmTW4gq6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38681-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38681-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A433318431B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBF423799;
	Mon,  6 Jul 2026 12:08:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B13033F5;
	Mon,  6 Jul 2026 12:08:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339715; cv=none; b=nPRp/vG+RSl+YZvMdsqtw287cPFL/f6uuTLctf++KPAQBQ76Lqa5ucGN1MXggv1qHgeSZcsnRU1szSdpCjHy6hCxSNKN9ylc4WmzWqZyNKuNUra41SFcAwikzIzYBPr49H2gdoJ4+eOI1Ct6gI0ZHyRa64Koa/JBGe7QO4dTaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339715; c=relaxed/simple;
	bh=uB3HF3lokezskor+Db7VUtdp2pkQLE+PkzjxyYapK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FuhTDr41ZvnL3mdcPaXY+LEAwg3JNMKFIs3CcxJuKXdyIhF5l2n9R4S/VFiJFn96RlwRtWd3xMtq7VeoFdKhPb5reC56zt6Oj/DdCOQyhcdjClPmq0KlDt7zj1NE6khsTu4SQ0vAnHFlwwekjUhojcf1J5EwNNuoVUrlNGgFv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmTW4gq6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D83E1F000E9;
	Mon,  6 Jul 2026 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783339714;
	bh=PAxzJfr/8WC9bfBeHItPe09+0OJRAW/8N54/h+mUpQc=;
	h=Date:From:To:Cc:Subject;
	b=FmTW4gq63FRkHNpl5kdZyv/6TZvoVsac3bTA0esVgdGuzTm4wRYRwgFsBMjStlkOQ
	 GzV/cAnKHRe76ygepAHtQUjsYGaQade6CO6odvLjuXRIySHhDAlQZjvDfHOptL5n2D
	 syA7KjDrVBF2xgDxu4HkpE5azOlfPfOSn6+7VrCI5QqNnTQilq1f4iiox/ahN2o/dx
	 s+ODtNmVjmEcjz2sgz93cKp5KN/P8CLw3ms+Jsju9S/yAGJsUZpH7JJzr24XIV3/3b
	 rpj+sdSYriMBdn7S7G6NOcSZ9w8wAJ5iVOUg5car/UPqUcSZObtV6kkej0SMHU9QkT
	 vOhPc13EPWlEw==
Date: Mon, 6 Jul 2026 13:08:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Wireless <linux-wireless@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the wireless tree
Message-ID: <akuavl61ipORt5b0@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="DIzVpnLYhWxdCOJQ"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38681-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9AA47117D7


--DIzVpnLYhWxdCOJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  e4fa2545a610d ("wifi: cfg80211: cancel sched scan results work on unregister")

is missing a Signed-off-by from its committer

--DIzVpnLYhWxdCOJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLmr0ACgkQJNaLcl1U
h9DJ3Qf8CexnQJ2Hn9DMEG2s3wbMItHI8VHv1oPe4VUYZ+ke+S/U0Sx8tqquk+If
2wLETy8t2gNG8ToUvCkTMqLBeeywV+Es2QsEO39JrDCpCLqL1+rVKNgXFlY7qEaA
56f+R4Th7k/u7b423d5fiNjj2zMJ66BwI1ZWt5zzKHuQZPGO3Y7+0Q/iHkVvWpTf
4mwwPnU4pnjfkNLVrJForv9ItJjBv2Y+ctJDkkuYelYagWjx4i6hDjCsMdI9joa2
O10WHXpoMiBhPVAm/UBq2CnLSvl43zDeTBfAiS7iDg+OdJkfwn/6V9SP1OBTpVpg
fhaFbcHNqLSllYXMtWrnp2sudf2c1g==
=Nlf+
-----END PGP SIGNATURE-----

--DIzVpnLYhWxdCOJQ--

