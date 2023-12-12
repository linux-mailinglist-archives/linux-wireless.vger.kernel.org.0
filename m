Return-Path: <linux-wireless+bounces-682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930980E1CA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 03:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6671C21705
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C43D92;
	Tue, 12 Dec 2023 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJLyLa4Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D62B8;
	Mon, 11 Dec 2023 18:28:13 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5df4993c25dso28748587b3.2;
        Mon, 11 Dec 2023 18:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348092; x=1702952892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFEJBK39s2HmgQ9VlPsn5925TKEumn+jH4TGZrUP5qg=;
        b=JJLyLa4QYqY3UTMvyfTXmI+k01iktZdN0dSV/P/pIhBze7LcIH0wjn+tbOgGzLHa6x
         LDzaXWFjoijnWIfNBAzwJunRa6sdZBeqFpS9bP1R/NpWXZ7ud8pWO30VMe+cbYiCXYVh
         LqNBEdLeTrY5/kjUO4IOrlVOcvGzfyFcmklk8GyvbfRNed8SskX4JoaBh1xwRqrTb08U
         2lDqkklEyVBWrclNEwm/hGCHO1U9TZFGtj/Ynu/EFX5T87EYTAUNSK8g6EDaMGXmzE+f
         RLX/YCCX6bJBoHMdnONlevaPGX3YBOPo3c7kb30ssESng6yuOXPQ3e7XP8NLUep9E2Qf
         yX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348092; x=1702952892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFEJBK39s2HmgQ9VlPsn5925TKEumn+jH4TGZrUP5qg=;
        b=bI9VFZshKuS5EttZv9bXmUS/0sZn9qBPI9wjec8TBRlG5F5xJf3kZaEvssAvumnrs5
         bKmprBmQKp9lNXNTgL14UHiwlsFjZjrrYKS1lleeUBgLS3e8BgBxcXRVVfsUuV7MymfZ
         5msAw+lRLb62HkTZq9mS2AvLVORhRgHaVaSYv9m3VhCyY4TzOfl8NBEyYNbtJcsS8EZS
         O2iIkMKADAXxr+gTnmfP8npPV1QgSWUyafGHzjfqQt7CalGx+8NwIL5p3lX8Szks5DNf
         mOZhSsa2LQ5W3Yejn2DROhMpQTBNQDHEwe8gh6+3e/9whxC/QzXWs/soYoAvMf98A0m8
         J1aA==
X-Gm-Message-State: AOJu0YzTcwadPqquOiYx9OWYYcAbjCZZTAcdGdJWMaGbgFYzHBuqbkPF
	b6N0dtC5PSm9abLB6XOC745ibKVU3sKOJw==
X-Google-Smtp-Source: AGHT+IFeSOkqzijdoImeBErfWETX/wo40h7f/thFLgfzuT+2B28dRbzyEy4kpoJKGuVN+4D5yT1XSg==
X-Received: by 2002:a0d:ca05:0:b0:5d7:6a55:b589 with SMTP id m5-20020a0dca05000000b005d76a55b589mr4755536ywd.24.1702348091703;
        Mon, 11 Dec 2023 18:28:11 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id x9-20020a0dd509000000b005d951c0084esm3427568ywd.21.2023.12.11.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:11 -0800 (PST)
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
Subject: [PATCH v3 12/35] wifi: rtw88: optimize the driver by using atomic iterator
Date: Mon, 11 Dec 2023 18:27:26 -0800
Message-Id: <20231212022749.625238-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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


