Return-Path: <linux-wireless+bounces-35230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNwtC3Ie6Wl+UgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:16:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41044A10C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C6E43010214
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602AC34D907;
	Wed, 22 Apr 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wbETMsIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D935AC0F;
	Wed, 22 Apr 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885142; cv=none; b=E02u/kpnRJDs+3o2FmalVYg0oGYSgxeVXBN3Brequ2JBAq90OzwGNwSwhT2+2qvPgHx1ejQKkoklKJC9wRLefRXial/820oaIIbtxqqRzf+H0pVQGj6nxxkEbX7/UdwQiMAABaVn+cngWnS08DSOaHmDAJuKqM64YK7P1h2EyfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885142; c=relaxed/simple;
	bh=CHSbAdLxap8U/87UGwfGv0+Bd+7Z8CMJ6KvuzJDmVEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPSYDs/uyGHcZPEuML6iMpw2Z6LFWfb0v3VFTaY93b6QNuQOOVsOHrKZqgNEhCegXhYUzE+RZO6M41iOF452eGxtnTcDjZRin2czsx3KXyncQm4Gl5fIz4soq8q+uA4p1ideCZFRpeDLMKGM1/1ELx1nEu+O78THRiTpNUHzyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wbETMsIz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=94lgLNY96ah+G3TZGHsgMcXD3COQvY/pKYXue63uduU=;
	t=1776885137; x=1778094737; b=wbETMsIzC5oemkbkb5G7Z3wkTd/xcyZAZ0e/2wJfm/Tz0kp
	SdXYq8zdYaachTOy493K32lDy2m+7Cv53/3NANLr4tGeaxekS0vbTFI/DzcNxGlll4clFY9/e0bOz
	lonAQhVLN9JxHL8NOH7e1fWKhBnfCxhL1bFdtPq/PbVTzz6KW3PfH2c7ynt8+KRTN6TVCftKQLFfH
	nL5QD62wNysaYpeVbhtULSlqUXul6xgfTJ17NAlPP4G6i/2B1AOg+ZMkx16r+Cwx3qumxkJ9GcqLc
	o3BALssaSRrSQ6hSjcNohnCufppq6mmQWHYNBJBo4T37wcOKHWylhMGBZx6J7UHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFczc-00000006Sy1-2F9u;
	Wed, 22 Apr 2026 21:12:12 +0200
Message-ID: <2e20cb23d2d156963c2b687c4c51635e5eec2c7c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware
 sta_count in station list response
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Tristan Madani
 <tristmd@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Tristan
 Madani <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 21:12:11 +0200
In-Reply-To: <aekS72ESOUlnqGIo@google.com> (sfid-20260422_202701_581637_5690F81D)
References: <20260421134938.331334-1-tristmd@gmail.com>
	 <20260421134938.331334-4-tristmd@gmail.com> <aekS72ESOUlnqGIo@google.com>
	 (sfid-20260422_202701_581637_5690F81D)
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[chromium.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35230-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F41044A10C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 11:26 -0700, Brian Norris wrote:
>=20
> > +	u16 resp_size =3D le16_to_cpu(resp->size);
> > +	u16 count =3D le16_to_cpu(sta_list->sta_count);
> > +	u16 max_count;
> > =20
> > -	for (i =3D 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
> > +	if (resp_size < sizeof(*resp) - sizeof(resp->params) + sizeof(*sta_li=
st))
> > +		return -EINVAL;
> > +	max_count =3D (resp_size - sizeof(*resp) + sizeof(resp->params) -
> > +		     sizeof(*sta_list)) / sizeof(*sta_info);
>=20
> The repeated arithmetic is a bit weird, but I'm not sure if it'd
> actually be better to stash it in its own variable. Seems good enough I
> suppose.

I think it might be simpler if instead trying to limit:

> > +	count =3D min(count, max_count);

it'd just check the needed length based on the given count, and reject
anything above that?

Also, the whole sizeof(*resp) - sizeof(resp->params) etc. shouldn't be
there, that should just be

	offsetofend(resp, sta_list.tlv)

and then suddenly it becomes _way_ simpler:

	if (resp_size < offsetofend(resp, sta_list.tlv))
		return -EINVAL;
	if (resp_size < offsetofend(resp, sta_list.tlv) +
			sizeof(*sta_info) * le16_to_cpu(sta_.list->sta_count))
		return -EINVAL;

But regardless, I question the sanity of checking the size against the
size the firmware said the whole thing was going to be, rather than
checking against the actual buffer size ...

johannes

