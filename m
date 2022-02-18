Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965254BBBE4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiBRPK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Feb 2022 10:10:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiBRPK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Feb 2022 10:10:57 -0500
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 07:10:39 PST
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B38EB42
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1645196451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vg8BVEugctsdqPwI+1xt+x/A1mHe6ZYp91WeLa54JYU=;
        b=eXFR0DSRaJbYjUOhzvEXlTL3CrZ2Fo3/Lv/bnaYmDnOKbq+uLpgAmaPpBfAZLyKXJcV9Ni
        A18Z00d7vI8XvLu2juOV0cIcqdNEeasvvS5W85Xjj/HZyzPwzd5TlP03MO+j+wbLRyDeFN
        EM3tgRm+H0wdyOAGCcg13NE+y2c7Gt4=
From:   Sven Eckelmann <sven@narfation.org>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        ath11k@lists.infradead.org, Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PULL] ath11k firmware 20211223
Date:   Fri, 18 Feb 2022 16:00:47 +0100
Message-ID: <4785910.v3KmxWAaZY@ripper>
In-Reply-To: <BYAPR02MB4567669033A210A78AC397E9927E9@BYAPR02MB4567.namprd02.prod.outlook.com>
References: <BYAPR02MB4567669033A210A78AC397E9927E9@BYAPR02MB4567.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1841571.kgKKsBDBsr"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1841571.kgKKsBDBsr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, ath11k@lists.infradead.org, Kalle Valo <kvalo@qca.qualcomm.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PULL] ath11k firmware 20211223
Date: Fri, 18 Feb 2022 16:00:47 +0100
Message-ID: <4785910.v3KmxWAaZY@ripper>
In-Reply-To: <BYAPR02MB4567669033A210A78AC397E9927E9@BYAPR02MB4567.namprd02.prod.outlook.com>
References: <BYAPR02MB4567669033A210A78AC397E9927E9@BYAPR02MB4567.namprd02.prod.outlook.com>

On Thursday, 23 December 2021 15:03:04 CET Kalle Valo wrote:
>  ath11k/QCN9074/hw1.0/Notice.txt  |  802 ++++++++++++++++++++
>  ath11k/QCN9074/hw1.0/amss.bin    |  Bin 0 -> 11897676 bytes
>  ath11k/QCN9074/hw1.0/m3.bin      |  Bin 0 -> 340108 bytes

This pull adds the firmware for QCN9074 but not the board-2.bin. As result, 
the initialization of the ath11k PHY will fail.

Kind regards,
	Sven
--nextPart1841571.kgKKsBDBsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmIPtJ8ACgkQXYcKB8Em
e0Yz3A/9H7Gix3bMBn50gieAjVOm8JW0B2vM5dhPl2Ngaz0FT6ZiL2hLXlVaAZ8A
HDcsAgv7R2bTyhElm4sp8nd22kxI7HwspU7B4KcKRFgYqBFrCcVQAezU539d3src
Cto4gDAeOA16BgkgLP6ha2mLOttKg6hWsH0j5ye7G3NPVMl9RX95a4OfS9CXQqG5
oS5iYamhuMThcEE6oYsITf3Ayd+baTPUcbEWZJI1aPVQg1vIYOAEJP8hSsuPxLJL
2tM/4dxU1F2doCWmpBbA3H2yAjgyJwY7UNxABsyvo3kZ133QU2FBxUyQ3uooGOGK
+uSZ+UxoxGOn0BNcUQ5pxRlqva/bfcb5n57GLA4EkpkA4H8yftdFu5MMYVsACmFC
L71qk37kBSoqOAJwZtUj4/dvdmqzXRvmaUR+i9eF7oPyIx7NCU5r8duIhIbaQbX7
Pi/PULX3kRh1vV+laJ0E2fmJfFzApTczOGtJQs0i8nRCD87+XjI4bXV+/ueOD9ON
S96B8RQU6SGFGwwAmFESJ4fTHTUrhQPVLXzy9OMRrIGJU71Wbo9BefWxr+sjk55P
yQcOhcZreU7SGWSWcpvr6k6ZsqMZt4nG8YgxV0TUXGPL7KwGTFRBw3KRJvjvH7dt
QNCNMWh82LD9PD2FZGovpxH7jr+LuuYrxfUUeXjRVyc3vRHMQPI=
=VQAG
-----END PGP SIGNATURE-----

--nextPart1841571.kgKKsBDBsr--



