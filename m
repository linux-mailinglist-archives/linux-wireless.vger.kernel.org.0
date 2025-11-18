Return-Path: <linux-wireless+bounces-29065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D984C66D75
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02177353EE5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F52DD5F3;
	Tue, 18 Nov 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGsllzeC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162202F6593
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429621; cv=none; b=eT/ixpvmWfr0FetlbBsfq14ZlFp+VrI8EUdqJXXL3HnwCaOGmskXNhDKBpE387Dwc59cROBMES4XW6IsALUhcLaW8UpQX+7ZAZ8vu6eBbbfz9tiBAcQea33dEOMvbeHk5x1HyMP5e4xtzZVZR3vwvwPpkZ5n1vqr2thBxB2CKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429621; c=relaxed/simple;
	bh=EaDA7R6DVAC3caD85wSgI0FDHY2jIQ8AA5ESbZa9QP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0LBFjWxwT0j9OIbsOJ+DH3vcctRfz/g2X2+cINotakNoz7hsHE+7vP8UyPwImcTh8WP/cXMoa/rM5/ZxPzQ9ABWdFS3GzOLbnXQB5Zug+tLH1EGQDbt6+O962AnhEDauFEChr1tzu71FE0/YwQX2DmiPvJ/ks50X2o4XZsdCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGsllzeC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8845498be17so2299666d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763429614; x=1764034414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikdHAo0H0R2rcJjr6KUHCBoyesYlheavNuP3/u1nKGY=;
        b=DGsllzeCI+LqoDRcV3CbRTJNznR45LZGkAmkAtN5sLFaeCOhL19fa8sB4a3pcF64cj
         /f/LCjGtsORN4HL70SqUxsBBtxMdi0Wk7p5cogX+V+w9uaOkvFdZ8Blka3lrKOd9pdsg
         qafgmXFDg9TAE4sM+DDqE9HJNqUl8KqRdnuCcPE+Am92aCXKyGaCxcb1fE2poeLwN/lL
         jAMu0/tFXVX8e7Puv06TzwrDd7sNtxtgM922Ah8Qn9Lx0MQ3d2qrJIbS9BLmsJz8EBE2
         80+tFL2A/QjlRRdc7xTcAFLOGhpmdg+aZY9lLGQbosoC0ETY94LxkMvcC2/CMMQJzRLM
         qSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763429614; x=1764034414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikdHAo0H0R2rcJjr6KUHCBoyesYlheavNuP3/u1nKGY=;
        b=YPbvffJKMQ0gI9NRO8dTgHusQqH2GQ4ml/VwRaAUyy4hLMzR8jkr3R8vanzyoYxSb6
         gp64YMqCIb8F7b9Iw4WHx4M0DiFJH4N9of5lzHbUiqPGr5I+YsQ+NRVi9/gUZ3NMubE9
         o+EfCHXFqoHwv7II6XgCD5Q1WfDtjtuyNw/6wdci9BP8g4PA8gmqO+r9s/GJzj4+gEgI
         gwog6/0tck96t9LOASDZRmSMmKc32ag9ynw0DLgTiSK/bbrScZVj2oqNyRXtSQ4dOrw2
         fneEXhB1bglFvWUnRj+8w0cxZ41AEBSazhzmzr6G9oqBsoWBoKHzCorYsmqAnl+Q1xvG
         wYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVzvqqVMheoWomvH/EPFBjMR6dQj4zGzUH4tM6fXJvgWGJtXYbAbKoukp5bMh81BQqCXv1vPVGEUC1/pW3YaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMzkONyZNr6CV2z3+KGSJGqJ7XHBp5qi83gvN6//g80DT2/b7
	Lok5PY7S1hyDtHP6rYbcaD+QLx/hh+x4B/xs/GdezJUPpR5NyKiMp3wsxtdSmhGL
