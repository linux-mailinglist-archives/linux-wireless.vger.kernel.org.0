Return-Path: <linux-wireless+bounces-28016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D59BE74B4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BCCA505E36
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78BD261B77;
	Fri, 17 Oct 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiUW45Bh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239225F984
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691053; cv=none; b=kH22VEJRXgxgRvSeNnXc6tZxygQP/tdEMcZLi8GI0EdhmXpjnpn/lMWWGvZOnWPz1ifI2Z/IDtyUjvTn4yOY9jdGjnMyiIIiyrQ3v7YOdeA4DTExg5GHOXyKHUctLnDkTkOKqlaaD/NeHSwlATQjkHtGwekKg2vJXas5cX+2ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691053; c=relaxed/simple;
	bh=w4olcKRO3ecEK3uC8NaUXgJFicNfgiNRqioLEZz49X0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iksx9TOLril8S/hrra/zn+EVikXubXq/RXcQg6cWdpzn1kkQdmtzinSn9BsSQFn4wHa0i29QwQOkm16hLHqurP4+ra4S5qWIQQ5bhswdO1arHe/WQQNZtSBflH9CpOJTxEW+VuLylDYELjRaJLp9jfPcO4og4hj5ZlPmiejUj2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiUW45Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B046CC4CEE7;
	Fri, 17 Oct 2025 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691051;
	bh=w4olcKRO3ecEK3uC8NaUXgJFicNfgiNRqioLEZz49X0=;
	h=From:Subject:Date:To:Cc:From;
	b=oiUW45BhCheOI+GQWnej3OnwcgbHLJHeFtnrCUBtv6r0BfHpkideZeNPoxkIxyZgF
	 KnM+iwVqE2YPXRHTaEcluROFF/EWBPvmytPE/hX6YONZYf/5Ovw2zoR+wP6jZsjP5L
	 mfJpy88nISloEubuc4cJXwirylqqLFYIr+PhHOdxjviyg/0awvb0eXoqdpTENCTcgC
	 7y4GICdCNwbVBM7rgWJddx3STShz1kmvFNPcTvv3ylv7kFcTqRiToNqkZBJLmgny5F
	 7/EDzr9SWRjgh6G8dCK4bDSAw+KVD9zhNNeEQFba1Z3Sne446tln+ZIfgzSncYPNpp
	 K4cxUOytflpAw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v2 0/5] wifi: mt76: Add NPU offload support to MT7996
 driver
Date: Fri, 17 Oct 2025 10:50:28 +0200
Message-Id: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUD8mgC/3XMQQ7CIBCF4as0s3YM0CrWlfcwXVCYtsQKDVSia
 bi72L3L/yXv2yBSsBThWm0QKNlovSshDhXoSbmR0JrSIJg4sZYzfK7yjG55oaFEMypFl0ZLPRh
 ZQzktgQb73sF7V3qycfXhs/uJ/9a/VOLI0PSGGlXLvtXs9qDgaD76MEKXc/4CLwH7760AAAA=
X-Change-ID: 20250910-mt76-npu-devel-aae84c7cfd73
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce Airoha NPU support to MT7996 driver. NPU is used to enable
traffic forward offloading between the MT76 NIC and the Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.

---
Changes in v2:
- Rebase on top of wireless-next main branch
- This patch is based on the following commit avaiable in net-next main
  branch but not in wireless-next one:
  commit 105ce7ad57e492b75ab40f2dc591db645fadbaa2
  net: airoha: npu: Add a NPU callback to initialize flow stats
- Link to v1: https://lore.kernel.org/r/20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org

---
Lorenzo Bianconi (5):
      wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
      wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
      wifi: mt76: Add the capability to set TX token start ID
      wifi: mt76: Introduce the NPU generic layer
      wifi: mt76: mt7996: Add NPU offload support to MT7996 driver

 drivers/net/wireless/mediatek/mt76/Kconfig         |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile        |   1 +
 drivers/net/wireless/mediatek/mt76/dma.c           |  73 ++-
 drivers/net/wireless/mediatek/mt76/dma.h           |  67 +++
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          | 137 ++++++
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |   7 +
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  16 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   4 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  21 +
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 352 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +
 drivers/net/wireless/mediatek/mt76/npu.c           | 494 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/tx.c            |   6 +-
 include/linux/soc/airoha/airoha_offload.h          |   1 +
 19 files changed, 1187 insertions(+), 58 deletions(-)
---
base-commit: ccc4cf71390c19ea0b95c7879b31ed23f18525d7
change-id: 20250910-mt76-npu-devel-aae84c7cfd73

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


