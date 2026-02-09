Return-Path: <linux-wireless+bounces-31661-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FJcEE+miWlJAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-31661-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 10:18:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B310D70E
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E846301D69F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977832693E;
	Mon,  9 Feb 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Pc8K8le2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48F3624C7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628635; cv=none; b=mWv85AZjHWU3yVUV7CN6CWBw3kEbbTwwGauFBkcyVQFiTv7PK9moRmuD2fRf2e8rP/lK0RJqRkZvcyp0GStYURSq+nBrBKK0AHCbbh5ALsAjdakYQFB04tVDBrnXi644kEEv+JwgIXNJm5NiAg5o85ouQU0Teg7LgarD2MyJ0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628635; c=relaxed/simple;
	bh=K0E9osJpZYXRt5Wk0KibdvPph+aO07mx3fwhjQLwpvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QugJ380HDfImcgVqoU88hPfkVKl/QHcYTWmP1rtJiw/qlnkU3XKVxKQg3+o2YVJzlUZGcHaT/jRQ4Ep78NBJuHbkiGdQ/+I9nNgaNj55SBCzS63OZQcdfStkc445JN02enzm9IfJDem6IlH5uv0Y0g2YyqpRX/RCRtsbHjkoICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Pc8K8le2; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7B52F21722;
	Mon, 09 Feb 2026 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1770628627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ISR/mfVT+xDv1tvxnsCEeFByJ832c8OhCJ5RCB0HqM=;
	b=Pc8K8le2y3fVQxXWukrh6DaIZQ/AGYP+41/QZ3tu405GjjcUnGn1/FIC8xIzbOXqo4SH2B
	OsbXRLyg2e+BJVa0UhUF9hGm1Jjy+g9C+J49mEFL0eoUhqvvP/TfGy/I9T5n32iNOCwT5O
	wlNDNrcvn9sm9n3pokzdFb1bAFHFniE=
From: Sven Eckelmann <sven@narfation.org>
To: "robh@kernel.org" <robh@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "nbd@nbd.name" <nbd@nbd.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Allen Ye =?UTF-8?B?KOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "saravanak@kernel.org" <saravanak@kernel.org>
Subject:
 Re: [PATCH v2] wifi: mt76: fix backoff fields and max_power calculation
Date: Mon, 09 Feb 2026 10:17:03 +0100
Message-ID: <4713788.LvFx2qVVIh@ripper>
In-Reply-To: <278546e3f3e526288d245111d8e022b2d68d012e.camel@mediatek.com>
References:
 <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
 <7906220.EvYhyI6sBW@ripper>
 <278546e3f3e526288d245111d8e022b2d68d012e.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2400649.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31661-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AF8B310D70E
X-Rspamd-Action: no action

--nextPart2400649.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 Feb 2026 10:17:03 +0100
Message-ID: <4713788.LvFx2qVVIh@ripper>
MIME-Version: 1.0

On Monday, 9 February 2026 08:48:50 CET Ryder Lee wrote:
> - In connac2, beamforming entries for BW20~BW160 and OFDM do not
> include 1T1ss.
> - In connac3, beamforming entries for BW20~BW160 and RU include 1T1ss,
> but OFDM beamforming does not include 1T1ss.

This doesn't seem to match the documentation [1]:

                  paths-ofdm-bf:
                    $ref: /schemas/types.yaml#/definitions/uint8-array
                    minItems: 4
                    maxItems: 4
                    description:
                      4 half-dBm backoff values for beamforming
                      (1 - 4 antennas, single spacial stream)
...
                  paths-ru-bf:
                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
                    description:
                      Sets of half-dBm backoff (beamforming) values for 802.11ax
                      rates for 1T1ss (aka 1 transmitting antenna with 1 spacial
                      stream), 2T1ss, 3T1ss, 4T1ss, 2T2ss, 3T2ss, 4T2ss, 3T3ss,
                      4T3ss and 4T4ss.
                      Each set starts with the number of channel bandwidth or
                      resource unit settings for which the rate set applies,
                      followed by 10 power limit values. The order of the
                      channel resource unit settings is RU26, RU52, RU106,
                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
                    minItems: 1
                    maxItems: 7
                    items:
                      minItems: 11
                      maxItems: 11

Regards,
	Sven
	
[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/net/wireless/mediatek%2Cmt76.yaml
--nextPart2400649.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaYmmDwAKCRBND3cr0xT1
y0eTAP4x/wnJjrsntSDQSErh9wdbbDbTV2Us/Y9H167xWGX0lQEAixfhJF2XsZ7O
EqIwD6otwncazjb4ckPtxspWy4wzKAw=
=7NbR
-----END PGP SIGNATURE-----

--nextPart2400649.ElGaqSPkdT--




