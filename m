Return-Path: <linux-wireless+bounces-845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AA815003
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B5C288F01
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F241846;
	Fri, 15 Dec 2023 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6Mzceyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FF41843
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 19:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE8C433C7;
	Fri, 15 Dec 2023 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702667481;
	bh=wsjXB01c4a+5o/EBeuXIe3bYs8YyMbsldam4999cL0c=;
	h=From:To:Cc:Subject:Date:From;
	b=q6MzceybvRMjEmzqZLR/iiFfAKmDfabiP+WFJWL+Q4jimIZAR0hWU1AYMqDNB5yOp
	 zGI8ySzxe+BBcMaDfeV2o6l1HR2S24MUdll090JBmkuV9MtxWigfFLEN4N626eOSZP
	 85lIcuvLXC1a+r33me9ds1IRfYeWk7E2e/UerPj2Fp3cPLUkg4ggN7oBaDY0mtQFAv
	 1I6TseE0Jz96vOJkuSucJW2QAEmdCh/bPYJ+9WfkkosC1nH+4le9A3TwJnVVSews0a
	 r97MPyJtgNl+hfVxJRb0X55kNaA2PepJiv3a3IBrzLvDntVe3cDBOhk8VEnPtfwizX
	 YiEaw9hjvYeHw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-next-20231215
Date: Fri, 15 Dec 2023 21:11:18 +0200
Message-ID: <87r0jnl1rd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Now that Jeff is also the ath maintainer we decided to start doing
proper pull requests. Earlier I was just merging ath-next directly to
wireless-next. So here's our first pull request, let's see if we got it
right :)

Kalle

