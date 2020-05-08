Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB61CA4D7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHHLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 03:11:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60192 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbgEHHLI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 03:11:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jWxA1-000WP7-LK; Fri, 08 May 2020 10:11:06 +0300
Message-ID: <8d6ec060c5a7513bc2f9ad617455ec76e48ac6d6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Fri, 08 May 2020 10:11:04 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Fi7hbhcBHYznOCu5GmB5"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-05-08
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Fi7hbhcBHYznOCu5GmB5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the second batch of patches intended for v5.8.  This includes
the last three patchsets I sent out.  Usual development work.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 790709f249728640faa4eff38286a9feb34fed81=
:

  net: relax SO_TXTIME CAP_NET_ADMIN check (2020-05-07 18:17:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-05-08

for you to fetch changes up to d3d2674cc6ff10e89bfbace7b943c09fb9052cca:

  iwlwifi: dbg_ini: differentiate ax210 hw with same hw type (2020-05-08 09=
:53:12 +0300)

----------------------------------------------------------------
Second set of iwlwifi patches intended for v5.8

* Support new FW APIs;
* Remove some old and unused features;
* HW configuration rework continues;
* Some queues rework by Johannes;
* Enable A-AMSDU in low  latency;
* Some debugging fixes;
* Some other small fixes and clean-ups;

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: add support for range request command version 9

Emmanuel Grumbach (4):
      iwlwifi: remove antenna_coupling module parameter
      iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module para=
meters
      iwlwifi: mvm: remove iwlmvm's tfd_q_hang_detect module parameter
      iwlwifi: move iwl_set_soc_latency to iwl-drv to be used by other op_m=
odes

Johannes Berg (10):
      iwlwifi: fw api: fix PHY data 2/3 position
      iwlwifi: pcie: allocate much smaller byte-count table
      iwlwifi: mvm: attempt to allocate smaller queues
      iwlwifi: dbg: mark a variable __maybe_unused
      iwlwifi: pcie: remove some dead code
      iwlwifi: pcie: gen2: use DMA pool for byte-count tables
      iwlwifi: use longer queues for 256-BA
      iwlwifi: mvm: don't transmit on unallocated queue
      iwlwifi: remove outdated copyright print/module statement
      iwlwifi: pcie: skip fragmented receive buffers

Liad Kaufman (1):
      iwlwifi: dbg_ini: differentiate ax210 hw with same hw type

Luca Coelho (8):
      iwlwifi: bump FW API to 55 for AX devices
      iwlwifi: mvm: initialize iwl_dev_tx_power_cmd to zero
      iwlwifi: mvm: add IML/ROM information to the assertion dumps
      iwlwifi: pcie: remove outdated comment about PCI RTPM reference
      iwlwifi: pcie: remove mangling for iwl_ax101_cfg_qu_hr
      iwlwifi: pcie: convert QnJ with Hr to the device table
      iwlwifi: pcie: remove occurrences of 22000 in the FW name defines
      iwlwifi: pcie: convert all AX101 devices to the device tables

Mordechay Goodstein (8):
      iwlwifi: yoyo: add support for parsing SHARED_MEM_ALLOC version 4
      iwlwifi: yoyo: use hweight_long instead of bit manipulating
      iwlwifi: yoyo: don't access TLV before verifying len
      iwlwifi: avoid debug max amsdu config overwriting itself
      iwlwifi: yoyo: add D3 resume timepoint
      iwlwifi: yoyo: remove magic number
      iwlwifi: dump api version in yaml format
      iwlwifi: tx: enable A-MSDU in low latency mode

Shahar S Matityahu (1):
      iwlwifi: dbg: set debug descriptor to NULL outside of iwl_fw_free_dum=
p_desc

Shaul Triebitz (1):
      iwlwifi: mvm: set properly station flags in STA_HE_CTXT_CMD

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         | 104 +++++++++++++=
+++++++++++++++++++++++++++------------------------------------------------
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h           |   3 +--
 drivers/net/wireless/intel/iwlwifi/dvm/main.c          |  11 ++--------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c            |  11 +---------
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h      |  14 ++++++------
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 110 +++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |  14 ++++++------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |  99 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c        | 104 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |  13 +++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/init.c           |  55 +++++++++++++=
++++++++++++++++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   6 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/smem.c           |  14 ++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  15 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |  44 +++++++++++++=
+++++-------------------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |  14 +++---------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h           |   7 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h            |   7 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h     |   8 ++-----
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h          |  11 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c          |   7 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  34 +++++++++++++=
----------------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  11 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  67 +++++++++++++=
+++++++++++++++++++++++++++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  53 ++++---------=
--------------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  56 +++++++++++++=
++++++++++------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   8 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  13 +++--------
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  15 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |  51 +++++++++++++=
++++++++++++++----------------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |  11 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |  29 +++++++++++++=
++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 111 +++++++++++++=
++++++++++++++-------------------------------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |   5 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  32 +++++++++++++=
+++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  19 +++++++++++++=
+++
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      |  33 +++++++++++++=
++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  12 +++++------
 39 files changed, 761 insertions(+), 475 deletions(-)

--=-Fi7hbhcBHYznOCu5GmB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl61BggACgkQoUecoho8
xfpP/RAAiptfhI7lyURLzKbXSfpN9LTkZ7EVLYeETpixXtUPh4njlL1Sqxc7Dq4X
fdQOQB7lAl9bYGfs1s+QYLrk91XNPh1ZNiXcIOwWVQYz9kCxojNNWIKRiNWNCkq+
lbipRN41GvPy/1U+9Ur3IPLJdS29kQYVdEBLGW8mHWj+YRLgKE1AgQNEfW5/fU2e
vHVkxmWVI/7X/9oCDfs+LWZnj2OwXQOuceL15TXzsWB4tO/3ueZPwmV9v+uaQ+Dv
Q/DB7iSCdc14JO2dI7VWgRrNxevVhdOYR30IF12s2CvgQcVB3g1cIUW1xQtu10Ug
Dgg0F0ChX3L+i0CKhmB81lj6U88MKUMjvAmAYTT379zJS1lEXVhpwdq+LsHHzXxW
MdDGHVaT0a+UOCGivztKJE2vJSSOfVOYOspumYrX63dZZdUJCjP1Q0LjgPbZZYsO
VOJ8TftH3DyLabiMgYnlPBgJGAZpw2rRiK2JA5rMfrdDQ1lvY4zGeKSS+ogAV3Aj
pf6UK54mInohdmFgEWSRraJOCYXR+mYEXeOv9lyawhmNwjfA6B36VIDcnmEz3fZ5
Tw9ducTQpUXO2iE96QqR+O+yoQaoxnVnqWO/c2ovj6bYqlh+nmcUG4Lh4oT9wu5+
CtCKbrPE/FVaz+KFgvPC5ClAaCC7XBw+6fzAYIG4wpZigZQU/Jc=
=Xjie
-----END PGP SIGNATURE-----

--=-Fi7hbhcBHYznOCu5GmB5--

