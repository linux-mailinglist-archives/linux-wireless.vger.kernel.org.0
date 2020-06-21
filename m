Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796D2029DE
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2020 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgFUJvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFUJvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 05:51:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4DC061794
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2020 02:51:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so6914390pfe.4
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2020 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rfIJqIz5BUhfbWOvz3mdDm6yuavon20/nKnHyeguApE=;
        b=NnFqswP9axfSqK+VZsKI6J9HIHcFlFTB+ScbOQTyGUjKL47VEB+m9zDtIkm+jqsSrs
         lVBK3uj4cFlKcKdtq/EdB8EcqH2YSjLa1hoZ2dABJwiPbz66MkJX/ZX6KFF9ty7K0eg4
         ASjt/kohyN/wLIhDxVmDuC0FydaNnU8+lsu404PJIjucwkG98beKMP5KpDunuwaxjJxN
         QuDMA+Op5csQq01bAXmd1MYbEVgroWY1AKm3FVelnsOVpFtd6CE12CD/wa7WWwXN0Grg
         33dYaEgL2WgjErx1CBCBysORLoXFg5CVZYwzYlOYRRyDDWkRL5gAW3fEZ37GQTkbUVmE
         P30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rfIJqIz5BUhfbWOvz3mdDm6yuavon20/nKnHyeguApE=;
        b=BR1ru8OcDc0YSwItrKQtf31JazgsjoKWHdWH2xDMRN0AdkfYBMKg5zkUwLUW5JvGmG
         7glY4mQxP7IQk8NyUuAKdUqQgMyVBAGd6L3bv9esnb020XfwlaEYk84vCe/s9r+W7WCC
         A0qAz3mtDFJ54EAJ9VAi0RLEQcf/AS5xJ1lTfxh5sjSp0tsVUNDuR76nKSVjyZEq8d4I
         cJ2HkKUXhH7+znvoovmeKZJtiTlwiUTsiR9bYVIhlqI21N1QdnVpbuJQzR2jwNdEtSRH
         sVn1+Tk930TGGxAh8c+FCf178Rd99ry8Bt+TQobeWNXBhNb/XWbkXhBi0e5mVEWHbA1J
         f0/A==
X-Gm-Message-State: AOAM533WvONzok8TyrVXv1VjYPl+wUX8Yz5VU9mQeCxBxc3eycsfaWX2
        tWdmZRLX/yZTTJjSnb40hLvGs7IpPmQ=
X-Google-Smtp-Source: ABdhPJyx7O7qsGDQbd+9/Y0CU4viaRafqvCbTUf0nvQhLjZpjzdhe/oD4BR7KvmRbZ/Rm/9K+m1QQQ==
X-Received: by 2002:aa7:9d8e:: with SMTP id f14mr15202356pfq.76.1592733105734;
        Sun, 21 Jun 2020 02:51:45 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.34])
        by smtp.gmail.com with ESMTPSA id a7sm10302269pjd.2.2020.06.21.02.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jun 2020 02:51:44 -0700 (PDT)
Date:   Sun, 21 Jun 2020 17:51:40 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        tsu.yubo@gmail.com
Subject: [PATCH -next] ath11k: Add checked value for ath11k_ahb_remove
Message-ID: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return value form wait_for_completion_timeout should to be checked.

This is detected by Coverity,#CID:1464479 (CHECKED_RETURN)

FIXES: d5c65159f2895(ath11k: driver for Qualcomm IEEE 802.11ax devices)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 30092841ac46..1bbe30dceaf9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -981,12 +981,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 static int ath11k_ahb_remove(struct platform_device *pdev)
 {
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
-
+	int ret = 0;
 	reinit_completion(&ab->driver_recovery);

 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
-		wait_for_completion_timeout(&ab->driver_recovery,
-					    ATH11K_AHB_RECOVERY_TIMEOUT);
+		if (!wait_for_completion_timeout(&ab->driver_recovery,
+						 ATH11K_AHB_RECOVERY_TIMEOUT)) {
+			ath11k_warn(ab, "fail to receive recovery response completion.\n");
+			ret = -ETIMEDOUT;
+		}
+

 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 	cancel_work_sync(&ab->restart_work);
@@ -999,7 +1003,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);

-	return 0;
+	return ret;
 }

 static struct platform_driver ath11k_ahb_driver = {
--
2.11.0

