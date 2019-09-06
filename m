Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2CAB92C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 15:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392251AbfIFNWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 09:22:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41374 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393293AbfIFNWl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 09:22:41 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i6ECD-0006tC-S5; Fri, 06 Sep 2019 16:22:38 +0300
Message-ID: <ed169588021b846217aa86cbf2576a1375653065.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Fri, 06 Sep 2019 16:22:36 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tx+GI/SwLL4JIpUqoXvw"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2019-09-06
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-tx+GI/SwLL4JIpUqoXvw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's a batch of patches intended for v5.4.  This includes the last
patchset 4 patchsets I sent.  Usual development work.  More details
about the contents in the tag
description.

I pushed this to my pending branch and I got results from kbuildbot to
some of the series, but I didn't get any results yet from the two last
v2 series I sent.  I'll let you know if I get any results in the next
couple of days.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit a18da8f6194978c2b32a8367fb0df81cc6417848=
:

  Merge tag 'mt76-for-kvalo-2019-09-05' of https://github.com/nbd168/wirele=
ss (2019-09-06 11:59:32 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-09-06

for you to fetch changes up to 787350ef8d8044754582e79d28a0d5ef4df08ba4:

  iwlwifi: dbg: remove iwl_fw_cancel_dumps function (2019-09-06 15:52:07 +0=
300)

----------------------------------------------------------------
Patches intended for v5.4

* Remove (broken) d0i3 support;
* Debug infrastructure work continues;
* Bump support FW API version to 50;
* Fix for the SN value in certain suspend/resume situations;
* Some work on new FW scan APIs;
* Work on LTR FW APIs;
* New FW channel-switch support;
* Support new ACPI value for per-platform antenna gain;
* Support for single antenna diversity;
* Support for new WoWLAN FW API;
* Initial refactoring of the device selection code;
* A bunch of clean-ups;
* Other small fixes and improvements;

----------------------------------------------------------------
Alex Malamud (2):
      iwlwifi: LTR updates
      iwlwifi: Set w-pointer upon resume according to SN

Ayala Beker (2):
      iwlwifi: scan: add support for new scan request command version
      iwlwifi: scan: don't pass large argument by value

Beker Ayala (1):
      iwlwifi: mvm: fix scan config command size

Christoph Hellwig (1):
      iwlwifi: stop passing bogus gfp flags arguments to dma_alloc_coherent

Emmanuel Grumbach (20):
      iwlwifi: mvm: remove redundant condition in iwl_mvm_set_hw_rfkill_sta=
te
      iwlwifi: mvm: start to remove the code for d0i3
      iwlwifi: remove all the d0i3 references
      iwlwifi: mvm: remove the tx defer for d0i3
      iwlwifi: mvm: remove the d0i3 entry/exit flow
      iwlwifi: mvm: iwl_mvm_wowlan_config_key_params is for wowlan only
      iwlwifi: mvm: remove d0i3_ap_sta_id
      iwlwifi: mvm: remove iwl_mvm_update_d0i3_power_mode
      iwlwifi: mvm: remove last leftovers of d0i3
      iwlwifi: remove CMD_HIGH_PRIO
      iwlwifi: trans: remove suspending flag
      iwlwifi: remove the code under IWLWIFI_PCIE_RTPM
      iwlwifi: remove runtime_pm_mode
      iwlwifi: remove the opmode's d0i3 handlers
      iwlwifi: pcie: remove the refs / unrefs from the transport
      iwlwifi: pcie: remove some more d0i3 code from the transport
      iwlwifi: remove the d0i3 related module parameters
      iwlwifi: remove pm_runtime completely
      iwlwifi: mvm: simplify the channel switch flow for newer firmware
      iwlwifi: mvm: don't log un-decrypted frames

Gil Adam (1):
      iwlwifi: support per-platform antenna gain

Haim Dreyfuss (4):
      iwlwifi: remove unused regdb_ptrs allocation
      iwlwifi: add support for suspend-resume flow for new device generatio=
n
      iwlwifi: add sta_id to WOWLAN_CONFIG_CMD
      iwlwifi: mvm: add support for single antenna diversity

Hariprasad Kelam (1):
      iwlwifi: fix warning iwl-trans.h is included more than once

Ilan Peer (1):
      iwlwifi: mvm: Block 26-tone RU OFDMA transmissions

Ilia Lin (1):
      iwlwifi: Send DQA enable command only if TVL is on

Johannes Berg (5):
      iwlwifi: mvm: remove unnecessary forward declarations
      iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL
      iwlwifi: api: fix FTM struct documentation
      iwlwifi: mvm: drop BA sessions on too many old-SN frames
      iwlwifi: mvm: handle BAR_FRAME_RELEASE (0xc2) notification

Luca Coelho (12):
      iwlwifi: bump FW API to 49 for 22000 series
      iwlwifi: mvm: remove check for lq_sta in __iwl_mvm_rs_tx_status()
      iwlwifi: bump FW API to 50 for 22000 series
      iwlwifi: remove duplicate FW string definitions
      iwlwifi: remove unnecessary IWL_DEVICE_AX200_COMMON definition
      iwlwifi: separate elements from cfg that are needed by trans_alloc
      iwlwifi: pcie: use the cfg we passed to iwl_trans_pcie_alloc()
      iwlwifi: pcie: move some cfg mangling from trans_pcie_alloc to probe
      iwlwifi: pcie: set iwl_trans->cfg later in the probe function
      iwlwifi: pass the iwl_config_trans_params when needed
      iwlwifi: add a pointer to the trans_cfg directly in trans
      iwlwifi: always access the trans configuration via trans

Mordechay Goodstein (1):
      iwlwifi: mvm: name magic numbers with enum

Shahar S Matityahu (24):
      iwlwifi: dbg: move monitor recording functionality from header file
      iwlwifi: dbg: move debug recording stop from trans to op mode
      iwlwifi: dbg: support debug recording suspend resume command
      iwlwifi: add ldbg config cmd debug print
      iwlwifi: dbg_ini: align dbg tlv functions names to a single format
      iwlwifi: dbg: add debug periphery registers to 9000 device family
      iwlwifi: dbg_ini: maintain buffer allocations from trans instead of T=
LVs buffer
      iwlwifi: dbg_ini: use linked list to store debug TLVs
      iwlwifi: dbg_ini: remove periphery phy and aux regions handling
      iwlwifi: dbg_ini: use function to check if ini dbg mode is on
      iwlwifi: dbg_ini: verify debug TLVs at allocation phase
      iwlwifi: dbg_ini: remove debug flow TLV
      iwlwifi: dbg: align wrt log prints to the same format
      iwlwifi: dbg_ini: separate cfg and dump flows to different modules
      iwlwifi: dbg_ini: use linked list for dump TLVs during dump creation
      iwlwifi: dbg_ini: move tx fifo data into fw runtime
      iwlwifi: dbg_ini: make a single ops struct for paging collect
      iwlwifi: dbg_ini: use regions ops array instead of switch case in dum=
p flow
      iwlwifi: add iwl_tlv_array_len()
      iwlwifi: dbg_ini: remove apply point, switch to time point API
      iwlwifi: fw api: add DRAM buffer allocation command
      iwlwifi: dbg_ini: fix dump structs doc
      iwlwifi: dbg_ini: remove periodic trigger
      iwlwifi: dbg: remove iwl_fw_cancel_dumps function

Shaul Triebitz (2):
      iwlwifi: mvm: add the skb length to a print
      iwlwifi: pass the iwl_trans instead of cfg to some functions

Tova Mussai (2):
      iwlwifi: allocate bigger nvm data in case of UHB
      iwlwifi: mvm: look for the first supported channel when add/remove ph=
y ctxt

 drivers/net/wireless/intel/iwlwifi/Kconfig               |   14 --
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c            |   14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c            |   26 +--
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |   46 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c            |   18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c            |   44 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c            |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c            |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c            |   10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c         |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c             |    5 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c            |   12 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c           |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c              |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |   12 +
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h     |    7 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h           |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h      |  102 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h        |   83 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h          |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h          |    7 +
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h        |   12 +
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h           |   18 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h           |   32 +++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |   55 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 1155 ++++++++++=
+++++++++++++++++++--------------------------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h              |  121 +---------
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h       |   38 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h             |   29 ++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h              |    9 -
 drivers/net/wireless/intel/iwlwifi/fw/init.c             |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/paging.c           |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c             |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |   51 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  236 ++++++++--=
---------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h         |   36 +--
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h        |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   30 +--
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c    |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c     |   14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h              |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c              |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h              |   18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |   60 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h         |   27 +--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h            |    5 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c           |   16 --
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  150 +++++-----=
--
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |  224 ++++------=
--------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |  154 ++++------=
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              |  183 ++++++++++=
++---
 drivers/net/wireless/intel/iwlwifi/mvm/led.c             |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |  424 +++++++++-=
------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  150 +++-------=
--
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c             |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  480 ++--------=
----------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c        |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c           |   82 +------
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c           |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c              |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c              |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c            |  115 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |   98 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c             |   29 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c            |    9 -
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c              |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c              |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c           |   19 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            |  326 ++++++++--=
----------------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |   38 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c             |   77 ++++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c     |   19 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |  380 ++++++++++=
++------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |   52 +----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c             |  176 ++++++----=
----
 84 files changed, 2167 insertions(+), 3633 deletions(-)

--=-tx+GI/SwLL4JIpUqoXvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl1yXZwACgkQoUecoho8
xfq9exAArYFuRiSCqKJ+w7lvBrX9Obj2n/66hWTuy3XkZNXlZim7vyoX16tCNZzE
Jo2bftqYf/1hT+lmzVUeUG+ZQU3suL6ktFYsdNs627eGiKIAL9RBaXR1A4M4spZT
+6pr3r/fsduNaZ1xeUGuXNyXNyPvVlxuEAJz35PJ4e7YL8nDhFD10txvhg/6FgBc
3tLjrt9+eabO2Ghqd8p9V8Rz6c3ERP3Jbj4XzGWpCBmXmKVw03u/nWpj0rRGyBcE
34J6kCslZ3kiEpY8YV9RSpWW7ngMufNfgReBc9k39Jw0Iz/fYfrSkvBiPZXmt5e1
LlDNaRBZeR7GvXiQNPt5mQ31IHjbCySSRXClq3Nc2N5ltCP9K0TBxHrDZCVwbS7p
c48eEqXJEhmltLPw0ek4yEznF8+gPmY1LgumTBSe1/HNDtW8Jl3i7GizApuKqfd5
Pt5kSZ/hxO8cW56JrtdGX+VoYlHdFXcVqSz0sUUjh12wicysZYTYARk15cm2OFqO
fPUjdmZk+2s1ZsX6XBeCrXX1BxAofS7yLO7pAca9xsiVzG0BOAx/1x3T10WybBkr
7PoD96L/3ygsOU0a6NFhn0QRw9OUxMZWFe2wBY3xwtu0ddIZQkLZzN40VyH1/6e8
xNHQsYMXEqFboYx8brMkQN3fwI0j2Gr0cu/NDu5hXAw3WSBug/4=
=SUTs
-----END PGP SIGNATURE-----

--=-tx+GI/SwLL4JIpUqoXvw--

