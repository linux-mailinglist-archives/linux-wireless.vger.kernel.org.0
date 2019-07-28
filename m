Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE077EBA
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2019 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfG1JMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jul 2019 05:12:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55429 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfG1JMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jul 2019 05:12:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so51266995wmj.5
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2019 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0kYQisBHnLOdXLSjCfP/ODFYydyQtXafyJpgUMrC0A=;
        b=StxhutJxVuTH4mBogwc3Qe8lGKCkwyfJpFPjTnbnvs+Gw0JJ4CQpQCZyeDgqd3eSWI
         HEjjZp0BE5GFEk4qWmb2Poj0vWiWoScj1AHMAe5DODCSeHOPQRp7x0WAHiSxkx4Eh16x
         iBqDprZb+xG5xYwOHzg7INB0YTrCAHCk2vDJB78FW9w7gwTD2XgPMuJjjm1mG5Rq+I2B
         lnlPlv8Qwh0fGnAvL282d/kxcX1vHcSVSVHbZjezqOFIhktMmC6LaWXh+nEXmJtENNFk
         tFrnsJAEJr+YKjngndgumos5XGrrYX5IEplU9nTM7StxdMA6IywfoavnXfEPIG4BFn9O
         KVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0kYQisBHnLOdXLSjCfP/ODFYydyQtXafyJpgUMrC0A=;
        b=aQfT8z5EhFUjeaWgBJhGMJgBn5utQm63pQB3Fvrx2/zEzcUUIaNv+eDOaCDjieLA87
         dAvbSjzp3fyBYtfo0xsi38s4f37hsFqUk5lDfHQPf3j8Q90nymPpSEXurrxWdY7MR3+3
         OPZ/hFlN3cVvU4gngO6C89tuVqkbrvRWfLeRCEg+pkkT1sfXUnUkzd9w7VbNJdClXJam
         GOuHqZto1GF8AxW64f0A1JttH9YO0mUpducGRjkwcHWuf0O6rqutdlG2UUY7knVqa4Tt
         gD29W0xnMhrznmj68jBtdyCOn33+ZM+ziup9y86QGilWcTuq7SwOM5jqnbVrOJy5Iyst
         OQbw==
X-Gm-Message-State: APjAAAWOIlvAhqj6Hd6GJCYZkVCdDHatt2X6fQwer92uLDyBY+a0DQlp
        jALF0HY73MmOLgA3L8XMn/2oLVGA
X-Google-Smtp-Source: APXvYqxeAx0g0bcA5/2hHiS6DMdQhm80OjwGw+z4Pw+4zZ2jMoPGNnRokrRGefabc+1/BsCaglKL+w==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr27559036wmb.32.1564305122532;
        Sun, 28 Jul 2019 02:12:02 -0700 (PDT)
Received: from localhost.localdomain ([31.147.208.18])
        by smtp.googlemail.com with ESMTPSA id o20sm148358246wrh.8.2019.07.28.02.12.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 02:12:02 -0700 (PDT)
From:   =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH] ath10k: use ath10k_pci_soc_ functions for all warm_reset instances
Date:   Sun, 28 Jul 2019 11:11:58 +0200
Message-Id: <1564305118-3059-1-git-send-email-pozega.tomislav@gmail.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use ath10k_pci_soc_read32 / ath10k_pci_soc_write32 functions for
the rest of warm_reset functions. Until now these have been used
only for ath10k_pci_warm_reset_si0, but since they already exist
it makes sense to simplify code a bit.
Runtime tested with QCA9862.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 drivers/net/wireless/ath/ath10k/pci.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a0b4d26..bf16f17 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2567,35 +2567,31 @@ static void ath10k_pci_warm_reset_cpu(struct ath10k *ar)
 
 	ath10k_pci_write32(ar, FW_INDICATOR_ADDRESS, 0);
 
-	val = ath10k_pci_read32(ar, RTC_SOC_BASE_ADDRESS +
-				SOC_RESET_CONTROL_ADDRESS);
-	ath10k_pci_write32(ar, RTC_SOC_BASE_ADDRESS + SOC_RESET_CONTROL_ADDRESS,
-			   val | SOC_RESET_CONTROL_CPU_WARM_RST_MASK);
+	val = ath10k_pci_soc_read32(ar, SOC_RESET_CONTROL_ADDRESS);
+	ath10k_pci_soc_write32(ar, SOC_RESET_CONTROL_ADDRESS,
+				val | SOC_RESET_CONTROL_CPU_WARM_RST_MASK);
 }
 
 static void ath10k_pci_warm_reset_ce(struct ath10k *ar)
 {
 	u32 val;
 
-	val = ath10k_pci_read32(ar, RTC_SOC_BASE_ADDRESS +
-				SOC_RESET_CONTROL_ADDRESS);
+	val = ath10k_pci_soc_read32(ar, SOC_RESET_CONTROL_ADDRESS);
 
-	ath10k_pci_write32(ar, RTC_SOC_BASE_ADDRESS + SOC_RESET_CONTROL_ADDRESS,
-			   val | SOC_RESET_CONTROL_CE_RST_MASK);
+	ath10k_pci_soc_write32(ar, SOC_RESET_CONTROL_ADDRESS,
+				val | SOC_RESET_CONTROL_CE_RST_MASK);
 	msleep(10);
-	ath10k_pci_write32(ar, RTC_SOC_BASE_ADDRESS + SOC_RESET_CONTROL_ADDRESS,
-			   val & ~SOC_RESET_CONTROL_CE_RST_MASK);
+	ath10k_pci_soc_write32(ar, SOC_RESET_CONTROL_ADDRESS,
+				val & ~SOC_RESET_CONTROL_CE_RST_MASK);
 }
 
 static void ath10k_pci_warm_reset_clear_lf(struct ath10k *ar)
 {
 	u32 val;
 
-	val = ath10k_pci_read32(ar, RTC_SOC_BASE_ADDRESS +
-				SOC_LF_TIMER_CONTROL0_ADDRESS);
-	ath10k_pci_write32(ar, RTC_SOC_BASE_ADDRESS +
-			   SOC_LF_TIMER_CONTROL0_ADDRESS,
-			   val & ~SOC_LF_TIMER_CONTROL0_ENABLE_MASK);
+	val = ath10k_pci_soc_read32(ar, SOC_LF_TIMER_CONTROL0_ADDRESS);
+	ath10k_pci_soc_write32(ar, SOC_LF_TIMER_CONTROL0_ADDRESS,
+				val & ~SOC_LF_TIMER_CONTROL0_ENABLE_MASK);
 }
 
 static int ath10k_pci_warm_reset(struct ath10k *ar)
-- 
1.7.0.4

