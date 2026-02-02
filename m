Return-Path: <linux-wireless+bounces-31442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPmpBxBegGlj7AIAu9opvQ
	(envelope-from <linux-wireless+bounces-31442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:19:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4FDC99FB
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8ABD30022BD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17433986D;
	Mon,  2 Feb 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="UqSLyhXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AA3314C8
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020114; cv=none; b=i2yKgmwF5UQmYTTd85w7yl6Zv/zwUr/tshBzKyyrKiainW5sLlLxK0wbA2NMoHEn+1uOkl9AFBTrnWpHouJ/86H5tSdpbGpaPHuknaK8+kXWtOHcdTrYY8ZXFiMhvt80rMF9s8Cw42t21b1jbp1S/VAk34/gxpZw0I9HGTRL4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020114; c=relaxed/simple;
	bh=A6m3e73KQCRQkUY9ofsphG8zIIOyf309XA6E3Bic1CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrH9iyCVxi0dK33dFaZi60FCuIaEubJQ7Xonae7K1VhKI2QUNs7tKBnrZsSejLzr/+T7fhew3zmrjJA6hQ+IHMOh+2yxk1/+dN7hD8KBg7SzJNPI824xSgUsABkBr07/B+I4hxSRM76Mb1Y/UArzsX9XYSkoRtldChUspP79cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=UqSLyhXl; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id AAEFA21014;
	Mon, 02 Feb 2026 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1770020102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15pmCLyxEi0pLxzUNoUfwSKNMFIzmZCN92bXefFF3r4=;
	b=UqSLyhXlC7rpew+IjjX3v2CCNIB6aOjPuWZE8HdQK+daRtseY2ptazOGsddGJqVH6fSWCo
	pPYh1Kb2NWZXBiAOiBr2HrUsuNwonsM+z4WeO+LlwpvcBUAEkQ3aXaUAK4qnMSyy6cLKch
	PeEV3nkMx5qHJErRhP4EyZjavTCKB7M=
From: Sven Eckelmann <sven@narfation.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Allen Ye <allen.ye@mediatek.com>,
 Saravana Kannan <saravanak@kernel.org>
Subject:
 Re: [PATCH v2] wifi: mt76: fix backoff fields and max_power calculation
Date: Mon, 02 Feb 2026 09:14:54 +0100
Message-ID: <7906220.EvYhyI6sBW@ripper>
In-Reply-To:
 <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
References:
 <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3929001.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31442-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F4FDC99FB
X-Rspamd-Action: no action

--nextPart3929001.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh@kernel.org>
Date: Mon, 02 Feb 2026 09:14:54 +0100
Message-ID: <7906220.EvYhyI6sBW@ripper>
MIME-Version: 1.0

On Wednesday, 28 January 2026 00:55:57 CET Ryder Lee wrote:
> +               case MT76_SKU_BACKOFF:
> +                       backoff_chain_idx += 1;
> +                       fallthrough;
> +               case MT76_SKU_BACKOFF_BF_OFFSET:
> +                       delta = mt76_tx_power_path_delta(n_chains);
> +                       backoff_n_chains = mt76_backoff_n_chains(dev, backoff_chain_idx);
> +                       backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
> +                       break;
> +               default:

Please double check whether the "case"s for MT76_SKU_BACKOFF_BF_OFFSET and 
MT76_SKU_BACKOFF should actually be swapped. I think I've originally 
introduced this mistake when trying to demonstrate different ways to write the
switch block.


> +               /* For connac2 devices,
> +                * - paths-ru = RU26, RU52, RU106, BW20, BW40, BW80, BW160
> +                * - paths-ru-bf = RU26, RU52, RU106, BW20, BW40, BW80, BW160
> +                * Only the first three entries use 1T1ss and do not need index
> +                * adjustment; the remaining four require index offset.
> +                */


Hm, I doubt that anyone can understand this (same for the commit message).
You basically just showed a list of two equal "array"s.

Actually important here is that, RU26, RU52, RU106, ... stand here for 10
different values:

1T1ss, 2T1ss, 3T1ss, 4T1ss, 2T2ss, 3T2ss, 4T2ss, 3T3ss, 4T3ss, 4T4ss

For paths-ru-bf, also 10 values are stored in the DT for each of these
(RU26, ..., BW160) - but only the non-1T1ss are relevant for this
calculation for BW20, ..., BW160.

These 1T1ss beamforming values for BW20, ..., BW160 were (if I understand it 
correctly) removed for connac3. 

If you introduce some change in the DT interpretation, then you must also 
inform the DT maintainers (Rob Herring <robh@kernel.org>, 
Saravana Kannan <saravanak@kernel.org>, devicetree@vger.kernel.org) while 
updatingDocumentation/devicetree/bindings/net/wireless/mediatek%2Cmt76.yaml. 
The latter is currently still expecting 1 ("rates multiplier") + 10 values
(limits). And DTs with only 1 + 9 values per rate would therefore fail to be
validated.

At the moment, your connac3 code is basically conflicting with the devicetree
documentation. I will leave it to the experts to figure out if the devicetree
should have two different interpretations for the same property or whether
the property should be the same and the code must handle the differences
before sending these values to the HW.

Regards,
	Sven
--nextPart3929001.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaYBc/gAKCRBND3cr0xT1
y+JGAP9yD0LmmMIApgiKeRxfcsdReDLdpC+y3ZypWbDdwGGNTQEA3kYIKROXU2j5
Z4tImDd7EhOVEzJnuElNQlQHr1nbuQQ=
=wNka
-----END PGP SIGNATURE-----

--nextPart3929001.kQq0lBPeGt--




