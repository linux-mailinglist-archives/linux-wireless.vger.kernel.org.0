Return-Path: <linux-wireless+bounces-30393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5ACF7583
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 09:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9891F300BBAF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9122BCF68;
	Tue,  6 Jan 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkP7Iw00"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B127E7EC
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689410; cv=none; b=cQOWvKpVf0TtgR2beTUgNfgxEOvwzpaNi4ZaMT2NM5imUoEWHrIFxKZjmZo87BFk865TY+PzEspE1Znm4SjFX5rqKWfi37XMF/2XwsB1UKnOneB7i5liyMqF+p59uSddQTbaw62841ldlXqH3Uspqd8eVXlAvyumnd0HNLkRsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689410; c=relaxed/simple;
	bh=Mfr8IanOt8jxU7vewSt4DV+aakgkKleTBni/LrpiBkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjE6IOVSXa7VoX/SyAIqpTjlhmaaL5lZx0oBVIBYy/D8d6R6pSVl8asxsLODwxP/MA+QkEyvWsttUnZ6kkqZH9CpsC4KPwDrALIzKA953Ek2W2mADhOmL2Dg3rwR4++vri1ao1GeU3MDtjEgIrTFQcLqPrBh8HFCP5WaYLK1RHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkP7Iw00; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798f4059fso1044985e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767689406; x=1768294206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV/GMcvRyLCr7DUYxLRLYti8UWuf7naTwJHZtiyzU+M=;
        b=AkP7Iw00c1wFdlkYWq6yqgIF1CKlsR12fcDUPOL31p3kLkLR/ssOVsd7YqLz8P0+45
         zPnNxxQf0culpGPdFzTrdJ5lTq3ZNWVJae7v49F4MuDkszzsCKItuT3JFtENQXFhq54c
         RsXJjr5tniRMg5H6HZwfHq6PFDwQA9DlqyKM6P3sb0yDCLnHwwj7wtrx402r6om/OQbG
         8PLPTw54DDVi8s1xRpQRTZ3JcpYRYt0PXwqvA1oAJ7++d5Z+5wJOBmG1exrCR+CGiNTc
         SauophdfPBQPSecYWelhrr3sTf9MStySRg7m/DvfYpvEI6W0kZz4ozeBV3XnD1/5eimC
         GfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689406; x=1768294206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV/GMcvRyLCr7DUYxLRLYti8UWuf7naTwJHZtiyzU+M=;
        b=bQ3MS0kRMukr9EMcuMsoxgDh6qTqxiKTFQmmkAZCrGpB4AxIRoYRhcsw64Ha2aktf8
         tIKlJCI3/qjB8O54arKEBzusAHI8SPSK8h+YJ0gCK61B5ciga/hRZM+rXDCFhi2mnzkB
         xqdp5zU6BQjQLjDMiHkiDyfIfGj5D8D74i6WEt/n4TgXA/BWyyaylMgALfhLnISK6z1k
         OiIUpn3fxQ/Fx1fxj74Qke56ZEcvinEGbqhM+AOddKXkhRXS3rsE59GfI0d1bSOKs5JZ
         y9rPbBn79o+U2GJC0H1Ff4BulPAuWuoI2PX4utu37NYvJ/6R5P56kJl4lIx6uwd/zPJv
         cevQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJBisrV91TCkt5LCcWuDWPukyoKKQdqr0ua21CNg+UgokgBngxZqYxxhsM8DjrNMgESNEbx9P+/JNCGXpH8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ExGJUmLIKtdh4XfE1tyetWkt5O08IcptyuCNYImKQ7/JXG86
	TzbIJpwShyIEk+E1+O1OCWsHQlTQirvoAfgX0PRk0g4dKWLnCQKAgDEA
X-Gm-Gg: AY/fxX4jcwsWbosb1+qYUeiJ65kjddMS6o4QxuhZX6iGvQro7xOXhSe0LBkQwzxmHiG
	o2WIaGb/+QbMG8deiPnrvXKe6O1A/W+xlOIWVxQTnz0uzbVPjAfEKq0wUX1xRv3FjFynwXORa+U
	5+zUkdgfRIV5tJzTmYJRyQKZ/8DK265MCJxl6LXIvJAJKUKfr96ONG4PaXGOhtDVKFFK6WPONl2
	J9cNMPdE+cYkXlA7GZhVmz1QEofdBDqQkZCmzP7FiDdR4qeNUR8JslN8CJ0rc4RDkB0PCIQ0IBh
	ck5BjoDTVd7y33RrE59a7RQ4T2ftKwOMnN8/aL4n1j0VM6Lp3UfVY1lXDW1YGAE1oyrZKeSo8X+
	r/y1vZHJHoFB7k/tyf+J9DpRbWO1EB744DZUHWJsDyD7cXX0pdMp7sGD3IpDpc7ca7c3ohws7ce
	49LmCL6wLRCDAxcwAjGVd0TUMgi0RO1MhlTndwv7BI9Zf/LHbL3WcoUVX5kDsppjX1PGe4nJQhw
	R0u4XM=
X-Google-Smtp-Source: AGHT+IEbVRYctNc4A+yz5Gyy1tMc8wt0TvOceywuKntqSSYPrKkT3maN7meDceSemXFvcHnWFEclrQ==
X-Received: by 2002:a05:600c:138b:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-47d7f0a86f9mr14273175e9.7.1767689406312;
        Tue, 06 Jan 2026 00:50:06 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d7fb35701sm12342695e9.11.2026.01.06.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:50:06 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Sriram R <quic_srirrama@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Wen Gong <quic_wgong@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: ath12k: fix dma_free_coherent() pointer
Date: Tue,  6 Jan 2026 09:49:04 +0100
Message-ID: <20260106084905.18622-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_coherent() allocates a DMA mapped buffer and stores the
addresses in XXX_unaligned fields.  Those should be reused when freeing
the buffer rather than the aligned addresses.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath12k/ce.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index 9a63608838ac..4aea58446838 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -984,8 +984,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->src_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->src_ring->base_addr_owner_space,
-					  pipe->src_ring->base_addr_ce_space);
+					  pipe->src_ring->base_addr_owner_space_unaligned,
+					  pipe->src_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->src_ring);
 			pipe->src_ring = NULL;
 		}
@@ -995,8 +995,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->dest_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->dest_ring->base_addr_owner_space,
-					  pipe->dest_ring->base_addr_ce_space);
+					  pipe->dest_ring->base_addr_owner_space_unaligned,
+					  pipe->dest_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->dest_ring);
 			pipe->dest_ring = NULL;
 		}
@@ -1007,8 +1007,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 			dma_free_coherent(ab->dev,
 					  pipe->status_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->status_ring->base_addr_owner_space,
-					  pipe->status_ring->base_addr_ce_space);
+					  pipe->status_ring->base_addr_owner_space_unaligned,
+					  pipe->status_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->status_ring);
 			pipe->status_ring = NULL;
 		}
-- 
2.43.0


