Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F041037BC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfKTKlD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:41:03 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58730 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728192AbfKTKlD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:41:03 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNPx-0001oU-5N; Wed, 20 Nov 2019 12:41:01 +0200
Message-ID: <a9bd353c2e5f84e9144d3d843adeb03491053478.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Wed, 20 Nov 2019 12:40:59 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-lO+3PYdGThBI2EaHSsz+"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2019-11-13
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-lO+3PYdGThBI2EaHSsz+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the third batch of patches intended for v5.5.  This includes
the patchset I just sent out .  Usual development work.  More details
about the contents in the tag description.

I pushed these patches to my pending branch, but it was just now, so I
didn't get the results from kbuildbot yet.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit eac08515d7bd665d306cefa2ae9f3de56e875d6d=
:

  rtl8xxxu: Remove set but not used variable 'vif','dev','len' (2019-11-20 =
09:47:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2019-11-20

for you to fetch changes up to 54fae6e31bed393a17512c1c8d2559bc737943c9:

  iwlwifi: bump FW API to 52 for 22000 series (2019-11-20 12:28:56 +0200)

----------------------------------------------------------------
Patches intended for v5.5

* Fix a merge damage that causes issues with high-throuput on AX200+;
* Support TX/RX antennas reporting;
* Small fix in DVM's BT link-quality code;
* Bump supported FW API version to 52;
* Yet another scan FW API update;
* Some clean-ups;

----------------------------------------------------------------
Ben Greear (1):
      iwlwifi: mvm: Report tx/rx antennas

Denis Efremov (1):
      iwlwifi: dvm: excessive if in rs_bt_update_lq()

Johannes Berg (8):
      iwlwifi: pcie: fix support for transmitting SKBs with fraglist
      iwlwifi: pcie: make some RX functions static
      iwlwifi: config: remove max_rx_agg_size
      iwlwifi: mvm: remove left-over non-functional email alias
      iwlwifi: pcie: rx: use rxq queue_size instead of constant
      iwlwifi: pcie: trace IOVA for iwlwifi_dev_tx_tb
      iwlwifi: mvm: remove outdated comment referring to wake lock
      iwlwifi: check kasprintf() return value

Luca Coelho (1):
      iwlwifi: bump FW API to 52 for 22000 series

Tova Mussai (1):
      iwlwifi: scan: support scan req FW API ver 13

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c           |  3 +++
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c            |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       | 56 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h |  8 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/led.c           |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      | 13 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  5 +----
 drivers/net/wireless/intel/iwlwifi/mvm/power.c         |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 54 ++++++++++++++=
+++++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      | 28 ++++++++++++++=
++++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           | 14 ++++++--------
 16 files changed, 161 insertions(+), 41 deletions(-)

--=-lO+3PYdGThBI2EaHSsz+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl3VGDsACgkQoUecoho8
xfon9Q/+NX2mv4FlAH/WtChxQ0dylhPffwxZ1aXC+9K7F/EM+WeWQ9qIJJZPJHfu
3EV+rPQMrFOBMpmxKBK6P0eCNwZqyCNYTT93TYL0fAZfp80fEtql2xY5vWwzSAya
jnTlwkPzhB+ZIC1pdNwjw2g5E/toEUwdLBoUHeEBPOnTAcjo89oojnmKJRvgE63m
O0Y4Y544o0rkrQtkEHFhiBxJ/44Wx6Nm6mVAIQssJL6hYa+vxXHs49Xpb73YqNDp
JQk7SxeCgx6uwXy4w8I8Q5qtHvEOK3EqEbHI6288H+Q7zUXH9NB+I30psRxf2xK0
nSAJbx0SGBADSnuQmxLXcl+c2AGFymeh0d5Jkwqk9iJd3k3fRxV//vHOVO/DOXkG
6yt3GUvg2hzUb/AXBNtMUJ7SQDDrwqhbsAnN/i3klLzJa0L/AN/bNTjS9liSzPWx
DnXGbWJ5i8Uky75fQVAdMHH+1n3rb2I2osE4BVppjU+xYY7W+1xYzpyyblRy3T+8
78HVUunfchKNLRO/ytXoSZU1SZpO9jBdlZlXrT/TaLD0KM0YB7WqThj5oz0gMY56
OjyuQzqOz9VfzVjr5DgmTA5bTrB8KkzD+rcpMyUyD0KK8abGgYRKmD9OMcgoOB3b
+UtEeRVJX1FD6va9B5tfr4LyvVHZbu1wnWv3jPr66eQYdu60G5c=
=Ow2h
-----END PGP SIGNATURE-----

--=-lO+3PYdGThBI2EaHSsz+--

