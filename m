Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E8EDC0D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDKDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 05:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKDKDr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 05:03:47 -0500
Received: from localhost.localdomain (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40BC2184C;
        Mon,  4 Nov 2019 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572861826;
        bh=6En1jW30YAtZpWrXUfDkYNAs6YbhRXloSzn1AKZJncU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhvaDxhlDqF2rgHF5I2XZgdVUpQcvC0cwcZwVzPMk2rQ0HgKfBrUbYnOagJhmx6iE
         woXjjsC7KhWMMi7K+aM/TpLwOqiUjFCArASGYtRlZvuMeoMR9GdSWGCPaItPiW3oEJ
         fMhPzpf5MzoIe1yK7XwhEcmJqnJQUYJ/Bzj0DdQU=
Date:   Mon, 4 Nov 2019 12:03:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for
 MT7630E"
Message-ID: <20191104100337.GC3935@localhost.localdomain>
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.
>=20
> Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
> is no longer necessary to disable HW encryption for MT7630E.
>=20
> Disabling HW encryption helped previously because somehow fragmented
> skb's are not created if mac80211 encrypt frames, so buffer unmap bug
> of non-linear skbs was not triggered. Now since this bug if properly
> fixed by 7bd0650be63c , we can enable HW encryption back.
>=20
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x0/pci.c
> index 7705e55aa3d1..f84a7df296ea 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> @@ -51,19 +51,6 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
>  	mt76x0e_stop_hw(dev);
>  }
> =20
> -static int
> -mt76x0e_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> -		struct ieee80211_vif *vif, struct ieee80211_sta *sta,
> -		struct ieee80211_key_conf *key)
> -{
> -	struct mt76x02_dev *dev =3D hw->priv;
> -
> -	if (is_mt7630(dev))
> -		return -EOPNOTSUPP;
> -
> -	return mt76x02_set_key(hw, cmd, vif, sta, key);
> -}
> -
>  static void
>  mt76x0e_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  	      u32 queues, bool drop)
> @@ -80,7 +67,7 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
>  	.configure_filter =3D mt76x02_configure_filter,
>  	.bss_info_changed =3D mt76x02_bss_info_changed,
>  	.sta_state =3D mt76_sta_state,
> -	.set_key =3D mt76x0e_set_key,
> +	.set_key =3D mt76x02_set_key,
>  	.conf_tx =3D mt76x02_conf_tx,
>  	.sw_scan_start =3D mt76_sw_scan,
>  	.sw_scan_complete =3D mt76x02_sw_scan_complete,
> --=20
> 1.9.3
>=20

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXb/3dgAKCRA6cBh0uS2t
rIoOAP94Kt+FBkb1ytslXEGVicaSDj0E7jxUCax9SrO9wVuS3AEA+ZjZ03DdiK8w
LWTEj8Q7WXkPrZDAGjoUFDtMEGpczAo=
=sLfP
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
