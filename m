Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBCDC095
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633027AbfJRJIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 05:08:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50166 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406023AbfJRJIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 05:08:51 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLOFb-00022q-1u; Fri, 18 Oct 2019 12:08:48 +0300
Message-ID: <3aa31c1474703a74e539d97720ce6ef68b3e5893.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Fri, 18 Oct 2019 12:08:45 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ssCO+5fKT8KQZXHpq8yf"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2019-10-18
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ssCO+5fKT8KQZXHpq8yf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.4.  This includes the
last patchset 2 patchsets I sent.  Usual development work.  More
details about the contents in the tag description.

I pushed this to my pending branch and got results from kbuildbot for a
previous version but not for the last one yet.  Though there shouldn't
be any issues, since the changes were trivial.  I'll let you know when
I get the results.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 89dca86d29b46f2a5f38ea6476cfd441bd205d25=
:

  rtw88: mark rtw_fw_hdr __packed (2019-10-16 10:35:25 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-10-18

for you to fetch changes up to e3277617c634b0efadb0429c59c8716531648415:

  iwlwifi: rx: use new api to get band from rx mpdu (2019-10-18 11:52:49 +0=
300)

----------------------------------------------------------------
Patches intended for v5.5

* Revamp the debugging infrastructure;
* Some udpdates to FW API commands;
* Fix max amsdu value calculation;
* Small updates in the debugging infra;
* Some new helper functions;
* A few clean-ups;
* Other small fixes and improvements;

----------------------------------------------------------------
Emmanuel Grumbach (1):
      iwlwifi: mvm: use the new session protection command

Haim Dreyfuss (1):
      iwlwifi: mvm: add support for new version for D0I3_END_CMD

Johannes Berg (1):
      iwlwifi: mvm: remove leftover rs_remove_sta_debugfs() prototype

Lior Cohen (1):
      iwlwifi: mvm: add notification for missed VAP

Mordechay Goodstein (1):
      iwlwifi: mvm: consider ieee80211 station max amsdu value

Shahar S Matityahu (18):
      iwlwifi: dbg_ini: load external dbg cfg after internal cfg is loaded
      iwlwifi: dbg_ini: use new region TLV in dump flow
      iwlwifi: dbg_ini: use new trigger TLV in dump flow
      iwlwifi: dbg: remove multi buffers infra
      iwlwifi: dbg_ini: add monitor dumping support
      iwlwifi: dbg_ini: add error tables dumping support
      iwlwifi: dbg_ini: use new API in dump info
      iwlwifi: dbg_ini: add TLV allocation new API support
      iwlwifi: dbg_ini: implement time point handling
      iwlwifi: dbg_ini: implement monitor allocation flow
      iwlwifi: dbg_ini: add periodic trigger new API support
      iwlwifi: dbg_ini: support domain changing via debugfs
      iwlwifi: dbg_ini: support FW response/notification region type
      iwlwifi: dbg_ini: rename external debug configuration file
      iwlwifi: dbg_ini: remove old API and some related code
      iwlwifi: dbg_ini: support FW notification dumping in case of missed b=
eacon
      iwlwifi: dbg_ini: add user trigger support
      iwlwifi: dbg_ini: use vzalloc to allocate dumping memory regions

Tova Mussai (4):
      iwlwifi: mvm: create function to convert nl80211 band to phy band
      iwlwifi: mvm: Invert the condition for OFDM rate
      iwlwifi: nvm: create function to convert channel index to nl80211_ban=
d
      iwlwifi: rx: use new api to get band from rx mpdu

YueHaibing (1):
      iwlwifi: mvm: fix old-style declaration

 drivers/net/wireless/intel/iwlwifi/Makefile              |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  55 +++++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c            |  25 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h           |   8 +
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h      | 514 +++++++++++=
++++++++++--------------------------------
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h      |  33 +++-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h           |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h   |  80 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 811 +++++++++++=
+++++++++++++++++++++++++++++++++++++++---------------------------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h              |  47 ++---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c          |  35 ++++
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h       |  63 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h             |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h              |  12 --
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |  58 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  28 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         | 891 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h         |  22 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |  26 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h            |   7 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  40 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |  29 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c        |  33 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |  40 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  34 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  31 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c           |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h              |   4 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c            |  23 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  20 +--
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c      | 189 +++++++++++=
++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.h      |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c              |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c           |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  77 ++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 149 +++++++++--=
-----
 38 files changed, 2553 insertions(+), 897 deletions(-)

--=-ssCO+5fKT8KQZXHpq8yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl2pgR0ACgkQoUecoho8
xfpW/g/9GBa4y+BpdpR2uPgWm7OJwq92TPzm8OS4GsuSdcG26LSb0Qn+hIisfc+a
hUfCiENsZAtZAmVtSneNHzOtv1xDvWf6ZIoH1mvvfopmbAdWP9GQcPWjh16w31UB
0o4M38V2WLsyFEKTCW+2FcthC1bdVM6vaa5OLPJsf/PsaQhp2bJijTxp8B2Ezya6
FtLutVunITc0AhAEhplSPvQFQmi28HrCLUoVx6l1/YTGQ8hgSV6S7LWsk8+Y1Mkw
IWD60pLwiGVlEY1f7o2NrdusjB3ykKbGHmUn+CkXyKxhT+f10AA6vaFPDIYPSgL7
astuTVwIdWP0MNw6MFg7OrzeOvAISLHRamMIlACDG9huXScjMva8KXrUZzJco3/J
KFd+TWdYo5v26Ig1OIcx+L3Q/SkHlhFyxMkb69hdGZHjRHA6+n4wiwTduRNvMZQy
yeteFAkZ/iKLQ3gEpTcqzUhUYNVL0JYC3Zzhubr2PPuphSu0U/KmvssG11C55FhW
rwddpB+astFlBXbEDwBNfsdCWFDlXAr+t2SJmYfxD2JF0eeUHrjamolVRW/YhlZT
1Wfd2BWA5z4+77fhqxiu/5wHNIuNro2Y56lwZZjPGktgz/fb3xqH5yWdIxzryGFg
CvK/yyn29b2YXT4iYUYxkgU/ZeKyzWVIf+KeDa+D4Ft2+GfCaaY=
=1LFy
-----END PGP SIGNATURE-----

--=-ssCO+5fKT8KQZXHpq8yf--

