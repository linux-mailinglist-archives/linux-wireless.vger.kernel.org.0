Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715F832E650
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEK1L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 05:27:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:47846 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229836AbhCEK0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 05:26:51 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lI7fQ-004PSY-5S; Fri, 05 Mar 2021 12:26:44 +0200
Message-ID: <3f941262db82a01ff00dbdb405cc315ee4dec480.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Fri, 05 Mar 2021 12:26:05 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-II/rxtUXLlDKK2EeA/hp"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull request: iwlwifi firmware updates 2021-03-05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-II/rxtUXLlDKK2EeA/hp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 5ecd13ffe8e24385cf4f30f3d0dcaff4dfb24de2=
:

  Mellanox: Add new mlxsw_spectrum firmware xx.2008.2406 (2021-03-03 13:23:=
49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-firmware.gi=
t iwlwifi-fw-2021-03-05

for you to fetch changes up to 568016467deab716b8a382bf087209b781d4bca7:

  iwlwifi: add new FWs from core59-66 release (2021-03-05 12:18:25 +0200)

----------------------------------------------------------------
Update iwlwifi firmwares to Core59-66

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: update 7265D firmware
      iwlwifi: update 9000-family firmwares
      iwlwifi: add new FWs from core59-66 release

 WHENCE                            |  34 +++++++++++++++++++++++++++++++++-
 iwlwifi-7265D-29.ucode            | Bin 1036444 -> 1036772 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1512096 -> 1514240 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1483116 -> 1485556 bytes
 iwlwifi-Qu-b0-hr-b0-62.ucode      | Bin 0 -> 1329296 bytes
 iwlwifi-Qu-b0-jf-b0-62.ucode      | Bin 0 -> 1248672 bytes
 iwlwifi-Qu-c0-hr-b0-62.ucode      | Bin 0 -> 1329312 bytes
 iwlwifi-Qu-c0-jf-b0-62.ucode      | Bin 0 -> 1248688 bytes
 iwlwifi-QuZ-a0-hr-b0-62.ucode     | Bin 0 -> 1328924 bytes
 iwlwifi-QuZ-a0-jf-b0-62.ucode     | Bin 0 -> 1248672 bytes
 iwlwifi-cc-a0-62.ucode            | Bin 0 -> 1292672 bytes
 iwlwifi-ty-a0-gf-a0-62.ucode      | Bin 0 -> 1455104 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 0 -> 27456 bytes
 13 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-62.ucode
 create mode 100644 iwlwifi-cc-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0.pnvm


--=-II/rxtUXLlDKK2EeA/hp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmBCBz0ACgkQoUecoho8
xfptmg/9EGl6/fLQE6eyDvZsQJsHtvWXizGfVcGHuLXobNGdqse9KhTgdf9KJFsn
LLWV0x7aHD+QTO+xtMz5OlAoRQ6ELw5/PjNKniz0vz8xXMRquev912NWUOL+Aagg
CfyQVC7W9q2VoThT2/6pPhh0zK3YInCcRSAOFLf5E6auZqYsoKcs740gx6YT0JlB
ZryIVqUm3EBqV/bpEvow32UeZ5yF+aWpEmIORYCCwFo/dvb6XrodgwLl2bmkt/yq
IIHgeA62b/W1llY5Ba4hvvFwdgLgLpok5MrTW/w76DWWrqmDUE0YfntiP9DzDByV
mq3W9I7ZT6iw/fZSDFk0KMPg5a8J0ZOaUwzECJqd9QFy5eirzR6i0KPAfip+5OB7
X3qZFTqO1nZHNDxiTxQt5PyRipaieXSFN/0fYHgrmgwg/h89+XzVOHfEoEijq2hU
EQKFEZZcIDYlVNg0tAKLjG87lDIOfNNoaGe5TujYbwjCegb8rtED1QndxD9Mf9xN
WDToeFiazx7wZ/dfoR3KJBjAXyD6LUeQoWXDhO9MP+a1073eY5kvTBIK9RFc7YGI
FKLUARfEQnGEtS7I9numbVEbrmrM8mCJOONBHEVCkQ5peC6loXnIcyE3nKKO5okk
sHSF7JA99gtUD719JrwkOAJ+ppwCk8spz6agIp2J8kGxOYcljyw=
=u406
-----END PGP SIGNATURE-----

--=-II/rxtUXLlDKK2EeA/hp--

