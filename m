Return-Path: <linux-wireless+bounces-30336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D838CF1806
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136C33026B0D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854A24DCF9;
	Mon,  5 Jan 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMGnZ/cT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3E7640E
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572831; cv=none; b=JaJM1nCvhM7IpudIMxcI/aabvO53YYYsYGfwgzekI/H557feCAd54wS1CT2dfNTyhOFTuyfGpMaKUvibWv0KmvYpBNGA1Pkrs/mSMZmbzNhCIJpzJP5PK2JbMXGS6+J5DxQ72n8TCPSCRM7DkCtPgOk0cDulwvAusoTvZ2HeXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572831; c=relaxed/simple;
	bh=3BGhu95nJ27lYH43BGIMR+sgNyP0MZttqBXOand+UeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1p6pngSZKuz+SM05+u4bXVwOZfeTEVslHQg5rcyfXnQAnmNSN0kv6szAe1QNltZWXrJwccyiYtL282PcWO2RQ62eZeBxMmJa9kw2G7VyNBjJDSVFD6Od6896VcgKfoUWuAMl2ma+wbhePioNAfVlKbnpQDHL1vOif/3oOcUlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMGnZ/cT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a099233e8dso113556075ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572827; x=1768177627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJjfGhYzMRnwgUAUKvlNtXxtk0atD56wzBEV6PIqpWc=;
        b=fMGnZ/cTJ9rXJcdQmGhnSwBIFeGKDF0I54sh/2akOMmMRq2WLGqJOFUdy3EsLrAY+T
         I0xjelcKsMYle74Lkp5ZkG9QhHBU7FXck7f4Xy+gDn2zAvY/yHPPXUmehChurvWdB9AC
         FzmYH+PfRSuRF3UZCTwzGpONDlZnhLHAh1HF5qMJGmuDSzuvwshHaJxs0JhdnjNF911m
         kMZdaO9C46vv1IK2IA4h0JLqMHKvvj3bbh1iV5UAvOSgqbwbfBdu4e1B4GosDNDWIHRT
         3ShosIH8UPEdEnbxTTAL8Dk9IRyQLcQhnA3aJYo0bzVVEOZiu3dhh9+9m+t7s/QdQLtZ
         jGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572827; x=1768177627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJjfGhYzMRnwgUAUKvlNtXxtk0atD56wzBEV6PIqpWc=;
        b=OvFWwVacF0Krl5q1boQgm6kMSUO+71Cox2xd/pFZf0rzMRo0df2uUSw3m9Qynemukv
         gYUwebPyzud6xRbQJqpp333cXOK4le9YmhJJktT4HjA0vmzLKz7EH4xLtzk1uZP9Crxn
         XtVWJOQDMpz11iq5CnncX8+KW2G9NkVECsQCumTXb9frYDw8brM4IiyaJLaO8Ta1Umct
         jTaHXkfg9N9TbCbY7PPquzaUSCAp2JNi8dqXoeSQKse+bFeH5UCcYIpoXbGxyL0XSZYo
         IScTamYOwsuGHBIR8tNV8bktZAFraUzGJiuQxMxAvAm4Y9uu4f9Hekf2e+zWhGz4DCix
         trsw==
X-Forwarded-Encrypted: i=1; AJvYcCU5NhXrrd17zDYEQZ/5T84n9baT9CwwiVYz0bnF0AuzlKAiNNnrcGm3wdrfpCg/Drrt0gRuZIujgFceXXfkNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw662Bxs9aSIKw95LYthoy5jUx8txVNQrOUSxsPoynMFVa6USf3
	dFgoXfvso3/MlOI8AkwPay3qc+slmV5zkG3GjxT/M+Bm9E+OccKeCJmJLULDBdKD
X-Gm-Gg: AY/fxX77jE4wEThjcb6hs84tiTBKwD3exG3Nzf4FmcSuS6cXi2/dOOzoeJUng/U0jWu
	aZoHjLCJknSVYG3xj3rmhJzQetaigAu2warsEaTQAA6bVG1ek4SNfz3Qb4qxImyoYK5mUyOi4gr
	kS3bB2b5a4VtpGPIeaQ1Lq8No9Bd16OxWXWzL8C2fWSNGhsgJnd9HgNOnnDgrjMruu75x1mVJnc
	NofDJzkG2qtMwNutl/p6N8TfaCXqWBTLG/RIdPtASTDIGJsD/ja/CTEryMl51Z5zCPI5iVzuC8v
	Bory5QP6ZC6c5C8BzbaTf3fZcQFB50/MaKmBa+5igl/DgGMHRNQ2KRIsTXXAR2LPBKgHmr53WpR
	xTCuQ/uj8WiHpv7Fb9pXb+c11eptUTzPq1ACRI155ok0VuzcJPJtsPqfsI/3Pxz3DTbH00wOoT3
	cDTQMpUO5gpuOxU1LEE0yRlh2YjwvczgNEIwEmLhEjUC1HCgH0lOvKM6V77Eshdvo=
X-Google-Smtp-Source: AGHT+IEgwdZc2sv9zKx5KjMOni7rSof10mVUH9VaD1BavVlI4TZ/Co6GlilKA9YVOKhSaEIPSjDGFQ==
X-Received: by 2002:a05:701a:ca08:b0:11b:9386:825b with SMTP id a92af1059eb24-12172302a23mr38511025c88.48.1767572827042;
        Sun, 04 Jan 2026 16:27:07 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:06 -0800 (PST)
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
Subject: [PATCH 15/17] wifi: mt76: mt792x: fix firmware reload failure after previous load crash
Date: Sun,  4 Jan 2026 16:26:36 -0800
Message-ID: <20260105002638.668723-16-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the firmware loading process crashes or is interrupted after
acquiring the patch semaphore but before releasing it, subsequent
firmware load attempts will fail with 'Failed to get patch semaphore'
because the semaphore is still held.

This issue manifests as devices becoming unusable after suspend/resume
failures or firmware crashes, requiring a full hardware reboot to
recover. This has been widely reported on MT7921 and MT7925 devices.

Example error log:
  mt7921e 0000:c2:00.0: Failed to get patch semaphore
  mt7921e 0000:c2:00.0: probe with driver mt7921e failed with error -5

Apply the same fix that was applied to MT7915 in commit 79dd14f:
1. Release the patch semaphore before starting firmware load (in case
   it was held by a previous failed attempt)
2. Restart MCU firmware to ensure clean state
3. Wait briefly for MCU to be ready

This fix applies to both MT7921 and MT7925 drivers which share the
mt792x_load_firmware() function.

Fixes: 583204ae70f9 ("wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module")
Link: https://github.com/openwrt/mt76/commit/79dd14f2e8161b656341b6653261779199aedbe4
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 9dc768aa8b9c..05598202b488 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -936,6 +936,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 {
 	int ret;
 
+	/* Release semaphore if taken by previous failed load attempt.
+	 * This prevents "Failed to get patch semaphore" errors when
+	 * recovering from firmware crashes or suspend/resume failures.
+	 */
+	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
+	if (ret < 0)
+		dev_dbg(dev->mt76.dev, "Semaphore release returned %d (may be expected)\n", ret);
+
+	/* Always restart MCU to ensure clean state before loading firmware */
+	mt76_connac_mcu_restart(&dev->mt76);
+
+	/* Wait for MCU to be ready after restart */
+	msleep(100);
+
 	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
 	if (ret)
 		return ret;
-- 
2.51.0


