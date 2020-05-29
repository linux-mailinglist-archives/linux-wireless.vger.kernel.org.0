Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55F1E770A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgE2HkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 03:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:35076 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgE2HkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 03:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeZcX-000jzT-6b; Fri, 29 May 2020 10:40:02 +0300
Message-ID: <28366747f660fca49a5abef38b8be1cd93af005d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Fri, 29 May 2020 10:39:59 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-l5SkK7+HpxoaVxK3XuzY"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-05-29
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-l5SkK7+HpxoaVxK3XuzY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the third batch of patches intended for v5.8.  This includes
the last patchset I sent out.  Usual development work.  More details
about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c=
:

  sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02=
 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-05-29

for you to fetch changes up to e6d4318c049574dcfa040725903add2790cfbd7b:

  iwlwifi: bump FW API to 56 for AX devices (2020-05-29 10:32:46 +0300)

----------------------------------------------------------------
Third set of iwlwifi patches intended for v5.8

* Update range request API;
* Add ACPI DSM support;
* Support enabling 5.2GHz bands in Indonesia via ACPI;
* Bump FW API version to 56;
* TX queues refactoring started;
* Fix one memory leak;
* Some other small fixes and clean-ups;

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: add support for range request version 10

Gil Adam (2):
      iwlwifi: acpi: support device specific method (DSM)
      iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia

Haim Dreyfuss (2):
      iwlwifi: set NO_HE if the regulatory domain forbids it
      iwlwifi: pcie: don't count on the FW to set persistence mode

Johannes Berg (1):
      iwlwifi: pcie: gen3: indicate 8k/12k RB size to device

Luca Coelho (1):
      iwlwifi: bump FW API to 56 for AX devices

Mordechay Goodstein (3):
      iwlwifi: pcie: keep trans instead of trans_pcie in iwl_txq
      iwlwifi: move iwl_txq and substructures to a common trans header
      iwlwifi: move txq-specific from trans_pcie to common trans

Sharon (1):
      iwlwifi: mvm: fix aux station leak

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c               |  99 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  22 +++++++++=
+++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h       |  14 +++++----=
-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  34 +++++++++=
+++++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  12 +++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         |   5 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h             | 128 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |  42 +++++++++=
++++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  43 +++++++++=
+++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |   5 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c               |  18 +++++++++=
----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h               |   6 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  10 ++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c        |   6 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h         | 121 ++-------=
---------------------------------------------------------------------------=
-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c               |   6 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  11 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  47 +++++++++=
++++--------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c          |  70 +++++++++=
++++++++++++++--------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c               | 120 +++++++++=
+++++++++++++++++++++++++++++++++------------------------------------------
 21 files changed, 524 insertions(+), 297 deletions(-)

--=-l5SkK7+HpxoaVxK3XuzY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl7QvE8ACgkQoUecoho8
xfqpYBAAkSU2YCE1UulouB7B+1Ix7ZNUbiINbChwrgWaI+EaAu7aopz93CQG8C8S
D/KkjADqeOhHIwnUkrIwrenBQeDang1t8HtYeIiRhWpn7q8IMZLd2fhIMaL0nM0k
xIevVmT1KX1clgRLrbho9GYRZtxN1x1Fzp0NWqLB6Tnm8JsSBm5iVduGI5ON1i1h
zsgVGuBMRBaaHz7BqZLYp6zecq+iYgC/WMz9SiNDk1Kg7/j/K4Mq049xxhit7bXO
glwD0pqG5jEvsz+UDxDFEGWPQuen+cFDwV04Wa1fX5DS7w1esS1h4LoTuk2kI1DL
R61ckoB2OTAb3URghLCF1V3gDGM3XfZHl9UlVu8cUInNWWpnjRR2swHG9D854feD
V7m2azgJvbQCmwEuQc6vL5Raavb1nGkEH/K06bmzVyJzIPS2EdCLZNjmWdEQpNuY
DA5rj8wo/QNon5Q9TtXWt4uKsGOuDL8IlbKUBZHxk/O+W9hg+9j8Vo49rVXfn7NM
vju7keWoQnGXtTMqEhJlVupeEnDgGVX8S4QuB8LYN1FlRnRmXLqaJ3Wc/UIoHb47
xvhaE12dj02+YA915Yts2OG6ugEsFgj+AtZybjfg59wjd4I7Nx4rKAmGU44whl+T
yIZOhcOix4hD3iOokfSnuhlPlwM+Z02d7Tdgt9RnCDXDEo2qYUw=
=5B5+
-----END PGP SIGNATURE-----

--=-l5SkK7+HpxoaVxK3XuzY--

