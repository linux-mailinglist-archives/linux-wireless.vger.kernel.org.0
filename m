Return-Path: <linux-wireless+bounces-5900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08638899CD6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AD12834CD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392F16D9A7;
	Fri,  5 Apr 2024 12:23:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB716D4DC;
	Fri,  5 Apr 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319787; cv=none; b=Ved9b2v4WDbDNbZXiFrl1w2FBpcRCMluNN1JKxgfNvL32dVEP7h4TYLwevQw8ojHWtCbxfV+UFlm3QVW8WBUI8rURbs5FV12Nrz6Dk6mlDdN716sT6OHtFg6MbdQ5RjET94m1sl/8VORz0yZ7cb56ExAiRnYFaLo44GZyR5IEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319787; c=relaxed/simple;
	bh=H4qwwcs9QCBhu2Nhj/At6l3PyJNuCbZmSkaPnBPTv2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMQVBuXU6cEiHqxEtM/C9RiNlgTh4amuD/hp5F9xSYIx7tUwz4sxMxpVF55bAsgqzH8mnJVxoSVWHOOOjMQXwI2LNwtlqUFbD7yNAg6EPPoyDecHj2yJRPH3o6gy2azr7aQrUQdYxzPuneRtM/Tbd49RKYc/wG+C30DMP1SjwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso2882300a12.2;
        Fri, 05 Apr 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319784; x=1712924584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0b6ZTZP28B582Ew9wb8M6SnVQx+DzS3AWFgjM5huBrw=;
        b=EfQmn2Lzgfv12+rK2dFvdU1/dss8K7UZVj5PukvJvVYQyPQJNgSF1/TyjfKpkJebRc
         sj0CszgbfREZVBLcr4/jO+UdlfD2qh5NRAUnso34DyfJC9GS09HTr22vTcb+Hb9LLgCt
         Hq2jm+kJuCdr/wREup+7emPjJvENI4Dps6ITNo0SddQqnffrJ+u/4QiNUSu7B0KOR/rd
         AY59/hM35+2alONuWKd0EYXavzrBwh91pTl2TJyP3alTyhuCx89n9IFNkSq8dKMjn7Fe
         DkAXt1XLhgKewtnik2XUOVAVrk4gUwT4IgmyRCOrwQJrR0U3MoE2E0rT58pbtVv4JXku
         OliQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Y546E+BxVQ9B9CCAA38QkNBGCYXF/6/WWZ0X9hOX/GqwExmUTDisf9kOYuS7aaZKv6KG7nMCeqwgwoqeYrVJCk7qZzAcXh2UyzX4AXkWN23vwpzeS1BQOgX/5KThguVFKJLyUBM=
X-Gm-Message-State: AOJu0YxpQ+/8FRXHeRA6qfXo1teRPnfEptjei4oQfMdRiU5yZwIjv735
	D62TGYUX3PqlSQB9VGeuc/x0//jTIIysGxXv9bQJwpGiyd8x90vp
X-Google-Smtp-Source: AGHT+IEUq9r/2bByh0SZDeLS9YE8AIX/kJ1yrrwbEiNuiEdzLaWWM9/L5wr+eIzvXbdrrpRvHGpXSg==
X-Received: by 2002:a50:c04c:0:b0:56d:c40d:b921 with SMTP id u12-20020a50c04c000000b0056dc40db921mr974312edd.20.1712319783449;
        Fri, 05 Apr 2024 05:23:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c509000000b0056bf6287f32sm736426edq.26.2024.04.05.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:23:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	imitsyanko@quantenna.com,
	geomatsi@gmail.com,
	kvalo@kernel.org,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/3] wifi: ath11k: allocate dummy net_device dynamically
Date: Fri,  5 Apr 2024 05:21:18 -0700
Message-ID: <20240405122123.4156104-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405122123.4156104-1-leitao@debian.org>
References: <20240405122123.4156104-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at ath11k_ahb_config_ext_irq() for ahb, and
ath11k_pcic_ext_irq_config() for pcic.

The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
case, and ath11k_pcic_free_ext_irq() for the pcic case.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  9 +++++++--
 drivers/net/wireless/ath/ath11k/core.h |  2 +-
 drivers/net/wireless/ath/ath11k/pcic.c | 21 +++++++++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7c0a23517949..7f3f6479d553 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -442,6 +442,7 @@ static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -533,8 +534,12 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_ahb_ext_grp_napi_poll);
 
 		for (j = 0; j < ATH11K_EXT_IRQ_NUM_MAX; j++) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b3fb74a226fb..590307ca7a11 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -174,7 +174,7 @@ struct ath11k_ext_irq_grp {
 	u64 timestamp;
 	bool napi_enabled;
 	struct napi_struct napi;
-	struct net_device napi_ndev;
+	struct net_device *napi_ndev;
 };
 
 enum ath11k_smbios_cc_type {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index add4db4c50bc..79eb3f9c902f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -316,6 +316,7 @@ static void ath11k_pcic_free_ext_irq(struct ath11k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -558,7 +559,7 @@ ath11k_pcic_get_msi_irq(struct ath11k_base *ab, unsigned int vector)
 
 static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 {
-	int i, j, ret, num_vectors = 0;
+	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
 	unsigned long irq_flags;
 
@@ -578,8 +579,11 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_pcic_ext_grp_napi_poll);
 
 		if (ab->hw_params.ring_mask->tx[i] ||
@@ -601,8 +605,13 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 			int vector = (i % num_vectors) + base_vector;
 			int irq = ath11k_pcic_get_msi_irq(ab, vector);
 
-			if (irq < 0)
+			if (irq < 0) {
+				for (n = 0; n <= i; n++) {
+					irq_grp = &ab->ext_irq_grp[n];
+					free_netdev(irq_grp->napi_ndev);
+				}
 				return irq;
+			}
 
 			ab->irq_num[irq_idx] = irq;
 
@@ -615,6 +624,10 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 			if (ret) {
 				ath11k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
+				for (n = 0; n <= i; n++) {
+					irq_grp = &ab->ext_irq_grp[n];
+					free_netdev(irq_grp->napi_ndev);
+				}
 				return ret;
 			}
 		}
-- 
2.43.0


