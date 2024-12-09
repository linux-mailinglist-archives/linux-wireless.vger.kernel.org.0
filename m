Return-Path: <linux-wireless+bounces-16103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05F9E9E7B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE5166E22
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F72175D3A;
	Mon,  9 Dec 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdZvBRzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED5167DAC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770464; cv=none; b=VnW0w61ORu43AO5uWqE65Fmw+RDZcYq0wsY+f2ZwEZCKf0YhoQMAb3s8pEym/Vhsv4dHCRPeXq7ix+MmDrL2vT0TKLmmUWr/ihcLpLCVmjZkZkJwA29qY1zfoJEtrB12y7PoYhE5/GVd3Ke6nlM2Sbt3etun5Vr2Edb6nUG5zRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770464; c=relaxed/simple;
	bh=90AjjSK78KZHmSzF/kocMWbCfIF7ZpNwSM++h3U7QLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOuPLoBk/L7Z/lVB1JGCE3pwD+NGecbF+6Wxaaa2o+0lDHoC88XgCCh4l9Qfe/ym1LYL70CseB2BbwoHVpy8lzO6tEfJSCwS7IxlW8g7XlKT7qKlP0v0XQZDLIDnKCKck3yJP2EHZSxiVeFCH+4a3mejZRXL46LrQiR7ChfOvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdZvBRzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51FFC4CEDF;
	Mon,  9 Dec 2024 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770463;
	bh=90AjjSK78KZHmSzF/kocMWbCfIF7ZpNwSM++h3U7QLE=;
	h=From:To:Cc:Subject:Date:From;
	b=hdZvBRzBw3F1nyeM8KzoejVSVlIkdpTPyZLQlTKusZzgg77HCmtMPIvVuu2qGjRWX
	 pDaAk0LOC60vUFddDrbwW11FcP7uMT+nC/EvO4LA4s67rMxesPvKAkYda6EqXXu2AZ
	 3EYPaspSyaLxxiEjOOL+cj8saBhSR72eU4BU+Hva7oaTqg030v6jH3SL8QpNiME6LD
	 tobpPoHn105u2mcJAGzdN9CEASKzqxNA2ccYFXJBT87+BBv1isu6wNCpsA1yZXOZe6
	 6w1E9OFvW6YoPSL7XzFZBy5MCeSber+nYv8+GpPizkrudo+EYGhMLIpSHE83unwaUC
	 9eCpNnEfrV4QA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/9] wifi: ath12k: MLO support part 8
Date: Mon,  9 Dec 2024 20:54:12 +0200
Message-Id: <20241209185421.376381-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Getting MLO to work with QCN9274 is getting close, this should be the second to
last patchset. Small patches this time. Minor changes to data path to support
MLO, some interface combination rework and few fixes.

Please review.

Aditya Kumar Singh (3):
  wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large
    allocations
  wifi: ath12k: fix ar->supports_6ghz usage during hw register
  wifi: ath12k: pass link ID during MLO while delivering skb

Karthikeyan Periyasamy (6):
  wifi: ath12k: move to HW link id based reveive handling
  wifi: ath12k: add partner device buffer support in receive data path
  wifi: ath12k: add helper function to init partner cmem configuration
  wifi: ath12k: introduce interface combination cleanup helper
  wifi: ath12k: Refactor radio frequency information
  wifi: ath12k: advertise multi device interface combination

 drivers/net/wireless/ath/ath12k/core.c   |   5 +-
 drivers/net/wireless/ath/ath12k/core.h   |  17 +-
 drivers/net/wireless/ath/ath12k/dp.c     |  14 ++
 drivers/net/wireless/ath/ath12k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |   8 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 213 +++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.c    | 247 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/peer.c   |   2 +
 drivers/net/wireless/ath/ath12k/peer.h   |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c    |  10 +-
 10 files changed, 414 insertions(+), 109 deletions(-)


base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
prerequisite-patch-id: 721655de1e9eb1b723c3340c80f52be7ab6e73a7
prerequisite-patch-id: 99576487c570edbaf46b35e8ba6b9e20ad9bf85c
prerequisite-patch-id: f0a242859176e986640595256e7f488561683309
prerequisite-patch-id: 532325a3a8da40d6b43ef643f38dca5389750820
prerequisite-patch-id: 1a0adfd0f7ad52c7d0ddd6466659e7a8a229013b
prerequisite-patch-id: e1a1418434e24374ef1ad04a49249436de602dd8
prerequisite-patch-id: 8847add439503b799079f8cfa043b15b57691d7f
prerequisite-patch-id: 017994ce11ee18d218464d1bb5ffb50ac8d941a5
-- 
2.39.5


