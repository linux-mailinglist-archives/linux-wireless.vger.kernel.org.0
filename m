Return-Path: <linux-wireless+bounces-27014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB1B442FF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EC73B0805
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B42D12EA;
	Thu,  4 Sep 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BITsbOMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE201260580
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003897; cv=none; b=nc59vaMqKuS2K1ApkWs2HisZSGQEmbKP4KSgmU9D3uH44bLeT+bzymaDfjRlt70jBfqAs5FV+qz5Hoy3dPcf4ZSUDVMPFRywpjqpWKcoOO/VX87eBDp5MxggTKqEY55DEyRQU3Q7rcg+nt5+V2QQcEPyd01v3MGveG9riMEN0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003897; c=relaxed/simple;
	bh=ChX4cPagxHty/nC/yRxRrePEVJPTduypsP1Q5ifYM7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VT1KhtpIrrGKQVRpTZpXXYrMzJrcwb8xpWSF3Ni1UDcBAm510ppnfznh+VaYvMryN6nq+jbXMXOjMw8ODBioli8gLfn+lVIFNFrG8F0N8GD7mGFKWARZ0f50IiimTcUEe/msNw/HloFixspJva6L6v4ClP+KjlR9iRfSQ54bfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BITsbOMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430D4C4CEF0;
	Thu,  4 Sep 2025 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003897;
	bh=ChX4cPagxHty/nC/yRxRrePEVJPTduypsP1Q5ifYM7Y=;
	h=From:Subject:Date:To:Cc:From;
	b=BITsbOMIAwbcvehEwnuLF/fetUdeLkMwFX7QHiXTTQ4r+fgBFgUIXQsvXMTcHmQIE
	 vnddshjNs1AjPvUqrN62kC3EPdyOQ+/b2Vqt45F/c1anaTzLYjCKvgQxjvBmS8PEKL
	 EQ31dUYUEpDatFSa83RYya5cVOpSAq3kPIlokeh8Egs1CpVEkpq8NFwhvxRA1wQvU1
	 WKq7/7Wwv/wnwY+9nTB3Ir6XTsJCm+k3qpEuG76xU5Kznhj0ziKren5m0zNp6DLNCc
	 fVOFgtDndk5iOdSEMHaxQVPkKFAX0/Oluxj+FAlpabwoZPAjsapR01KxQR37isavve
	 2/1h4E3eMXUPQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v4 00/15] wifi: mt76: mt7996: Decouple RRO logic from
 WED support
Date: Thu, 04 Sep 2025 18:37:54 +0200
Message-Id: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLAuWgC/33NTQ6CMBCG4auYrq1py1/HlfcwLhCm0KDUTEnVE
 O5uYaNG4vKdZJ5vZB7Jomf7zcgIg/XW9THS7YZVbdk3yG0dmymhMqGV5NehAMg5keOEd0cdVym
 IClEYUWsW/26Exj4W83iK3Vo/OHouE0HO139akFzwvNJpUZQ15GAOHVKPl52jhs1cUG8CxCqhI
 iENxIn8nMla/hDJJ6HWiCQS2miZaBCQAX4R0zS9ABi3+Eg5AQAA
X-Change-ID: 20250821-mt7996-rro-rework-2490cee0f0d8
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

Decouple RRO logic (v3.0 and v3.1) from WED support in MT7996 driver in
order to reuse it when WED module is not available.
Introduce WED offload support for MT7992 chipset in MT7996 driver.

---
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
Lorenzo Bianconi (7):
      wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
      wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
      wifi: mt76: Do not always enable NAPIs for WED RRO queues
      wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
      wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
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

 drivers/net/wireless/mediatek/mt76/dma.c           | 226 ++++++++++---
 drivers/net/wireless/mediatek/mt76/dma.h           |  29 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  54 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 326 ++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 310 ++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 365 ++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  19 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  89 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  91 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  32 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   8 +-
 15 files changed, 1297 insertions(+), 269 deletions(-)
---
base-commit: bf71ee05e8ceaa086233d6db2557442c153ba05e
change-id: 20250821-mt7996-rro-rework-2490cee0f0d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


