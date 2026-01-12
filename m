Return-Path: <linux-wireless+bounces-30709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD3D14D4E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 19:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2A0C30164FB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A63803F3;
	Mon, 12 Jan 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JdqjLJCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF23C506;
	Mon, 12 Jan 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244324; cv=none; b=FAVZXENDpE9CNQigczyeR+3IySJCG29rMwWDSGZYE6aRfgZq5E6igd1gIAWuCx9t+dWa9043Ghw4uCPDNbIt5wuh4VSAuHK20JvM6HFM7mmdEpdtkPS0a3F/9BCAF6bgsFvuI8jr75Gfe8rNhrhJX9eN7S+SKoNijzpCBbbgjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244324; c=relaxed/simple;
	bh=WvhLdWDoWaxItY48GKcoCQnAxImqdEKCfsnIqppCBkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRdQ2yrLvk8l/I1X8Y9XrUTGWH8Q24ID5zbTM740waj3bun2x8ZHWfwStLmh3jreHcBUKSrdPbqRcXUKd+ylidOCO/hibfNBvsx0JbzVdIdbAE6AJHg7v0lH1Nbt0tZ+vn2Qhgy7AlFdayWc0AGleLtg84mA/6qZaZHDAdTm/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JdqjLJCn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fVRTbJz2tYsj4cUrpELs5NF/TSC6y9a175Fp07umCQo=; t=1768244322; x=1769453922; 
	b=JdqjLJCn05b9QGV8C+FWFYlSiRQVEAzwgK8vtwZGx4IPSfW4y2pGtIo4j8c0JIe6K/PwtPws04f
	MgVDoNgDCIxhpmcz4k+tkFjJ5EhxxUk8QBVAfFZRMc73c6bgnoWVITVZsBvTNYU9HLxbH4ap6c0c/
	5XJzbVWTDFjRAvu6EKg5pbShuDgaS3vyjARQlUTdp7di5qQpHleN4CZePs28mdaMKqcQn3RBqNKWn
	fPEzcp7Ez+yPB7JkZ2dKVPvfzzE+pfXU5po+157y/zCys9tL6T+1ZB+BGMug4Vt7DK9ZyYY9Yd3qL
	wK5B/AaWnPbsBGntUOLeeREBBgVBx5l2edhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfN7f-0000000A0vz-3NY9;
	Mon, 12 Jan 2026 19:58:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-01-12
Date: Mon, 12 Jan 2026 19:57:07 +0100
Message-ID: <20260112185836.378736-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

Couple of things first. We have a lot of NAN (WiFi Aware)
stuff pending, but it needs a bit more review (time) and
also a merge from wireless via net via net-next first
(which you already have, but I don't want to pull back
net-next into wireless-next w/o a pull request).

Note that Jeff says there's a conflict to the MHI tree,
I don't even know if that goes through net normally, or
if this will bubble up all the way to Linus in the next
merge window, see also
https://lore.kernel.org/all/20260105154243.7cd5d049@canb.auug.org.au/

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit dbf8fe85a16a33d6b6bd01f2bc606fc017771465:

  Merge tag 'net-6.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-30 08:45:58 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-01-12

for you to fetch changes up to 46e7ced3ef5b56c90ae30634aade96d241a2dfef:

  wifi: mac80211: remove width argument from ieee80211_parse_bitrates (2026-01-12 19:48:41 +0100)

----------------------------------------------------------------
First set of changes for the current -next cycle, of note:
 - ath12k gets an overhaul to support multi-wiphy device
   wiphy and pave the way for future device support in the
   same driver (rather than splitting to ath13k)
 - mac80211 gets some better iteration macros

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: Update csa_finalize to use link_id

Alok Singh (12):
      wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
      wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
      wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
      wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
      wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move MU user processing to Wi-Fi 7 module
      wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
      wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k module

Baochen Qiang (2):
      wifi: ath12k: add the missing RCU lock in ath12k_dp_tx_free_txbuf()
      wifi: ath12k: move firmware stats request outside of atomic context

Chen-Yu Tsai (1):
      wifi: mwifiex: Allocate dev name earlier for interface workqueue name

Harsh Kumar Bijlani (14):
      wifi: ath12k: Move HTT code in dp.h to newly introduced files
      wifi: ath12k: Move HTT Rx specific code to newly introduced files
      wifi: ath12k: Move HTT Tx specific code to newly introduced files
      wifi: ath12k: Move HTT specific code from dp.c to newly introduced files
      wifi: ath12k: Refactor ath12k_vif structure
      wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
      wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
      wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
      wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to ath12k_dp
      wifi: ath12k: Add hash table for ath12k_dp_link_peer
      wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete
      wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
      wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
      wifi: ath12k: Move DP specific link stats to DP link peer

