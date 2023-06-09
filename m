Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F7729F22
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbjFIPuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbjFIPuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 11:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC60635BC;
        Fri,  9 Jun 2023 08:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC0661C5A;
        Fri,  9 Jun 2023 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053D2C433D2;
        Fri,  9 Jun 2023 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325788;
        bh=VujHTb3Jst7P7AKBSUf6SEnI2gqNIkp0cYDL1jRQ5Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWXiQoWUZrbEzGfv1didX1XWnGpeFeM3Z0E5xFzq1wZBaoT+OTdszCqjUwy0vmHzA
         X/7EPPA2WhjAo3F3jVs4bVDMkDHGijdyvrla3eg+6VFKx6NOtifHDjTLZ+ygZaxcpp
         Ca8sGBOFBEoK2g5OG66BiWNwPKQM/z0CikQQvwqFbgL2nGGf/sGRdSjTy+bqT3iLOD
         7WMHt+XsklMQxtJCVebXjk07aKWzN3RADgbrC/gOV0KkoVn3jrhAcnnmolSu2uRnI9
         HrMbHmE6SyFeoiplswxjwGxg70IF2hXNATe6aE4Mbr9UEsrIzUWBwXu/HLL04U2oXh
         W/z4gj442vyrg==
Date:   Fri, 9 Jun 2023 16:49:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: net: ath11k: add
 ieee80211-freq-limit property
Message-ID: <20230609-carded-stipulate-439950812469@spud>
References: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hr0x/gMYpYr/cxtg"
Content-Disposition: inline
In-Reply-To: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Hr0x/gMYpYr/cxtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 10:44:54AM +0200, Christian Lamparter wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
>=20
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Hr0x/gMYpYr/cxtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZINKGAAKCRB4tDGHoIJi
0g+3AQCFQ8p2CNxwxmughCknWM1xVeucR0xBQ1yAXg8iamMwtAD/RLoywsac7z6f
gp1X+1swDTOiyPsYQXc2tf41bBIHxw0=
=CDm6
-----END PGP SIGNATURE-----

--Hr0x/gMYpYr/cxtg--
