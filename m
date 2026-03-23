Return-Path: <linux-wireless+bounces-33681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HMbBL7KwGmmKwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:08:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1122EC958
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 06:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F86A30094F7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E892609EE;
	Mon, 23 Mar 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyTR2j6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D734414
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242489; cv=none; b=PLLxBIpmMRvnkym3dLMAMB8CsJsowSr/4qJy6f/GMYjpZfVgA0tZPlhDTNcnlJtrRMGmHM6MxGBt/ppN0E1c+XsdNCc2QjsGaRaHXsJD5S0rrh68D4J/zSFYbzi+pKmtn8DkpfDBBc6inSFdTIH60bzWQd60c0J2ZJ9RiXRxf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242489; c=relaxed/simple;
	bh=3M/qa2j2XtSav5vEQ9cbpA94fhQS57if053QslqBV7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXml7iQDhTo2z2fZw1oCrQHMMmVAVy7kJTaiFiKzwcI/kB0UKAVqaNMqvJDDEhinX2hUbEWG2Vc7CXBSbRVWcBlZxQjkbirRSHlZ9Bqf9CC6FHIWRkduRG3jUd3hCa66Ah5hCUlFCPqgb8aQA8XHkhk1Yhc5abuA/FEdOPT05c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyTR2j6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46294C2BC9E
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774242489;
	bh=3M/qa2j2XtSav5vEQ9cbpA94fhQS57if053QslqBV7E=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=eyTR2j6WMeQDnZ13+rZfQkANPKQSgcg4IN92FSdrU2ffWJvgfcSaw5jeWw4+pOS0G
	 XcIIg+0AunhYGl02HrI3/ptDdPcL9S+/vQgEZNArlyos9tJlTjGjewR55vKrBhElG7
	 +ZxUqLcIyuJhgT4CJJnidj/ay1+rzxGlhNQZn3tZgfYhIHVJUTmP5RvCLzwt6w0znR
	 8Wy8OtTJBM5MssIfuIzsWzYxNAD8SB6O6PV3rLEmRKoHvmmzP0EniNchPOzdSp3hZx
	 S0Ya1BkbjgoLkjmuXUYv7F9FOy21pZFpjgLXwWMtnBzO8jKbVmSZJ4AU0fpWbxtNhd
	 ttEAPcqFBbTeg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a32d36396so34403931fa.0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 22:08:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx1kYGPhcsMYgemCCYYaKunwa4hgstb+I428nxXgLqn6W9h/OLv
	N5lVpmfr4E4bIq9WaCkXQIEEi4hJYDE3nQZCrBAEznJxLav4LInh7B0fSM8ZLDEmJgAEpu96Lfp
	eIuHhVz1HRyzPSvZjYuSubD6UnNh/0hg=
X-Received: by 2002:a05:651c:1a1e:b0:38b:d126:8ff2 with SMTP id
 38308e7fff4ca-38bf9d13c28mr32429411fa.8.1774242487659; Sun, 22 Mar 2026
 22:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125212622.28370-1-bage@debian.org>
In-Reply-To: <20260125212622.28370-1-bage@debian.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 23 Mar 2026 13:07:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v64KgRdrSAbCXDh4nuqQa3Gftmdk8Nt7AmC4RFU28NoY6w@mail.gmail.com>
X-Gm-Features: AQROBzDfDB9RDuBpgX5Kwyrvb0UbEjorp9OJFk0F63qxs0y5IMAIcFNsoN7bvHw
Message-ID: <CAGb2v64KgRdrSAbCXDh4nuqQa3Gftmdk8Nt7AmC4RFU28NoY6w@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Port RSA signing to cryptography lib
To: Bastian Germann <bage@debian.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33681-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,db2bin.py:url]
X-Rspamd-Queue-Id: 7B1122EC958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 26, 2026 at 5:26=E2=80=AFAM Bastian Germann <bage@debian.org> w=
rote:
>
> Port the RSA signing from the deprecated M2Crypto library to the
> cryptography library.
>
> M2Crypto is no longer actively maintained. The cryptography library is
> the recommended replacement, offering better maintenance.
>
> Remove unused hashlib import.
>
> Signed-off-by: Bastian Germann <bage@debian.org>

Sorry for getting to this just now. I somehow accidentally archived it,
so I ended up taking Ben Hutching's patch instead.


Thanks
ChenYu

> ---
>  db2bin.py | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/db2bin.py b/db2bin.py
> index 29ae313..a4fa3e5 100755
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
> @@ -125,19 +124,27 @@ if len(sys.argv) > 3:
>      # Load RSA only now so people can use this script
>      # without having those libraries installed to verify
>      # their SQL changes
> -    from M2Crypto import RSA
> +    from cryptography.hazmat.primitives import hashes, serialization
> +    from cryptography.hazmat.primitives.asymmetric import padding
> +
> +    # load the private key
> +    with open(sys.argv[3], 'rb') as key_file:
> +        key =3D serialization.load_pem_private_key(key_file.read(), pass=
word=3DNone)
>
>      # determine signature length
> -    key =3D RSA.load_key(sys.argv[3])
> -    hash =3D hashlib.sha1()
> -    hash.update(output.getvalue())
> -    sig =3D key.sign(hash.digest())
> +    sig =3D key.sign(
> +        output.getvalue(),
> +        padding.PKCS1v15(),
> +        hashes.SHA1()
> +    )
>      # write it to file
>      siglen.set(len(sig))
>      # sign again
> -    hash =3D hashlib.sha1()
> -    hash.update(output.getvalue())
> -    sig =3D key.sign(hash.digest())
> +    sig =3D key.sign(
> +        output.getvalue(),
> +        padding.PKCS1v15(),
> +        hashes.SHA1()
> +    )
>
>      output.write(sig)
>  else:
>