Huang Chenming (1):
      wifi: cfg80211: Fix use_for flag update on BSS refresh

Jeff Johnson (1):
      Merge branch 'ath12k-ng' into ath-next

Johannes Berg (5):
      Merge tag 'ath-next-20260105' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: unexport ieee80211_get_bssid()
      wifi: mac80211: improve interface iteration ergonomics
      wifi: mac80211: improve station iteration ergonomics
      wifi: mac80211_hwsim: remove NAN by default

Kiran Venkatappa (13):
      wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
      wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
      wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
      wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
      wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
      wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
      wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
      wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
      wifi: ath12k: Move hw_init invocation to target-specific probe
      wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
      wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
      wifi: ath12k: Remove HAL defines from shared PCI code
      wifi: ath12k: Remove HAL define dependencies from shared AHB code

Lachlan Hodges (1):
      wifi: cfg80211: include S1G_NO_PRIMARY flag when sending channel

Manish Dharanenthiran (1):
      wifi: cfg80211: add cfg80211_stop_link() for per-link teardown

Miri Korenblit (2):
      wifi: mac80211: don't send an unused argument to ieee80211_check_combinations
      wifi: mac80211: remove width argument from ieee80211_parse_bitrates

Pavankumar Nandeshwar (46):
      wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
      wifi: ath12k: Move hal_tx.h file to wifi7 directory
      wifi: ath12k: Move hal_rx.h file to wifi7 directory
      wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
      wifi: ath12k: Move Rx error related functions to wifi7 directory
      wifi: ath12k: Move hal_desc.h file to wifi7 directory
      wifi: ath12k: Move rx_desc.h file to wifi7 directory
      wifi: ath12k: Move rxdma ring config functions to wifi7 directory
      wifi: ath12k: Move rx error and defrag functions to wifi7 directory
      wifi: ath12k: Move regular msdu processing functions to wifi7 directory
      wifi: ath12k: Move srng processing to wifi7 directory
      wifi: ath12k: Separate arch specific part of RX APIs
      wifi: ath12k: Move arch specific REO functions to wifi7 directory
      wifi: ath12k: Move arch specific rx tid and related functions to wifi7 directory
      wifi: ath12k: Move arch specific tx APIs to wifi7 directory
      wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
      wifi: ath12k: Remove non-compact TLV support from QCN
      wifi: ath12k: Replace ops with direct calls for rxdma ring mask
      wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
      wifi: ath12k: Add new infra for the rx path
      wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
      wifi: ath12k: Move srng config and hal_ops to hw specific hal files
      wifi: ath12k: Initialize desc_size through hal_init
      wifi: ath12k: Initialize hal_ops through hal_init
      wifi: ath12k: Move wbm_rbm_map to hw specific hal files
      wifi: ath12k: Move hal_params and regs to hal from hw
      wifi: ath12k: Add direct HAL pointer in ath12k_dp
      wifi: ath12k: Use hal handle instead of ab handle
      wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7 directory
      wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to wifi7 directory
      wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
      wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7 directory
      wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to wifi7 directory
      wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
      wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7 directory
      wifi: ath12k: Segregate the common and wifi7 specific structures
      wifi: ath12k: Remove the unused ring inits in wcn
      wifi: ath12k: Add callbacks in arch_ops for rx APIs
      wifi: ath12k: Move DP device stats to ath12k_dp
      wifi: ath12k: Add helper to free DP link peer
      wifi: ath12k: Remove the wifi7 header inclusions in common code
      wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
      wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
      wifi: ath12k: Remove arch-specific HAL dependencies from common DP
      wifi: ath12k: Build all the files in wifi7 directory into ath12k_wifi7.ko
      wifi: ath12k: Use dp objects in performance critical paths

Rafał Miłecki (1):
      wifi: brcmfmac: rename function that frees vif

Randy Dunlap (1):
      wifi: brcmfmac: fix/add kernel-doc comments

Ripan Deuri (16):
      wifi: ath12k: Move the hal APIs to hardware specific files
      wifi: ath12k: unify HAL ops naming across chips
      wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
      wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
      wifi: ath12k: Support arch-specific DP device allocation
      wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
      wifi: ath12k: Add framework for hardware specific ieee80211_ops registration
      wifi: ath12k: Add framework for hardware specific DP interrupt handler
      wifi: ath12k: Refactor data path pdev struct
      wifi: ath12k: Rearrange PPDU radio stats
      wifi: ath12k: Rename hal_ops to ops
      wifi: ath12k: Drop hal_ prefix from hardware register names
      wifi: ath12k: Add lockdep warn for RCU
      wifi: ath12k: Move ieee80211_ops callback to the arch specific module
      wifi: ath12k: Replace lock/unlock with guard()
      wifi: ath12k: Skip DP peer creation for scan vdev

