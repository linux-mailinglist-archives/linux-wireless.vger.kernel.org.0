Return-Path: <linux-wireless+bounces-29488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66FCA2C1E
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0180A301BEBC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64199279DC0;
	Thu,  4 Dec 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEbEnNW1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B22741B6
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835884; cv=none; b=AyR/XBsUXZDwzykbaRr4xllAZorK7cFG5towoOBdbGi3HjzCcOHyHLeviEJVKyHqtoWIEVS3J6MwN/USkE+NV0BWS+x213YgLrv3paso2ouCNEuQuPoltZ7qJSF2yfeObbyqEEmMbQ16d0h3QSRXkXVmkb0wNHBY5zXBaxARjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835884; c=relaxed/simple;
	bh=ih0PAVj5mYWpCZmavJUHnu6MojlzaYqb055Ta3igXto=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DRKAIn7+NgOYM6UDSwey0GfPWXrIfDYXVjhc6PDoBVkEq4Jw1HhsxzzDSySOofOUfXi8coHRbgQAkFyJQ1QRlTZH8/UF1Fo+U8dedFm7DwaIWWFjLY88h5UOKMos7dc7Jk0IJIakCEqd8BRI8Ldt361Q0RlKDK/yuoD7Q9eC0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEbEnNW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6433CC113D0;
	Thu,  4 Dec 2025 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835883;
	bh=ih0PAVj5mYWpCZmavJUHnu6MojlzaYqb055Ta3igXto=;
	h=From:Subject:Date:To:Cc:From;
	b=fEbEnNW12WVkW5n7hYCQDv9S+uU6YHfC/p3BNvlvwbOHpmady7jHPmWkQEskD98jJ
	 gA1t+ogXrGVACAlkut3CyRQ89zmxgl9rrdFSmCIhzvvVw/CSeAzaOh9vxcZ4w0V89F
	 Sa19Vs1ZSy/YR0wgaXQjxik9FLxmdzGTSLxqTXQUgdyzvmyJRFUOgyb2p8QFmdKVGo
	 McUgwsJV49wPotFicS47tbKfF+VJTNLvYZmOiRXYkqHZOuFXMF37PqTCrerutN206N
	 tNTZ0ktST0bQTG6apfpx8ArPy7J2sxqWb1UPxxddBnTgWNJ5t+hBEXMeHtWTQ7PBBt
	 /cBgmBpKZVf7Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 00/11] mt76: mt7996: preliminary support for MT7996
 NPU offloading
Date: Thu, 04 Dec 2025 09:10:42 +0100
Message-Id: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJJ2uNXooPUWguloRWB9O9Jl
 4E5zCSIFJgi9EWCQDdH9i5LVRYwrcYthDxnBymkqjJwPxuN7riQzLIRems3b2YUQnXW1FLXXQs
 5PgJZfv7xML7vBw7LOTxoAAAA
X-Change-ID: 20251202-mt76-npu-eagle-offload-0059fa426498
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Introduce preliminary support to enable NPU offloading in MT7996
(7990-Eagle) chipset.

---
Lorenzo Bianconi (11):
      wifi: mt76: mt7996: Fix NPU stop procedure
      wifi: mt76: npu: Add missing rx_token_size initialization
      wifi: mt76: always enable RRO queues for non-MT7992 chipset
      wifi: mt76: mt7996: Fix BAND2 tx queues initialization when NPU is enabled
      wifi: mt76: mt7996: Fix wdma_idx for MT7996 device if NPU is enabled
      wifi: mt76: mt7996: Add mt7992_npu_txrx_offload_init routine
      wifi: mt76: mt7996: Rename mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
      wifi: mt76: mt7996: Add NPU support for MT7996 chipset
      wifi: mt76: mt7996: Integrate NPU in RRO session management
      wifi: mt76: mt7996: Integrate MT7996 init configuration for NPU
      wifi: mt76: mt7996: Integrate MT7996 dma configuration for NPU

 drivers/net/wireless/mediatek/mt76/dma.c           |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  10 +
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 132 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  47 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   4 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 394 +++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/npu.c           |  31 ++
 9 files changed, 503 insertions(+), 129 deletions(-)
---
base-commit: 53d1548612670aa8b5d89745116cc33d9d172863
change-id: 20251202-mt76-npu-eagle-offload-0059fa426498

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


