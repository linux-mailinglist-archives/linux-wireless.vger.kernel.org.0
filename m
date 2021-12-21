Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98947BB8B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 09:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhLUINv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 03:13:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51626 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231443AbhLUINu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 03:13:50 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mzaHL-001PBw-Hm; Tue, 21 Dec 2021 10:13:49 +0200
Message-ID: <64f03fe09e5e811878a609824464d84086c3647f.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Tue, 21 Dec 2021 10:13:45 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-jIvWQBuITawDgZFNrQVj"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2021-12-21
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-jIvWQBuITawDgZFNrQVj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my second pull request for v5.17 with the five patchsets I sent
earlier, plus a couple of indentation fixes and a couple of compilation
cleanups that were sent to the list earlier.

Otherwise this is all normal development, new features, bugfixes and=20
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9=
:

  Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/=
scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800=
)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-12-21

for you to fetch changes up to 33511b2061dc0cd85bdb3d2a30cf4b875a7b9635:

  iwlwifi: mei: wait before mapping the shared area (2021-12-21 09:54:32 +0=
200)

----------------------------------------------------------------
iwlwifi patches for v5.17

* Support for Time-Aware-SAR (TAS) as read from the BIOS;
* Fix scan timeout issue when 6GHz is enabled;
* Work continues for new HW family Bz;
* Support for Optimized Connectivity Experience (OCE) scan;
* A bunch of FW debugging improvements and fixes;
* Fix one 32-bit compilation issue;
* Some RX changes for new HW family
* Some fixes for 6 GHz scan;
* Fix SAR table fixes with newer platforms;
* Fix early restart crash;
* Small fix in the debugging code;
* Add new Killer device IDs;
* Datapath updates for Bz family continues;
* A couple of important fixes in iwlmei;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Avraham Stern (4):
      iwlwifi: mvm: add support for OCE scan
      iwlwifi: mvm: perform 6GHz passive scan after suspend
      iwlwifi: mvm: set protected flag only for NDP ranging
      iwlwifi: mvm: fix AUX ROC removal

Ayala Barazani (1):
      iwlwifi: mvm: Add list of OEMs allowed to use TAS

Ayala Beker (2):
      iwlwifi: mvm: correctly set channel flags
      iwlwifi: mvm: correctly set schedule scan profiles

Bjoern A. Zeeb (2):
      iwlwifi: iwl-eeprom-parse: mostly dvm only
      iwlwifi: do not use __unused as variable name

Dan Carpenter (2):
      iwlwifi: mvm: fix a stray tab
      iwlwifi: mvm: clean up indenting in iwl_mvm_tlc_update_notif()

Emmanuel Grumbach (2):
      iwlwifi: mei: clear the ownership when the driver goes down
      iwlwifi: mei: wait before mapping the shared area

Gregory Greenman (1):
      iwlwifi: mvm: rfi: update rfi table

Ilan Peer (2):
      iwlwifi: mvm: Increase the scan timeout guard to 30 seconds
      iwlwifi: mvm: Fix calculation of frame length

Johannes Berg (19):
      iwlwifi: fix Bz NMI behaviour
      iwlwifi: fw: remove dead error log code
      iwlwifi: parse error tables from debug TLVs
      iwlwifi: dump CSR scratch from outer function
      iwlwifi: dump both TCM error tables if present
      iwlwifi: dump RCM error tables
      iwlwifi: mvm: fix 32-bit build in FTM
      iwlwifi: fix debug TLV parsing
      iwlwifi: fix leaks/bad data after failed firmware load
      iwlwifi: mvm: isolate offload assist (checksum) calculation
      iwlwifi: remove module loading failure message
      iwlwifi: mvm: use a define for checksum flags mask
      iwlwifi: mvm: handle RX checksum on Bz devices
      iwlwifi: mvm: don't trust hardware queue number
      iwlwifi: mvm: change old-SN drop threshold
      iwlwifi: mvm: support Bz TX checksum offload
      iwlwifi: mvm: drop too short packets silently
      iwlwifi: mvm: remove card state notification code
      iwlwifi: fw: fix some scan kernel-doc

