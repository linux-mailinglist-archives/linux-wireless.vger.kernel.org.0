Return-Path: <linux-wireless+bounces-12250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8DD9659FE
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6328AB3F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB41534E6;
	Fri, 30 Aug 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6F1RKtN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF51667ED
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005988; cv=none; b=OBtoS7TRkgGPFvEjlgP0geapfjmlAQU96rh1HOH93gsJBw+aNYZw3757ZG9GsMv4Qg1Shy0j4cmT5SciZHeMVagkty19EYgTa/MxcoTqVJIB05WABC78Hdaa4YqQhCWdsGbzGff6M5WAeR4H2zHrXzUN89q+3BLkoEExM5S4hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005988; c=relaxed/simple;
	bh=vaVJ2TMsWEUA1zY4HWwkIeL4wMyTn1Q0lqASZxJ7FIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJ9a7t/VCvasTJIANaTBlbU1CeKBsdHraUFk2Gfvv4gWOqm0XfMTO71A2LhdyzPCAi7cLkupqUJN8N23tHQPA2X2ZUSZGR0A8J0B29kwLUDk7Koo7NBirPa2yCGZVTyi2oxRTgozyqUYHk45Ox4/9xCVmAEC/PM/kQNRULKVxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6F1RKtN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371aa511609so979438f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725005985; x=1725610785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wuv9obc/Xx4ZaKo4kmCVXNgu0ZQZGPsA7BXAh4kjQ+s=;
        b=V6F1RKtNHq/CDl0GtoFvFMx7qAtqJB2L3zu7sOiOQhrSOIbIHKERmJo7b0DVjacZlS
         RLpyxwMSYkRMWLvcEo5xnzezairU2JIqXCraz7Lb3zjXvHO62cyBdO2EfrtCKkDr5Ojo
         cJFUNBAzjcr3RZfSoz0QDnefh0tlTMU4/ylXPRx5NMUgZ1sLAbCxdyWBP6q1HWKxSwUi
         HlHPoyW4HJgIZAPppTtaG4F6oH95ooha6SFj/t9wC1LSG5ZdOBKLl40ZPOefMbvqL7EM
         v5cR/BuvMXQe6uL+JeOZaU6qqv5fTbDtZH9+59x+MTcDN5SR2f7/JVpUhNDQa+IyfcNK
         okDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005985; x=1725610785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wuv9obc/Xx4ZaKo4kmCVXNgu0ZQZGPsA7BXAh4kjQ+s=;
        b=CfN90sqpD1HSIQtDqqnZJDQh0T3L7lMxE8jpBnIDagXbuhwvm+3ZxxuX0Qz4Qn8Pwq
         5CSspSV82znIkLuRBr4/Yw0xTHt10q1TwKcBilmd1fxy9s1nvtAXqGJY8RSYW/Cb0seO
         5IkgVLAxT0p+c0BeYBYWBdrrQ9pqSYJHc1lQMJXliOcfWDlZjGHjmUgH+aPpQ+vfcDh2
         Wjx69eJDShNRkB5axkcAhlzSAR296fjV6vYwk9O/cT7xk6c8PCkoVClN2bR3JAfaAEx1
         rjV3Bkw3RnVXUlfiwyc/DCrhvjz4ywJp7xPEOs81gwvFrq4EmxHLxypiGMKYszBsWvfi
         ecxg==
X-Gm-Message-State: AOJu0YxSNGo3kVrfXWZ0UvkzCu9+DGMuuhkgJXZqVBqCsFoGXntX8PVk
	M3Thr5G5iPlOJn7eo3SQmj6eiFR7KJ/eprnN0YBlAZOdYM1UX6V8
X-Google-Smtp-Source: AGHT+IEAFpZYeGmtteC9UnGx9qUAJ3fgJzSiGa5JxPKv7WaO1jcBGcjsCe2AM88YZ8qr8IDBCZ/tgg==
X-Received: by 2002:a05:6000:4012:b0:368:41e0:16c0 with SMTP id ffacd0b85a97d-374a9568b7bmr1313272f8f.22.1725005984394;
        Fri, 30 Aug 2024 01:19:44 -0700 (PDT)
