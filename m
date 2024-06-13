Return-Path: <linux-wireless+bounces-8910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259190623A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B771F22411
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64412CD8B;
	Thu, 13 Jun 2024 03:02:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06618028
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247769; cv=none; b=LQIRAqJ4xAlplhJBvkwqxgNhmhmd4BF2JukDnl6DShdledDuLzvcSVfdgsMah6p4Vig/8OKx/WXEoNwCPAzr804CdxbJvw2jI1Ehr85MWBkctdnz80lL8r5FgaTQ2ISDz3j7n2JWxe/IxPPndJfpMmsJX8rcDtzpkbM7B5/AkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247769; c=relaxed/simple;
	bh=uWkuOTccdBiZ179b6SEhfG/8T9N9lWVQZXjc3kGSO0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s2pEqn46J0qPY6ewtTDokjSHZnjMliArHMI4RQuHKM5BZI8T6faYCjj011kI7X4WQeYqTPnyzwe6fL2cXnk3d4ggjNeNgOEUC75c0EET0nIxVOHn/wMGSE7pt74C0YxHyN5Q5Wqi0gWdTMO6nHz7Lo2OOrSOvYpZisEzfQgGW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b97f09cde3so43126eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247766; x=1718852566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjwbybjfnlPDTGv5o9qP6JskFHBy1UjXTbEViuKqIyc=;
        b=Ql3+CEU2aWuuz7+EM9ZzmP4KyTQNnixmY2u8BWRvFtpYubqNWpmKZ+BsGw8ZYgppPq
         GRm/NSHVSW7Nq+zF8Gw7sUDTUpxsinP+rWicqFjej4yG+EdPjxx3RAqONRxHGwAaBQVu
         gGH0K3gfmPoVn9zONHtvI575MDQSBGw9YKE3bUyB4OeIEOnVNYlE6dZepJ3rXMCQRP0w
         +HBNgO9Fo1tkA3GKpZhrLNYPc2MqJZ3do6M0IMBSQMJ+iZszNrwLUvIyKIc40ahqfzW4
         DKiF5vTmLbt+GNiMufYy77t55M1NeUrjh7qr9tV22695qtkaUgGRtOKRJYpHzd6bHkmc
         /OWw==
X-Forwarded-Encrypted: i=1; AJvYcCW6lOclNKOmLmgseyxyHjhGPRWsqhnMZf8fkrgGVdSXXOWWfvQwDinMMVgMCK6TuLUG9hU990vtvWr/nlgJNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxifiZPw61Uy3fLgv6dZYhTf3KqIFtGVnhkKzxzsh2mhkjbWCXn
	nuDLdyhcpXIpAq1sLWOLd1Ex0mHHrNfR1CxaGtZK9/r8ciQihR5aEb0w171/3n4=
X-Google-Smtp-Source: AGHT+IER9+Uy+9LreQRT6aeUwKH/q1c4bW65weR/CmRHz5fIl/mNx4PfWXC2BSSQSFLZkz07u24dig==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3995097eaf.0.1718247766411;
        Wed, 12 Jun 2024 20:02:46 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:45 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 00/47] Prerequisite Refactoring for Enabling MLO on MT7925
Date: Wed, 12 Jun 2024 20:01:54 -0700
Message-Id: <20240613030241.5771-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

I'm submitting some patches that are essential preliminary steps for getting
Multi-Link Operation (MLO) up and running smoothly on the MT7925 driver.

Before we can activate MLO, we need to do some necessary refactoring work.
This involves adjusting how the driver handles certain commands and data to
support per-link STA and per-BSS operations. It's like laying down a strong
foundation so that MLO can seamlessly integrate with our existing setup.

It's important to note that these patches focus solely on refactoring work.
We're not changing any of the current functions or logic; we're just making
sure everything is structured properly to support MLO when it's enabled.

I've tested these patches to make sure they're reliable and won't mess up
anything that's already working. 

Deren Wu (5):
  wifi: mt76: mt792x: add struct mt792x_bss_conf
  wifi: mt76: mt792x: add struct mt792x_link_sta
  wifi: mt76: mt792x: add struct mt792x_chanctx
  wifi: mt76: mt7925: support for split bss_info_changed method
  wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS

Sean Wang (42):
  wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link
    BSS
  wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
  wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
  wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link
    BSS
  wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
  wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
  wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM
    TLV
  wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on
    mt7925_mcu_bss_rlm_tlv
  wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link
    STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link
    STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
  wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
  wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link
    STA
  wifi: mt76: mt762x:  extend mt76_connac_mcu_sta_basic_tlv for per-link
    STA
  wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link
    STA
  wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
  wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
  wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
  wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate
    per-link STA
  wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link
    STA
  wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
  wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link
    BSS
  wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing
    fw_offload

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   8 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  56 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  19 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  66 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 143 +++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  46 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  69 +--
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 452 +++++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 500 ++++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  25 +-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  15 +-
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  78 ++-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  70 ++-
 .../net/wireless/mediatek/mt76/mt792x_mac.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 18 files changed, 896 insertions(+), 673 deletions(-)

-- 
2.34.1


