Return-Path: <linux-wireless+bounces-29846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6DCC94A6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 19:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD3C30495A5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B827462;
	Wed, 17 Dec 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqF2kxmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AD2DF68
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996044; cv=none; b=RvuKjhAqQkWJFnc628LL1klZcN1Fp+Zf+XbeGYVqty9wso9Mo9TE2SM8PQkGuo7HMhzauJW2DuoInH728r1sm1//wvY+E497qbBvSqSDc4Hqv8Ul5aNhU3ERdgLsqp+zftaliC83BJFSn1DFEyub/I/jwlpK6BpYF3Ma0EwDp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996044; c=relaxed/simple;
	bh=4tGJnne2NFnkco+2ExBr4DvRZ1JDl0skj0zzTsPXHMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXb5Bfh+/4bv6orKkzDXY0jZr2abJzQpvsWfsbQauI+shV/Tp/Hl6EnSHJRCUBgiP3rEv2LABqF6KIzI7G4RrjLdSaGeQgvt904ge/e5JX7rjjTRiZZtUECKdo08RUW7oQsaKHfX0y9z45YOATVs1yGSBEnCOA+YioeB2wdB2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqF2kxmj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735b89501fso797953166b.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765996041; x=1766600841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QDfUKXoI43WGoz8hYBIesMjA58VBd3YInpH3TkNqD4=;
        b=cqF2kxmjDuzN9nGyDtV1IgjrKxtOS/vYZZazt6bdWl2MqGD84uVFee+W6AcHM4o7LZ
         D2dvWO7NauER19TLJkdgHeQ9R3l1j9dwx8lZFiaMCwhxsBIxmu6yoyHlTTIKCh6lB1YP
         4J45INmszDc3AjIWUmDjq1Ba7B6HlpQuPZFujoziwIeR3WEWXYR+2z4+xTgxNUMr3Ws0
         75PiTBrDOTHi0e/CYmdpgyydvFsqMEnymm9fLQtwR3lwvUhC7Up7Jl85r/4WY2otMjAk
         ZpFQVYhsTstJzauEctUGGoytw8t3DmguDlpK7WwXx5r+p7rWTAER2IgK7/qGFwxg/7aY
         neUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765996041; x=1766600841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QDfUKXoI43WGoz8hYBIesMjA58VBd3YInpH3TkNqD4=;
        b=VRU3ek6tPJp7IHJ97H40Xv0Bte/EO74NH0ldwSEbp9YTfbSt9Au70jmonGKQKJeLLf
         CYHcvWaD3gAEe5z/YEn3SEId2HsuX/M22GkvZjmr0jIVcCmLwvs4XYnB4/aQqePFFvAJ
         3yGhJ63Bk4fGBDd9PhdOofprnvyb5/P5/n0gXjth6j+d9QsobwjXJzqWkiVlIclPJUb1
         CcoZ5rcT2sUPYn4YVTFOH44MCnCaQ5mSTpnin7+aHUWEFpZdQzP5H4TlnNCT1s7CwFcE
         sbeWFcudrW++ss2UMTXfFNHetxS2ooJ1dtyuXnAOpAjf7MzlCWdp4B0vgy7kqFhNMWRW
         iSiQ==
X-Gm-Message-State: AOJu0YxCo26mOCbufYkRFAT9qBc3spYnkRUdYzLHT6ZAidtvdGKU1o4U
	TbyqXTfu9TF8V2fOWeK0r/X6tCLpcOOF1rAhBHoVZFWUDUzhn02qJjnC6ZZXKg==
