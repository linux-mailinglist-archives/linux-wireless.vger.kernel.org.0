Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06336777248
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjHJIJy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjHJIJk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:40 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDD2704
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1691654971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWf7pVy4VSkBn4LU83suocRKaD90O0axOs+3iQ7JA2s=;
        b=n17IXXXh5p46YQz//PUBcM6ylgfUMMCLw5qoBoXGwRojP5iDssn8Uag7pylYIFd++Q+qw/
        JYABeshYLWhne/4HR0kUYT+YcxKGOMmVyfSqm19Ha9vL7Xa+dStDZ99gFLRMV3F+y+KnMH
        yYKCX1md3cu98kJcxQJqPpwC3OMiUOQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with extraie
Date:   Thu, 10 Aug 2023 10:09:25 +0200
Message-ID: <4161316.1IzOArtZ34@ripper>
In-Reply-To: <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
References: <20230809081241.32765-1-quic_wgong@quicinc.com>
 <3206e181-f770-c599-87e1-364114b9746a@quicinc.com>
 <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2644003.BddDVKsqQX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2644003.BddDVKsqQX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 10 Aug 2023 10:09:25 +0200
Message-ID: <4161316.1IzOArtZ34@ripper>
In-Reply-To: <db119d06-7549-3be9-524f-327485d34da9@quicinc.com>
MIME-Version: 1.0

On Thursday, 10 August 2023 06:31:02 CEST Wen Gong wrote:
> On 8/10/2023 2:16 AM, Jeff Johnson wrote:
> > On 8/9/2023 10:31 AM, Jeff Johnson wrote:
> >> On 8/9/2023 1:12 AM, Wen Gong wrote:
> >>>
> [...]
> >>
> >> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >
> > Wen, can you please add a Fixes: tag since based upon the discussion 
> > you actually observed a crash
> >
> Jeff, do you mean I should add the crash call stack or other thing in 
> this patch?

I think a reference to the commit which is fixed should be added.

> The crash is observed by Sven Eckelmann <sven@narfation.org>  on 07 Dec 
> 2021 here:
> Subject: Re: [PATCH] ath11k: enable 
> IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
> https://lore.kernel.org/linux-wireless/3267805.el9kkjlfUZ@ripper/

This was for ath11k. See my patch for it in 
https://lore.kernel.org/r/20211207142913.1734635-1-sven@narfation.org
So I doubt that it is ok to add the same backtrace for an ath12k commit.

And if I compare both patches, it looks to me that you don't handle the 
params->extraie.len > 16 bit (see WMI_TLV_LEN) in ath12k.

Kind regards,
	Sven
--nextPart2644003.BddDVKsqQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTUmzUACgkQXYcKB8Em
e0aMaw/5AZ4D6mNNbQCEz4PivXFwvT/Wz/zdb5/b1JfgZXmtIdUQg6wgVJYzVO6g
yL5RVKYfMKG0aITyAWQvI9eSYabuAhLZKFucdjArwtPVY1u07x0pzbH81yP8Wfkn
nzYW1IG8FafG6LV0oYpQf6xr30layDjhq6VPHaVmx4Bap5yaY7kRpngNTZCtNEoc
7zpH+VgUJQu+5qMfHe3A8kgS7Tg8GhhXW/AOh1DHrKoK7QjZ5FueR+jdVq2iDyCa
K7wyIurAmltLm/xJxxIeMkYd05p06tLWAYDjz7oYT8yDiNaOAFQGMAiQ6OGn/wJx
h+rCNP0EdUOeGVVRGHe8CPHW+iHn91KRicNsjV7kZ0dZQ/L8a8e6ekwffw8MS9wg
1bq6+O7+n4sIMfZGqhX5+2m+a2BRZIdK0Paz1u/E27k1G+ETubk2ITCKjJ/sPLBf
nl3BhRa6woAhhy7PSkAkUEGxnineoTmhhEn47yWmBtDDHQ46zDUKZ61C83iwYEPk
FEkthQTXF3jN0/xYRGbwcPZN78AgnyzeeD4tUO1Os7rVMrN8QsoFhEJg8a55/xMJ
neipHEWxOTKs9JR5arxDcWDokiq4TjOFDE3kcvHK2fL/cOmJJ+DKq4/88f2Ye1mo
jLOTCZtO/BcxUV83E5W23VcYakZTWzkyXyJzKWJv4uuIumdLMg0=
=bxKb
-----END PGP SIGNATURE-----

--nextPart2644003.BddDVKsqQX--



