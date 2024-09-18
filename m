Return-Path: <linux-wireless+bounces-12972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DC97BFFF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DB2283170
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5717C98E;
	Wed, 18 Sep 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWvPplYu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDB1509AE
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683045; cv=none; b=PUQyB3Ve4NgWviDhCIMT6tSwjB49y0s0VAlFt4nYLW8Tt3iTvM7be0gFV2vDb1+bvcCPjyzBFVjLxouHNzgyegE7BgxDZnaYzKnVzA7047eVX6GxqwndqMaezgRv3WvvrQwI0oR9JqesGqgNushT4DpeXnRiFIivthyTNxXJcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683045; c=relaxed/simple;
	bh=V691wO6FXdMoBdotKFnE8iuE140/7GMXx+PGaFn2t5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJsxD3aUBQJd/k2jeeVWxSOfCPA+ycfpLJ60nOMbkKh+0muafPa2dulbOaKzqCRRcubcwhY34EN4eTu23qXgyFNBm/fiuSD5KDjwmL3+IwwGonAcJ9OJtPhgUg6FxwCvxVuXeY7/VCw8IAVqWkrlfS7Z4QxxKgTHJPg9yAxDXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWvPplYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A8AC4CEC2;
	Wed, 18 Sep 2024 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726683044;
	bh=V691wO6FXdMoBdotKFnE8iuE140/7GMXx+PGaFn2t5M=;
	h=From:To:Cc:Subject:Date:From;
	b=bWvPplYuftc1hkfwWUZP8MfCxtwt7DS5bYCX8jp2gAckS850DlTZZxzgbHTCATeoY
	 fJ4GoTwJj7tgsfWlNRzm5bRXuXH8sWz5SsS9Ukk/SGDWaQzb0yUZ384rvSgSXigSsu
	 Sfx/Qhm2pbSokmW/99nZpt9NJxJNrO7unV4cCwPKfry07F+DNvDNBpbUc+XAOiXMtf
	 /jWxmvGzk7PgsaX+Vnk/SHsayMU5DlHIoa781RyU3SLljHP2PIQtAqN3YanSMmKTM6
	 0qPw5RyHNJ5b4KXc45IgAdHgRHWagrfxNY69rpYobQFudW54y9lb5DAlAwxcngdj+5
	 6Hu0cCGyBPTFw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 0/4] wifi: ath12k: switch to using wiphy_lock()
Date: Wed, 18 Sep 2024 21:10:38 +0300
Message-Id: <20240918181042.91891-1-kvalo@kernel.org>
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

v2:

* rebase to ath-202409051620

* patch 1: ath12k_wow_op_suspend(): remove extra wiphy_lock()/unlock() (Baochen)

* patch 1: fix clang warnings about unused labels (Johannes)

* patch 2: s/no/now/ (Jeff)

* patch 4: ath12k_sta_rc_update_wk(): fix wiphy_priv() usage

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20240821153728.2121600-1-kvalo@kernel.org/

Kalle Valo (4):
  wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
  wifi: ath12k: cleanup unneeded labels
  wifi: ath12k: ath12k_mac_op_set_key(): remove exit label
  wifi: ath12k: convert struct ath12k_sta::update_wk to use struct
    wiphy_work

 drivers/net/wireless/ath/ath12k/core.c        |   6 +-
 drivers/net/wireless/ath/ath12k/core.h        |   7 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   4 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |  26 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 363 +++++++-----------
 drivers/net/wireless/ath/ath12k/peer.c        |   6 +-
 drivers/net/wireless/ath/ath12k/wow.c         |  26 +-
 7 files changed, 183 insertions(+), 255 deletions(-)


base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40
-- 
2.39.5


