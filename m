Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C57311C9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbjFOIKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjFOIJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 04:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B21A3
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 01:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345C261E6D
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 08:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18941C433C8;
        Thu, 15 Jun 2023 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686816587;
        bh=ZAt5rBYCwVr1kW0vzedsjGJ19usAHQ8JPGxfPNMQXTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHPhE/9deuZaO7L1R5Ji1N8NgXBwDYX2IoWDgHTVxR/B3J6Sm9ZHsGJEi9HMCdz+J
         qGWCkrIWrH/wdFLPXHXV5VYOAjzZKcGpkTFRDf5m1CZSibWXiREio8VXsW+qbyJxon
         sr7AIiLSo90iC46NB2a+9Y9jx1e2YSk9ZeVHD9a3iLEy0yFXaTQqM/TDPLJG+2AUD6
         T9wpdczeYYeqeD60/VAyJJMhrqXhPHqnQkBHyRyC2VUVTh24rBSoa4aF26wTtnPwWL
         DitmG6dhszoUUVbbQ7uCqa3mkkybGY2KKOOYDm1j4Q+Oo/gL1423M0PKDBZU9T8Xkh
         Dq4XxMaRWoBdw==
Date:   Thu, 15 Jun 2023 10:09:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: mt76: add git tree
Message-ID: <ZIrHR53jAUPeDg/F@lore-desk>
References: <20230614144704.505553-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VewxizL/3ceCZg2v"
Content-Disposition: inline
In-Reply-To: <20230614144704.505553-1-kvalo@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--VewxizL/3ceCZg2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Felix has a git tree for mt76 patches, document that.
>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0971854323a7..f7d7fdf47dd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13212,6 +13212,7 @@ R:	Shayne Chen <shayne.chen@mediatek.com>
>  R:	Sean Wang <sean.wang@mediatek.com>
>  L:	linux-wireless@vger.kernel.org
>  S:	Maintained
> +T:	git https://github.com/nbd168/wireless
>  F:	Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>  F:	drivers/net/wireless/mediatek/mt76/
> =20
>=20
> base-commit: 93ae81454b1107843ad36dcdc457dd10ee0f2cbe
> --=20
> 2.30.2
>=20

--VewxizL/3ceCZg2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZIrHRwAKCRA6cBh0uS2t
rAA9AQC1Ow2hhTh42yTsiZk/Fs10aKD/Zp03+Tn4JBnKncyeSgD/WUSCb5tJoAk0
90tpVR8I1tKAzihfTjLBByLGidiu9Q0=
=uOTf
-----END PGP SIGNATURE-----

--VewxizL/3ceCZg2v--
