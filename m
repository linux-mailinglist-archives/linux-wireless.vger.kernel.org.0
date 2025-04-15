Return-Path: <linux-wireless+bounces-21544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D809A89A54
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FF03A9697
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3347F28E609;
	Tue, 15 Apr 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuyUh4Kz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC1268FF4;
	Tue, 15 Apr 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713094; cv=none; b=dgONz3Y9X6NK6fH9M5UPxBKsMwj3D9tHQFdB0qG0i1U10yeyNtdeNdD1P0YI3Z3LOlCMPSRud/7DyX4VoKMZVHy+EARHrlOSUZLhUM/RELkQcJPWp9rcc8JiB/dLZlzewLNsatpIYyyC9p/ov0cae5gIiaqJPhcG9VjZBs7KkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713094; c=relaxed/simple;
	bh=dzyFJ2bsjyCS6VKRFAcX5j/tALFBa0b1kmk7JYDqOtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeBmTkw7waXNrK/y1lKcTmmj/6twPGPHeD7FCp92yRB8N4W6RXJlVAuLXZu2JPQbCMkAKLo40ksR2FgHlqmA1j10jfzCjDv0Ah8ujKudxitq9KUlPeu2fgyvinZbizOcyb6xfP3oRxo12IHqUOlLIWbpAz2oLSwXV014Teaub0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuyUh4Kz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso55573325ad.2;
        Tue, 15 Apr 2025 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744713091; x=1745317891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piEHt8DNlbripb3VCl/uqi4OkVU+QF2L2YSycFXtwDM=;
        b=RuyUh4KzeEn2fRzxwootVF0vG1efvmxxEHdbkCtE0MvEsq6NwEX9kLjoOJheB6+PhA
         uQ4GyUlZSuheTrc+cEvaqFnTTBXG/RMWCKKEdeSACTa9ZaKw6NbREMzya+4dghtr8rX7
         GzBldtHTgJiQeRS9fS77rYYnLxMsxZMMCYEQKEmvhSWy39+0eSh7GyhtouuN6Fgl3nnp
         ev8rmAPOA0bk5CvDyVOTau0VVz+t02t2+H0clWWLjvU+A20H/nJZmAEUwF5Uk4tzURZB
         Z0QB2eXZhmoN5EfQOWlGAwA2w+2hkHw1r3PXgGdwkMMN3J052CcaZYkhEc5+43lEpfoS
         pHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713091; x=1745317891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piEHt8DNlbripb3VCl/uqi4OkVU+QF2L2YSycFXtwDM=;
        b=t/xqmvTxk8dKmbyR+7sH4wEHmTxBVMX6Fy6pm6J3i4ccRJ5Ajih48knHT+CL8SzYO4
         K/tykB8xsUvRnSe6nsNCDtj0xqW4CDkZFu+P4A+k5dAuncj1l7PV9BG3flSWqSkpW9le
         ezrfWQ8pJuCYvBMvKurzrip2GpAvD7aR6zUD9CULhkslN0vAr6lk80R2vzBJHx3xnwQ4
         B4GLzsXOpeWzOP7hs4J8H96neuXjIhaxGyiukG4V8GpMNJP7cbrkAso3Q2L/ceyd7Ind
         QnotvHc9xGn+gR0zjFSzvNBga05ej7grEXShJXRRrpZQe5mcLM271eo+DRdWqASokntM
         ZeDg==
X-Gm-Message-State: AOJu0YxvgHWn4pJDmlhLbC42g8XuBkooLn2t2n4NJ3M34MYQGvcmG77J
	W5UylU1Fz9nTXr4sd+k7cFyjnZAtdq+NlE5KqUqaUufWXdEF4ybTa8wZX0pV
X-Gm-Gg: ASbGnct1TeYEtIDqiKyYDtq8tFTZlYU7HdOYChclhyvrjV2+opc3NCu/Hzm8SPphZKB
	9XaBINLXniBw8k2zk+vQCc7y0aevhn9wIde+yq32avdHRZl6S87OSHYRnijATjZHDIP+KcetE1q
	Q1TTrXVxpx3SZImFQOWT2KgEghQsJyLgzm3CDWRBHY3VFblPkJOgnnwfgHnxB4vLHv/mc2gsFQ2
	H1D127zMlAjoWi6PflmaYMywFhLy/oy/ojhJ1IMjsGz8n2u7gpRV0ZF7yUdIAnSsrcnzFdpaHpr
	1RUz3sCY83zDvbqkXL5Od59A9MuAEK6qt183FN5TkEFxY4vDOvD6k3NI3oyaacNARqkjPHcDc9w
	47qgaiSELaESIbCY=
X-Google-Smtp-Source: AGHT+IHa+Rn3BvIokQWTUXbZmtv34dCtR0nHrMMRe4e5bk47q3z/okjU2coLi4shJ32ahTXHgP6Imw==
X-Received: by 2002:a17:902:d492:b0:223:66bb:8993 with SMTP id d9443c01a7336-22bea50bd60mr231442515ad.43.1744713090953;
        Tue, 15 Apr 2025 03:31:30 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd21df771sm8158292b3a.76.2025.04.15.03.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:31:30 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH v2 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called after probe complete
Date: Tue, 15 Apr 2025 18:31:24 +0800
Message-ID: <20250415103125.15782-2-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415103125.15782-1-zenmchen@gmail.com>
References: <20250415103125.15782-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1 ]

At probe stage, we only do partial initialization to enable ability to
download firmware and read capabilities. After that, we use this pre_deinit
to disable HCI to save power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231110012319.12727-4-pkshih@realtek.com
[ Zenm: The rtw89 driver in recent kernel versions supports both Wi-Fi 6/6E
        and Wi-Fi 7, however the rtw89 driver in kernel 6.6 supports 
        Wi-Fi 6/6E only, so remove the unnecessary code for Wi-Fi 7 from
        the upstream patch to make it apply on 6.6.y. ]
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
   - Add a comment explaining why this patch differs from the upstream one.
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 ++
 drivers/net/wireless/realtek/rtw89/core.h | 6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 535393eca..d1d8fd812 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3807,6 +3807,8 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 	rtw89_core_setup_phycap(rtwdev);
 	rtw89_core_setup_rfe_parms(rtwdev);
 
+	rtw89_hci_mac_pre_deinit(rtwdev);
+
 	rtw89_mac_pwr_off(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ee6ae2a0c..16aad0f83 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2989,6 +2989,7 @@ struct rtw89_hci_ops {
 	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
 	int (*deinit)(struct rtw89_dev *rtwdev);
 
@@ -4515,6 +4516,11 @@ static inline void rtw89_hci_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 	return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
 }
 
+static inline int rtw89_hci_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.ops->mac_pre_deinit(rtwdev);
+}
+
 static inline void rtw89_hci_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
 					  bool drop)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 98af64444..7787159dd 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2568,6 +2568,13 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -3812,6 +3819,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.write32	= rtw89_pci_ops_write32,
 
 	.mac_pre_init	= rtw89_pci_ops_mac_pre_init,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit,
 	.mac_post_init	= rtw89_pci_ops_mac_post_init,
 	.deinit		= rtw89_pci_ops_deinit,
 
-- 
2.49.0


