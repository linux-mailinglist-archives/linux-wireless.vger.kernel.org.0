Return-Path: <linux-wireless+bounces-7327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3F8BF9D8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 11:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDEE28670F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A07757F7;
	Wed,  8 May 2024 09:54:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080ED54679;
	Wed,  8 May 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162076; cv=none; b=hbkiy7mhRIlKA9t5amG8Tt00jVGjdVAdxnIzuXUuP2ISx85j9atNDRB153iwQdIUA9dxZQQu2HsixLYxkCDUvNaxGWYJMHqQnalpjuNXHarq91y89GpmsPiXmgKEX7wLhvJGF6VzibalrYQ4aOcxQxLidFp+amjAUUQhfb8WpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162076; c=relaxed/simple;
	bh=FfA5dF31garZW/tk3DQl+spTHY7RrowSCt5gDZ9Om5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EL3URdUFxNswfWu89eqgUIrgtfQ/sJ6hROy9rHX5NYs3BShUlm6JeUzTEPWLbbemddnMzGsyJcgM4DwAotsg0V07awZEfniFke+DkzHomIm2EzzcbDHelPnrVD2KMJ93ARL4yIvL8RZU9cgCb8ByllPQgl5Zf9UwsYIbzIURu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f3761c96aso5359673e87.3;
        Wed, 08 May 2024 02:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162073; x=1715766873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD2/6sPlr7JEw5uhBN364YYJFLTnmVMqOaL4BzfWeD8=;
        b=JK9dtjL3KcLGjrM7+kmQQsDY0Y5AqzmConde9oSepmQmv7OIfQymaJjU+w/+DUJa+v
         Z5hghzEAynwFe1JwOL/AHM9ObQDy7TFA1W/nOUPf4UK6+BfIfRb8DsjZu3NqUNTDOb49
         JC7R0Gf/Tg2ggCWgFBTO4Pl0//WFlxiiuhyYxs71tDYhZZsWFFZ36MD3hHXnrIJSn9pq
         7oxrWUt86U63tv+YLjwfOc640O4umls3wXNIHGxOk2i0dnjHfoq94zk5VrYjBAhnawsh
         kzMQUNVn5a/9ofUMsObz2uh7zRAelLAYlDwrwyFgtY4zCI1OGQXqpovH5mID27mlpTXm
         yRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaVnDQcksz/jsxekU//CEQIjcPRMYzjSX4DPSmHhWS9NjEtnX92F+JvAGCk+bTPFPdOm000lC6pm9wCh984+xGwsQxIFsSigPKIFdD/LUqlxMKwtIlYOgYi0lZAPysEHNEtYlVELVL7yUah44=
X-Gm-Message-State: AOJu0YywGncSVmDtpr54G2+potKreOQsD2wQQa8aMZ8KRG2H4T2sLXBh
	yv0j3HRGEbJnYZfyD2XB/DAFuhl6Z02Mf8jAnnbBynvcpRM+NsvTmMgtPg==
X-Google-Smtp-Source: AGHT+IHmCf5LAkl84GP171Zeb9C+hU+YlcxP1NLnZdtmzr65qLJvoOCAVJfs5QJwFe5Cm/IGPVi37w==
X-Received: by 2002:ac2:5929:0:b0:51d:a1ab:98bc with SMTP id 2adb3069b0e04-5217c3733cfmr1876163e87.2.1715162072909;
        Wed, 08 May 2024 02:54:32 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090648d300b00a5a06effd3fsm379569ejt.221.2024.05.08.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 02:54:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: horms@kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next v2] wifi: ath12k: allocate dummy net_device dynamically
Date: Wed,  8 May 2024 02:54:09 -0700
Message-ID: <20240508095410.1923198-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
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

Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
the net_device object at ath12k_pci_ext_irq_config().

The free of the device occurs at ath12k_pci_free_ext_irq().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
 v2:
	* Free all the allocated dummy devices if one of them fails to
	  be allocated (in ath12k_pci_ext_irq_config()), as
	  pointed by by Simon Horman.
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c  | 27 +++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 47dde4401210..6671219c3567 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -146,7 +146,7 @@ struct ath12k_ext_irq_grp {
 	u32 grp_id;
 	u64 timestamp;
 	struct napi_struct napi;
-	struct net_device napi_ndev;
+	struct net_device *napi_ndev;
 };
 
 struct ath12k_smbios_bdf {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 16af046c33d9..ac75e8e3916b 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -350,6 +350,7 @@ static void ath12k_pci_free_ext_irq(struct ath12k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -560,8 +561,9 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
-	int i, j, ret, num_vectors = 0;
+	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0, base_idx;
+	struct ath12k_ext_irq_grp *irq_grp;
 
 	base_idx = ATH12K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
 	ret = ath12k_pci_get_user_msi_assignment(ab, "DP",
@@ -572,13 +574,18 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 		return ret;
 
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+		irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev) {
+			ret = -ENOMEM;
+			goto fail_allocate;
+		}
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath12k_pci_ext_grp_napi_poll);
 
 		if (ab->hw_params->ring_mask->tx[i] ||
@@ -611,13 +618,23 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 			if (ret) {
 				ath12k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
-				return ret;
+				goto fail_request;
 			}
 		}
 		ath12k_pci_ext_grp_disable(irq_grp);
 	}
 
 	return 0;
+
+fail_request:
+	/* i ->napi_ndev was properly allocated. Free it also */
+	i += 1;
+fail_allocate:
+	for (n = 0; n < i; n++) {
+		irq_grp = &ab->ext_irq_grp[n];
+		free_netdev(irq_grp->napi_ndev);
+	}
+	return ret;
 }
 
 static int ath12k_pci_set_irq_affinity_hint(struct ath12k_pci *ab_pci,
-- 
2.43.0


