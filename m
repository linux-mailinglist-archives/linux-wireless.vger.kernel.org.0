Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEF4CBC36
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiCCLMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCLMO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 06:12:14 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981D17C436
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 03:11:27 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nPjMZ-000PsW-Ld;
        Thu, 03 Mar 2022 13:11:19 +0200
Message-ID: <af43569b2247f7aff44b1ea3680d88dbe083d78d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com,
        You-Sheng Yang <vicamo.yang@canonical.com>, luca@coelho.fi
Date:   Thu, 03 Mar 2022 13:11:13 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Fx5l+HB6KXwGexffRz51"
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2022-03-03
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Fx5l+HB6KXwGexffRz51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit ee0667aa201e7d725ec87b1e4cf08de1d748d64f=
:

  amdgpu: update raven2 VCN firmware (2022-02-28 09:44:17 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2022-03-03

for you to fetch changes up to ba104c67dfb838e892b6b4c72569aa7f1ee955a2:

  iwlwifi: add new FWs from core68-60 release (2022-03-03 13:00:52 +0200)

----------------------------------------------------------------
Update and add iwlwifi firmware binaries for release Core68-60

----------------------------------------------------------------
Luca Coelho (2):
      iwlwifi: update 9000-family firmwares to core68-60
      iwlwifi: add new FWs from core68-60 release

 WHENCE                            |  40 ++++++++++++++++++++++++++++++++++=
++++--
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1519544 -> 1520208 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1490376 -> 1491056 bytes
 iwlwifi-Qu-b0-hr-b0-71.ucode      | Bin 0 -> 1364312 bytes
 iwlwifi-Qu-b0-jf-b0-71.ucode      | Bin 0 -> 1285192 bytes
 iwlwifi-Qu-c0-hr-b0-71.ucode      | Bin 0 -> 1364328 bytes
 iwlwifi-Qu-c0-jf-b0-71.ucode      | Bin 0 -> 1285208 bytes
 iwlwifi-QuZ-a0-hr-b0-71.ucode     | Bin 0 -> 1364308 bytes
 iwlwifi-cc-a0-71.ucode            | Bin 0 -> 1322288 bytes
 iwlwifi-so-a0-gf-a0-71.ucode      | Bin 0 -> 1550124 bytes
 iwlwifi-so-a0-gf-a0.pnvm          | Bin 41808 -> 41808 bytes
 iwlwifi-so-a0-gf4-a0-71.ucode     | Bin 0 -> 1566352 bytes
 iwlwifi-so-a0-gf4-a0.pnvm         | Bin 21576 -> 28064 bytes
 iwlwifi-ty-a0-gf-a0-71.ucode      | Bin 0 -> 1494024 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 41588 -> 41588 bytes
 15 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-71.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-71.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-71.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-71.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-71.ucode
 create mode 100644 iwlwifi-cc-a0-71.ucode
 create mode 100644 iwlwifi-so-a0-gf-a0-71.ucode
 create mode 100644 iwlwifi-so-a0-gf4-a0-71.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-71.ucode


--=-Fx5l+HB6KXwGexffRz51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmIgolEACgkQoUecoho8
xfqU3A//W5vr+/Qyl+n0yYniUQhH60YMBTwiNIUm6FPm/2FwpB9e1FTQZKl7fs9W
jskD4xVktMbyF4ikxf3EgzsclBGgQlLBK6zZLpmYhv9OdYUljVZfDbuhE9GFQ8Ns
Loz4ys1SpvaB6F6KqP74uyK6/AEitioELbW+eA51WsBv+o5zEGcu3RbBcLgTpTtx
HYjdaamzRN9C2tLMynRMAAIigzP6vu6+agAFsA0r4nbwmNMdWrw1dSR47H0Ek08F
fyXOUmXiuPa4lGJrZpn6hKC88iivdLMOtFj54dBz+CCpBggf1Lyde1WT6L6WcpeR
80Z09S1amLV+LD/ciXpFtR8xzwf50CL8MYRz8ZbxvU/dQtzDaoMuzS6km4Zz3UFy
sgV+4483/C23IG4tP9qBvVdFAS/zDDeIzJqxH24eztFolRV39M716QOJ7wBYVrYe
MqBVOA3ncSQyT3j5f0w9ECjkcN+nm5/sl6K+ZjLq925DE2MIcZ6qUeFxoKUKS7yW
pe6cSGPeCpquAjJEy/ymaZ3ccRB5gNUs25REBnMfan6YCVizI7dbOIVmkiWKoRSX
vdNu51FR7j0q5JKJvPxctHjnzbNo4wSufQdZhETb3hbIsVwFsvAsLYT+29vP6UUs
ad/zkT6pUV/+3hGfVmL2lvAcrUCBmcxK6BIKrwZQOlFYR8HgPL8=
=BUx7
-----END PGP SIGNATURE-----

--=-Fx5l+HB6KXwGexffRz51--
