Return-Path: <linux-wireless+bounces-19200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84371A3DB1F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D39189BA6F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97C1F5612;
	Thu, 20 Feb 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvpG0kjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E361F4262
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057552; cv=none; b=PGPK7fnjuIDf1EOvxAJWcB76elEKLEUJJwMZv83AY/PhmYWNawKaGbpJWY9tb2L9kSK8E+K5a5D52l8PcH5GIChwnWk8RWZgNeejLDkv7pJPHRD+e5tbRz8D7q2dYGsSpOIdt+OCkjNezmhw4geY2/SeBSQfyip19A1lTpqR6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057552; c=relaxed/simple;
	bh=UUnURo3zAoASQKC54eJodNprMU55Mn36QZREdJKHOP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CYmcV5oTWoxpa9kIVno60d/QYBVxEBsZ325FfF8EhWUwLwNR9sol/dFty1b4NNrJWCHryZ/7mqjsaR5S4LlkedVLDNJKPVKCCEs6RToa/yygrW6wLjEIEwwGfJmMqQHE/ZqaXwCaLnWTvVmEdidqzlsiVvDUuDuSJTq2XQy3dJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvpG0kjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1384CC4CED1;
	Thu, 20 Feb 2025 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057551;
	bh=UUnURo3zAoASQKC54eJodNprMU55Mn36QZREdJKHOP4=;
	h=From:Subject:Date:To:Cc:From;
	b=rvpG0kjEEFZwtA3tN7346VbqUyXJN6XjOn5sg61RVR7h2Xp7mHm0kNCKV5qBaveZX
	 YnrrnrhaDFiNwowrhzG0RtnHJQccMC4RhbVAkvdN21n90/gjFUS6dYOD1ec6byRsX1
	 U5CFfNbP0sfszHIAzcQaE8A4uB2gnVxshhRdRjbVh6HcP5qPU1aILZke08oTmV3pwW
	 dA0Z7WyCMiBVEeLRd4r0ieHcVU3XcIUDy8SucIhCAJz3HmpT3i50QO5Asoy5krvzC6
	 X7+6F7tzgbZ3TJ7mQ2ZDQKAd163smG7MRtQsx5DVN2b+9pDJS5RLp1Gbgifwl3hs1v
	 Er4XhFbnFxGhA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 00/14] wifi: mt76: mt7996: Preliminary work to support MLO
Date: Thu, 20 Feb 2025 14:18:46 +0100
Message-Id: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYrt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3dwSc0tLM93cnHxdS9NUy7RUY4NEy1QDJaCGgqLUtMwKsGHRsbW
 1AB7VReFcAAAA
X-Change-ID: 20250220-mt7996-mlo-95e9fe30a9e0
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

This series is a the first preliminary work needed to support MLO in
MT7996 driver.

---
Lorenzo Bianconi (10):
      wifi: mt76: mt7996: Add chage_vif_links stub
      wifi: mt76: mt7996: Introduce mt7996_sta_link container
      wifi: mt76: mt7996: Add mt7996_sta_link struct in mt7996_vif_link
      wifi: mt76: mt7996: Add vif_cfg_changed callback
      wifi: mt76: mt7996: Add link_info_changed callback
      wifi: mt76: Add mt76_sta_common_init utility routine
      wifi: mt76: Move wcid cleanup logic in SoC driver codebase
      wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks
      wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Rely on mt7996_vif_link and mt7996_sta_link in mt7996_mac_twt_teardown_flow signature

Shayne Chen (4):
      wifi: mt76: mt7996: Add mt7996_mac_sta_change_links callback
      wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
      wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support
      wifi: mt76: mt7996: Rely on mt7996_vif_link in mt7996_mcu_twt_agrt_update signature

 drivers/net/wireless/mediatek/mt76/mac80211.c      |  62 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   9 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   8 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   8 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   8 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   8 +
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 125 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 458 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 335 ++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  30 +-
 15 files changed, 699 insertions(+), 389 deletions(-)
---
base-commit: ad4c9a8a980336450631dce8cc0799f9a8de1914
change-id: 20250220-mt7996-mlo-95e9fe30a9e0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


