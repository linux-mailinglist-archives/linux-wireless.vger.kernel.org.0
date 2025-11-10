Return-Path: <linux-wireless+bounces-28811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A7C486F3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75D14E61E2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E112E6CA6;
	Mon, 10 Nov 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="jmXgRtZV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70632E54D3
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797208; cv=none; b=pTc9v/D1t+HBP9KB+CSD93QJEsHflDnvF/etxiMMJBVO7ct9cgsR/9oSq9pRFC5P8w8dNypP3FkhkPeHU0gmsPkeCzJx8e+u4xhFex4S0hqF7UDkyEnvbqPS4TacK3rtNR2H7LvSdXaw7GdAKJH9+tQuONb5t7zkkJQSQ7W/kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797208; c=relaxed/simple;
	bh=Lt/1CFIZSYE9YGBEOPIRVp2yrsoVFOp/QxdHkcY3gU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcg6BlaBznfJob+0VGSHRCQKB18G30n5mzcQFVFMbV6KHWXTxHfKM4M+Td9YJ8Jlkvn0zBYDRUQjRYTi2QuCMqS7QL/d6pc+QZgPKPsKK7wsLbjrFoJXvnZ133iz6rsRf/x+EcXBj+95JTW+oQSr/OVE58rTnwRJGlxlSB25r34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=jmXgRtZV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7afc154e411so1949113b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762797205; x=1763402005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUcDXkPejgMco2JfdbhYSJS3kdJZuowM1tOw4yzk4R0=;
        b=jmXgRtZVXVmaYY+a9RUmC+LknWuMBbFAh2sD2WP9ZW/VHz+WsoxHoIdJgaI/OJlTcD
         CxKDQmt4yu/5a/S1fkzzt95PAh9ekm0OqMNGEuuSvnWB4cr7uXPuLBYkmuR0LxWpW66e
         PFLiSMlSIYveO+b8FyNR8MRIfq0OHkVmTV/MWWXvlJnemetoevEkYcsU+Hdf037gcz8I
         R0jnW0l9TSXzubmR6elb2a2o3cD4J7d1OexY0X1CG7Ntptr4PPeHN+l6KmSmXrxWR8hb
         AAQqhQWeqS6cp5kZU64AldF2skHRXqmH/mp4diEVK/uvKwjBXge9yAm9DMRtFUgNgMqD
         2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797205; x=1763402005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUcDXkPejgMco2JfdbhYSJS3kdJZuowM1tOw4yzk4R0=;
        b=idc4sO8KqCJhQqN6Ytv8TpmIJxF93EXOFdZtMEXsT4gpLkWp/mIZMh8Ij6SaFZIQ9p
         fouwmgKwDjuzHsC3+1WdkOPs5rfJjcan4y1z75+2NeQ26P2ZErTHPzSo8eyB7FpK6JGC
         FjeGXTwTz6NqEYwguKmRT8ggv+uQZxXui2VdpfUWTH8RcJvfcZ6hDJV2x1dsQrJSubHy
         OUr0x4kiE7RjB+0v9TyO6uEyZQD+R1Xtv7ChVYH0sif4JE55KkSQ6EC3YqTDYQKiNAPJ
         5JHJrdSV+p/d5qT4YPxS4dVez1Q7n+HaDz7ZOdqwzDTj2GQ2tTuej2RemlfOPZc2z89C
         2UOQ==
X-Gm-Message-State: AOJu0Yx32NZsrMIRUSttwo9IB2IvMvtlmenRbnOpgEfId5elkWP6GhIY
	hYdM5jY/4g5Xvf9Ip6C/Z93xM4WIaEF4wowkvF8DZu8OO3EEDBuombhJicRB/16OPL/CRss+tRC
	qzQ0/O7o=
X-Gm-Gg: ASbGncvgP5KIe9jP3dfZvSu4swx3lNxAkzGwR6LWhF1MLOtKpp8p3w0tRoX9h/JplrC
	GZlNp4iXxL4K+lbuQZ7p5skyM5HwccPm1P7ADWiTp03FtUVGwlwAv+N+TDWZwRknG68/7AleWS0
	CYCH1fhcZW1nvvT4QXNyW9j+6sYH2h3Qm/yN+Hc7OOshxrhdQczHHK4egI3MER2f220foXlcIrX
	eoKjpUllmiIqL1DIQUk7RAj5IposO1gBeRvQxnxK5Gb0koZX6TDbEGCSp7dWNy+eCgkPHegMHZQ
	Ns29jg2uE1qTjMJUjiwX3iqGjXQDcXzFCHGZCOzdjE6CUjFpsn+QSsf4Wd3nHS7sjtofemhY8Y4
	hsfjq3GJcio4cKsj7EBHke48p2jEJ5lc1ekYQ+3WH22wN2FdoM8dAM3jjjNzOJE6XVura3JrGKD
	1BKI9I4ZL0DfVt/OGqsQ2opAbL
X-Google-Smtp-Source: AGHT+IFoANBS+IaD+50u8WEIs8LTu+6CF+x94Eog59zLa6zFUQ0ovUDXHwdutBc/eywjQzKVHdO8mQ==
X-Received: by 2002:a05:6a20:430b:b0:352:7cc0:93b7 with SMTP id adf61e73a8af0-353a38596eamr10965577637.40.1762797204710;
        Mon, 10 Nov 2025 09:53:24 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7b0cc17ad4asm12525193b3a.37.2025.11.10.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:53:24 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
Date: Mon, 10 Nov 2025 23:23:15 +0530
Message-ID: <20251110175316.106591-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error paths, the memory allocated for skb_rx is not freed.
Fix that by freeing it before returning.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/st/cw1200/bh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..37232ee22037 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -317,10 +317,12 @@ static int cw1200_bh_rx_helper(struct cw1200_common *priv,
 
 	if (wsm_id & 0x0400) {
 		int rc = wsm_release_tx_buffer(priv, 1);
-		if (WARN_ON(rc < 0))
+		if (WARN_ON(rc < 0)) {
+			dev_kfree_skb(skb_rx);
 			return rc;
-		else if (rc > 0)
+		} else if (rc > 0) {
 			*tx = 1;
+		}
 	}
 
 	/* cw1200_wsm_rx takes care on SKB livetime */
-- 
2.43.0


