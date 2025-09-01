Return-Path: <linux-wireless+bounces-26898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD545B3F027
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7844F484527
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A1272E41;
	Mon,  1 Sep 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3zVbZU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5F1DDA0E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760302; cv=none; b=pQjDDFpHaA8X7btQ92gbVZEw2pBUfD0s1Sw1dMtr3gMupedIkFOs4rpxX0LrAmM5RPWvkNbg9p7rGON9yQCC6krRDTLeHjM6gh36/ni2gGA2J0IVLHrKcdT/LJdNrQUtO3DasGJR88HsnPR4hzUMaxgK6xxEa8jQc/kWrBGykWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760302; c=relaxed/simple;
	bh=wF92u9Joc2AuDrhH1zBbRWs4j5eARuYiRn0/M2503aE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KFwoEI/xeULzi2E6OY2VgO06H5+EpUHrqUBtZ1BdK1s1fNprBwAi/O/vTGNXEhsUJ3W0SC1Imyn4wYUVJT9Xzg0Q+es0AVeYJzLpkKbKOfZ+6Fnbk31FCacTe1zbNFAjMGeKmezVuUYiL3sgoDI2OHStIDuhcU9SVZWYkwKHDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3zVbZU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC79CC4CEF0;
	Mon,  1 Sep 2025 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760302;
	bh=wF92u9Joc2AuDrhH1zBbRWs4j5eARuYiRn0/M2503aE=;
	h=From:Subject:Date:To:Cc:From;
	b=B3zVbZU3MKwDl7Y3iQaH8GnuotGg66HQ2TWvAII1euSxhIS2UTKy+izgk/TvdsnJ0
	 r+wmB91YJOPXmsKqPyncFHwSkcbbRGzFaqbX6YwLUZtqg431i9kXGkpWUs3KLH0jcm
	 AdC8rbCqB+pXpLEIsvjjnjoLCarh0yaked3n4Lsmxp1J8wB0VNeEgp9c2+S50lcd70
	 pAc9UKsA/UG6iUUi+Pwnh3WsZz84lP1R31OIihWyW4+3NpO3ls8BY7WIh89vyDsRrr
	 O3cAmUpyTjMx16R0J8k95Og7TSsiznUURNSURj4/SzS2H93tJi0jOOlko8G+q3KIn8
	 r83dbnFqvEi+w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v2 00/14] wifi: mt76: mt7996: Decouple RRO logic from
 WED support
Date: Mon, 01 Sep 2025 22:57:56 +0200
Message-Id: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQItmgC/32NQQ6CMBBFr0Jm7ZjSILSuvIdhQdopNCglU1I1p
 He3cgCX7yX//R0isacI12oHpuSjD0sBearATMMyEnpbGKSQF6Fkjc+t07pF5oBMr8AzykYLQyS
 csArKbmVy/n00733hycct8Oe4SPXP/qulGgW2RjVdN1jdanebiRd6nAOP0OecvwhPAf6zAAAA
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
Changes in v2:
- Fix SER when Wireless Ethernet Dispatcher (WED) is disabled
- Rebase on top of mt76 main branch
- Link to v1: https://lore.kernel.org/r/20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org

---
Lorenzo Bianconi (6):
      wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
      wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
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

 drivers/net/wireless/mediatek/mt76/dma.c           | 215 +++++++++---
 drivers/net/wireless/mediatek/mt76/dma.h           |  47 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  54 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 326 ++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 310 ++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 367 ++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  19 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  89 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  91 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  32 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   8 +-
 15 files changed, 1306 insertions(+), 269 deletions(-)
---
base-commit: 533a336bdd8154e69439c5f157fdc69a448942a3
change-id: 20250821-mt7996-rro-rework-2490cee0f0d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


