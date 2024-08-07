Return-Path: <linux-wireless+bounces-11105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B387194B287
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6042815B2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64A14EC47;
	Wed,  7 Aug 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MbbntmnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3A1527B1;
	Wed,  7 Aug 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067987; cv=none; b=CX1tRXrNkqwtBe7OmORTGeIyWRd/yeRbBLe6BBfh0Sbyw2rJmMT1MAr5mWlpzxrMN3Ojlwso6M/cOXdcKv5hjViF8n68F3NvQC7oTivtOSbedGXBERAapvizoQpmJJVnX+WA5TrRc83rU1ktp2FspbH1U2/heZTJqV3tqh+lZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067987; c=relaxed/simple;
	bh=/lNYgyyduqWNxgYtLW+nx5b5Z5RouJ+QUC7x18aRp2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkhuoOJjeJUFqncSgsURynm5Mq0a1DApqliVBBUp4FAceEZaTuTa4046PSfyUwObObnvOdopfrJXcY+4Me3tGPNj4LDTLlW2Gt9EpJvjnLdzfXDFfgn2UZeWWEUQbjHss3RnE5gANMaKNdHy495iRq03ow9aEs2YYfofrFaEJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MbbntmnK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723067979;
	bh=/lNYgyyduqWNxgYtLW+nx5b5Z5RouJ+QUC7x18aRp2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbbntmnKzTGoiDDdTw5hxGSbhQVK/2QGMSWVrF1vacCGy6bYYdXVuY7rMKY1UJa5X
	 cyZesAnxJ4cTw0rwqRWEMrvbLqM31CPmjpX9yW3Q6d/5I9b7JPyIgKtfH++f513RDY
	 i9XAzTx9b++Ru0Rr5o3TB4icmjK73HCTxTQpf0do8C1pZW9T0VE2anTGr7QdFP58c4
	 r2vYKKKXTiSBKUTv6HCUB7DbZAm5cDxsAfY907syVUYgMW0W1RkqUTeA9L+1wY5Ssw
	 0fbf3AAp+YgDhWbYOriAwze8JJ4GGDM+AjhfeIBa3OkISBmri6zZwnNEo6abhRWyeq
	 TXB7lfq6IOWQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WfPGg1R6mz4x42;
	Thu,  8 Aug 2024 07:59:39 +1000 (AEST)
Date: Thu, 8 Aug 2024 07:59:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: request to include ath.git tree
Message-ID: <20240808075911.2c096333@canb.auug.org.au>
In-Reply-To: <87wmks50fw.fsf@kernel.org>
References: <87ed7163yd.fsf@kernel.org>
	<20240807080423.45efb506@canb.auug.org.au>
	<87wmks50fw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y9l/9f.IroInhR7WVArfaBC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Y9l/9f.IroInhR7WVArfaBC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Wed, 07 Aug 2024 09:09:07 +0300 Kalle Valo <kvalo@kernel.org> wrote:
>=20
> Please add Jeff and our ath10k list (all our build reports go to the
> ath10k list):
>=20
> Jeff Johnson <jjohnson@kernel.org>
> ath10k@lists.infradead.org

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y9l/9f.IroInhR7WVArfaBC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaz7i8ACgkQAVBC80lX
0GzqWwf9GzyPoKGJO51ko+sZEJvxExBZsAD4NIts8I2WXxIOdqrMWfHS2thshdwW
7zx1miYAD3cOPQMZhqD9YYg88BqC/R+9/xB/HWnfKvzgN0j6l1SVN0iLJwCgGfKj
I0bmCQcgzdP96HmZ7YDJuVRiWTGdk6/MqDT6pnxtDSr3EA/9EY3dgwU5qhOXkdUb
7h1SqD3hYGdRYk+Q1zzDOs8bO/4SE3Qo/Q4p7dE1AjGDNcKDdffHkxmRAEVvH6zW
Ko/V5X0N6kH5wxmL4hIF31oFj1EfshmCRKjQZoqROks/ftgfs66wJp0XUZjQqL5p
8+8d/JrsP9AcxvlASDvV87v71zIBLg==
=HHuc
-----END PGP SIGNATURE-----

--Sig_/Y9l/9f.IroInhR7WVArfaBC--

