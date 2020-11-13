Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D42B18A5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKMJuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMJuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:50:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B20C0613D1;
        Fri, 13 Nov 2020 01:50:16 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id g11so4292680pll.13;
        Fri, 13 Nov 2020 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2INJsF9zCQkJZ9y9G7Ubrge+QxyZh7roneWpcKNN1UY=;
        b=D+ijiI4MEoiT6HxCFpTocZix+QJjr42QJodysCCWNb69pQKCRdyWLr34eMz6GvoFfo
         Y0Hlio+338Ph2P9Z2h6rMa2FjkNuO+Sq6j8Z71yXq6y21RiEkiUGCO7ltPVAACxRCcBp
         tICuFzWYlypHcdzNAlXaVTttuCi6jZPFT3KjCdE/uXUr1C8fs/t/c+OtBRdD6MTjIjI4
         /kndtSNLYOkSLLq+NgvaDuEkyEbfaeOYBI6VlJVtBvI0ncmuQqpDNWUzZGuhhwPFPawM
         7bAxyn14IYuQ+WLKnhUSxGHIts296ERkFKWWpEw9oUMnA/6RGKJLcajA44kYU8/N5+7b
         j0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2INJsF9zCQkJZ9y9G7Ubrge+QxyZh7roneWpcKNN1UY=;
        b=JxKWh3BHF1I61BUWUBTqbof6SnICCUxQ1PXM3eF3LvCRNAbNdcHsHV2xMfqR+mEaCE
         iMrqNWpY+47OZYZqmB2iC41fBs8cDN37AlkBBeyXmScNe1Fwi1rdST/abV/Ta9xP6v0V
         sg4FWSeCr8RCuCpGRhWBo0cQ5KlrQ6xxi9IljAyXtGxUvpZRvrGGPtHu0hy+HZZuueaw
         Gaz80kaN67KGl+V4s+iSzpRrk7txMgdS5lUsON2SSdLT515Zt4xFAI/dCFpIi8ZOXzuR
         w0PaELvRs9iVAOTIO/k7TS3ItiVfLn0zxPkIpJP3doFXrbYBf+ymrt3Vv8gd9N23Zd/a
         fvmg==
X-Gm-Message-State: AOAM533sgeilMLUdWdfwbm9msp9j0uM41K0mThf1RdnMNOREgWMBO/Lv
        GIF9VHWbfOGT2Zr6C7ypSQ==
X-Google-Smtp-Source: ABdhPJwrjH005vThOAAV5rh6RD4ywlDGGc3CxjFHovQMQV7Fn/e98ellsRr9p4MOcUWHff+Qy/5mGQ==
X-Received: by 2002:a17:902:9a4c:b029:d6:1f21:8021 with SMTP id x12-20020a1709029a4cb02900d61f218021mr1552801plv.58.1605261016477;
        Fri, 13 Nov 2020 01:50:16 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id a20sm8959868pff.118.2020.11.13.01.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 01:50:15 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, chiu@endlessm.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] rtl8xxxu: remove the unused variable timeout value assignment
Date:   Fri, 13 Nov 2020 17:50:10 +0800
Message-Id: <1605261010-5413-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable timeout is overwritten by the following statement in
rtl8xxxu_gen1_init_aggregation(), so here the value assignment is useless.
Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5cd7ef3..342126b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4426,7 +4426,7 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 	page_thresh = (priv->fops->rx_agg_buf_size / 512);
 	if (rtl8xxxu_dma_agg_pages >= 0) {
 		if (rtl8xxxu_dma_agg_pages <= page_thresh)
-			timeout = page_thresh;
+			; /* do nothing */
 		else if (rtl8xxxu_dma_agg_pages <= 6)
 			dev_err(&priv->udev->dev,
 				"%s: dma_agg_pages=%i too small, minimum is 6\n",
-- 
1.8.3.1

