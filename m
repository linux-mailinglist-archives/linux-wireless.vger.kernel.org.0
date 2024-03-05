Return-Path: <linux-wireless+bounces-4373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F2871BEB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 11:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A3E284DF7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445F5677D;
	Tue,  5 Mar 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UpbHxMf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0F56B98
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634689; cv=none; b=JWkSBMDuyXrD52taOhE9pKkOnCcvJCWjiwpdwy+cMBUhmF3nfOt32FBMdX6dh3IuBvlI0XNVOdogZahc+IG5y1GX+iDdO2pS2v6P1j2us2gtRoXxlNu/jF6b5kBlZoxeiufs/eb/Cfg0+//Pn4ewxAX65R8HU/jhvXrwoZaa7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634689; c=relaxed/simple;
	bh=DQFKDNWKPjFisi1HPO3BcfvAOJmFm67KUQYYYSVmyl8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3npBx1HKxmXRVKphxaK5nrhP7Nt2obDDiVtfMGGkReQZF9CYAq284U5a3N92W5xacLAh7KxvbbFrVZv7VU4JeULxt0VGuggk+ASFDvdtMs1N97vKDEPpye28vpt/Yu5C88B2yUV5pEtmm06CUpW8EzgGBN5hM3C9LTFaA/isgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UpbHxMf2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n7oEURmIKwTo7dl4LS8JiG3qXOySMYNGmqeErShafYU=;
	t=1709634686; x=1710844286; b=UpbHxMf2+6c7XWT/8ecPhm3aE3i0YJTeYkXnVInKW1o/kT8
	vyWuUnszBzaaQEKYGlNVHsxcdHhb68W+wrQLAcg8krBSWJFESFPnSOsMlhWb4ZBx/RS85PXoGlXNz
	GZmPxgPpg52nnF4foHOVToLz8FHI2tJflz5U/Vhu4W8hnJQEzT6NCuQ7Co88fr08dxmhQiyp0WVHE
	Kluu12Kp5Rsj8saD0WD5wqaWmKC/pBIP4CHQq9fAf7r512ZqXCUFkhTpkufL6ScHPNwKoWf0WbTyD
	AZOi43IB143k1NUU1VS1UAF5pLZUI2LRU7CljDNA9oGB1cd3w3z5itaQf2WJPBYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhS4x-00000002hxl-241o;
	Tue, 05 Mar 2024 11:31:23 +0100
Message-ID: <37398c88130c487be656eed4e378d6b047a3d612.camel@sipsolutions.net>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Escande <nico.escande@gmail.com>, Isaev Ruslan
	 <legale.legale@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 05 Mar 2024 11:31:22 +0100
In-Reply-To: <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
	 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
	 <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-05 at 11:17 +0100, Nicolas Escande wrote:

> For what it's worth jansson has been very good to me. It has printf() lik=
e
> object creation which usually integrates well with c programs.

Nice :)

> With MIT license https://github.com/akheron/jansson/blob/master/LICENSE

If we link it as a library rather than copying it, that wouldn't even
matter (well unless it was GPL too, but even then you could still make a
build without it if you don't want the result to become GPL.)

> For me, having a "good" json representation means, as you pointed out, us=
ing the
> right json underlying type and most of the time I'm afraid that means a c=
omplete
> different code path because of the underlying type/container. It's always=
 a
> blurry line obviously but duplicating in a complete seperate function tha=
t only
> does the right thing for json output may end up being cleaner codewise.

Yeah, depends, I guess. I'd rather see less duplicating, and in the
cases like in this patch it seems like it wouldn't even matter so much.
But agree it depends on the objects.

Just things like

	iw_json ? print_string(PRINT_JSON, "manufacturer", "%.*s", sublen, data + =
4) : printf("\t * Manufacturer: %.*s\n", sublen, data + 4);

seem like the worst of both worlds... More obviously perhaps where it's
not even different:

	iw_json ? print_string(PRINT_JSON, NULL, "FT/IEEE 802.1X") : printf("FT/IE=
EE 802.1X");

or

	iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], =
data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1=
] ,data[2], data[3]);


Whereas with something like

	iw_json ? print_string(PRINT_JSON, "response_type", "%d%s", val, val =3D=
=3D 3 ? " (AP)" : "") : printf("\t * Response Type: %d%s\n", val, val =3D=
=3D 3 ? " (AP)" : "");

(ugh, I don't like those long lines)

you probably don't even want to have the " (AP)" thing in the JSON, but
make it a real integer type rather than a string with print_string()!

But we could make that

	output_int("response_type", "Response Type", val);
	if (val =3D=3D 3)
		hint("(AP)");

and the hint() just doesn't do anything in JSON?

And maybe even "response_type" is translated to "Response Type" for the
human output so you don't need to add the other "Response Type" there.
Dunno. I really wouldn't mind if in some places that meant we'd now
output "Response Type" instead of "response type" or "Response type" or
something.

Or perhaps do it the other way around, so "Response Type" is lower-cased
and illegal chars like " " are replaced by "_", although that makes the
JSON representation less obvious in the code.

Picking one arbitrarily, we'd have something

	output_int("Response Type", val);
	if (val =3D=3D 3)
		hint("(AP)");

which seems far nicer than

	iw_json ? print_string(PRINT_JSON, "response_type", "%d%s", val, val =3D=
=3D 3 ? " (AP)" : "") : printf("\t * Response Type: %d%s\n", val, val =3D=
=3D 3 ? " (AP)" : "");

in both code and JSON representation.

Yes we'll have to do something about the \n and indentation and I know
I'm handwaving about that, but it seems like with open_object() and
close_object() etc. that need to keep a state stack anyway, that should
be solvable?

I'd argue that we should try to get somewhere around 80-90% of the cases
unified in this matter, and then have special things for the rest that
are special kinds of objects, etc.

Right now it's pretty much 100% special cases.

johannes

