Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCB137CAA
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2020 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgAKJlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jan 2020 04:41:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52408 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728719AbgAKJlB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jan 2020 04:41:01 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iqDGK-0004ai-HW; Sat, 11 Jan 2020 11:40:58 +0200
Message-ID: <e58709ad7fd4909fca3726e181f048b1862c962b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Sat, 11 Jan 2020 11:40:54 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-mRUUMuGJmXcJ69uxQggl"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-fixes for v5.5 2020-01-11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-mRUUMuGJmXcJ69uxQggl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of fixes intended for v5.5.  This includes the
last 2 patchsets I sent plus Mehmet's revert that I sent separately.=20
More details about the contents in the tag description.

I pushed this to my pending branch and I got results from kbuildbot for
the first series, but not to
the second one yet.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 33328bfab892d676920abb440d41fbf4b16c2717=
:

  MAINTAINERS: change Gruszka's email address (2019-12-19 14:54:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git t=
ags/iwlwifi-for-kalle-2020-01-11

for you to fetch changes up to 205608749e1ef394f513888091e613c5bfccbcca:

  Revert "iwlwifi: mvm: fix scan config command size" (2019-12-30 15:43:40 =
+0200)

----------------------------------------------------------------
First batch of fixes intended for v5.5

* Don't send the PPAG command when PPAG is disabled, since it can
  cause problems;
* A few fixes for a HW bug;
* A fix for RS offload;
* A fix for 3168 devices where the NVM tables where the wrong tables
  were being read.
* Fix a couple of potential memory leaks in TXQ code;
* Disable L0S states in all hardware since our hardware doesn't
  officially support them anymore (and older versions of the hardware
  had instability in these states);
* Remove lar_disable parameter since it has been causing issues for
  some people who erroneously disable it;
* Force the debug monitor HW to stop also when debug is disabled,
  since it sometimes stays on and prevents low system power states;

----------------------------------------------------------------
Gil Adam (1):
      iwlwifi: don't send PPAG command if disabled

Haim Dreyfuss (1):
      iwlwifi: Don't ignore the cap field upon mcc update

Johannes Berg (8):
      iwlwifi: pcie: move page tracking into get_page_hdr()
      iwlwifi: pcie: work around DMA hardware bug
      iwlwifi: pcie: detect the DMA bug and warn if it happens
      iwlwifi: pcie: allocate smaller dev_cmd for TX headers
      iwlwifi: mvm: report TX rate to mac80211 directly for RS offload
      iwlwifi: pcie: extend hardware workaround to context-info
      iwlwifi: mvm: fix SKB leak on invalid queue
      iwlwifi: mvm: fix potential SKB leak on TXQ TX

Luca Coelho (6):
      iwlwifi: fix TLV fragment allocation loop
      iwlwifi: mvm: fix NVM check for 3168 devices
      iwlwifi: pcie: rename L0S_ENABLED bit to L0S_DISABLED
      iwlwifi: pcie: always disable L0S states
      iwlwifi: remove lar_disable module parameter
      iwlwifi: fw: make pos static in iwl_sar_get_ewrd_table() loop

Mehmet Akif Tasova (1):
      Revert "iwlwifi: mvm: fix scan config command size"

Shahar S Matityahu (1):
      iwlwifi: dbg: force stop the debug monitor HW

 drivers/net/wireless/intel/iwlwifi/dvm/tx.c         |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c        |  10 ++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         |   7 +---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h        |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    |   9 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c        |   3 --
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h  |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c  |  61 ++++++++++++++++=
+++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h  |   9 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c      |  10 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h      |  26 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |   8 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 157 ++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |   7 +---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c        |  12 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c         |  21 ++++------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c |  45 ++++++++++++++++=
+++--
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h  |  19 +++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c     |  47 +++++++++++++---=
------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c   | 208 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c        |  68 ++++++++++++++++=
++++++----------
 22 files changed, 566 insertions(+), 170 deletions(-)

--=-mRUUMuGJmXcJ69uxQggl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl4ZmCYACgkQoUecoho8
xfpYCQ/+IhL5/8SmKBuB9VJtucLgWDkDaYBTBGppGUMmMbejvJtgI3lpost6bitf
YRVScRzyKHA79WKBN1zOnIB7xMglWQHs5FmnhgKpo2ECCiEryf0AtASweBgmxDmA
g00OGFm6L7LaCZFKMS9wcE8JQaXxee/3yzFxIAsUFUxBeMMlrRT953UXErE1i80s
bkyV3VKLSuPc0LX/gxdnl1APTWo5VY8bXicWIJIwI85QXJSK2zSnVepTSS8pJKTn
RpAi+JxHEvvqq+TLLJf07VI+dw8AV5eqojCkFf8GTP6JaGYs9h1PhoWBRe5EmNE0
tzrbzqh7u0kaFZXATiOnSUTfHm9jAP4m2FxTx/hJ6f3dnkCLYCF0mqR5uJ7T2Coi
NKt59W3XxfZ7Ni7M6NWHT774qJC5xRUaQeTI/jW0NG97Wno6UajZyFV2b/kchsbN
WjN07QLNla4D57eZxoIAS1p7bMUVv8tHpe710BnfzAEoi6tYtnZqtKro416QHCXA
LsyM6ZZs3YXlOMzWzSPtLBBzhy7Zv3HNjJX0g1oCqkRzTabG9xqr4wrswRftrUi8
RxKLYCAFB23BnVMFSVYuNpW58UF7ThbO7M74A0p/ImNuHR0bpUmij+Y+oh0IV+mc
/o3/vWEZ1DEVheRzCez60JgUAGMt9neBAEPvXtX/q8ZnaYt+ZzQ=
=kkKk
-----END PGP SIGNATURE-----

--=-mRUUMuGJmXcJ69uxQggl--

