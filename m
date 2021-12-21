Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4247BE3F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhLUKmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 05:42:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233721AbhLUKmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 05:42:43 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mzcbQ-001PGR-3Y; Tue, 21 Dec 2021 12:42:41 +0200
Message-ID: <51742e95c6f5f523c26cfe1a44c80489b2880708.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Tue, 21 Dec 2021 12:42:38 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4NFckR8/qqd7vMna6gMM"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2021-12-21 v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-4NFckR8/qqd7vMna6gMM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

This is version two with the s-o-b's added to where they were missing.

Here's my second pull request for v5.17 with the five patchsets I sent
earlier, plus a couple of indentation fixes and a couple of compilation
cleanups that were sent to the list earlier.

Otherwise this is all normal development, new features, bugfixes and=20
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit f85b244ee395c774a0039c176f46fc0d3747a0ae=
:

  xdp: move the if dev statements to the first (2021-12-18 12:35:49 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-12-21-v2

for you to fetch changes up to bcbddc4f9d020a4a0b881cc065729c3aaeb28098:

  iwlwifi: mei: wait before mapping the shared area (2021-12-21 12:39:04 +0=
200)

----------------------------------------------------------------
wlwifi patches for v5.17 v2

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
      iwlwifi: mvm: add US/CA to TAS block list if OEM isn't allowed

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


--=-4NFckR8/qqd7vMna6gMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmHBr54ACgkQoUecoho8
xfpRIhAAu0ClP2S689Ntz1cKkyWF3EuXNryT7dUbqntHytaWKffGeHVSG+c0tHgr
Hz/TAuu4Kw6aze8tUQbMM964JALgjvdJx8IgOI/6QYbpBrbUzcRoZRgePeRQHwJd
QXk6lmX4YrxtyUtx+4ejnEclPDgS5d94QAzIdPPmZrtmZRKohsPgEtZN0JwIC2RQ
GiAX9wrrCVj8Y/kbY9PF1ZeSljL/S2W5VQA4ADLXpEfY8OE5XwrmgjlVFNOXzJoP
03B+sRoYVB7t7axElVgeMARKvfdj6q6RcCvplTzt8zqIXcjhdS9ZDdsS8ilFrBRH
8O8YjCjvYsjh8douOm8bpZ5ZwG3o/7uUG6gyxaJwqKs1SFjbWtnrvYDDhw4rMF+1
Z/yHW3w5NwXQFIAbUA9GlxMhywI0VfBjT73AWr6+Mm7zqNDFzuZc162PjHz/5bgL
Iv8k1/fRCQ7rbqsx+51xlw+BSxF/Dcws+79qxfHlpz+U191iEZa1tx7gcsDSSYin
bNv3wn+zMczpfQ8XbOhTFFYCN/FYrrWqpRRDKpJ0zV4Z5rkOkSnVCQz5F3iwRn3X
7+5dyiHuCYRIIiNsKFswq4/0I7DbygXt0xVOajDAmZOCPxuwhhlhkuMqgsqiViHI
zJBmAIH9IVrhgVoSwfU6hgRDSE/njDlMReCu2A6S5OZoU37PHmo=
=vlsx
-----END PGP SIGNATURE-----

--=-4NFckR8/qqd7vMna6gMM--
