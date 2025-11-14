Return-Path: <linux-wireless+bounces-28964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422BC5C66E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604144FD5FC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649E306D52;
	Fri, 14 Nov 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="nnJEeXPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7630ACF3
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113545; cv=none; b=Rp6jzBx4NiMtAd2JPiw6WFOpENzcerAUau8FT9FEZJni1faZyrb9N9Q1pqVSRjs7pf+tasnTjtPFCWxsg8J37xPTUs72J9zAye/HziXfnTEgQo30w7iGAKIhV+4CkIfPXWJzFqU8GIgDX/OI4k/nGw7Y7W48oKIrtlPF0gzqBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113545; c=relaxed/simple;
	bh=/v95hXtiMNtokXdEjGGjh7v6qZAmq6GB9grj7w5PDjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLwd/hK5hYutDqbGBiTTMk6rsHZNWBx1l02FQgchEOgKHzSZd+OnGthBCYktnw3Ds3Y/uSm2hNNDp6ZJ3DATvCI+1JVXClt1W8vrBwHe+ZHGLhuDybDz8mWuoS8QF3xpw6ZVtWVs4+1JvRilKZgI0REHJFtvHmJWUhWHZIjtAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=nnJEeXPN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2980d9b7df5so16779215ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763113541; x=1763718341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYdcmg/EanAelwRsGB72V2V0TYhuxD+KsCswGlWW8ZM=;
        b=nnJEeXPNCmhrpaEBAy6elOMksCMn8xA/HcJDT4QyezdMYOnSos+0dgL+0N0c9Cr+55
         EIAt+YKfDJgp5QMnjKmjDeHKjxbMFGSltWKRf2qsLf2WJ3f1XupWdlWwcjO2sODS6LAp
         5iLtZifPI2nVZ90iXvgORO3dc/D3f8fx4mJiGWfMNaSIZTA4+VEMNniuS7MFqw3GNSiC
         YjQQek2k64iMi6m0NAK3vn23EUQ0jx9XYRQFRmdLddtKoxT1q6EMtKApYb4WEPITvVnF
         btwosuF2YfcZDVKAWuzVtxI07rwFmVVwcZwfv+uxfcd+vQokaQ+s12vyRVVa1QDlqVyW
         AMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763113541; x=1763718341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYdcmg/EanAelwRsGB72V2V0TYhuxD+KsCswGlWW8ZM=;
        b=GyABcc5vLTV1cq1ktOrMz7in+t/mRX1j7S+p/iMxfcOKWEKH4207Q+0Exhn3tYbnva
         Qg/tZTjyES2HjLAqtq74UgdYpmrUCAObpsFzIRJlffn1+qBcjyTq5pRtAk/wWreGVMaK
         h0T6Eg6q1GhVjYfCU9QaHghN4MG8OUr8+/imerT6i7G59zZtzVkylfEXDPSjTywTwlPb
         rgEQFCl2i6Yob/potbcHGqGEzt58EqUftQVPkirlvhSpEcJTly9SbjuklaqRWn+NiDNM
         gUaW8WnSlLBr2TrdDQz+ikpH19ZvIZYBBTAg8bi1n+JfoprTdmXw9tjq2PrJSrwyaynp
         Dckg==
X-Forwarded-Encrypted: i=1; AJvYcCUHKuOd2yU8pWaXqnCm/P990X5R9beIX7SfvwofSi8DEj6kJKXnTBES4O/Ps8DowbhbvBZOXok/FCPSnO7HDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8psngb5sz3XR/GwMU8ZV4Lkr4UWulSl9Xqsbl4QFVJOQFz6U
	KNYkuPT2feRCirfqFaGbsTq2i7qL470ZBuevIdCk9qZKaj4LKGHbpPfTphwsfjENd9E=
