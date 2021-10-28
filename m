Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4843DCEF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1IcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 04:32:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5BC061745;
        Thu, 28 Oct 2021 01:29:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HfzJ01H0fz4xcC;
        Thu, 28 Oct 2021 19:29:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1635409777;
        bh=X4uCS05x0BzlU2reBiuh8ykPwQkXGQAAbY+K+IifiSI=;
        h=Date:From:To:Cc:Subject:From;
        b=XR7XhmZ+7HCFRY/IO6tnCUMJbT2Pi13eORSgGN0/eK9lGQJzn9PAFckjqc5krfBH/
         ofT4jFtjdO/1dgu4599n9kFi1yJs21noy3F9EL1iQLbw0xtFJn0yYXotfafAUetZOP
         5+yIhklU/MKzi0j1fJONIsJzfWgpS2knQgcGrt57bCUT17bhDuJClwZWD1sHVMejNv
         GP6I1D7gkXhBSKYT4/+bcmHRVNgVxMu0xV1OK+1zpkZg7TVxUK4scRV68MVRz2/p9C
         Tg8aO0SIQrTkB/Xq60TfkzG0BxG3BALEpKHHmhj4Z/lfedto0kayj9Skv/IRQCGhHW
         MR2gBMpf4RnLQ==
Date:   Thu, 28 Oct 2021 19:29:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the kspp tree with the
 wireless-drivers-next tree
Message-ID: <20211028192934.01520d7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DOZuLkFxk_X_y2D5FQRhN18";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/DOZuLkFxk_X_y2D5FQRhN18
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h

between commit:

  dc52fac37c87 ("iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES ver=
sions")

from the wireless-drivers-next tree and commit:

  fa7845cfd53f ("treewide: Replace open-coded flex arrays in unions")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 9b3bce83efb6,5fddfd391941..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@@ -720,10 -715,11 +722,12 @@@ struct iwl_mvm_compressed_ba_notif=20
  	__le32 tx_rate;
  	__le16 tfd_cnt;
  	__le16 ra_tid_cnt;
- 	struct iwl_mvm_compressed_ba_ratid ra_tid[0];
- 	struct iwl_mvm_compressed_ba_tfd tfd[];
+ 	union {
+ 		DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_ratid, ra_tid);
+ 		DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_tfd, tfd);
+ 	};
 -} __packed; /* COMPRESSED_BA_RES_API_S_VER_4 */
 +} __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
 +	       COMPRESSED_BA_RES_API_S_VER_5 */
 =20
  /**
   * struct iwl_mac_beacon_cmd_v6 - beacon template command

--Sig_/DOZuLkFxk_X_y2D5FQRhN18
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF6X24ACgkQAVBC80lX
0GxeDgf/T3r+U+CZjL9KlT19vbpSRLwiT8w+XGLe0g66wEreQRWCqtU5mJMvtAND
DoXEYjGVrSRF358gzMYbbubrHD8l55lT0z9LxB0Ug7m4H5ilrpg2huufzPL2C8ul
H33zGMNoElTG5/bYih+1k5oeupOHqDMW4zEkbqb+BZc+M5VJ3xSFQ1lc3c+f6/aK
SRjoFU76ykMIeNjx/WulA8rGPRWjVnr7aRuBEROt1dI9HBwa61Ae5uGB2TTd+uFs
qFAn7LvgnzaHt5WfpLWBLwrv9vgsJ5kyuOjiFjJHcdjOsbZBfFZgDtuR3koYh/kX
kj7oydHy4sDNLswqYguxsvZ6898XFA==
=Di/1
-----END PGP SIGNATURE-----

--Sig_/DOZuLkFxk_X_y2D5FQRhN18--
