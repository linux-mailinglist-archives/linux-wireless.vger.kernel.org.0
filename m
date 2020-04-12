Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0E51A5FC7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgDLSaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgDLSaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 14:30:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C9C008681
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 11:24:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n10so3583777pff.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PVvAuZcC+jYSt4UujoVoHghzUI+WSaJdhVbDp2XqxPI=;
        b=Yp8a5C+Qw8pwBbmYhbDMkyGdjAJ6fFf4WxqMQiR7gQEkGUTe3clYE1tp4TbsB8QUIe
         2fmHHnMsEAw1oWOC8wx/3oHJbrOXFn1IJheIyW62J+yxssMEY3N1zLI4tAWktRtp0SEH
         UYrAlExJh24/YFW8HaZfDfb6moDU/b/N3U30D50dGc0VjG83tvLKGhPWSQjCBZdMlzdW
         df0fUeQk5K9Sq9xt6HTODzAiTI7qFhkiZyyrnSM0Up2zrnHAaFxOTv24QZSsrSf/L/Zg
         +hxlz3Uj7Lz5xnDHTyHLe40Tu5MLi17CY7/0kMNlv4o5FJaR838cyl4xAN9wa73jZ7pK
         offQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PVvAuZcC+jYSt4UujoVoHghzUI+WSaJdhVbDp2XqxPI=;
        b=O44r8rXhgi1bP19d4VBF9ho3HC3YphEkKb0A3B6A9h/S6GOL5LgCjQiTWas5jJTWhq
         +vo2ehuiaati19GMuh10qcjOoz4UxNKyd4NAl4BuCMzybHAOkOKR9eBI3OBMfyyOymQX
         vTeW8mQk8dNUTVRkvANyQ04sz+yIwUJcTLAVcb0+/FMgCp8sDI9PdGZ8MyqdeNY3JQiH
         M6mjTuMRqFc3oQ3p4J/EZ9iTDww6MZmkcN7DI013Bj4qrBSSxjUgMLOP7cWiGiT4Rxbi
         zt6+3pABdW/d5gV3NuL0JoIGo+VpXJPn6lPXMYvwHS1FF8K+8rNSpS8QfHtjKulymBMx
         MyBQ==
X-Gm-Message-State: AGi0PuZN0fu+OLjyHshxS41vSAbQS3xE9B3kZYuAj+Z4ieIKHwUqA0Kk
        kT3aJTdCUlFmN7Gc/yDVTiA=
X-Google-Smtp-Source: APiQypJNMCunUad9ZOy2DbCZLMLc4XhwjB6MBvwd1z9uRQhIFYVKE9n8bYA02JhzRk7U18bxp7aKzQ==
X-Received: by 2002:a63:1415:: with SMTP id u21mr7470882pgl.452.1586715898235;
        Sun, 12 Apr 2020 11:24:58 -0700 (PDT)
Received: from localhost.localdomain ([203.187.233.102])
        by smtp.googlemail.com with ESMTPSA id x76sm6406956pfc.190.2020.04.12.11.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 11:24:57 -0700 (PDT)
From:   Mamatha Telu <telumamatha36@gmail.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Mamatha Telu <telumamatha36@gmail.com>
Subject: [PATCH] ath10k: Fix typo in warning messages
Date:   Sun, 12 Apr 2020 23:54:35 +0530
Message-Id: <1586715875-5182-1-git-send-email-telumamatha36@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix some typo:
  s/fnrom/from
  s/pkgs/pkts/
  s/AMSUs/AMSDUs/

Signed-off-by: Mamatha Telu <telumamatha36@gmail.com>
---
 drivers/net/wireless/ath/ath10k/debug.c | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c  | 2 +-
 drivers/net/wireless/ath/ath10k/wmi.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index f811e69..69139c2 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -778,7 +778,7 @@ static ssize_t ath10k_mem_value_read(struct file *file,
 
 	ret = ath10k_hif_diag_read(ar, *ppos, buf, count);
 	if (ret) {
-		ath10k_warn(ar, "failed to read address 0x%08x via diagnose window fnrom debugfs: %d\n",
+		ath10k_warn(ar, "failed to read address 0x%08x via diagnose window from debugfs: %d\n",
 			    (u32)(*ppos), ret);
 		goto exit;
 	}
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 5a0db34..943db9f 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -542,7 +542,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 	int pkt_cnt = 0;
 
 	if (n_lookaheads > ATH10K_SDIO_MAX_RX_MSGS) {
-		ath10k_warn(ar, "the total number of pkgs to be fetched (%u) exceeds maximum %u\n",
+		ath10k_warn(ar, "the total number of pkts to be fetched (%u) exceeds maximum %u\n",
 			    n_lookaheads, ATH10K_SDIO_MAX_RX_MSGS);
 		ret = -ENOMEM;
 		goto err;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 4a3a698..a81a1ab 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -8336,7 +8336,7 @@ ath10k_wmi_fw_pdev_rx_stats_fill(const struct ath10k_fw_stats_pdev *pdev,
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "MPDUs delivered to stack", pdev->loc_mpdus);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
-			 "Oversized AMSUs", pdev->oversize_amsdu);
+			 "Oversized AMSDUs", pdev->oversize_amsdu);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "PHY errors", pdev->phy_errs);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
-- 
2.7.4

