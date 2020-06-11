Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D101F644A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFKJIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 05:08:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36732 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726697AbgFKJIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 05:08:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jjJCc-0015ri-71; Thu, 11 Jun 2020 12:08:51 +0300
Message-ID: <b09ebb1abe0c884d31884fc16e52ed47e8a3796f.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Thu, 11 Jun 2020 12:08:48 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-kjFt2wCzAM7JxmNd+3ac"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-06-11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-kjFt2wCzAM7JxmNd+3ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.9.  This contains
only patches that were sent by the community.  I have decided to apply
community patches directly to iwlwifi-next without going through our
internal tree first, so the turnaround is shorter.  I apply them in
parallel to our internal tree so we get the benefits of our CI
infrastructure as well.  Kbuildbot has also reported success.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 1806c13dc2532090d742ce03847b22367fb20ad6=
:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-05-3=
1 17:48:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-06-11

for you to fetch changes up to e00c6d8d491b3b8b93eeac1aae51c78a5217cde6:

  net: wireless: intel: fix wiki website url (2020-06-10 15:25:42 +0300)

----------------------------------------------------------------
First set of patches intended for v5.9

* Fix links to wiki;
* Some preparations for gcc-10;
* Make FW reconfiguration quieter by not using warn level;
* Some other small fixes and clean-up;

----------------------------------------------------------------
Alexander Wetzel (1):
      iwlwifi: Extended Key ID support for mvm and dvm

Arnd Bergmann (1):
      iwlwifi: mvm: fix gcc-10 zero-length-bounds warning

Ben Greear (1):
      iwlwifi: mvm: Fix avg-power report

Chris Down (1):
      iwlwifi: Don't IWL_WARN on FW reconfiguration

Colin Ian King (1):
      iwlwifi: mvm: remove redundant assignment to variable ret

Flavio Suligoi (1):
      net: wireless: intel: fix wiki website url

Gustavo A. R. Silva (1):
      iwlwifi: Replace zero-length array with flexible-array

Luca Ceresoli (1):
      iwlwifi: fix config variable name in comment

YueHaibing (1):
      iwlwifi: mvm: Remove unused inline function iwl_mvm_tid_to_ac_queue

 drivers/net/wireless/intel/iwlegacy/4965-mac.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig          |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h   | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c   |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h      | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h     |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c        |  8 --------
 14 files changed, 33 insertions(+), 32 deletions(-)

--=-kjFt2wCzAM7JxmNd+3ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl7h9KAACgkQoUecoho8
xfrdyA//WAAPtM1RFoeoaI9BM/hDcU2k/mjpbiHTGceFJyB6xjgkPiaBR6+D9vls
TRiYA9+wbbD7DyXQo69AJPYKV6Beq9sjPA92mmR1rWPW5QKugYHHf2rKfnsWPuCY
6l2nQ65lYHOdivdIkZpGGSP9LoQuVj/uPSuBpSwEcFINzlsxKmk3Se7bepEt1LBX
iaa9B9KZNtDxSR9NT7KaY5M8S0Y8lZvDBOWBMtee+0aePoXCNMAw+hDgmpYRPnu2
nbGXr7JdBwws2iERHLDdJAmlmlDz61SyCfoHaVTLLlrKnzEvdeVyzHtanw9pVk0v
baitfTOHdKLFlkhKwAQ3bt31m1OT5eLqnTDhX+pV3jfLQaaROr/ibLdAdhAaE3sM
LTkOslucTUBJfCqCiNUtogJtdxb3bTNMnZPKWnrIGrRZWynts2JjX+tMUSfHL0mj
ueni6bsX67VUdcnbpUXeGs4Kn0snyAIJDzD3+rTYGjuFlBZA07CgmsXyNa+Fw2RG
iMoyZW7jwRhHZ1Mxx3pPaqTkxECs1StL3CW9KB1X657vhq1MegTSlNvoftYW08Rv
IOF7NqPAEMG9ymMs9lyvwx8r6I8qcEoAoUx/XBMOYn3VCkXhHY2luCFSN/srGTDo
5n/CGLACPqA9e6UTL8BIPescPeyOraIJLiV0BbidJzoXRTTYHUU=
=SSuf
-----END PGP SIGNATURE-----

--=-kjFt2wCzAM7JxmNd+3ac--

