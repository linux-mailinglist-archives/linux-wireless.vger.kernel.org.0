Return-Path: <linux-wireless+bounces-30322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C74CF17A6
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDA73005E90
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAE1D6AA;
	Mon,  5 Jan 2026 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nItjd97Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE9175A5
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572812; cv=none; b=WKVJXZ1ELKu+Bw9iPht0JZ7CFg5CQu/PxEeKy0aYsEUIkw9f9HljsJ+2Wpj+DWfCZ71daS0q0umi8bvCB5vDGqpeHNkmIJ0At3fbYz1xKcG6p97en46YyVPgHEe1slrfani998DBvbPHPF7hdLIsPEPDQWexzodSMt2A2InlHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572812; c=relaxed/simple;
	bh=YvpsYJsMDkp81Cd8U/l9hI167LcSGEdyNDV0ovD8XYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azYgrvakg7W/UbK5bbK2jH6LDij+HJf1IlUtZBSmU1iBOlqQrrOzXL2Tdz0pDpFRJ9BFAbIBPCnyrBlupfJ0CJby0h3OZz99UvEP6qcxCg4vsq2cNT5XInKOK3QlLerLdGyRc3BXPaf7SF0jR2ilNGw4AGiU82OYJ1HIaUDnsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nItjd97Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c4464dfeae8so1153601a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572810; x=1768177610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGsItTLYZ1AgpgK0DoAEs/2zR0B3ANCxJg83nnOaKnY=;
        b=nItjd97QSblrAhPN5CryNqORtmHsTUoXNc+cJGrCdKCfhdPnZvCdytqZvJO6fkSgY2
         9gXLJ5y3RMRvUOEbDUH0UwXOXN5ZEDV3DBd8NjsUvUC5WIDvsDBPMN8XD2jANef/AH0+
         Ou/jUgpdLT/3zQE30YdO8BGcf0vLZYflBKQOKJn6rcJCBP6ScuoV+uya3DeKV7P74QAY
         X4jYVPev/rnUBIb2zGvZ+IXjHgse1K168QFx3UsDmIeSLY6FrH/5Y9SV8h9tfDyJtWk8
         e9ket/HxeXVgO+5pVu3cInheuiFMhh6n+8xUrhVDxfJpA0Lryklok0Rl9jn+eef+0dxz
         OxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572810; x=1768177610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TGsItTLYZ1AgpgK0DoAEs/2zR0B3ANCxJg83nnOaKnY=;
        b=JBJfsTYhulwuZDmLY+635aVOyOewV+T9akByjRMA4ohN6bOPUJdh3Z2Udp1ZhVu7J+
         iDo30PruDH+Xu4vHaT6zzNRuXonjJw/c9G8wR0RfUwsO9WYb+d6L23Agy1bIFpmcdLOw
         N8dTLExXdTN5Gy0MPuLsPLARBs5dajqxXqYGWDIFN5bC1IPtpaWMwN8/jnPxRIHlxpX1
         VfTg/BITZKpQgvJmskrQdqUGXpdWFcjrMwMRnnfnFr062pVdmB0GUin+zvlMoj/xQIW8
         l4bqNuUJVqCMNbgD/zwni6A1scghiJCu1ryCJaxUJj6lJJLD/YiueVo9PFaKJHgVkyYg
         t8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWsA2jW03Dns3ujPvVnwNhbnLM92OP47Czcg7C3DPThRJo41hZkZyaSUh7p9SeQCRWDv1yncFKH5w/hoM+q/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VpjtaBUdD6UAJoJcZ1wlzbtJotZ8JPGdfNTB15Vfc+tk563F
	ls7S33MjFPfupwScl6al0AYSGMnnUNS7S2rV6RyHcCFQW4wGwo67Y0Fj
X-Gm-Gg: AY/fxX4Yliy16mOY2h01RqiHiHcBYPQWPyeSimYVpS/cotlEsj5H1k8Icrc6i/d5EuI
	ZEG10QX85pFwcVYYphUnrUNmQtIcThfADtULeqaRlkjhY4zsuOZvE2dOGX7aNXUgieDeKktQ4ZN
	05yBUUuBly4Oi3dL/DhBBSO0YzvYe+sTktBlwo5pkHo0ALTPZZbXJ2ENau9XzjC1/KRrv5yzxpa
	donTf1U/no1QGZvL4urrwiyyPxfyy3vkSYmeOrr81vGsDVoiu4Xb251x64+u9eT3I79rEh/nPdV
	7p1pfbYK57z7y50BamIKACAjaLJq0FhSjKcJiO7ZqBf5gd1H7FyjUjIR1Yi7GJr2hKRBG8uwMza
	Qx30ZKiaAlJ8AyPc0n+59hf9niNt+gA7nVZWaoUp6cVDHxxPpysMGwX/fHHwOZRzSZBFpgVuDx+
	h7oJbteVB0oqnAQcHHY1XWMk1uN2fe8qHmlKw+gmB97hqMdKkpnCbnmIjf8OXA96iKKVGyGNVjj
	Q==
