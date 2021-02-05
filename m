Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C460311388
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhBEV2A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhBEV1r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 16:27:47 -0500
X-Greylist: delayed 1119 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Feb 2021 13:27:07 PST
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26499C0613D6;
        Fri,  5 Feb 2021 13:27:07 -0800 (PST)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1l88Kz-0008Kk-SC; Fri, 05 Feb 2021 22:08:21 +0100
Date:   Fri, 5 Feb 2021 22:06:44 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: Use true and false for bool variable
Message-ID: <20210205220644.0d05f5ce@wiggum>
In-Reply-To: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jz6Nx+otOii=QehdirSLbMq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/jz6Nx+otOii=QehdirSLbMq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Feb 2021 14:56:39 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:

Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael

--Sig_/jz6Nx+otOii=QehdirSLbMq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmAds2QACgkQ9TK+HZCN
iw58hQ//T//CDvkFrpC+zCcZ6qfcfjLrO/d3Wswp1Ta01ZJIVEvpsHKb22VDnrAG
YBnrcN8ZLSsMm9mcQrj4rzfLPhYEIOnaX4+4z8RtZZqwpK97A/3uVsGhx20U+E1k
VwcHiIATbtzh7BeoLOrS/GW6f4zvJ+gld9hctJenKSe1vakBIuZ4ygCVSyX5kuiB
QkWzZmEr4/SnqXAvCRF+CErP9jg3Ks1+uJRLxyj5XbA+MRFEjSajnfZlNiS2No2f
nZxma6I9MpMIqsMLBFWHOWQkAVQPecFqGR25PPcYAe3kUT6vLbKjt4XTC5mOqA14
CgwVynDEhBW4BpG2qzxUbS5/ahgmdbeOtF97aqXwX3fWD9PsFRvMAmYAn5SWKeS3
Mtyvd9X9adDS39DkLtl8BftQ/shHAOS2iTAhfKZ79lnMdl6bcHhP8QvApTVc7mBk
dx2sCT4Wu5uHZBeds0LyCPQCpqkTQ4AG+AhqhaZJV/RBmRTAwVYcx9dO+jTZSPj7
XqTxafxJUi2wD7oAUIM7//Uy8fVvNiYVXrH9Zk8EXYRELY/v0NHlO3SBCxfhHaDm
CfP15YzaNYnzsh8pWFHyTG30hoCzyDNhVezWSTYyWhhrTeB9I/mJ3qMHq27H3J90
0Bt0xnQUDqp2tYPxm+w293AIoAnL69ZO2F0/r+wNplHtsKbyZMU=
=h9ND
-----END PGP SIGNATURE-----

--Sig_/jz6Nx+otOii=QehdirSLbMq--
