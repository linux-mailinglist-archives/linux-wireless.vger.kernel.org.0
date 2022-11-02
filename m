Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295BC6170C4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 23:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKBWhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKBWhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 18:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802BDBC36
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 15:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB5C61C60
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 22:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10FC433B5;
        Wed,  2 Nov 2022 22:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428624;
        bh=HGrNUTgAl8c/oQJAl4TiiTH5QHvDd9Mu7yXf5rzTRao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UudH/B14WAcaNzxlgTJzts9Wo9DUqqYNk52xGI2zi0Jix8vWA1t6fEnG7RFMca4lZ
         zIZ7voUHJqyEf4hJ8ux4FY8rKbSPB0aj8N1O7a14oV4Ih0LXSy8V+QUTweQoRcWnQY
         tD+UkLzfpCL1RT6ali0QhSujUwIcWD/kMbkG+FUTV0wdFkeWO7+itdKKpqVIHc9tZO
         VFecJz/VW0ybiU6blCASnAN3WnSJ8ZuL8D+gfmpGnfyuT+OfMXc+HMKhJfvKCeIUvs
         7Ww2LeodQ0M7KuIVeRHmCMLHC0evmAub+MKemRNqqIc1NiwR0bg+s/a2h0Id/CYMu4
         WJeqJpE2fr+QQ==
Date:   Wed, 2 Nov 2022 23:37:00 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH 01/10] wifi: mt76: extend aggr_stats for tri-band support
Message-ID: <Y2LxDLqPa45Xbe9n@lore-desk>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
 <20221031164000.17063-2-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8OepT4zXwtk9Efj7"
Content-Disposition: inline
In-Reply-To: <20221031164000.17063-2-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8OepT4zXwtk9Efj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 01, Shayne Chen wrote:
> Make band2 able to report aggregation stats.
> This is a preliminary patch to add mt7996 chipset support.
>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index f9bdf16fc6c4..42847b327cb0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -781,7 +781,7 @@ struct mt76_dev {
> =20
>  	u32 rev;
> =20
> -	u32 aggr_stats[32];
> +	u32 aggr_stats[16 * __MT_MAX_BAND];

I think this patch will break mt7915 and mt7921 drivers.

Regards,
Lorenzo

> =20
>  	struct tasklet_struct pre_tbtt_tasklet;
>  	int beacon_int;
> --=20
> 2.25.1
>=20

--8OepT4zXwtk9Efj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2LxDAAKCRA6cBh0uS2t
rEB8AP9Dm5/DXpvQLm3l29yvDhyBM5gPC9tAq05+24dkf8At3QD9HVpnd8JIW8ZR
E4bSiHw7IUPp15+Bp53TQvck0WVT0ww=
=vlXf
-----END PGP SIGNATURE-----

--8OepT4zXwtk9Efj7--
