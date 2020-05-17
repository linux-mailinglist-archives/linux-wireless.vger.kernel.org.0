Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5911D68DC
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2020 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEQQaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 May 2020 12:30:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38943 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728035AbgEQQaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 May 2020 12:30:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C0F415C0092;
        Sun, 17 May 2020 12:30:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 17 May 2020 12:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm1;
         bh=+1pExrMtUQsybCJ2U3H9utt+zcUO7VAy5M7wdQdt7Jk=; b=eX4NuyawmL82
        8RpJmUfIDIZd2gARzCUfM8GJFp23QPKJ92ftKuCv6Z4+b8nwD3kJ0qY7auykwiZ/
        1+nge/iZEbCBkRaGjWzmy+xYRal0G1E38/1Vjul7+m4VquvIuKwR80BDBZXamN/9
        jwlSAhnW+5HBC8wthDfn9EmxGExoX2P5Pug3RlcHOc3wCLZEHBqWskHPY4nk2098
        JMGPLbvCLmGNUjV8wu8gzddIHLj1J8fb8kx1oZncp5Dwqe1tetIDA/+PFGCb+zPt
        q+kFw70ncrITQx92//Lb+WMuLqvcKRLIUiTTF/0YJTl5TbvUVESiG/9zVvIBb+xa
        vzn2SUtG/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=+1pExrMtUQsybCJ2U3H9utt+zcUO7
        VAy5M7wdQdt7Jk=; b=D1tFDHWHnoXb6wVPE3ZL/6w8rvI+Rji9QeAj0IGuZL0Z3
        g4QME5ZGqD9BrmGgQU5NeabTK87C4Ihp5oivNf3hYWc4SETSQ7l9fZ10vMww38Jn
        rwvs2dWHUA3VcWNNFTuN01SrQGBbdEq/ueAGTMTbbQPWnCMhSu29OZPtAnqgTKhy
        eanBIn/bHcGdpl3zlQS9VH7xXhvgf6DLr7VnwEeLQogy6CmCTGEJsukS7yxlkssd
        5xjhaFcGvwxzjv4GCu4yU3KY5bAWk5x6TDWt5a4JtsRfkP1FSd9hDWPi5vdtmU0Z
        3EZGgxxysvL9cf3NtK+wO05eoDTpnuauBZn9sb4Xg==
X-ME-Sender: <xms:kmbBXkO9GrxgOj1dJWmGvzkRR6bhT0dz5iZzI_MXH71HrKeO4ShkOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtfedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeeifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecu
    kfhppeejjedrudekfedrudelrdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kmbBXq_jJvmIZrLzlI-YPu4vHrM9SR4FKJgpT9GFNpw-wr8Zuf22kQ>
    <xmx:kmbBXrSD0qRduICFX-GsfdqWkrmbHRnxP1r77v7-rTu3AdiTOc8ntw>
    <xmx:kmbBXss3yRa4sNESUXr9OO8Q1fG-_Lbn1NDgZgOFCTmvK8EoJLt2pw>
    <xmx:kmbBXmpt_l4UAaJSwYw1FF07f19-cykgl8-f6i3pCLDD3Zui-4py_g>
Received: from vm-mail.pks.im (x4db7131f.dyn.telefonica.de [77.183.19.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0361F30663AE;
        Sun, 17 May 2020 12:30:09 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6d12006e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 17 May 2020 16:30:05 +0000 (UTC)
Date:   Sun, 17 May 2020 18:30:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] cfg80211: fix CFG82011_CRDA_SUPPORT still mentioning
 internal regdb
Message-ID: <c56e60207fbd0512029de8c6276ee00f73491924.1589732954.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Back with commit c8c240e284b3 (cfg80211: reg: remove support for
built-in regdb, 2015-10-15), support for using CFG80211_INTERNAL_REGDB
was removed in favor of loading the regulatory database as firmware
file. The documentation of CFG80211_CRDA_SUPPORT was not adjusted,
though, which is why it still mentions mentions the old way of loading
via the internal regulatory database.

Remove it so that the kernel option only mentions using the firmware
file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 net/wireless/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 63cf7131f601..813e93644ae7 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -181,8 +181,8 @@ config CFG80211_CRDA_SUPPORT
 	default y
 	help
 	  You should enable this option unless you know for sure you have no
-	  need for it, for example when using internal regdb (above) or the
-	  database loaded as a firmware file.
+	  need for it, for example when using the regulatory database loaded as
+	  a firmware file.
=20
 	  If unsure, say Y.
=20
--=20
2.26.2


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7BZpsACgkQVbJhu7ck
PpSijg//f6vNZV87bAHCP/dUrxf700HvRS5NwW+Ds6VRGzCcr12yVjZ9wA73i77x
jy9ElW/CSzqtgV2olljczex3W+lOzxT+pcnWbIpe1TXJXr7tz3W3Oc3VZZETH5kc
NhfZY38IooEdB6fmntaRiZ/F4Tf/5owWvE13LfbwYyuWVgturATSLS0/+aIMR7fF
tFBIvgm19ahg0wCqOPLJK0Griv5xTnY6+wfA6mh1N/3nQ+86+O+BZBOHYLk4mdWI
Uo2eWd13rfWrRP/r09zdk9IL9uXUCjS9I5WdLTDE6j0UC0iO19O9QwijpUhnP0pq
xPahylK1iKyxvJ0HOn8sstJyoq5jlH+9/LxhilFhKbMzB29JsdmryceFKhxBzy1F
+p1Uz1paNED4IBSDnNwBWrKGW7WUiSCRpw7Hypc02lmmag3u8Gk9F3URH9aZqsbc
xSHUWgMpneTwckYzX1ie/Q84SA450FPq9nQk9MRAeLVbNr1xSO36+trUz217YzE2
iFLHsgKUAgjHySrZ+N2F3oBjH1JEazweYSKrZQ95IWYA6f041qt5iglsw6ZsAHx9
9YWm+XBvCCcHtlN338or/YdX4xXCS5PxLztZ1AvSV8u8GeLn+zpL6CXCEU2CfTRV
RClPz5ZNf+6/NNGcE0OxSCkOi3tgCM5WKBRdLDl0Mp2sVTKlIMc=
=oLQ7
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
