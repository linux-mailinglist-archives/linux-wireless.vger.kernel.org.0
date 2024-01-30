Return-Path: <linux-wireless+bounces-2811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DD842614
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7F91F2466F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D036BB23;
	Tue, 30 Jan 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYfv+YHc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C966B51
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620864; cv=none; b=VcujKohNFpevz3NjNWhHlPN1fhNTComm+ovjbaJVviHXVRVed2qvnAPoF1hG++UDeet1qs1FuaQgb1XgjxPHDfVILDoEbJlYw+dOczx8tpgJGmmgTAd2IqMv8PrjB7QrTHkTXV4xdJZu5uUU2+SqUgupv2E5vLaf9U072Ti7Llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620864; c=relaxed/simple;
	bh=E6opCYNDJ0WPrN3PjCl83P29TptoonpsG80tHmzXzc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYwJK4sj5r4o/rlAT8RTlI561W94Aid/ENqGVf6Z4L/AqwL8IGz6kREePKTX6VmADqi9Z/FKBSwgrR8Sp0oS+gWGWloqg0iI2R7zNLxyxQnYwt9lo/eDb4qAg+yE+EvdHYAycbLoxRjXB7K1qQ99VV2nDm3ku250YSTOhEnWKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYfv+YHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ED0C433F1;
	Tue, 30 Jan 2024 13:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620864;
	bh=E6opCYNDJ0WPrN3PjCl83P29TptoonpsG80tHmzXzc8=;
	h=From:To:Cc:Subject:Date:From;
	b=UYfv+YHczPjxd0MZeKo7/GG4vh3wDbofag3qtTUsOrM1s/V6M6PgyHsUfcMv4YpIM
	 iZntHJDOXOeEZl6OY0ahmZ8PXpJXdBydoXIdGXelBFR2LpOE50i8llaf6TxzapEA8a
	 s67VoSM0ofqIQqsQ+38RE/PKYdk73moz9ZCMu/mbQRSU3abcxPicw42XARzwg01n9g
	 S2cEHTMrFhdrXrtTcyuVrPG+tirVAmp/xiQemM/FzJPgQBPmw2SUc3kjCoAY7gTs4l
	 +juenl/jxaimQA8Y3l5F9wN8F6+u1Cq1rPA8G7hG3rtuDI8iUcojT/nSEfI75xj+xr
	 n0Dxt7ZNaOHFA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-next-20240130
Date: Tue, 30 Jan 2024 15:21:00 +0200
Message-ID: <87bk93vtxf.fsf@kernel.org>
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

Our ath-next pull request for wireless-next.

Kalle

The following changes since commit c5a3f56fcdb0a48a20772e4c9b8adc6c7256a461:

  Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/kvalo/ath (2023-12-17 13:20:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next=
-20240130

for you to fetch changes up to 9d5f28c1366f48efae7b1df0f622285519e74dce:

  wifi: ath11k: fix connection failure due to unexpected peer delete (2024-=
01-25 18:44:02 +0200)

----------------------------------------------------------------
ath.git patches for v6.9

We have new features for both ath11k and ath12k. ath12k is now under
heavy refactoring in preparation for MLO support.

Major changes:

ath12k

* refactoring in preparation for Multi-Link Operation (MLO) support

* 1024 Block Ack window size support

* provide firmware wmi logs via a trace event

ath11k

* 36 bit DMA mask support

* support 6 GHz station power modes: Low Power Indoor (LPI), Standard
  Power) SP and Very Low Power (VLP)

----------------------------------------------------------------
Baochen Qiang (11):
      wifi: ath12k: support default regdb while searching board-2.bin for W=
CN7850
      wifi: ath11k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
      wifi: ath12k: add support for BA1024
      wifi: ath12k: change MAC buffer ring size to 2048
      wifi: ath12k: add support for collecting firmware log
      wifi: ath11k: enable 36 bit mask for stream DMA
      wifi: ath11k: remove invalid peer create logic
      wifi: ath11k: rename ath11k_start_vdev_delay()
      wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_dela=
y()
      wifi: ath11k: fix connection failure due to unexpected peer delete

Dmitry Antipov (3):
      wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()
      wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()

Jeff Johnson (16):
      wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
      wifi: ath10k: use flexible arrays for WMI start scan TLVs
      wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
      wifi: ath10k: remove unused template structs
      wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
      wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update
      wifi: ath12k: Make QMI message rules const
      wifi: ath12k: Remove unnecessary struct qmi_txn initializers
      wifi: ath12k: Add missing qmi_txn_cancel() calls
      wifi: ath12k: Use initializers for QMI message buffers
      wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
      wifi: ath10k: add missing wmi_10_4_feature_mask documentation
      wifi: ath10k: correctly document enum wmi_tlv_tx_pause_id
      wifi: ath10k: fix htt_q_state_conf & htt_q_state kernel-doc
      wifi: ath10k: Fix htt_data_tx_completion kernel-doc warning
      wifi: ath10k: Fix enum ath10k_fw_crash_dump_type kernel-doc

Karthikeyan Periyasamy (21):
      wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc() call
      wifi: ath12k: refactor ath12k_mac_allocate() and ath12k_mac_destroy()
      wifi: ath12k: refactor ath12k_mac_setup_channels_rates()
      wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregiste=
