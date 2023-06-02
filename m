Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B67208D1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjFBSIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBSIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 14:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6C123;
        Fri,  2 Jun 2023 11:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5996611B7;
        Fri,  2 Jun 2023 18:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC27C433D2;
        Fri,  2 Jun 2023 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685729316;
        bh=trVIsllqEc81wyDJ+ten0E5hJ8khH0VhpwFVl2U/LAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd8pv5I1oGyCOTYW2Vsa0MLiGAsZvAO0KCNsbGmIRhmjaVRtqO78eyHxKbMXXYB2K
         amgVLaeVb86YBH8byiFyCoiaeQMR7UvlwkGRzi/Du+OK6Ew1qKi2uyxTDIm6BQ4RRS
         rlrIZUQIKrdMXzRHtFQnYjRKvPGaalflGWO3BS3lW+vvbbDn/QCUFJ+un6dsUaxkeV
         iQuVwM2XqLadTF/cSiJQB/rl1ogDZ3u0n94XiF3r35urP1k+914JMLqOp2Wa38xrEf
         Ld+KriUNvvcApw0Twv8KMaIBkjiQfqPdOl5UtXDao/AxF/wuYCc/TVU1Gmvzwiw3Tk
         GAXDcLMp3x7JA==
Date:   Fri, 2 Jun 2023 19:08:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Arend Van Spriel <arend@broadcom.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] dt-bindings: net: wireless: brcm,bcm4329-fmac: allow
 generic properties
Message-ID: <20230602-playgroup-scanning-0d40123d1007@spud>
References: <20230602135925.14143-1-zajec5@gmail.com>
 <20230602135925.14143-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lZWLL1mZjyEGX5a5"
Content-Disposition: inline
In-Reply-To: <20230602135925.14143-2-zajec5@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lZWLL1mZjyEGX5a5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 03:59:24PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Include ieee80211.yaml to allow using generic 802.11 properties for
> bindings of Broadcom FullMAC devices. That allows specifying frequencies
> ranges.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-=
fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fma=
c.yaml
> index 527f055a6683..4aa521f1be8c 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> @@ -15,6 +15,9 @@ description:
>    These chips also have a Bluetooth portion described in a separate
>    binding.
> =20
> +allOf:
> +  - $ref: ieee80211.yaml#
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -121,7 +124,7 @@ required:
>    - compatible
>    - reg
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.35.3
>=20

--lZWLL1mZjyEGX5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHowHgAKCRB4tDGHoIJi
0g/uAQDgeMmfqJo6Ytlhdux0U7WWCq0qq2Ep8R3Onnz/oLqzhQD7Bqjz1oHC54JN
drBQywo42CJUxZCwwQfYgnk+T6BW0wI=
=KpQ8
-----END PGP SIGNATURE-----

--lZWLL1mZjyEGX5a5--
