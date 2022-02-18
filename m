Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048574BB56B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 10:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiBRJW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Feb 2022 04:22:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiBRJWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Feb 2022 04:22:25 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2A1EEE3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 01:22:07 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nKzSk-000GcY-S2;
        Fri, 18 Feb 2022 11:22:05 +0200
Message-ID: <d19d9ad6a7ddab0c8345e5922e58e4a28a593c45.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Fri, 18 Feb 2022 11:22:02 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Eeusvrnr/6XHm5ZNAsct"
User-Agent: Evolution 3.42.4-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2022-02-18
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Eeusvrnr/6XHm5ZNAsct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my first pull request for v5.18 with the six patchsets I sent
earlier, plus about 10 patches sent by the community.

This is all normal development, new features, bugfixes and  cleanups.=20
More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit ea0de861374b06f97620eb508d442161b56cfa62=
:

  mac80211_hwsim: Advertise support for EHT capabilities (2022-02-16 15:44:=
45 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2022-02-18

for you to fetch changes up to cb0a1fb7fd86b0062692b5056ca8552906509512:

  iwlwifi: dbg_ini: Split memcpy() to avoid multi-field write (2022-02-18 1=
0:40:56 +0200)

----------------------------------------------------------------
iwlwifi patches for v5.18

* Support UHB TAS enablement via BIOS;
* Remove a bunch of W=3D1 warnings;
* Add support for channel switch offload;
* Support a new FW API command version;
* Support 32 Rx AMPDU sessions in newer devices;
* Support a few new FW API command versions;
* Some debugging infra fixes;
* A few fixes in the HE functionality;
* Add a few new devices;
* A bunch of fixes for W=3D1 and W=3D3 warnings;
* Add support for a couple of new devices;
* Fix a potential buffer underflow;
* W=3D1 warnings clean up continues;
* Some improvements and fixes in scanning;
* More work on the Bz family of devices;
* Add support for band disablement via BIOS;
* Bump FW API version;
* Fix config structure for one device;
* Support a new FW API command version;
* Support new queue allocation command;
* Some more debugging improvements;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Abhishek Naik (2):
      iwlwifi: nvm: Correct HE capability
      iwlwifi: tlc: Add logs in rs_fw_rate_init func to print TLC configura=
tion

Andrei Otcheretianski (1):
      iwlwifi: pcie: make sure iwl_rx_packet_payload_len() will not underfl=
ow

Ayala Barazani (2):
      iwlwifi: mvm: allow enabling UHB TAS in the USA via ACPI setting
      iwlwifi: mvm: Disable WiFi bands selectively with BIOS

Bixuan Cui (1):
      iwlwifi: mvm: rfi: use kmemdup() to replace kzalloc + memcpy

Bjoern A. Zeeb (2):
      iwlwifi: de-const properly where needed
      iwlwifi: propagate (const) type qualifier

Cai Huoqing (1):
      iwlwifi: Make use of the helper macro LIST_HEAD()

Colin Ian King (1):
      iwlwifi: Fix -EIO error code that is never returned

Dan Carpenter (2):
      iwlwifi: mvm: fix off by one in iwl_mvm_stat_iterator_all_macs()
      iwlwifi: mvm: Fix an error code in iwl_mvm_up()

Emmanuel Grumbach (3):
      iwlwifi: mvm: starting from 22000 we have 32 Rx AMPDU sessions
      iwlwifi: don't dump_stack() when we get an unexpected interrupt
      iwlwifi: mvm: always remove the session protection after association

Golan Ben Ami (1):
      iwlwifi: bump FW API to 70 for AX devices

Gregory Greenman (1):
      iwlwifi: mvm: rfi: handle deactivation notification

Ilan Peer (5):
      iwlwifi: mvm: Correctly set fragmented EBS
      iwlwifi: scan: Modify return value of a function
      iwlwifi: mvm: Passively scan non PSC channels only when requested so
      iwlwifi: mvm: Unify the scan iteration functions
      iwlwifi: mvm: Consider P2P GO operation during scan

Johannes Berg (28):
      iwlwifi: prefer WIDE_ID() over iwl_cmd_id()
      iwlwifi: mvm: fw: clean up hcmd struct creation
      iwlwifi: make iwl_fw_lookup_cmd_ver() take a cmd_id
      iwlwifi: fix various more -Wcast-qual warnings
      iwlwifi: avoid void pointer arithmetic
      iwlwifi: mvm: refactor iwl_mvm_sta_rx_agg()
      iwlwifi: mvm: support new BAID allocation command
      iwlwifi: mvm: align locking in D3 test debugfs
      iwlwifi: mvm: support v3 of station HE context command
      iwlwifi: fw: make dump_start callback void
      iwlwifi: move symbols into a separate namespace
      iwlwifi: dbg-tlv: clean up iwl_dbg_tlv_update_drams()
      iwlwifi: avoid variable shadowing
      iwlwifi: make some functions friendly to sparse
      iwlwifi: mei: avoid -Wpointer-arith and -Wcast-qual warnings
      iwlwifi: pcie: adjust to Bz completion descriptor
      iwlwifi: drv: load tlv debug data earlier
      iwlwifi: eeprom: clean up macros
      iwlwifi: remove unused macros
      iwlwifi: debugfs: remove useless double condition
      iwlwifi: mei: use C99 initializer for device IDs
      iwlwifi: mvm: make iwl_mvm_reconfig_scd() static
      iwlwifi: make iwl_txq_dyn_alloc_dma() return the txq
      iwlwifi: remove command ID argument from queue allocation
      iwlwifi: mvm: remove iwl_mvm_disable_txq() flags argument
      iwlwifi: support new queue allocation command
      iwlwifi: api: remove ttl field from TX command
      iwlwifi: mvm: update BAID allocation command again

Kees Cook (1):
      iwlwifi: dbg_ini: Split memcpy() to avoid multi-field write

Luca Coelho (5):
      iwlwifi: mvm: don't iterate unadded vifs when handling FW SMPS req
      iwlwifi: read and print OTP minor version
      iwlwifi: remove unused DC2DC_CONFIG_CMD definitions
      iwlwifi: mvm: don't send BAID removal to the FW during hw_restart
      iwlwifi: fix small doc mistake for iwl_fw_ini_addr_val

Matti Gottlieb (1):
      iwlwifi: pcie: Adapt rx queue write pointer for Bz family

Mike Golant (1):
      iwlwifi: add support for BZ-U and BZ-L HW

Minghao Chi (CGEL ZTE) (2):
      iwlwifi/fw: use struct_size over open coded arithmetic
      iwlwifi: dvm: use struct_size over open coded arithmetic

Miri Korenblit (4):
      iwlwifi: mvm: add support for CT-KILL notification version 2
      iwlwifi: mvm: use debug print instead of WARN_ON()
      iwlwifi: mvm: refactor setting PPE thresholds in STA_HE_CTXT_CMD
      iwlwifi: mvm: move only to an enabled channel

Mordechay Goodstein (6):
      iwlwifi: cfg: add support for 1K BA queue
      iwlwifi: dbg: add infra for tracking free buffer size
      iwlwifi: mvm: only enable HE DCM if we also support TX
      iwlwifi: advertise support for HE - DCM BPSK RX/TX
      iwlwifi: mvm: add additional info for boot info failures
      iwlwifi: mvm: add additional info for boot info failures

Mukesh Sisodiya (4):
      iwlwifi: yoyo: add IMR DRAM dump support
      iwlwifi: yoyo: Avoid using dram data if allocation failed
      iwlwifi: yoyo: support dump policy for the dump size
      iwlwifi: yoyo: send hcmd to fw after dump collection completes.

Nathan Errera (1):
      iwlwifi: mvm: offload channel switch timing to FW

Rotem Saado (3):
      iwlwifi: yoyo: fix DBGI_SRAM ini dump header.
      iwlwifi: yoyo: fix DBGC allocation flow
      iwlwifi: yoyo: remove DBGI_SRAM address reset writing

Takashi Iwai (1):
      iwlwifi: mvm: Don't call iwl_mvm_sta_from_mac80211() with NULL sta

Xiang wangx (1):
      iwlwifi: Fix syntax errors in comments

Yaara Baruch (2):
      iwlwifi: pcie: add support for MS devices
      iwlwifi: pcie: iwlwifi: fix device id 7F70 struct

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  38 +++++++++--
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c          |   1 +
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c            |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |  18 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  11 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |  13 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h     |  33 ----------
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h   | 148 +++++++++++++=
++++++++++++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |  37 +++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h      |  19 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  34 ++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h        | 127 +++++++++++++=
+++++++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  52 +++++++++++++=
+-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h        |  16 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h        |  10 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h         |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            | 297 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h            |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |   8 ++-
 drivers/net/wireless/intel/iwlwifi/fw/img.c            |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c         |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c           |  22 +++----
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c           |  12 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  12 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   3 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |  72 +++++++++++++=
--------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           | 118 +++++++++++++=
++++-----------------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h           |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c   |  12 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h            |  30 +++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c            |  18 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |  43 +++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h          |  13 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |  12 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |  59 +++++++++++++=
+---
 drivers/net/wireless/intel/iwlwifi/mei/main.c          |  10 ++-
 drivers/net/wireless/intel/iwlwifi/mei/net.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  29 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  18 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  25 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  24 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 189 +++++++++++++=
+++++++++++++++++++++--------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c      |  50 ++++++++++++-=
--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      | 328 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++--------------------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |  16 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  30 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c      |  43 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c           |  13 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  32 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c            |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 294 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           | 312 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------=
-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  20 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c            |  11 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |  20 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |  40 +-----------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |  35 ++++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |  46 +++++++++++--=
-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           | 112 +++++++++++++=
+++++++++----------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  49 ++++++++++++-=
-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  14 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c          |  97 +++++++++++++=
+++++----------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h          |  21 +++---
 include/linux/ieee80211.h                              |   1 +
 79 files changed, 2315 insertions(+), 945 deletions(-)


--=-Eeusvrnr/6XHm5ZNAsct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmIPZToACgkQoUecoho8
xfolcBAAkSY9libPUDjoKWWJ8PBm72vuA43hibD7KnM4BxdV2U0odrc8hqQcbEj4
Eonfkz56O2f2N39a0VccrL361caxqUqiIFusMbiiN6Iol/4E9tnatBVoDtTL0+Z9
XCwMocfAd6QaalEzeBGo7TDk3wNmPzznK7x+XyaTlCbSmEyXas3aZU7IYnPDHORS
gbMHRkvslFl+y+/WU3uG19AjsJF2tPxRO5QxMDuNt26D3fGWQIMGs7JmA1uiOai0
Vaqoa4L4vfbrzdpia2KVvDlw8dquesCVRfSsmKH2QYI04m8cOPdAnX39fb5xF7pK
8wotnhqaAp992HiLN0JjTGdE8Q1S2V2syPiiX7wh2VgK6PD9gJSgP1RskbAKJaIY
LewsSMRdNeQvBbEtBcPE5gw3YuEbgMI+XcS7x7Vis3f7UJkgWvIBxUHaURu1mYNl
e4meD6vPgBp34WvO4+GGqyIR1c5gSFbX08BUAXsag90VlICUIVQRBRpaDznKEqUP
5kEbOkmR5PVJOE8QKeEyLA4MPx7FbA1RDFbXMSaMGqEICV5Qt1fUDJR7dYEFVjUl
J0QzASxZbleX/gNsFgsy4YXOdf3umzbhWY311kmGbgrDtnKKjNe1JDAXoPN0XEhH
03PUaegw1lYAGInPrGBiYUmi8BHU1DwXm4Qo7mYijIyGmL5fQUY=
=fdbh
-----END PGP SIGNATURE-----

--=-Eeusvrnr/6XHm5ZNAsct--
