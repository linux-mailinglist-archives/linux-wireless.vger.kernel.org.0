Return-Path: <linux-wireless+bounces-27158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD74B4A8C1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45591880592
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB178309EF8;
	Tue,  9 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjKhMMDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5630AD1B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411123; cv=none; b=t4FcFEjRYPDDrCpzVNO0qvWO9ssjp/lHn4ftE4ohWzQ6ZTyp2Yu2c8ogC116IUhgLNi/AuVMOXLI7/zXGiyfDiNGTER8qRzGR6hMpzdGxDvIyf/OmNH/HLo4l9yKiaCbXQ5ZBI95gDCEkYzBHqTGSMa5Rt/vG78CejaDipg8OLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411123; c=relaxed/simple;
	bh=6Ia94TRSZA8SsqhhVryqysgdQbFx10IztQi8lM9eEWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kj9z9ywircpljkOiC3FV90rnWISJRx3GFT4xiMzNE6ARX0yZ0MtyucnR+Z5mIyiX7+8mEQX51e3xER4rHhNQrQ2nDLLRRjI/NhwLTAu0DiNa2hEiLb2Q7sZIvACPg3lMg7/LePkCS8oO/33tPZMW0qtigiYkd9dYSeUlRW9vyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjKhMMDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B2CC4CEF4;
	Tue,  9 Sep 2025 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411123;
	bh=6Ia94TRSZA8SsqhhVryqysgdQbFx10IztQi8lM9eEWY=;
	h=From:Subject:Date:To:Cc:From;
	b=NjKhMMDYd72PhQgDOxt8i8Ro/KBVVDDBON28EkMgi4bndcvon6TjRPk7e2a3HD6Cp
	 UXvygD+ZWGOU4z+QrHMRbp8QS3s9SJeaJv/uqaYLyCGVuuUeKJvf3E0vsrYIyhHsFK
	 EZv4PdYAif1g+bmIk+CGVzm4cfyJZPiUHOdGEin33SsrO77GKvLHqh+iwZy7ozli5k
	 1YnnwAvb0RTpzPqcFWhrRuIBuvpbVt6tx+z0bW1yMM8ksafyZKdWhSWQlDDCuPvlQ7
	 Q7rrGh8kZVPS6sgxAOu9tpqlJvt5DDuOIaEZ8kL85x3SpYS7K6qZxFXP1V4GdE/rtE
	 8kY74Bxy0F+og==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v5 00/16] wifi: mt76: mt7996: Decouple RRO logic from
 WED support
Date: Tue, 09 Sep 2025 11:45:08 +0200
Message-Id: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACT3v2gC/33NQQrCMBCF4atI1kaSaZpmXHkPcaHNRIPayFSqI
 r27sRsrFpf/wHzvKVriSK1Yzp6CqYttTE2Ocj4T9WHb7ElGn1uAglI50PJ8rRCtZE6S6Zb4KMG
 gqolUUN6J/HdhCvE+mOtN7kNsr4kfw0Sn39d/WqelkrZ2pqq2Hi2G1ZG4odMi8V68uQ4+BKpJA
 jKhA+YJuyu11z9EMSZgiigy4YLThUOFJdIPYcaEmSJMJqD2qKkCQG+/iL7vX0/n7/R8AQAA
X-Change-ID: 20250821-mt7996-rro-rework-2490cee0f0d8
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

Decouple RRO logic (v3.0 and v3.1) from WED support in MT7996 driver in
order to reuse it when WED module is not available.
Introduce WED offload support for MT7992 chipset in MT7996 driver.

---
Changes in v5:
- Fix more bitmap usage in DMA descriptos data.
- Fix compilation warning.
- Link to v4: https://lore.kernel.org/r/20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org

Changes in v4:
- Do not use bitmap for DMA descriptos data.
- Link to v3: https://lore.kernel.org/r/20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org

Changes in v3:
- Fix compilation warnings
- Rebase on top of mt76 main branch
- Split patch 4/14
- Link to v2: https://lore.kernel.org/r/20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org

Changes in v2:
- Fix SER when Wireless Ethernet Dispatcher (WED) is disabled
- Rebase on top of mt76 main branch
- Link to v1: https://lore.kernel.org/r/20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org

---
Lorenzo Bianconi (8):
      wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
      wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
      wifi: mt76: Do not always enable NAPIs for WED RRO queues
      wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
      wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
      wifi: mt76: mt7996: Convert mt7996_wed_rro_addr to LE
      wifi: mt76: Add rx_queue_init callback
      wifi: mt76: Add mt76_dma_get_rxdmad_c_buf utility routione

Rex Lu (8):
      wifi: mt76: Differentiate between RRO data and RRO MSDU queues
      wifi: mt76: mt7996: Initial DMA configuration for MT7992 WED support
      wifi: mt76: mt7996: Enable HW RRO for MT7992 chipset
      wifi: mt76: mt7996: Introduce the capability to reset MT7992 WED device
      wifi: mt76: mt7996: Enable WED for MT7992 chipset
      wifi: mt76: mt7996: Introduce RRO MSDU callbacks
      wifi: mt76: mt7996: Decouple RRO logic from WED support
      wifi: mt76: mt7996: Add SW path for HW-RRO v3.1

 drivers/net/wireless/mediatek/mt76/dma.c           | 226 +++++++++---
 drivers/net/wireless/mediatek/mt76/dma.h           |  29 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  54 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 326 +++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 318 ++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 387 ++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  89 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  89 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  32 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   8 +-
 15 files changed, 1315 insertions(+), 277 deletions(-)
---
base-commit: 29806c11aec7a552fa351867efa1337cc4ad1fe9
change-id: 20250821-mt7996-rro-rework-2490cee0f0d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


