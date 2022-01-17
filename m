Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66217490A48
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 15:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiAQO3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 09:29:55 -0500
Received: from mout.web.de ([217.72.192.78]:36709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbiAQO3y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 09:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642429793;
        bh=U8DCgnYeYcxryoKneOBMvXqg6aaJduWJhZvJpy2BCvo=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=f/Xoso3gI7pSW8Ebleat6NnvLUPTeX46NG2fcU2IzdooNe/vaWh7lUvgHMDBhbqi2
         z3pxI6T7Njh+DdfXwg+zFWzQtHwiw0e4C0tPTOKNgBdrd04/Xcs3s6ufhkUhRu1ByP
         +dSRbLvBS2mC2GSwTsaWmbmwM/vJKSQ2OER0P4oY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [80.245.136.130] ([80.245.136.130]) by web-mail.web.de
 (3c-app-webde-bap30.server.lan [172.19.172.30]) (via HTTP); Mon, 17 Jan
 2022 15:29:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-f503010b-028a-4c52-a368-56b3e6a1e645-1642429792868@3c-app-webde-bap30>
From:   fckath@web.de
To:     linux-wireless@vger.kernel.org
Subject: ath11k and the 32 MSI problem
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jan 2022 15:29:52 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:O2r+MzQFrrBl36hi/xk5KVgA3AzRq20/FCY27ja9y8Z3CWhMdQ7pYFsYvYwmGfpKKBMvn
 0tR7C+t8ofjfpYOM8/sK9/xeS8gqH9jw3Lo2HRq175tMJD5Uuo6zHY9oxbHMY+cBnAhpkeBuJKAP
 uGYWgFVGPD1+yGVTc+At64wq5oC5tgVuGlPxL0cnC6ZvqtasXShhq979RQXQXYh9QL9R0imNz1vG
 gM1uJjm3sAGuSwG4x1tkG4CJHJUsqoDnGB0rDFBb+8A1kmCfwInaN4k+2a2nsI25skTSqEcyUMYd
 dg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jgFf+MShmy0=:E8rCQctoEwjNlloU5+Vgp7
 4W6xZ879q+14Psy5CACSg98NMK6r8+eSR8m/7FIL9oaRIG1hWKusef29P8PgBCKkOwJbliUYR
 be0ghuRuP2o1JGO9Huso6XAAuRXMSG6j8TPs8JqRkwGkiewWLIk2rO6VMHSY+VHw4h57VGTt3
 aSdpkuTUY/2i3Q242ZwOlDveAx1IrjMefovA7O6yb8o35JRuWaoVgSnXMTdXdtenKS3QqQEm3
 g2u3Eu3D/FFWEWG/VsSq7XZVmzgLckE2+zD/9A6La/IpCi/J3ayuWNfJYsRUpjATv9J3+mfP+
 hD2xJ/7A5uDrqjs/p28nIlry7naJd+meEv5MeRJ+TJrf/mpG3Ze+qCkrb7WRv5hLYo1gqy3U6
 niHOC3otby93klg6iKnhqudSq+Mw2dnrgSywYPGQ7Qp6DjPcqRaf776jfeFyUbqwU11hnw0cP
 WLH2el6advCKqUfc0NrKs9IyCM9p9+1ezqSvY4pC9eKvuTanYlOfNpk73kKYkREwbC+R2sI0r
 jsB4PC3tUc2+PjhykQf5+gHk/IA0meIQzb5A8o2woTllVcVXV/KCWc1ZvHdKpMtOUxAU1AUls
 pwvzvVhdhSqLbfMGObU7SqvAI4L2+QaXH0vh7hWK3cUWCwU28KE7ggtypGKkKGHYsTNoj1xt2
 DRRxVwl0B6sxfpkX2zTKyOZG8g16YVJsAtZb8La2AwBZB7SqQ0IZSwW6dUXNrzPeFuiiqeM3U
 pMuY13cV8uyz9ArqkN/zIGDs3BJIg6ofgKFOw21p6nMN9/KY3bnLQkouIPnPRNFaQgfLrrsvL
 /5oEAEA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello world;
=C2=A0
I've got a bunch of M=2E2 Type A/E Wifi 6e cards from Emwicon (WMX7205) an=
d Sparklan (WNFQ-268AXI(BT)) wirth Qualcomm WCN6856 chips=2E
=C2=A0
I'd like to use them on DFI AL553 3=2E5" SBCs with ATOM E3940 processor (h=
ttps://www=2Edfi=2Ecom/de/product/index/1409), but I was hit by the error m=
essage "failed to get 32 MSI vectors, only -28 available"=2E Ok, it seems t=
hat the Atom E3900 does not support VT-d=2E I managed to get these card wor=
king on standard PCs with i7 and i5 with active VT-d=2E However, when disab=
ling VT-d in the BIOS I get the same behaviour as on the Atom boards=2E

I tried the single MSI patch on https://wireless=2Ewiki=2Ekernel=2Eorg/en/=
users/drivers/ath11k but failed to apply these patches to an 5=2E15=2E0 ker=
nel from Debian backports=2E

Are there
 - patches for 5=2E15 or 5=2E16?
 - patched drivers for 5=2E15 or 5=2E16?
 - information where to find a matching driver source on which the patches=
 will apply?

Best Regards

Frank-Christian Kruegel

=C2=A0
