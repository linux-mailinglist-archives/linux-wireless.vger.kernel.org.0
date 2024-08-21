Return-Path: <linux-wireless+bounces-11748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0395A185
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC01B1F2337D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729B13D8B2;
	Wed, 21 Aug 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6xRkVJ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAF136342
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254653; cv=none; b=j07Op5kBFtwafqZs14SdczzSrV95UZ2Qsou4AUijNmdd5UvKhENI6MxBY5W/y3PGEGmX8H7OWTCCVMW5VCUZcobJeMZwSn0D8vwTtCVCOn/L8+j87tvaB/2gyhsdwDreXGyo5GggN3rSReLaRlWztFkcmIR1CLjtgq4GsufupFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254653; c=relaxed/simple;
	bh=4NQy9XYDVAd7OXQxaogt82tT/li3qf+oGJKMYNomv64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ke8ojDmhh64HmQmSe1iusOqAiTIxKmM6Se22kZQsPAeowNthdx0G0RpCspIfJnl5vUf+aCz75C4uSCCiEMAMzHJRf6789IkmTPhxIUh26acbbBtODPWlF3R5afVqQX5BUlMyDStwlPSCTDkTcSI8daQPb1w/AziShYu/2LJZ5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6xRkVJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8550C32781;
	Wed, 21 Aug 2024 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724254651;
	bh=4NQy9XYDVAd7OXQxaogt82tT/li3qf+oGJKMYNomv64=;
	h=From:To:Cc:Subject:Date:From;
	b=W6xRkVJ7l8Q0xWW7T2qQngBwINrrvKU2roKCNGUa02cujlukfP0/eZwHJZn0K3/ZX
	 sR3EZWCDRAhxKd+tRdjPRdgfZhcYFPsGgXa6c1Gp9lgwQFWeRaMpEWhphVVDPCtPNn
	 BlwFzlKso1Sk0355VPGtRGtEHYi3jf+hwZS/KJoesGIIXtN6SrIrbmyFjeE2jrdIsw
	 VxYihy9B2B2+BmQunx5aEdY4fnL1OtF1wdfVoE4d/1dsr8W/VDcoho6bmCXUdE5b1H
	 GYes8A7yjylC8xDPabozYOKjU2yBGXHJzNocEBrDXaLDrQnHkDbd3RXGsRZTLh4XUj
	 op2LaN0VBgbsg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC 0/4] wifi: ath12k: switch to using wiphy_lock()
Date: Wed, 21 Aug 2024 18:37:24 +0300
Message-Id: <20240821153728.2121600-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
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
 drivers/net/wireless/ath/ath12k/mac.c         | 366 +++++++-----------
 drivers/net/wireless/ath/ath12k/peer.c        |   6 +-
 drivers/net/wireless/ath/ath12k/wow.c         |  29 +-
 7 files changed, 187 insertions(+), 257 deletions(-)


base-commit: a38ef6438cb9017b7f0a6a8978355aeb02742a62
-- 
2.39.2


