Return-Path: <linux-wireless+bounces-37348-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qMa8BH0eIGqVwAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37348-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:30:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A783637862
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=keEAZASF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37348-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37348-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DC5E314999B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF349472782;
	Wed,  3 Jun 2026 12:10:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D946AF37;
	Wed,  3 Jun 2026 12:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488613; cv=none; b=rAPvN3ZYeEm7YmSlcGLrZMOQ68ZXXUZ3PY+R4NOC6M8ukXg4Fq3WJXjRq44SaXlTGgnlvylKdRACxhlHHJ5lcCoGWRbLxtbxd+Ab+T2WeEwmqM8AsHfnQ26ZxNJlMQ5Ken1dX/JCf7uAgUQ/CrOitfCoyLSgCICtG4Ghrwc0jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488613; c=relaxed/simple;
	bh=E53t0GX/q0rfd2pSXpToIBYHwBQUqiT01aMUKreh3Jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edRF+xowYZNhQabj0dXRDKDyMh0j3FjUY0bmGh1BCUnSkx7vM+QENxYQykSmBmnkHAb7mid8XkdR4pcFJlODk67f8Mw52JryRgrB7KwU0YHZ4O6aAjsuj3Cwai7Q1YVjSYBpsUVlLhtRuREweJNgHu/9BZtusFax5ObvVPHOACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=keEAZASF; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+PlzdCER/RcjA0HQ3AgtKopayR3MXsHpT+3IgIX4iOI=;
	t=1780488612; x=1781698212; b=keEAZASFmyNChkK4Q6g2K76nZgLQAiaZZNnZx+hczgaUs8/
	xp8GEoH+fP08CGxro8wWlojDFOfCz9nK2vvepIiewV2tf6NOCTVOG9+xl10g0qjm+4OoUQ8Mc3iQf
	dh62zPgKn8vOMQAjTsGzEE6IxJjcumXJQ6Q7m1ljAdSL6kennVsyqeai2i14Ysku4UxC9FmIADd2d
	pgsJyW6ka1+5V8GGj9cHwyP7JptJyyplLDZjCmVTkTGGkdZZuHeRAvaKNUn8/PkTZ2yd2HiCCCWvH
	Cdr3QLF1DSgZwvRCEBaY+i41uce/W320JMS7g1M8snvJ9h0If2t5Db41Ikb6lAfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUkQD-0000000H6do-3qUU;
	Wed, 03 Jun 2026 14:10:10 +0200
Message-ID: <978c9a11cf836680b1fd9365f3b90f028ddf5372.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Oscar Alfonso Diaz
	 <oscar.alfonso.diaz@gmail.com>, fjhhz1997@gmail.com
Date: Wed, 03 Jun 2026 14:10:09 +0200
In-Reply-To: <20260519235713.49109-2-lucid_duck@justthetip.ca>
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37348-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucid_duck@justthetip.ca,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:oscar.alfonso.diaz@gmail.com,m:fjhhz1997@gmail.com,m:oscaralfonsodiaz@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A783637862

On Tue, 2026-05-19 at 16:57 -0700, Devin Wittmayer wrote:
>=20
> Cc: stable@vger.kernel.org # 6.9+

No. It's known to crash drivers on some versions, so it should
explicitly opt out of stable by

Cc: <stable+noautosel@kernel.org> # causes some older drivers to crash


> -	if (chanctx_conf)
> +	if (chanctx_conf) {
>  		chandef =3D &chanctx_conf->def;
> -	else if (local->emulate_chanctx)
> -		chandef =3D &local->hw.conf.chandef;
> -	else
> -		goto fail_rcu;
> +	} else {
> +		struct ieee80211_chanctx *ctx;
> +
> +		ctx =3D list_first_or_null_rcu(&local->chanctx_list,
> +					     struct ieee80211_chanctx, list);
> +		if (!ctx ||
> +		    rcu_access_pointer(ctx->list.next) !=3D &local->chanctx_list)
> +			goto fail_rcu;

This results in a sparse warning, maybe my loop approach was better
after all.

johannes

