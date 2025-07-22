Return-Path: <linux-wireless+bounces-25832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F63B0D4D3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8104B1AA2333
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F612C1581;
	Tue, 22 Jul 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2owCAeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551C228C86
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173789; cv=none; b=mINRAtzNoUUVy5mBIRjsWxgPSvE4xZjsFZzUJR74IEkcA/0tz4Jh20AOLeaYc6ckZbzLU4MBvAAVJzitv+RLnicqbQAATnni2ZMvSUS9xqQtfD35QqXG2ZSmHd2khYucT3Y9prhumaf9G+TIwPwSpPIpubd8bbOMb1M6H96/Yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173789; c=relaxed/simple;
	bh=HoN/3y3SXLcKwKC3/dtyDNLJWjVXsQw8MjZvFf8nb/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwXXkEriRBG8FsDLjlUk4+fKseovba0ioJd8vhZxk+VCb7k4fsxxB+zLyfDz388wSc/8E3R2bMtvoXbuW3AEAJv6K5osvi7xcWPEXr7FeJtwi5hs0evPztETH6g8c1SgXm5DbNhGDHFFqlaovcx1tOgymZh6nYmHj459V86EZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2owCAeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D281C4CEEB;
	Tue, 22 Jul 2025 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753173789;
	bh=HoN/3y3SXLcKwKC3/dtyDNLJWjVXsQw8MjZvFf8nb/s=;
	h=From:To:Cc:Subject:Date:From;
	b=Q2owCAeH7MwmIn4nbNSRCAax4lZqFqDz0Uk8z8Ucll8L5lQ7x4ow3h5LJK9PMltM4
	 2c1QX+/I0t7sNNDaCtbYUhyNoGqHbdulM5LPTjFTXGMYoyn+GM/q4XLeCC2pLUdaI1
	 n1IM/3IfHmsYNsBs2VTd9TA0imerQBUpt2Zr5sAdO37ZAiJEe6a0wKrRDh1VPX/1MO
	 8IbsNtQasH+45mQcF5ZkEEb37GtNE7bj1S2RHCpITt7VHDqKn0PXNQm2CBAan3vO4I
	 hMwZbgl+wBT2kEHkpq8oWEakL78wpaYls228i682KNs6nh53elB4Cc02a6t3/XF9nM
	 +VLmuqU/uJvUw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	krzk@kernel.org,
	lorenzo@kernel.org,
	horms@kernel.org
Subject: [RFC mt76 v2 0/4] Add NPU offload support to MT7996 driver
Date: Tue, 22 Jul 2025 10:42:23 +0200
Message-ID: <cover.1753173330.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha NPU support to MT7996 driver. NPU is used to enable
traffic forward offloading between the MT76 NIC and Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.
This series is based on the following net-next series for airoha_npu driver:
https://lore.kernel.org/netdev/20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org/

Changes in RFCv2:
- Do not compile MT76 NPU codebase if NPU support is disabled in airoha-eth
  driver.
- Remove dev_warn() in mt7996_pci_probe() if NPU support is disabled.

Lorenzo Bianconi (4):
  wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
  wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
  wifi: mt76: Introduce the NPU generic layer
  wifi: mt76: mt7996: Add NPU offload support to MT7996 driver

 drivers/net/wireless/mediatek/mt76/Makefile   |   1 +
 drivers/net/wireless/mediatek/mt76/dma.c      |  71 ++--
 drivers/net/wireless/mediatek/mt76/dma.h      |  67 ++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  91 +++++
 .../wireless/mediatek/mt76/mt7996/Makefile    |   1 +
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |   9 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  15 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  13 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  21 +
 .../net/wireless/mediatek/mt76/mt7996/npu.c   | 284 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |   3 +
 drivers/net/wireless/mediatek/mt76/npu.c      | 378 ++++++++++++++++++
 15 files changed, 921 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c

-- 
2.50.1


