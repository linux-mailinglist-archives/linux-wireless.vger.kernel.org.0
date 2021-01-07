Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45C52EC916
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 04:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhAGD0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 22:26:41 -0500
Received: from ozlabs.org ([203.11.71.1]:54341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAGD0k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 22:26:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DBBTL4pzWz9sW0;
        Thu,  7 Jan 2021 14:25:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1609989959;
        bh=znFli4VeK1mU2u3SaFssFQErYIJ5L+bSWa+34l3uTCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jf+hX6O/9tF+IgQh/x0Py92Su9hV3POYpU+VzAHM5EWyYcBCDb2Cnf3MAyYaKWvyE
         5EEF55/qLS8GxoQdbCyC3iXEaji8osUm5X1EkssEbYiUhSgvAdXuKbvlMdjKMk3QSY
         oRmlQlqDK5oQJTttQC7Ya8XAUewUsyEyACS7mSUrMnJjFxWdYmK1kFfxySNrEk4zqY
         yNUR75JXiSJc+lMotzgcVIENs/ErO2Kaf5L9P4UfNh0/PQvXbT7AUCrucReatQl/A+
         o0db/8TMO1BO1Wuj8Aiedi3B+uU/YTX+JUd6nRKbmxTXov0M3wdSTrQDs17SBfd551
         I3x4UxQnrm2Vg==
Date:   Thu, 7 Jan 2021 14:25:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3] cfg80211/mac80211: fix kernel-doc for SAR APIs
Message-ID: <20210107142555.302c7079@canb.auug.org.au>
In-Reply-To: <20210106234740.96827c18f9bd.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
References: <20210106234740.96827c18f9bd.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lFaX9pAFy_iXKWAZKQUMtus";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/lFaX9pAFy_iXKWAZKQUMtus
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed,  6 Jan 2021 23:47:41 +0100 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> A stray @ caused the kernel-doc parser to not understand
> this, fix that. Also add some missing kernel-doc.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limi=
tations")
> Fixes: c534e093d865 ("mac80211: add ieee80211_set_sar_specs")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build only

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/lFaX9pAFy_iXKWAZKQUMtus
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/2f0MACgkQAVBC80lX
0Gxm7Qf/UFmyK4jtX2USkFfXUm0rSU/1GInlvGc/PYa10oF7lDt3maC9ojC9R0qv
p24NIbJXGEVjI0UbjIj5Qg6YLwRzA4IGxRoFOMNSbrabVBZ2GBGxlQ7mMXVmmSD/
ZM5zkDz7ukEk9P32J0TcR87uOHZXhYPjDStx92nU1vGOjAGH2PsbKimt26f01ZDR
TLy/tgsOEAsiSkAb/Dd3POH5dz3+aLeDd016dGPRJZyRiS/sfNA6C7e6LKiLIfmC
P3Aj8QDOOH4IEYTAdmFk6L6bx1JZUYIRmwOREjTZClbnK4Ru+ZO2VAVRRq+J4+Pn
YK3FHdkQOOflXcvahwnH+0ICXHbFhw==
=69mV
-----END PGP SIGNATURE-----

--Sig_/lFaX9pAFy_iXKWAZKQUMtus--
