Return-Path: <linux-wireless+bounces-28628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01694C36701
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D0A501E11
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3030DD19;
	Wed,  5 Nov 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hsz+J6jU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6992641FB;
	Wed,  5 Nov 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356944; cv=none; b=GFZMNVpH91FUR6FdIMZjpZgypkQ4Z7p7Fzxh/L0lH3Lg9XSjo7tej999eaQT+lyyknS4mgeu+sxc02OEMPEpoyVgcTBYCrEWKCrS/sTQCLIUV6zV1PxPDQqMamcNI+j0yX3o+LIAHx7AEWCuZi8TW8Lnk4X9RT65ekLltKJrALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356944; c=relaxed/simple;
	bh=PY/omXWxnOyxVorqQ9R+pkl09QE3Q7EjLqoiP7N+eog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGUBb1g69xdrHrHOjQCkMTp7UmNX/19H8/6jeP9JZlf0XiEPaN7MoKD7tV7Q5nvAmmr+4hmMw+qHFi+2Wdh6M9UUR+vFJ2cEofa5KkcoVKyyA4nbCGlV6g0Ss2DhAIOJd9hINjqFd/yBfqASk4xQO8dNLuhcZbQc49d1LXwPvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hsz+J6jU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FzmyRr2t51cLHRpA2F/afH1pib978Jz/dAaIti/iSGY=; t=1762356943; x=1763566543; 
	b=hsz+J6jUIOVxpJ9KFoyllu8akm6f3hbnMVGX+Z3llAk5JnzEO0JKtZdOm59EKsWTCN+4WNN/+88
	1ry9QijonMM8MLnVc/VA5Q6xEGqulkw289cQd/koxnlt6VF9Kpq7oQMx41aSGhAFZy25FpSK7EPlD
	cMcKLEziF4WfduGf8/WmHKkHPKy+vvzCVlFbmN4aUVehMFhCzPAqnGPVJ47xMVHKsoMneHU7QfBJ2
	gEslNEIh9idEKAHIpFNs/9byrXCASow35tTJCXj+h7DlVBTTGLXXavOE7QlVaUmRQHSye4s0mpzEN
	t4xDyvV6PaoF3misR7X+Psw3oepaDNc3+FJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGfXw-0000000FJrD-2jDR;
	Wed, 05 Nov 2025 16:35:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-11-05
Date: Wed,  5 Nov 2025 16:34:33 +0100
Message-ID: <20251105153537.54096-38-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So more driver updates are trickling in now, with Intel
and Atheros this time. I have a whole new NXP driver that
isn't in here yet, but is quite likely good enough for
next week. We'll see. :)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 1a2352ad82b515035efe563f997ef8f5ca4f8080:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-31 06:46:03 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-11-05

for you to fetch changes up to 2f6adeaf92c4ea4adf5a91b87497ba13bb057996:

  Merge tag 'ath-next-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next (2025-11-05 16:29:11 +0100)

----------------------------------------------------------------
More changes from drivers are coming in, notably:
 - ath10k: factory test support
 - ath11k: TX power insertion support
 - ath12k: BSS color change support
 - iwlwifi: new sniffer API support

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()

Aditya Kumar Singh (5):
      wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon
      wifi: ath11k: relocate some Tx power related functions in mac.c
      wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      wifi: ath11k: add support for Tx Power insertion in RRM action frame
      wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION

Baochen Qiang (7):
      wifi: ath11k: restore register window after global reset
      wifi: ath12k: fix VHT MCS assignment
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment
      wifi: ath12k: restore register window after global reset
      wifi: ath12k: fix reusing m3 memory
      wifi: ath12k: fix error handling in creating hardware group

Dr. David Alan Gilbert (1):
      wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params

Emmanuel Grumbach (5):
      wifi: iwlwifi: mld: support get/set_antenna
      wifi: iwlwifi: be more chatty when we fail to find a wifi7 device
      wifi: iwlwifi: stop checking the firmware's error pointer
      wifi: iwlwifi: disable EHT if the device doesn't allow it
      wifi: iwlwifi: mld: check for NULL pointer after kmalloc

Jeff Johnson (3):
      wifi: ath11k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath12k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath11k: Correctly use "ab" macro parameter

