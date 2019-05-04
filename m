Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917AF13884
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEDJwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 05:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfEDJwX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 05:52:23 -0400
Received: from localhost.localdomain (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE44206DF;
        Sat,  4 May 2019 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556963542;
        bh=BqZ5JiWkvHkc3lAZvNDNmOQq2YEoCS6tHKgUvGvJXVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxvM9teiIZbYOqhRHkz2n/HXkEHEr4dOOGdVnkTliw4EMLPRagrs4iAh++HUHlOpK
         cJk4GPEwdkgtD0S8XWXjlNjpZb7jAGSUbczUa/Gk/aXYSN67UibOXq97ultTeAQt7o
         /cawM5/Np/2FRGObAEQAXhNgHi2W3t7xdTjaQURY=
Date:   Sat, 4 May 2019 11:52:16 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7615: Use after free in mt7615_mcu_set_bcn()
Message-ID: <20190504095215.GA23263@localhost.localdomain>
References: <20190503130909.GI29695@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190503130909.GI29695@mwanda>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> We dereference "skb" when we assign:
>=20
> 	req.pkt_len =3D cpu_to_le16(MT_TXD_SIZE + skb->len);
>                                                 ^^^^^^^^
> So this patch just moves the dev_kfree_skb() down a bit to avoid the
> use after free.
>=20
> Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chi=
psets")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index ea67c6022fe6..dc1301effa24 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1270,7 +1270,6 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, stru=
ct ieee80211_vif *vif,
>  	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
>  			      0, NULL);
>  	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
> -	dev_kfree_skb(skb);
> =20
>  	req.omac_idx =3D mvif->omac_idx;
>  	req.enable =3D en;
> @@ -1281,6 +1280,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, stru=
ct ieee80211_vif *vif,
>  	req.pkt_len =3D cpu_to_le16(MT_TXD_SIZE + skb->len);
>  	req.tim_ie_pos =3D cpu_to_le16(MT_TXD_SIZE + tim_off);
> =20
> +	dev_kfree_skb(skb);
>  	skb =3D mt7615_mcu_msg_alloc(&req, sizeof(req));
> =20
>  	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD,
> --=20
> 2.18.0
>=20

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXM1gzAAKCRA6cBh0uS2t
rDeKAQDGjECddgKPoW1n3Dnye8aHew95bCQqgsIeRCLiVSH00QD/VWP4FLjdbVHM
+9OT95BeBDbj0eG7VaB6OROPr+8wLwg=
=UKNW
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
