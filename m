Return-Path: <linux-wireless+bounces-24043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78EAD6A9A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF04168215
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CFA1B0F0A;
	Thu, 12 Jun 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uXHNAyk7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAC189BB0;
	Thu, 12 Jun 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716741; cv=none; b=JKGGcigwCWEoSgTXUpwBUSRUROnbyReGl1m0e+fVYoGTf04RXg9/XYklKozgM3QphjmJlyHg+9/7uLbe0jiZScnSJx61tVcRq7GTAVEXu81ZqndDFKO+sEtIXyp+mDK5aK2KrSuTQzt+RKcUn9lUXQwF9wAUSLoR1Rl8tirW4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716741; c=relaxed/simple;
	bh=NtyFz2v91XHDD4JVNQ/RmS8itnTzoEojen+Xb/p17wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzrMuF7XvnWVCd21oBb9HbgzlNWFCCE1Z7jTNPyzuFRbm1VNpa1a3ZU+avBBrOtB0aKjatYMqkq8ZICKiNBpYmbTN8efEQwMnZChI1R3VlH0fo4nS75xDv1OAck6ADxP/8zrzEa3nEmPTJ4RCuleibBGLgi8t4pYBq25hn5QRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uXHNAyk7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hU9TAPDtr6fHxQR1sgOHiFV13ms0iwUk0e/U/3LA88A=; t=1749716739; x=1750926339; 
	b=uXHNAyk73/r4t4UgeUaz5ouT2reCiuXP6+3UVYFqc9TLWbvdsMZCrhl5Tj0V67NXjhXGlbeiWYg
	9SijQnZ+z7Dqur+lKmdYxkkrYOUXXKkg4mh6378Q9+iArfd683TWEn830KaZRvM22Qpca5t/+UKbf
	WoKGXbmxmVBwBk3DlTK4tmMu0irWzgz6Aql/3FvGxhFPmyxxIoJKXl6/kPNMuet3X+OXr9vxe9tHr
	7+IhXo2K589ekYndkRDc56Pv+17KLjX5WcWKUbfZPQFMqgAPuKlEAj6QdSlg6SHy6tKMCnOukqNXm
	TiTmajuVGrEXxSh0VT31L3rSoZuLdYs2TExg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uPdFX-00000003om0-27fp;
	Thu, 12 Jun 2025 10:25:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-06-12
Date: Thu, 12 Jun 2025 10:24:19 +0200
Message-ID: <20250612082519.11447-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just a quick couple of fixes as described below. Part of
the reason to send them now is that Jeff wants to have
them in -next to avoid conflicts later.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 2c7e4a2663a1ab5a740c59c31991579b6b865a26:

  Merge tag 'net-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-05 12:34:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-06-12

for you to fetch changes up to f87586598fffac31afc1141471b789251b030a76:

  wifi: cfg80211: use kfree_sensitive() for connkeys cleanup (2025-06-11 11:36:56 +0200)

----------------------------------------------------------------
Another quick round of updates:
 - revert mwifiex HT40 that was causing issues
 - many ath10k/ath11k/ath12k fixes
 - re-add some iwlwifi code I lost in a merge
 - use kfree_sensitive() on an error path in cfg80211

----------------------------------------------------------------
Baochen Qiang (8):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started
      wifi: ath11k: move some firmware stats related functions outside of debugfs
      wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
      wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
      wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
      wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Casey Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix merge damage related to iwl_pci_resume

Francesco Dolcini (1):
      Revert "wifi: mwifiex: Fix HT40 bandwidth issue."

Jeff Johnson (1):
      wifi: ath12k: Fix hal_reo_cmd_status kernel-doc

Johannes Berg (1):
      Merge tag 'ath-current-20250608' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Loic Poulain (1):
      wifi: ath10k: Avoid vdev delete timeout when firmware is already down

Miaoqing Pan (1):
      wifi: ath12k: fix uaf in ath12k_core_init()

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Sebastian Gottschall (1):
      wil6210: fix support for sparrow chipsets

Zilin Guan (1):
      wifi: cfg80211: use kfree_sensitive() for connkeys cleanup

 drivers/net/wireless/ath/ath10k/mac.c         |  33 ++++--
 drivers/net/wireless/ath/ath10k/snoc.c        |   4 +-
 drivers/net/wireless/ath/ath11k/core.c        |  29 ++---
 drivers/net/wireless/ath/ath11k/core.h        |   4 +-
 drivers/net/wireless/ath/ath11k/debugfs.c     | 148 +++-----------------------
 drivers/net/wireless/ath/ath11k/debugfs.h     |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c         | 127 ++++++++++++++--------
 drivers/net/wireless/ath/ath11k/mac.h         |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  49 +++++++--
 drivers/net/wireless/ath/ath12k/core.c        |  10 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c          |   6 ++
 drivers/net/wireless/ath/ath12k/hw.h          |   2 +
 drivers/net/wireless/ath/ath12k/pci.c         |   6 +-
 drivers/net/wireless/ath/ath12k/pci.h         |   4 +-
 drivers/net/wireless/ath/wil6210/interrupt.c  |  26 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  24 ++++-
 drivers/net/wireless/marvell/mwifiex/11n.c    |   6 +-
 net/wireless/nl80211.c                        |   2 +-
 19 files changed, 251 insertions(+), 246 deletions(-)

