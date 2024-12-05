Return-Path: <linux-wireless+bounces-15932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D79E5F67
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C211883F2E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B51B219E;
	Thu,  5 Dec 2024 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0n1QEke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D5179A3;
	Thu,  5 Dec 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430648; cv=none; b=BK1Lf+SsiM2F/lyiAEegb6iWGsDwb/ndCNuPQJA/2ayjDZvY45V6V8Q+WFze3U3y/jEQmv09UmaA3iWwY5Q5Agvf4N+BB6Yif5ywVRtuBu6oI94+hTjPxsc3kWMr3sNz2F7pjDo2id0uLCFL3GEei3DSm01CMW33+xKx3DhtvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430648; c=relaxed/simple;
	bh=Ib3cGulyfqEUw58OLEQF7k9wpzjY72SNjQYpqGguIOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzEIbKLBZ7ICK5+vRP2wVPVizuIq2vmCZqapZpVm9O4TQE78sIdUQCJKMwqyvE58Y/gGwsP+tNwrYNCRfXzO5gJoqhnW+YwZkcygi//DqPASYLZGuIpYhLyBvobUAI0wTZGw1G9kHM00dPnEBXvycaOviAfo6SKhRm3St7aaFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0n1QEke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBABDC4CEDC;
	Thu,  5 Dec 2024 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733430647;
	bh=Ib3cGulyfqEUw58OLEQF7k9wpzjY72SNjQYpqGguIOU=;
	h=From:To:Cc:Subject:Date:From;
	b=G0n1QEkeaNl625piuM1qYWEOP8Xpnc7XYN4dZ/NXa5U9L1BovuibuvNLt1kmvfBlt
	 bhKshxhCMXqHoL0ZkCofgJ6FQqjrI1zzwvL0nR5yGgs4pVR90XWEJ5j4N/GdlDx/rU
	 hQ01aEIPzniLNwqylL3SlOwgzLpOFKQgAuJKVl37ioV90tebsld6eEvELk62EyifHp
	 zAFkZatCfqr+8esUr724yyNMTZxyfDAT6DnvDNCyW53457hyXnopkmxa1nL/D/aKj+
	 Vh3YL/Igi+WiWo882kJ+23Ym6MOI11FHlZsczrE+rJflNUK3j7WABj1Z/HhFL2v86X
	 ZNtNC8BT4VU4Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/8] wifi: ath12k: MLO support part 7
Date: Thu,  5 Dec 2024 22:30:36 +0200
Message-Id: <20241205203044.589499-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Implementing Multi-Link Operation (MLO) continues. Bindings document is added
to get WSI information from DT (patch 1) with the code parsing the information
(patch 2). Rest of the patches are about configuring MLO in firmware.

Device Tree bindings were last reviewed as RFC:

[RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k PCI module with WSI

https://lore.kernel.org/ath12k/20241105180444.770951-1-quic_rajkbhag@quicinc.com/

This patchset depends on:

[PATCH 0/7] wifi: ath12k: MLO support part 6

https://patchwork.kernel.org/project/linux-wireless/cover/20241204163216.433795-1-kvalo@kernel.org/

Please review.

Bhagavathi Perumal S (1):
  wifi: ath12k: Add MLO WMI setup and teardown functions

Karthikeyan Periyasamy (5):
  wifi: ath12k: send partner device details in QMI MLO capability
  wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
  wifi: ath12k: add support to allocate MLO global memory region
  wifi: ath12k: enable MLO setup and teardown from core
  wifi: ath12k: avoid redundant code in DP Rx error process

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: Describe ath12k PCI module with WSI
  wifi: ath12k: parse multiple device information from Device Tree

 .../net/wireless/qcom,ath12k-wsi.yaml         | 205 +++++++++++++
 drivers/net/wireless/ath/ath12k/core.c        | 256 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h        |  18 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  13 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 142 +++++++++
 drivers/net/wireless/ath/ath12k/mac.h         |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c         | 283 ++++++++++++++----
 drivers/net/wireless/ath/ath12k/qmi.h         |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c         | 180 +++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h         |  49 +++
 10 files changed, 1073 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml


base-commit: 3b2ab397d31f926523f2781d7f0a14a387415bf4
prerequisite-patch-id: 4540940c2bec34a09b96e13f48137b6e790511d4
prerequisite-patch-id: 472a001cb2a5600bbb7586f33107b3e03779cd13
prerequisite-patch-id: e0f7adef6ad3fb9d6d87acb79750a50e3c806708
prerequisite-patch-id: a7b08b983b6c74382c97db7e7d10cc954853fe9a
prerequisite-patch-id: f623e2512bafdececc6b567935fe750c572a0089
prerequisite-patch-id: cfe1b2c58cfa15ea019cc32114c5787a39a65f9b
prerequisite-patch-id: e2829b24674547319d5e684ef7bdd800667c0807
-- 
2.39.5


