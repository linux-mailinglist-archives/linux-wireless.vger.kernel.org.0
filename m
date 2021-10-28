Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CF43DDB6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJ1J2k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 05:28:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:32900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229626AbhJ1J2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 05:28:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mg1ff-000fWI-CK; Thu, 28 Oct 2021 12:26:11 +0300
Message-ID: <dc1df61337fad1cb5a83789bc78da8b18541ef26.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Thu, 28 Oct 2021 12:26:01 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uYjTaFHqS4XMehjDg/Ru"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2021-10-28
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-uYjTaFHqS4XMehjDg/Ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my second pull request for v5.16 with the two patchsets I sent
earlier, plus one patch for a new HW combination that I sent this
morning.  I decided to leave out Bj=C3=B6rns patches, because there are
still a few things Johannes and I are discussing about them.

Otherwise this is all normal development, new features, bugfixes and
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit a427aca0a931b8c65b47231bbf09e8873b29d554=
:

  Merge tag 'mt76-for-kvalo-2021-10-23' of https://github.com/nbd168/wirele=
ss (2021-10-27 18:36:30 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-10-28

for you to fetch changes up to cbaa6aeedee5f92dafa5982eceea2a1f98ce4f7d:

  iwlwifi: bump FW API to 67 for AX devices (2021-10-28 12:04:12 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.16

* Support a new ACPI table revision;
* Improvements in the device selection code;
* New HW support;
* Some fixes in the Geographic SAR implementation;
* Support for WiFi 6E enablement via BIOS;
* Support FW API version 67;
* Improve debugging support;
* Some fixes in session protection;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Ayala Barazani (1):
      iwlwifi: ACPI: support revision 3 WGDS tables

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix some kerneldoc issues

Gregory Greenman (1):
      iwlwifi: mvm: update RFI TLV

Ilan Peer (1):
      iwlwifi: mvm: Use all Rx chains for roaming scan

Johannes Berg (10):
      iwlwifi: pcie: fix killer name matching for AX200
      iwlwifi: pcie: remove duplicate entry
      iwlwifi: pcie: refactor dev_info lookup
      iwlwifi: pcie: remove two duplicate PNJ device entries
      iwlwifi: pcie: simplify iwl_pci_find_dev_info()
      iwlwifi: dump host monitor data when NIC doesn't init
      iwlwifi: fw: uefi: add missing include guards
      iwlwifi: mvm: d3: use internal data representation
      iwlwifi: mvm: remove session protection on disassoc
      iwlwifi: mvm: extend session protection on association

Luca Coelho (5):
      iwlwifi: mvm: read 6E enablement flags from DSM and pass to FW
      iwlwifi: mvm: don't get address of mvm->fwrt just to dereference as a=
 pointer
      iwlwifi: rename GEO_TX_POWER_LIMIT to PER_CHAIN_LIMIT_OFFSET_CMD
      iwlwifi: mvm: fix WGDS table print in iwl_mvm_chub_update_mcc()
      iwlwifi: bump FW API to 67 for AX devices

Mike Golant (1):
      iwlwifi: pcie: update sw error interrupt for BZ family

Mukesh Sisodiya (1):
      iwlwifi: yoyo: support for ROM usniffer

Nathan Errera (1):
      iwlwifi: rename CHANNEL_SWITCH_NOA_NOTIF to CHANNEL_SWITCH_START_NOTI=
F

Yaara Baruch (1):
      iwlwifi: add new pci SoF with JF

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c        | 150 ++++++++++++++++=
++++++++++++-------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h        |  40 ++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h      |  43 ------------
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h   |  17 +++++
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  10 +--
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h     |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h   |  55 +++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h     |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h        |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h     |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h        |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h        |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    |  92 ++++++++++++++++=
++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-io.c         |  46 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c         | 357 ++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++---------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |  72 +++++++++++++++-=
----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   |  67 +++++++++++++---=
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c        |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c        |  10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c       |   8 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c       | 149 ++++++++++++++++=
++++++++++++-------------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c        |   9 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c     |  45 ++++++++++---
 26 files changed, 804 insertions(+), 401 deletions(-)


--=-uYjTaFHqS4XMehjDg/Ru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmF6bKkACgkQoUecoho8
xfqLhA/7BH7LfJXvrufvzCDyv9SgLiiU9T3Ngf6qCjbENJ6EjgMRVzuN4/9QiiMQ
1XnI/ILsMg8TSsPFv3+utGgQh84jnsOwAuevgl6tHyr7mMWfdmeVRy2Rt9+rSDqq
/8o92OY2VYNx2WQH6J+NCQvGK9Ogl5n2dkQ/BnHmvKRxFOUxF27XHcVk+wfCquzC
gNBlwf9h2o8NRPxt9znzLSTcuPLaBfaYMOhlDsEEQkvB8OvN/u7K9bJx1uLR76rG
AJowXPsGL2jCsfn1LeBKoCwd34kS7MU+ySN/OpaDvh0m4g+kVV42l7XUIOyr9SF9
ZH04sJgC/1Pv5tsuN2Lcvl4udVIS6DXlrTAbtscDuVBX487DWqWdgw3+KBMi9cHa
8UJLaxEKEAS97fGsabLHmD+a5dPBfiaji5y8j++1Gv22FawezCsK1uhBNaGaF8fL
HD6fzv2AB1nw+WaDGA5Eully6OPVMQhz8Lb/vAISBR/BwoEBc8rBQHLL9XRKZiWn
u6psvrb8mQuV4pUwy13sGo7fVxNbThXQ4PW5VpZObi0uyjos50ogWZxCW6fap/rr
nwU7/fJieVsadypRDxva2+fsxhR/aqlSYRIQgaWxdyJ0EXv0K2OZBsrio/SwlZc/
Im9RfTjTLPbKCmNUC6tOR7HFrGNt/09sQySO3vI3SLQut/GMgC4=
=cBxK
-----END PGP SIGNATURE-----

--=-uYjTaFHqS4XMehjDg/Ru--
