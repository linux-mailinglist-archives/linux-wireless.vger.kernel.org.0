Return-Path: <linux-wireless+bounces-14369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640B9AC0BE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954801C23406
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878A1553B7;
	Wed, 23 Oct 2024 07:53:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C8156238
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670031; cv=none; b=hj/PA6h2Bafm4TWlBAYTb++m/ynjxYAnzm1pro6yPF52iA9eXzF/A201xLCUMnXmWlDuw2/vCx1ZoA3emnTGX5fUp3mowUinDmtBJ3666bOzw+fTGi3Oda36b2EUCs++XQC0N3hJN+ZouWZyJ6FcxP5ZqnR4XwmEs1Ef+1aPjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670031; c=relaxed/simple;
	bh=CKqWS0cKKcDhkW6ETAcVZ6LmNshZutt9sfJP5CjjokM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B2qcrnaYOCNNclB3cUBVVcBMvDu8YoaXBC/DqbSQNhagdsv11lwpYfhYfGvHR+8b9fL3PXXVSO3bIpDmtIritfQvGCsBhuELqfNTtDbFjknC2JI2FUQYnedCIEBI2RVA9qSdBXBla0ChzEa6FOoD9dZN+WHe0GGRnGMhlKbwwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYLpj4B3Wz10NkR;
	Wed, 23 Oct 2024 15:51:41 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FC301400D8;
	Wed, 23 Oct 2024 15:53:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 15:53:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ath11k: fix return value check in ath11k_spectral_debug_register()
Date: Wed, 23 Oct 2024 15:40:51 +0800
Message-ID: <20241023074051.309-1-thunder.leizhen@huawei.com>
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

Fix the incorrect return value check for debugfs_create_file(), which
returns ERR_PTR(-ERROR) instead of NULL when it fails.

Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 79e091134515b43..4c545231292142a 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -942,7 +942,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 						    0600,
 						    ar->debug.debugfs_pdev, ar,
 						    &fops_scan_ctl);
-	if (!ar->spectral.scan_ctl) {
+	if (IS_ERR(ar->spectral.scan_ctl)) {
 		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
 			    ar->pdev_idx);
 		ret = -EINVAL;
@@ -953,7 +953,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 						      0600,
 						      ar->debug.debugfs_pdev, ar,
 						      &fops_scan_count);
-	if (!ar->spectral.scan_count) {
+	if (IS_ERR(ar->spectral.scan_count)) {
 		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
 			    ar->pdev_idx);
 		ret = -EINVAL;
@@ -964,7 +964,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 						     0600,
 						     ar->debug.debugfs_pdev, ar,
 						     &fops_scan_bins);
-	if (!ar->spectral.scan_bins) {
+	if (IS_ERR(ar->spectral.scan_bins)) {
 		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
 			    ar->pdev_idx);
 		ret = -EINVAL;
-- 
2.34.1


