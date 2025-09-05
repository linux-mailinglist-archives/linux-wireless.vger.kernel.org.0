Return-Path: <linux-wireless+bounces-27032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400DB44CFC
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 07:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B9A441B6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 05:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE622B8B0;
	Fri,  5 Sep 2025 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i4+5qk2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EC255E40;
	Fri,  5 Sep 2025 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048888; cv=none; b=YZPmKkip1KY7uyUln+HjAaOc7hsQSIqlNAik/wnkziaybYM5f2zrZaP+LzmGzGiJCj84gkeq3Z3dHNcRAhLLjwl1+yrwOyCWv0UGS7fd1g5zN1x9Cr6ww2IVHza1W44axT21AeJ0VIZ4twoOk0T+mnLcxiiVFILgpAQBsTq9g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048888; c=relaxed/simple;
	bh=Nvsjo+hoxG0Y68uVTp1BOMx7yxFokSxTDBoAg4jYy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAopPSz03eAfswDhZmTRV31UaH89BiqIuEixZiCmhUFVLwvA2nBzjiE9bmRKptbQO/q6W7eOZKtWIvS8Ziu4jP48KJl6Dgy5vMN5NnXX7d/luiPTPIRiE2t+1p4xLbm/ahg3ZYLcw1sXdt5pfDzOG1CkSK2EhzrQQ6qoQal5niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=i4+5qk2O; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1757048883;
	bh=7Uobh0MtBkkqb4QSJlV6WibYFSiDhIJead2SUVGBM7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i4+5qk2O2xIY+5VtWaB5ayCdgjmbeI299KiCIMZQp1V//C3KRxcIlRWEzUDHYT/tI
	 meWfLcQqJDOfQxPtx+nolVmhc80piVgPJ0u7QcexlFvrD4K2WH+wKzJshgntphXgeM
	 9S/fxzFs9X9z4VIZ9Ge5Ws6JW6iY81C4LbKBRcGi/4DuapVmx7TfvWq9FkuneOvDpx
	 nR6dT96ugsdF4/cFgn9TIAQvAk523MAMtlyarpkDAmfKdXlZjOn3Q0Dtqp1iHPglXq
	 EIOQ1SGkTjTi8/otzr264YvBKfLdnbSL+RTgNSIraVuSixA9uOqXZaBSgYOn66wuHu
	 7wgGSpJyMO/bQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cJ49Y4Z2Tz4w9h;
	Fri,  5 Sep 2025 15:08:01 +1000 (AEST)
Date: Fri, 5 Sep 2025 15:08:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Johannes Berg <johannes.berg@intel.com>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iwlwifi-next tree with the net
 tree
Message-ID: <20250905150800.08c5402f@canb.auug.org.au>
In-Reply-To: <20250903121032.744f5a30@canb.auug.org.au>
References: <20250903121032.744f5a30@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AnN7A/or9kwBB3eNn0ui1UW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AnN7A/or9kwBB3eNn0ui1UW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 3 Sep 2025 12:10:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the iwlwifi-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/iwlwifi/fw/uefi.c
>=20
> between commit:
>=20
>   1d33694462fa ("wifi: iwlwifi: uefi: check DSM item validity")
>=20
> from the net tree and commit:
>=20
>   f53f2bd8fc5f ("wifi: iwlwifi: uefi: remove runtime check of constant va=
lues")
>=20
> from the iwlwifi-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc drivers/net/wireless/intel/iwlwifi/fw/uefi.c
> index 99a17b9323e9,44c7c565d1c6..000000000000
> --- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
> @@@ -742,17 -744,6 +744,12 @@@ int iwl_uefi_get_dsm(struct iwl_fw_runt
>   		goto out;
>   	}
>  =20
> - 	if (ARRAY_SIZE(data->functions) !=3D UEFI_MAX_DSM_FUNCS) {
> - 		IWL_DEBUG_RADIO(fwrt, "Invalid size of DSM functions array\n");
> - 		goto out;
> - 	}
> -=20
>  +	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
>  +		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
>  +				func, data->functions[DSM_FUNC_QUERY]);
>  +		goto out;
>  +	}
>  +
>   	*value =3D data->functions[func];
>  =20
>   	IWL_DEBUG_RADIO(fwrt,

This is now a conflict between the wireless-next tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/AnN7A/or9kwBB3eNn0ui1UW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmi6cDAACgkQAVBC80lX
0Gyf5AgAh2FpHJpuXGtuzODAfaRcvBiF9tlg5Af2EsEgQj7VaWX7Qgzs802BFcCO
WiU4DH39SLHTfX178+v+HZIIs0ysb6ImuqdiGkkoEyxAl40/7lX89hw3Qo1HYDWo
hEyCQ8m6SAbrWp+csh8quYRx4NOWyFAVrjzUharEfeU25+SdPT11dIPlcDx0Ucae
t1dUZvp3PXgJqSCugar48atsu8mdxVgltiEvJhzqr/fq8J/Da4FaDtyVEQgU3JjJ
Fy6oCpEqHSen6hIAUD554WrlkkOMyAd5/pdVp7jtrpxCC6YgDsMgFcE3Z2Rb0wiK
7c+xziCiF1+wGvy3hS7j964CwCgj3w==
=f5nQ
-----END PGP SIGNATURE-----

--Sig_/AnN7A/or9kwBB3eNn0ui1UW--

