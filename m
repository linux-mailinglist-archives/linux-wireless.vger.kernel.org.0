Return-Path: <linux-wireless+bounces-15083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A709C0775
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F9A1C20C3E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1018318FDAF;
	Thu,  7 Nov 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMMtM+oS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CD20FA9A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986184; cv=none; b=XYuAwbkt/uj10mYK81ZjXuKOjrponqTmhmGSYc3fphd7cR9dE/TEAlS9M8J0DxKfUMgwhYSpylPlJKE2XXWgnXrx6UJ4Tde+zec6QUrBaLYPFMoYv9YjqV6TKhfoqLGskWaJrYPBnErJUYacdQHQS8QvRft3U7/qcMw2sdNsRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986184; c=relaxed/simple;
	bh=JPx5Yy366qriUZJPznuz1j6aJBb652orJPWVANgqp9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdhOk1imaHczsl3c+psinrh3PMvlGiXxXD7DnSRFqMx1JX129TRJNk8zbQATRYZ5a6TYGK40M5NMqAt43o2JwkOLZZStoOWhVEl8+uyJrBsOscHn5JgXfuGrQoxBKrLhBISo88UHFeTRnDA8XenMHGuXpFXRkU5Hb0kcSePNB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMMtM+oS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f2b95775so1102866e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986179; x=1731590979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3R7ZL0no5oqV13HdTl2lduOwzKG0mLzPGiwll2wJ10=;
        b=gMMtM+oSb9iRJPdctPwqgHJ1wbuOyYkDvOMkncmZtx0oC4iXm3QX9lj6h/7bRmrX8+
         3RYBZhl86RsdDlUqdJGCCL+ntwSIbdUekCUhWcus+retZ6Daw4xnHYF9sMIfmJ8xd5iQ
         m85qTrTXOEg6TFuaXbygCUmND10YpFQvZ54I3nuL4sdQYvhaXpXEB9je1unBFrRFMew9
         FwyKzL2hVSZBjzNnXn8VpjnlW5KcEJS6FqROZ4CVkjG8uDyBCZF1lAvcA4BrGqWNV6fq
         vNyx3Cb0E3pVlOYxhqR8AXL4qe9lFP9ObF+SWmyoIG9MrUQ04FOlMq6Sx7+jXwtnbiIp
         CZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986179; x=1731590979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3R7ZL0no5oqV13HdTl2lduOwzKG0mLzPGiwll2wJ10=;
        b=TkMG/UrxPoZcIPbJLC5+siYcKz97lsQ3LGfHX30XQ6upucmLb5d2m2epEgqlcZm6LK
         oykV1VfXi9+q7ShNmeh1X2WFuxAojdacUJV+NqrCP9sySMrJBKofTuGnPg4LlbHqv+mI
         HwlapFSA5GYYBnRc4fHjPX9JOWdZFiT/aIcPJ+oezV2xVimEZodMiPCKo1TpvaZ8ppPp
         +3v5uWLdWC5Sas2Wa3UrpSJcfGyLk97HsTKbuN26A3I/f7KVJK36wBXMj7AJccyWuu9J
         nSf+D4tyoqNq5o6CVUIC9LBLDOQpIsiTdm/Gt6mIuYjkS/k7CIpTiVGa6NOB+CJJrbC2
         /EMA==
X-Gm-Message-State: AOJu0YzjJQlkV1YmUL3WI0D6e1K9aF0jlZ65/22KJpVuKpee6+nWsQmN
	RtIgXVUjBDuViaV/5Z7we/egBe+ze9zkJG7lN9DBqrBEX8yOd2fQ
X-Google-Smtp-Source: AGHT+IEDpMGA6FOc1dk/vMrHMeEQBGc7ESDqPRGsevIRrEuMSDQohjeGdZxKD/nFlExCJBMdIueWug==
X-Received: by 2002:a05:6512:e89:b0:53b:4a6c:1849 with SMTP id 2adb3069b0e04-53d65df29fbmr19496324e87.35.1730986179023;
        Thu, 07 Nov 2024 05:29:39 -0800 (PST)
Received: from wlt.. (144-178-92-130.static.ef-service.nl. [144.178.92.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176a6sm94086866b.16.2024.11.07.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:29:38 -0800 (PST)
From: nvbolhuis@gmail.com
To: brcm80211@lists.linux.dev
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	arend.vanspriel@broadcom.com,
	Norbert van Bolhuis <nvbolhuis@gmail.com>
Subject: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer dereference in 'brcmf_sdiod_sglist_rw'
Date: Thu,  7 Nov 2024 14:28:13 +0100
Message-ID: <20241107132903.13513-1-nvbolhuis@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert van Bolhuis <nvbolhuis@gmail.com>

This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
are sent from the pkt queue.

The problem is the number of entries in the pre-allocated sgtable, it is
nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
Given the default [rt]xglom_size=32 it's actually 35 which is too small.
Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
is added for each original SKB if tailroom isn't enough to hold tail_pad.
At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
NULL and this causes the oops.

The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
the worst-case.
Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
additional bytes of memory.

Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 17f6b33beabd..42d991d9f8cb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -770,7 +770,7 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
 
 	nents = max_t(uint, BRCMF_DEFAULT_RXGLOM_SIZE,
 		      sdiodev->settings->bus.sdio.txglomsz);
-	nents += (nents >> 4) + 1;
+	nents *= 2;
 
 	WARN_ON(nents > sdiodev->max_segment_count);
 
-- 
2.42.0


