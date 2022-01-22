Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46A496C06
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiAVLWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 06:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiAVLWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 06:22:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB50C06173B
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 03:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 837C4B817A0
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 11:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F59C004E1;
        Sat, 22 Jan 2022 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642850553;
        bh=Bs96ov4AUGG+3BWAOX5/gp8rMtv0HA80uFNRw2AcKQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9sKYF0oobfs9Ve/yxGDbF9NHPyb/gv2tzAXLkLDP9+R8YtRITwv6fmYIwYCXRtp5
         JOiywFRaT93yNLkbckduPOdYB+qB+kaas1W/AUKyXbmnrHfmuQbba4COHITmNKUSXh
         dByQtEWhjtlYST7B8u7IXlaHzT8DtzeO31lmuq+35bVio3bbJsQyMRscJaVH7/UUOp
         Lv1Sf+gSQ/LEbwr8h4E3iBEuGNwHsLEOGh5gnvjW9AkYC+7uI8hy0rdTYpR7L/nnlj
         0wYRBcRMmSBDr9LYPPVC8QOw6LqQ+YuAEBUTvbVHIlzm6iB1p5ZOMoBUJLKmv4QQeQ
         t2tYRT2Nbn45g==
Date:   Sat, 22 Jan 2022 12:22:29 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76:  Ensure sale skb status list is processed.
Message-ID: <Yevo9fhaPeuS+e7C@lore-desk>
References: <20220121195548.17476-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdtrgTUa6WyzUa/J"
Content-Disposition: inline
In-Reply-To: <20220121195548.17476-1-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--xdtrgTUa6WyzUa/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> The old code might not ever run the stale skb status processing
> list, so change it to ensure the stale entries are cleaned up
> regularly.

I guess this work is already performed in mt76_tx_status_check() executed by
mac work (e.g. mt7921_mac_work()) where pid is set to 0 and the first lookup
will always fail. Have you identified an issue in the current codebase?

>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
>  drivers/net/wireless/mediatek/mt76/tx.c   | 24 +++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 37d82d806c09..bfb68788251f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -271,6 +271,7 @@ struct mt76_wcid {
> =20
>  	struct list_head list;
>  	struct idr pktid;
> +	unsigned long last_idr_check_at; /* in jiffies */
>  };
> =20
>  struct mt76_txq {
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wirele=
ss/mediatek/mt76/tx.c
> index 938353ac272f..b6f0d74fd563 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -157,24 +157,35 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct=
 mt76_wcid *wcid, int pktid,
>  		       struct sk_buff_head *list)
>  {
>  	struct sk_buff *skb;
> +	struct sk_buff *skb2;
>  	int id;
> +	/* Check twice as often as the timeout value so that we mitigate
> +	 * worse-case timeout detection (where we do the check right before
> +	 * the per skb timer would have expired and so have to wait another int=
erval
> +	 * to detect the skb status timeout.)
> +	 */
> +	static const int check_interval =3D MT_TX_STATUS_SKB_TIMEOUT / 2;
> =20
>  	lockdep_assert_held(&dev->status_lock);
> =20
>  	skb =3D idr_remove(&wcid->pktid, pktid);
> -	if (skb)
> +
> +	/* If we have not checked for stale entries recently,
> +	 * then do that check now.
> +	 */
> +	if (time_is_after_jiffies(wcid->last_idr_check_at + check_interval))
>  		goto out;
> =20
>  	/* look for stale entries in the wcid idr queue */
> -	idr_for_each_entry(&wcid->pktid, skb, id) {
> -		struct mt76_tx_cb *cb =3D mt76_tx_skb_cb(skb);
> +	idr_for_each_entry(&wcid->pktid, skb2, id) {
> +		struct mt76_tx_cb *cb =3D mt76_tx_skb_cb(skb2);
> =20
>  		if (pktid >=3D 0) {
>  			if (!(cb->flags & MT_TX_CB_DMA_DONE))
>  				continue;
> =20
>  			if (time_is_after_jiffies(cb->jiffies +
> -						   MT_TX_STATUS_SKB_TIMEOUT))
> +						  MT_TX_STATUS_SKB_TIMEOUT))
>  				continue;
>  		}
> =20
> @@ -182,9 +193,10 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct =
mt76_wcid *wcid, int pktid,
>  		 * and stop waiting for TXS callback.
>  		 */
>  		idr_remove(&wcid->pktid, cb->pktid);
> -		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
> -						    MT_TX_CB_TXS_DONE, list);

I guess it is more readable as it was before.

Regards,
Lorenzo

> +		__mt76_tx_status_skb_done(dev, skb2, MT_TX_CB_TXS_FAILED |
> +					  MT_TX_CB_TXS_DONE, list);
>  	}
> +	wcid->last_idr_check_at =3D jiffies;
> =20
>  out:
>  	if (idr_is_empty(&wcid->pktid))
> --=20
> 2.20.1
>=20

--xdtrgTUa6WyzUa/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYevo9QAKCRA6cBh0uS2t
rNUnAQDf/7olCCQvApzArT+9vPGdEOZoxdabiKvDgaXXh5XbdAD/YJHlx4nzw2M5
GEdl1DitsnCZrn8W19w+1V9KSjCLNAI=
=Nds4
-----END PGP SIGNATURE-----

--xdtrgTUa6WyzUa/J--
