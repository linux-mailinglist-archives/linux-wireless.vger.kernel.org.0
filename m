Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96C6F5AB4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjECPKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjECPKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 11:10:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D75FC9
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 08:10:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f37a36b713so12664475e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 May 2023 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683126601; x=1685718601;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHrNZtXhnkvkLwSC7JrWBPXdMDcce03qbIYQQuiMdxc=;
        b=Gu8ejPsqndZGyE5ua6xrQITikRnRTRGNZSYX44/83yLhtiOsRBuyowvXb/QMyvr50w
         U5PK/tDttV3WMWWTqZPkLn0IK/9AGXj2B9pFBb3ZmJN7lOs87ILJENyP9v5cg3BHJgVg
         YolxM9GbAGavRd05OtjaXE8MSX+xzUsS40j/YI/oFypPyAvFQgPxHUeDDmQI5kYYmJFy
         nFoIE7oU0NTYXliTIFnSPqbxc/4g2u/bTQE/3nbQdEDaMGFPTaYW9a5YE8axWYdZO4lF
         EBlKux+umRfXfmLEdGR4//nWgeNW8d0oP6pnEOxmHbaiCDT12vH4BOp+39jkeoZj8sqQ
         2zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126601; x=1685718601;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHrNZtXhnkvkLwSC7JrWBPXdMDcce03qbIYQQuiMdxc=;
        b=TQ91TR7dxjALPIpJJF4xruUGbpiGXBXTmF1FWz8dfgI8LboaTd7KH0mZ46y4P4hTzv
         23HVLrux4XPox+WZ8W5Dlc1LMn/UVyM0cYPiLBhm/hc5FgQc1daEjZYma3tRTxgnI1cY
         x39TYRycPARUKYm4TucWpjMCCKh3qDXde3awLohFogcXX9yM2RCOV8K2EENbwO7Odq5+
         vKgTZ21NYiCuE+zQbaZW49DuaUlBexvpEVfL6ArZjiA/hpbxNo26ESa3mxKcpy52pElQ
         Txmj+IsCo+q51BuR+srQPxQLyh51fyk/xkPV+u/hjijRHqH05kFEizl9n62rj9ROB5Bw
         iD/g==
X-Gm-Message-State: AC+VfDwKMfY/fM2JYBllTb3jgsPitWQfQ+JQtQvAvlXSgVW8qJwoqIUZ
        EXWeBx8Ur6ObYjD44fsHNDeVJg==
X-Google-Smtp-Source: ACHHUZ7XV4yU2fWv2Xdj0eB9CbHk9AHdArfTBgZTCElAXrhVFv7DpJ8VqSPML4gtTPVBvwg8WSimcQ==
X-Received: by 2002:a05:600c:2194:b0:3f3:195b:d18c with SMTP id e20-20020a05600c219400b003f3195bd18cmr15259647wme.30.1683126601415;
        Wed, 03 May 2023 08:10:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l20-20020a1ced14000000b003f182cc55c4sm2172659wmh.12.2023.05.03.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:10:00 -0700 (PDT)
Date:   Wed, 3 May 2023 18:09:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtw88: unlock on error path in rtw_ops_add_interface()
Message-ID: <ddd10a74-5982-4f65-8c59-c1cca558d239@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Call mutex_unlock(&rtwdev->mutex); before returning on this error path.

Fixes: f0e741e4ddbc ("wifi: rtw88: add bitmap for dynamic port settings")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 7aa6edad0d01..02cd19ee6e4c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -173,8 +173,10 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	mutex_lock(&rtwdev->mutex);
 
 	port = find_first_zero_bit(rtwdev->hw_port, RTW_PORT_NUM);
-	if (port >= RTW_PORT_NUM)
+	if (port >= RTW_PORT_NUM) {
+		mutex_unlock(&rtwdev->mutex);
 		return -EINVAL;
+	}
 	set_bit(port, rtwdev->hw_port);
 
 	rtwvif->port = port;
-- 
2.39.2

