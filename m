Return-Path: <linux-wireless+bounces-30296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E636FCEF421
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1061F30142F2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08F1E5B9E;
	Fri,  2 Jan 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw0YEU5u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BF1E0DE8
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384199; cv=none; b=sfC/elyeFiLFEPDmOhG9APWG6xNiRUW1JAPkGKZMRPUh672mho9BjStNXz4luK4DvkPVjGgV4O5xUdisdp7062v04kz8tK9/YQfexA33x/S3EcxkNm+URWD8rs0eo7IZI7ioZcEmyw1d2H2/ShrvXontp2xOHut9bszNrL/CltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384199; c=relaxed/simple;
	bh=FhTQfE5bOzE5tdi4tp88giNIsjXZ5M7QxgyGKV5uYQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/YA/2ixTu2cQGsHviUBz/qlkP5/fMQ82Xpj2FF87XpVOL0uunRvKj5S/BM7aZ0dvhVmgQqchysBO++WtRcKFYw7UBJ4DKmb8rFTPLRrx4LggofuvX47RUGHYOR+zyWdWctnkO5n3YINLRwPjImNdDSAe85IqUbSSD2CmclWmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw0YEU5u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0b4320665so191206975ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384198; x=1767988998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G4ImuRF3VbvO9uYx7tT0KAIoCmTeaN1WiLwF/Wm090=;
        b=Pw0YEU5u7RO27uqwyS9N3Un2ggi4dveRqVzIZyMPlKDBd/JWY4lWWoIFgZL4CqUbpK
         0pe6SwjOhRlu0Z3X3dYB/S8R+C+MW8KeHJTDyW3O1B3RI85oe96CacswKu3hjYL++WZI
         kflzcrPwLfUF20xt8NeoPxaTKTuokc74z+RapDCYCcgbO1ychEFuk5PS/Ndku/cAXZnf
         9/ztvn4hFfWL/z/DUN3dDfDxQmbg4yXaBFTe8wXSMEYW7tBImc3wAEGJP83aAfkmOI1U
         xCvIZYzfsAgRRwchYUFyBMyYd5p1xBqcgskcRSQpjSMAZIAhs8QPh8f4Sy7anMc6eR9w
         Gk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384198; x=1767988998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2G4ImuRF3VbvO9uYx7tT0KAIoCmTeaN1WiLwF/Wm090=;
        b=RnZBqpqv3UbGR76/EntIHmr6f0vgdwhb2G4poDI0bM8DMNyeksoSzfhNNBUJTp9+GA
         DIKCOYAQhtvpdW8oW0zyHkzIOnMS91umxK6VrkCRWTCuWhN1DsRrzXwX9H6GphbQRSrF
         emOq1cDJS0Y/6Kfzm/7NT9GPSwM9ZVYzhwlOmyEor4kMgOAjz+CPiTMZ1IU7sbegX0xs
         akR5sUULhq9L2P0kzdZGDfJP0OQsMG8vF7+GSp28SWjdxjyfUUQOV/D5B28YNvid2Xm8
         y8CvGv2ddyYA1GHKlPfGtagecBBpwsW3ZNX6GOvZJeOZu60j8F/o1JJ9VT8Etn4OSEYb
         z1HA==
X-Forwarded-Encrypted: i=1; AJvYcCX8VoawJPAnIBAdIIvSVnivY82zk9hoGFJ9UKzM+o4cXNkpsp4pr1nZWNjIRqsEzoQ4vSoA+/RNPL8DWHLyYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dDTydbVhSWDQ+dJsG038dwBbjjTLlg5WwO8xAtLKB6KUlepz
	t6XHOTHdjf6lxK4iFkW+hGvdGr7/apkTsaHHRcPxaF3RO+DbkF54DGf9