Luca Coelho (4):
      iwlwifi: recognize missing PNVM data and then log filename
      iwlwifi: don't pass actual WGDS revision number in table_revision
      iwlwifi: bump FW API to 69 for AX devices
      iwlwifi: pcie: make sure prph_info is set when treating wakeup IRQ

Matti Gottlieb (1):
      iwlwifi: Read the correct addresses when getting the crf id

Mike Golant (2):
      iwlwifi: pcie: add jacket bit to device configuration parsing
      iwlwifi: add support for BNJ HW

Miri Korenblit (3):
      iwlwifi: mvm: support revision 1 of WTAS table
      iwlwifi: mvm: always store the PPAG table as the latest version.
      iwlwifi: mvm: fix rfi get table vendor command handler

Mordechay Goodstein (2):
      iwlwifi: rs: add support for TLC config command ver 4
      iwlwifi: return op_mode only in case the failure is from MEI

Mukesh Sisodiya (2):
      iwlwifi: yoyo: support TLV-based firmware reset
      iwlwifi: yoyo: fix issue with new DBGI_SRAM region read.

Nathan Errera (1):
      iwlwifi: mvm: test roc running status bits before removing the sta

Yaara Baruch (1):
      iwlwifi: pcie: add killer devices to the driver

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  58 +++++++++++++=
+++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |  47 ++++++++++---=
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  23 ++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h      |   9 ---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |  10 +---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |  26 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  25 +++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |   8 +--
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h         |  56 +++++++++++++=
+++---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |  45 +++++++++++++=
--
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |  11 ++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |   7 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c           | 149 +++++++++++++=
++++++++++++++++--------------------
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |   1 -
 drivers/net/wireless/intel/iwlwifi/fw/img.c            |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |   4 ++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  13 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |  58 +++++++++++++=
++++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |  92 +++++++++++++=
++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c  |   4 ++
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h            |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c            |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h          |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |  13 ++++-
 drivers/net/wireless/intel/iwlwifi/mei/main.c          |   7 +++
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 169 +++++++++++++=
+++++++++++++++++++++++-------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  18 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  38 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c           |  46 ++++++++++---=
--
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  97 +++++++++++++=
+++++++------------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  48 +++++++++++--=
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          |  40 ++++++++-----=
-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  24 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            | 102 +++++++++++++=
+++++++++++----------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 286 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++-----------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |   7 ++-
 41 files changed, 1086 insertions(+), 485 deletions(-)


--=-jIvWQBuITawDgZFNrQVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmHBjLkACgkQoUecoho8
xfoJuA/+MAlC0jJ2VxrQUDbmy8gXLaD0Ek+3hqyo/DvhN92hX1gmS43OUsk4UNKX
zxENFZbXZj1zZsmgxsAW9NhBmrupmtW++LsgiSiP10zQggWQwZVqCjNRrdksjvG2
Ij+tmhNNTzHkPnhbsyQ1Syp7N3ZhMs1gjXbfapfkcZdXDpOlVltf0O26VxmrekS4
/HRCxnp+KdoBu/4fkebj0CuKCJf/qYsrNcQSDrfOUTLCoE0liNGLW8N2klZxtsbo
OwuM3LDtq4gGlssKt7pSLZ23PtqbyV2ATBfuBl+0CNUrPG0n8lB7z51t46fFJGhu
s2cxJjgK89jcvALx8MvgxnnSwd5PTHXVPAFShK799NFcBcVzHT1rLx2+UXEN4Qjz
0xnmsxPxYGqcLCvcXd/lWMBb1rPCAUSje5Ox/YBWcTwn8lm6n8Ih7e0qtLCqxrve
kmroczqWjWnZLp4Bdc+IhdeWwRnly1rUr8gpsXFkRoG9oWkpkmmiQaZOv8gHjxQM
k1+xwu4F54EfDrIYkiuWQNoJbkCdeVhjHfR0StJKYEBDgMMwil+yI20WN489YvYO
w2CvXQfq61E6ZnBrMTh7CHH3zeCrlOU+/Snv8AcwWrPYRBHga/7ZJ4deRjhBpQPa
JycYoQ7xBsKSnk6r3rBblPpWnccXdVDHdhX1RsSBSWXxJc2c4oY=
=ZM8v
-----END PGP SIGNATURE-----

--=-jIvWQBuITawDgZFNrQVj--