X-Google-Smtp-Source: AGHT+IGUlMoLAZTEdBS6DMTK8EyIRJTt+D9XZZtlYRD44utmmdlWurYUMUg/4PMNfp15VP8DPQf4tg==
X-Received: by 2002:a05:7022:1e13:b0:11b:79f1:847 with SMTP id a92af1059eb24-121722b44bfmr31712624c88.12.1767572809919;
        Sun, 04 Jan 2026 16:26:49 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:49 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH v3 00/17] wifi: mt76: mt7925/mt792x: comprehensive stability fixes
Date: Sun,  4 Jan 2026 16:26:21 -0800
Message-ID: <20260105002638.668723-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102200524.290779-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This patch series addresses kernel panics, system deadlocks, and various
stability issues in the MT7925 WiFi driver. The issues were discovered on
kernel 6.17 (Ubuntu 25.10) and fixes were developed and tested on 6.18.2.

These patches are based on the wireless tree (nbd168/wireless.git) as
requested by Sean Wang.

== Problem Description ==

The MT7925 driver has several bugs that cause:
- Kernel NULL pointer dereferences during BSSID roaming
- System-wide deadlocks requiring hard reboot
- Firmware reload failures after suspend/resume
- Key removal errors during MLO roaming

These issues manifest approximately every 5 minutes when the adapter
tries to switch to a better BSSID, particularly in enterprise environments
with multiple access points.

== Root Causes ==

1. Missing mutex protection around ieee80211_iterate_active_interfaces()
   when the callback invokes MCU functions (patches 2, 3, 16)

2. NULL pointer dereferences where mt792x_vif_to_bss_conf(),
   mt792x_sta_to_link(), and similar functions return NULL during
   MLO state transitions but results are not checked (patches 1, 4, 5,
   9, 10, 14, 17)

3. Ignored MCU return values hiding firmware errors (patches 6, 7, 8)

4. WARN_ON_ONCE used where NULL is expected during normal MLO AP
   setup (patch 13)

5. Firmware semaphore not released after failed load attempts (patch 15)

6. Key removal returning error when link is already torn down (patch 12)

== Testing ==

Stress tested by hammering the driver with custom test script.

Tested on:
- Framework Desktop (AMD Ryzen AI Max 300 Series) with MT7925 (RZ717)
- This whole patch series was tested on Kernel 6.18.2 and 6.17.12 (Ubuntu 25.10)
- Enterprise WiFi environment with multiple WIFI 7 APs with MLO enabled

Before patches: System hangs/panics every 5-15 minutes during BSSID roaming
After patches: Stable for 24+ hours under continuous stress testing

== Crash Traces Fixed ==

Primary NULL pointer dereference:
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
  RIP: 0010:mt76_connac_mcu_uni_add_dev+0x9c/0x780 [mt76_connac_lib]
  Call Trace:
   mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
   __iterate_interfaces+0x92/0x130 [mac80211]
   ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
   mt7925_mac_reset_work+0x105/0x190 [mt7925_common]

Deadlock trace:
  INFO: task kworker/u128:0:48737 blocked for more than 122 seconds.
  Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
  Call Trace:
   __mutex_lock.constprop.0+0x3d0/0x6d0
   mt7925_mac_reset_work+0x85/0x170 [mt7925_common]

== Related Links ==

Framework Community discussion:
https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-nullptr-dereference/79301

OpenWrt GitHub issues:
https://github.com/openwrt/mt76/issues/1014
https://github.com/openwrt/mt76/issues/1036

GitHub repository with additional analysis:
https://github.com/zbowling/mt7925

Zac Bowling (17):
  wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
  wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort
  wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO PM
  wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
  wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
  wifi: mt76: mt7925: add error handling for AMPDU MCU commands
  wifi: mt76: mt7925: add error handling for BSS info MCU command in sta_add
  wifi: mt76: mt7925: add error handling for BSS info in key setup
  wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
  wifi: mt76: mt792x: fix NULL pointer dereference in TX path
  wifi: mt76: mt7925: add lockdep assertions for mutex verification
  wifi: mt76: mt7925: fix key removal failure during MLO roaming
  wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
  wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU functions
  wifi: mt76: mt792x: fix firmware reload failure after previous load crash
  wifi: mt76: mt7925: add mutex protection in resume path
  wifi: mt76: mt7925: add NULL checks in link station and TX queue setup

 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 27 +++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  8 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 95 +++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 52 ++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |  6 +++
 5 files changed, 170 insertions(+), 18 deletions(-)

-- 
2.51.0

