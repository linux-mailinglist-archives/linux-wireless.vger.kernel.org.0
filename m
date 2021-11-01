Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F64441D00
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhKAPB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 11:01:28 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:57086 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhKAPB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 11:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635778733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hLC8q7J0qw/3LqmCg2gnCRHDw7JAgfe2AiurAEka4Y=;
        b=jIKYUqUarj1SuJcpQajmHfG2bpU6dFybBLdW6VTYYaUjVvYxBoTCAdU6nI7GKpPMYt+nGl
        89A6uTXvhfw5RKH8qvavnCxGl7PBjnt8U5g5JDnK6AsT0o8t7IMDC+pE/lPbUK/RTBsJgY
        MVQkGrrpPsKJavaH0P9SKyCneg4RpKw=
From:   Sven Eckelmann <sven@narfation.org>
To:     luciano.coelho@intel.com,
        Sharadanand Karanjkar <sk@simonwunderlich.de>,
        johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date:   Mon, 01 Nov 2021 15:58:50 +0100
Message-ID: <12264353.XuppNRcviy@ripper>
In-Reply-To: <6520824.1yIjQniEF0@sven-l14>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4715850.dHxB9yWSct"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4715850.dHxB9yWSct
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: luciano.coelho@intel.com, Sharadanand Karanjkar <sk@simonwunderlich.de>, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date: Mon, 01 Nov 2021 15:58:50 +0100
Message-ID: <12264353.XuppNRcviy@ripper>
In-Reply-To: <6520824.1yIjQniEF0@sven-l14>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14>

On Saturday, 30 October 2021 19:17:38 CET Sven Eckelmann wrote:
> [...]
> Maybe 
> there are even newer (test) firmware versions available but I am not aware 
> of any newer firmware version than the previously mentioned one [1].
> And this firmware was published for linux-firmware right around the time when
> Vfg. 55/2021 was released - so it is to some extend expected that Intel didn't 
> yet incorporated such a change.
> 
> I only saw newer releases for other HW [2] but not for Ty.

Seems like there was just a newer release with Sharadanand should test

Kind regards,
	Sven

[3] https://lore.kernel.org/all/19391a6dd10076e3a64aff20d68a9a37ac56e794.camel@coelho.fi/
--nextPart4715850.dHxB9yWSct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGAAKoACgkQXYcKB8Em
e0bRBRAAvMKjQQDHZmoBJ8hxEXrvwMnFvWDAt4Cs4bslVFRReHLRSWucgZEmJ5Ar
GjH6VrQLnbiOKpF3t0QCtDW38oz/uUaSVcxdGF/3lYMkhdTqJK5paZa1nJ6JIWyx
bDGBc/lIpDz0KFGiYz/eKM0W8bfZwNNAr4phbfNZZik+ze9nsymiOU0/6m1gxCsA
qeHMg4MLZQXS3enqwJlgLcqfKG4SljfX0fLwm/Yywu/MpxfVyOxkJxMA14hvR1Hq
pPJ0o00FrJcyc9LfSvQ+N1oG+GSbzSqIkrNHBlQ46h+WvXJjdVVWczWR9uljwFa4
r2yUvAuwFjDzC6eE3ol1j7zogOvFiLqHbaRVhct6Ql94VMM0Mjt8zUWTqUfZnnnZ
4rUuZ9sh2WlZoL2fuarYNLNrtBPUNqR3hyh9PuLyhynoaooX61UJJ5UD0Syt8Xpr
aWWFCn5CEn5qxMwJmyiFL3EXzW6sgY+12k06KntzE2WXVuR1k4WXIkItxi+/X/Jz
B5EHKyW7NxttTGtdD9J0X9eNInsUARpZ0mOOZdTV2Rbrx2fwq1lxQzrDYyG9x+fP
2uUrW9myhL5qUlXTkxxpItdqJRFtJBS30n5eSMB3+CValrD5M+HgFbKNA2VWb+P/
F+/Pz0oquRVv+oSw38+g2ZKb9j87qHmtOeGIaVE75zStszzSb5Q=
=nT1i
-----END PGP SIGNATURE-----

--nextPart4715850.dHxB9yWSct--



