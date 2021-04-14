Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B083C35F0F6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhDNJmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 05:42:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44786 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232167AbhDNJmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 05:42:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lWc23-000Lye-0I; Wed, 14 Apr 2021 12:42:00 +0300
Message-ID: <3bc5f697c8ec26e66009a84a93253758229c6407.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Wed, 14 Apr 2021 12:41:57 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-8Vvy8DK6BlHGTu0ZAH6T"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: pull-request: iwlwifi-next 2021-04-12-v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-8Vvy8DK6BlHGTu0ZAH6T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's v2 of the first batch of patches intended for v5.13.  This
includes the four last patchsets I sent out for v5.13 with the usual
development work.  In v2 I dropped the mei series.  More details about
the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 5871d0c6b8ea805916c3135d0c53b095315bc674=
:

  ionic: return -EFAULT if copy_to_user() fails (2021-04-13 15:08:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-04-12-v2

for you to fetch changes up to 7c81a025054cd0aeeeaf17aba2e9757f0a6a38a1:

  iwlwifi: dbg: disable ini debug in 9000 family and below (2021-04-14 12:0=
7:21 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.13

* Add support for new FTM FW APIs;
* Some CSA fixes;
* Support for new HW family and other HW detection fixes;
* Robustness improvement in the HW detection code;
* One fix in PMF;
* Some new regulatory features;
* Support for passive scan in 6GHz;
* Some improvements in the sync queue implementation;
* Support for new devices;
* Support for a new FW API command version;
* Some locking fixes;
* Bump the FW API version support for AX devices;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Avraham Stern (3):
      iwlwifi: mvm: support range request command version 12
      iwlwifi: mvm: responder: support responder config command version 8
      iwlwifi: mvm: when associated with PMF, use protected NDP ranging neg=
otiation

Emmanuel Grumbach (5):
      iwlwifi: mvm: don't allow CSA if we haven't been fully associated
      iwlwifi: remove TCM events
      iwlwifi: don't warn if we can't wait for empty tx queues
      iwlwifi: mvm: don't disconnect immediately if we don't hear beacons a=
fter CSA
      iwlwifi: mvm: don't WARN if we can't remove a time event

Harish Mitty (1):
      iwlwifi: mvm: refactor ACPI DSM evaluation function

Ilan Peer (1):
      iwlwifi: mvm: Add support for 6GHz passive scan

Johannes Berg (10):
      iwlwifi: pcie: avoid unnecessarily taking spinlock
      iwlwifi: pcie: normally grab NIC access for inflight-hcmd
      iwlwifi: pcie: make cfg vs. trans_cfg more robust
      iwlwifi: mvm: write queue_sync_state only for sync
      iwlwifi: mvm: clean up queue sync implementation
      iwlwifi: remove remaining software checksum code
      iwlwifi: mvm: don't lock mutex in RCU critical section
      iwlwifi: warn on SKB free w/o op-mode
      iwlwifi: trans/pcie: defer transport initialisation
      iwlwifi: fw: print out trigger delay when collecting data

Luca Coelho (1):
      iwlwifi: bump FW API to 63 for AX devices

Matti Gottlieb (2):
      iwlwifi: pcie: Add support for Bz Family
      iwlwifi: pcie: Change ma product string name

Miri Korenblit (3):
      iwlwifi: mvm: enable PPAG in China
      iwlwifi: mvm: support BIOS enable/disable for 11ax in Ukraine
      iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command=
.

Mordechay Goodstein (7):
      iwlwifi: pcie: clear only FH bits handle in the interrupt
      iwlwifi: move iwl_configure_rxq to be used by other op_modes
      iwlwifi: queue: avoid memory leak in reset flow
      iwlwifi: mvm: remove PS from lower rates.
      iwlwifi: pcie: merge napi_poll_msix functions
      iwlwifi: pcie: add ISR debug info for msix debug
      iwlwifi: rs-fw: don't support stbc for HE 160

Mukesh Sisodiya (1):
      iwlwifi: dbg: disable ini debug in 9000 family and below

Ravi Darsi (1):
      iwlwifi: mvm: Use IWL_INFO in fw_reset_handshake()

Roee Goldfiner (1):
      iwlwifi: mvm: umac error table mismatch

Sara Sharon (1):
      iwlwifi: mvm: enable TX on new CSA channel before disconnecting

ybaruch (5):
      iwlwifi: change step in so-gf struct
      iwlwifi: change name to AX 211 and 411 family
      iwlwifi: add 160Mhz to killer 1550 name
      iwlwifi: add ax201 killer device
      iwlwifi: add new so-gf device

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  72 +++++++++++++=
+++++++++++++---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c          |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |  78 +++++++++++++=
++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  13 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 173 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  20 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |  22 ++++-----
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |  30 -------------
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |   8 ++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |   3 ++
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |   5 ++-
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |  59 +++++++++++++=
+++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  12 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   3 ++
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |   5 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |  91 +++++++++++++=
++++++++----------------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   6 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |  11 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  10 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  85 +++++++++++++=
+++++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  27 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 232 +++++++++++++=
++++++++++++++-------------------------------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  59 +++++++++++++=
+++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |  12 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  20 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |   6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  58 +++++--------=
-----------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 128 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |  10 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |  38 ++++++++++++-=
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  27 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |  18 +-------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |  80 +++++++++++++=
+++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  68 ++++++++++++-=
---------------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   8 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |   5 +++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  80 ++++++++++++-=
--------------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c          |  41 ++++---------=
----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h          |   3 +-
 44 files changed, 1102 insertions(+), 541 deletions(-)


--=-8Vvy8DK6BlHGTu0ZAH6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmB2uOUACgkQoUecoho8
xfrpfA/+M8PD4xwMxgC2pxptmY42us5uC/+6kq83zX9fofAMLhTsoS/08GrRgISu
dwcD/LXFpKZfARZcEh7ZdErohPoh0OraNoRpUQTPQD8EmhTXnh1r75PgfCRyzyAb
rDwetknzAvhQMJDZyc4aOj5fubSp/DAajBC91X1p05J0NUaImbmPJIKy220polcI
BZLEvMoKeaU+hZIb39yICrSFBpbooqj8qGEHs+zrFAIU6CVmeiDJtYZb1l4gENIK
BgVzWFgEf/wtHGNzAn8tLVe5+lYmRmP/DXGEhhQWVWpIki7HAkJmv8Iv7jBRLRGN
etGsTP6sScXZJNff1J8RqPjEXZ6z8eClb0+V7mXpIg5UQuAkBtEvZrD/norym0Qg
Xko9KYBPRuv48d/WiaS17+mjo9oEL3WKjP60p97GLOEv7ofsQDbGLNg2rFnRo8n9
sRtmhe4EJu3D/gFz/RPRGxb2HyDiMGWOBaMh+oYjmnZqux4I0s9777ZU4OOIHuk/
XMud6psfx9LZkSjY3bzVDnZ0b1fHW9v6eMH9f+65gBAHJWAqIgs/JRSfReieXMI6
hMpx92znMuvbaqeO4pur4yLq+gMW2SoXFtfaVEnrHlVUmB5KM4jv7zOCGoER1SN4
f59vJt+R7zSwWMjPYnxwV9GbS7jVGNNSfR9QJJDPZVFF7Q+3YRY=
=w0HL
-----END PGP SIGNATURE-----

--=-8Vvy8DK6BlHGTu0ZAH6T--

