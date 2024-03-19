Return-Path: <linux-wireless+bounces-4921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D63880351
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABE9B223BE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28018C22;
	Tue, 19 Mar 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1tyau/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE023772;
	Tue, 19 Mar 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868859; cv=none; b=u+La8fPnhdWCP/RRn14GLHE/oZ+KNWHW1wD+q92PgNvS29cQADegtyHuFv6UTj2WtOn5vZAcAtbcSBXpO0JS5FXEKuEQ8uDK/PEz4jmtQ/Jp5NBAEBlMNDc+ouVhc77uJPRsT0HThN5Tan9xc09BCxMBPy1+Go1ZoL/VEjyvNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868859; c=relaxed/simple;
	bh=W+xaZQzH47acfNmxkhab6M0XH+dH90+OCLekFxWL1eQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T7YE3a+NbU5v+kDcuEBiOKX5DjcSQQEyLrx8n/LMJ6yoWTzlnNdUgkyHeZFsio3TB9KKgT3K9Ke9h/FH9jCv2xiGhhCdMuxhNWTAMzoYVXUBMMdkCYleKTPRCcya0sIWTgvtnlDzIKYrOJ9UL+2b/FkG3OVxQQKXRwI9ARqRXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1tyau/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8BC433F1;
	Tue, 19 Mar 2024 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868858;
	bh=W+xaZQzH47acfNmxkhab6M0XH+dH90+OCLekFxWL1eQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I1tyau/vh/IsB5d4T35p5rGs7l3yclkYzgdGt2ZsZrhb4y5dZdQmDm7Y3aG0X9Pg7
	 Iz18m/HRyCHEUpEvWDC3QeZndw/zIFpW+/AVAUqSUgGKf4UmVHIsS2BJmTP98rfyzW
	 lNi6pQL6JOJeKzs70c2QMTZGYa1uJhNqQFtvzB4jmNck5Tdvj86sktZZQ+jG3DyPEd
	 TH87XYCghp4OOCagt8pH81zT0zwqB70g6V562wLOCc5L5YWzxjp/QKEcAOYKTlqKHO
	 SeVDujjl+tSmnGK3ilLurIqQc00kRxVlcgJbXCrutZx8iR28zx7W9nfXYDzeuuRNJj
	 cbaWiPMigs3Dw==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 19:20:54 +0200
Message-Id: <CZXWE5J2QMIN.1L4QKQU7C7UMN@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <iwd@lists.linux.dev>, "James Prestwood" <prestwoj@gmail.com>, "Dimitri
 John Ledkov" <dimitri.ledkov@canonical.com>, "Karel Balej"
 <balejk@matfyz.cz>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, <linux-crypto@vger.kernel.org>,
 "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.15.2
References: <20240313233227.56391-1-ebiggers@kernel.org>
In-Reply-To: <20240313233227.56391-1-ebiggers@kernel.org>

On Thu Mar 14, 2024 at 1:32 AM EET, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> This reverts commit 16ab7cb5825fc3425c16ad2c6e53d827f382d7c6 because it
> broke iwd.  iwd uses the KEYCTL_PKEY_* UAPIs via its dependency libell,
> and apparently it is relying on SHA-1 signature support.  These UAPIs
> are fairly obscure, and their documentation does not mention which
> algorithms they support.  iwd really should be using a properly
> supported userspace crypto library instead.  Regardless, since something
> broke we have to revert the change.
>
> It may be possible that some parts of this commit can be reinstated
> without breaking iwd (e.g. probably the removal of MODULE_SIG_SHA1), but
> for now this just does a full revert to get things working again.
>
> Reported-by: Karel Balej <balejk@matfyz.cz>
> Closes: https://lore.kernel.org/r/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz
> Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c    |  3 +
>  crypto/asymmetric_keys/pkcs7_parser.c     |  4 ++
>  crypto/asymmetric_keys/public_key.c       |  3 +-
>  crypto/asymmetric_keys/signature.c        |  2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |  8 +++
>  crypto/testmgr.h                          | 80 +++++++++++++++++++++++
>  include/linux/oid_registry.h              |  4 ++
>  kernel/module/Kconfig                     |  5 ++
>  8 files changed, 107 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_k=
eys/mscode_parser.c
> index 05402ef8964e..8aecbe4637f3 100644
> --- a/crypto/asymmetric_keys/mscode_parser.c
> +++ b/crypto/asymmetric_keys/mscode_parser.c
> @@ -73,10 +73,13 @@ int mscode_note_digest_algo(void *context, size_t hdr=
len,
>  	char buffer[50];
>  	enum OID oid;
> =20
>  	oid =3D look_up_OID(value, vlen);
>  	switch (oid) {
> +	case OID_sha1:
> +		ctx->digest_algo =3D "sha1";
> +		break;

I fully agree with the change BUT...

IMHO it would make sense to e.g either add inline comment about iwd
dependency or link to the bug report here.

I'd like to think that there is common will to eventually get rid of
all of SHA-1, and thus in cases where it is not yet possible it would
make sense to guide what to needs to be done to make it happen, right?

BR, Jarkko

