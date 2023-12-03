Return-Path: <linux-wireless+bounces-346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DC8026DF
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D911F211F2
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6C1CF81;
	Sun,  3 Dec 2023 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXM/GQNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED178FC;
	Sun,  3 Dec 2023 11:33:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db539ab8e02so2126318276.0;
        Sun, 03 Dec 2023 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632009; x=1702236809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2bgHWfqDyO3lNVNF7Er5ockraMzuQx9Kc/cYil1cOo=;
        b=mXM/GQNhSGvUH5dY0iRIV7P63pGxaAk57QQSDEZP+DAM7nTnnmYpXmPEB+TLQhRz1s
         67hsLViH79+OO15fdCSSIvuna1YnDa2Ezj26WVDWYUdnPHVhYz0h/mXmDyy459y/ZM+F
         bI5Hs28bPXYrt99IQlrRzwtZxhuwi72wTGspqpolISMr93m3a4sX/5QXCZ5P3diAvyzx
         xuONh6botTUHc9jJuZPq3xat1pKD1DlfHl0l5h2LvkVeYFDqijSjCuK3KvUGQEMXEmGz
         32LiKzIrtYl+2QeYqRsSl9JUh2uCtSCSd2hkT0bNXqoMqX4tNKG9YZcyUdIr10CVpc8x
         UUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632009; x=1702236809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2bgHWfqDyO3lNVNF7Er5ockraMzuQx9Kc/cYil1cOo=;
        b=FHIrlkrUq++h7nYPmoSDrOGgzW0ivBekkTWvkmdFvzcQQMIOdaLU/o72C4CLV5Gau3
         043v8oscl3R+BdccFP4WiQa/K7DtWz6Ea94lhQycftGm0zVB2e9ySgT9hmFIsR+Fc3qk
         xfa9+I8cII59K2rG9UkBksXBl4mjzUoQdniyqXl2lJh23SwpOO0j1udhh8IoLAz46Zy/
         6lQaKEkeIE1vrk2WbPaEs7gFbFqKyt6uPvjZuBPywFzVcdXykJgDtPLcbyscDz6DrtS2
         MNElcOU9Un0ArbFy//bYxqFt8/4M4UnrmXaYjJEqn4m0hbYgLQMguAt8/lE4INFCrnhY
         xe4w==
X-Gm-Message-State: AOJu0YzxtMpeqJvAnqoMoeJfiH+Unb6nJeczrufc0FIaKA9Xd6UyxgA0
	j9ai5kwxgxe8WyRIshAubxsg4jzGw7vCAw==
X-Google-Smtp-Source: AGHT+IETTzlb51Pnj/XyEVoHB9AyqyMCKMnSKLn74ys+Zqx8CWiQjFdSiKyVyEzB+LTTNvzxPlUbxQ==
X-Received: by 2002:a25:cf14:0:b0:db7:dacf:ed7f with SMTP id f20-20020a25cf14000000b00db7dacfed7fmr1778995ybg.96.1701632008700;
        Sun, 03 Dec 2023 11:33:28 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id v18-20020a259112000000b00d9cbf2aabc6sm1763099ybl.14.2023.12.03.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:28 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 12/35] wifi: rtw88: optimize rtw_pci_tx_kick_off() by using find_bit()
Date: Sun,  3 Dec 2023 11:32:44 -0800
Message-Id: <20231203193307.542794-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_pci_tx_kick_off() traverses tx_queued bitmap bit by bit. We can do it
faster by using atomic for_each_test_and_clear_bit() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 5 ++---
 drivers/net/wireless/realtek/rtw89/pci.c | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 2bfc0e822b8d..a0d69c75a381 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -789,9 +789,8 @@ static void rtw_pci_tx_kick_off(struct rtw_dev *rtwdev)
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
index 14ddb0d39e63..184d41b774d7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1077,10 +1077,7 @@ static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
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
2.40.1


