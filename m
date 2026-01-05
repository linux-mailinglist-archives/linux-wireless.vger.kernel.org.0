Return-Path: <linux-wireless+bounces-30363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A7CF59A2
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74C1D302DB17
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8CD2D77FF;
	Mon,  5 Jan 2026 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku+JMIuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41526F28A
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647152; cv=none; b=nYXIU7+nWYZtXp+LHD8JrXj3u1GYclWDI4lQCL31ilDx8OhChjJXxq4q9hVoetXyRJhfRFKRDUv/JZIxcBmtq+ZPm12fkjA5E7NSHTKt9sr2f0YN8u3GiXyUlWT/CZMnjvvBaxGnM9Q4TobGd7NG/Xi79WEHuvvGIrTIhBZWxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647152; c=relaxed/simple;
	bh=DYutQNrGgwXioiun8+u6ap8SX04u9tbSx/6VE5md44I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbUbW2rGLBeuoVHXhqWp5abSGWTMDbs+8zs4Wd7H9Bly+ZANKSckTAISXoWOn2jqvGqx0uFFjldIT8WsTXC9ONZ5qmHFdDRKM3isI15P2oKwLKQt4Erv6WL7ivbfI8fIqozgipA1L+GSF2aE9mhXSrLwEwYB8GksodXM0l/AsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku+JMIuR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so347795e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647149; x=1768251949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExRvh8gizlzCosztwzGXJoboDd+Ig4VaE8sOE6jME08=;
        b=Ku+JMIuRXXN36vx+hTdo6UdaBePSUHw2TfXZDbKwmV+cRYVSrHwlCxD0+pldU/RoTd
         +8r9TEXSC/OWD6mbu+kO+cOf1CP0WEx2heL1S3yKhvDbeZQlDomSoFC6nBR/yzE7Sq+9
         oXosVwv/r1NAsSAK2xeWm9dpCbJ1pPClWxEXFdn80JZqzTj36kQOvISMZ004OQA1NDtP
         6++Yf/3oN0UP26UJSsgrHO7wa/R3AhUthX1r629TA5HQ7AphZmt8A8dB2iNkywRn3vYP
         PVhbBPw37HdzIFmFkrr0KlaWqxVmoaVQXNRA9II97EmGh//nopYxI4pBo4yqD+PJVD5C
         IGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647149; x=1768251949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExRvh8gizlzCosztwzGXJoboDd+Ig4VaE8sOE6jME08=;
        b=bWsiAHzWBmtkbRxstz3ioazNavAhHrVHKt8wDWDvae3x94P8q4+4VQT0BWabDHYSke
         Mi6lZG+kdAmPN0HLldieQN0AjSddyxTEFasW43V/3UwyTe1U/xAvMsSSulTbcqKwLajK
         yM2Yhvmyai7UxvAq716Bj7UWkfAmtH2ubNrorvqNKNCpxETgtvxlAeURUdQ2LRnofOCY
         gtYydtVeITLtRh0ubpcp27bB4UmvmmYmIT9kh94GP1BEyNak4ElS+EA1pnlTxkLuMmQR
         H7SOXZgoIWwMLVdY72zPqN+xlzBE2x3eiksq/jjEpLg3dCByzBy8TWR7ewci7r0g6S3x
         LTNg==
X-Forwarded-Encrypted: i=1; AJvYcCXuaq7n4RQGd9MPbTD7lrHLlkwve1y73idqtK3ofJI9QzhfTFqZlcpY94yNWs2xr8FjTEQZuvPuR78IzOiyYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fGIYG0E/xZl6vvp11Ji4WKZLlDkD8Xxok7C3pFOXMuQDtMuy
	t7FZOegoX8MUd8AXrADtMxAX2Zcqenj1Kwq3LAdFNMLwnxzNNRRLGyCR
X-Gm-Gg: AY/fxX7h7OjUShczP3Yu+uhiL9B+3nDFjJ2L3Ku0Pjr+I+/sZUAzEe44KEh1lY+5GOk
	OH7sAAWxZn88YAAC4CV1lr+Fh5p9okwxRXib1LLsYDLgTMI+nnLmv3Roh1xXUP2y3dl/Xd77mzk
	M1jZn+R3lGrhyNYc6WaOPqMOqnDOv8elbKqiFOa68VeKpfiB6rDrcr8BjUFUj+uNMik+uk/gtD9
	oWq0v7qpgmtMn+SDdxN9bYKr+WaihMyMbLiXSsPcc2lV6RTdt1DZkS3YamU89ektrcA/PauiCc8
	61x+pCTSaQUdFJFNO54G1rMECz7EF2PJJS1RuBZhaxxt5eaxlnqQWQNSCQcFflNb/1nLg5e6X1b
	bgCzoDcf6ekL98m51CvOo0hTEok7WJ+8rHiLzEuum/+EhwfVRI7f9bEsqi/W7mWZoUsm7C6wIQV
	W7PDPaAwrvIEuRErfNfrq6J6vwOzshoy8bm1g=
X-Google-Smtp-Source: AGHT+IFjVV5YYWM1Hac/Fy7//KMT/cxXD4H8sP8nsBaJZGJr9obOAP5rEPdrJ+zyBeOpMLvhACyeFw==
X-Received: by 2002:a05:600c:1f94:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-47d7f09cca9mr5148485e9.4.1767647149186;
        Mon, 05 Jan 2026 13:05:49 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:144e:5eef:4e0a:3841:cee5:ead8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm535579f8f.21.2026.01.05.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:05:48 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Govind Singh <govinds@qti.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: ath10k: fix dma_free_coherent() pointer
Date: Mon,  5 Jan 2026 22:04:38 +0100
Message-ID: <20260105210439.20131-2-fourier.thomas@gmail.com>
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

Fixes: 2a1e1ad3fd37 ("ath10k: Add support for 64 bit ce descriptor")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 7bbda46cfd93..82f120ee1c66 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1727,8 +1727,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
 				  (ce_state->src_ring->nentries *
 				   sizeof(struct ce_desc) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->src_ring->base_addr_owner_space,
-				  ce_state->src_ring->base_addr_ce_space);
+				  ce_state->src_ring->base_addr_owner_space_unaligned,
+				  ce_state->src_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->src_ring);
 	}
 
@@ -1737,8 +1737,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
 				  (ce_state->dest_ring->nentries *
 				   sizeof(struct ce_desc) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->dest_ring->base_addr_owner_space,
-				  ce_state->dest_ring->base_addr_ce_space);
+				  ce_state->dest_ring->base_addr_owner_space_unaligned,
+				  ce_state->dest_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->dest_ring);
 	}
 
@@ -1758,8 +1758,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
 				  (ce_state->src_ring->nentries *
 				   sizeof(struct ce_desc_64) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->src_ring->base_addr_owner_space,
-				  ce_state->src_ring->base_addr_ce_space);
+				  ce_state->src_ring->base_addr_owner_space_unaligned,
+				  ce_state->src_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->src_ring);
 	}
 
@@ -1768,8 +1768,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
 				  (ce_state->dest_ring->nentries *
 				   sizeof(struct ce_desc_64) +
 				   CE_DESC_RING_ALIGN),
-				  ce_state->dest_ring->base_addr_owner_space,
-				  ce_state->dest_ring->base_addr_ce_space);
+				  ce_state->dest_ring->base_addr_owner_space_unaligned,
+				  ce_state->dest_ring->base_addr_ce_space_unaligned);
 		kfree(ce_state->dest_ring);
 	}
 
-- 
2.43.0


