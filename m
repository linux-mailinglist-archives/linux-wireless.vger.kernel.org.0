Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18A456DFA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 12:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhKSLMB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 06:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231828AbhKSLMA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 06:12:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C0360F57;
        Fri, 19 Nov 2021 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637320139;
        bh=Ek2VDOl/eHvnZX/shjcKiE2kgrtnoRJ4eArPCTtx0kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOjxrYo2Kwx9Y5/75p6CrTJDECfkkdRpKdCbaw+5fG+ClH72JuqyUDHGXMeNXdaqz
         dDd5kZAgbOcWYeaAzBQP+PR47nU/NjP/xHXLMOoIc+Hjvj+MU0I82HGiD6Gi53CGqp
         +AL+Caud6EzdqniohJKv5FCK+OcyzmqQJ8ByCfZVbVuF5qR2DvUJInT6PivbrxHs/P
         WHjaMJ8zJb8zmbsJTSOHcYpcN+GuvriCCOC4/rIpTgb+nLVIbSyior41hpb6Vcg+jx
         TqLqE6t6weoNUe4dwAabL36GPZGvyhg2oi+RhH7PEk8L64nOM+gVsbqYS10ZWWeIZL
         TKvIMV6NEUeRA==
Date:   Fri, 19 Nov 2021 12:08:55 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: fix NULL pointer dereference in
 mt7915_get_phy_mode
Message-ID: <YZeFx0s8HUNtaODw@lore-desk>
References: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UoWE2AMvjOShN/DN"
Content-Disposition: inline
In-Reply-To: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UoWE2AMvjOShN/DN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix the following NULL pointer dereference in mt7915_get_phy_mode
> routine adding an ibss interface to the mt7915 driver.

Hi Kalle and Felix,

I guess we can apply this patch in wireless-drivers tree since the issue is
already in Linus's tree. What do you think?

Regards,
Lorenzo

>=20
> [  101.137097] wlan0: Trigger new scan to find an IBSS to join
> [  102.827039] wlan0: Creating new IBSS network, BSSID 26:a4:50:1a:6e:69
> [  103.064756] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [  103.073670] Mem abort info:
> [  103.076520]   ESR =3D 0x96000005
> [  103.079614]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  103.084934]   SET =3D 0, FnV =3D 0
> [  103.088042]   EA =3D 0, S1PTW =3D 0
> [  103.091215] Data abort info:
> [  103.094104]   ISV =3D 0, ISS =3D 0x00000005
> [  103.098041]   CM =3D 0, WnR =3D 0
> [  103.101044] user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000460b1000
> [  103.107565] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000, pud=3D0000000000000000
> [  103.116590] Internal error: Oops: 96000005 [#1] SMP
> [  103.189066] CPU: 1 PID: 333 Comm: kworker/u4:3 Not tainted 5.10.75 #0
> [  103.195498] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [  103.201124] Workqueue: phy0 ieee80211_iface_work [mac80211]
> [  103.206695] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
> [  103.212705] pc : mt7915_get_phy_mode+0x68/0x120 [mt7915e]
> [  103.218103] lr : mt7915_mcu_add_bss_info+0x11c/0x760 [mt7915e]
> [  103.223927] sp : ffffffc011cdb9e0
> [  103.227235] x29: ffffffc011cdb9e0 x28: ffffff8006563098
> [  103.232545] x27: ffffff8005f4da22 x26: ffffff800685ac40
> [  103.237855] x25: 0000000000000001 x24: 000000000000011f
> [  103.243165] x23: ffffff8005f4e260 x22: ffffff8006567918
> [  103.248475] x21: ffffff8005f4df80 x20: ffffff800685ac58
> [  103.253785] x19: ffffff8006744400 x18: 0000000000000000
> [  103.259094] x17: 0000000000000000 x16: 0000000000000001
> [  103.264403] x15: 000899c3a2d9d2e4 x14: 000899bdc3c3a1c8
> [  103.269713] x13: 0000000000000000 x12: 0000000000000000
> [  103.275024] x11: ffffffc010e30c20 x10: 0000000000000000
> [  103.280333] x9 : 0000000000000050 x8 : ffffff8006567d88
> [  103.285642] x7 : ffffff8006563b5c x6 : ffffff8006563b44
> [  103.290952] x5 : 0000000000000002 x4 : 0000000000000001
> [  103.296262] x3 : 0000000000000001 x2 : 0000000000000001
> [  103.301572] x1 : 0000000000000000 x0 : 0000000000000011
> [  103.306882] Call trace:
> [  103.309328]  mt7915_get_phy_mode+0x68/0x120 [mt7915e]
> [  103.314378]  mt7915_bss_info_changed+0x198/0x200 [mt7915e]
> [  103.319941]  ieee80211_bss_info_change_notify+0x128/0x290 [mac80211]
> [  103.326360]  __ieee80211_sta_join_ibss+0x308/0x6c4 [mac80211]
> [  103.332171]  ieee80211_sta_create_ibss+0x8c/0x10c [mac80211]
> [  103.337895]  ieee80211_ibss_work+0x3dc/0x614 [mac80211]
> [  103.343185]  ieee80211_iface_work+0x388/0x3f0 [mac80211]
> [  103.348495]  process_one_work+0x288/0x690
> [  103.352499]  worker_thread+0x70/0x464
> [  103.356157]  kthread+0x144/0x150
> [  103.359380]  ret_from_fork+0x10/0x18
> [  103.362952] Code: 394008c3 52800220 394000e4 7100007f (39400023)
>=20
> Fixes: 37f4ca907c46 ("mt76: mt7915: register per-phy HE capabilities for =
each interface")
> Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chi=
psets")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 42e9ce99e046..2894da63f319 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -176,7 +176,7 @@ mt7915_get_phy_mode(struct ieee80211_vif *vif, struct=
 ieee80211_sta *sta)
>  		if (ht_cap->ht_supported)
>  			mode |=3D PHY_MODE_GN;
> =20
> -		if (he_cap->has_he)
> +		if (he_cap && he_cap->has_he)
>  			mode |=3D PHY_MODE_AX_24G;
>  	} else if (band =3D=3D NL80211_BAND_5GHZ) {
>  		mode |=3D PHY_MODE_A;
> @@ -187,7 +187,7 @@ mt7915_get_phy_mode(struct ieee80211_vif *vif, struct=
 ieee80211_sta *sta)
>  		if (vht_cap->vht_supported)
>  			mode |=3D PHY_MODE_AC;
> =20
> -		if (he_cap->has_he)
> +		if (he_cap && he_cap->has_he)
>  			mode |=3D PHY_MODE_AX_5G;
>  	}
> =20
> --=20
> 2.31.1
>=20

--UoWE2AMvjOShN/DN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZeFxwAKCRA6cBh0uS2t
rPmaAP9nh/y6njG1Y33PciUBBRs5alSx3u0ANZfQllfWSOsCigD+NmJSkXyY5FI3
yK61JTNC+NljEISYLUwbe5AnpMY9xgo=
=/rpG
-----END PGP SIGNATURE-----

--UoWE2AMvjOShN/DN--
