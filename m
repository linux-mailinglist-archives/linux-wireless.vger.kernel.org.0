Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E77475AD9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbhLOOnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 09:43:11 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:19348 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbhLOOnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:10 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 09:43:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639579025;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=ejh9MaZEoGFEFVzMn0biitEw8Y7aNLP1PcPwLXGfzoA=;
    b=N3m3h6iyjLXSd7/wtk6TidcSKQ9JFZJAgJcnHgpUz7pX+gKcQdB38ScCQJ4dk/Gmf9
    kTL/VtQXwHzAuv2ONwndp37ehty1/hRNJaLyPOaepEFnQJHOdO92PLCzjt6jhjgRjLyb
    WIWlv7pcen7dvolQ3WQqk/zPQDZpc+US5xb8WoMCh1cw2SUyKhh055FoOgy5n5kgcQtI
    s9E4/wDvukhuFiC949gtyXO5kygLSKrEeJUavFPWS67Mvpw5t9Uww1Ra1CkXACZX4XOG
    iX4dM20HXdncmK+/v19j/0oTCBXi9KNhK/LhW4jhfZMMqYhZUqDrg2s1xqxpwN4FChgQ
    7tzA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisErWh6LPk3spTL101mGmwQHB2ptS7Er3KB6PpXx"
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id z0a241xBFEb49As
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-wireless@vger.kernel.org>;
    Wed, 15 Dec 2021 15:37:04 +0100 (CET)
Date:   Wed, 15 Dec 2021 15:36:57 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-wireless@vger.kernel.org
Subject: downgrading a wireless connection
Message-ID: <20211215153657.10d6ec53.olaf@aepfle.de>
X-Mailer: Claws Mail 2021.11.07 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ETFZlZqFg1t3jtsls8BEpU_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/ETFZlZqFg1t3jtsls8BEpU_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

https://bugzilla.kernel.org/show_bug.cgi?id=3D214231

As noted in this bug, a Galaxy S5 is able to sync a large amount of data
to an iwlwifi device. But a Pixel 3a, and also a Galaxy S7, is unable
to do the same.

I wonder if there is a way to "downgrade" a wireless connection such that
the 3a and the S7 use the same connection parameters as the S5. In case
this can be done, I hope the wireless connection should be reliable
for all three clients.

How do I see the connection parameters for the various clients?
How can I change connection parameters?


Thanks,
Olaf

--Sig_/ETFZlZqFg1t3jtsls8BEpU_
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmG5/YkACgkQ86SN7mm1
DoC+dQ//UV0ZtoiZ2Cee3e3Y7vsFPqecIe1ZnkJ8/2GdAAgIrkzHluBnaCOciGOi
vRcIIoPUzWiZ7NflIDSzVxPBCSBIzxzhl1p9KTQjqTq5eHuKi9Kl3NoM0u1LRwVl
QVHSielBYgaoI8PivyKKiI0W1Tn717ZMJUL2rD7q3fma8Pf9UeykjrDnj/7ykfG+
sapfY/J+txyZ5lvbbQ0U5eN7fQwAySwCRdAACN4CpMc1iXP7yuTUBdJ9EeWwd9zE
Wh1HH2YioCt3nB3bZxHCg3SLIte3dFPWPWXXu7QeCJLQmHYfuAP2yC3JvwIYjlsQ
Cdvv8/QFBXcgQZ0vPPQpI5i/+mrZAcYKBJKFkBxX9F2WFrOHYmzTSYoFgcXv13vs
ly3vkJ3stAnf8AMeWd+duWSwOOhoKSuHoWHL/pTmbifPTcTKF1F2/MqaOVHz9wzK
mKVC2zZ5NQBgt1w+JKm+4R3AehtTPrjzGkaLd9Nf+NsiaMyvqxeamjX77JiQyg42
CwFmhqaCtiRrpMH3CBn8M0kp7T1zh6sQZhuKj0DaqEH8lh0oX9uTjg9n+dZGdpuk
udkzp3sG7qdEtRtQiGCHXXxlm45SjftQNjDEqckdbscYbevoa6vfn7uVqzfwQv0M
TErlSidgclt8dcKIKe4+7flcaUpLHcKcUuVoeXHodmvDmD/Dlis=
=EDFy
-----END PGP SIGNATURE-----

--Sig_/ETFZlZqFg1t3jtsls8BEpU_--
