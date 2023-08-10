Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1D777293
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHJIPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHJIPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 04:15:14 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE410C4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1691655311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLlflyYOngEb2hRwNwugn1tbiottu6X5hyIKDMBoaAk=;
        b=JjL5skd+laa1ZwveR79V9J9EC64MRni9MkP3prlWPFyZ2iz7HFe3qhNq3Ko/ZcZeDvMz9X
        ok57Jn+v04/zDwRK9HLmcocvY3OCxSJ3DFWTVCA3MBtG8W/Z+lQsh/ARZTN5O1AWll9E7R
        fExEWWYQ1kQ1AGUiERGlJKy/TAL9N0I=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with extraie
Date:   Thu, 10 Aug 2023 10:15:09 +0200
Message-ID: <9198694.rMLUfLXkoz@ripper>
In-Reply-To: <4161316.1IzOArtZ34@ripper>
References: <20230809081241.32765-1-quic_wgong@quicinc.com>
 <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
 <4161316.1IzOArtZ34@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3052943.CbtlEUcBR6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3052943.CbtlEUcBR6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 10 Aug 2023 10:15:09 +0200
Message-ID: <9198694.rMLUfLXkoz@ripper>
In-Reply-To: <4161316.1IzOArtZ34@ripper>
MIME-Version: 1.0

On Thursday, 10 August 2023 10:09:25 CEST Sven Eckelmann wrote:
[...]
> This was for ath11k. See my patch for it in 
> https://lore.kernel.org/r/20211207142913.1734635-1-sven@narfation.org
> So I doubt that it is ok to add the same backtrace for an ath12k commit.
> 
> And if I compare both patches, it looks to me that you don't handle the 
> params->extraie.len > 16 bit (see WMI_TLV_LEN) in ath12k.

Ok, just saw that the v1 had handling for that but it was not split into two patches.
https://lore.kernel.org/r/20230809081657.13858-1-quic_wgong@quicinc.com

So just ignore this remark.

Kind regards,
	Sven
--nextPart3052943.CbtlEUcBR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTUnI0ACgkQXYcKB8Em
e0ZjHw/+N9VA/8VaWv4Ms52vwZTowjPU8NgfkaPnSVx7boynE9sun1JujW6P+SXj
pDCb9++Sm+yDdHfPN/j5SYKh5HqqZ/YKNzy0Sesz6TJLEzZBaHoLLFIJfid71Czy
QcNAK5M9g97OlMGgo/tVsE0BA6+2LKDplMiwBmT/p4RGS7VM0aw8lY9L6ElcHold
TiPDpJyWjk9hT9S/Y0rSEoeyOKgpOBAoYEgIpR+s5F8OgCt/HivImemFQkQOhoaE
dU1oKB6/gqIYURzsOoZGCMJuNyf+7JcAP+gPWs5otHqYPXIoDEjOEO9OzyD0g2GS
hNvsKtvOjUVqILZH7Y6VS2YA0LAho37z6WX6M/UW8Mhaebjjj0vu2T5n5DuJJwUS
5LbZyLhKoMAD6JcvbEFJ5U8NIoQwC++39dK+Gjw1rjEmAMQg/FA0dHjvD6Wn74uI
YBrryCkE4uZCw0gmar9LVXibvzFjXV3iOHKGZm2gmkJ8LPU7KTb9Pve893zOaZ++
H2qP9VVfXqXAYQfTsxk/90PXR89kk52B5MNSHCZ3sQELSDspb84zs1sGnTvwNVUf
pQgfCbZt3eDr2SVYXZ56EuoEMUT3EUKaT6bPPLHlhjNBexkDXrReX486kGWQwzA9
tsVlxxGhdH1LrZJiFOYHaSTh+E8o/R2McMT6w57OJcfj8+lptYs=
=BGuC
-----END PGP SIGNATURE-----

--nextPart3052943.CbtlEUcBR6--



