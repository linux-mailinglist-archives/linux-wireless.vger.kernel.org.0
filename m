Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2BD1950F8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0GS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:18:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgC0GS0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:18:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHiJy-0004X8-Cl; Fri, 27 Mar 2020 08:18:23 +0200
Message-ID: <9c8b99b802532b58471eb2024de64b5dc2f5727d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Fri, 27 Mar 2020 08:18:20 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-94uSBx/+0+cm/gLR+pTW"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-03-27
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-94uSBx/+0+cm/gLR+pTW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the second batch of patches intended for v5.7.  This includes
the last two patchsets I sent out.  Usual development work.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 3af4da165f487a3956fe5a7b4ee08b12c7a3a9af=
:

  hostap: convert to struct proc_ops (2020-03-26 21:23:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-03-27

for you to fetch changes up to 84acc85a62a171de98706b9b2cc73a660088314a:

  iwlwifi: mvm: remove newline from rs_pretty_print_rate() (2020-03-27 08:1=
2:53 +0200)

----------------------------------------------------------------
Second set of iwlwifi patches intended for v5.7

* Refactoring of the device selection algorithms continues;
* Improvement in the initialization fo SoC-based devices;
* Support for FW scan API;
* Some additions to our FW debuggging capabilities;
* More refactoring of the device selection algorithms;
* Support new FW API version;
* Support for EDCA measurements;
* New scan API features;
* Enable new debugging code;
* Some other small fixes and clean-ups;

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: add support for non EDCA based measurements

Johannes Berg (6):
      iwlwifi: pass trans and NVM data to HE capability parsing
      iwlwifi: mvm: rs-fw: fix some indentation
      iwlwifi: mvm: enable SF also when we have HE
      iwlwifi: remove IWL_FW_DBG_DOMAIN macro
      iwlwifi: pcie: make iwl_pcie_cmdq_reclaim static
      iwlwifi: mvm: remove newline from rs_pretty_print_rate()

Luca Coelho (15):
      iwlwifi: yoyo: add PCI config space region type
      iwlwifi: pcie: implement read_config32
      iwlwifi: remove redundant iwl9560_2ac_cfg struct
      iwlwifi: move integrated, extra_phy and soc_latency to trans_cfg
      iwlwifi: remove some unused extern declarations from iwl-config.h
      iwlwifi: add HW step to new cfg device table
      iwlwifi: convert all Qu with Jf devices to the new config table
      iwlwifi: convert QnJ with Jf devices to new config table
      iwlwifi: remove unnecessary cfg mangling for Qu C and QuZ with Jf
      iwlwifi: add support for version 2 of SOC_CONFIGURATION_CMD
      iwlwifi: add trans_cfg for devices with long latency
      iwlwifi: remove support for QnJ Hr STEP A
      iwlwifi: remove support for QnJ HR FPGA
      iwlwifi: yoyo: enable yoyo by default
      iwlwifi: bump FW API to 53 for 22000 series

Shahar S Matityahu (2):
      iwlwifi: mvm: add soc latency support
      iwlwifi: scan: support scan req cmd ver 14

Tova Mussai (1):
      iwlwifi: scan: support FW APIs with variable number of profiles

rotem saado (1):
      iwlwifi: yoyo: don't block dumping internal memory when not in SRAM m=
ode

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         | 300 ++++++++++---=
--------------------------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c          |  32 +++--
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   |   6 +
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |  83 +++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h        |  87 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |  47 +++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |  11 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  62 ++++----
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |   6 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   9 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h        |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  46 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   7 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 169 +++++++++++++=
++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c            |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 721 +++++++++++++=
+++++++++++++++++++++++++++++++++------------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |   1 -
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |   2 +-
 30 files changed, 943 insertions(+), 720 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h

--=-94uSBx/+0+cm/gLR+pTW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl59mqwACgkQoUecoho8
xfpQaA/+NeU6l+lmYyNSTUGxNh+CplYtz83zsURrDXjEwoG7MlmpLmL1EhvJ1EnR
XWE5xS7AlafGmE/Tbid/5fArGSS47NWR+/YWxW2V78vmWLGyKKG0HB2JLstKDnSm
GXhFg8E61VbS3qvkxATeDv58gW56XdQwG0fmVLgckuF9qp4H2m/EbkeJm/AUnVdh
t4kE+ki1vtu1TovG6/vCrVToleMwWjeGEN9FFyrrk5yXEkx0gd09+AquOfh4nsXy
Ez54lnUtb5AQfb8JRWsOMrN2uuTk6ozpJPuqi/x376pEzuMtEwI5gSp5uECfqu5s
KTksZWVw+hwnZ8go7H/oqdNB88h1dm5Qzad0CaGmVJvSr5hLKpjZC5RNeryevecm
F5cZzvZTnftlQPWLRGivXqiKxR0UIoOiG4NZrf0vZ04Tiusfw6N1/7C5WMGIbtVd
iSviTjJVo4NW4KLevpbeePXrN/5rdeypR7tgdz3tPZn3Go1E5oGze3YVyuW0ek/Q
c9TCI+ybcyTB75mj3BLw76oYYZfGD3BWgF2eZYpqcdq6q58tFDLKGsIKbCuICyEc
+JN67evhfQhhz4WUgrJnI/wkbJbJBUm5bAZIRhXqlTfKfBm94Dcsvjymd0wOJCgj
SqdSRsym4yb84T/j/I1tvLj0sOhpM4V9VjT/+7Tb0S6/MleTkko=
=1mJQ
-----END PGP SIGNATURE-----

--=-94uSBx/+0+cm/gLR+pTW--

