Return-Path: <linux-wireless+bounces-28932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3EDC59266
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560964FD78C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CA236A8B;
	Thu, 13 Nov 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="VkVAJciH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6D2FC880
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053143; cv=none; b=T9GZIsqn5ywGfCKTPEUbdiso4qfhMeKQlP6WoUPtnYd6agxfvk3rtvDzvFWg8iq5QiFR+reMk8a6Ngp+3EDdgxZIwETO1xyVKRRQUc7/kDxh4S6O/u8XwyxVeBhIaU/HqFWW5feo3ltHtO0vPRXmKTaV6BGKFyhEy7DxFSSQH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053143; c=relaxed/simple;
	bh=a4D/KXYNw/8KDDVIrRVsePn4NnMGqm9FVy4LsiCY7aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFep+u7HPmfd2UTvd5tYhGgilwqGmKEU9Pg85rti0GckoF1vDVIFcbcVKSnIMTb4PCkc+w58KAM1eaLxgGwYQ60WYaa2xGbvKVN+XBVojrdU9ML8xfHPVuUsHg5P6vpM0SJlBjlprvCb3LKa5Yu+ofD+WPhtLEPt50PfheaZAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=VkVAJciH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso979501b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763053139; x=1763657939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpAI/e+d+gimI71xP+kZzple2mX6lW+bMxn4vDREkbk=;
        b=VkVAJciHRqQgxapdFThc1hb70loQqwYdcWJNjsa/eLrCdl2He51Ckfjhffa0P81rH3
         spi7q/+7ipdPrafiM0MV29TAlzB7LawwfdpMosAhytxYnxQTF8TotxRo5RoA2vhLnHee
         C0juh06q60g1QoVUA0jURex6UyaCsfzJb5P/Xo7kWi0t/Sk59o9gg7Mqhk8YGgPnaCZ2
         KjuHLj2aue8JnWUaWLC1B+CuUa0XSVdYSsl38D43ONiY0Tl1SCItpl84pMmwKKDIZngp
         D1UQ5YvMGE7ek5bCfY3Sk+aRNzY47PpXdZNi9+DEiXQRSsTrTN/3yVSPkP/tt8sohbRH
         pULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053139; x=1763657939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpAI/e+d+gimI71xP+kZzple2mX6lW+bMxn4vDREkbk=;
        b=k6YkZuY1INJiuJB7CO7Pq1R+3vK44hWvWaJLikA1lWXJAyrej0HLX2hR7eOFATFDb4
         f19sHvP4PGtqzn414qnjofUc+ZzS09k5OiUlCm+hU4IUqjLKajspk6NTmT+QRYQhIiot
         hej5tF/rPIjs8+lWunoZcNy6yapvPvKqbo2spylZucGP1WZfPlidjJNCAzTiu2kiUFBr
         Nx3ylGGjzJhCR35Oxag5qTkZ9w0eeGH7g5hcO92RjjH0UCPFH+2eshqBaJf76IJI219+
         rOVjaaLepwagg3SlToYBCloSmcIuHJ9bjruT1g++XvPfSKpiXJhpMbVybMT3NAMy98QH
         7VfA==
X-Gm-Message-State: AOJu0YwElKP4o4MtRSxG9N2VehKx1JfCREvPzGGrb+btXfJ+33IIguZf
	YRPTjlW5a96sPMjDtLSObXUVaSsK7QJNThh8Waitkik5GhrZb+T/W0dcE2PGjMKgsDUD/rX4VbR
	T61C1pLM=
X-Gm-Gg: ASbGncs56GdfcrcU21PeUTlsmxfVx+IcQqhaPLBBbTMMIKNbKhilxyBfKfHzf+OBd0d
	sFnhSOpS4MQTJucUv6TSY1SyPRMxpRi24kAnEIic7Suq+XeiCQ26xmq+FzsXtuXfsT5ZFee3NyO
	kXMnVqs09WM4Gn3IuE265ilktxaDH/zrR8P5XdA+VQcyczOLeHV8fiSjik4eVYsewc+X5CIgc3U
	FXCVMMUAWvAL4K3iShyKkwSaFMCrqHvTUjD0Kj8wuISZIKMEUaIKHU9lVroOszdzBE89Xj+H4h/
	r5mqM+Hsp6oRlPyClZSx3XDjYrAYu85YBWo07FlHiu4SNN+8Tz1DP6Cfn7+PYl3LBFhCIjxpBEn
	kUzGdl11U5fe5VR/tNDTlMVgIkaFpXOwZzGBxRXqU+xOuqfNlZtrxwgkb0Lpki6vNy69O21hi2G
	IPVQBK0QNR5yoBpQO2wm0XhrpljPRHgMpiJjc=
X-Google-Smtp-Source: AGHT+IGajXo8qyfi3TAyAuUGqLr/c/kTCvTSdHx/BDP0w4C2sHDnRL6+WEWKK85bouAnyPxneU8dJQ==
X-Received: by 2002:a05:7301:4303:b0:2a4:3593:6460 with SMTP id 5a478bee46e88-2a4aba9c042mr46555eec.16.1763053138633;
        Thu, 13 Nov 2025 08:58:58 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db102f5sm463857eec.4.2025.11.13.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:58:57 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtl818x_pci: Fix potential memory leaks in rtl8180_init_rx_ring()
Date: Thu, 13 Nov 2025 22:28:49 +0530
Message-ID: <20251113165851.39054-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rtl8180_init_rx_ring(), memory is allocated for skb packets and DMA
allocations in a loop. When an allocation fails, the previously
successful allocations are not freed on exit.

Fixes: f653211197f3 ("Add rtl8180 wireless driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.

 .../wireless/realtek/rtl818x/rtl8180/dev.c    | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 2905baea6239..898611ccb400 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1023,11 +1023,8 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 		dma_addr_t *mapping;
 		entry = priv->rx_ring + priv->rx_ring_sz*i;
 		if (!skb) {
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
 			wiphy_err(dev->wiphy, "Cannot allocate RX skb\n");
-			return -ENOMEM;
+			goto error;
 		}
 		priv->rx_buf[i] = skb;
 		mapping = (dma_addr_t *)skb->cb;
@@ -1037,11 +1034,9 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 
 		if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 			kfree_skb(skb);
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
+			priv->rx_buf[i] = NULL;
 			wiphy_err(dev->wiphy, "Cannot map DMA for RX skb\n");
-			return -ENOMEM;
+			goto error;
 		}
 
 		entry->rx_buf = cpu_to_le32(*mapping);
@@ -1050,6 +1045,19 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 	}
 	entry->flags |= cpu_to_le32(RTL818X_RX_DESC_FLAG_EOR);
 	return 0;
+error:
+	while (i--) {
+		struct sk_buff *skb = priv->rx_buf[i];
+		priv->rx_buf[i] = NULL;
+		dma_unmap_single(&priv->pdev->dev, *((dma_addr_t *)skb->cb),
+				 MAX_RX_SIZE, DMA_FROM_DEVICE);
+		kfree_skb(skb);
+	}
+	dma_free_coherent(&priv->pdev->dev,
+			  priv->rx_ring_sz * 32,
+			  priv->rx_ring, priv->rx_ring_dma);
+	priv->rx_ring = NULL;
+	return -ENOMEM;
 }
 
 static void rtl8180_free_rx_ring(struct ieee80211_hw *dev)
-- 
2.43.0


