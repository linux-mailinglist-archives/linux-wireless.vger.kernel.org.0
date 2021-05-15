Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEEE38197B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEOO4S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhEOO4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 10:56:02 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55796C06174A
        for <linux-wireless@vger.kernel.org>; Sat, 15 May 2021 07:54:46 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lhvgL-0003tZ-2m; Sat, 15 May 2021 16:54:21 +0200
Date:   Sat, 15 May 2021 16:52:54 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "John W . Linville" <linville@tuxdriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/1] ssb: Fix error return code in ssb_bus_scan()
Message-ID: <20210515165254.248647d0@wiggum>
In-Reply-To: <20210515072949.7151-1-thunder.leizhen@huawei.com>
References: <20210515072949.7151-1-thunder.leizhen@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VHxs5xiuuPF0B6tDQDbV9Gg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/VHxs5xiuuPF0B6tDQDbV9Gg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 15 May 2021 15:29:49 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix to return -EINVAL from the error handling case instead of 0, as done
> elsewhere in this function.

> @@ -325,6 +325,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
>  	if (bus->nr_devices > ARRAY_SIZE(bus->devices)) {
>  		pr_err("More than %d ssb cores found (%d)\n",
>  		       SSB_MAX_NR_CORES, bus->nr_devices);
> +		err =3D -EINVAL;
>  		goto err_unmap;
>  	}
>  	if (bus->bustype =3D=3D SSB_BUSTYPE_SSB) {


Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael

--Sig_/VHxs5xiuuPF0B6tDQDbV9Gg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCf4EYACgkQ9TK+HZCN
iw4NRRAA3wLGilSNBbRnorgEI3MkycTCUTOxSB3btZDByoiT0LxHgIbb6rG2Uvny
wPpM/Up5O/nUHu7xZf4Rw5Zme4YFUQjQqKXPzPDHlAjsLhwqDiZnl4srE7YFMzTr
IS1ebXLU4FULDhrJNN2FywRIWfa4lJO3D3Gj26v4ORD3nPURfF6Vz9iO8POctLCV
tQ1Zoi4CVrJRF+sELRQvSf9gPDr/P24+ddrijHPQCE+T96GMeu1RrTkRrYFqu/AW
0ZrdHwewATcOC9GoksOOB7lbjk71NlzebRBQHL/slN/NhqN62CMM40GByATQMnpN
QUnGY4fiIRL7Or20EmLFxjIygtHQh/TKv6p2IGevEWjt89k9QA2PTcSEJI2G5ij2
BhH/ThDf8utCdwp5c2ao0j1qPvHq6O+zL1jQSNU5CnsuCRtCBHXpk5GnBnRVMfCF
IcYtqFuiZ0kF8YV189pN02wuN/5inPpCX7/qrruvr66P2E9dYUC2Ub15u5Dq6zOW
vfmXaU2Ewcgfz0fbqaV2BjQD7RLRF4VKt7SRYETXP0YDpzyAtZ60KD9+PXn+oitV
L5PYEwlYAgJ/E7ROMQhpDyn/PweCtvIDlWNtDfbISXIZLYpNLafQwjhkzl/hLox4
AmxX75V3AAEqGQViPe9fQdMwZp34xWFNd4IN/4a0g45NJJSJEBM=
=GIQ2
-----END PGP SIGNATURE-----

--Sig_/VHxs5xiuuPF0B6tDQDbV9Gg--
