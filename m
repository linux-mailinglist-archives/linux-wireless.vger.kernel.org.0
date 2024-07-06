Return-Path: <linux-wireless+bounces-10019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB89291D0
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6CEB21A13
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2941CAB3;
	Sat,  6 Jul 2024 08:28:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B421C69D
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254503; cv=none; b=DgE8aH5r9Z78yhVUV97pfOGJHyctuGOCwDYZ5O102M+dnjs88LSArKjIOzDX7MCFUJVXY4xY8vcOmA06uRU1530SoR9YZB5lxQGrpNvkM9yN70RtBIp3QSPnAbCloQUI8P8yhjlmnlGLiNo6bYIYF52TmiYhNCsjdk4T/BbTft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254503; c=relaxed/simple;
	bh=Rsx0Hwh/pI9tKdNpuXUME7zLcaDhXROxW54gbArhAL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EPNzqtdJsj+xV4QcGdCKB2E8GfLrP8GRdWY4vmAoiJHuJ8SDXwmqwQn0pDyBpVPETvI85shNdSA3ibqry8/DZkmqnzd0ENWUE5ex1K7CwsthjD7Rlajd0qSG2a99rF9gv4/vm6CJxmroGQWNFOFPPEaNrLDSBkXDIZgzzDeUQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25e23e0492dso341256fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254500; x=1720859300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+9sCETA5CNRJA0LCGkWGOXOTk1EqLMTFhnYEilWNyc=;
        b=FdkG3xX1w8WBvhnWip+ImNDgYoPunOV2kj3tkFd4rs4nXx91+QByPCaM+9NWuiNqxA
         /I3tuGlbY2zOe5bZrZ2/RSjPGIX+X6J0ljlzH7deFtAAIi9wtNXaZud+VzRwxOwshGnk
         RKoJxEzcFpYLbWZLFfa6KtYGd+0Ct8RORDGdmi29CMLry4JcqnitIadTKtYcph2HKxtP
         LghWShuuO5qve+Y6TPPMxR+1gD897liY6ks1PRjIApWoCUE2RvmGWtqVdxjCN+nVVidX
         pbCV3h7aoUWa8WsPL1/XP/RjRt046a1dTI97aSgymqR5EyGg6EGPESZehiCTjJPVQvgr
         TT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLnnXg8zXwaz/BV+nmxxOvzqpYdZQZ6xWiPfU1x6eeMaUuypf143ULrgmk+kOuNUBbqgQcEpf7VPJ4b/s+qoHBCCaU0/kTLENBnEZdTuc=
X-Gm-Message-State: AOJu0YziamwO+qo2+mlCb1QVrCrDgZs5vBxqepHg2WjpdrdpcjmgIq0N
	uSnufav7vBbbavJx+x2vrVq+FNgR2C27g6/ctzd7LNRYK9oTKEiC
X-Google-Smtp-Source: AGHT+IFwmm+1y8/oYaoSFh2YBKxpxKSVCuGifrFXNZi9Vo4mr3Auh4YXT0ufIBJaVZv8cZHo3RDKgQ==
X-Received: by 2002:a05:6870:c1d1:b0:258:476d:a781 with SMTP id 586e51a60fabf-25e2bef2b1fmr6754403fac.3.1720254500457;
        Sat, 06 Jul 2024 01:28:20 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:19 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH v2 00/37] Enabling MT7925 MLO Mode Support
Date: Sat,  6 Jul 2024 01:27:40 -0700
Message-Id: <cover.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@kernel.org>

Hi nbd,

We've worked diligently to prepare the driver for the upcoming MLO-enabled
firmware integration in the 6.11 kernel.

We are posting v2 to further enhance and refine the v1 patchset. We hope these
improvements can be included in the mt76 pull request for the merge window.

These patches are rebased on commit "74861fbe2d25" (wifi: mt76: mt7925: simplify
mt7925_mcu_sta_cmd logic by removing fw_offload) in the mt76 tree. If these
changes look okay to you, could you please update them in your tree?

Thank you very much for your assistance.

The details in v2:

Address missing parts and improve driver for the firmware for multilink support

- Added 8 new patches:
  - wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
  - wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
  - wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
  - wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
  - wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
  - wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
  - wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
  - wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info

- Updated the following v1 patches with changes:
  - wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
    1. Update group_mld_id with primary link

  - wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
    1. Set the bss index per link
    2. Set the BC entry per link

  - wifi: mt76: mt7925: add link handling in mt7925_set_key
    1. Set bss index per link
    2. Fix the issue for setting up the BC key

  - wifi: mt76: mt7925: add mt7925_[assign, unassign]_vif_chanctx
    1. Set the channel context per link

  - wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
    1. Get the channel context per link

  - wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
    1. Set the channel context per link
    2. Update mt7925_mac_select_links to properly calculate the sel_links

  - wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
    1. Set the omac, band index per link

  - wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
    1. Set the bss index per link

  - wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
    1. Add link handling in the call path of disabling beacon filter

  - wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
    1. Get the channel context per link

  - wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
    1. Set the channel context per link
    2. Simplify the logic to get mconf
    3. Get phy idx per link
    4. Also update assoc logic to include the above (1), (2), and (3)

The details in v1:

This patchset introduces comprehensive support for MLO (Multi-Link-
Operation) mode on the MT7925 Wi-Fi driver. It includes driver
modifications to ensure seamless operation specifically with MLO-enabled
firmware environments. The patches included are:

1) Enable the link handling in the existing neccessary functions
   in the driver for MLO mode.
2) Add MCU TLV handling tailored for the MLO-enabled firmware.
3) Implement .change_vif_links and .change_sta_links callbacks for MLO
   mode.
4) Register the MLO capability with mac80211 when the driver is operating
   with the MLO-enabled firmware.

These changes maintain compatibility with non-MLO mode and the older
firmware versions.

Sean Wang (37):
  wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
  wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove]
    for MLO
  wifi: mt76: mt7925: set Tx queue parameters according to link id
  wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
  wifi: mt76: mt7925: add mt7925_set_link_key
  wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
  wifi: mt76: mt7925: add mt7925_change_vif_links
  wifi: mt76: mt7925: add mt7925_change_sta_links
  wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
  wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
  wifi: mt76: mt7925: add link handling to txwi
  wifi: mt76: mt7925: add link handling in mt7925_set_key
  wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
  wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
  wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
  wifi: mt76: mt7925: add link handling in mt7925_txwi_free
  wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
  wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
  wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
  wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER
    handler
  wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
  wifi: mt76: mt7925: update rate index according to link id
  wifi: mt76: mt7925: report link information in rx status
  wifi: mt76: add def_wcid to struct mt76_wcid
  wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
  wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
  wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
  wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
  wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
  wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
  wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
  wifi: mt76: mt7925: enabling MLO when the firmware supports it

 drivers/net/wireless/mediatek/mt76/mac80211.c |   5 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   7 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   6 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  11 +
 .../net/wireless/mediatek/mt76/mt7925/init.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  80 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 730 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 538 +++++++++----
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  42 +-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  16 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  26 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  49 +-
 12 files changed, 1249 insertions(+), 267 deletions(-)

-- 
2.25.1