r()
      wifi: ath12k: refactor ath12k_mac_op_config()
      wifi: ath12k: refactor ath12k_bss_assoc()
      wifi: ath12k: refactor ath12k_mac_op_conf_tx()
      wifi: ath12k: refactor ath12k_mac_op_start()
      wifi: ath12k: refactor ath12k_mac_op_stop()
      wifi: ath12k: refactor ath12k_mac_op_update_vif_offload()
      wifi: ath12k: refactor ath12k_mac_op_configure_filter()
      wifi: ath12k: refactor ath12k_mac_op_ampdu_action()
      wifi: ath12k: refactor ath12k_mac_op_flush()
      wifi: ath12k: ath12k_start_vdev_delay(): convert to use ar
      wifi: ath12k: refactor QMI MLO host capability helper function
      wifi: ath12k: add QMI PHY capability learn support
      wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath12k: Refactor the mac80211 hw access from link/radio
      wifi: ath12k: Introduce the container for mac80211 hw

Sriram R (1):
      wifi: ath12k: Fix issues in channel list update

Uwe Kleine-K=C3=B6nig (1):
      wifi: ath9k: Convert to platform remove callback returning void

Wen Gong (15):
      wifi: ath12k: add string type to search board data in board-2.bin for=
 WCN7850
      wifi: ath12k: add fallback board name without variant while searching=
 board-2.bin
      wifi: ath12k: remove unused ATH12K_BD_IE_BOARD_EXT
      wifi: ath12k: add support to search regdb data in board-2.bin for WCN=
7850
      wifi: ath11k: add support to select 6 GHz regulatory type
      wifi: ath11k: store cur_regulatory_info for each radio
      wifi: ath11k: update regulatory rules when interface added
      wifi: ath11k: update regulatory rules when connect to AP on 6 GHz ban=
d for station
      wifi: ath11k: save power spectral density(PSD) of regulatory rule
      wifi: ath11k: add parse of transmit power envelope element
      wifi: ath11k: save max transmit power in vdev start response event fr=
om firmware
      wifi: ath11k: fill parameters for vdev set tpc power WMI command
      wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
      wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPO=
RT for 6 GHz

Wenli Looi (1):
      wifi: ath9k: delete some unused/duplicate macros

Xingyuan Mo (1):
      wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_=
mgmt_tx_compl_ev()

Zhenghao Gu (1):
      wifi: ath11k: fix IOMMU errors on buffer rings

 drivers/net/wireless/ath/ath10k/core.c      |    4 +-
 drivers/net/wireless/ath/ath10k/coredump.h  |    8 +-
 drivers/net/wireless/ath/ath10k/htt.c       |    3 +-
 drivers/net/wireless/ath/ath10k/htt.h       |   12 +-
 drivers/net/wireless/ath/ath10k/mac.c       |    6 +-
 drivers/net/wireless/ath/ath10k/pci.c       |   10 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c   |   11 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h   |    4 +-
 drivers/net/wireless/ath/ath10k/wmi.c       |   22 +-
 drivers/net/wireless/ath/ath10k/wmi.h       |   62 +-
 drivers/net/wireless/ath/ath11k/core.h      |   41 +
 drivers/net/wireless/ath/ath11k/dp.c        |   20 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c     |    6 +-
 drivers/net/wireless/ath/ath11k/hal.c       |   19 +-
 drivers/net/wireless/ath/ath11k/hal.h       |    3 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c    |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c       | 1086 ++++++++++++++++++++---=
----
 drivers/net/wireless/ath/ath11k/mac.h       |    5 +-
 drivers/net/wireless/ath/ath11k/mhi.c       |    4 +-
 drivers/net/wireless/ath/ath11k/pci.c       |   19 +-
 drivers/net/wireless/ath/ath11k/pci.h       |    3 +-
 drivers/net/wireless/ath/ath11k/reg.c       |  267 ++++++-
 drivers/net/wireless/ath/ath11k/reg.h       |   11 +-
 drivers/net/wireless/ath/ath11k/testmode.c  |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c       |  293 ++++----
 drivers/net/wireless/ath/ath11k/wmi.h       |   65 +-
 drivers/net/wireless/ath/ath12k/core.c      |  217 ++++--
 drivers/net/wireless/ath/ath12k/core.h      |   57 +-
 drivers/net/wireless/ath/ath12k/dp.h        |    3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c    |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c     |    8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c     |   10 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h  |   20 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c    |   15 +-
 drivers/net/wireless/ath/ath12k/hw.c        |    9 +
 drivers/net/wireless/ath/ath12k/hw.h        |   23 +-
 drivers/net/wireless/ath/ath12k/mac.c       |  860 ++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h       |    4 +-
 drivers/net/wireless/ath/ath12k/pci.c       |   10 +
 drivers/net/wireless/ath/ath12k/qmi.c       |  377 ++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h       |   34 +-
 drivers/net/wireless/ath/ath12k/reg.c       |   13 +-
 drivers/net/wireless/ath/ath12k/trace.h     |   29 +-
 drivers/net/wireless/ath/ath12k/wmi.c       |   95 +--
 drivers/net/wireless/ath/ath9k/ahb.c        |    6 +-
 drivers/net/wireless/ath/ath9k/antenna.c    |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h |    9 -
 drivers/net/wireless/ath/ath9k/reg_aic.h    |    4 -
 48 files changed, 2739 insertions(+), 1060 deletions(-)

