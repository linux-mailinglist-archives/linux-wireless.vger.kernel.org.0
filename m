Return-Path: <linux-wireless+bounces-9940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFE926A89
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575AB1C20BD8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A81849C4;
	Wed,  3 Jul 2024 21:42:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB517F51A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042968; cv=none; b=GqXotjWf5GVRPivFW0OpPBrxnzcIrCcxMsjj603LQMgbq9176LVzOoi39/Z2oWqOtsrItz3ssUZZ07kv5GkYb4v0bJlktt18H55FPcFRGpsQ3t1FxX2eQDlYDRT4QqKy/rglSqIEadb2fksWT5nxmStJh2tJxMPzWh1rYvHbeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042968; c=relaxed/simple;
	bh=DTBo5RbdhV/xl/R/PbGjiOOSH131YWBasqnJrn/B5eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KycFdGIySvfHk1mgLo0nc06+DQrBAyfSRczX0WmdCqrksQjgO6qD6OvTuPcZ9xpg5HCvNOJhh8CL98fzaUUuq82bAtSv6cfowbXwgnl9Yh045Nkl0TaE0bPqE4O/Ra0ZchTCr3R4ceNGUOpP11HKeBWZSwsQGBnlPr1tE7MaHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-700ce014fdbso82567a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042966; x=1720647766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU10Slj9rAnvBK1nq0gnwTI6g6o8HVgf6xfWPzjhhDc=;
        b=klRNTRUVNBaWqVKNFJGT17I7wfVpVHPS9D72votIhpjS+M6WFpzSUuBj73X1piyfPG
         ztehWs8Gt7MF/LEC9sMjj7rlSjAc/2z+Db6l0vK15dwTxo5uoD8K/2JLlctKZ9IEgfAZ
         4IE6/5Dr61jf81YHWAN7ZlhTEYZcmxpri19rhh9g74AQDlfiEj0v/ZtV8IafQrssVcJ9
         KVYECZ+MU3r2/CSdJX2odTOODJ0jMgnfS6il+oCpLUvgv3MU9wCn8bilYWSQ2fWX/4mx
         IGJtjuIED9NmvnbXlnVNPevo/PDZODxc4fu0yAewK7VzOesEQTcIVCKa6D7BOwxtruyk
         523Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVaCHQgzA63+Grwj/tCMsbdnHNVEZvtmnPgnYt8V3cIOVif/0FIXRBcW5p1KLcEEkp/6bBKUGOuCq0IMTsns74K75r3EyzeTnm6/3aVMs=
X-Gm-Message-State: AOJu0YxcRY+XJKJvQmTSHK6iSUAPDftZSoKedWMHMSv2WMAPctSR2QfZ
	IRXbCz9aV/GXHFfv6D2SfeG0V3loNJP7IZFF+XhErdWR3qDgNQMz
X-Google-Smtp-Source: AGHT+IGs9LjiOOX50n/PkLYnHZ65tqk8YD1duswUnhyNDzZ1E3riWbqCJWGulMSNkxlMUIwgmwKypg==
X-Received: by 2002:a05:6830:45aa:b0:702:39:1fbc with SMTP id 46e09a7af769-70207726e80mr11937436a34.2.1720042965736;
        Wed, 03 Jul 2024 14:42:45 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:44 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH 00/29] Enabling MT7925 MLO Mode Support
Date: Wed,  3 Jul 2024 14:42:05 -0700
Message-Id: <cover.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@kernel.org>

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

Sean Wang (29):
  wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
  wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, remove] for MLO
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
  wifi: mt76: mt7925: enabling MLO when the firmware supports it

 drivers/net/wireless/mediatek/mt76/mac80211.c |   5 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   7 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  11 +
 .../net/wireless/mediatek/mt76/mt7925/init.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  66 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 660 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 397 +++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  40 +-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  26 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  49 +-
 12 files changed, 1134 insertions(+), 148 deletions(-)

-- 
2.25.1


