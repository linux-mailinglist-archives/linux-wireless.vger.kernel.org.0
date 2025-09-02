Return-Path: <linux-wireless+bounces-26939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E48B40DBB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3303A9359
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A933EB17;
	Tue,  2 Sep 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDfO+Jq+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17B2F83D0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840688; cv=none; b=rXY0J9PogN3XuoUCJALzh/sc0OlIzlPA2Yd2Mt60XA5bd1DJiyEEl1EA07ZLo68iQ2yw0RksZxHEAz2iRPIuyP3z73QoPJIsZl4TuQIapTOjsswmUIclUjNk7TrX7apcd+C6xoLRmV3FetsAE+RFLH0UwH5dbc916MV9ZzG/wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840688; c=relaxed/simple;
	bh=ck3/Ptu01yBjH4i4YdJ++OB47FDKG2zMtAy7fwoHRYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OzGhmi0Fnlq8dqupQpa6MAYSzGK0wi3Y096vh7phOW+pgNkMLM1o9P2/O5OOROmiW0/YtpiR3oICVshQzYhhVXSRK/MMAoaW6NBTH1uCAOHs8CMlZ0G/sfN52k5LR4VmiP7hQgUnJZYqPhfaCWpmttfSd8NA2SJip6LaDa9pQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDfO+Jq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C0C4CEF7;
	Tue,  2 Sep 2025 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840687;
	bh=ck3/Ptu01yBjH4i4YdJ++OB47FDKG2zMtAy7fwoHRYk=;
	h=From:Subject:Date:To:Cc:From;
	b=hDfO+Jq+R3j/5cTzFy6+tt0efObUX8DEVs73EXYGOMva30PuK2whyRRWK19sWUFXj
	 0L0D0DQElFeji/CEBZHMJ7BAUbvqfGVE9+44PIfoa6mAXxyxvkfz/Yj7u+NNsVEhFq
	 8LSeExjGaXVIu6DDALjm8grhcnhUv6GXyx5f4lXl/I+y8E5G3CL6KgCv9RZMjkcneR
	 TvVkbQyu32In3Yt0kXBeu2COv1jHcrOSjtiRWo9p8vFa8yUwblDyFmewHOxwwKlcRx
	 xWfygV35KlC35kSTZWqMwo3Z5WHddSxQm3/4DntFz/q6K6IPyEfexkSqi3xUxEvgzB
	 kO1XR3ml0UQXg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v3 00/15] wifi: mt76: mt7996: Decouple RRO logic from
 WED support
Date: Tue, 02 Sep 2025 21:17:50 +0200
Message-Id: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5Ct2gC/33NQQ6CMBCF4auQrq1pKxSGlfcwLpBOoUGpmZKqI
 dzdwsaYGJf/JPO9mQUkh4HV2cwIowvOjykOu4y1fTN2yJ1JzZRQhaiU5LepBNCcyHPCh6eBqxx
 EiyisMBVLf3dC656beTqn7l2YPL22iSjX6z8tSi64bqu8LBsDGuxxQBrxuvfUsZWL6kOA+EmoR
 EgLaUJfCmnkF7EsyxsIPk/H9gAAAA==
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

 drivers/net/wireless/mediatek/mt76/dma.c           | 215 +++++++++---
 drivers/net/wireless/mediatek/mt76/dma.h           |  47 ++-
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
 15 files changed, 1304 insertions(+), 269 deletions(-)
---
base-commit: 8680a5406aa6348943da4e739483870a865c343a
change-id: 20250821-mt7996-rro-rework-2490cee0f0d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


