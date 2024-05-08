Return-Path: <linux-wireless+bounces-7354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5684C8C04AB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F591F23446
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781712CDBC;
	Wed,  8 May 2024 18:59:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDF12C464;
	Wed,  8 May 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194756; cv=none; b=W+qP7fjU5bs8uWvg/aDv0q7fnXbn+fHt2sdHXAn7jj7f4v9afzqG+05lI1krDCWhCucBfCVNPUfl9P+T0oQXs4LC2GZybT30cYqrAr86fM5Qw9YVLps7GsH7WnTCwGIjGBzJ57UKQQQn7A30el2ZLnsuSGwQaDIJKkWyJFxm79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194756; c=relaxed/simple;
	bh=bSLgq4FvpeTB8kkbHpmgDPjDvcsz7KxXYPf2zdLXhbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCce4Ldz5dgmyybSyhFm1iuZExaIjAGQZq87DAX2l+qbbbM1/YGHGm88swsA3FE5b7ncmk8da4tYbkfMFKEPUAyg237jdcravRudX33YAs8twKoRtNBHxQAtp69qj2ZYihqZVRo/3x2lP8WWmkesaMzc09Q2/W97xfz3i6+zgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so2246542a12.0;
        Wed, 08 May 2024 11:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715194753; x=1715799553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFrOIrDzTcMn622VateT75IhKFBfpAyCB1nXrmsjnHc=;
        b=A+Aj4wEFOeuc/nFRSoBL5uvJPwdxNMvzAXrXL8DVPKKmyVK5st23UEOE0wmV0Evl6A
         AeihrgEPjAfKzWwYEq4hwIyw7HYPl9u43Dl21PhrWo/bHE/tFBTt+QbMiOrxwY/XgmZ6
         FWCYtEzS/dZDLYdKqPS0CUjbGBTa1h2Ny4GA4toLyMUHBVUAlOmjx7z0hMvHwxff60Wl
         ICPz+GunUI7YJBpxmLyWTN8hTnda4BJ8VRNhYzzWzH0oDobbstQndZlxt1f8TRfPm6sq
         QfhT5beqTB8Blqov2r3QUH8gzU8D3eaECCtl+SiyP3RDv3thjfyY7HbjLgv0xGW2FDPn
         jA8A==
X-Forwarded-Encrypted: i=1; AJvYcCVIeXjhzS2ua7kAs7E7cOFQKd9gprvmSzs8qBaTcfZeGA5X4D9QJye1F9g1gknkUdz4PvimVG4kDBXr4V+CtmVMc0+nIMGrR7kZUmqxTRcFd4fXA68y+LFkkQQGpyxtY13IgNMoDW5h07RwfvA=
X-Gm-Message-State: AOJu0YxboxBGMXDuA2iX21nBrV0TW5eixOCdtSGPQcCiQXMMJ85d1Byv
	ElW1O0/OtBxcvH8gn2gFsWCZ1UpjOe+QmfriMScrQjo9giOB2PfmtO3fEg==
X-Google-Smtp-Source: AGHT+IEK4RWsOUL+8o+nVUUM0654BVgn5v3VnQl5a8AzTg5iRjxacDUtx9DKydCnJGRbKSZJvyiVQA==
X-Received: by 2002:a50:d50c:0:b0:572:3eaa:a637 with SMTP id 4fb4d7f45d1cf-573326dbfe0mr342070a12.2.1715194753099;
        Wed, 08 May 2024 11:59:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ee53-20020a056402293500b0056fede24155sm7890077edb.89.2024.05.08.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 11:59:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: horms@kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] ath11k: Fix error path in ath11k_pcic_ext_irq_config
Date: Wed,  8 May 2024 11:59:01 -0700
Message-ID: <20240508185902.70975-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If one of the dummy allocation fails in ath11k_pcic_ext_irq_config(),
the previous allocated devices might leak due to returning without
deallocating the devices.

Instead of returning on the error path, deallocate all the previously
allocated net_devices and then return.

Fixes: bca592ead825 ("wifi: ath11k: allocate dummy net_device dynamically")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ath11k/pcic.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 79eb3f9c902f..debe7c5919ef 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -561,6 +561,7 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 {
 	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
+	struct ath11k_ext_irq_grp *irq_grp;
 	unsigned long irq_flags;
 
 	ret = ath11k_pcic_get_user_msi_assignment(ab, "DP", &num_vectors,
@@ -574,14 +575,16 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 		irq_flags |= IRQF_NOBALANCING;
 
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+		irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
 		irq_grp->napi_ndev = alloc_netdev_dummy(0);
-		if (!irq_grp->napi_ndev)
-			return -ENOMEM;
+		if (!irq_grp->napi_ndev) {
+			ret = -ENOMEM;
+			goto fail_allocate;
+		}
 
 		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_pcic_ext_grp_napi_poll);
@@ -606,11 +609,8 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 			int irq = ath11k_pcic_get_msi_irq(ab, vector);
 
 			if (irq < 0) {
-				for (n = 0; n <= i; n++) {
-					irq_grp = &ab->ext_irq_grp[n];
-					free_netdev(irq_grp->napi_ndev);
-				}
-				return irq;
+				ret = irq;
+				goto fail_irq;
 			}
 
 			ab->irq_num[irq_idx] = irq;
@@ -635,6 +635,15 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 	}
 
 	return 0;
+fail_irq:
+	/* i ->napi_ndev was properly allocated. Free it also */
+	i += 1;
+fail_allocate:
+	for (n = 0; n < i; n++) {
+		irq_grp = &ab->ext_irq_grp[n];
+		free_netdev(irq_grp->napi_ndev);
+	}
+	return ret;
 }
 
 int ath11k_pcic_config_irq(struct ath11k_base *ab)
-- 
2.43.0


