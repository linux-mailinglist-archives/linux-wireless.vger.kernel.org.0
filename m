Return-Path: <linux-wireless+bounces-8420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4B8D8195
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34471C21CEF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC98614B;
	Mon,  3 Jun 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYz1T7Jc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC985C46;
	Mon,  3 Jun 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415490; cv=none; b=u17PGI/F2ziM3TqyEUEolGL4Krs9+moNrjllvYNXL0pCXlC0hjTihR13HDiJ0Ydy1UP5E8Ifym02CWv+CL70rOfwZBH1xhw7PpLPoWe8//QeoAbJeE4Mm2qWOFVXjszElBQMqvkFgWneDpF6DUmzLOufh8nCrVlNfr8/Yv7rwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415490; c=relaxed/simple;
	bh=dnFAluB4y6Ozxk3Y50bYaxjCBEZXX1yDcIMuCXTldcc=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=WrJcuVJys9fle1dHPq44tp1BSS0WT0S9jPqlLHxQ74EcPtFqFXoUvAEyDDG7zIsWQ/zrCWijV/x2r6qu/7CU7pDTH+gVbanApcTyEKKRJjIOHavFhj+tQblA7iGK7/VZuHmKYok94ou1lm2QofpU28Y9nKTeVtlOJ+qMS7Fbx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYz1T7Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9494CC2BD10;
	Mon,  3 Jun 2024 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717415490;
	bh=dnFAluB4y6Ozxk3Y50bYaxjCBEZXX1yDcIMuCXTldcc=;
	h=From:Subject:To:Cc:Date:From;
	b=XYz1T7Jcav2+SeoopomV8r3mtxlPMkOwBYu+UF4VS/vGFXGGaXGLdQF1+qZHGPdLf
	 pSQce6bYobzGBsYvzvu5mD0zUWofKjLL68cnNy39E/P+kyRm8D4u4I3vqSRYzkzeiG
	 9jcv8gClye/hATbLRw9FYvfgRv0jLYmJL90dTCnm3yJulu9zfS0BzOwS3QFuTbxs80
	 j23c8JGjrzm4BGmA1huWOeGEZ3kPWEr3FssJYUr0DBkybht2VUoj8DVOS3N9klr9LY
	 nGL4/QvyY/WyM0JJwxIE64oWPJ85gcT1rKcJuI7iBlZDeZG58XV15gfYJ7FfYlTR/L
	 w0tlVXAY6n7pA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-06-03
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240603115129.9494CC2BD10@smtp.kernel.org>
Date: Mon,  3 Jun 2024 11:51:29 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-06-03

for you to fetch changes up to 819bda58e77bb67974f94dc1aa11b0556b6f6889:

  wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS (2024-06-01 13:15:26 +0300)

----------------------------------------------------------------
wireless fixes for v6.10-rc3

The first fixes for v6.10. And we have a big one, I suspect the
biggest wireless pull request we ever had. There are fixes all over,
both in stack and drivers. Likely the most important here are mt76 not
working on mt7615 devices, ath11k not being able to connect to 6 GHz
networks and rtlwifi suffering from packet loss. But of course there's
much more.

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: pass proper link id for channel switch started notification

Alexis Lothoré (3):
      Revert "wifi: wilc1000: convert list management to RCU"
      Revert "wifi: wilc1000: set atomic flag on kmemdup in srcu critical section"
      wifi: wilc1000: document SRCU usage instead of SRCU

Ayala Beker (1):
      wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Baochen Qiang (1):
      wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP

Benjamin Berg (1):
      wifi: iwlwifi: mvm: remove stale STA link data during restart

Bitterblue Smith (1):
      wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS

Breno Leitao (1):
      wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config

Carl Huang (1):
      wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

Dmitry Antipov (1):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix a crash on 7265
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Johannes Berg (8):
      wifi: cfg80211: validate HE operation element parsing
      wifi: cfg80211: fully move wiphy work to unbound workqueue
      wifi: mac80211: apply mcast rate only if interface is up
      wifi: mac80211: handle tasklet frames before stopping
      wifi: cfg80211: fix 6 GHz scan request building
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64
      wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
      wifi: mt76: mt7615: add missing chanctx ops

Kalle Valo (1):
      Merge tag 'ath-current-20240531' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (2):
      wifi: mac80211: fix Spatial Reuse element size check
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Miri Korenblit (2):
      wifi: iwlwifi: mvm: don't initialize csa_work twice
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Mordechay Goodstein (1):
      wifi: iwlwifi: mvm: set properly mac header

Nicolas Escande (2):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: always set the TWT IE offset

Yedidya Benshimol (2):
      wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
      wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

 drivers/net/wireless/ath/ath10k/Kconfig            |  1 +
 drivers/net/wireless/ath/ath11k/core.c             |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c              | 38 ++++++++++------
 drivers/net/wireless/ath/ath11k/pcic.c             | 25 +++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 16 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  9 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 14 +-----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 39 ++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   | 13 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |  9 +---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      | 12 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       | 12 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |  5 +++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |  4 ++
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 41 ++++++++++--------
 drivers/net/wireless/microchip/wilc1000/hif.c      | 17 +++++---
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 43 +++++++++++--------
 drivers/net/wireless/microchip/wilc1000/netdev.h   | 12 +++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  5 ++-
 drivers/net/wireless/realtek/rtlwifi/core.c        | 15 -------
 net/mac80211/cfg.c                                 |  9 ++--
 net/mac80211/he.c                                  | 10 ++++-
 net/mac80211/ieee80211_i.h                         |  2 +
 net/mac80211/main.c                                | 10 ++++-
 net/mac80211/mesh.c                                |  1 +
 net/mac80211/mesh_pathtbl.c                        | 13 ++++++
 net/mac80211/parse.c                               |  2 +-
 net/mac80211/scan.c                                | 14 ++++--
 net/mac80211/sta_info.c                            |  4 +-
 net/mac80211/util.c                                |  2 +
 net/wireless/core.c                                |  2 +-
 net/wireless/pmsr.c                                |  8 ++--
 net/wireless/rdev-ops.h                            |  6 ++-
 net/wireless/scan.c                                | 50 ++++++++++++++--------
 net/wireless/sysfs.c                               |  4 +-
 net/wireless/util.c                                |  7 ++-
 41 files changed, 322 insertions(+), 166 deletions(-)


