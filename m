Return-Path: <linux-wireless+bounces-9030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A790A06D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CAA1F21B72
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BF33C0;
	Sun, 16 Jun 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="IKuN1KuC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7B29401
	for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718575401; cv=none; b=m0FJiBIFdpdmp0Tadm955224LZC5c624k8haJ2U60qvYle6IG/G1EN3AWwCmQYki6CFxpR2UQncIUPuWq5EuDQSxacUOJamNLcjCM0BULrLGCxtlhcFOZph6Rgu4pQYzN6siOatrvAXnNE80vOaPdJFmdUCiuCD644MEz11lYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718575401; c=relaxed/simple;
	bh=T5NmqqLu72cozDCcFFMtqglCqvtrLGHbOUDyyvPocCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmjQG0qEcw6kxZ+HkpssFJjXuI0IzESQuSOY9u9HoHTCyUpjCp1JkOUNx98etJItQ2WRuTu+twhQuEl0D+Z989llfrCheqKsBZsBOV66lFD+NjTetOY1CfyoD1bNT9VLBeU634SOWTz6tviwbdInPQprZF0gTsaQS3E9ZzNRYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=IKuN1KuC; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1718575373; x=1719180173; i=christian@heusel.eu;
	bh=T5NmqqLu72cozDCcFFMtqglCqvtrLGHbOUDyyvPocCY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IKuN1KuCCIK2XfuXVLtGjEgIqpENnvLXz4n9PhEXdc5J/0qFVdpzmD6S7HTVc8Ry
	 U9Ge4KQ/QD9z3HMJpRlQwWRexGM6IyDACQ4BuZQub3mlGnuxlVihHHnwS8SK2pcCT
	 q1cMa3D5brfdpqzg2CCKpQW1+GE+eABLQ2/fUpaTAwM/dC8Ibd1TxeCv0h8jnjAok
	 ZSfvWvUWSTeTtg3WlCdxSiAvxF4ENTHDe5kJqCSIApQSqZmXdRI38zDRR0NX7SeSm
	 XfMlJlvR9PFPahTI99idrL838O3L76AvqjEu2fVfQJSp4MsKWTEZXWkmk6zd2tEiW
	 sm/enM0pqJtMLNj8wA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.138.245]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBDWo-1s6IWB07ry-000Jbt; Mon, 17 Jun 2024 00:02:53 +0200
Date: Mon, 17 Jun 2024 00:02:50 +0200
From: Christian Heusel <christian@heusel.eu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Savyasaachi Vanga <savyasaachiv@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mac80211: fix monitor channel with chanctx
 emulation
Message-ID: <75180c51-c71b-4348-975c-f1cac71b4f2e@heusel.eu>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <20240612122351.b12d4a109dde.I1831a44417faaab92bea1071209abbe4efbe3fba@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ccncytsvoaxmygxe"
Content-Disposition: inline
In-Reply-To: <20240612122351.b12d4a109dde.I1831a44417faaab92bea1071209abbe4efbe3fba@changeid>
X-Provags-ID: V03:K1:8Cwg1rMA2d13APtxL0EGHn58A/Nb/Uepac7AMV9KVkeK11R0XCm
 OdeLvZjI/qv8X9QOiuvA4ls6/hRPfPTDQuf3TYoP/N1/mhyp7JFbjR6LWzzOuEUFh2KuTrC
 DSvj3hX5tv8ZIB3w6wDHV8QEhYQnny8gOiEpe3NYLxkMqr6n93P2qlcIAosmjjo69CNgWVh
 Y0GHhRBq9h9oc0hY+xxMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:684IY1ROtKQ=;eIwcH9tSRq1ibMnSnse9VcYbIRE
 Ug1lCWpgnpJvNZhl+pxaut43DY/mVBMBf+7faQhnga3A8UxoqJQTydZVo/ihyZxfO3W1cBrdv
 9QyUpzaqoGUsbeP9lqzxW8f5PBXfuYCzL9uEwo2fbtp6d2mZLg6ME5GrnYi2nxFa0zMmsWzSl
 D5pKLu0SL0Dr7opCyTdlyU3O+E3UrPqf5Y+InWVOp76k9qepRR/ZyDmOoiVAxfAc+Iy+MHHnk
 SlElUQ2sgnIiHnoAlDBZQFoFT0ElUJXOjK2hJY8VU1qYV98ZncJbBtdAtuiggZXr0NFYD+9+n
 wmHkhbMSxzySMHoWOhWcWDNUy+LWBbdIm001UZ6RfYkLwYSapVpkf/fw+rMh/kpXs1gWye/YX
 htcI85V91WtBEqybWMTz9g2kB8Ct+kCHC1kCMApKqyRNaqqQAwLQC2ODI6nH/CTuYNeV0ItOi
 PNZofvA9L+QEA511T4HfIXYSfAhIeSt4OTbj8w1+Q1rhvsz0v8UzlAxtXEcXfTeZXHXeKzZzJ
 9OqHXHIZYwCgXGrdeYbOft9rZzW1zNgJ7g6KSSsdGzR/jdJEFtHmb/FF7tx+XqlaF+pOcp5vi
 aF6rw3PR/xfD+Ek+Cg/+wClvBSdcUqQm0I/tuACJU1DmfKof0a1uhK9GHmn1OYzFM4s3WFuSj
 d1q01CxxekQH3sFfSbyYvsOTUZrzFJncA9HR73Zl6zZVNFjYJoAMbeycH135dXTWgHAFctyfq
 fDlf2iXySmg3gfNe10VwmzdexoWY0UhptYpCB7aARwPOPQQyv7dSUI=


--ccncytsvoaxmygxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/12 12:23PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> After the channel context emulation, there were reports that
> changing the monitor channel no longer works. This is because
> those drivers don't have WANT_MONITOR_VIF, so the setting the
> channel always exits out quickly.
>=20
> Fix this by always allocating the virtual monitor sdata, and
> simply not telling the driver about it unless it wanted to.
> This way, we have an interface/sdata to bind the chanctx to,
> and the emulation can work correctly.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> Reported-by: Savyasaachi Vanga <savyasaachiv@gmail.com>
> Closes: https://lore.kernel.org/r/chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqv=
dyikqu63lon@gfds653hkknl
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hello Johannes,

I saw that you have dropped have dropped the "Bisected-by:" tag I added
=66rom[0], if its still not too late it would be cool if this could either
be re-added or replaced by a "Reported-By:" tag if that is what's rather
used in this subsystem.

Cheers,
chris

[0]: https://lore.kernel.org/regressions/chwoymvpzwtbmzryrlitpwmta5j6mtndoc=
xsyqvdyikqu63lon@gfds653hkknl/

--ccncytsvoaxmygxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZvYQoACgkQwEfU8yi1
JYVqcw//WFiLqTjPs4viKFcIWGEZY3yuYpr4hgXlDcvhuw/P4jc2diRNQiJktzfQ
To/o80bE85O+NdrFim0WQSEzs47dqyD2yRvABmptTPOx/TzXK09TjSP9bkUpre3y
3bSakdSA8Z7EdEgqxscIdP62FVx0IQat8tRnNIum52l10EV5Y0HrI+g0IROFQ2GY
fNIKOWgDjH6XkmXVmXuOy9OxDr06o9K0Kk4Mu1eUCOdAn4m9Ix7CzcBzncSk4Xn0
Z+kehZFy3pxkfFBvu6pfFpJSQo6RnBgXUMewXDu3fARHwrLP6hmtlMCSEQm9w/ur
b1Ldb9vkf0x0sX4TYw+tzcVnbYy2xuvBiJAo0rdrBhaPlB0H579+ntD5ioScJDow
Ub75h/ubNMFFxJtqk7qInBc9lGlThBMaKL8C3dqoa3YEJC0XCvb5gRmErox7RQMQ
ADUsDXLFeQhbfdJTp86J1Dzfe1pMjSF+idIM/L3K4kATzxhos4JrrIXXNyHZ01tu
s2QQOpdC2g+BUDNFa5tt+TjvCvwwkFwR2kw9Rx8fNcsGjPUuWlfidKEY3QcNTW1u
vgTmDb4GqZJCHnRY7GtieUeFH1uyJSrUKBAghEBv74lo3m/zWNcAcKzkyUJf4WSN
WWdci1wIA6h58rwBzc4Pw2ulRVeQNwsRS6bmuNCNYL3NeNYsYL0=
=TmgV
-----END PGP SIGNATURE-----

--ccncytsvoaxmygxe--

