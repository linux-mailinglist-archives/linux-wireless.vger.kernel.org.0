Return-Path: <linux-wireless+bounces-13612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3891E993442
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA1A284A02
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59E1DC1A6;
	Mon,  7 Oct 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfpkFJkX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0531DC1A1
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320375; cv=none; b=H2nFs58NK7HJ8wZRh4uqo9KwGpwqp8sBFnWk6fJaTVIuGryubNPuDfmpfmJDO7lye+GAM4OVJyfxb40XeGHtomLRqkZqk8FtBG6pIa8PphCl6S3Ooft6lAMp3Ct2P+10mRfhavb5NRQk7l/3uFYXFBdimI0rUnoR1TCI4Ip90qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320375; c=relaxed/simple;
	bh=24oXcR1cCTS8ICxr6auGrAJBYBfCWfHURTnHc2VMI34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKALvA3bky4KVHYgDEP/gujkNxXWcw83qTUTLCcNODx+7QEzqm8LYjmk2fT3GnvYJRNhI4KgdKYnbAshOCXGtwUDhbgsuYXa27RNTqt1Bt7xCZZloSO2DgOocGGjR8xqjRtrueqXyfi4O1hAV3BGI0UyMX/eQlYGBs5btMphtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfpkFJkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE7CC4CEC6;
	Mon,  7 Oct 2024 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320374;
	bh=24oXcR1cCTS8ICxr6auGrAJBYBfCWfHURTnHc2VMI34=;
	h=From:To:Cc:Subject:Date:From;
	b=YfpkFJkXOdExaRc805PhA68WhExpv4+eD2YXCdGb8ZV3bjpH95ekDHWkoEqVox+Zw
	 lM/NrROY/OYHanyQ8j34b6QTKGe+8vrXiNIMhyIHYl4vxDiZsYQ9s74B+xub/tRCrI
	 u3zg89s7auUvpbSujR6Kt1WAWNIAELYmK25nniLZ3D4HOlA38P/hmSrIydBzrPOidF
	 eabyQUaqlRCpiNNpS7t7VUhnSnJT9+1Ow2lLbSBCU28dP5y8/N/jwaw5XqtFmGedHq
	 I0wqFfxbP/KnX81KMQESs6A8VUR4Slh/EchuwNky9gX2XnlOgZfgJNJnbAhWvdWqr0
	 dGwQ0ysfMibAg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/6] wifi: ath12k: switch to using wiphy_lock()
Date: Mon,  7 Oct 2024 19:59:26 +0300
Message-Id: <20241007165932.78081-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Convert all uses of struct ath12k::conf_mutex to use struct wiphy::mtx, which
is already used by mac80211, and remove conf_mutex from ath12k. This way we
have one mutex less in ath12k and simpler locking design.

v4:

* patch 2: s/praparation/preparation/

* ath12k_mac_op_assign_vif_chanctx(): lockdep_assert_wiphy() was twice

* ath12k_mac_vdev_create()(): lockdep_assert_wiphy() was twice

* as this is now tested with MLO remove RFC tag, this patchset should be ready now

v3: https://patchwork.kernel.org/project/linux-wireless/cover/20240924092515.1049885-1-kvalo@kernel.org/

* new patch: wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()

* new patch: wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation

* patch 3: ath12k_core_post_reconfigure_recovery(): take wiphy lock before hw_mutex to
  avoid a lockdep warning

* patch 3: ath12k_sta_rc_update_wk(): remove extra wiphy_lock() calls

* patch 3: update commit message, especially remove the sparse warning which was already fixed

* rebase to ath-202409191620

v2: https://patchwork.kernel.org/project/linux-wireless/cover/20240918181042.91891-1-kvalo@kernel.org/

* rebase to ath-202409051620

* patch 1: ath12k_wow_op_suspend(): remove extra wiphy_lock()/unlock() (Baochen)

* patch 1: fix clang warnings about unused labels (Johannes)

* patch 2: s/no/now/ (Jeff)

* patch 4: ath12k_sta_rc_update_wk(): fix wiphy_priv() usage

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20240821153728.2121600-1-kvalo@kernel.org/

Kalle Valo (6):
  wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()
  wifi: ath12k: convert struct ath12k_sta::update_wk to use struct
    wiphy_work
  wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
  wifi: ath12k: cleanup unneeded labels
  wifi: ath12k: ath12k_mac_set_key(): remove exit label
  wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk
    cancellation

 drivers/net/wireless/ath/ath12k/core.c        |   7 +-
 drivers/net/wireless/ath/ath12k/core.h        |   7 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   4 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |  26 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 387 +++++++-----------
 drivers/net/wireless/ath/ath12k/peer.c        |   6 +-
 drivers/net/wireless/ath/ath12k/wow.c         |  26 +-
 7 files changed, 190 insertions(+), 273 deletions(-)


base-commit: 1a0c640ce1cdcde3eb131a0c1e70ca1ed7cf27cb
-- 
2.39.5


