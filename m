Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC5FD72E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKOHoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 02:44:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:57136 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbfKOHoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 02:44:00 -0500
Received: from [185.77.248.5] (helo=dubbel)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iVWGr-0006s6-6L; Fri, 15 Nov 2019 09:43:58 +0200
Message-ID: <12f1628d715bd9915b291aebe8512cfb3c44dec8.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Fri, 15 Nov 2019 09:43:55 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-UNcsAp7lGjmKKS/Ov1wP"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2019-11-13-3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-UNcsAp7lGjmKKS/Ov1wP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's another updated pull request with the second batch of patches
intended for v5.4.  This includes the last patchset 2 patchsets I sent.=20
Usual development work.  More details about the contents in the tag
description.

In this update I have fixed the Change-Id tags that slipped in.  Sorry
about that.

I pushed these patches to my pending branch when I sent them out and
kbuildbot reported success.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 21c60a28af58d7c376502c26fbb0064b39c32917=
:

  rtw88: signal completion even on firmware-request failure (2019-11-08 10:=
27:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-11-13-3

for you to fetch changes up to 37a8f748bb679ed614878dae9bbdb1cfcf9eb99e:

  iwlwifi: mvm: fix non-ACPI function (2019-11-15 09:37:36 +0200)

----------------------------------------------------------------
Second batch of patches intended for v5.5

* Update scan FW API;
* Fix single antenna diversity support;
* Bump the supported FW API version;
* Add debug dump collection on assert in WoWLAN;
* Fix VHT capabilities settings;
* Move ACPI handling code fully into acpi.c;
* Increase the CTDP budget to improve signal strength;
* A fix for compilation with no ACPI enabled;
* Enable adaptive dwell on P2P interfaces;

----------------------------------------------------------------
Colin Ian King (1):
      iwlwifi: remove redundant assignment to variable bufsz

Emmanuel Grumbach (2):
      iwlwifi: pcie: make iwl_pcie_gen2_update_byte_tbl static
      iwlwifi: mvm: sync the iwl_mvm_session_prot_notif layout

Haim Dreyfuss (1):
      iwlwifi: mvm: don't skip mgmt tid when flushing all tids

Ihab Zhaika (1):
      iwlwifi: refactor the SAR tables from mvm to acpi

Johannes Berg (4):
      iwlwifi: FW API: reference enum in docs of modify_mask
      iwlwifi: remove IWL_DEVICE_22560/IWL_DEVICE_FAMILY_22560
      iwlwifi: 22000: fix some indentation
      iwlwifi: mvm: fix non-ACPI function

Luca Coelho (3):
      iwlwifi: mvm: fix support for single antenna diversity
      iwlwifi: mvm: remove else-if in iwl_send_phy_cfg_cmd()
      iwlwifi: bump FW API to 51 for 22000 series

Mordechay Goodstein (3):
      iwlwifi: mvm: in VHT connection use only VHT capabilities
      iwlwifi: mvm: print rate_n_flags in a pretty format
      iwlwifi: mvm: start CTDP budget from 2400mA

Shahar S Matityahu (4):
      iwlwifi: dbg_ini: support dump collection upon assert during D3
      iwlwifi: scan: make new scan req versioning flow
      iwlwifi: scan: support scan req cmd ver 12
      iwlwifi: mvm: scan: enable adaptive dwell in p2p

Tova Mussai (4):
      iwlwifi: nvm: update iwl_uhb_nvm_channels
      iwlwifi: scan: create function for scan scheduling params
      iwlwifi: scan: Create function to build scan cmd
      iwlwifi: scan: adapt the code to use api ver 11

Wang Xuerui (1):
      iwlwifi: mvm: fix unaligned read of rx_pkt_status

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  52 ++++++-------=
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           | 287 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  84 +++++++++++++=
++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       | 208 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h        |  10 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |  18 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |  11 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h            |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   9 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |   7 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 392 +++++++++++++=
+++++----------------------------------------------------------------------=
--------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |  21 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |   8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |   8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h            |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c            |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 557 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c            |  43 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |   7 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  53 +++++--------=
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  31 ++-------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      |  18 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |   2 +-
 34 files changed, 1292 insertions(+), 578 deletions(-)

--=-UNcsAp7lGjmKKS/Ov1wP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl3OVzsACgkQoUecoho8
xfowLxAAqfoesLyUL1HsIbn7gRA+5M8VwTiwyZM5C9DeeuPB48pNV4MOLeYIdn4B
J7NmXvh/hIwZHPXlX3cZy1jwzEO2/qo3QuS4UA6kqwCUO4LvN9SY8ctSvj16dr/P
uWbR6JLkY+Mc/0ZrY4JX8kpqD/ruAfPKWOsfNIz1Bpo6dPW5/u3Of+AtQg1UZInj
XDs93GGIS+XpVgjreEZ/ng/mPSXZmA+iTO5UQt663HXbf+Zd12Gz2KaNKqIHrheY
y1htVcBVoSwXWq/TaWC8KDVslVnBtFM0IToe1Kq6hmukuWEKXimTVjpDJq1LBFFt
gALFqJMh4rAjCsoEhxraNL05caRqz41p0TPUqLvTEjR86Tv5OZdcPZ0fwctwH60r
bEIBjMRc4YAVYUFCt/LEmGgq6nayoHN/ETnAVNgLItgaZQZseIE4kX8ltvXfvzFf
41CCtI5wd89i9SAAJuGJM4DLfznPBYcG6tNsscIyRDYiTBa2eUP2Tb3wikweHL5c
sgyug/ig/VXVkCrp0FzpvBGPIMzfa+XR+L7xJTj2Rgbb3T4qgaNUNiB4iZsOcpH2
EwStlnwb1HDH7HEOelQOawQ57cd1sjZm+MJdKjZe9ChAIgMC44jt7NnFIlp5BwMA
UaF+5jke6WZSDJKAUpVzW2TCwU66wa36OgwZ/JbVLlToT0lmjhk=
=7DZB
-----END PGP SIGNATURE-----

--=-UNcsAp7lGjmKKS/Ov1wP--

