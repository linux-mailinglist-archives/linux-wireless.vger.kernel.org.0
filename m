Return-Path: <linux-wireless+bounces-27216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE1B51A66
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D5AB606A2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68533CE97;
	Wed, 10 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okT/Rb2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38F32CF6B
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515224; cv=none; b=da3a686LHqAYXVXkgIxcxRCrwp+QOJoFzG1NOmto0cepW+Q030GfOQfFtUpVBoK/c90Q0FIrdcbqBbRUpW65x+C/F3C9WR4Q3YsUvVjfjjczTekcNxUSb8jBvvMa2KyTJim9wrefZ38kIU5813LAc23/8YKEpfMih8crq80fyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515224; c=relaxed/simple;
	bh=Jzop6ul/4tVOPaZkz1xDLoiVg5p9/77QHGE89X0WNWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPmVDSJPtZ2mGNJNY33XJdsVV0OAjhJqjQC8yXKzZ3p7osyqQ+aT6Hk2HZ5FJ9voxZ86dJqehv90cAMUI04MMCltbo3qNrSnA086c6Rc5+2xpJu+o1iM/CQr7n86YEF8cYO38vhpHt1b490cDiA7dR/NeVOQcVC9k6UTs1Wwzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okT/Rb2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7385CC4CEEB;
	Wed, 10 Sep 2025 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515224;
	bh=Jzop6ul/4tVOPaZkz1xDLoiVg5p9/77QHGE89X0WNWo=;
	h=From:Subject:Date:To:Cc:From;
	b=okT/Rb2UBU69uiaNuQHWXc/M8BuinSaIVgLUtxPzkxpGur72j5RA6r6WojWWQrfQS
	 S1vaE+cUnsYlznCe6cd45PwnXIujccRbOcJMfZj5ycfSb4Pw5/Rg/jyLuYZBuM6rA+
	 go8L7SyhiRE/d49xVDvIRBjyV9mlV+5Nwf0q+H3AuH59xpL8jsTmfzvTJsq94HbBKp
	 gOEqpf+prZSGgiHvqjl4AcQVaR/aAayCL2uQOP+xH83SI2k93nm95De7V0JYHLTor1
	 mcgDyT6Sp/oELaOkXSnth8opzfs4dGgPSymLaXB/M3uXByioXYoBRrDJ6Jf+lDHdUq
	 riX2q8uzZL+5g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/5] wifi: mt76: Add NPU offload support to MT7996
 driver
Date: Wed, 10 Sep 2025 16:40:01 +0200
Message-Id: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGNwWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3dwSczPdvIJS3ZTUstQc3cTEVAuTZPPktBRzYyWgpoKi1LTMCrC
 B0bG1tQAQKPi6YAAAAA==
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
base-commit: 8620dfbed395fc72f968dfd07f1b50eba352bae6
change-id: 20250910-mt76-npu-devel-aae84c7cfd73

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