X-Gm-Gg: ASbGnctQAKma3vMDQNd1MDRzRxv/fHkvqOOiF2Qu6avzycryJfB8SfhWHNngiLGYBGq
	cxJdfz5bJcAVio7aUrqz347HmegfAEDlrkK1qJGHg3DuG5Lk9Au/ZD8fNUB5TcOOYDpIJopCouy
	xZ6G6kINKawSweDKtoiLUHlOD9M0srDGhYFHn4S0AFwk0NxwYcUAKdjkQaqskrex4qMLYES0NL0
	WzIlwwINbBX2zSQ1ZvfFHZzMpXBbkNTIgeeunc4sqx6R1CCsTqcmTjDPJ1oI9/sLeX7vLSEGjuM
	VkPfwXHsiG1/Yf/J0PMOZxmx94FUEy9rc09AKsmviroQ651CoBWphIpVUG+L+RDxsU5UnqmL5oV
	gRuBfmZR2RPXZLdr2SamZ15ZEi0QSuLEwcP0TdGQUesE9YM5xiTbpQvR5m7y/queTBN4nu4Worq
	2t8kWtZDqyfauQajvz84yRz6s/0kHMfO9ofXu6skanD/pov0Ms+/QI+v2jVwqZTdkxoDfoQ/HFL
	TUwAoLAPOzDm2wJU2aASYquynj/xF7pS3pUIgn4BQ==
X-Google-Smtp-Source: AGHT+IHOadgjPaHIj+5EwBNHBV87PTaNQIJ2DMf8yS3mtjD3oroeoRJFO64v1ns0jok8VQkO611hQA==
X-Received: by 2002:a05:6214:76e:b0:7ef:4bbc:7767 with SMTP id 6a1803df08f44-8829269e0eemr232607936d6.52.1763429613643;
        Mon, 17 Nov 2025 17:33:33 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286318333sm104928426d6.24.2025.11.17.17.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 17:33:33 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Hin-Tak Leung <hintak.leung@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
Date: Mon, 17 Nov 2025 20:32:59 -0500
Message-ID: <20251118013258.1789949-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aa04fd38-a1df-4d16-bf16-e24a848a00f8@web.de>
References: <aa04fd38-a1df-4d16-bf16-e24a848a00f8@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The rtl8187_rx_cb() calculates the rx descriptor header address
by subtracting its size from the skb tail pointer.
However, it does not validate if the received packet
(skb->len from urb->actual_length) is large enough to contain this
header.

If a truncated packet is received, this will lead to a buffer
underflow, reading memory before the start of the skb data area,
and causing a kernel panic.

Add length checks for both rtl8187 and rtl8187b descriptor headers
before attempting to access them, dropping the packet cleanly if the
check fails.

Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Addressing feedback from Ping-Ke Shih
 v2 -> v3: Address coding style feedback from Markus Elfring

 .../wireless/realtek/rtl818x/rtl8187/dev.c    | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 0c5c66401daa..7aa2da0cd63c 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -338,14 +338,16 @@ static void rtl8187_rx_cb(struct urb *urb)
 	spin_unlock_irqrestore(&priv->rx_queue.lock, f);
 	skb_put(skb, urb->actual_length);
 
-	if (unlikely(urb->status)) {
-		dev_kfree_skb_irq(skb);
-		return;
-	}
+	if (unlikely(urb->status))
+		goto free_skb;
 
 	if (!priv->is_rtl8187b) {
-		struct rtl8187_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187_rx_hdr))
+			goto free_skb;
+
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		flags = le32_to_cpu(hdr->flags);
 		/* As with the RTL8187B below, the AGC is used to calculate
 		 * signal strength. In this case, the scaling
@@ -355,8 +357,12 @@ static void rtl8187_rx_cb(struct urb *urb)
 		rx_status.antenna = (hdr->signal >> 7) & 1;
 		rx_status.mactime = le64_to_cpu(hdr->mac_time);
 	} else {
-		struct rtl8187b_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187b_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187b_rx_hdr))
+			goto free_skb;
+
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		/* The Realtek datasheet for the RTL8187B shows that the RX
 		 * header contains the following quantities: signal quality,
 		 * RSSI, AGC, the received power in dB, and the measured SNR.
@@ -409,6 +415,11 @@ static void rtl8187_rx_cb(struct urb *urb)
 		skb_unlink(skb, &priv->rx_queue);
 		dev_kfree_skb_irq(skb);
 	}
+	return;
+
+free_skb:
+	dev_kfree_skb_irq(skb);
+	return;
 }
 
 static int rtl8187_init_urbs(struct ieee80211_hw *dev)
-- 
2.43.0


