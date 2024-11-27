Return-Path: <linux-wireless+bounces-15739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81D9DA127
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B094168420
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A0288B5;
	Wed, 27 Nov 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpu6TYAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D32126BF5;
	Wed, 27 Nov 2024 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678400; cv=none; b=HtNb3w7sI81m5ugo20951m6Z58GCMBrIsbSukeMm2UWSCHNQPhgxubUH4o8DQFQnWAUEMyMRrgBoC9Jid85n/CfaF/qiHr/kVFaUqfL3tRT3EXQwY/Qtbxm4Ons02WcajHjpmgBPgxF4meNXSDEAt7r/KOirM+N1j8hnpUdBe74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678400; c=relaxed/simple;
	bh=gLNb4J6oJ9RFFWk09zFtGKaYReuRMraK2dS7HiIQghQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1R4SLmHj6HuIAgDQ5oWcswiNsKhVr42VMCBCpcWV1EfCNV8Q2wUKT9GePm5a/q3lAJvNIeiX2z+6IvjqH4bvx8dxLLldfaWUV4k4+TQklcNdA1ygiJg/GGK0JdU7OCVwuQr3DSB7l3f6BIR4lixViQ6JGj2zubIS8s8px3BIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xpu6TYAE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso4192685b3a.3;
        Tue, 26 Nov 2024 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732678398; x=1733283198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNFL0BV7Mb4x6Fh0ZaK/xjfKcHVlGKbOO70Q78B2CSM=;
        b=Xpu6TYAEQbd6ABooN2VugXS+g545yMHwEWOB2V3S3Prs6rOfcic4lyWmm61DYXpb/c
         1Dd1FGqAyTfF+e5uuE7HT4ls9G4Rf5m31vYVY1enG5/duK0K6ww3nVVJ1a0LdBwcNHHT
         lTyf9ct/8eRN6NNbdG2K+dTfORcKF0tEmz+/VFetmQPykjIjWWKAfoBoNSrwIE7aHRl6
         RMyqUms3p+w7Hu87haJUuKhuAACN4LADdYIR5MRjMdUuRvfJZL8ah9dAUA4tGusOyQoD
         fFIaNgbqXRZJxiAhGQveVDDJ/3QgChqa1Y2o+yfdGVpfURl6pJpaP6kV3EuRpHeexifd
         37gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678398; x=1733283198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFL0BV7Mb4x6Fh0ZaK/xjfKcHVlGKbOO70Q78B2CSM=;
        b=ZdJJsxZmVT3xnivG2U5nsyIwkjfP2FgxJ66cxrpEm6DpJhqoiwlocQf3WOKjoupvmq
         HPfU/Ne4gNMusxxUZv72mXkwx808F273TOpHvGRSwYneta3NxOIhA0oAHaANrds0eB2v
         MXv6U0YxaHhP58rgvr7INgIX9SIm49gw6QLWjXV9LNMHHkFXlSX7HTdu8oT3P9BA7eqb
         ca25U/mK/yDxzMw1asAxB7n66ewYHPh1iD+todpRzIz4Ra/+SoomZ2tkPn6tsWaOm98f
         GlVtzbLVxFUHV6Mi6ELPrzhG3NuHJXcusuA3jq4CbB+tbGtdIgo5s6/DRC5Orq13TRqP
         r20g==
X-Forwarded-Encrypted: i=1; AJvYcCUOse2P4b0mocooOYV5sDXN59wOuB/SI4grfRVJFh+lMJZ0IDYJ5WJlQGFUOJ+U8LyI36Z2ThpKMQnnJvij4Yw=@vger.kernel.org, AJvYcCVlUwn2QRGRtEaMNlTcd6zyXsGGFWOLs4q7Z5L975fhNrcZG9KvuQRCJ62YZtjAfJp1Fld5nYKqXjfLBRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHh8sq2LkB8ALQUayLpkFWFWl73UZEv2BKP/TjZTmGuAb4XaB
	Gu8gZlr1MgofG+DMo33OMJgqKvda7jLx89pVJcDTBXEIqhuJG4Dz
X-Gm-Gg: ASbGncvkwpgFG+zC3m6LMoIP5glAA8KAJPxwy0PCZYVE02GQICfPVC3+AV0wgm7D/R8
	G6+FAUCiUxCRC/xMsSsBTGXp6PqjRbTEAiR8NOYs3m84kBTfZwmdC1oJExj4iQ+SKIFC6+B9QaZ
	7kHscr5ZRZOJaMrVOe8kvqFqomgNR7cMfRO3iqTNHqle56kvljzIxbAsFDjDK/WpzdgF1YtV7Qx
	wGeI9F4JRMwia7HUeIet9q820atxiXshXRSbK69Q2I6xNHEBN/aDx/itAA=
X-Google-Smtp-Source: AGHT+IF9h1tM8BSdg93H0W+/CAgEXZ1IPcpLB/cuUojd4Nyan4flXiS5rwt4tMHeQhfpdoI8SqUjtQ==
X-Received: by 2002:a05:6a20:3945:b0:1e0:cc01:43e4 with SMTP id adf61e73a8af0-1e0e0b12154mr2723008637.27.1732678397396;
        Tue, 26 Nov 2024 19:33:17 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47e941sm9168699b3a.78.2024.11.26.19.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 19:33:16 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: [PATCH v2 1/1] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 11:32:41 +0800
Message-Id: <20241127033241.60478-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
References: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the NON-NULL check by changing the OR (||)
to AND (&&), ensuring that the function only proceeds
when both `dest_ring` and `status_ring` are NON-NULL.

The current implementation of `ath11k_ce_rx_post_pipe` checks for
NON-NULL of either `dest_ring` or `status_ring` using a
logical OR (||). However, both rings, especially `dest_ring`,
should be ensured to be NON-NULL in this function.
If only one of the rings is valid, such as `dest_ring` is NULL
and `status_ring` is NON-NULL, the subsequent call to
`ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
resulting in a driver crash.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
---
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


