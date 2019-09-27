Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9510FBFD55
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 04:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfI0CwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 22:52:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43280 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfI0CwL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 22:52:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so2609707pgk.10
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tqr7QB4uMDahoLUg1vtMN7U9ziA02RLHNEAHbsMVg8Q=;
        b=ZprUA0F9Kz9I+1mf4ph2986xnt5gq+VieaP85/39gimADAIug8G27MXvVCwI2k0Jdq
         lOzTTgVWLLdk4e9AHKrhacJKL/aKQPSX2KQX+AWb47qSMp0w/TZIw/dynsn3EbG/RKub
         1QRVO+Qy9POFDCUDF+aigEsNOfHyh5CU8+J0AlEPwqkwUvXSd3RUlfNSvS2qeCAJV/2s
         gvzcCbNscg+grn7yjVP9fVByhLvzqFipNwZJzq4Sd8dnisCOubARgJgz4Ie6DN0uKr2P
         U7TuNimma0C6265CggRXAsMa57cKmeVhOkbywUigplS2pUlD4stpxdW5O/g6edcM9g37
         kPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tqr7QB4uMDahoLUg1vtMN7U9ziA02RLHNEAHbsMVg8Q=;
        b=CrOHMCi96XCuZtziVE9m5INi8X/Prv3BnfMyBkX/QV4SPCLePI+mTYwic79Fu6RGnt
         EtB+SjY0arwwLjvB6cLqdMkLioqytYg8Xwhyifwqe4fmzvn5urs5BYT7DRPMcTMvHhxx
         ycR1FQWVKepOvxV/znlivl48hXPdg2aEON4e0sTx/pJLJN758YbDxLSoBjqO8WRYnczd
         0rGMFQFJmB6hAHqgj+oRfPwwm4gzuCoxVCgb23FxC8JXunKPiMQLS5E3DsXZZNM5PTdY
         oslZfFBNw2UbKqrhugJAH4LWTpyKs+5mb/W2LxPYTTi3c+B0amIT2scPVwbGI9feBoUX
         n1lg==
X-Gm-Message-State: APjAAAV2lype9yqeQYMgwr5o3zvHbYAPYrH42D2VN2I7sGvr3oaWOT/H
        6aT0VxM3nAhSDYgMrS6lIUFN2TVw
X-Google-Smtp-Source: APXvYqxMb0zIU42oo8ztOypxpjx/wawH1z6Pkr92kHu1b/YRo5E4mQCyF0mJIC2go4pufXePYqZThw==
X-Received: by 2002:a63:a0d:: with SMTP id 13mr6139874pgk.99.1569552730407;
        Thu, 26 Sep 2019 19:52:10 -0700 (PDT)
Received: from gtx1600.flets-east.jp ([2409:11:53c0:1f00:74b6:e06c:995a:c069])
        by smtp.gmail.com with ESMTPSA id d1sm605963pfc.98.2019.09.26.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 19:52:09 -0700 (PDT)
From:   Masashi Honma <masashi.honma@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     ath9k-devel@qca.qualcomm.com,
        Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 1/2] ath9k_htc: Modify byte order for an error message
Date:   Fri, 27 Sep 2019 11:51:45 +0900
Message-Id: <20190927025146.2888-1-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 4e8e80ac8341..aba0d454c381 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -986,7 +986,7 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	    (skb->len - HTC_RX_FRAME_HEADER_SIZE) != 0) {
 		ath_err(common,
 			"Corrupted RX data len, dropping (dlen: %d, skblen: %d)\n",
-			rxstatus->rs_datalen, skb->len);
+			be16_to_cpu(rxstatus->rs_datalen), skb->len);
 		goto rx_next;
 	}
 
-- 
2.17.1

