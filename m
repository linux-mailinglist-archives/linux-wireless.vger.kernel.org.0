Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BA24E282
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 23:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHUVR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVRZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 17:17:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F47C061573
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 14:17:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so1664209pfw.9
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjsJFmybSAkA6bHsOFiw9hYiFCXWIe9EkdnGoMqjY1w=;
        b=RTYNRS8kY1tdMfDWjSV6jmjiDCOvMq/zWNciEX0rPTQom+fcKHW3I0eEo4Vqgnac0v
         Mns0Hozp6RM6TIqn+WutcxOx8PvdUrvhwn9mjFDg5UyYJNxqWRtKSDRynBYcczG/7UfN
         ZkjTB/C38OTJ1IP9JzR1Ph5q4YxyRqecU7j8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjsJFmybSAkA6bHsOFiw9hYiFCXWIe9EkdnGoMqjY1w=;
        b=LQh3NenVDIKtZjRkldhFgOwCTEKv/RHhP6cZMIal90sl64IUEcpNHbrEughmue2svc
         27rBjD4Pg13LRMtBga421YLZC/BDIpqKAD2B5VHJn8QCjFXcmndRM2kiu4/udF3lo7Nv
         EfmkC9JgrbzoZsAxUQtDZ+1420foZlqCToUn6QcNnKEYp0E9euMEe7EQKC+AGkmbOp63
         Qd89UVvDzmzyrffkrpWCg1GIwf8S1jxiiwLY7/zr3niEh0iUZEEQb07aAy6ntl0rsqb1
         ggXkgv2Eg7kNOaww6eBuGOiVxGq/L6VCriqak91RVlSu9ENjipGf5Ps/UczITL4zRtCe
         dMqw==
X-Gm-Message-State: AOAM532XFnD7bmtW1iZA+s1L4oJ3EWSklowpkJub/wKghq3yOe1T7RX7
        j1lMk8DJ9qlJxhlT/FNdrexkHrASU3UeLw==
X-Google-Smtp-Source: ABdhPJybEbOFZe/kXk4i0ZCWU+Qrgjp5klLGFwIDTrab8cyW8mkqZ4mDkcrKyim1hjLVsZiLGdF37Q==
X-Received: by 2002:a63:e154:: with SMTP id h20mr3583443pgk.428.1598044643789;
        Fri, 21 Aug 2020 14:17:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id t25sm3495867pfe.76.2020.08.21.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:17:22 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtw88: don't treat NULL pointer as an array
Date:   Fri, 21 Aug 2020 14:17:16 -0700
Message-Id: <20200821211716.1631556-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm not a standards expert, but this really looks to be undefined
behavior, when chip->dig_cck may be NULL. (And, we're trying to do a
NULL check a few lines down, because some chip variants will use NULL.)

Fixes: fc637a860a82 ("rtw88: 8723d: Set IG register for CCK rate")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8d93f3159746..9687b376d221 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -147,12 +147,13 @@ void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
-	const struct rtw_hw_reg *dig_cck = &chip->dig_cck[0];
 	u32 addr, mask;
 	u8 path;
 
-	if (dig_cck)
+	if (chip->dig_cck) {
+		const struct rtw_hw_reg *dig_cck = &chip->dig_cck[0];
 		rtw_write32_mask(rtwdev, dig_cck->addr, dig_cck->mask, igi >> 1);
+	}
 
 	for (path = 0; path < hal->rf_path_num; path++) {
 		addr = chip->dig[path].addr;
-- 
2.28.0.297.g1956fa8f8d-goog

