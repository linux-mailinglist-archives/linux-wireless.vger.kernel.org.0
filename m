Return-Path: <linux-wireless+bounces-15720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB779D9C22
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187F7164F84
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08A1DA0E3;
	Tue, 26 Nov 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPd0bfSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F281DA0E0
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641102; cv=none; b=c+AoRio0+IgJADwopLni+RoX+DV0Ug4NLZgo8wdHmAPLD5dvp5f4sbRXOU0DUzV03V4gaTXXu6QbanCF2Feitdj+lDYJGd4+D3E9WALwy/V9gSdZ997nqBIbiX1CFcHpoaD70bp1dFA7sot4AdjqfAiHlzbrithzxbZ0aihsYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641102; c=relaxed/simple;
	bh=AAy/l7FVAB7w48Gl+7z8EDq9uVuCICPeTvilR4EL6Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUabz/qyQVmYYFLSv2EoNXZ594ExJ253aCfAjrVzhYj3SV4WJDOKVvG+RIUE33+T5DCO6rb6e1XssjxzWi77ZFpMaT9/HCY9cxx2b+wHtW5dPhCeF3SMxvO4W/nqSUTsmvXDku/HMnaldoHZGzZsiEwaokRcV0m7LeAIDxKLL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPd0bfSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB99EC4AF0C;
	Tue, 26 Nov 2024 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641102;
	bh=AAy/l7FVAB7w48Gl+7z8EDq9uVuCICPeTvilR4EL6Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=fPd0bfSpMYDrEt8Rk628FpdopH7LFr4W51QnQlyFh71qkE1JCfSUh/KjuG62Uk1XT
	 IXWU1c9gU4BDNijNksERwN6PDWp4QoqaENOJFyh2uTp7olXpT7FfCJu2fnpS8xi0JR
	 31zgs+KdnhlbT0cEWKK5x21QJhuXzlAD6H5uHro9gr7MX6XsBq/P0W3QnDC33AcBwD
	 1XpbF2SbD6X1yPTSg6uZiiyQ3jJVxxj6dW95WZzNspQcOQUay57kdiXaDtY4FOxgdm
	 3KFwaQ+5jpUjgc4ddKxnAfy58MUu6IZCKoe0lb/QLSqupCeopCNK3QbnGbdLs1yoRd
	 QxKb0mqk3Xb6w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/10] wifi: ath12k: MLO support part 4
Date: Tue, 26 Nov 2024 19:11:29 +0200
Message-Id: <20241126171139.2350704-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Here mac.c refactoring continues but there's also few fixes included. Please review.

Aditya Kumar Singh (1):
  wifi: ath12k: ath12k_bss_assoc(): MLO support

Kalle Valo (3):
  wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct
    wiphy_work
  wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
  wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided
    link id

Rameshkumar Sundaram (2):
  wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
  wifi: ath12k: defer vdev creation for MLO

Sriram R (4):
  wifi: ath12k: ath12k_mac_op_tx(): MLO support
  wifi: ath12k: ath12k_mac_op_flush(): MLO support
  wifi: ath12k: ath12k_mac_op_ampdu_action(): MLO support
  wifi: ath12k: do not return invalid link id for scan link

 drivers/net/wireless/ath/ath12k/core.c  |   6 +
 drivers/net/wireless/ath/ath12k/core.h  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |  36 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 436 ++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h   |   6 +
 6 files changed, 371 insertions(+), 125 deletions(-)


base-commit: 175616a7658cd5d53389d1f9c1ce22debd4595a5
-- 
2.39.5