X-Gm-Gg: AY/fxX7Tz0Ox13O//1AHLmngLu+toXwQ1hJm40CnwZNFwE3FRisBaK7KG9YRrqsNH8H
	JKey8udX7FGuSh53qdkdsSfGQGhZOG5QpMU341NbcQ1mieaTC8RsfWY4VQPxDHEz02ybgfGKaEG
	hKOXg4cAjM/9Ldm2UwvZynSNCQe/Qu0/Agn2lJ9sPnDXTLeNKG24B2Xzm0JiEh7NJighF0HkJ76
	HnUPzTyqTWr05adpMZ611/8lqso7j4WQPhh+zoghTnW06vxlKVj1785uNr1GiLd2gBG71OxToBs
	pqVMuIhc++bIuKy2FPgEs08Zyuy+lEB7JI+HpBBZ2RzdXgESoj0WwBXEyOhq1onFqcmdZ4g3pUy
	nYRg8WIBddjENzdo3WjsmgyJXVgBP5NuaeGzCjaaq9ZGoSfx25aeLuwFMU5oWdT2rw2eF9dQY6j
	v44nBBeDwCbREcDhe9Z/XnAubnHD2olhE0bFWKlwO1z7P82tAFTHMcm/nf5oH4ieQ=
X-Google-Smtp-Source: AGHT+IFKqvVGthWN24o7nYHTavjyGNiAOtKDNOq7RpmLHmYQZqv8sAIrpZUOjEgpt+0P2SSiW5Emkw==
X-Received: by 2002:a05:7022:608c:b0:11a:273c:dd98 with SMTP id a92af1059eb24-121722b50b9mr40737332c88.20.1767384197392;
        Fri, 02 Jan 2026 12:03:17 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:16 -0800 (PST)
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
Subject: [PATCH v2 0/6] wifi: mt76: mt7925/mt792x: additional stability fixes
Date: Fri,  2 Jan 2026 12:03:09 -0800
Message-ID: <20260102200315.290015-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101062543.186499-1-zbowling@gmail.com>
References: <20260101062543.186499-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This series contains additional fixes for the MT7925 WiFi driver that
address issues discovered through further testing and static analysis.
These patches build on my previous series [1] and address the remaining
stability issues I've encountered on the Framework Desktop.

Changes since v1:
- 6 new patches addressing MLO roaming, firmware recovery, and resume path

Summary of fixes:

Patch 12: Fix key removal failure during MLO roaming
  During MLO link teardown, mac80211 may request key removal after
  driver state is already cleaned up. Return success instead of -EINVAL
  when the link is already gone, as the key is effectively removed.

Patch 13: Fix kernel warning in MLO ROC setup
  Replace WARN_ON_ONCE() with proper NULL checks in mt7925_mcu_set_mlo_roc().
  During MLO AP setup, the channel may not be configured yet when this
  function is called. Return -ENOLINK instead of triggering a warning.

Patch 14: Add NULL checks for MLO link pointers in MCU functions
  Several MCU functions dereference mt792x_sta_to_link() and
  mt792x_vif_to_link() without checking for NULL. Add defensive checks
  in sta_hdr_trans_tlv, wtbl_update_hdr_trans, sta_amsdu_tlv,
  sta_mld_tlv, and sta_update.

Patch 15: Fix firmware reload after previous load crash (mt792x)
  Backport the MT7915 fix (commit 79dd14f) to MT792x. If firmware loading
  crashes after acquiring the patch semaphore, subsequent loads fail with
  "Failed to get patch semaphore". Release the semaphore and restart MCU
  before loading to ensure clean state.

Patch 16: Add mutex protection in resume path
  The resume path was missing mutex protection around mt7925_mcu_set_deep_sleep()
  and mt7925_regd_update() calls. Found by static analysis (sparse/coccinelle).

Patch 17: Add NULL checks and error handling
  Add NULL checks in mt7925_mac_link_sta_add() and mt7925_conf_tx().
  Add error logging for MCU calls in mt7925_regd_update() to help
  diagnose regulatory domain update failures.

These fixes have been tested on a Framework Desktop (AMD Ryzen AI Max 300)
with the MT7925 (RZ717) WiFi card. The system is now stable through
suspend/resume cycles, MLO roaming, and firmware recovery scenarios that
previously caused crashes or hangs.

[1] https://lore.kernel.org/all/20260101062543.186499-1-zbowling@gmail.com/

Zac Bowling (6):
  wifi: mt76: mt7925: fix key removal failure during MLO roaming
  wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
  wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU
  wifi: mt76: mt792x: fix firmware reload after failed load
  wifi: mt76: mt7925: add mutex protection in resume path
  wifi: mt76: mt7925: add NULL checks and error handling

 drivers/net/wireless/mediatek/mt76/mt7925/init.c |  13 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  19 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  45 +++++---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |   2 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  14 +++
 5 files changed, 75 insertions(+), 18 deletions(-)

-- 
2.43.0


