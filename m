Return-Path: <linux-wireless+bounces-30251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E713CECAEB
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 00:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C23C630102BD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74825C6EE;
	Wed, 31 Dec 2025 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdEmJUjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2981EFF80
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224798; cv=none; b=PuQcyQ97fLp3fPilB9ncwkNzdbQd+K2a5DfGlde0Iwvxz3BzkoLn53kcoReI9zXkXHrTLY1iMy/c5ewfH0tnwZemRFxhaJgg9ZWoSxzFWBzM5DoZh0Ck3TeywTDN4ndKiscB4htayRayPYnk7k3uvjrbkkSzUOdID3bKVpk8l5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224798; c=relaxed/simple;
	bh=MWL/eF5/iegDIKlHPGSEIEhG52xmBM34mqqyx/kIhm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fV7cWM81MvMbA23tRnQPAVVZlaq/LZ5RlnFsB32bpokqSWhM2aUUvneT4/kz6EnmcE4JYnGDYs4kNv2kgX7p9nOiY+jvutmyuidzCUddlW3twC5fghYJawUagYNXvRgklLkmwwfYwewEOE404fPLY9r9FxHawbTqv877oBC+kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdEmJUjk; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7c6d13986f8so9290431a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767224795; x=1767829595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lECKX6HYn/UFgYHW3Lep9ULLvDa097/tngl+1jpf04=;
        b=ZdEmJUjko1si9FrQp6ZuU44K8tQ2QA0zGm58CwGGsij2pQpK1ZizNiZCvNc4/cVLwO
         EALs4yKtR7AUrlBpsqhMz6cU5X442Be77NZiXV1pMnxjaY8n9cbk2BObXZ0h8dU2KWCC
         68MPucIDVmE5yoMRUe3a5bcTXkAAmPkV3F0K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767224795; x=1767829595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lECKX6HYn/UFgYHW3Lep9ULLvDa097/tngl+1jpf04=;
        b=k1MTz2TjkH0vs2f9SvmpvwpA6FRFNQXH2/0kFQZe0spMqFZIot2MQ8ckfJUhMuMjzC
         SqIDoi7uMm2sWSbNz+5s4DIGh33iVRdNfe8BpSynlWuWE3U+MOi1FvhfeD1rmav2rIWQ
         8SZ7sUnaptfjp8fXaIORaft6tV1dvE8ZfSnKBRcPvFZbXRaIWfs5Ao8/qVqOKmYQUGR/
         IZi31jHkEjCuSBZ5yY6dPqj2jEm7ysDjDL7X1fwuY1YZP0AUCXHab5+1iCPousKzs7JK
         Vys2PNpMuKPwVOLIgWg5VvWHSLRQ0b6ihKavICKCchchlRWW9sN4f9CEr5wVZOBtCE26
         h8Og==
X-Forwarded-Encrypted: i=1; AJvYcCU5+rZZkThHbpEYwb+Bl/80m3LWYWW33c1BbWvIhitaPDFyopi4P/rdQ7ICxIYzfh6trJWZppjGznkgvZxLEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWCuIpEGzCev3QFebYHX+VABFgR8oRHwNvVFwn35NuiyDAZqC
	yHbl0WKl/u2aCQUNKljPS0OSFyluGDqycjWX9TucrSQkE2KeBJ5b08ZPwlI90FOOrmY=
X-Gm-Gg: AY/fxX54xjnuAb7sVSXCEh+xZDGuMRLBI7Y1euK5vB3ZW1G7TYyYyB0fMaxDoe2zpp0
	JwxDw6RhMbSNNE3tRp2MB1LIybp5KkA4p2oJWT5Ghwc5fBWoPW2CTFpGbwTKnlI8v+anUtwNuVO
	WhAfmdClsTXm9JW3vGDT6SNs9QB7kbEAQt08Fxd/2JJ0dDFQNlk4L6+ZydI9+jVtnH4PR85w4qr
	KvNOL0thzfpztKvJIp8lsZGVDJAK+OaxDh5C24kpVXXyu/Bp4Ts+WbkH248qX8uxKxVPGBAeDAw
	mRtxWxqzFcd0Do6O1BP+zdg9Xk2Cj4poA5W5uKB3fvGTT+wdEftz1kWfO6xVcNcfOkHinuYwdAC
	qwRuq1BjBLpTSdnaY2dhpns3zL44z5iJJtHn35B79JEXYac4CIxnZplmuB8+CcEiIqDrkSPH4Uk
	5hzXmDPGVx5g+ywcGCe72e6QyjCG7WvVB7Dg2M
X-Google-Smtp-Source: AGHT+IFV2BaGqD0BAddR/5VHavfl8Mnol7saz3Bsj0Em4upn6uAvpba1yOclRSKtiPCjPQk30vcWYg==
X-Received: by 2002:a05:6830:2e06:b0:7c7:64f3:690a with SMTP id 46e09a7af769-7cc65eb8a4emr20258833a34.18.1767224795618;
        Wed, 31 Dec 2025 15:46:35 -0800 (PST)
Received: from shuah-framework.internal ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ec367sm25187288a34.23.2025.12.31.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 15:46:35 -0800 (PST)
From: Shuah Khan <skhan@linuxfoundation.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	torvalds@linux-foundation.org,
	johannes@sipsolutions.net,
	ebiggers@kernel.org,
	matthew.schwartz@linux.dev,
	linux@weissschuh.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mario Limonciello <superm1@gmail.com>
Subject: [PATCH] wifi: mt76: Remove blank line after mt792x firmware version dmesg
Date: Wed, 31 Dec 2025 16:46:26 -0700
Message-ID: <20251231234627.11867-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An extra blank line gets printed after printing firmware version
because the build date is null terminated. Remove the "\n" from
dev_info() calls to print firmware version and build date to fix
the problem.

Reported-by: Mario Limonciello <superm1@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---

Note: adding discussion threads about revert and simpler fix
for this. Mario sent me email offline about being away for
bit. Sending the patch since I have it ready before I disappear
for New Years.

Relevant threads:
- Revert for f804a5895ebad2b2d4fb8a3688d2115926e993d5
  https://lore.kernel.org/all/20251231035645.5545-1-skhan@linuxfoundation.org/

  This patch depends on revert patch.
- Discussion abour reverting:
  https://lore.kernel.org/all/d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org/
- Proposed fix for reverted commit
  https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/

 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fba7025ffd3f..0457712286d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3019,7 +3019,7 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 	}
 
 	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-	dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+	dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s",
 		 hdr->fw_ver, hdr->build_date);
 
 	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, false);
@@ -3048,7 +3048,7 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 	}
 
 	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
-	dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
+	dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s",
 		 hdr->fw_ver, hdr->build_date);
 
 	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, true);
@@ -3124,7 +3124,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	}
 
 	hdr = (const void *)fw->data;
-	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s",
 		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
-- 
2.51.0


