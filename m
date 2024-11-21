Return-Path: <linux-wireless+bounces-15553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA39D5039
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688E2829C6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D8156875;
	Thu, 21 Nov 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oliylSwC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276579C4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204688; cv=none; b=uzc2bxC1tLDszbDgvtHfc+LBsAJocxMClteQz56k4xzmV/glJFI82uFWoR1Upg3SX4JFx6DO8PiJ8wyhf7by/FOsT8fLwoZEWsw8Z0aoEKf4XyVHM/d8gLGRoP9I75DqvbYAoK1lXTNgTqVINe6KorWmO1UIrT3ODYeFsTjSri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204688; c=relaxed/simple;
	bh=bM8yvdO52euAiZL2EbvfH106P1GU63TZbKzTB2Ya7L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdKFM5Ud0s0Zi1mXn+m3ME/g5NBw8NGlBwkxjxByWoVpGwcKWxa4H4je9/x7E/hb3Fkm8jUyWdEh9SjHZ00zROUwnG+dfwOZkCcXO86gWggMYRO/XUK1+xeMznke4EBwV6/bgCeao9Gyuj3kiWN0hpFfD8HM8raV+4UZ6WPuPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oliylSwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBADC4CECC;
	Thu, 21 Nov 2024 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204688;
	bh=bM8yvdO52euAiZL2EbvfH106P1GU63TZbKzTB2Ya7L0=;
	h=From:To:Cc:Subject:Date:From;
	b=oliylSwC4OrSdPol+DVzjjMWlHgCKykAWQ7aoqiE/ZAQKuiWkkOT8OGmvxYkmyWMs
	 3odMNp/6K6B83f8Wr19oGNm1indg/FiI27Vgl4tvxNqoNqn0OWXQ9dUTdKP3TaUZZt
	 nUfzore9oTD+L+IrnACvxzzgrJhk7vPDoEPhp4Qd6HVJPYv9dsBmWi/8SmzVEOtNgc
	 aSh7M+rYgjaReVIYUHsOOtquldXsLoEgQg3NBVHDqyxnwJR6m7z7liBt8afx49QLVd
	 hKpXkQeruiKlPjTNztsRDNt+NOk9S4syvSDncIfAjuice3bueZ3zC73DG9/3JkgtgW
	 chuc1AyRdMTjQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] [0/8] wifi: ath12k: MLO support part 3
Date: Thu, 21 Nov 2024 17:57:58 +0200
Message-Id: <20241121155806.1862733-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

We continue refactoring ath12k in preparation for supporting Multi-Link
Operation. For example, in this patchset we modify station state handling and
start to use more link level configuration.

Please review.

v2:

* patch 1: maintain sta state in ahsta (offline change from Aditya)

   sta state is not per link level hence there is no point in keeping it in
   arsta level. Hence move it to ahsta instead. Even mac80211 keeps sta state
   on per MLD sta level instead of link sta.

* patch 1: minor code refactoring and removing redundant codes (offline change from Aditya)

   For ML station remove, redundant code was written in different function.
   However, existing flow code can be leveraged to perform same operations.

* patch 1: ath12k_mac_assign_link_sta(): remove unnecessary synchronize_rcu()

* patch 1: ath12k_mac_free_unassign_link_sta(): remove unnecessary forward declaration

* patch 1: fold ath12k_mac_unassign_link_sta() into ath12k_mac_free_unassign_link_sta()

* patch 2: ath12k_mac_alloc_assign_link_sta(): use kmalloc()

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241106142617.660901-1-kvalo@kernel.org/

Rameshkumar Sundaram (2):
  wifi: ath12k: add reo queue lookup table for ML peers
  wifi: ath12k: modify chanctx iterators for MLO

Sriram R (6):
  wifi: ath12k: Add MLO station state change handling
  wifi: ath12k: support change_sta_links() mac80211 op
  wifi: ath12k: add primary link for data path operations
  wifi: ath12k: use arsta instead of sta
  wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
  wifi: ath12k: Use mac80211 sta's link_sta instead of deflink

 drivers/net/wireless/ath/ath12k/core.h  |   4 +
 drivers/net/wireless/ath/ath12k/dp.c    |  44 +-
 drivers/net/wireless/ath/ath12k/dp.h    |   1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  58 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 985 ++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h   |   1 +
 drivers/net/wireless/ath/ath12k/peer.c  | 108 ++-
 drivers/net/wireless/ath/ath12k/peer.h  |  11 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |  16 +-
 9 files changed, 965 insertions(+), 263 deletions(-)


base-commit: 7c16c77c1c085ed2e14f95b3399fe216e1e42a35
-- 
2.39.5