X-Gm-Gg: ASbGnctYY4aFUm3ynLpFskdu4nmzDYK9bafF5HII5bzECh969aRcJ5jek6ANpdst6Ro
	tWH6EzLfUHsf1QVE0orumB+VqBkreUBtOVh8Nk8ymDixJZzmWvYeIzP8S4IBvTfFjTAEYsERm7Y
	wQyhPv8iD6/YFB0MJRMZuD5DIvjdyfUpfawlnfEHq4OIXJNFDvlnlE1fi7tjUJWDcOFqe9NSPrL
	ZbWp+xosGLmXXpqa5Gd7vkS+OWI89lb5hVJpzrzqkBVQM3ccsDrACo6JKKR0juNdWuYgFCOVKwT
	a1FLFOJcvE/3J4dY5ieVc2DRAiyh0e3DZH/FYmKm6SG/3B8C99COWsHtoOhws6/Cjx4F2R+Flwe
	1u7PoOsz8NsWT/H4VSdFq/9gqJtnMHBoHppxklUUIntrpNUjtSXzWuvzl7tlrHPgM/CHgdWDyyh
	eLumWG0tiX3MnWfTZCHVNpgUHAdHkyOX4zvkU=
X-Google-Smtp-Source: AGHT+IGTHxgQ91mqlnu4ODmMQ4fLQ5T7yFXMw8D7cdVyAgnfmSNyWAX4we6ymVTehkLjKlRgVXG6Cw==
X-Received: by 2002:a17:903:fad:b0:297:d45b:6d97 with SMTP id d9443c01a7336-2986a6d36a1mr23962645ad.14.1763113541235;
        Fri, 14 Nov 2025 01:45:41 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.25])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2985c234644sm49725305ad.10.2025.11.14.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:45:40 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl818x_pci: Fix potential memory leaks in rtl8180_init_rx_ring()
Date: Fri, 14 Nov 2025 15:15:26 +0530
Message-ID: <20251114094527.79842-1-nihaal@cse.iitm.ac.in>
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

Fix that by jumping to err_free_rings label on error, which calls
rtl8180_free_rx_ring() to free the allocations. Remove the free of
rx_ring in rtl8180_init_rx_ring() error path, and set the freed
priv->rx_buf entry to null, to avoid double free.

Fixes: f653211197f3 ("Add rtl8180 wireless driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v1->v2:
- Use rtl8180_free_rx_ring() to free the buffers by jumping to
  err_free_rings label, as suggested by Ping-Ke Shih.
- Remove free of rx_ring and set the freed priv->rx_buf entry to null,
  in the error path to avoid it getting freed again in 
  rtl8180_free_rx_ring()

Calling rtl8180_free_rx_ring() directly in rtl8180_init_rx_ring()
requires moving the free function before (implicit declaration error).
So in order to minimize the code change, I used the err_free_rings label
as suggested by Ping-Ke Shih.

Link to v1:
https://lore.kernel.org/all/20251113165851.39054-1-nihaal@cse.iitm.ac.in/

 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 2905baea6239..070c0431c482 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1023,9 +1023,6 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 		dma_addr_t *mapping;
 		entry = priv->rx_ring + priv->rx_ring_sz*i;
 		if (!skb) {
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
 			wiphy_err(dev->wiphy, "Cannot allocate RX skb\n");
 			return -ENOMEM;
 		}
@@ -1037,9 +1034,7 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 
 		if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 			kfree_skb(skb);
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
+			priv->rx_buf[i] = NULL;
 			wiphy_err(dev->wiphy, "Cannot map DMA for RX skb\n");
 			return -ENOMEM;
 		}
@@ -1130,7 +1125,7 @@ static int rtl8180_start(struct ieee80211_hw *dev)
 
 	ret = rtl8180_init_rx_ring(dev);
 	if (ret)
-		return ret;
+		goto err_free_rings;
 
 	for (i = 0; i < (dev->queues + 1); i++)
 		if ((ret = rtl8180_init_tx_ring(dev, i, 16)))
-- 
2.43.0