X-Gm-Gg: AY/fxX4dwVJz8c5RwjhOIsoDdPMpVkDLCddkx1h6dnnKmC5uKPg0mZFtFtI3ynx77Nw
	iVR1Fp1KsL0E+LG2BkaEOg5NM9FuMPDMn0A6W6e5MBya5n+M5z5kGN5+JAn4KIh+5GdPNI2fl2C
	1rqHxCY8kWmir62YgqQO+SFy1sIMWSpIjz4XcuwTRzPxS7d2uTfQyzJSLdlTuevsVxJkJznkCGN
	+cNNRG3dQKk3hKSmQDHzUZUrwrYldw3Mp1hMtMgujvk2s3QgIQesff9dQnonK9QXuxfAjBbY/GX
	IxTVsOw8MI191mkz3shyWQVpUBdh+ZJIpwR16ESibDxBmZGXBVu3XjFVIEd/gCOYo955aVHXifl
	VVthbwSIpZqepZNv1vP3aZh9kZQffuUDEjTK74KyO3kSfXvZrWg4+5BtbKQ5zOMRGr9hcF2gFo4
	n2NDouckoAwh4Wi5llPKWTdITrYLi2iu34bqLN2tP3YzbkPx4vYipF9nlXpoyhYN8=
X-Google-Smtp-Source: AGHT+IExiedRiHnM03Bk0QF4dlI7lKo9R5E3c5dx58bqzYD4o7MmU8riRaWM/LDQiAeyXf1hWGQesA==
X-Received: by 2002:a17:906:f59b:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b7d238cf0e4mr1667778566b.36.1765996041143;
        Wed, 17 Dec 2025 10:27:21 -0800 (PST)
Received: from zefir-PC.neratec.com (80-218-237-147.dclient.hispeed.ch. [80.218.237.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8020c49efasm15084666b.64.2025.12.17.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:27:20 -0800 (PST)
From: Zefir Kurtisi <zefir.kurtisi@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: toke@toke.dk,
	nbd@openwrt.org,
	adrian@freebsd.org,
	qca-developer-program@qualcomm.com,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: [PATCH] ath9k: fix: avoid updating TXDP while EDMA queue is active
Date: Wed, 17 Dec 2025 19:26:26 +0100
Message-ID: <20251217182629.1144973-1-zefir.kurtisi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zefir Kurtisi <zefir.kurtisi@westermo.com>

ath9k has a long-standing TX queue corruption issue on EDMA
chipsets that can be triggered by bursts of TX requests.

In ath_tx_txqaddbuf(), when the FIFO at the head index is empty,
the buffer is enqueued at the head and the descriptor is pushed
to Q_TXDP via ath9k_hw_puttxbuf(). This is done unconditionally,
without checking whether a previously programmed TXDP is still
being processed by the QCU. If the QCU is busy, overwriting TXDP
corrupts TX processing, causing frames to be accounted as sent
while some never reach the air.

The issue was observed in the following setup:
  * two APs and one STA on the same channel
  * the STA sends directed probe requests to both APs
    (36 Mbps, VO, NO_ACK)
  * if the second probe request reaches ath9k_hw_puttxbuf()
    within ~30 µs of the previous one, one frame is lost

The problem is highly timing-sensitive and can be masked by added
latency (e.g. printk(), slower CPUs, or an artificial usleep()).

Fix this by checking for pending TX descriptors before touching
Q_TXDP. As long as the QCU is busy, TXDP is left unchanged.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 75225c1..62b2249 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2422,7 +2422,8 @@ static void ath_tx_txqaddbuf(struct ath_softc *sc, struct ath_txq *txq,
 	ath_dbg(common, QUEUE, "qnum: %d, txq depth: %d\n",
 		txq->axq_qnum, txq->axq_depth);
 
-	if (edma && list_empty(&txq->txq_fifo[txq->txq_headidx])) {
+	if (edma && list_empty(&txq->txq_fifo[txq->txq_headidx]) &&
+	    !ath9k_hw_numtxpending(ah, txq->axq_qnum)) {
 		list_splice_tail_init(head, &txq->txq_fifo[txq->txq_headidx]);
 		INCR(txq->txq_headidx, ATH_TXFIFO_DEPTH);
 		puttxbuf = true;
-- 
2.43.0


