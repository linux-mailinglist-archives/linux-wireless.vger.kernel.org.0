Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83F65A972
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF2H3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 03:29:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54812 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726527AbfF2H3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 03:29:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hh7ne-0002Yb-Jc; Sat, 29 Jun 2019 10:29:30 +0300
Message-ID: <0cc44e0dc21beb76c222f484e51e1fd80d562029.camel@coelho.fi>
Subject: pull-request: iwlwifi-next 2019-06-29
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Sat, 29 Jun 2019 10:29:28 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-R9keWYFCrxcObQmrZQ6T"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-R9keWYFCrxcObQmrZQ6T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's a batch of patches intended for v5.3.  This includes the last
patchset 2 patchsets I sent intender for v5.3 and the one I sent with
fixes for v5.2, because we failed to put them in time for your last
pull-request (as we discussed on IRC).  Usual development work and 6
important fixes.  More details about the contents in the tag
description.

I pushed this to my tree, but I didn't get any results from kbuildbot
for quite a while, as we discussed.  I'll let you know if I get any
results in the next couple of days.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit b741422218efeb76389a307b72ed3afe41671cf7=
:

  rtw88: refine flow to get tx power index (2019-06-27 20:24:29 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-06-29

for you to fetch changes up to 940225628652b340b2bfe99f42f3d2db9fd9ce6c:

  iwlwifi: mvm: clear rfkill_safe_init_done when we start the firmware (201=
9-06-29 10:14:45 +0300)

----------------------------------------------------------------
Patches intended for v5.3

* Work on the new debugging framework continues;
* Update the FW API for CSI;
* Special SAR implementation for South Korea;
* Fixes in the module init error paths;
* Debugging infra work continues;
* A bunch of RF-kill fixes by Emmanuel;
* A fix for AP mode, also related to RF-kill, by Johannes.
* A few clean-ups;
* Other small fixes and improvements;

----------------------------------------------------------------
Andrei Otcheretianski (1):
      iwlwifi: mvm: Drop large non sta frames

Dan Carpenter (1):
      iwlwifi: remove some unnecessary NULL checks

Emmanuel Grumbach (7):
      iwlwifi: support FSEQ TLV even when FMAC is not compiled
      iwlwifi: mvm: make the usage of TWT configurable
      iwlwifi: pcie: fix ALIVE interrupt handling for gen2 devices w/o MSI-=
X
      iwlwifi: fix RF-Kill interrupt while FW load for gen2 devices
      iwlwifi: pcie: don't service an interrupt that was masked
      iwlwifi: don't WARN when calling iwl_get_shared_mem_conf with RF-Kill
      iwlwifi: mvm: clear rfkill_safe_init_done when we start the firmware

Gustavo A. R. Silva (2):
      iwlwifi: lib: Use struct_size() helper
      iwlwifi: d3: Use struct_size() helper

Haim Dreyfuss (2):
      iwlwifi: Add support for SAR South Korea limitation
      iwlwifi: mvm: Add log information about SAR status

Jiri Kosina (1):
      iwlwifi: iwl_mvm_tx_mpdu() must be called with BH disabled

Johannes Berg (3):
      iwlwifi: update CSI API
      iwlwifi: fix module init error paths
      iwlwifi: mvm: delay GTK setting in FW in AP mode

Luca Coelho (2):
      iwlwifi: pcie: increase the size of PCI dumps
      iwlwifi: mvm: remove MAC_FILTER_IN_11AX for AP mode

Mordechay Goodstein (2):
      iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all T=
X packets
      iwlwifi: mvm: remove multiple debugfs entries

Naftali Goldstein (1):
      iwlwifi: mvm: correctly fill the ac array in the iwl_mac_ctx_cmd

Shahar S Matityahu (15):
      iwlwifi: dbg: allow dump collection in case of an early error
      iwlwifi: dbg_ini: dump headers cleanup
      iwlwifi: dbg_ini: abort region collection in case the size is 0
      iwlwifi: dbg_ini: add consecutive trigger firing support
      iwlwifi: dbg_ini: use different barker for ini dump
      iwlwifi: dbg_ini: support debug info TLV
      iwlwifi: dbg_ini: implement dump info collection
      iwlwifi: fw api: support adwell HB default APs number api
      iwlwifi: dbg: fix debug monitor stop and restart delays
      iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv
      iwlwifi: dbg_ini: remove redundant checking of ini mode
      iwlwifi: dbg: move trans debug fields to a separate struct
      iwlwifi: dbg_ini: fix debug monitor stop and restart in ini mode
      iwlwifi: dbg: don't stop dbg recording before entering D3 from 9000 d=
evices
      iwlwifi: dbg: debug recording stop and restart command remove

Shaul Triebitz (1):
      iwlwifi: mvm: convert to FW AC when configuring MU EDCA

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c             |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  28 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h      |  22 +++++
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h     |  11 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h        |  12 +++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |  15 ++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 427 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------=
-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h              | 133 +++++++++++=
+++++++-----------
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h       | 111 +++++++++++=
+++++++------
 drivers/net/wireless/intel/iwlwifi/fw/file.h             |  17 ++--
 drivers/net/wireless/intel/iwlwifi/fw/init.c             |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |  28 +++++--
 drivers/net/wireless/intel/iwlwifi/fw/smem.c             |  12 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  33 ++++----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |  35 ++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  75 ++++++++++-=
------
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |  14 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |  66 ++++++++++-=
----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              |  72 +++++++++++=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c        |  16 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |  66 +++++++++++=
++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  12 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c             |   9 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  26 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c           |  25 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  12 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h             |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c              |  16 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c           |  20 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  10 +--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |  29 ++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c             |  68 +++++++++--=
----
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c     |  11 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 187 +++++++++++=
+++++++++++-------------------
 37 files changed, 1110 insertions(+), 530 deletions(-)

--=-R9keWYFCrxcObQmrZQ6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl0XE1gACgkQoUecoho8
xfrY/g/9EkG2/QUdj5LBVYjWjNjNOQ86xOe5AtPkjblcvr7VV7c79n39vIOvXaMx
Hln7uBIVaNwda2vDwoCxN5VhxTY4o2cpbX08XBbOT17+ZiYgqTY4b/2N+snHk1k2
g2bfa1wRH3cuoBEvZva2BYkWgwodU/PRwXeYqk+hTiy01Hmlnhh55EtntwZ5bjMD
YAPvq2CHp2iZX6D7st99+hfsnop9pOc/ux3KRDmSHJwJg14GLPEnF/mlNow0S62/
vrqZbFjoWEBsrF+2SK8W9FavYOoqV2oTVhksw/TyXp8/pETV3/9vlLnTtcDpR5pD
fgzB3IyFw0Kvlb8NA0/2+WbDzGVHg5lhzohrYNBDndTRNm40eK00lBYUhcb2ml9X
n3P9JCRbV3TbIiPEyV/3U/9IND6AF4Tvp1aW+xhnij3f7EDJkr2VAbHZojSMpjzF
DYf0uVOrqSLM+MZfkMJBgWnMVA/i+GoQ5+wAiL6hZ/pVIhK6o0UMiS/RsODIeIpK
UUaXk0oCA3/oki6eBZP9CHvMDW6rJCaRIOM67HOeXuLcaZrlq3l2LOfZ1R6odwKt
aYXlZCOmuelt9s1Gku3WvbbK3TYfbj/P3Ig2anJOAxngjfXWtixz7mWZOcOMs72z
z4buncGag5sL46nA7+BpgD00MPqNgt8RXs9Oggyzb+pvJdl1r8o=
=4iln
-----END PGP SIGNATURE-----

--=-R9keWYFCrxcObQmrZQ6T--

