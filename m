Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC927F3A6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3U42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 16:56:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725355AbgI3U42 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 16:56:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNj9E-002MYk-BJ; Wed, 30 Sep 2020 23:56:25 +0300
Message-ID: <08351c498348047be547a41a49d3384067a20942.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 23:56:23 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-O/P67apMN7KxAKvQFQY7"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-09-30
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-O/P67apMN7KxAKvQFQY7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.8.  This includes all
the patchsets I sent out for v5.10.  Usual development work.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 1d2a85382282e7c77cbde5650335c3ffc6073fa1=
:

  wl3501_cs: Remove unnecessary NULL check (2020-09-29 11:25:30 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-09-30

for you to fetch changes up to 7ecc1c393f80fcbaa1bbfcfdff05658904cceba6:

  iwlwifi: bump FW API to 57 for AX devices (2020-09-30 23:46:23 +0300)

----------------------------------------------------------------
iwlwifi patches intended for v5.10

* Protected TWT implementation;
* Support disabling 5.8GHz channels via ACPI;
* Support VHT extended NSS capability;
* A few fixes in the datapath;
* Enable TWT by default;
* Support new PPAG FW command version
* Move some trans code around for better abstraction;
* Some clean-ups in the ACPI code;
* A fix for AP mode;
* Updates in the ACPI code to support new tables and FW versions;
* FTM updates;
* A bit of reorganiztion in the queue code;
* A few debugging infra improvements;
* Add support for new GTK rekeying;
* A fix in the scanning code;
* Support for some new cards;
* Some updates for new or changed FW APIs;
* Some new FW API command version implementations;
* Some other small fixes and clean-ups;

----------------------------------------------------------------
Andrei Otcheretianski (2):
      iwlwifi: mvm: Don't install CMAC/GMAC key in AP mode
      iwlwifi: use correct group for alive notification

Avraham Stern (7):
      iwlwifi: mvm: add an option to add PASN station
      iwlwifi: mvm: add support for range request command ver 11
      iwlwifi: mvm: add support for responder dynamic config command versio=
n 3
      iwlwifi: mvm: location: set the HLTK when PASN station is added
      iwlwifi: mvm: responder: allow to set only the HLTK for an associated=
 station
      iwlwifi: mvm: initiator: add option for adding a PASN responder
      iwlwifi: mvm: ignore the scan duration parameter

Ayala Beker (1):
      iwlwifi: mvm: clear all scan UIDs

Dan Halperin (2):
      iwlwifi: mvm: add support for new  version of WOWLAN_TKIP_SETTING_API=
_S
      iwlwifi: mvm: add support for new WOWLAN_TSC_RSC_PARAM version

Emmanuel Grumbach (1):
      iwlwifi: mvm: split a print to avoid a WARNING in ROC

Gil Adam (4):
      iwlwifi: acpi: evaluate dsm to disable 5.8GHz channels
      iwlwifi: acpi: support ppag table command v2
      iwlwifi: regulatory: regulatory capabilities api change
      iwlwifi: thermal: support new temperature measurement API

Golan Ben Ami (1):
      iwlwifi: enable twt by default

Ihab Zhaika (2):
      iwlwifi: add new cards for AX201 family
      iwlwifi: add new cards for MA family

Ilan Peer (1):
      iwlwifi: mvm: Add FTM initiator RTT smoothing logic

Johannes Berg (6):
      iwlwifi: mvm: rs-fw: handle VHT extended NSS capability
      iwlwifi: mvm: use CHECKSUM_COMPLETE
      iwlwifi: mvm: d3: support GCMP ciphers
      iwlwifi: align RX status flags with firmware
      iwlwifi: mvm: d3: parse wowlan status version 11
      iwlwifi: api: fix u32 -> __le32

Luca Coelho (12):
      iwlwifi: dbg: remove IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
      iwlwifi: don't export acpi functions unnecessarily
      iwlwifi: remove iwl_validate_sar_geo_profile() export
      iwlwifi: acpi: remove dummy definition of iwl_sar_set_profile()
      iwlwifi: add a common struct for all iwl_tx_power_cmd versions
      iwlwifi: acpi: prepare SAR profile selection code for multiple sizes
      iwlwifi: support REDUCE_TX_POWER_CMD version 6
      iwlwifi: acpi: rename geo structs to contain versioning
      iwlwifi: support version 3 of GEO_TX_POWER_LIMIT
      iwlwifi: mvm: remove redundant log in iwl_mvm_tvqm_enable_txq()
      iwlwifi: support version 5 of the alive notification
      iwlwifi: bump FW API to 57 for AX devices

Mordechay Goodstein (22):
      iwlwifi: sta: defer ADDBA transmit in case reclaimed SN !=3D next SN
      iwlwifi: msix: limit max RX queues for 9000 family
      iwlwifi: wowlan: adapt to wowlan status API version 10
      iwlwifi: fw: move assert descriptor parser to common code
      iwlwifi: iwl-trans: move all txcmd init to trans alloc
      iwlwifi: move bc_pool to a common trans header
      iwlwifi: iwl-trans: move tfd to trans layer
      iwlwifi: move bc_table_dword to a common trans header
      iwlwifi: dbg: add dumping special device memory
      iwl-trans: move dev_cmd_offs, page_offs to a common trans header
      iwlwifi: mvm: remove redundant support_umac_log field
      iwlwifi: rs: set RTS protection for all non legacy rates
      iwlwifi: acpi: in non acpi compilations remove iwl_sar_geo_init
      iwlwifi: fw: add default value for iwl_fw_lookup_cmd_ver
      iwlwifi: remove wide_cmd_header field
      iwlwifi: move all bus-independent TX functions to common code
      iwlwifi: dbg: remove no filter condition
      iwlwifi: dbg: run init_cfg function once per driver load
      iwlwifi: phy-ctxt: add new API VER 3 for phy context cmd
      iwlwifi: pcie: make iwl_pcie_txq_update_byte_cnt_tbl bus independent
      iwlwifi: dbg: add debug host notification (DHN) time point
      iwlwifi: yoyo: add support for internal buffer allocation in D3

Naftali Goldstein (1):
      iwlwifi: mvm: process ba-notifications also when sta rcu is invalid

Nathan Errera (2):
      iwlwifi: mvm: support new KEK KCK api
      iwlwifi: mvm: support more GTK rekeying algorithms

Roee Goldfiner (1):
      iwlwifi: add new card for MA family

Sara Sharon (1):
      iwlwifi: mvm: add d3 prints

Shaul Triebitz (3):
      iwlwifi: mvm: add PROTECTED_TWT firmware API
      iwlwifi: mvm: set PROTECTED_TWT in MAC data policy
      iwlwifi: mvm: set PROTECTED_TWT feature if supported by firmware

 drivers/net/wireless/intel/iwlwifi/Makefile            |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |   68 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |   72 ++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |   58 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h      |   25 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h         |   82 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   |  231 ++++++++++++=
+-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h        |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h        |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |  133 ++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h         |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |   29 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |   56 ++++
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |   14 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c            |   55 +++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |   13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |   26 +-
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h         |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   98 +++++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |   78 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   34 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  273 ++++++++++++=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  363 ++++++++++++=
++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  205 ++++++++++++=
-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  356 ++++++++++++=
+++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c      |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |   64 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   51 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c      |  126 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |    6 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |   85 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          |   70 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |   53 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c            |   78 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |   77 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |   46 +--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |   34 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |  158 +---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  132 ++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      | 1089 +-----------=
-----------------------------------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  535 ++++--------=
--------------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c          | 1529 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h          |  230 ++++++++++++=
++
 59 files changed, 4358 insertions(+), 2494 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

--=-O/P67apMN7KxAKvQFQY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl908PcACgkQoUecoho8
xfroSRAAnuLUZhZaXCkJ2Sj4FbDZZu6y3EqxOsuEh9oJB0qNvHHxCTD/oaOv6iaI
N06PMC53DiBX0WDQW1ijuT13uNR6fZEODiDm/2+XJ0ioVxdlfprJ7+UynrhmBW3N
uDVYPPpkdpuV3YKCqlpKyv5Y5kzvlV33BYG5CBcOlBGVz4Zus6HHbz1049B4GFUx
gkGBlZOJuKk3spUFZ/sjqRbaIVVZ4KYy+n6yL6KFE4Clax9GpyE20OJfeyvliIvX
3LN9cQr3H8j4Q3tHBIdnynx7un5KPOrerDHh0yWTUHV46G9AtMP4J7MJoiYEiDZa
q0Pf4711x2nBKlWg5xWH4X9IxBTeNVJhP4tx2K3mNNuePJ8+sLiwNhNzJquYk/U+
GBTMNWHmR/jPqk5HwlSR9q/3hWL82DI0Zz4vWC3s6pPH7tuFYHuDE9UQpESgR9tF
dCx46wkwMa/9gIpcUGdLE4VF4mIw82TCr1h89GGns1X6S2ZbWQ27TXp+CWCitQ79
4DeW67xthoezfe6wpLIXsar2SCLP/AJag47krU2xKK/2vQwTiYzl6CJUeOf7DozT
b5mpY4GV+4F3aaUnhsswNGtttRx9Ud9wbEoXJwYq3BkElsCTSTPjj38Pt+1yJpB0
WMt2IU6MHSxROtiWFuicECywDKmcsOI8ywG9I2kQS0CHiOlKNB8=
=bH31
-----END PGP SIGNATURE-----

--=-O/P67apMN7KxAKvQFQY7--