Johannes Berg (14):
      wifi: iwlwifi: mvm: move rate conversions to utils.c
      wifi: iwlwifi: cfg: add new device names
      wifi: iwlwifi: tests: check listed PCI IDs have configs
      wifi: iwlwifi: fix remaining kernel-doc warnings
      wifi: iwlwifi: mld: update to new sniffer API
      wifi: iwlwifi: mld: include raw PHY notification in radiotap
      wifi: iwlwifi: fix build when mvm/mld not configured
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: mvm/mld: report non-HT frames as 20 MHz
      wifi: iwlwifi: mld: use FW_CHECK on bad ROC notification
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: cfg: fix a few device names
      Merge tag 'iwlwifi-next-2025-10-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-next-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next

Kang Yang (1):
      wifi: ath10k: move recovery check logic into a new work

Li Qiang (1):
      wifi: iwlwifi: mld: add null check for kzalloc() in iwl_mld_send_proto_offload()

Loic Poulain (1):
      wifi: ath10k: Support for FTM TLV test commands

Miri Korenblit (7):
      wifi: iwlwifi: align the name of iwl_alive_ntf_v6 to the convention
      wifi: iwlwifi: mld: remove support from of alive notif version 6
      wifi: iwlwifi: mld: reschedule check_tpt_wk also not in EMLSR
      wifi: iwlwifi: iwlmld is always used for wifi7 devices
      wifi: iwlwifi: mvm: cleanup unsupported phy command versions
      wifi: iwlwifi: mld: set wiphy::iftype_ext_capab dynamically
      wifi: iwlwifi: mld: check the validity of noa_len

Muna Sinada (6):
      wifi: ath12k: generalize GI and LTF fixed rate functions
      wifi: ath12k: add EHT rate handling to existing set rate functions
      wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
      wifi: ath12k: Add EHT fixed GI/LTF
      wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
      wifi: ath12k: Set EHT fixed rates for associated STAs

Nidhish A N (2):
      wifi: iwlwifi: fw: remove support of several iwl_lari_config_change_cmd versions
      wifi: iwlwifi: mld: Move EMLSR prints to IWL_DL_EHT

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

Rameshkumar Sundaram (2):
      wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
      wifi: ath12k: unassign arvif on scan vdev create failure

Sarika Sharma (3):
      wifi: ath12k: Fix MSDU buffer types handling in RX error path
      wifi: ath12k: track dropped MSDU buffer type packets in REO exception ring
      wifi: ath12k: Assert base_lock is held before allocating REO update element

Takashi Iwai (1):
      wifi: ath12k: Add MODULE_FIRMWARE() entries

Thiraviyam Mariyappan (1):
      wifi: ath12k: Fix NSS value update in ext_rx_stats

Wei Zhang (1):
      wifi: ath12k: add support for BSS color change

Zhongqiu Han (2):
      wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
      wifi: ath10k: use = {} to initialize bmi_target_info instead of memset

 drivers/net/wireless/ath/ath10k/core.c             |   28 +-
 drivers/net/wireless/ath/ath10k/core.h             |    6 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |  275 +++-
 drivers/net/wireless/ath/ath10k/testmode_i.h       |   15 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   19 +-
 drivers/net/wireless/ath/ath11k/hal.h              |   38 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  455 ++++--
 drivers/net/wireless/ath/ath11k/pci.c              |   20 +-
 drivers/net/wireless/ath/ath11k/pci.h              |   18 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   20 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   18 +-
 drivers/net/wireless/ath/ath12k/core.c             |   22 +-
 drivers/net/wireless/ath/ath12k/core.h             |    3 +
 drivers/net/wireless/ath/ath12k/debugfs.c          |    5 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   19 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   74 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   10 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  751 +++++++--
 drivers/net/wireless/ath/ath12k/mac.h              |   14 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   24 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   11 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   86 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   55 +-
 drivers/net/wireless/ath/ath12k/wow.c              |    1 +
 drivers/net/wireless/ath/wcn36xx/hal.h             |   74 -
 drivers/net/wireless/ath/wcn36xx/smd.c             |   60 -
 drivers/net/wireless/ath/wcn36xx/smd.h             |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |   24 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    5 +
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  134 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |  286 ++++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   78 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   39 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   26 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   29 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    4 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   13 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  103 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  100 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        | 1709 +++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   15 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  164 --
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  164 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   10 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |    9 +
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   29 +
 94 files changed, 3437 insertions(+), 1975 deletions(-)

