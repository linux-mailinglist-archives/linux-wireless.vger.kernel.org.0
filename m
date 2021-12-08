Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28B46D589
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhLHOWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 09:22:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50726 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230142AbhLHOWr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 09:22:47 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1muxmr-001C6D-1r; Wed, 08 Dec 2021 16:19:14 +0200
Message-ID: <0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Wed, 08 Dec 2021 16:19:10 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-DwlaWSaItyGcu0ShPbOw"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2021-12-08
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-DwlaWSaItyGcu0ShPbOw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my first pull request for v5.17 with the three patchsets I sent
earlier, plus a few patches to fix small issues introduced when iwlmei
was merged and a couple of other patches sent by the community some
time ago that were still pending.

Otherwise this is all normal development, new features, bugfixes and
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit fe6db7eda9306d665f7b8fc3decdb556ec10fb85=
:

  iwlwifi: mei: fix linking when tracing is not enabled (2021-12-05 13:55:1=
5 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-12-08

for you to fetch changes up to 977df8bd5844c9370c26a9477418165b870da27c:

  iwlwifi: work around reverse dependency on MEI (2021-12-07 20:18:06 +0200=
)

----------------------------------------------------------------
first set of iwlwifi patches for v5.17

* A few mei fixes;
* Some improvements in D3;
* Support for new FW API commands;
* Fixes and cleanups in device configurations;
* Support some new FW API command versions;
* Fix WGDS revision 3 reading bug;
* Some firmware debugging improvements;
* Fixes for in device configuration structures;
* Improvements in the session protection code;
* Support SAR GEO Offset Mapping (SGOM) via BIOS;
* Continued work on the new Bz device family;
* Some more firmware debugging improvements;
* Support new FW API version 68;
* Add some new device IDs;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Arnd Bergmann (1):
      iwlwifi: work around reverse dependency on MEI

Ayala Barazani (1):
      iwlwifi: support SAR GEO Offset Mapping override via BIOS

Colin Ian King (1):
      iwlwifi: mei: Fix spelling mistake "req_ownserhip" -> "req_ownership"

Emmanuel Grumbach (3):
      iwlwifi: mei: don't rely on the size from the shared area
      iwlwifi: mvm: fix a possible NULL pointer deference
      iwlwifi: mvm: remove session protection upon station removal

Haim Dreyfuss (1):
      iwlwifi: pcie: support Bz suspend/resume trigger

Ilan Peer (2):
      iwlwifi: mvm: Fix wrong documentation for scan request command
      iwlwifi: mvm: Add support for a new version of scan request command

Johannes Berg (15):
      iwlwifi: mvm: fix delBA vs. NSSN queue sync race
      iwlwifi: mvm: synchronize with FW after multicast commands
      iwlwifi: mvm: d3: move GTK rekeys condition
      iwlwifi: mvm: parse firmware alive message version 6
      iwlwifi: mvm: d3: support v12 wowlan status
      iwlwifi: mvm: support RLC configuration command
      iwlwifi: fw: api: add link to PHY context command struct v1
      iwlwifi: mvm: add support for PHY context command v4
      iwlwifi: mvm: add some missing command strings
      iwlwifi: mvm/api: define system control command
      iwlwifi: mvm: always use 4K RB size by default
      iwlwifi: pcie: retake ownership after reset
      iwlwifi: implement reset flow for Bz devices
      iwlwifi: fw: correctly detect HW-SMEM region subtype
      iwlwifi: mvm: optionally suppress assert log

Luca Coelho (3):
      iwlwifi: remove unused iwlax210_2ax_cfg_so_hr_a0 structure
      iwlwifi: add missing entries for Gf4 with So and SoF
      iwlwifi: bump FW API to 68 for AX devices

Lv Yunlong (1):
      wireless: iwlwifi: Fix a double free in iwl_txq_dyn_alloc_dma

Matti Gottlieb (1):
      iwlwifi: Fix FW name for gl

Mike Golant (2):
      iwlwifi: support 4-bits in MAC step value
      iwlwifi: add support for Bz-Z HW

Miri Korenblit (1):
      iwlwifi: acpi: fix wgds rev 3 size

Mordechay Goodstein (3):
      iwlwifi: mvm: add support for statistics update version 15
      iwlwifi: mvm: update rate scale in moving back to assoc state
      iwlwifi: fw: add support for splitting region type bits

Mukesh Sisodiya (2):
      iwlwifi: yoyo: support for DBGC4 for dram
      iwlwifi: dbg: disable ini debug in 8000 family and below

Shaul Triebitz (1):
      iwlwifi: mvm: avoid clearing a just saved session protection id

Yaara Baruch (3):
      iwlwifi: swap 1650i and 1650s killer struct names
      iwlwifi: add new Qu-Hr device
      iwlwifi: add new ax1650 killer device

Yang Shen (1):
      iwlwifi: mvm: demote non-compliant kernel-doc header

 drivers/net/wireless/intel/iwlwifi/Kconfig                    |  52 ++++++=
++---------
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c                |  29 +++++-=
----
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                 |   8 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h             |  17 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h          |  13 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h                |  81 ++++++=
+++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h          |  62 ++++++=
+++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h           |  13 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h           |   5 ++
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h          |   9 +--
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h             |  14 +++++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h              |  48 ++++++=
++++------
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h             |  92 ++++++=
+++++++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/{soc.h =3D> system.h} |  16 ++++=
--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                   |  21 ++++--=
-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c                  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h            |  18 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c                  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h               |   4 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                  |  88 ++++++=
+++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h                  |  20 ++++++=
+
 drivers/net/wireless/intel/iwlwifi/iwl-config.h               |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h                  |  19 ++++--=
-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c              |  12 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c            |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h                 |   7 +++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                |  13 ++++-
 drivers/net/wireless/intel/iwlwifi/mei/main.c                 |  30 ++++++=
----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                   | 184 ++++++=
++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c              |   8 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h               |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                   |  55 ++++++=
+++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c             |  39 ++++++=
++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                  |  10 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                  |  30 +++++-=
----
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c             |  62 ++++++=
+++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c                  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c                |   8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                   | 261 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                 |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                 |  51 ++++++=
+++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                  |  10 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c           |  12 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                |  51 ++++++=
+++++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                 |  40 ++++++=
++------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c          |  13 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c               | 115 ++++++=
++++++++++++++++----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                 |   8 ++-
 50 files changed, 1321 insertions(+), 354 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/fw/api/{soc.h =3D> system.h} (70=
%)


--=-DwlaWSaItyGcu0ShPbOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmGwvt4ACgkQoUecoho8
xfpAdw/+I4Vi34l2IpEcFIlaCQ2KNFFUjKfSG1uHHmxvGLRzzXO+rzrzt3f2MecI
ItR5StvCRsE06JTYkrmUWaVIp6FqmRPrFVy9FDzpf+MHfQIHJim6CbPw50WZ6xOc
qBCJ0NAM5+PmwgAHtvHLAp+fluoDRn4pfMQ40r7GXiOT//pt2ggIFAa+kVewaRJ0
ZcPG/Vk08mJqTYru35U27/17G8nEQqvL2vnoet/2PXszKq4JROxKQk2ruT4AXZaU
UpA+yEK1GdcPSpMHdDs67s5h8TsQdNtgK9AAlTJYINbjetiPWAE04uPL35jtKtEo
Q9hipWHshQhj+5deyutyzVOpvqNlGIl20IHzgUm0sKxwmVtOr1ABxxolJqkjnUUJ
qYR6fgHWvMylx3X52ll7jDZ44Mcn8JZQgz55FsNCsTGFHZbjTYGmSaGSBt79J/2k
z9MTlxaxfgRBSE22QZPGXms8Dt8xglz4gbKNB18OQc4lzCLAjzxA7U0RMw6PwDTY
wm5VTaMHB5ZQM3J3cqV3Run62IIRBu84425LZbBSUElGiu+NePVUJDJi1Z3jKtMv
xuBGdKHoW+dlYV28RJxyMY6T9v/+0fngYLj75LiaD+joRjjrTk5E8mBi2nt+ysJs
0SpB0eOBRT6vN9gRMlsNoX8QYIS22Dos4+aJReEmhqXqmprgeJM=
=oj5b
-----END PGP SIGNATURE-----

--=-DwlaWSaItyGcu0ShPbOw--
