Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBEE726
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfD2QAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 12:00:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51146 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728789AbfD2QAe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 12:00:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hL8hk-00008l-FH; Mon, 29 Apr 2019 19:00:32 +0300
Message-ID: <491e2c7557a981d2e1a721ffe7571ec992dfe62d.camel@coelho.fi>
Subject: pull-request: iwlwifi-next 2019-04-29
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Mon, 29 Apr 2019 19:00:30 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XpMiXDPO0F0gSj9k2Gb6"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-XpMiXDPO0F0gSj9k2Gb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

This is the fourth batch of patches intended for v5.2.  This includes
the last patchset I sent.  Usual development work.  More details about
the contents in the tag description.

I have sent this out before and kbuildbot reported success.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 9ef77fbedad9ea8895cd5d7fb7aee16071f527dc=
:

  brcmfmac: send mailbox interrupt twice for specific hardware device (2019=
-04-26 15:00:53 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-04-29

for you to fetch changes up to a0eaead41db98c08614c4b1ef453bdfaacde962d:

  iwlwifi: dbg_ini: check for valid region type during regions parsing (201=
9-04-29 18:42:48 +0300)

----------------------------------------------------------------
Fourth batch of patches intended for v5.2

* Fix a bug we introduced in the RX path in a previous patch;
* Add command version parsing from the FW TLVs;
* Some fixes and improvements in the new debugging framework;
* Bump the FW API supported for 22000 series;
* Small improvement in FTM;
* Some RF-Kill interrupt handling fixes;
* Support for a new WoWLAN patterns FW API;
* Other small fixes and improvements;

----------------------------------------------------------------
Andrei Otcheretianski (1):
      iwlwifi: mvm: Don't sleep in RX path

Avraham Stern (1):
      iwlwifi: mvm: report FTM start time TSF when applicable

Johannes Berg (3):
      iwlwifi: pcie: initialize debug_rfkill to -1
      iwlwifi: pcie: don't crash on invalid RX interrupt
      iwlwifi: parse command version TLV

Liad Kaufman (1):
      iwlwifi: mvm: limit TLC according to our HE capabilities

Luca Coelho (3):
      iwlwifi: mvm: support v2 of the WoWLAN patterns command
      iwlwifi: bump FW API to 48 for 22000 series
      iwlwifi: pcie: remove stray character in iwl_pcie_rx_alloc_page()

Shahar S Matityahu (6):
      iwlwifi: support fseq tlv and print fseq version
      iwlwifi: dbg_ini: add lmac and umac error tables dumping support
      iwlwifi: dbg_ini: add periodic trigger support
      iwlwifi: dbg: replace dump info device family with HW type
      iwlwifi: avoid allocating memory for region with disabled domain
      iwlwifi: dbg_ini: check for valid region type during regions parsing

YueHaibing (1):
      iwlwifi: Use correct channel_profile iniwl_get_nvm

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h         | 136 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   4 +++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |  70 +++++++++++++=
+++++++++++++++++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h            |   3 +++
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |   4 +--
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |  32 +++++++++++++=
++++++----
 drivers/net/wireless/intel/iwlwifi/fw/img.h            |   7 +++--
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |   2 ++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |  18 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  58 +++++++++++++=
++++++++++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  20 +++++++++++--=
-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  34 +++++++++++++=
+++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |   4 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |   9 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  11 ++++----
 22 files changed, 373 insertions(+), 50 deletions(-)

--=-XpMiXDPO0F0gSj9k2Gb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAlzHH54ACgkQoUecoho8
xfrtlA//cL3y+pTgDVvP/yAZrjnx8G4tojTY01QR+MjBms3PIF/nCJa4nzOGHY61
5m+SUxfi/cO/PkkoRv6Zr0pcKE0dGlWX8vqTl8iTktZfIn9wZuNOVL4OUpumkbYv
ltF3VHZQ3AiVdhZvGbISeW3zExILrZcUVNaviTcCTli/sQ9p9pmxUWRkKJ6QoDgB
WVFNvUH5irkrIhaNAUYaWSAn0vcf7iB5SE7xkTuuEF6RpNlGaSpSeifxdvhYtb6f
H/JZ6oKwqlto6V5lNrnZ/oi+hIgSleBpzBqBwP3gm09F95IOMNeju3hF+2/i3ZER
pfBtoTklu6kJg6TdwbncylHFqlfvfZ8r2G8IvSvEOgXmBbeIShyGxUelDHl8Wm6X
zTRLYIlF8E72yJb0fiv1RJx9YXoOOfQuwgMAB/sgEY5BM20JeyMRz8VUXdXiem1Z
vf2zYwFxacGa/tWdqf6QGpPn8O0R0iK6LMYYFbsGqn4e1f3dreWR1ClhE5NPcIHb
LGoBqEjBz0qCkBGOsAMC4TOUCe5S55sDBttv26MWwn/+5/IwWH781criaE7iIkLw
27X6zmXf6a0uUORh5SmeW4NjNvp9XAfSla90PbkOrVIEVB5HG024D1BgKG3IKBWr
e91XxWCX65PzdSMLJywLFetLMhWESR9Zjjs6O6fKonac3KhI/Yg=
=yXvG
-----END PGP SIGNATURE-----

--=-XpMiXDPO0F0gSj9k2Gb6--