The following changes since commit 1002f8171d966f73e3d97b05fc0178e115fb5dca:

  wifi: ray_cs: Remove unnecessary (void*) conversions (2023-10-25 20:44:40=
 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next=
-20231215

for you to fetch changes up to fd6ed1772b2c639370b7b41602d4c925dbd003d4:

  wifi: ath11k: workaround too long expansion sparse warnings (2023-12-15 1=
7:58:51 +0200)

----------------------------------------------------------------
ath.git patches for v6.8.

We have new features only for ath12k but lots of small cleanup for
ath10k, ath11k and ath12k. And of course smaller fixes to several
drivers.

Major changes:

ath12k

* support one MSI vector

* WCN7850: support AP mode

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too=
 early

Dmitry Antipov (1):
      wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()

Hancheng Yang (1):
      wifi: ath9k: reset survey of current channel after a scan started

James Prestwood (3):
      wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath12k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath10k: add support to allow broadcast action frame RX

Jeff Johnson (14):
      wifi: ath10k: Remove unused struct ath10k_htc_frame
      wifi: ath11k: Remove struct ath11k::ops
      wifi: ath12k: Remove struct ath12k::ops
      wifi: ath11k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath12k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath11k: Consolidate WMI peer flags
      wifi: ath12k: Consolidate WMI peer flags
      wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: remove ath10k_htc_record::pauload[]
      wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
      wifi: ath11k: remove ath11k_htc_record::pauload[]
      wifi: ath11k: Fix ath11k_htc_record flexible record

Jiri Slaby (SUSE) (1):
      wifi: ath5k: remove unused ath5k_eeprom_info::ee_antenna

Justin Stitt (1):
      wifi: ath10k: replace deprecated strncpy with memcpy

Kalle Valo (1):
      wifi: ath11k: workaround too long expansion sparse warnings

Kang Yang (8):
      wifi: ath12k: get msi_data again after request_irq is called
      wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
      wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
      wifi: ath12k: refactor multiple MSI vector implementation
      wifi: ath12k: add support one MSI vector
      wifi: ath12k: do not restore ASPM in case of single MSI vector
      wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector
      wifi: ath12k: fix and enable AP mode for WCN7850

Karthikeyan Periyasamy (9):
      wifi: ath12k: fix the error handler of rfkill config
      wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
      wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
      wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
      wifi: ath12k: refactor DP Rxdma ring structure
      wifi: ath12k: Optimize the mac80211 hw data access
      wifi: ath12k: avoid repeated hw access from ar
      wifi: ath12k: avoid repeated wiphy access from hw
      Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ"

Lingbo Kong (1):
      wifi: ath12k: fix the issue that the multicast/broadcast indicator is=
 not read correctly for WCN7850

Luca Weiss (1):
      wifi: ath11k: Defer on rproc_get failure

Ma Ke (1):
      wifi: ath12k: drop NULL pointer check in ath12k_update_per_peer_tx_st=
ats()

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_ht=
c_txstatus()

Muna Sinada (1):
      wifi: ath12k: add 320 MHz bandwidth enums

Uwe Kleine-K=C3=B6nig (3):
      wifi: ath11k: Convert to platform remove callback returning void
      wifi: ath5k: Convert to platform remove callback returning void
      wifi: wcn36xx: Convert to platform remove callback returning void

Wu Yunchuan (1):
      wifi: ath9k: Remove unnecessary (void*) conversions

Yang Li (1):
      wifi: ath11k: Remove unneeded semicolon

 drivers/net/wireless/ath/ath10k/bmi.c              |   1 +
 drivers/net/wireless/ath/ath10k/ce.c               |   1 +
 drivers/net/wireless/ath/ath10k/core.c             |  17 ++
 drivers/net/wireless/ath/ath10k/core.h             |   3 +-
 drivers/net/wireless/ath/ath10k/coredump.c         |   1 +
 drivers/net/wireless/ath/ath10k/coredump.h         |   1 +
 drivers/net/wireless/ath/ath10k/debug.c            |   1 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |   1 +
 drivers/net/wireless/ath/ath10k/htc.c              |   1 +
 drivers/net/wireless/ath/ath10k/htc.h              |  20 +--
 drivers/net/wireless/ath/ath10k/htt.h              |   1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   4 +-
 drivers/net/wireless/ath/ath10k/hw.c               |   1 +
 drivers/net/wireless/ath/ath10k/hw.h               |   4 +
 drivers/net/wireless/ath/ath10k/mac.c              |  17 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   1 +
 drivers/net/wireless/ath/ath10k/pci.h              |   1 +
 drivers/net/wireless/ath/ath10k/qmi.c              |   1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |   1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |   1 +
 drivers/net/wireless/ath/ath10k/rx_desc.h          |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |   1 +
 drivers/net/wireless/ath/ath10k/thermal.c          |   1 +
 drivers/net/wireless/ath/ath10k/usb.h              |   1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |   1 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   1 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   1 +
 drivers/net/wireless/ath/ath10k/wow.c              |   1 +
 drivers/net/wireless/ath/ath11k/Kconfig            |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  10 +-
 drivers/net/wireless/ath/ath11k/ce.c               |   2 +-
 drivers/net/wireless/ath/ath11k/ce.h               |   1 +
 drivers/net/wireless/ath/ath11k/core.h             |   1 -
 drivers/net/wireless/ath/ath11k/dbring.c           |   1 +
 drivers/net/wireless/ath/ath11k/dbring.h           |   1 +
 drivers/net/wireless/ath/ath11k/debug.c            |   1 +
 drivers/net/wireless/ath/ath11k/debug.h            |   2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |   1 +
 drivers/net/wireless/ath/ath11k/debugfs.h          |   1 +
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |   2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   1 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |   1 +
 drivers/net/wireless/ath/ath11k/dp.c               |   2 +-
 drivers/net/wireless/ath/ath11k/dp.h               |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h            |   1 +
 drivers/net/wireless/ath/ath11k/fw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h              |   2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c           |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h           |   1 +
 drivers/net/wireless/ath/ath11k/hif.h              |   1 +
 drivers/net/wireless/ath/ath11k/htc.c              |   1 +
 drivers/net/wireless/ath/ath11k/htc.h              |   6 +-
 drivers/net/wireless/ath/ath11k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  16 +-
 drivers/net/wireless/ath/ath11k/mac.h              |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |   1 +
 drivers/net/wireless/ath/ath11k/pcic.c             |   6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |   2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   2 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   1 +
 drivers/net/wireless/ath/ath11k/reg.h              |   1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h          |   1 +
 drivers/net/wireless/ath/ath11k/spectral.c         |   1 +
 drivers/net/wireless/ath/ath11k/spectral.h         |   1 +
 drivers/net/wireless/ath/ath11k/thermal.c          |   1 +
 drivers/net/wireless/ath/ath11k/thermal.h          |   1 +
 drivers/net/wireless/ath/ath11k/trace.h            |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |  63 +++----
 drivers/net/wireless/ath/ath11k/wow.h              |   1 +
 drivers/net/wireless/ath/ath12k/Kconfig            |   2 +-
 drivers/net/wireless/ath/ath12k/core.c             |   6 +-
 drivers/net/wireless/ath/ath12k/core.h             |   5 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |   2 +-
 drivers/net/wireless/ath/ath12k/debug.c            |   2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   6 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  13 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  15 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 153 +++++++----------
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   6 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   3 +-
 drivers/net/wireless/ath/ath12k/hif.h              |   2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   5 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 190 +++++++++++------=
----
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |  18 +-
 drivers/net/wireless/ath/ath12k/pci.c              | 174 ++++++++++++++++-=
--
 drivers/net/wireless/ath/ath12k/pci.h              |   4 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   2 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  21 +--
 drivers/net/wireless/ath/ath12k/reg.h              |   4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  64 +++----
 drivers/net/wireless/ath/ath5k/ahb.c               |   8 +-
 drivers/net/wireless/ath/ath5k/eeprom.h            |   3 -
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   2 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |   2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |   2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |  36 ++--
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   2 +-
 drivers/net/wireless/ath/ath9k/init.c              |  12 +-
 drivers/net/wireless/ath/ath9k/link.c              |   2 +-
 drivers/net/wireless/ath/ath9k/main.c              |  15 ++
 drivers/net/wireless/ath/ath9k/pci.c               |   6 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |   6 +-
 128 files changed, 631 insertions(+), 466 deletions(-)

