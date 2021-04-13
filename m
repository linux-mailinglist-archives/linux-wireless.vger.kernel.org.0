Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041BA35DC80
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhDMKeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 06:34:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245379AbhDMKeM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 06:34:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FKMQl2TMRz9sVb;
        Tue, 13 Apr 2021 20:33:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618310032;
        bh=0QSTG7AgKcAj2zXsiIn2BwtPbzxwF9Qsx+zdz7te+9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=C0Q/O3/4b26VYHU25DT2IbFkx+YsFpUiIJiJoPf4zqXMpxlFsXflhd6RBqqFVEmHK
         O7GzA0PHnJs3v3PdN0JzJQb16BL/LJuZC3VYmGHH64LZLGSegP55vps4JTAnqoJ3Sl
         rwCqYvAm9NzeDqx/kSSHYOaPUKMBtDMHtavoW4FITMkPk7qiHvlqoBfM3YXMXIyNho
         CoU/crrHuJXCCrN15z9QsKsH9eCfDoaQ3ZozySOJxxTgjDD35LSYkUC6d1OWEcdFQ8
         zUqy87gtEPQTCK13E4EMM5vGbDSKmNKAU3tlOy/yYL4sbx6tcxfIudTROrv3g9DHdd
         QUMC9r9YbW6Sg==
Date:   Tue, 13 Apr 2021 20:33:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mac80211-next tree
Message-ID: <20210413203349.43d3451e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CLleS31GUfCWDobcilOra.f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/CLleS31GUfCWDobcilOra.f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mac80211-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead
include/net/cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_=
set_hw_state(). Prototype was for wiphy_rfkill_set_hw_state_reason() instead

Introduced by commit

  6f779a66dc84 ("cfg80211: allow specifying a reason for hw_rfkill")

--=20
Cheers,
Stephen Rothwell

--Sig_/CLleS31GUfCWDobcilOra.f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB1c40ACgkQAVBC80lX
0GxGlAf9HEF0WTisn6VJtPlv2O6InYLiBP+qbCslxrrpJAHfppUktma6Ued0aDLm
gx49xPRmR+lu1MdnXw9Z7Pu1b/1I3t0xVmZJqAq31+eGYFmqSsrUaI5c80epJ/Na
Xzw3s0EC2wc8uqUBzqz7ZrCM7OyHaQvwls3ta/NU1qGr82WPW7oum+4oq23nbjxM
EeaanUOT9RbRwtg4OjhqpCLaJPD5f2ekJbs31NYhUiv/TxAyXm48XUfdNcANRD7F
AIl1Zf9saW1NrI+sGaeh3j3PzE/2q7DHJZxwkMegkycMDxo1uy9BI3oeAlzTvLoj
AetHK4KXGFqOrukjsOXuN9pA+6u/2A==
=AKUc
-----END PGP SIGNATURE-----

--Sig_/CLleS31GUfCWDobcilOra.f--
