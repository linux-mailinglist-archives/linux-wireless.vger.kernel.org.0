Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B971C45A367
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 14:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhKWNEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 08:04:52 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:45382 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhKWNEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 08:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637672502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bXSoijhcsdVseGfeNV9VthAVOTN6+8WFm2JTxPImEc=;
        b=t1qGzy6dQIGokgeXiy83J6z7zvdnHyXgIoP0i7C4RuTPoZcxErUDBOo2UDhMhgjdf5YvUP
        /eOiAILGUpk1GW03KVRklb2BJXKsiOMOR8ODS1jcoWu0mhihlHETsqMjbIA5K8mAopGEAu
        lEZ12cwDpXQuWp9vXXKzOS5YKEJ3n/s=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH v5 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Tue, 23 Nov 2021 14:01:34 +0100
Message-ID: <74442923.uYUSDj6SXF@ripper>
In-Reply-To: <1637666940-30548-2-git-send-email-akolli@codeaurora.org>
References: <1637666940-30548-1-git-send-email-akolli@codeaurora.org> <1637666940-30548-2-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8316323.Rvb1ZgBP0e"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart8316323.Rvb1ZgBP0e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH v5 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date: Tue, 23 Nov 2021 14:01:34 +0100
Message-ID: <74442923.uYUSDj6SXF@ripper>
In-Reply-To: <1637666940-30548-2-git-send-email-akolli@codeaurora.org>
References: <1637666940-30548-1-git-send-email-akolli@codeaurora.org> <1637666940-30548-2-git-send-email-akolli@codeaurora.org>

On Tuesday, 23 November 2021 12:29:00 CET Anilkumar Kolli wrote:
> +                       ret = of_property_read_u32(dev->of_node, "memory-region",
> +                                                  &hremote_phandle);
> +                       if (ret) {
> +                               ath11k_dbg(ab, ATH11K_DBG_QMI,
> +                                          "qmi fail to get hremote phandle\n");
> +                               return ret;
> +                       }
> +
> +                       hremote_node = of_find_node_by_phandle(hremote_phandle);
> +                       if (!hremote_node) {
> +                               ath11k_dbg(ab, ATH11K_DBG_QMI,
> +                                          "qmi fail to get hremote_node\n");
> +                               return ret;
> +                       }

Afaik, this can be combined via

    hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);

Kind regards,
	Sven
--nextPart8316323.Rvb1ZgBP0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGc5i4ACgkQXYcKB8Em
e0ZyPQ/8CbZDas4jD05U2eurivg669Wkd8ldicZqVa9YAcUJWEYYE2zMgWFuVnfJ
4z3fPpQd1Mtp8KRrayLCfOi5HOpK8uOGH+JLodjwX0aBewI8EZiHL/8onrpuqtNe
tKEiWZG5WTA0ltntf6SqeV5TF2L5R+ySknNPk4LKYsP6/E7iZ4EM2TM6FTxzbc+h
z2xeFWViRbGTw23qJBb0DKtagzQVScoGvEktpDy79HdAEntUbDlQSerS8kiXd7Ll
yh+dgg+piQ9VS3E+KZ6NhR/2CnWYFI0xBFggxGIX5/VVJxD8GK+zlkkYTbtXUGPE
vu1NoJtQNqfJsdzvVVxWMY5t6VFa8uBreo3C7PSUK+gR9Cg7vL1A13BYn8npdloH
V4DcB/USCX8yyhozQMwfEojvCRfG5uvAM0untitGwYqNRAMrHsQgL57rJ/gdemhX
SROOFG2wZI4VW5DQru/BRf5HEj2fTRNAqnctJX6mYZVjg9Kt5vdMij1AXQrvUl8A
qrGuu634XlfqCHBld3CxTu08lxaK6tOlD34vRAZL3cC1MT7FMYY5zOd/9tcvpph8
GgEk5fxrr6wXpw+S722w2Y4KCw+3tMAzl1mpKJ/V7+y/SdqZBBCPE720e9zf4w+L
TYTN7y18wTfMVqF1n/WvhBc2ZYeBpxRnt7If7EIssZiB0RGJiPU=
=LV2O
-----END PGP SIGNATURE-----

--nextPart8316323.Rvb1ZgBP0e--



