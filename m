Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9A459113
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhKVPRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 10:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232963AbhKVPRw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 10:17:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A726D60F25;
        Mon, 22 Nov 2021 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637594086;
        bh=OH6FgXhpWT9k5P7jfUy+KIL7OhDtxFhPgZSvVtlxFB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQW28OH0c9j2B2t3iZBaqmbW2icgiJZ4Xrkkl4fqk+nKprgwAZyBo1aiT4ZXedny0
         SrcNuu1hXHnCC2fYRDktudRD0rKk+z4lPLyXj8fLLnKtx8p4G3NnVNSUU+ocM7PLBr
         dAshLImWGiMen6dIGqpal9EAJ0PzmU3B3r+G5FK2w5kC7kD6mygii2TCIKV5xK4FSs
         W1bjc9QzOiUVo1Wnpg06wFu6wKzkKDDFGkC121m/bZSoBLGqHtLNt3KjTjO5mnbWsa
         NcIYosD/2BJSKPpFXfypc7BwGJpRIKdQRA0q75wIoPGExABWDxzTH78mvwf15QNRAz
         nkdCPTjwmKVYw==
Date:   Mon, 22 Nov 2021 16:14:42 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: fix timestamp check in tx_status
Message-ID: <YZuz4rJvinnT69tq@lore-desk>
References: <934b51921e22ca6f8983d7cbd9feb5248f804303.1637590567.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="673l5YOoA4Vyf7tW"
Content-Disposition: inline
In-Reply-To: <934b51921e22ca6f8983d7cbd9feb5248f804303.1637590567.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--673l5YOoA4Vyf7tW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Should keep SKBs only if timeout timestamp is still after jiffies.
> Otherwise, report tx status and drop it direclty.
>=20
> Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---

I guess this fix should go in wireless-drivers tree.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>  drivers/net/wireless/mediatek/mt76/tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wirele=
ss/mediatek/mt76/tx.c
> index 11719ef034d8..6b8c9dc80542 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -173,7 +173,7 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct m=
t76_wcid *wcid, int pktid,
>  			if (!(cb->flags & MT_TX_CB_DMA_DONE))
>  				continue;
> =20
> -			if (!time_is_after_jiffies(cb->jiffies +
> +			if (time_is_after_jiffies(cb->jiffies +
>  						   MT_TX_STATUS_SKB_TIMEOUT))
>  				continue;
>  		}
> --=20
> 2.18.0
>=20

--673l5YOoA4Vyf7tW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZuz4gAKCRA6cBh0uS2t
rEFuAP97vLFYKpu0U8Rl6cOHSd6z6G8TGo+93uHanRCsuZQ5WAEA0b0MKC462mlF
w5IkoKlkba+PMqAWwyuq8Pm4RLG8pwA=
=JGvl
-----END PGP SIGNATURE-----

--673l5YOoA4Vyf7tW--
