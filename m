Return-Path: <linux-wireless+bounces-15675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7A9D7AFA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 06:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D76281F4C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0914F9F7;
	Mon, 25 Nov 2024 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l17D3MGN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8F14D43D;
	Mon, 25 Nov 2024 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511356; cv=none; b=UKeL/ga8HRIp+faAUhqROVhorYqrjN7tqM95H3SHwpP5MwQaP/FfNXVnNRCxlf+7RFxrKdpLzfk9qUXLpVLyvF4MgpMXrE+yplTkZOl9VfeEONzILxivtx03HegrPIEPY7qyfxDjuCdoorZVUgVaIpD7ajz+YS1aHqaBcVV6RfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511356; c=relaxed/simple;
	bh=oBpCpFwzKOS9kNJbMir6VNoqd576gfiE///ekgUQy2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2PZJ+hGVHz2hj59mlkmnUBREObMqyT/vDFyQBojPFpzkT4sxwxIVcH/NkN3g80kdJ5tPP66XLB2eCxcWapxjglQbtX03ZMf22QNx6OvjdLZjjlxglICuu9vO2DVhL4+JY1qcXW8atE5zc/turbViNZgyPyBaPRxJXPJ2s2+ZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l17D3MGN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21288d3b387so29041665ad.1;
        Sun, 24 Nov 2024 21:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732511354; x=1733116154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksHQJb34QqtN+KT+UEF2FYuZsjJBthTlyXY3J2CcoiA=;
        b=l17D3MGNvLYqnoCLj4cgJbeXJ04Vq5FHqm4CtPI+wTpv5Pks7FTU/EhE9D/C2Goh44
         857yG1jagoxhQVZjvRFp0ijWQ0qLS83jGDWhE21s8dDNwDSc/QAhpwmIiyQnghcux75N
         dnEEmhg5T2dC9vF19Fx6TVDaufl61MvroYjk8UX0sc2Jjl5PuiG6RfqMBpSoitSZFT2r
         7EVRyXHb2CvAsSU3cxIT1Hx8T1YN/cXrT3jktMAT1/V/JQpN+nqlXNUPUosW74bD8jAH
         3RcvpFHLm5cD30zfb0Tcz1sfCPl6IT4cDvP4K83KWhTJR8qKW0JicpX2/MbiJGK1xyaw
         u1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732511354; x=1733116154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksHQJb34QqtN+KT+UEF2FYuZsjJBthTlyXY3J2CcoiA=;
        b=pat6Le3R0aAWJUE/EmQyQY0iQEG1FRzYi7JxMj7X2sY/Lz0133Rd9jy20deyXz8J1e
         QH9ScHHRgSDNmsdGtTlFf3VivxU/Jl8Ovw+a7H/yTrm1uDb4eHzVbokzJRAo+tvLf7s5
         4BURVtrb9RONsWU3httFKzoiwppiCpiJ8FCgUeSYSyfR4tLAxpeNma0h82ze8osvuSzr
         m1b0vUDFa6A+sJMhBa6Xus/fTJ6roomCDRxmYYteFBZ4qPhiTDUU+6O+LqIe5rrMH9Jr
         TA2QKhiUQYMmTFnrxwSlOJ+0C3HYv0An3Xr7PHdd2okJO1A15c0C5IOthhAcpNMdhupQ
         tS1w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5ORMvlBKORMu4lVBdh3xIH1LQEKhEamq5nbiCPgWdoVorusjRI7YhaXShJysbZ/+Uhzx54NXgorVcfk=@vger.kernel.org, AJvYcCXcJEyYfrEWAh3+NF5W9K6une1TqJZWky+nwcmcASEHP1l9w3/Ec9leDenkKTKN9y2+O64QGTLPTsabPUOfv5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/Gf3DkbSZ3+a2TjukrBxjDkwwW4PgpdoX6N9bvXV0/0ktMEX
	IL9ItS3Uim3mJIHJLxEIXPZKLDTCojrV12JpxUqyzZJANHOEmRg9
X-Gm-Gg: ASbGncsHOoRDGWaM0MPARPhUaZS8+f0zv7jkg8AhhH8cuUAAt5GClKfW+D+/WI/3DLT
	b5oiFGmvKb4c/xP6AlCOFLbKMRATOqsFVBS5NyVV4iTt4O8ikaJtMMxJb8WP3UJLRqIETAwmUS2
	6FVfOEuKxST1O3CQOmVbWi5svTp6QAmkIg5PGYy9q1I+F8iN9zcKQNyeU8owrZ9H2nMMCsufG6D
	Zk6P4xur2H+FZXzW+fX6BQ9E/dDUgrj9vnWx8CFfNHGywhMG3G3/gkflyQ=
X-Google-Smtp-Source: AGHT+IG63PxHo5iTotrnTrhDmCs9a973/JWeKIYwPi+EO97WB1upfgy+iNKydb5IhZi+y2Qjw7diaA==
X-Received: by 2002:a17:902:da81:b0:20c:ee32:759f with SMTP id d9443c01a7336-2129f680ca4mr157420345ad.39.1732511353664;
        Sun, 24 Nov 2024 21:09:13 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21a1asm55071445ad.222.2024.11.24.21.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 21:09:12 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: kvalo@kernel.org
Cc: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Baichuan Qi <zghbqbc@gmail.com>
Subject: [PATCH] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Mon, 25 Nov 2024 13:08:21 +0800
Message-Id: <20241125050821.149898-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous code used OR for NULL pointer check, whitch can not
guarantee the pipe->dest_ring pointer is NON-NULL. When certain
errors occur, causing pipe->dest_ring to be NULL while
pipe->status_ring remains NON-NULL, the subsequent call to
ath11k_ce_rx_buf_enqueue_pipe() will access the NULL pointer,
resulting in a driver crash.
If it is assumed that these two pointers will not become NULL
for any reason, then only need to check pipe->dest_ring is or
not a NULL pointer, and no need to check NULL pointer on
pipe->status_ring.

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


