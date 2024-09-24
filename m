Return-Path: <linux-wireless+bounces-13106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CC98420A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AB41F23F65
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382615539D;
	Tue, 24 Sep 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5vzvn/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C9155314
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169917; cv=none; b=olVKijzzGuoux1jdvntyRO4StVTCxZgoPaEhwV10jnOQYab3e/catQizvmrBN/aR7qAO1uRNbFxEg0wLUEmKa5JQJZnES9bsagDKrbW+X9zTm367wWAIa4MS6vu2i0TUjKBNVyoptneOf99EQEX1DKZbp8jZPGRY/AffHeV14Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169917; c=relaxed/simple;
	bh=glQD8WRL31UdYqkiq9YK+0QDTotbN41o2t2NZ3Fysko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lO9H4vKIKG99s7LRxZ3k3sjd4R3dW2PfFW9sTRjanv6gAUffu6uuQkiWYazaVhvNG6oeiImZ+hvUZ0+YtpjTWFAZ6A1sCXGtb8Ejj04WSSqMCSSGWXBz2uBeyF/JVqnhbpwynx+E+yn+9JpJPBL4vKPZLubrE54alx4TtF78R4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5vzvn/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D56C4CEC4;
	Tue, 24 Sep 2024 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169917;
	bh=glQD8WRL31UdYqkiq9YK+0QDTotbN41o2t2NZ3Fysko=;
	h=From:To:Cc:Subject:Date:From;
	b=V5vzvn/qeNQaa+Faw7puQp/YzpAhQNyfFVRBHax8BN1K+3ET3H5o0WhOFdyEZ7XD8
	 xF/4/2ccbQ3+Ijg/dSpoquzOGKpq63SKgWoXRfzid7x9b+tj/gbECBQ7EjgAfHPbvN
	 NdW2u6R723QnnRDoBlcJVNFp8KcybCN8L0TMleu7FPJ3Wsl+FVewRCj/zTeIqYKPBn
	 lBcLINQoN1BvZdBMWcenmBG7pRclaazRoaDBUZqHOyyjWGbLVtU4bESVFMo+9JbcgB
	 mHLqbVoFkkcdAml78Y19FoP7t07qhQAyUBoniW7uo8f9uN2H0kH7Pd9/DQLsGvApkO
	 Us8Ks0imBxJmQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 0/6] wifi: ath12k: switch to using wiphy_lock()
Date: Tue, 24 Sep 2024 12:25:09 +0300
Message-Id: <20240924092515.1049885-1-kvalo@kernel.org>
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

I'm submitting this as RFC as I have only tested these patches and need
to investigate how this affects MLO implementation.

v3:

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
  wifi: ath12k: ath12k_mac_op_set_key(): remove exit label
  wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk
    cancellation

 drivers/net/wireless/ath/ath12k/core.c        |   7 +-
 drivers/net/wireless/ath/ath12k/core.h        |   7 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   4 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |  26 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 388 +++++++-----------
 drivers/net/wireless/ath/ath12k/peer.c        |   6 +-
 drivers/net/wireless/ath/ath12k/wow.c         |  26 +-
 7 files changed, 192 insertions(+), 272 deletions(-)


base-commit: d35bb26e150d7fb7434959fad9fcaeaac99906e6
-- 
2.39.5


