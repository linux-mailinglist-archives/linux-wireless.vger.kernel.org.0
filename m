Return-Path: <linux-wireless+bounces-26486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C85B2EBEB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5981BA82BE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC202D877F;
	Thu, 21 Aug 2025 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeOFo5B1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B723F294;
	Thu, 21 Aug 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746880; cv=none; b=gHYGb9zyr4Ghipv2MmxMbwfzlhqYNg8kucsZi2f8BSMy+giUl1v2e5vFN7ErjjJXlpn2/u5bKTMYvCzlRE6LLtB48r2ZtqmVKDGLl5lnM2Ck3QawQY7uos7PrrtlTeOuTJwIhdK941TBJN5pz0M3ptQR3PhCJi92XP3tGG02Csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746880; c=relaxed/simple;
	bh=Voo9oKRofxTuV/k2tUtAV41fVYahmsWQA3Okt2W7K9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv00qgciu6l9FPcUu5HZ+y3uQEB/mMPHj7x2pddKcw2DXis/JazLn3+pcbiIsSLjrzmjFLwN8Sp/hCzN6JXlPqq9buB6tjM0zBcEgKgmtlJ389pS+7L44oRF1A4iAyZh+B7HE4xNKGZtFZ5XAPS0IjhiJk+HFFaHFkNSbi4zU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeOFo5B1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e613e90so448356b3a.0;
        Wed, 20 Aug 2025 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755746877; x=1756351677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IN1Teq4e2sAVaB5v/P7mB/rOLPipyuu7DLJ8UrOyVo=;
        b=HeOFo5B1tDvgqPZg5uoqYml3fsoNMMuU6FcbOHJEYTKZ7ftxWQr2RhtWlGwWrvqeqc
         0yFyDA/FoI4tzkBZixmPQ6gcTtsjShFuQdZOAgzcbkjy2Bf+sDk7akkPYDFgOGqrSYNs
         9KlRHPizxEwVnK2aV7BmAE2tABFlfWx7QAix8C/jRvjKbYoec8IhW4yXDJn0NxHklIr2
         hEtFFVaRTtXUaFXa5iJ+8LtzPsW8zoFV9OWmn7+QuKSeVh9NEnBTK0h3H1XJ4xRMUpGo
         QWiZ7nSuQYcpZaoxK4F5OkipdG9SfHfvNtGTltaxbjZMAgXnYgWLmayHETzs8SH1tOYe
         BWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755746877; x=1756351677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IN1Teq4e2sAVaB5v/P7mB/rOLPipyuu7DLJ8UrOyVo=;
        b=biLdoSBoiAcIK/0RBqRq3iOROnr3c+6psULfXWmqt/HbPvLBTVgR/8fngbxpaP+HdA
         euXbGwQp79qVpSNopi9ow2gp1CCRaFwi2Xjpad5L8TGClprT3wr5+Ql+ZWCCD5IPo1aU
         icx596VCPlx8nH4PfdzfjCy7vAz0D9ySceWYkdEFvnj6U/C8nnJWnIWGZKwYZgi+PvC0
         Xg07Ot5xzta/iKKzds6UPKZ6Q9ShgR0qYwAsbJx2jFmJ11O6R+x9aLOz9AW22T8umP2v
         2vp1yErm/pi6el7g6vcxS5OX1se+B/pKp42ql0wvhkT36skeCACDxWE7j4MQt+V34ysc
         aZcw==
X-Forwarded-Encrypted: i=1; AJvYcCVvBamThSxF/ZlweWkpk1QeXSrMF7kUcppMz9mY5uk6xRykkfMOissVYXKMzcUI5XTB6ksl0CfCD886HdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oqzdWTUO492ojxWto6FMOkmhpvjg+SoUBWJEAJgTDCpZDTmh
	G0ywtVeqGPg52KF+6T6W7iKYWTM440yMCsMb7CpQ6Ardi4SvdVsblbVoKFzp+Q==
X-Gm-Gg: ASbGnctIOyFeatwbi9Sb0mQasmqgTMRqxgbQDYYoWHykvfXUdmL2T+J2Y6CgznOPhDV
	JULTh2+qbwjz/R5Vuu6mZWMHm7vP/tvHSHm3prrakuZkRch/CnDjjMjcW/D6NUiPgFGHPRBTSaP
	vkMe0zpILHDebJweKC2cVMQu7J/h5GZLoDHyodbq7dP1Nrf002GgUS0o+J210m1cbrpybmT5oPl
	jZkxYptlwEPnaAXe6ZBcQxAvAziJtfmHJ5D1Sn+Ou1kMEY/rRPb6Phs4Iutkq1Qh4CNpMsnrOUr
	ik1epKIAHHj3hAAjCfUH1kOg3rRLJc6dsj9TTJ4XDA93auHs4U4dqO8U9shuzKWMzYbcepwtGRt
	Lkw7C
X-Google-Smtp-Source: AGHT+IF41ywgDWIkaN2gPF4JkkQoYJJmpVIEoTZsLO1tVomauIeM2wVIjSiP1XNgt6v0HViVwzBw8w==
X-Received: by 2002:a05:6a20:734f:b0:243:78a:82bb with SMTP id adf61e73a8af0-24330abad42mr1211381637.53.1755746877418;
        Wed, 20 Aug 2025 20:27:57 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe8ae4sm3512707a12.18.2025.08.20.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:27:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
Date: Wed, 20 Aug 2025 20:27:55 -0700
Message-ID: <20250821032755.636661-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed to support nvmem defined MAC addresses in DTS.

In addition, check if the probe should be deferred as nvmem can load
after ath11k.

For brevity, ACPI is not a factor here. ath11k is too new for that.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1fadf5faafb8..801db15ca78b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/inetdevice.h>
+#include <linux/of_net.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
 
@@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
-	device_get_mac_address(ab->dev, mac_addr);
+	ret = of_get_mac_address(ab->dev->of_node, mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
-- 
2.50.1


