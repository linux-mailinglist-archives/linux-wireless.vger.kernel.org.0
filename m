Return-Path: <linux-wireless+bounces-30300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DACEF43F
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64B2304794D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6531A046;
	Fri,  2 Jan 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBheiQ0h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CA31960B
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384205; cv=none; b=bXSiWVelHd05sJ7Afm0zwEj7ZI7GtdxzSR0/TXvGgoA7+8AEApIh6XZd2a0Kpr2pdpTvFuUnZSumx2Dd7b0UFrepX/A9f5fsQmj0uph6h2jMweu4eGphImAHxwk5O18pAN18nU6KxqmnirJqjU8HGci94r57hQipCXZaxcTgsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384205; c=relaxed/simple;
	bh=8xalLFN09boRABPZ8yoH2d7b4fV9SjQeAwgCs/7XUO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs6hrTUyYajrgGB3gZ6tzJMm5m/4h6CgqGuv+gG61xmOMNXehT3nXGQyowtrTkVh6/GPE0PdHSLctTlYEssdT10q4ykSUVgI3fw70PU9G1c9Gau1aG9DW+JCkgoHtSFlo1eLK8hPHU4Y3VA//kFWaaNerRHSojUhn3Yhay5qsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBheiQ0h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29efd139227so162590555ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384202; x=1767989002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7qZYSeLZChIxDrw/4tv0b/VSzAX1CnFXje+sP60SRE=;
        b=MBheiQ0hPjFe54Xr0DtZcG9Lo2oWofAENSs7+s/oYLI2zLqzUjRkZndFJ+S6/c7nLK
         LtTN9Bb4V0krPYNQPb7R+o0y3bWMOwVYemTho8+JkwLqZgIr+PxN19NR9xh/e3Phd8gF
         1x9g6A5GWpCsLvsppcCwUV3Mxkp/AdL89MGuv0UWVf4YgYR9OSmCsMkYRZ/0k5Zaq1hr
         XPncKEpUJ7Xp2xCSA6EIglZCLCk2/vc+b8usITZ4ohjJ08JJvIF1oMVlwyQtrxF3Ez0J
         e6kXhLECJT9isM/edjfYbpnzigftLbSxO/ZXaYchbx/0IwMtGiyZDmBFbbU3LuYSDCP1
         285w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384202; x=1767989002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7qZYSeLZChIxDrw/4tv0b/VSzAX1CnFXje+sP60SRE=;
        b=hPR236kbKJxPRJVQ5r/NQ3nMHAeT6oMbwSpOWtSIiKf3lwNEkDeuGWXmJet0WYSTDU
         7EDlQv3+rhKpeIg/RXQxr/7caENlHKr7fU0XRUenjKBvVDHSBXCB1prZQTZVvbf9XsHN
         IaeTSQo4jLP/O0Nbprx+9vefOPpYTjnvSJ6gFMMl0MUieboOh+d5BAGxMwLl+tmUYfKq
         FWFyoc8DjvOMPSK/GPAWgY5O3gI4g4NJdc7PIOeYpCFJc6jSPI5Dhio6vpDAw+nqQZQ0
         9ewwL5oSknUpkp/JseK4HfLE067epuN0VBpQASj3tRBUnNj2UxKLmyq24RZoMYuFxy9R
         9O+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOEtemvav2cWU+2X5zfhJijxWqztkxQ3WS5IZLec1F+4qXvOjJYPaw1gMPeuDbgqzkSs4g8oruMkSJsdbyRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QyCPBdVoeQZ7ZrhRAustwgRwINwJYxHdr2+03twTxloRiT7d
	4V6jjhgzoKXxx94P5rMs1+87yuOF0CiUNSVsY/OL8vlVdZDtgmYTyPXi
X-Gm-Gg: AY/fxX46c1ZYYsJP4n2FPspPLJeL6r3m/ca5TFbVFVVMx2XD+27cQP/mBGRwAsj4C/R
	qxX9+XbrzSIG1/vvk5wvw/jKgO9wgrrZ9a5Wck3yB6VEQofArvWqNDMeAidfcVe8LW6VpQg/j2D
	NYN465vs9DfH5ER0lBfIusL//rR6eQTYZN/vfLdddeKsJPc2z5MrC8+0kVpeO8UUs3gcsG4fxIe
	1tFr65j25vxag8AZqun7ClpItOk2A40Y0bJknIXXF0ANVZiTAPBg/kLDfBH79f4nueEMbrhTBaX
	H5JH2dWtgQe8lWZ/2Eome3pBOxyRj937if/LGbHspxJ65o6fQf2BQJ3IdoCzv/hnLE9oK0nv0GM
	BV3XhlZelTgS6YGBbn7X/rZhnl3tSByrRfSJQM9cNsZ0DKsggEQtXtZQXWcbvuQMzc1Po+QJNX/
	EX0n7oinEX/Fck3Y5NxIYZnA+97tg2iT4NC3Uv5MMPXix6wIspVrgWGkym3ur4l0w=
X-Google-Smtp-Source: AGHT+IGGD10yYGQ2fi7EjrvXcQ2RpewtLBipkaRDvFeki8yg8+BUwMUf7qrB19+RqRFSHDwFrqgGrg==
X-Received: by 2002:a05:7022:6199:b0:11f:1e59:4c2d with SMTP id a92af1059eb24-121721acb6dmr36824686c88.7.1767384202231;
        Fri, 02 Jan 2026 12:03:22 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:21 -0800 (PST)
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
Subject: [PATCH] wifi: mt76: mt792x: fix firmware reload failure after previous load crash
Date: Fri,  2 Jan 2026 12:03:13 -0800
Message-ID: <20260102200315.290015-5-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102200315.290015-1-zbowling@gmail.com>
References: <20260101062543.186499-1-zbowling@gmail.com>
 <20260102200315.290015-1-zbowling@gmail.com>
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

Apply the same fix that was applied to MT7915 in commit 79dd14f:
1. Release the patch semaphore before starting firmware load (in case
   it was held by a previous failed attempt)
2. Restart MCU firmware to ensure clean state
3. Wait briefly for MCU to be ready

This fix applies to both MT7921 and MT7925 drivers which share the
mt792x_load_firmware() function.

Fixes: 'Failed to get patch semaphore' errors after firmware crash
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 mt792x_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mt792x_core.c b/mt792x_core.c
index cc488ee9..b82e4470 100644
--- a/mt792x_core.c
+++ b/mt792x_core.c
@@ -927,6 +927,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
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



