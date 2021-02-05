Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750B73108BA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBEKLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 05:11:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230482AbhBEKI2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 05:08:28 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7y1T-0044nD-7N; Fri, 05 Feb 2021 12:07:31 +0200
Message-ID: <274043dd180b451125ab059601416d64a951a9f6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 05 Feb 2021 12:07:30 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-LaifhtdnsAWtAfjS49/r"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2021-02-05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-LaifhtdnsAWtAfjS49/r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.12.  This includes
the four last patchsets I sent out for v5.12.  Usual development work.
More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 4832bb371c4175ffb506a96accbb08ef2b2466e7=
:

  iwl4965: do not process non-QOS frames on txq->sched_retry path (2021-01-=
25 16:43:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-02-05

for you to fetch changes up to 47ef328c2090cc790c0766094557aedd04ac923f:

  iwlwifi: pcie: Disable softirqs during Rx queue init (2021-02-05 12:00:13=
 +0200)

----------------------------------------------------------------
iwlwifi patches intended for v5.12

* Check FW notification sizes for robustness;
* Improvements in the NAPI implementation;
* Implement a workaround for CCA-EXT;
* Add new FW API support;
* Fix a CSA bug;
* Implement PHY integration version parsing;
* A bit of refactoring;
* One more CSA bug fix, this time in the AP side;
* Support for new So devices and a bit of reorg;
* Per Platform Antenna Gain (PPAG) fixes and improvements;
* Improvements in the debug framework;
* Some other clean-ups and small fixes.

----------------------------------------------------------------
Dror Moshe (2):
      iwlwifi: parse phy integration string from FW TLV
      iwlwifi: mvm: debugfs for phy-integration-ver

Emmanuel Grumbach (4):
      iwlwifi: remove TRANS_PM_OPS
      iwlwifi: mvm: don't check system_pm_mode without mutex held
      iwlwifi: mvm: cancel the scan delayed work when scan is aborted
      iwlwifi: mvm: fix CSA AP side

Haim Dreyfuss (1):
      iwlwifi: mvm: don't send commands during suspend\resume transition

Ilan Peer (1):
      iwlwifi: pcie: Disable softirqs during Rx queue init

Johannes Berg (13):
      iwlwifi: mvm: add notification size checks
      iwlwifi: mvm: check more notification sizes
      iwlwifi: mvm: remove debugfs injection limitations
      iwlwifi: mvm: scan: fix scheduled scan restart handling
      iwlwifi: mvm: handle CCA-EXT delay firmware notification
      iwlwifi: pcie: properly implement NAPI
      iwlwifi: mvm: simplify TX power setting
      iwlwifi: mvm: debugfs: check length precisely in inject_packet
      iwlwifi: always allow maximum A-MSDU on newer devices
      iwlwifi: mvm: advertise BIGTK client support if available
      iwlwifi: fw api: make hdr a zero-size array again
      iwlwifi: mvm: slightly clean up rs_fw_set_supp_rates()
      iwlwifi: mvm: make iwl_mvm_tt_temp_changed() static

Krishnanand Prabhu (1):
      iwlwifi: mvm: add explicit check for non-data frames in get Tx rate

Luca Coelho (12):
      iwlwifi: bump FW API to 60 for AX devices
      iwlwifi: move SnJ and So rules to the new tables
      iwlwifi: add support for SnJ with Jf devices
      iwlwifi: mvm: move early time-point before nvm_init in non-unified
      iwlwifi: pcie: add support for SnJ with Hr1
      iwlwifi: mvm: set enabled in the PPAG command properly
      iwlwifi: mvm: implement approved list for the PPAG feature
      iwlwifi: mvm: add HP to the PPAG approved list
      iwlwifi: mvm: add Samsung to the PPAG approved list
      iwlwifi: mvm: add Microsoft to the PPAG approved list
      iwlwifi: mvm: add Asus to the PPAG approved list
      iwlwifi: bump FW API to 61 for AX devices

Mordechay Goodstein (9):
      iwlwifi: mvm: add support for new flush queue response
      iwl-trans: iwlwifi: move sync NMI logic to trans
      iwlwifi: dbg: dump paged memory from index 1
      iwlwifi: tx: move handing sync/async host command to trans
      iwlwifi: mvm: add IML/ROM information for other HW families
      iwlwifi: mvm: add triggers for MLME events
      iwlwifi: fwrt: add suspend/resume time point
      iwlwifi: mvm: add tx fail time point
      iwlwifi: mvm: add debugfs entry to trigger a dump as any time-point

Shaul Triebitz (1):
      iwlwifi: mvm: csa: do not abort CSA before disconnect

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c        |  58 ++++++++++++++=
+++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h  |  18 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h     |  15 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h        |   7 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h        |  28 +++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c           |  34 ++++++------
 drivers/net/wireless/intel/iwlwifi/fw/file.h          |   3 ++
 drivers/net/wireless/intel/iwlwifi/fw/img.h           |   3 ++
 drivers/net/wireless/intel/iwlwifi/fw/init.c          |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h       |   7 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c          |  14 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c |   7 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c           |  36 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h         |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c        |  18 ++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h        |  33 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c           |  31 +++--------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c      |  79 ++++++++++++++=
++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c           |  39 +++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c     |  18 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 114 ++++++++++++++=
++++++++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  16 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c          | 195 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++------------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c        |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c           |  13 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c         | 125 ++++++++++++++=
+++++++++++++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c         |  12 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          |  23 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c           |   8 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c           | 175 ++++++++++++++=
+++++++++++++++++++++++++++++++++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c        |  61 ++++++++++++++=
+++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c         | 141 ++++++++++++++=
++++++++++++++++++++----------------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h    |  20 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c          | 267 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++--------------------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c       |  92 +++++++++-----=
-------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c     | 125 +-------------=
-------------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c          | 150 +++-----------=
---------------------------------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c         | 129 ++++++++++++++=
++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h         |   1 +
 40 files changed, 1389 insertions(+), 738 deletions(-)


--=-LaifhtdnsAWtAfjS49/r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmAdGOIACgkQoUecoho8
xfrysg/4wnu1WvR6SFCL/7jh4rsyp7xzQp4EDkFDwfLqfyeIKB9GR77keq7ZLD/t
er0E4mwcSHJJc5SeD2lWngYliHk8nEyucujFi9nQ4+rij+6lY1wwhfpOYe2Hye3T
Xps0yXzaTE63MC7J6kzhlWwSONLStnwnNPeTR3h23Wg46jQyb+SAR/D80JbGGSdC
W0YVdLyr38/sRBqnMtf8FSzgHud+ND5ZiJ8lOdVwQijkjczy2IpCUgEn0/sUQQUm
Ogok2WFOTBzvtKzGavef6OXLfurm4YdmTdJF+XVNJLF3PBYIb3MHUm9LR3P/FDlN
zEbS7S2rJMmS78SGJ34TT4J1OfxLmEQQB7MSBKqQmsuIAU3VvIroMdSYpeWV5gTC
sh1wrCYaNFiymW0Cd7LM1d/ZtIfIQW5/6347DF9GgyxdnGHNK9qQgtbq+8VslAp3
n7qjqtnk8pxdeTL4dZoZA13lv1E2ZURrJsz3pq9Wx1XP+gMzSpQky9By7R7SqzdY
2o2zuO3dy9q4blxOWzRgc2kMN/dXKUNcX0om4SoxFYNOQ27GtM9/BiVqqbdJoc5A
C9WYeBYvXTuaSSPohiTK9XWwtFsn0V3jxXG4B2SqxpRRZU7DZv2fPtZ1wrr5Bx3N
7ZgLez27NbRADaaxymrCbqJ0tgbWyLH67KRaKwWhDKDgwuj/7A==
=0jnp
-----END PGP SIGNATURE-----

--=-LaifhtdnsAWtAfjS49/r--

