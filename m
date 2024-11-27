Return-Path: <linux-wireless+bounces-15758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E99DA6EF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 12:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4686BB21025
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31551F8EF8;
	Wed, 27 Nov 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4U98T4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAC1F8AFD;
	Wed, 27 Nov 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707831; cv=none; b=W11eTn5KNxJEnTbxY+TXEMvmJwtL5J1kR+1sqDscFZWbwtgrG+RP38wKNlAhs/U0app1T7tCQl9U1yWGBl+vfuYqzzaxcBvh6PwudvL2BmuVA+CubPNjJQo5o/aOK6PxCEDJdOgiOLIltUUSOoSAeP9wA3YH0hipa6BbcvjfoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707831; c=relaxed/simple;
	bh=QqIFzL95u92FJ2dFrY0Hk2QYTWK3YhksIaMwY2a9vqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVILbN2+iwl5EXQpLn234rxnTZV1wPF5WCFSKyYSLwB91RQ59brC239t97xOl3ryh/umjQTyCPoOS9hj4vb0VqxvhNbV38kXYsKaHmLhb6NvayAuDbzhv0tx1EtyiblNORLyVePSJSMCm17NfDs0km4/0L2VDt5lUr1Mmd8xrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4U98T4y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so5234927a91.1;
        Wed, 27 Nov 2024 03:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732707830; x=1733312630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxSbLAHRSVlRsq/cq4uSZcTsBky57XnC1dO2nem3UBA=;
        b=Q4U98T4yGZ8uZ3n3sPZ8bSlOUOOargcI5yRSLnvgenH0sFdwhhNLQUyYFWNs9y1Vjo
         clFlRGYsjxHBPR2z2vFV0swHBRVzk8+J8P5QSd/VDow83rdZ8cSV7hawGotf9BMF8aZM
         P4Ix0ZsA4APQPImyTbxhkF4Ri4aYs61TM2jCnT/OJjsyRnjK8JLUcGrVvnpE0+A2K4L9
         ePqbD++QjuXi+599XOPQekDDE/oE94r74uz+cRBftMihRVJBGWcQKVkR6QXMYw5E/zpI
         /fHbR1m9zRjjJW78XeGm4zMbWNa+UxehwxILA0x3Po0RNTrxgDPxlSLx4prepDdxrBFS
         k8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732707830; x=1733312630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxSbLAHRSVlRsq/cq4uSZcTsBky57XnC1dO2nem3UBA=;
        b=gek8GDsT7IFR5vjUpJmmfRCc9iF2HOSIW63VjeLPia26t37rfRr9Y3S8JtezqxKWCR
         c9ecO2+WfEETHy3Dy6qlxHaVqP7VuNHqOI3Z/wRByKg9ps6rUdIpQbBG2UoQgne3I/7w
         nbc3+0wIxzXiFg9OYJzCFk7BUqzyZ8ILwhJMjOC5jL1TxQQkZ+iSLCat0he1g/j8s5d8
         dmANMUw+9pSIlHza2g0jdelnfeTNvCiXNfpVTRp7Ni7zaFAaFDko++Yk5ztQaj5BviqZ
         C2GleK5tqHKcjHkiEA/ldiMrq7UDtoXrhtmsXaqcsFExcAyvCJYl4i+aetpvwI7D7nKW
         8D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8g3yXidjgAg0COxQFPQAgRYIlAjQB5TLWM0Omai6DrPu49ylPta5tnazOfMETC25ou5nM9hMdu6MeMfXxBWA=@vger.kernel.org, AJvYcCUNRdbZ0/Q8mt9yHJ7m/SUqhNVrwvr4QbpRijYLcULd81GfGS74UBTH3BdVbHD0wkbMHIwSX32Yt53I7wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFq8Hw/OlXib9d86yboFmK+mto+wleJVV/GotL6BLiFR1UeBUH
	KNpJflT9lwa6VnfaKR5H0Cg9iwDRzni6+ZxotxkevlASkdbMawZj
X-Gm-Gg: ASbGncuQ7KOFan2MQUF0IvXiYUAHtZD+E6tgLoJB5mya3P/HjtfQPtKvNHUTa4BbKEF
	eTEtbrR+gy3jBINXptyCXX95kZeQD4429bPjihfwY912r6xppEs/aBvimC6VSC9FuVmZZKmdl9h
	UxkhtE7+XdIYYPx090xscqJeBCk2OnvgcPo10TL1UOhzqEP+9rnCxzUC7BFnr2j+ui6cv62jC7Q
	T24T3AT7vH1oWV4WWwqImTOBX5G9txeUYDhI+J1GySZdvxn63G+4Xr0+nc=
X-Google-Smtp-Source: AGHT+IELFrmOn3UMip8RyR2/J8mMZUZh/mRNybF/pjN095lAFdf3BfbRFYSu/uLilRm80EzueWBlNA==
X-Received: by 2002:a17:90b:2b47:b0:2ea:5c01:c1a3 with SMTP id 98e67ed59e1d1-2ee08daf0a4mr3851522a91.0.1732707829275;
        Wed, 27 Nov 2024 03:43:49 -0800 (PST)
Received: from localhost.localdomain ([223.72.121.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fab815csm1277113a91.48.2024.11.27.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:43:48 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: [PATCH v4] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 19:43:10 +0800
Message-Id: <20241127114310.26085-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <64d7fa52-b96c-4bff-b90c-98f0b1d15ac5@web.de>
References: <64d7fa52-b96c-4bff-b90c-98f0b1d15ac5@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of `ath11k_ce_rx_post_pipe()` checks for
NON-NULL of either `dest_ring` or `status_ring` using an OR (||).
Both rings, especially `dest_ring`, should be ensured to be
NON-NULL in this function.

If only one of the rings is valid, such as `dest_ring` is NULL
and `status_ring` is NON-NULL, the OR (||) check would not stop
`ath11k_ce_rx_post_pipe()`, the subsequent call to
`ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
resulting in a driver crash.

Fix the NON-NULL check by changing the OR (||) to AND (&&),
ensuring that the function only proceeds when both `dest_ring`
and `status_ring` are NON-NULL.

Link: https://lore.kernel.org/ath11k/a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
---
V3 -> V4: reorder describe info
V2 -> V3: add Link URL to mailing list archives
V1 -> V2: rewrite commit message and fix tag

 drivers/net/wireless/ath/ath11k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..cc9ad014d800 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -324,7 +324,7 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
 	dma_addr_t paddr;
 	int ret = 0;
 
-	if (!(pipe->dest_ring || pipe->status_ring))
+	if (!(pipe->dest_ring && pipe->status_ring))
 		return 0;
 
 	spin_lock_bh(&ab->ce.ce_lock);
-- 
2.34.1


