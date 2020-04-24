Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16C01B7295
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgDXLDB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:03:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57812 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726489AbgDXLDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:03:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jRw6j-000OSN-J0; Fri, 24 Apr 2020 14:02:58 +0300
Message-ID: <f786da13f1f1bb41e6a5c38125cde4cc8d67e91c.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Fri, 24 Apr 2020 14:02:56 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-gsyOdCPD4+numFWJNg7M"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-04-24
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-gsyOdCPD4+numFWJNg7M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.8.  This includes
the last two patchsets I sent out.  Usual development work.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 75e69fb11b40ba1256b14f943c7050682c1f5458=
:

  rtw88: 8723d: initialize mac/bb/rf basic functions (2020-04-23 07:47:27 +=
0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-04-24

for you to fetch changes up to d7b14112a51a6cc9807b5c66144b71647e44fe1c:

  iwlwifi: debug: set NPK buffer in context info (2020-04-24 13:30:58 +0300=
)

----------------------------------------------------------------
First set of iwlwifi patches intended for v5.8

* TX queue debugfs improvements;
* Support for a few new FW API versions;
* Remove deprecated scan FW API version;
* New hw configs and other related changes;
* Support for NPK buffers in debugging;
* More debugging fetures;
* Some other small fixes and clean-ups;

----------------------------------------------------------------
Emmanuel Grumbach (1):
      iwlwifi: remove fw_monitor module parameter

Gil Adam (2):
      iwlwifi: mvm: add framework for specific phy configuration
      iwlwifi: debug: set NPK buffer in context info

Ihab Zhaika (2):
      iwlwifi: add new cards for AX family
      iwlwifi: update few product names in AX family

Johannes Berg (6):
      iwlwifi: pcie: use seq_file for tx_queue debugfs file
      iwlwifi: pcie: add n_window/ampdu to tx_queue debugfs
      iwlwifi: pcie: gen2: minor code cleanups in byte table update
      iwlwifi: mvm: add DCM flag to rate pretty-print
      iwlwifi: pcie: move iwl_pcie_ctxt_info_alloc_dma() to user
      iwlwifi: mvm: tell firmware about required LTR delay

Luca Coelho (4):
      iwlwifi: remove deprecated and unused iwl_mvm_keyinfo struct
      iwlwifi: pcie: add cfgs for SoCs with device ID 0x4FD0
      iwlwifi: pcie: add new structure for Qu devices with medium latency
      iwlwifi: pcie: add new structs for So devices with long latency

Mordechay Goodstein (3):
      iwlwifi: move API version lookup to common code
      iwlwifi: support version 9 of WOWLAN_GET_STATUS notification
      iwlwifi: acpi: read TAS table from ACPI and send it to the FW

Shahar S Matityahu (2):
      iwlwifi: dbg: support multiple dumps in legacy dump flow
      iwlwifi: yoyo: support IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT time =
point

Tova Mussai (2):
      iwlwifi: scan: remove support for fw scan api v13
      iwlwifi: nvm: use iwl_nl80211_band_from_channel_idx

 drivers/net/wireless/intel/iwlwifi/Makefile              |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  71 +++++++++++=
++++++++++++++++++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  76 +++++++++++=
+++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |  17 +++++++++++=
+
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h       |  39 +++++++++++=
+++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h           |  39 +++++++++++=
++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h      |  15 ++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |  26 -----------=
-------
 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h          |  12 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h          |  26 -----------=
-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 139 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++---------------------------=
------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h              |  11 --------
 drivers/net/wireless/intel/iwlwifi/fw/file.h             |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.c              | 100 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h              |  19 ++---------=
--
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |  14 +++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  23 +++++++++++=
+----
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  26 +++++++++++=
+------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   4 ---
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h       |   2 --
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h       |   4 +++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |  29 +++++++++++=
++------
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c   |   4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c   |   4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              | 113 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |   4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  25 ++---------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c              |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  44 +++--------=
------------------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  47 +++++++++++=
+++++---------------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c      |  15 ++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            |  34 +++++++++++=
+++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |  16 -----------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 137 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++---------------------------=
----
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |   8 ++++--
 37 files changed, 800 insertions(+), 354 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/img.c

--=-gsyOdCPD4+numFWJNg7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl6ix2AACgkQoUecoho8
xfrhpQ/+L3M+KjFh6pjqBJDQ7pUzAMUJqfRWAH01mM4Er/00yJrrJ6OGxeUqRwxN
wkE5ICKSiosukieUWjZ7bFELQB/AtT1PYBzEg1+L9gPQBnhVSryqWiildcu4xoac
xOeaKbWAK50yjiL3W+VTFNWnjSw6oppGjPqNI5A2hX7S7DHamPQK0lHe/VBseat8
Dr5pEdoyLvKTXdeW1AUhd7PpKjZZ9JRtZuPrW8l1LKIj7Wbs5uqkA29sZQd5bp/2
EEpzGViq2v22onXniUiBDQLbOLCtvstmlnQhz2CHuFptf2xUvl/m9QEJjtLlLbzp
qauOhT5kKEsYIWpwQZhubEu41r0trJpDEhvXFhOu3WYKRO2hX0N4lmd9GttSkZLo
d2sf3f0WbBe0lSpDPL/hxs7alVnvG21XZ6gB4wFK6ENExc1jfu2HoxdUf+UZ4y2+
E8dnwd9NneVTMpHha7Q8DlFs3XP4iGC9KgxwC+O6US+HC12w12bydXsbcpO1b1oC
KArgD9TJ0kJGUUidZkJMuiQQLZzBL5Pyt9k18lImuxRYn5++bc80yyXQq2OIliS+
WwvuCXYKWrwt3K1SFIgtLSchvKS4RcKeNq2Gbj4oUjQScF6eNA0dVyjDj61eucSo
VKSamS+jFEu2yD7wp4Q4kX9ced2SjMinfPC/r1gejWdje++WKN0=
=edkU
-----END PGP SIGNATURE-----

--=-gsyOdCPD4+numFWJNg7M--

