Return-Path: <linux-wireless+bounces-9325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67F910FE6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5D1F237B7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034D1BE876;
	Thu, 20 Jun 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTKbvNiQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBC1BE86B;
	Thu, 20 Jun 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906264; cv=none; b=OpH2UUf3W6AA0PnHYFvkKgk3VferXxjb4TRSgHrAaJ05fFk1eVwrF/1Brxp2N1NQ+qtjUkRdvVsaPDYUpM4jXa0g2yiO7mforGnhMSjlvTw9IdiCo83X8vmHxYoSvv//JYbiMoR5uaqxHIn5qIa46c9fxhRg1q53vPZutpbwWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906264; c=relaxed/simple;
	bh=Kq0Le/AzG6nhFQ+X/jkGw++00vhHiyLHVZOAh/AXVkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6aJHpvfrPTlexzKzd2CNQODM/bPuLYbQGXbNyy4pdvMInLcoN0lUC5GmBCfrcfz3bI/wt39Bya0kKq1RpLZBBwFunB+VFuG1Yf903PzZJvSD9Fh0nFtmEwYFDeSLQa6Z8BgFMQ39ovMAJ1aZ+DqRdjntBawgyb30Pf+RX8bSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTKbvNiQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9de13d6baso4397325ad.2;
        Thu, 20 Jun 2024 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906263; x=1719511063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoRopA5ztbgBJRJEKQhgRyu/McLJD9vC3MN+d4zw/zY=;
        b=jTKbvNiQWVes0vDEyyG7Shb/nyfrhRKxbMpNfF8B8b/f0f9Aqa0VC8ZUskzSe1BPL+
         ryoDVXOPPqiNr6jLZfX9kO6WD7hyE9enr/15IaMJgy7dNJUtdTBOvJZUEATjHV8t3KhQ
         htZ7c8N0On6YyDDIThnOF2AZbAumvdP/MJTwZaV6VBpvbtR1qA8TXBEN2Q/g/UlKF6l5
         dFVGV+/3cb61ncD6DQzJo8A/DPOLj93NDp7/rbeqLFx4+Vj070wHSC/+xttzIEkdHeN0
         INk5OUB5zm+Ky+7nNKvRZcOwd5WWukXUlz7r0zE4XXWPNapkB7qOPMDYtwq5EVyzk1FL
         78kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906263; x=1719511063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoRopA5ztbgBJRJEKQhgRyu/McLJD9vC3MN+d4zw/zY=;
        b=n8lyzdvaVfLDeu1utbSDARPIi6PdzVc+i3UGUcyrsugaKFaVIKNCyoIn8AuqWxD8GD
         feYDm2OQQtQ2cOI71qJnuYZqyMg0s4QbBzmvc4qiw6Ye2Q6dI2wdasainhVv1zfp19TH
         ADJanZ7BKCffPnpcWV+R/jCdJR+BjP4QWHQtpnKdKIvDoSuGLkHZOG8OBq0vnd6FJLTc
         qYNmWYYL9lNJ3INGTWC9Rll4ZqUIIzCusmNwi7WoTmXopMr+2TJuFcb8kqiHI5SCmsCF
         YJXLRSopQnEq0V/C5cePZGntFVsWQLIPsnF74TnY2s4HkKpMGpt+HXlIRynLWVsdJnw2
         2qbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCFKQBH8+38o+UYcgQzRI37Gvai1cpSHUJBT+vDxK7FxVO78GnzRtESRvmMq4Ppn8XHKVvdycaXbdgPZBDBb9y1vxr56cAXWHjwI/H0VE=
X-Gm-Message-State: AOJu0YyH6GniuyTuDAYYEvEDgdwrOqj9g7YgliMm4AMq0Xen3b416bhv
	TIYnUXTDvF8OJMeRdoDrZCouP0N2pfBLD4PElLpmOLOc12hHGRQPlp8seYzL8a8=
X-Google-Smtp-Source: AGHT+IFHXkrW2RCg31fg2jAnnLV16IOTYwG6YWnnpIOxreHYDd/8dS8YUOFYNhDpd1HKZjOhC4X4hA==
X-Received: by 2002:a17:902:d508:b0:1f9:d1f7:3fe5 with SMTP id d9443c01a7336-1f9d1f76f10mr22446525ad.34.1718906262729;
        Thu, 20 Jun 2024 10:57:42 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d6b45389sm13541245ad.216.2024.06.20.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:42 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 12/40] wifi: rtw88: optimize the driver by using atomic iterator
Date: Thu, 20 Jun 2024 10:56:35 -0700
Message-ID: <20240620175703.605111-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_pci_tx_kick_off() and rtw89_pci_tx_kick_off_pending() traverse bitmaps
bit by bit. Simplify it by using atomic for_each_test_and_clear_bit()
iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 6 +++---
 drivers/net/wireless/realtek/rtw89/pci.c | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 30232f7e3ec5..28c0f4c99cf8 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/find_atomic.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "main.h"
@@ -790,9 +791,8 @@ static void rtw_pci_tx_kick_off(struct rtw_dev *rtwdev)
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	enum rtw_tx_queue_type queue;
 
-	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++)
-		if (test_and_clear_bit(queue, rtwpci->tx_queued))
-			rtw_pci_tx_kick_off_queue(rtwdev, queue);
+	for_each_test_and_clear_bit(queue, rtwpci->tx_queued, RTK_MAX_TX_QUEUE_NUM)
+		rtw_pci_tx_kick_off_queue(rtwdev, queue);
 }
 
 static int rtw_pci_tx_write_data(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 03bbcf9b6737..deb06cab5974 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020  Realtek Corporation
  */
 
+#include <linux/find_atomic.h>
 #include <linux/pci.h>
 
 #include "mac.h"
@@ -1234,10 +1235,7 @@ static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
 	struct rtw89_pci_tx_ring *tx_ring;
 	int txch;
 
-	for (txch = 0; txch < RTW89_TXCH_NUM; txch++) {
-		if (!test_and_clear_bit(txch, rtwpci->kick_map))
-			continue;
-
+	for_each_test_and_clear_bit(txch, rtwpci->kick_map, RTW89_TXCH_NUM) {
 		tx_ring = &rtwpci->tx_rings[txch];
 		__rtw89_pci_tx_kick_off(rtwdev, tx_ring);
 	}
-- 
2.43.0


