Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210FC35C461
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhDLKw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:52:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44614 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237944AbhDLKw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:52:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVuAn-000Kxz-H5; Mon, 12 Apr 2021 13:52:07 +0300
Message-ID: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Mon, 12 Apr 2021 13:52:05 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ZszUkfg70f8AuAKrM7QR"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: pull-request: iwlwifi-next 2021-04-12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ZszUkfg70f8AuAKrM7QR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.13.  This includes
the four last patchsets I sent out for v5.13 with the usual development
work.  It also includes Emmanuel's series for adding the iwlmei driver,
including one patch by Alexander Usyskin in the misc drivers directory.
(which Greg asked us to push via our tree).  More details about the
contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit fa9f5d0e0b45a06802f7cb3afed237be6066821e=
:

  iwlegacy: avoid -Wempty-body warning (2021-04-11 12:31:01 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-04-12

for you to fetch changes up to 1a9674efd5364f875a04d4ae2f499dfc4bf22e3b:

  iwlwifi: dbg: disable ini debug in 9000 family and below (2021-04-12 13:2=
7:04 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.13

* Add support for new FTM FW APIs;
* Add new iwlmei driver;
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
Alexander Usyskin (1):
      mei: bus: add client dma interface

Avraham Stern (3):
      iwlwifi: mvm: support range request command version 12
      iwlwifi: mvm: responder: support responder config command version 8
      iwlwifi: mvm: when associated with PMF, use protected NDP ranging neg=
otiation

Emmanuel Grumbach (8):
      cfg80211: allow to specifying a reason for hw_rfkill
      iwlwifi: mei: add the driver to allow cooperation with CSME
      iwlwifi: integrate with iwlmei
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

 drivers/misc/mei/bus.c                                 |   67 +++-
 drivers/misc/mei/client.c                              |    3 +
 drivers/misc/mei/hw.h                                  |    5 +
 drivers/net/wireless/intel/iwlwifi/Kconfig             |   13 +
 drivers/net/wireless/intel/iwlwifi/Makefile            |    2 +
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |   72 +++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c          |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |   78 +++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   |  173 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   20 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |   22 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |   30 --
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |    8 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |   59 +++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |   12 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |    3 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   61 +++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h     |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |   91 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |    8 +-
 drivers/net/wireless/intel/iwlwifi/mei/Makefile        |    8 +
 drivers/net/wireless/intel/iwlwifi/mei/internal.h      |   20 +
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h       |  440 ++++++++++++=
++++++++
 drivers/net/wireless/intel/iwlwifi/mei/main.c          | 2026 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 drivers/net/wireless/intel/iwlwifi/mei/net.c           |  409 ++++++++++++=
+++++++
 drivers/net/wireless/intel/iwlwifi/mei/sap.h           |  736 ++++++++++++=
++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h    |   69 ++++
 drivers/net/wireless/intel/iwlwifi/mei/trace.c         |   15 +
 drivers/net/wireless/intel/iwlwifi/mei/trace.h         |   62 +++
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |   11 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   85 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  235 ++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  101 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   82 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  205 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |   20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |   58 +--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          |  128 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |   38 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |   18 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |  107 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |   68 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |   21 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |   80 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c          |   41 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h          |    3 +-
 include/linux/mei_cl_bus.h                             |    3 +
 include/net/cfg80211.h                                 |   11 +-
 net/wireless/core.c                                    |    7 +-
 65 files changed, 5415 insertions(+), 568 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/internal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/main.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/net.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/sap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.h

--=-ZszUkfg70f8AuAKrM7QR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmB0JlUACgkQoUecoho8
xfpGlw//VEjEdIPK7NIsLvy3WYfD5/UJCxUw113tqnHb5HeW79hvS0Kt8jYvyQ6N
Ih8BbT53Lnp3Z3BbhGV+H9N18AnTMsxCJjx7HfVza3wWfViFVVnQ85VYY8QiVxfK
ORWwrJlR0LbRUZwQPez4+EB74fij3SGKLFy9vq+/Gh1mCoSrYRXYScQ020sG/xXV
Ir1fvhYvVXBrvvFoUi7bix2MIPdkuJvvT3EwMaoVzHAeWFvozRFvcgM0uC0mjC8K
b3JazcwbVF1ASwcNPwYPBqCts8NceWlcBKpC7BCLM4mZzGZi4Ny7DNuvrYZ0oh2Y
2vnyGX9FAug2Rp1FChWxFjyRuuA6dQVZhKtIc+Q/B7c9xtw+18/qacB8gOpfxFFY
FqGtSplIET6xMCSQsFHTzDhV4WBpnBAj68xRL+zK+lBTYCFDB+iiLwUcMChogWdY
d3f/IxZoi8BLAuv0XQ7wc6oj1vaEZ/pJaPqXBfcn0mzMyCdKAg845vCsA6L9cezX
2396CqYNFftG7dSbZTqVAsSn4IMnCXxIyKxEWo8YnS+XUtvmvKNPgiFLjL1q/d78
LSkdBQas/zcw1F27d9F5raM4OyVqDTVRMoqI7d4ijXryEOHtKNJ7dpWVSBhqDNMs
jnikD8isctMQuBc7s2XttIF+C8etpS/xoPA6AyhwTZ2UcBRfvwM=
=qNPF
-----END PGP SIGNATURE-----

--=-ZszUkfg70f8AuAKrM7QR--