Szymon Wilczek (1):
      wifi: libertas: fix WARNING in usb_tx_block

Thorsten Blum (1):
      wl1251: Replace strncpy with strscpy in wl1251_acx_fw_version

Tuo Li (1):
      wifi: iwlegacy: 3945-rs: remove redundant pointer check in il3945_rs_tx_status() and il3945_rs_get_rate()

Uwe Kleine-König (1):
      wifi: wlcore: sdio: Use pm_ptr instead of #ifdef CONFIG_PM

 drivers/net/wireless/ath/ath12k/Makefile           |    8 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |  171 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |   31 +-
 drivers/net/wireless/ath/ath12k/ce.c               |  326 +-
 drivers/net/wireless/ath/ath12k/ce.h               |    7 +-
 drivers/net/wireless/ath/ath12k/cmn_defs.h         |   20 +
 drivers/net/wireless/ath/ath12k/core.c             |   75 +-
 drivers/net/wireless/ath/ath12k/core.h             |  176 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    6 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    8 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |    4 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |   62 +-
 drivers/net/wireless/ath/ath12k/dp.c               |  563 +---
 drivers/net/wireless/ath/ath12k/dp.h               | 1752 ++--------
 drivers/net/wireless/ath/ath12k/dp_cmn.h           |  106 +
 drivers/net/wireless/ath/ath12k/dp_htt.c           | 1353 ++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h           | 1546 +++++++++
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 3517 +-------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h           |   58 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |  690 ++++
 drivers/net/wireless/ath/ath12k/dp_peer.h          |  182 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 3482 ++-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h            |  191 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            | 1638 +--------
 drivers/net/wireless/ath/ath12k/dp_tx.h            |   39 +-
 drivers/net/wireless/ath/ath12k/hal.c              | 2258 ++-----------
 drivers/net/wireless/ath/ath12k/hal.h              | 1475 ++++----
 drivers/net/wireless/ath/ath12k/htc.c              |    3 +-
 drivers/net/wireless/ath/ath12k/hw.c               | 1680 ----------
 drivers/net/wireless/ath/ath12k/hw.h               |   94 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1076 +++---
 drivers/net/wireless/ath/ath12k/mac.h              |  139 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |  132 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  241 +-
 drivers/net/wireless/ath/ath12k/pci.h              |   42 +-
 drivers/net/wireless/ath/ath12k/peer.c             |  453 +--
 drivers/net/wireless/ath/ath12k/peer.h             |  112 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |   19 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |   75 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.h        |   20 +
 drivers/net/wireless/ath/ath12k/wifi7/ce.c         |  973 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/ce.h         |   22 +
 drivers/net/wireless/ath/ath12k/wifi7/core.c       |   68 +
 drivers/net/wireless/ath/ath12k/wifi7/core.h       |   11 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c         |  181 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.h         |   20 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     | 3385 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h     |   23 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      | 2202 ++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   59 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |  978 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  705 ++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  564 ++++
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h |  298 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 1032 ++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |   45 +
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c   |  221 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h   |  422 +--
 .../ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h}  |   55 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c   |   23 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h   |   30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  805 +++++
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |   39 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  945 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/hw.h         |   13 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c        |  138 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.h        |   11 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |  191 ++
 drivers/net/wireless/ath/ath12k/wifi7/pci.h        |   12 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |  105 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.h        |   15 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  138 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    7 +-
 drivers/net/wireless/ath/ath12k/wow.c              |    5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    4 +-
 drivers/net/wireless/intel/iwlegacy/3945-rs.c      |    7 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |    2 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   13 +-
 drivers/net/wireless/ti/wl1251/acx.c               |   11 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |    6 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    2 -
 include/net/cfg80211.h                             |   22 +-
 include/net/mac80211.h                             |   71 +-
 include/uapi/linux/nl80211.h                       |    4 +
 net/mac80211/cfg.c                                 |   21 +-
 net/mac80211/ieee80211_i.h                         |    3 +-
 net/mac80211/mlme.c                                |    2 +-
 net/mac80211/parse.c                               |    3 +-
 net/mac80211/util.c                                |   76 +-
 net/wireless/core.c                                |   24 +-
 net/wireless/core.h                                |    4 +-
 net/wireless/nl80211.c                             |    3 +
 net/wireless/reg.c                                 |    2 +-
 net/wireless/scan.c                                |    2 +-
 net/wireless/sysfs.c                               |    2 +-
 net/wireless/trace.h                               |   13 +-
 net/wireless/util.c                                |    5 +-
 103 files changed, 20420 insertions(+), 17497 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h
 delete mode 100644 drivers/net/wireless/ath/ath12k/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/Makefile
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (91%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (84%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (75%)
 rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (87%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (88%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.h

