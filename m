Return-Path: <linux-wireless+bounces-31688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULSOCOTXimnrOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 08:01:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271A117997
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 08:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2916C3006B39
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99917BB21;
	Tue, 10 Feb 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="suIVVqXo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30F32E757
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706906; cv=none; b=jAXOqO7qbWA/e4U0bR4oTiVExHYULGt4MUwJCjwTkRRkyPC+gL8U83uCZSCseqjrTSShxmzAfTYP1XeOcUkvLT9joPE3j1Qed3+1VxUYxexUSg6BhrSM5w91UKzXfjhKhnFt+jRABV5MPENo4A9NmAoiOXhqFt0y9cVcf52EWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706906; c=relaxed/simple;
	bh=DhkZpMg4rPXm+50sOBEbIlI+iu7Ka30oqoUPXuT4Rgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JneG39gE7iV1SuCSONJDAO4YdTJN2Mgfe6t9+r+GAWiiUZ1nyhnpHmsT00ARPvGtIGMcR6PKhPfSBIiysl7IytTMpABcD64Hd1eVyxeiavLSDpBcb+kwN2PgFFdlzPeKQ3ZrzTrBPBm2dcExnzZ0boEqFL+OnnQgzKSA7Hotg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=suIVVqXo; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id DCE6C1FDD2;
	Tue, 10 Feb 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1770706902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NuQo5m5WVF4qQncKmUBdwTNv+fOhnEkb1fAnPLf4sl0=;
	b=suIVVqXo80JnX1uqu7Gp0ahAwsV4K5SwWszfMt43VtNg5lC+Vy2ZWVjgjVHcP4wdvzBjmj
	5mUWzhWCScRdcemDoXAiR+qlO9HDRuCpZEaLunDjrRNYIrRfHlL4r1WESpPQCwImr9T2P+
	bOYh1ehGqI8C/9pRTuKfaqUv2yKSyAg=
From: Sven Eckelmann <sven@narfation.org>
To: "robh@kernel.org" <robh@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "nbd@nbd.name" <nbd@nbd.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Allen Ye =?UTF-8?B?KOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "saravanak@kernel.org" <saravanak@kernel.org>
Subject:
 Re: [PATCH v2] wifi: mt76: fix backoff fields and max_power calculation
Date: Tue, 10 Feb 2026 08:01:30 +0100
Message-ID: <3596367.QJadu78ljV@ripper>
In-Reply-To: <1816591a2149629822a1e08fc4c3fe7601b802fa.camel@mediatek.com>
References:
 <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
 <4713788.LvFx2qVVIh@ripper>
 <1816591a2149629822a1e08fc4c3fe7601b802fa.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1952642.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31688-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8271A117997
X-Rspamd-Action: no action

--nextPart1952642.CQOukoFCf9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Feb 2026 08:01:30 +0100
Message-ID: <3596367.QJadu78ljV@ripper>
MIME-Version: 1.0

On Tuesday, 10 February 2026 07:38:24 CET Ryder Lee wrote:
> Of course, I can revise the description for connac3. I just wanted to
> say that there=E2=80=99s no need to change the min and max values, which =
should
> make things much simpler.

Ok, thanks

Regards,
	Sven
--nextPart1952642.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaYrXygAKCRBND3cr0xT1
y0emAQDQ6WKUrkWC/22IIPGth1fOyuYCl/S4vMfiXu7hBhFa/AEA9A/LnQmNQ8tX
aaUzZSB6o9miIuSlwglW3zm8/hB4vwA=
=uWRc
-----END PGP SIGNATURE-----

--nextPart1952642.CQOukoFCf9--




