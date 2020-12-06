Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D982D05D7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 17:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgLFQGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 11:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLFQGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 11:06:47 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C02C0613D0;
        Sun,  6 Dec 2020 08:06:07 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Cprrh0NCNzQlXZ;
        Sun,  6 Dec 2020 17:05:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1607270738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8JzY7suajkVMfhZ42n7nxDHFMguxx5XXAFU43lWh/uk=;
        b=WJ3f4qPT1GayhhvRDBSMVsG6k9c+R0hm25GGegjQWo5r4Ov2eYehnDEfTw6djgWSReC1IZ
        nAG0JNmPBH/S+5vjVcFFaeeJ2Wv9cK8Wb4jUMJ33lssj/uqgf9OuhK+Lz+PKCQ3QdgBOXD
        K10SSaYcxu/5qB9787/ZWly+8Gby7kAPEOaFxMjeuTG7LVQQ9+7oDqv9Y1+tO7sCjeioSC
        91LR8A7h56C9hOgWECVtpgPHvEpBbBDWSRDoM6vbbpLM+qYYmBz+3i3Wqd9hhcLpe3Rynz
        g4iofBvux1jGEgzZc3I6sdHAkLjPjpyCaaeRrrpYaSN0sBgA8mT/nr0OHxGmkA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id VmRRN7YIUDzM; Sun,  6 Dec 2020 17:05:36 +0100 (CET)
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 4.19.161-1, 5.8.18-1, v5.9.12-1 and 5.10-rc6-1
 released
Message-ID: <4a0da906-e3b7-1a94-8c26-12bf7cbca5f5@hauke-m.de>
Date:   Sun, 6 Dec 2020 17:05:31 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BdxyMquMNx5cmnkVXb4h5Kwo5BsHaN4dO"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: CE81D17AA
X-Rspamd-UID: d24b71
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BdxyMquMNx5cmnkVXb4h5Kwo5BsHaN4dO
Content-Type: multipart/mixed; boundary="JDdkwiajmCCrtaMvstEdidH3m3lnk9GeM";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org
Message-ID: <4a0da906-e3b7-1a94-8c26-12bf7cbca5f5@hauke-m.de>
Subject: wireless backports 4.19.161-1, 5.8.18-1, v5.9.12-1 and 5.10-rc6-1
 released

--JDdkwiajmCCrtaMvstEdidH3m3lnk9GeM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

backports-5.10-rc6-1 was released. This is based on Linux 5.10-rc6.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.10-r=
c6/backports-5.10-rc6-1.tar.xz

backports-5.9.12-1 was released. This is based on Linux 5.9.12.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.9.12=
/backports-5.9.12-1.tar.xz

backports-5.8.18-1 was released. This is based on Linux 5.8.18.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.8.18=
/backports-5.8.18-1.tar.xz

backports-4.19.161-1 was released. This is based on Linux 4.19.161.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v4.19.1=
61/backports-4.19.161-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke


--JDdkwiajmCCrtaMvstEdidH3m3lnk9GeM--

--BdxyMquMNx5cmnkVXb4h5Kwo5BsHaN4dO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl/NAUwACgkQ8bdnhZyy
68fJAQf/cq9W6NItfYOkZ2C28Jq2FaW45yTWYLmnVYnhWag00wIXwknqmmP7lAUy
tKN/lUG8UqGbH3378j36spiamo62+nXWQWYA2prwUf5XcUGSRqxCNPMdWDoG5cQm
bEb9z8bVfKgOKchOYU6KUCCGfj1bYnmcmaqpzXU4IDYCk42ltgtfuXCeooLAsN8p
LcIzuVmdFEF512f2pSrWbcAUjImgAJHddIc8e38sgeeIxP0Q108J99fNszmLc8tL
EDti9XlZ7Qsvs+TxQCtBKoRlE8Q+jqLA86LZGP6+XvNtf1cxDLdH18EJeicGyyhf
fLTW4RF1dAdTJ3evF/RkCj1XowTBZQ==
=i90S
-----END PGP SIGNATURE-----

--BdxyMquMNx5cmnkVXb4h5Kwo5BsHaN4dO--
