Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151283B24D3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFXCTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 22:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFXCTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 22:19:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8851C061574;
        Wed, 23 Jun 2021 19:16:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G9Nzq6j8nz9sX2;
        Thu, 24 Jun 2021 12:16:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1624501002;
        bh=FY9bPQtgTRPc1Bcpcqtr0qfazMka2vKx91DBMBcpNbI=;
        h=Date:From:To:Cc:Subject:From;
        b=N1gZpdEDpV4KQ9OkH/j2XCPQwERL52BYCnPl1z00668R+daWvalE35wJBVbUWEWUj
         QMqCJo53JdftKt8nYt+jMvFia0rQQLbI9aN/ILkN1LdZMAfbD1UwCd9/CcMfS6Zx7j
         QAkywIlPXSaPz2o4nodqhrY93Kndhxg1vLsYDi8ZbMBkCzB+wYLOMfzi5MbQThsun3
         eCE6IZymq8mJx1KufyitNi0Off5Ybu4H/TTNnfOO2wfXCBuhazHuFYPP6yX99nsXSh
         1JL3z8QYeVlsABcqqwicN3dAF4WyjCB4E1xWMwe+HVz7LnfsjtDXHqPX89WIRDCKwX
         enExavto+aTTw==
Date:   Thu, 24 Jun 2021 12:16:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-drivers-next
 tree
Message-ID: <20210624121639.6d89a9b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W4hkBcwaqEdyC7l9sQ=G.nr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/W4hkBcwaqEdyC7l9sQ=G.nr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-drivers-next tree, today's linux-next build
(x86_64 allmodconfig) produced this warning:

drivers/net/wireless/intel/iwlwifi/fw/acpi.c:720:12: warning: 'iwl_acpi_eva=
l_dsm_func' defined but not used [-Wunused-function]
  720 | static u32 iwl_acpi_eval_dsm_func(struct device *dev, enum iwl_dsm_=
funcs_rev_0 eval_func)
      |            ^~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  7119f02b5d34 ("iwlwifi: mvm: support BIOS enable/disable for 11ax in Russ=
ia")

--=20
Cheers,
Stephen Rothwell

--Sig_/W4hkBcwaqEdyC7l9sQ=G.nr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDT6wcACgkQAVBC80lX
0GzHUAf/fnNlc172wY+YLLv6TuTErmpfi2I4m/OeqmWzQJqUs4Anh95ATuMHkojp
fUH9tI0AlNzFacWdAZQnY34wYq8MS30czipF66p7c6XdY1NG1iGLD3QfBKoTZglk
noT6+KEeG2OEa4b3rrTYfMWKTErrTGQrbVosoRfokFiz0uVaDbetibbuEIJ4OgaP
SRvcd9ecGEPPf+ieOTYSWy9V3nBTG9ZjLUVM9SbF31fiPOxcJAekVq99Z1k+Kyp5
bCkxpRTgwaxQ3is8qUwXdBzyPbtE187BKL2O/ZSIjzfPReZVqT/4jQCKlXj5Zx+r
Uls/7MzQYK1m4xMnHmIGnvE+5XreQA==
=rm5X
-----END PGP SIGNATURE-----

--Sig_/W4hkBcwaqEdyC7l9sQ=G.nr--
