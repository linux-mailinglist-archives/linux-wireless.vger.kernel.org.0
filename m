Return-Path: <linux-wireless+bounces-32168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF35GuqmnmmrWgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 08:38:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80519392E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B4173022073
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B472D73BE;
	Wed, 25 Feb 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTsZm0Wf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA2279DCE
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005096; cv=none; b=RCdFv0858ZEDw4ly05lb23sMJXTAPorEV6psc8cG/kNJDa5nP6Myo2jXs66LJ8yJIUhTIjYW+Tqsf5wdIpTauuXC+xvLrfeB2bnTi3vBtOprVAzH44cIfkqf+rA6bzdCcos4S3jHhXNXzLJJonKeRBWa/YAJJ00VseM0OlZgB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005096; c=relaxed/simple;
	bh=j9gtPTNra9e2hfvaCX2It61foBz+mxYQEvCr9Hw6B98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThTKXQhHGDceWyM337Pi8VBTVWUdZWxHi3NGEvMffp5hsXlrvPZa5Q+F3+DW1qg2kX6pOA4xa0WoOqltl3NzhWftpX3lD+rkzqkDYkxv4+SfPukNprlNvQJwhpNVxqk5MHJdcIWeJ1R/TyzWCeIRrBVyiuo2M6Bvo9lEJQBMZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTsZm0Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D57C116D0
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005096;
	bh=j9gtPTNra9e2hfvaCX2It61foBz+mxYQEvCr9Hw6B98=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=NTsZm0Wf1u1lHuDmRp2WZXSkQ8rIJRou/2dDWmBDvKBWlwY03AuCHiVF8XcOdSVRi
	 /A2QGCS4tLz+ev0Eo7+cH0uDDm91DbnlSIrSLc6nzcIE+3NCWSGIB9BKVHAW0rCTre
	 ZO9UX4Pxa2aNjL915tdSIe0k55ffXBrVvImTBBKXhPhRFsO876Dalmi/X1s98q7I6h
	 Ir9coVTQkQugeAk90okv4j+ecDszwd+p6zCsvZiFvlw0Twed9hTllgTuvXgcgzFFZc
	 M0Orj0ZVl0mUZYaE9dkbQu0pMlMSmcvViMoBK64F43uvQ7L/fNYgTZcviNIUonVbHd
	 i/PkEJEwyhccw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3870dec27f4so6697571fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:38:16 -0800 (PST)
X-Gm-Message-State: AOJu0YxG5UeTnOtplMRT8F/P7fjXgYz2KsHZxjzUAFwwUBDpagHLHFsw
	T0tLzxmF5DS1y0NGI13wpzzt7GuKVunEPBlGsHAYRL3cDqlcQTZSefnKnN9q5+X/7brmhrzeW36
	iAzAoGFLvceBqkzpitS3vH8C0jFZHi9c=
X-Received: by 2002:a2e:bea7:0:b0:366:ef7d:bab3 with SMTP id
 38308e7fff4ca-389ddc4d7fbmr8506501fa.1.1772005094693; Tue, 24 Feb 2026
 23:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZN3thlmaiBxYVQQ@decadent.org.uk> <aZN4FltUUWKUh6rp@decadent.org.uk>
In-Reply-To: <aZN4FltUUWKUh6rp@decadent.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 25 Feb 2026 15:38:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kMtJmdV8ijbbjjP+iig1Kz=ipVS4Hzv_=kwt+PS9QQw@mail.gmail.com>
X-Gm-Features: AaiRm52ClQmSBSgnpNgvirOTe2JXtV2wnpqd0w6e2dRIOfy181fBWdTZsKTR8q0
Message-ID: <CAGb2v66kMtJmdV8ijbbjjP+iig1Kz=ipVS4Hzv_=kwt+PS9QQw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Replace M2Crypto with cryptography package
To: Ben Hutchings <benh@debian.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32168-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Queue-Id: 1A80519392E
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 4:03=E2=80=AFAM Ben Hutchings <benh@debian.org> wro=
te:
>
> M2Crypto is deprecated by its maintainers in favour of the
> cryptography package.  Update db2bin.py to use that for signing
> regulatory.bin.

Cool. This actually forced me to remove Python 2 from my system
to switch over to python3-cryptography. I was using some ancient
version of M2Crypto otherwise.

> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
> This applies on top of the preceding fix for M2Crypto usage, but I can
> squash them together if it's preferable to switch directly to
> cryptography.

It's fine. Having some history is good.


Thanks
ChenYu

> Ben.
>
> --- a/db2bin.py
> +++ b/db2bin.py
> @@ -2,7 +2,6 @@
>
>  from io import BytesIO, open
>  import struct
> -import hashlib
>  from dbparse import DBParser
>  import sys
>
> @@ -125,19 +124,18 @@ if len(sys.argv) > 3:
>      # Load RSA only now so people can use this script
>      # without having those libraries installed to verify
>      # their SQL changes
> -    from M2Crypto import RSA
> +    from cryptography.hazmat.primitives import hashes, serialization
> +    from cryptography.hazmat.primitives.asymmetric import padding
>
>      # determine signature length
> -    key =3D RSA.load_key(sys.argv[3])
> -    hash =3D hashlib.sha1()
> -    hash.update(output.getvalue())
> -    sig =3D key.sign(hash.digest(), algo=3D'sha1')
> +    with open(sys.argv[3], 'rb') as key_file:
> +        key =3D serialization.load_pem_private_key(key_file.read(),
> +                                                 password=3DNone)
> +    sig =3D key.sign(output.getvalue(), padding.PKCS1v15(), hashes.SHA1(=
))
>      # write it to file
>      siglen.set(len(sig))
>      # sign again
> -    hash =3D hashlib.sha1()
> -    hash.update(output.getvalue())
> -    sig =3D key.sign(hash.digest(), algo=3D'sha1')
> +    sig =3D key.sign(output.getvalue(), padding.PKCS1v15(), hashes.SHA1(=
))
>
>      output.write(sig)
>  else:

