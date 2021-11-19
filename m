Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B4457025
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhKSOAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 09:00:02 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:43910 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhKSN77 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 08:59:59 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 08:59:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637330214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDh2Gef57VIrw3JCOhoreOyscn4mWGROcXDUPaTYRHU=;
        b=1FH3GsiIuqk9MfZBfqTih9QEDTPGeLAuiThZjHfujj6Z0YcJr2eg19OZgVrxyq5co8aqKS
        XlEQVCTdsNa8ulX2DxfqucUUem4LJobzCLNLPq4LPNyTjdAhmMxpjRowUb9iGPKuQTQq8X
        CCuYNTUl1qICtwetDDhmyry11QRNJeU=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATH v3 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Fri, 19 Nov 2021 14:56:45 +0100
Message-ID: <40959183.USSs3XEnCI@sven-l14>
In-Reply-To: <1637244892-27267-2-git-send-email-akolli@codeaurora.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org> <1637244892-27267-2-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4088782.isi6uL5OL7"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4088782.isi6uL5OL7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATH v3 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date: Fri, 19 Nov 2021 14:56:45 +0100
Message-ID: <40959183.USSs3XEnCI@sven-l14>
In-Reply-To: <1637244892-27267-2-git-send-email-akolli@codeaurora.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org> <1637244892-27267-2-git-send-email-akolli@codeaurora.org>

On Thursday, 18 November 2021 15:14:52 CET Anilkumar Kolli wrote:
> +                       if (of_property_read_u32_array(hremote_node, "reg", reg, 4)) {
> +                               ath11k_dbg(ab, ATH11K_DBG_QMI,
> +                                          "qmi fail to get reg from hremote\n");
> +                               return 0;
> +                       }
> +
> +                       start = reg[0] + reg[1];
> +                       size = reg[2] + reg[3];

That cannot be correct. Since when can upper 32 bit and lower 32 bit of an u64 
be combined with a simple "+" and no shifting? And why can you operate on the
reg without getting the address + size cell count?

Kind regards,
	Sven
--nextPart4088782.isi6uL5OL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGXrR0ACgkQXYcKB8Em
e0YWphAAoi8XgHm6HgBiHPw5kiqY+4Y+gqOXmJ+wdBpNEgosjJTQTNMC63+cR3+G
d1sIxFo3PDESFnM+1ECTEOQhYbJcG3AFtEwX06vYgtnaifR099MtW5cvLxyEfD3G
2updTMGLyYDCcrRHUpCrpe+JTuHLMZQBgbmMFtb//hs5YYtRP0DXObULwYStBMQS
Qsa2mqzSvzqmP7cUCVDPS1ERRSsUl61POTRi66c4x3vZH6B303OF9Al3eWbQ5VP5
sltJLngIIrHrl96LTb50ETEYsFbTFORed2tY0AKDVwL7LgEy6ZmUj4xypDVktxV6
gRgn64ccfXvUr3OWtCjLGp6yMNQokpHNJuazuLsQ4DbzdMzVuARWlBgfpn2o8XwQ
FqY7c/GJAUUmM7P2RT8hjnXnheZxnFdU+XYwqXBYfDi2AwLpFwL7se8FsR7UwU1H
C3gxOgU+UFSGEvNITubPl+qdxVEjzzUaKKz3arwqnzNmI84HgKNTlw6Ih8ypyl8g
1xjrioaQodhkQx75ZJuhQWzOgi9H+6hJrQck9k1czQZnCEA9ftzIWaTlGnJe03Ch
tYLbjnGh4Vx4SbIeHAWVuv7f7se04HjhgM0VsG3PtvxbA6ID2JAOxxNrkOD4Lb4J
KqbWQrF/5b5PkWo+duFcn8S4dehVJDOVg/z2RAPs3gHFgd9iO5w=
=ahX6
-----END PGP SIGNATURE-----

--nextPart4088782.isi6uL5OL7--



