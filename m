Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8904D42C6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiCJIne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 03:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiCJInd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 03:43:33 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F20329
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 00:42:29 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nSENK-000U2k-3D;
        Thu, 10 Mar 2022 10:42:24 +0200
Message-ID: <d4c71b078097ae236fc20131ea59cd5c436554bb.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Thu, 10 Mar 2022 10:42:21 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-RLiXsD2G9mE9EmHgyP1l"
User-Agent: Evolution 3.43.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2022-03-10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-RLiXsD2G9mE9EmHgyP1l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my second pull request for v5.18 with the last patchset I sent.

This is all normal development, new features, bugfixes and  cleanups.=20
More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 12b604d4ba693a3aa254cf7f9d0b4835770e9e97=
:

  rtw89: declare HE capabilities in 6G band (2022-03-09 13:39:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2022-03-10

for you to fetch changes up to 8594ab868799ce78c770498b74fe55ded30def9e:

  iwlwifi: bump FW API to 72 for AX devices (2022-03-10 09:23:29 +0200)

----------------------------------------------------------------
iwlwifi patches for v5.18

* Mostly debugging infra changes;
* Some more work on the Bz family of devices;
* Bump the FW API twice;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Ayala Barazani (2):
      iwlwifi: mvm: add a flag to reduce power command.
      iwlwifi: Configure FW debug preset via module param.

Johannes Berg (3):
      iwlwifi: mvm: remove cipher scheme support
      iwlwifi: pcie: fix SW error MSI-X mapping
      iwlwifi: use 4k queue size for Bz A-step

Luca Coelho (2):
      iwlwifi: bump FW API to 71 for AX devices
      iwlwifi: bump FW API to 72 for AX devices

Matt Chen (1):
      iwlwifi: acpi: move ppag code from mvm to fw/acpi

Mordechay Goodstein (2):
      iwlwifi: dbg: in sync mode don't call schedule
      iwlwifi: dbg: check trigger data before access

Mukesh Sisodiya (3):
      iwlwifi: yoyo: disable IMR DRAM region if IMR is disabled
      iwlwifi: mvm: add support for IMR based on platform
      iwlwifi: yoyo: dump IMR DRAM only for HW and FW error

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  19 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c               | 211 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  28 +++++++++=
+++
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h          |  27 +++++++++=
+-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                |  34 +++++++++=
++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h               |  28 ---------=
---
 drivers/net/wireless/intel/iwlwifi/fw/img.h                |  12 -----
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h            |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h            |   5 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h           |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  69 +++++++++=
++++++-------------
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h         |   5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                | 221 +++++++++=
++++++---------------------------------------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |  33 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |   1 -
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   5 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c              |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |   2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c              |   4 ++
 20 files changed, 412 insertions(+), 306 deletions(-)


--=-RLiXsD2G9mE9EmHgyP1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmIpue0ACgkQoUecoho8
xfokOQ/8Ch0OrzsnfkxYkR/zTNK4BZoifdUs3GEy8s3FjUu89PE3cm4017NJ/COJ
+lXPJo0qCN5TiTZbxIoHKujniASJkqRbkyc4RbZc7NJHgzU1hHO2/mOImqxdKuXb
Z9FY7Uo45jkRMLfbRaGMUCsFlhx3TBZYcJZqnSaFFQHZIE02+z9amCiUbChlGPOU
95GkR2GCpi0RHlO7ZjjIfP1qbO+FzUT1wuwyMzgNxXOkNVXwgKYJtxBWQDxPx+Fl
xaIlTAkxzbTE6C2lrmVdqPN778C7a2fFQckwzqZ11VM9MqJKs+muX5LJcJZt4yR0
8YKpe3NymLHyLz29A4mEIhl6EWXe2MSbbjr367AwgFQv56bpd1N6/RNQ1msPq3lB
PRkASPPG79qV+Dy42KO6dPU1/YyC1iTv2quhgP5Q4+45UBfnwTJ/DDlH9xINiWgx
BbY5s684mUzAhpsllDirx2emtauO+Lc15Yzdi+GLyL59Z1gcv1yfxnmTZvuoypqi
ysbIZnMBKZIpNqTZ5vuYXbjZmrBWZlDIp5QWUCSxNnaGqrO4KsNnHbeLEDlwttx4
dJ2rUXfzp8mo9l384eGAwJH4MpdQ4PJwfJPuRNZT5ad5BHpYSK32SwpdLyVdSgSi
BXU/OyRzbBlxuwQ32eu2AGDnOJjoZ6D30HiqNwPkIXMsjx26LPw=
=gHHV
-----END PGP SIGNATURE-----

--=-RLiXsD2G9mE9EmHgyP1l--
