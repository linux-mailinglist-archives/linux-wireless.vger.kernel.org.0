Return-Path: <linux-wireless+bounces-26511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28ABB2FA22
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFE01CC2A78
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683732A3E4;
	Thu, 21 Aug 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIxP/xj6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4932A3DC
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782184; cv=none; b=ncidG1x6QcFV9vKEo1pS6nuR9CNYeMUNsNfPCRXATElBLYST4Nqft5Aemr0SdgkpJZIH3rONVbVmb0Mdo52VDz00x9lQybe0efSh0yiInYW90FJIaJOMZA0q3DcHDNW7xiVxDvzC+jS/nzcknWMz9vbFjGIkG4icdW2wWtx5Wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782184; c=relaxed/simple;
	bh=uXC8XBLK8JNdBpqHbP9lfOw01MDaNvB9hC67k6MC2as=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lDbRaHGoHS5I2u7fp2IolR3XPOatiKqtPQh1arlxJKiQUU5UMgjC4TpVKNQMfdUX05enE1mOjcgWoY5OImhTT1jmDvmWbjUPKzHxhBqXRgw9/eCXBe4c9UhldddLjQLZ/vuoY1fBxfghW9BZAGf7ZvyYQ6zUxUa1u+v+6eIfexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIxP/xj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D601CC4CEEB;
	Thu, 21 Aug 2025 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782184;
	bh=uXC8XBLK8JNdBpqHbP9lfOw01MDaNvB9hC67k6MC2as=;
	h=From:Subject:Date:To:Cc:From;
	b=BIxP/xj6QGyIxppt2DObsQpLw2SOfcPEkzfJWTyxSjrixxHJB60NQBd0Sly1OBPoN
	 WWC7QH4oDH1Md7M3oNxli5EWkSr2q28SaEY0issY+Bjoy/xuyRT8tlYWq2zyAuE5f4
	 9MRMLrEXO7N0IJMdxpTNQhOZoQ0webpFA/DIG24AMMvzHfUs/E6AfgsK8a08krUH6m
	 ahJsb+8FhclO1D1XjDQOCh9yb4AC4L7UknXWDO+6dPewop5dbDgNiV1IOwwuFDsrVQ
	 0CwdeJd3WW2Bm3JQJ4pxSrWlfzUHBZnAvEUKf0SwDOzV/hMqUoCsN9AbYQ6QAOpirN
	 zyN9Avrnr/TNg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 00/14] wifi: mt76: mt7996: Decouple RRO logic from WED
 support
Date: Thu, 21 Aug 2025 15:14:52 +0200
Message-Id: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0bp2gC/x3M3QpAQBBA4VfRXJsam7/1KnKhNZjEalYoeXeby
 +/inAcCq3CAJnlA+ZQgfovI0gTc3G8TowzRYMgUVJsM16OytkRVj8qX1wVNbskx00hDDbHblUe
 5/2fbve8HzC2rsmMAAAA=
X-Change-ID: 20250821-mt7996-rro-rework-2490cee0f0d8
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>, Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

Decouple RRO logic (v3.0 and v3.1) from WED support in MT7996 driver in
order to reuse it when WED module is not available.
Introduce WED offload support for MT7992 chipset in MT7996 driver.
Please note this series is based on the following commit available in
net-next tree:

commit 477b4a33c96451b6e49f242a3d7bab67a57666b1
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Aug 12 06:57:23 2025 +0200

    net: mediatek: wed: Introduce MT7992 WED support to MT7988 SoC

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

 drivers/net/wireless/mediatek/mt76/dma.c           | 176 ++++++++--
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
 15 files changed, 1280 insertions(+), 256 deletions(-)
---
base-commit: 477b4a33c96451b6e49f242a3d7bab67a57666b1
change-id: 20250821-mt7996-rro-rework-2490cee0f0d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


