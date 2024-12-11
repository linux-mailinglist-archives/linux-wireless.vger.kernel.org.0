Return-Path: <linux-wireless+bounces-16255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36179ED02F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB74916AF97
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4C1CB9EA;
	Wed, 11 Dec 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7UpIfdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5341D0F50
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931841; cv=none; b=bH+Vtbz0ski4CTXQKWXpuRZcKY4SJeZMwW2/yEKHiS/El7eeSoEfuCdIHfFtuTiR8Wf+oBxSbQipBCALN5RDe9k0Tez/hWh7eo6XDfWBSDzLR5ncjFNzZciv4BepQFBkIUs09GZUZyIMEIDLy52BXri9hRw616ZGibwuC+2rEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931841; c=relaxed/simple;
	bh=aG4RgDRyRpZnGIGsKaAiH/8JkR1fnpa+sxx5VzyOkYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N8nDPamiT3KnkDNBoVzjUQuPSxy+74JBXzzdoNyagUXoCIyKqFVTWDQ0hX1/Yd+8zpGMj+j7uRFh9AQ/CpOGhLCRNo5s+T+BYmnFEFwJPB7FTFXGcSyqiKcSghQF0O6cQVYKVFNEc2WUyTMBoHbUY38kXX8HA708JqjnszmZ1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7UpIfdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474B0C4CED4;
	Wed, 11 Dec 2024 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931840;
	bh=aG4RgDRyRpZnGIGsKaAiH/8JkR1fnpa+sxx5VzyOkYw=;
	h=From:To:Cc:Subject:Date:From;
	b=e7UpIfdx6IQfXC0j0W8bE8BCtKFoiOtGi3ahegwId+YidmJa4DMVfXtBBEZJRKriH
	 h0j8eFFeFzDMo1zU1me22krP0xHrsP4gQGLNHry5Ablv3iv9tulG4in1jeLU4nqgx3
	 yClnzHTYBrt2Y0oHPAEmqXvbVODQ548hPre+8yNdfWSoixlBXKZM/DRF33uYkPII7i
	 vt2Ot5taJd+g6klnLxqfyqnNTNbN31rhzibWJqhpyuyyf9C9bQR1lO863Smce9rmjk
	 LX+QR0MXfsb1HhXK+Y43rtG+O346Vp+sMgqsFt5EsE1lugzSac5vhOwru588BuhjX9
	 mLhZRFubVFxFA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] wifi: ath12k: MLO support part 9/9
Date: Wed, 11 Dec 2024 17:43:51 +0200
Message-Id: <20241211154358.776279-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

The last patchset enabling MLO support in ath12k (only for QCN9274, for now).
All are small patches adding the last minor features before we can enable MLO.

Please review.

Kalle

Depends-on:

wifi: ath12k: MLO support part 8
https://patchwork.kernel.org/project/linux-wireless/cover/20241209185421.376381-1-kvalo@kernel.org/

Aditya Kumar Singh (6):
  wifi: ath12k: symmetrize scan vdev creation and deletion during HW
    scan
  wifi: ath12k: add can_activate_links mac operation
  wifi: ath12k: add no-op without debug print in WMI Rx event
  wifi: ath12k: remove warning print in htt mlo offset event message
  wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
  wifi: ath12k: assign unique hardware link IDs during QMI host cap

Rameshkumar Sundaram (1):
  wifi: ath12k: advertise MLO support and capabilities

 drivers/net/wireless/ath/ath12k/core.c  |  34 +++++-
 drivers/net/wireless/ath/ath12k/core.h  |   7 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   6 +-
 drivers/net/wireless/ath/ath12k/fw.h    |   3 +
 drivers/net/wireless/ath/ath12k/mac.c   | 156 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/qmi.c   |  35 +++++-
 drivers/net/wireless/ath/ath12k/wmi.c   |  26 ++--
 drivers/net/wireless/ath/ath12k/wmi.h   |   7 ++
 8 files changed, 234 insertions(+), 40 deletions(-)


base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
prerequisite-patch-id: 4f0c25ed9cb858bbe89fb5eb0edd226596e2234e
prerequisite-patch-id: 99576487c570edbaf46b35e8ba6b9e20ad9bf85c
prerequisite-patch-id: f0a242859176e986640595256e7f488561683309
prerequisite-patch-id: 532325a3a8da40d6b43ef643f38dca5389750820
prerequisite-patch-id: 1a0adfd0f7ad52c7d0ddd6466659e7a8a229013b
prerequisite-patch-id: e1a1418434e24374ef1ad04a49249436de602dd8
prerequisite-patch-id: 8847add439503b799079f8cfa043b15b57691d7f
prerequisite-patch-id: 017994ce11ee18d218464d1bb5ffb50ac8d941a5
prerequisite-patch-id: 8160e50b27670d195fb48f365e48e9914aed35f5
prerequisite-patch-id: 2a828218167edcca737a6400145c48e99be1dab0
prerequisite-patch-id: 960a34375824886cfadeff20afe1152290d285bd
prerequisite-patch-id: 6ed64d739660c590f3a891b675ada69ff71db858
prerequisite-patch-id: b71fe3eca5e431636785abf669d55eb600e3a212
prerequisite-patch-id: 066f114094ed84600304fbb2dd113a153b48b253
prerequisite-patch-id: b14fd74db0c7979aaf7b22c70b53f3b27730ce8e
prerequisite-patch-id: 3b8dae9159662edaaf64d144f0c0796737c3b77c
prerequisite-patch-id: d26a06c418d308111a55f1a1b8f03250c17ba6c5
-- 
2.39.5


