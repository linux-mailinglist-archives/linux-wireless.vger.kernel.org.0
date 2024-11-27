Return-Path: <linux-wireless+bounces-15753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA29DA4FB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE6285D36
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0724193416;
	Wed, 27 Nov 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFHqgD9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589B13A888;
	Wed, 27 Nov 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700642; cv=none; b=i8DvEea9Bb26IQmMY4Fq6iKtEAs0ZkJcD7TvJdEMXZJ+6mnhYlSqRheq8vzbd12YJ7Z/lpUUOrrFyAfDDaZpsNhYCLZ/OMNJHqyteqeE1idkIoXYxKXRfdf9/Y6mszBwtQCEiccsHy30ZpsesAhVEONvj4i2Uodf64zjMhojvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700642; c=relaxed/simple;
	bh=oYhtZ1jN8eKmPGIhNaCBo3qgy8HkZ0en4NnnBSgdXwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikg8yTE4S3RH2OqdaAtzoAZrpudU56J2IXLSntLhtoREdKv/W6QyiJNfDnijU6Q7vyh30RDobS+YkVLDBMgBQnGaZlVj+/KvlVAY9EmRnfRNBFHggVjdP8FRAXKvn9ZcwPhdueHhC2pZwFk4/TLr3XEeroGZJtUrD+TqGbJj2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFHqgD9I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea4e9e6ef2so5159391a91.1;
        Wed, 27 Nov 2024 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732700640; x=1733305440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoFcqYTJpQSjF6BsiEup/tHDY+g9XJsfXL/ccQA2FU8=;
        b=QFHqgD9ICHqxVanLlESBD73vGFC2SU5oUomeyH8vbe3364nEQ459o7szCwhbUcl1h3
         OVUKLMO4XymGLtDuJe7htjOTi1C7cFZkS00rzf+TT+EFXI6j7fXnCQh87sQe0pxbMvVJ
         j3gI8AVyym84lBAEb90vpTm9qBi8ajhQhw9ula4VfYk5dE6dL9/sCZJe8IpRfqgSd/Ll
         HiEtwNR08vzj955gXW6pyFuGtitYCLWS3vV2WmFsztS9EbLPkNyzeYDPnPHgMgukVBSD
         Q6q0FzGt91fLvMo5KFN5sCnqFk4yaq+nPntIu0zTSdy0X/uMqr2hPfKdwIDWojkAuzwO
         w/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700640; x=1733305440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoFcqYTJpQSjF6BsiEup/tHDY+g9XJsfXL/ccQA2FU8=;
        b=s+SNrfHBElb+gHmfNzNbIVZfODunI+iNVxadl1hflrnloT20xVe1m+hC7GJcpFKaDh
         JIBx+OlK5KgSLgUaHQIXpmA+lnVuLhK+C4suVmjgLsgN3Hv9YjtAIL7I7HF6oFiSiDKF
         UqxaZRv3qKN65tWk0OOCUZ+MOTcprSKK7M1XMTOYlZHHUSFSOAwRXoEjJOHqFXk+kp+L
         EnhbmXSTs3ByJtY8ZbS/ktusJTOSc/rKPap3xQehOEgLS1kW71OaD160m4GXAobL92Fx
         BIa4SZnAuCoVqFYCEBQe9OBNgXCc6gSQo1LAFkiqmpPQw+fctMoxK6Ku/+Tka7G9PlYC
         ltrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFxIYj27+MU1JKI33syf0wdnizC1djrRnf1JjwnU3qaxh6yupUAGnGPYxm+bf12ibREbfSZPvJ6oS2PjhaiO8=@vger.kernel.org, AJvYcCUwv28xSd2zrZhtvBa4r3llebzpbvlIerspFKUdqQoRKCiE/dv+juEBO3V6C2Qng6tMTOHTDUIlBm2nFLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7HdPX0yOY+R3FSkYoVd18qngFNCEhV/iFfI/erW+AGnb24yM
	6fIWYFaDIZ2Fy7sf/K9X8MzqeOr9nV+9AxoygALgcx4Sz072AEey
X-Gm-Gg: ASbGncv69GML5D8Uhp2LGi5qnaNOCQ/jNN59PVc2QBgcHSPZHvz9GMmqZJfBfyDJKRI
	aVqOgFJSUZo192hkKUW7Vi6cYQ0tdCaCQZYMJPQI8AX8FZLkTR6eRaFbuwya9HBomYWtgUD3ZA/
	rCcv3v1hUMXK6QPx4zf33wrlIt6AXoUcK2bLBLW+hW2qmowWryyyOnwRCK7cTlvscKZpteS+p+h
	o8YsKsm9Sp4FarGb6vw17UGq/3/CiHQyqwDiIZTGhLCdH5VLXslROba6SQ=
X-Google-Smtp-Source: AGHT+IF4YBQ5R2ogJZut7ke432SKKHDz7Ixuem5LWStg75TNRXhrr46Ou1TuK+emhmQ7woHGw9l4Eg==
X-Received: by 2002:a17:90b:1b51:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2ee097e51b4mr3265400a91.31.1732700640197;
        Wed, 27 Nov 2024 01:44:00 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa41f7fsm1155250a91.11.2024.11.27.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:43:59 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: [PATCH v3] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 17:43:17 +0800
Message-Id: <20241127094317.303815-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a77fe99d-079b-4ef3-a1ce-6aea10256860@web.de>
References: <a77fe99d-079b-4ef3-a1ce-6aea10256860@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the NON-NULL check by changing the OR (||) to AND (&&),
ensuring that the function only proceeds when both `dest_ring`
and `status_ring` are NON-NULL.

The current implementation of `ath11k_ce_rx_post_pipe` checks for
NON-NULL of either `dest_ring` or `status_ring` using a
logical OR (||). However, both rings, especially `dest_ring`,
should be ensured to be NON-NULL in this function.
If only one of the rings is valid, such as `dest_ring` is NULL
and `status_ring` is NON-NULL, the subsequent call to
`ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
resulting in a driver crash.

Link: https://lore.kernel.org/ath11k/a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de
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