Received: from syracuse.iliad.local ([2a01:e0a:0:2100:21ef:6d50:511c:bd79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef812b2sm3317624f8f.75.2024.08.30.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:19:44 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp
Date: Fri, 30 Aug 2024 10:19:42 +0200
Message-ID: <20240830081942.3623380-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those two fields are used to store the per SPT page of tx/rx descriptors send to
the firmware for cookie conversion. Right now they are in struct ath12k_spt_info
which means they are duplicated PPT page times while we only need one instance
of them. This works for now as we always use the first spt_info as a global
storage for all PPT pages.

Let's move them into struct ath12k_dp where they belong, alongside of the
spt_info array they are tied to, to avoid waisting a good bit of memory.

Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-03283.1-QCAHKSWPL_SILICONZ-2

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 18 +++++++++---------
 drivers/net/wireless/ath/ath12k/dp.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 61aa78d8bd8c..ecd3b5c76d26 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1162,7 +1162,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	spin_lock_bh(&dp->rx_desc_lock);
 
 	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
-		desc_info = dp->spt_info->rxbaddr[i];
+		desc_info = dp->rxbaddr[i];
 
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 			if (!desc_info[j].in_use) {
@@ -1181,11 +1181,11 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
-		if (!dp->spt_info->rxbaddr[i])
+		if (!dp->rxbaddr[i])
 			continue;
 
-		kfree(dp->spt_info->rxbaddr[i]);
-		dp->spt_info->rxbaddr[i] = NULL;
+		kfree(dp->rxbaddr[i]);
+		dp->rxbaddr[i] = NULL;
 	}
 
 	spin_unlock_bh(&dp->rx_desc_lock);
@@ -1220,11 +1220,11 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 
 		for (i = 0; i < ATH12K_TX_SPT_PAGES_PER_POOL; i++) {
 			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
-			if (!dp->spt_info->txbaddr[tx_spt_page])
+			if (!dp->txbaddr[tx_spt_page])
 				continue;
 
-			kfree(dp->spt_info->txbaddr[tx_spt_page]);
-			dp->spt_info->txbaddr[tx_spt_page] = NULL;
+			kfree(dp->txbaddr[tx_spt_page]);
+			dp->txbaddr[tx_spt_page] = NULL;
 		}
 
 		spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
@@ -1415,7 +1415,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 
 		ppt_idx = ATH12K_RX_SPT_PAGE_OFFSET + i;
 		cookie_ppt_idx = dp->rx_ppt_base + ppt_idx;
-		dp->spt_info->rxbaddr[i] = &rx_descs[0];
+		dp->rxbaddr[i] = &rx_descs[0];
 
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(cookie_ppt_idx, j);
@@ -1445,7 +1445,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
 			ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET + tx_spt_page;
 
-			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
+			dp->txbaddr[tx_spt_page] = &tx_descs[0];
 
 			for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 				tx_descs[j].desc_id = ath12k_dp_cc_cookie_gen(ppt_idx, j);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index b77497c14ac4..28c8bf22810c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -300,8 +300,6 @@ struct ath12k_tx_desc_info {
 struct ath12k_spt_info {
 	dma_addr_t paddr;
 	u64 *vaddr;
-	struct ath12k_rx_desc_info *rxbaddr[ATH12K_NUM_RX_SPT_PAGES];
-	struct ath12k_tx_desc_info *txbaddr[ATH12K_NUM_TX_SPT_PAGES];
 };
 
 struct ath12k_reo_queue_ref {
@@ -352,6 +350,8 @@ struct ath12k_dp {
 	struct ath12k_spt_info *spt_info;
 	u32 num_spt_pages;
 	u32 rx_ppt_base;
+	struct ath12k_rx_desc_info *rxbaddr[ATH12K_NUM_RX_SPT_PAGES];
+	struct ath12k_tx_desc_info *txbaddr[ATH12K_NUM_TX_SPT_PAGES];
 	struct list_head rx_desc_free_list;
 	/* protects the free desc list */
 	spinlock_t rx_desc_lock;
-- 
2.46.0


