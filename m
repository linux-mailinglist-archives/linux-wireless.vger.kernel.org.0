Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029001B7740
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgDXNnI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 09:43:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgDXNnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 09:43:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jRybh-000OVs-V8; Fri, 24 Apr 2020 16:43:06 +0300
Message-ID: <4e80b41b8fc03d435d13a9f4fe77d5555b0d7cf9.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Fri, 24 Apr 2020 16:43:04 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-S0McXoes0sB1R41wNy4r"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-04-24-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-S0McXoes0sB1R41wNy4r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.8.  This includes
the last two patchsets I sent out.  Usual development work.  More
details about the contents in the tag description.

In v2 I replaced the "iwlwifi: move API version lookup to common code"
patch with v2.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 75e69fb11b40ba1256b14f943c7050682c1f5458=
:

  rtw88: 8723d: initialize mac/bb/rf basic functions (2020-04-23 07:47:27 +=
0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-04-24-2

for you to fetch changes up to cbc636557d2d20c4fb808c14df545b3c407a53d6:

  iwlwifi: debug: set NPK buffer in context info (2020-04-24 16:38:12 +0300=
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
 drivers/net/wireless/intel/iwlwifi/fw/img.c              |  99 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
 37 files changed, 799 insertions(+), 354 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/img.c

--=-S0McXoes0sB1R41wNy4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl6i7OgACgkQoUecoho8
xfovrQ//VsV4Fs/hIO2p8RYX7nNwWKzzcBN+xVG6BN5PodiT3JgrezTcZNFc77X6
32WZk/LbaX2PwIKBtKffSSh1qU63gv+J8wh3WkVA5vfq7qlVnPl26lbtbwN8C4LJ
Qyeo1GFVmMcV7yuLHOhmQRa1Df1Rb9vGR4n37XAi4R0/AfEI62CTQg20G//RjCvJ
Od4SuNM1nsedEQ6OFTqV9qhdUl5/JcjHFdxeNeCnKflxj4uxWy1O+pi1BhDUJ9h8
JKWTUCfLOqaDPFcTSLwO2L+IwD0/kzeVgZgR6mgorP6vYA4ZzO3Yl+UiqeNVQi/P
JYDK3K30IlU/hXURvPjTikg2d3MvddmMKM2isPTDktMsqP8uORgXhQcu5ZKjJoB6
VSiuSi2c536TZ1Iq3C59VxlXEVDJoEJYH04yR/ElzRmT7DSahjb2paLFKSUpKVap
TXrk9SFpduxXGYX4etnuQMkj6EGesHKheDodqasBhTkTK11w6nYb9KwVuT9MST0h
fPGivlje8GYhzcSf5ub6OdGCSGQ0SZTpZQ9svODHiOS7g9eDJj/CuifoLDGe+5Br
1Vrc6X2rIx8hcUduSDzHajdgSD6apVhgiIINGt2YGrXCEV6H4h4GSiydRcd8+nzd
4kQxWDOOmD1YOkctLUTHv+iUp/YPV5GE71+rX6SRb2v+3KwPV6Y=
=22QA
-----END PGP SIGNATURE-----

--=-S0McXoes0sB1R41wNy4r--

