Return-Path: <linux-wireless+bounces-13968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BF699F3C0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E4B2834DF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2F1F76B4;
	Tue, 15 Oct 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzUQNOEI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03917335C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012460; cv=none; b=jllc7/v8xq6AmU4+lFT6NDWwU9rEvr9CHNNu5JlGVbnrn74kW7nEM9mImsJWByA0Li7tzVfI0okm0H9pd5lwI8hgoE5e232QL8byovGNbTyDwrK5P/ktHqOy9ktqepcBBcB+oZFzm93W7p9rQNexDGqc4s9S/1lnS0Qu7TfsLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012460; c=relaxed/simple;
	bh=DCBlPadHCzsQZj65kPYdgD6poH9aNHZndZDV2jYWdMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2SkG4k/hdO3yZldHRp5hTL+F50ZH+b4DYi5S0F9qrqZpo9iBuI1YFi4nPcny7h7+zYz0suhb6hamFNgmwuUEeKOIW+aDmjt5EGXHcdN/ejrjlNDWRmqJnDiBmk11RJOgCUR9aJbI2v+7c0Zrc8ny2Ds2nW56AbHjvc+JN2Qioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzUQNOEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF03C4CEC6;
	Tue, 15 Oct 2024 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012459;
	bh=DCBlPadHCzsQZj65kPYdgD6poH9aNHZndZDV2jYWdMY=;
	h=From:To:Cc:Subject:Date:From;
	b=hzUQNOEI7REmVwE5/qbInfTNjcc2P9kOUqdSyOEytpaQK7poDRwmlmBAQhXOPw6YZ
	 7DcRyUCQhVOlMqNkOkdGuYAqgRLwTJhi/HVQNdUopuvuNi6rSGu5gzaF5pipBWySwN
	 5MFNeZjMcNDr9Gv6EuLK6oKdbyN3NTQdMCDg6znMu7fc2Co5awhEKSfG3t13s+KKZF
	 tYB4OVOUY8I4eXQvOJ8zkLVbg3outmAK8WrVzmKPpFeVeD98sjit0nuRnOmHxT2oBA
	 0p+5IblPJecsorMkAH/5Wh1BINz9BVwCp1f2ZgYkrHGiFLSOAkm4RHxrOiyBma/FTZ
	 MsV4ywnSBbvPg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] wifi: ath12k: MLO support part 1
Date: Tue, 15 Oct 2024 20:14:05 +0300
Message-Id: <20241015171416.518022-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

I'll start submitting patches for adding MLO support to ath12k. There will be
several patchsets and this is the first one (of many).

In this patchset we start refactoring code in mac.c to support multiple links.

Depends-on: wifi: ath12k: add missing lockdep_assert_wiphy() for ath12k_mac_op_ functions
https://patchwork.kernel.org/project/linux-wireless/patch/20241011173323.924473-1-kvalo@kernel.org/

Rameshkumar Sundaram (4):
  wifi: ath12k: prepare vif config caching for MLO
  wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
  wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
  wifi: ath12k: modify ath12k_mac_op_set_key() for MLO

Sriram R (7):
  wifi: ath12k: prepare vif data structure for MLO handling
  wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
  wifi: ath12k: prepare sta data structure for MLO handling
  wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
  wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
  wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
  wifi: ath12k: modify link arvif creation and removal for MLO

 drivers/net/wireless/ath/ath12k/core.h   |   89 +-
 drivers/net/wireless/ath/ath12k/dp.c     |   21 +-
 drivers/net/wireless/ath/ath12k/dp.h     |    3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |   14 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h  |    2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |    9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h  |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 1492 +++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h    |   11 +-
 drivers/net/wireless/ath/ath12k/p2p.c    |   17 +-
 drivers/net/wireless/ath/ath12k/p2p.h    |    2 +-
 drivers/net/wireless/ath/ath12k/peer.c   |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h   |    4 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |   22 +-
 drivers/net/wireless/ath/ath12k/wmi.h    |    8 +-
 drivers/net/wireless/ath/ath12k/wow.c    |   59 +-
 17 files changed, 1192 insertions(+), 584 deletions(-)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
prerequisite-patch-id: 3f91f437016fbeec6019c1444cee521756971ba1
-- 
2.39.5


