Return-Path: <linux-wireless+bounces-28935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7585C598FA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 19:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7493A6A67
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC4316188;
	Thu, 13 Nov 2025 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBfocsAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237D2DEA78
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059628; cv=none; b=qwgPRYGO89KiNQHBVIvN1kPsCfg9EY12cxprmezlTpmSaTQp29MM7pI666Q5yP7+n3GODFU3GSfgPmcHlBa66OUmeNbK2xT8/9N0EOUSBBiC59CvEfSuhZhGmSYmOIq8/0YTJFJ32FBXSc9e2N/FbAbVW3VMR9wMQI0R2gmhKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059628; c=relaxed/simple;
	bh=AEYu0vHePKHhlXiw+wtsZbGWlUAKKgWtvlMl4a3SqzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7VloEHP3TrTkVKA99hTUg3O1x5V+KN2G2UFEvau1U4/KIRD0VsNtW7cCvBx4bqBxU3H7F0vmiBy6HFT6IExJ9QgfHEAx3G+Aab0f9z3AmixIGOBulW4axHkRKG/GgmhEuBlkOcLJVVIs/JHJW57Mnl+fUa7WunoaJbzCYLuw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBfocsAR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88f2b29b651so115907485a.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763059623; x=1763664423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvsdwBPqpvbPMEI6oTxpi2WOx4rn64tuW/Zp9XGZRd0=;
        b=jBfocsARyT5hQQKzAimm3JzmNcLCQ/jxaQUWaYxsNMMex+2MJ+wCA+wmti24O2MBj6
         /foFSOJ3NFpA3alOxeJGhEarL2S2Z26fI++YkeL4ghpBD/ZQvOY/YF5c0kVu0z2je/hb
         rUKqNkrb0tAS+ktODdI9eLljynaHsx2DQ+AOQPVE1Uz7CTmbmqClka9iJYBr5rpukv0T
         koY0YNgcKK80RAS/r061PAr/I+W61x9xRC7R6QfZdnXoA5cnc5HSrn5SXgufjT5WWtb4
         tB2aTxgvWDyeiTpIForS2V8FeQG5/xLlHLH3SqROM/W52Euk3yTxMq8fPrvifU091G34
         LXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059623; x=1763664423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvsdwBPqpvbPMEI6oTxpi2WOx4rn64tuW/Zp9XGZRd0=;
        b=flXnkdoVrbJh1gQypLq+7Urus2oe7G1IrW77WI8jS2boxEJD/3Pal96M9NPoE/+ORl
         g3ln2iPud7HlzgEVPrlRitfPM/sPkb6YheWS0kYaZO0+gIalBWUBZFTQFbmsrfpbsvAP
         zHoXA1TbpQbJ4lVoLHQCaVH6g4Gwhv1gPu+zouM/xoL9k8aYqhITZEV9JUvV4t5poXyC
         SJPvx5XvqVLZ2OjcWjSWuth6XRUDDmhKnruqHHHTkHGZPWTbRu//psgyvQZzl+0R9zma
         x0+B/qr2AnjO5FLYBPPcwPGSl5dvt+RzCPKm7gfItGBNuI0qTEk/k33T+gOaALbMbAhb
         BPAg==
X-Forwarded-Encrypted: i=1; AJvYcCXYJHLrMSuOD7tqbdJnLYlEv82ivMgbJSyd8XVQVYjSmzLSlnfMSMZj4h1wf+BOLl0BaQdCLfHzSYDo+SNlcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AZcnzVh0DLwXY++lKeolCj2JWD+gDU8ERLEyiu9QDgqZNZ2B
	GJDBAO3IfVaNohZWF0s6yMd1uye8gjBOuoyXrkSufwNgejrDUP8dw91o
X-Gm-Gg: ASbGncvp3I805INYDr9Acb7CHcxyC7E2BYmOgP6vJMpv0gmNlJkyY1f1oYl7KE8xLIp
	lM0BAYN2z75i6UeGYqGvWO48Jl79ghhlEGF1u+nnJ7j0SQgj3PItlUDxZo75cta2+E0b4ncJ44p
	9uXWuJMOyh8KQT8aCIdyrd9haNd/2odX9SHHSENFfO0YtAv7+wUil855ZXDXzB9Xis54oNzqNIl
	mKAZe6uSmuojJisMdrRItArt9xAmbauoNDQFVi1AZQKe0JhgdFSU6sB9RaU2WxFyH3Mpr8db4rl
	BgXu+75DsXAmMU+X3xEfOvTvNF1tUgyWfUFnOdW/H2j79xAVcIWd+uHgFUUNs7MtgAnihB7N/UW
	IHXJS1C/shjz2W3KjpU7cMkvLlXB8YFtAyLmzksnlkAcGL8il/n/QAEW+EV/o73+yqCCourJl1L
	WyRwPDib/i1Bs9Wt580hhHhnxDWBU4BoHf2UqWORngXZkqFGGT8dN9xuvMbGQYtuIIKUjxi6vFt
	PiqXnTVQOAPYb5qh1JOV44yuWTy9k0=
X-Google-Smtp-Source: AGHT+IH3InWBGWlCMYupWUVBrRqlbaHu5eEfs1OoTcoYk3eD1OrI5bKS0JrlheVnrRCn26zA4PKCKw==
X-Received: by 2002:a05:620a:2945:b0:8b2:889a:124b with SMTP id af79cd13be357-8b2c3130660mr64071185a.5.1763059623199;
        Thu, 13 Nov 2025 10:47:03 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af06334csm179025685a.57.2025.11.13.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:47:02 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Hin-Tak Leung <hintak.leung@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
Date: Thu, 13 Nov 2025 13:46:27 -0500
Message-ID: <20251113184626.748717-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch adds length checks for both rtl8187 and rtl8187b descriptor
headers before attempting to access them, dropping the packet cleanly
if the check fails.

Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 0c5c66401daa..eff42acc11a0 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -344,6 +344,10 @@ static void rtl8187_rx_cb(struct urb *urb)
 	}
 
 	if (!priv->is_rtl8187b) {
+		if (skb->len < sizeof(struct rtl8187_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
 		struct rtl8187_rx_hdr *hdr =
 			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		flags = le32_to_cpu(hdr->flags);
@@ -355,6 +359,10 @@ static void rtl8187_rx_cb(struct urb *urb)
 		rx_status.antenna = (hdr->signal >> 7) & 1;
 		rx_status.mactime = le64_to_cpu(hdr->mac_time);
 	} else {
+		if (skb->len < sizeof(struct rtl8187b_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
 		struct rtl8187b_rx_hdr *hdr =
 			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		/* The Realtek datasheet for the RTL8187B shows that the RX
-- 
2.43.0


