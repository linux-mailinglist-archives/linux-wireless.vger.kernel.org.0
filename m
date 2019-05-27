Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7B2BBD1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2019 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfE0Vs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 17:48:28 -0400
Received: from ozlabs.org ([203.11.71.1]:48463 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0Vs2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 17:48:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CVw90CqYz9s1c;
        Tue, 28 May 2019 07:48:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558993705;
        bh=xHqG+VZ3uOmhfBms6e5VSwJ6zWyDyy/VHolsyRkHHx0=;
        h=Date:From:To:Cc:Subject:From;
        b=VAK7GuJyqTx60/7BHPj4Pf+P8nm6sShWynbpBAWclyD5XgrfeD/4Q3kdlWRKdHc/x
         R4tw0RDY5rzT2+F1bUADN3sbyRJPBKjh1eQrj2bBKqi97qIB6WyJ1ihhf1d+mN3ZGC
         QmjixXTg/RX/rHFbp4Wodk0eNlkTgmKNAGiL6RH/cuoNW1ncBLjKIr0Iij2qqMz+y4
         ngQCzIZ8/MbRGI9Y+9qe2SD6OJZAHUN1B96hCPo/UXPEZf51vv1onbtcT0PPXkDs3R
         ubMIci7U35ZYKX4JVPIOFE9UF5rYufMcEs9ZLzPlFPxgSTgM98lwWfavwMEcA0G7KA
         nqhbEKsv24H/w==
Date:   Tue, 28 May 2019 07:48:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Pradeep kumar Chitrapu <pradeepc@codeaurora.org>,
        Zhi Chen <zhichen@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20190528074813.122bdddb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BrxpA.sp=dhLlqfhF1hlmg/"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/BrxpA.sp=dhLlqfhF1hlmg/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9280f4fc06f4 ("ath10k: Fix the wrong value of enums for wmi tlv stats id")

Fixes tag

  Fixes: f40a307eb92c ("ath10k: Fill rx duration for each peer in fw_stats =
for WCN3990)

has these problem(s):

  - Subject has leading but no trailing quotes

In commit

  93ee3d108fc7 ("ath10k: fix incorrect multicast/broadcast rate setting")

Fixes tag

  Fixes: cd93b83ad92 ("ath10k: support for multicast rate control")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/BrxpA.sp=dhLlqfhF1hlmg/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzsWx0ACgkQAVBC80lX
0Gzg+Af+Lb89BcVA/rGFGnEEurc2Q7yTKeOJdfirGZEvGWUfNG+u1Rnpvjk26PDo
+F6glbpYfjrNuNyv/9+a/DPUKndL+7eNBojV/sK2Za406DpFxkeEho+15wWByg88
h1rt/k2DlhFjV8izI/lYOpfI0NU0bhzvwdZoVQ8CTlKuRvsDNqILL+AhusOLUBrs
mW+veapxaGMJk/YKSuw082n3EgoCn3bRTxR2IpBfv+8AhM0qHzcBHZBfhaCrg5Nq
xW7Eh1HhoDLYSMr3IWG4fchRe3vrmyWiX3wD3LioCstqLWOmwg7G48hY/PzYw8AR
Yav5nf1CPxs8/NEnTif0/hG70EZvBA==
=8IXb
-----END PGP SIGNATURE-----

--Sig_/BrxpA.sp=dhLlqfhF1hlmg/--
