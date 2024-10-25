Return-Path: <linux-wireless+bounces-14497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB39AFA27
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA332825E2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 06:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD419B59F;
	Fri, 25 Oct 2024 06:37:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E01B0F3B
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838259; cv=none; b=FfRV3obNNtkJJilRcHnjp/6A/mcBvoF9H6VLIgzveLcCLcQFNjYJ4vE+vl3PVq9HZ3QUXlWrOfhEQMzIo8Z/6fh9Qj4JGklEqAEJgKmIIRSpWRhUbrQdr94vd57qL4WG7DvvI82X4BckDZDpegU/YcS1o7o5YScMP+Q47v7eOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838259; c=relaxed/simple;
	bh=94Kx3piAVosckVejWchZzMIwqoCbwRZ4d/DMNunwj1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p6ssoPwriQubOKcl2Ji+5gIshDrm9T3KtqN1jtgTkKnKL+12GC/LeuQhu+vBLX3ZT5nURY0qupvwz4ziuewZWgY6m86Dz4wG9ZjtfdYS+gRNH1QwCWzAm/80bNsnRrI8dYMxknh4e8RjZkZNGarTSEcW1S8RBRfjea33VODoCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XZY2V1Z6dz2FbLR;
	Fri, 25 Oct 2024 14:36:02 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id B721B180044;
	Fri, 25 Oct 2024 14:37:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 14:37:27 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH] ath11k: remove error checking for debugfs_create_file()
Date: Fri, 25 Oct 2024 14:36:14 +0800
Message-ID: <20241025063614.368-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


