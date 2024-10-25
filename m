Return-Path: <linux-wireless+bounces-14499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11229AFA34
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6984E1F21CAC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0E18C935;
	Fri, 25 Oct 2024 06:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB618C018
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838575; cv=none; b=bGX5PEoR8odDxshpkzfN/CW5nCCgcdLYJWMAFm1NmpzrFW8j4Nc8aL6pGkA23uYeyLGQ+9yoTrTOknOuFFcB0LQ59BmhGtq0qt2n7E8gyyaKbI5QlgASO5E9QqJhC81DSccKoxA4Oq6/hBWP0Nh3+LNLF5kXdl445lmZ8X9NCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838575; c=relaxed/simple;
	bh=94Kx3piAVosckVejWchZzMIwqoCbwRZ4d/DMNunwj1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l6v1RWRIuKgkh6TJfZCMnC705c0vtA1VfDVJBb/+brZlG7souSBHJ8R/DSIsSlqEqov5Kv44u3rxkODQtAJj6JTTHqnI6KJuJvds+fAql7C3G9cbx7VBQfKbH0kOnjkJYhlCiRMbJLaiZskOlCNQWvFIrY03TGMiosxMxTCmJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZY855Y0CzpXL4;
	Fri, 25 Oct 2024 14:40:53 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 643E218006C;
	Fri, 25 Oct 2024 14:42:50 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 14:42:49 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2] ath11k: remove error checking for debugfs_create_file()
Date: Fri, 25 Oct 2024 14:42:35 +0800
Message-ID: <20241025064235.382-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Driver ath11k can work fine even if the debugfs files fail to be created.
Therefore, the return value check of debugfs_create_file() should be
ignored, as it says.

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 24 ----------------------
 1 file changed, 24 deletions(-)

v1 --> v2:
Remove error checking for debugfs_create_file() instead of fixing it.

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515b43..a6426eda023a944 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -925,8 +925,6 @@ void ath11k_spectral_deinit(struct ath11k_base *ab)
 
 static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 {
-	int ret;
-
 	ar->spectral.rfs_scan = relay_open("spectral_scan",
 					   ar->debug.debugfs_pdev,
 					   ATH11K_SPECTRAL_SUB_BUFF_SIZE(ar->ab),
@@ -942,40 +940,18 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 						    0600,
 						    ar->debug.debugfs_pdev, ar,
 						    &fops_scan_ctl);
-	if (!ar->spectral.scan_ctl) {
-		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
-			    ar->pdev_idx);
-		ret = -EINVAL;
-		goto debug_unregister;
-	}
 
 	ar->spectral.scan_count = debugfs_create_file("spectral_count",
 						      0600,
 						      ar->debug.debugfs_pdev, ar,
 						      &fops_scan_count);
-	if (!ar->spectral.scan_count) {
-		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
-			    ar->pdev_idx);
-		ret = -EINVAL;
-		goto debug_unregister;
-	}
 
 	ar->spectral.scan_bins = debugfs_create_file("spectral_bins",
 						     0600,
 						     ar->debug.debugfs_pdev, ar,
 						     &fops_scan_bins);
-	if (!ar->spectral.scan_bins) {
-		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
-			    ar->pdev_idx);
-		ret = -EINVAL;
-		goto debug_unregister;
-	}
 
 	return 0;
-
-debug_unregister:
-	ath11k_spectral_debug_unregister(ar);
-	return ret;
 }
 
 int ath11k_spectral_init(struct ath11k_base *ab)
-- 
2.34.1


