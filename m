Return-Path: <linux-wireless+bounces-25391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D79B04366
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E594A1E44
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F425EFBF;
	Mon, 14 Jul 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv2k2zTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F725E448
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506216; cv=none; b=HGSiTaXBUSBSFcoYgH70iry6Ef/Ced0rve84t6iwxu07KfwEWCYOa/mYTr+wWlhFjAfW8Ab0t+YiZOqmIQ7TFopiBZOQDHxZMi9DVP0ramrYNgA/UkiU69MMpSQrH4K2t7v110k53GVmGWFQZ0W/+HonTciXDXmoOLspDKz1vA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506216; c=relaxed/simple;
	bh=cNl2G+4nID9VEq/SkN/gUiR1UE/E6bO8XMUjvivYSMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2hIKJHkSbqYVhsyZE0FJ/aX9YRgAPN6mcGGyTZzMbmhRNcTBVxR3hUKQOMpWFoGfhRWVqYyApN9FaI2uF+sToA8SU8FBU/auKJTnQsU4ZiSW2+00gRHlERM5H5zK0GxFPIfqJ8Vdmxla3It+h79iGuMcTMKvTmfU47jW2PX+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv2k2zTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60ADC4CEED;
	Mon, 14 Jul 2025 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506216;
	bh=cNl2G+4nID9VEq/SkN/gUiR1UE/E6bO8XMUjvivYSMU=;
	h=From:To:Cc:Subject:Date:From;
	b=Yv2k2zTkXByHZEoKL4c7km2DuInQFDAfQMJOk0h6uEpmR1gEIjWAnuF0lY9qwZAn3
	 3jxmnM/APPXVeiaRNQY7C2sXG9pJpCU8UePyDShfSC3HTJJRjlg5pfVWfIdvkgZ2bz
	 W4NjrhrlxdvldLLulBwnlYqBqGRRqYUDpNVTWyz61Hc6uS4n5HK3VvN6D9sgTPo/y1
	 aqWC8noOHSQvySVV0OiCWLGdxFzq0+2wxk9iPszT9igjSvkJKOXoxTZJNhlI/rPZMa
	 /G1a1JZ4s4Dr30d74QjNwcSsRALwj12qGMTXW6uOjNkP9KVkvrsfpNYc9Pd1tYiDcJ
	 s4t656AgRHFCw==
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
Subject: [RFC mt76 0/4] Add NPU offload support to MT7996 driver
Date: Mon, 14 Jul 2025 17:16:18 +0200
Message-ID: <cover.1752505597.git.lorenzo@kernel.org>
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
https://patchwork.kernel.org/project/netdevbpf/cover/20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org/

Lorenzo Bianconi (4):
  wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
  wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
  wifi: mt76: Introduce the NPU generic layer
  wifi: mt76: mt7996: Add NPU offload support to MT7996 driver

 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |  71 ++--
 drivers/net/wireless/mediatek/mt76/dma.h      |  67 ++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  49 +++
 .../wireless/mediatek/mt76/mt7996/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  17 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  15 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  13 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   3 +
 .../net/wireless/mediatek/mt76/mt7996/npu.c   | 268 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/npu.c      | 378 ++++++++++++++++++
 15 files changed, 855 insertions(+), 49 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c

-- 
2.50.1


