Return-Path: <linux-wireless+bounces-17562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21FA12934
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885AD3A295F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61970816;
	Wed, 15 Jan 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SotcUx15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECB15B14B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959992; cv=none; b=Mu6fOVT1r6WsQjJO0PGALqdNdgPUtRJ+uxaoUMx6oTXJ2MFeXO6jkRo7Al29eoRmtVvcyzaQl+0VBFzWioY75Kv0v4hU8OswTk0x0Wif3/+hgr1hVe/6/Li9o9elVCWRfvSgaLvsT0Ul5avHqdCF/xRDzxNDrZkwVGH7yPiAnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959992; c=relaxed/simple;
	bh=rsK0TYLVfCwP4ZECsZmPRCQlRRo1EHuSBWdx4ZFPdak=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BGDHHqm3U05oo5qlFiCi32PMd26LJ/GHfyJkHPdxjWMZfOqhJYZ1qE2bfXDdj5MWpo0fQZIb9zOoYUX2qTr5Ak3lu1K3lWaw/hWjjZVR3pXz0pgGgZGetnla5ic6p/CaGobHAR1qj9bFBFHXzfe5D1xvb+T6xoDWKAQU3oBDe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SotcUx15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679DFC4CED1;
	Wed, 15 Jan 2025 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959991;
	bh=rsK0TYLVfCwP4ZECsZmPRCQlRRo1EHuSBWdx4ZFPdak=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SotcUx15Orfo7zB3Ib8U4pRYFhpiRRl/NuSo0qsIdVWIY7wBlbtkhgdfpBxWcCjRi
	 71QIQOS5BnQsq5TuyrNADEMpRlSFkzr1FiRRYauMIVdX+SYtNCo/q1ucMB8t6EDA8c
	 57s1Mp4ADJaPeUf9oAfiwZ65pWO/h0U+XRrkj5YI++HkBn8CqZh2Y6RDktS42gnIl9
	 68CgeTYTXoirtGv2VHUe7+l89bhOU550lJ66VF91v9b6j1Brw99CfEYYq8OfDT8THu
	 I7XGnJ0QTdJqKEy0pcOk8PL18ShvMyTgGQN2Yg6lxNZjYbFg4GSshXnzC4C++FXWXU
	 Hw3xuL+3C7fNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-next-20250114
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b03d2e2c-3f11-427d-a156-eaa0be48078c@oss.qualcomm.com>
References: <b03d2e2c-3f11-427d-a156-eaa0be48078c@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, jjohnson@kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173695998878.529858.9751725465026344775.kvalo@kernel.org>
Date: Wed, 15 Jan 2025 16:53:10 +0000 (UTC)

Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> The following changes since commit b20821248e262a7d16882137419460030c1aead6:
> 
>   Merge tag 'ath-next-20241209' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-12-09 20:41:20 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250114
> 
> for you to fetch changes up to 336097d74c284a7c928b723ce8690f28912da03d:
> 
>   wifi: ath12k: fix key cache handling (2025-01-14 12:53:01 -0800)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.14
> 
> This development cycle again featured multiple patchsets to ath12k to
> support the new 802.11be MLO feature, this time including the device
> grouping infrastructure, and the advertisement of MLO support to the
> wireless core. However the MLO feature is still considered to be
> incomplete.
> 
> In addition, there was the usual set of bug fixes and cleanups, mostly
> in ath12k, but also in ath9k.
> 
> ----------------------------------------------------------------
> Aditya Kumar Singh (14):
>       wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
>       wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
>       wifi: ath12k: fix ar->supports_6ghz usage during hw register
>       wifi: ath12k: pass link ID during MLO while delivering skb
>       wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan
>       wifi: ath12k: add can_activate_links mac operation
>       wifi: ath12k: add no-op without debug print in WMI Rx event
>       wifi: ath12k: remove warning print in htt mlo offset event message
>       wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
>       wifi: ath12k: assign unique hardware link IDs during QMI host cap
>       wifi: ath12k: rename CAC_RUNNING flag
>       wifi: ath12k: fix CAC running state during virtual interface start
>       wifi: ath12k: handle radar detection with MLO
>       wifi: ath12k: fix key cache handling
> 
> Baochen Qiang (1):
>       wifi: ath12k: fix leaking michael_mic for non-primary links
> 
> Bhagavathi Perumal S (1):
>       wifi: ath12k: Add MLO WMI setup and teardown functions
> 
> Colin Ian King (1):
>       wifi: ath12k: Fix spelling mistake "requestted" -> "requested"
> 
> Dan Carpenter (1):
>       wifi: ath12k: Off by one in ath12k_wmi_process_csa_switch_count_event()
> 
> Dmitry Antipov (4):
>       wifi: ath9k: cleanup ath_txq_skb_done()
>       wifi: ath9k: cleanup a few (mostly) TX-related routines
>       wifi: ath9k: simplify internal time management
>       wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
> 
> Jeff Johnson (4):
>       wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
>       wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
>       wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
>       wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
> 
> Karthikeyan Periyasamy (23):
>       wifi: ath12k: send partner device details in QMI MLO capability
>       wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
>       wifi: ath12k: add support to allocate MLO global memory region
>       wifi: ath12k: enable MLO setup and teardown from core
>       wifi: ath12k: avoid redundant code in DP Rx error process
>       wifi: ath12k: move to HW link id based receive handling
>       wifi: ath12k: add partner device buffer support in receive data path
>       wifi: ath12k: add helper function to init partner cmem configuration
>       wifi: ath12k: introduce interface combination cleanup helper
>       wifi: ath12k: Refactor radio frequency information
>       wifi: ath12k: advertise multi device interface combination
>       wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
>       wifi: ath12k: Refactor monitor status TLV structure
>       wifi: ath12k: cleanup Rx peer statistics structure
>       wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
>       wifi: ath12k: fix incorrect TID updation in DP monitor status path
>       wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
>       wifi: ath12k: Change the Tx monitor SRNG ring ID
>       wifi: ath12k: Avoid explicit type cast in monitor status parse handler
>       wifi: ath12k: Refactor ath12k_hw set helper function argument
>       wifi: ath12k: Refactor the ath12k_hw get helper function argument
>       wifi: ath12k: Remove ath12k_get_num_hw() helper function
>       wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function
> 
> P Praneesh (1):
>       wifi: ath12k: Add support for parsing 64-bit TLVs
> 
> Pradeep Kumar Chitrapu (2):
>       wifi: ath12k: Support Transmit Rate Buffer Stats
>       wifi: ath12k: Support Transmit Buffer OFDMA Stats
> 
> Raj Kumar Bhagat (3):
>       dt-bindings: net: wireless: Describe ath12k PCI module with WSI
>       wifi: ath12k: parse multiple device information from Device Tree
>       wifi: ath12k: Include MLO memory in firmware coredump collection
> 
> Rajat Soni (1):
>       wifi: ath12k: Support pdev Puncture Stats
> 
> Rameshkumar Sundaram (1):
>       wifi: ath12k: advertise MLO support and capabilities
> 
> Ramya Gnanasekar (1):
>       wifi: ath12k: set flag for mgmt no-ack frames in Tx completion
> 
> Roopni Devanathan (1):
>       wifi: ath12k: Support AST Entry Stats
> 
> Sathishkumar Muruganandam (1):
>       wifi: ath12k: fix tx power, max reg power update to firmware
> 
>  .../bindings/net/wireless/qcom,ath12k-wsi.yaml     | 204 ++++++
>  drivers/net/wireless/ath/ath12k/core.c             | 315 +++++++-
>  drivers/net/wireless/ath/ath12k/core.h             |  63 +-
>  drivers/net/wireless/ath/ath12k/coredump.c         |   3 +
>  drivers/net/wireless/ath/ath12k/coredump.h         |   1 +
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 502 +++++++++++++
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 155 ++++
>  drivers/net/wireless/ath/ath12k/dp.c               |  14 +
>  drivers/net/wireless/ath/ath12k/dp.h               |  30 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c           | 156 ++--
>  drivers/net/wireless/ath/ath12k/dp_rx.c            | 231 ++++--
>  drivers/net/wireless/ath/ath12k/fw.h               |   3 +
>  drivers/net/wireless/ath/ath12k/hal.c              |   2 +-
>  drivers/net/wireless/ath/ath12k/hal.h              |   2 +-
>  drivers/net/wireless/ath/ath12k/hal_desc.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/hal_rx.h           |  14 +-
>  drivers/net/wireless/ath/ath12k/mac.c              | 794 ++++++++++++++++-----
>  drivers/net/wireless/ath/ath12k/mac.h              |  11 +
>  drivers/net/wireless/ath/ath12k/peer.c             |   2 +
>  drivers/net/wireless/ath/ath12k/peer.h             |   3 +
>  drivers/net/wireless/ath/ath12k/qmi.c              | 324 +++++++--
>  drivers/net/wireless/ath/ath12k/qmi.h              |   1 +
>  drivers/net/wireless/ath/ath12k/wmi.c              | 225 +++++-
>  drivers/net/wireless/ath/ath12k/wmi.h              |  56 ++
>  drivers/net/wireless/ath/ath9k/ath9k.h             |   8 +-
>  drivers/net/wireless/ath/ath9k/beacon.c            |   2 +-
>  drivers/net/wireless/ath/ath9k/calib.c             |  24 +-
>  drivers/net/wireless/ath/ath9k/channel.c           |  29 +-
>  drivers/net/wireless/ath/ath9k/hw.c                |  25 +-
>  drivers/net/wireless/ath/ath9k/hw.h                |   2 +-
>  drivers/net/wireless/ath/ath9k/main.c              |   9 +-
>  drivers/net/wireless/ath/ath9k/recv.c              |   4 +-
>  drivers/net/wireless/ath/ath9k/xmit.c              |  52 +-
>  33 files changed, 2723 insertions(+), 547 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml

Pulled, thanks.

89d62bcd2501 Merge tag 'ath-next-20250114' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b03d2e2c-3f11-427d-a156-eaa0be48078c@oss.qualcomm.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


