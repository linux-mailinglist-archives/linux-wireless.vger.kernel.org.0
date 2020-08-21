Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8BB24CED4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHUHSv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgHUHSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF020C06134A
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so1004647wrm.6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7w3jE69M/e5e/80kesqbMY/Z/0HVdXG9NSX8Y6W1xc4=;
        b=YiZI5pLzZI5/jEU6hI6Ahuit8iLuJTNlIDoDhTz8w4icHiZokTBWxZL7BEBOFGYKfp
         DLyl9+y7diiZvjqBr4YmFUF5HtM9OSjokpbiJR3YQujobmuOHkPx+ZCYFj4almTunJus
         PwNzus7n2mgOozuanDA8NATcuOMlRF7JmLOjvh6W6bdtLLWxs+M7DIuUiySGZTtjHa5X
         6gLPcXs7q7hdMPybJrZcRllyPM46IM7wC+wH/cmmQvfuyCj/iHohO/IheQ868oJfkcpL
         gSsEsTEsx0ilnQiPgEenoM8aFBGOPzo6bg4Rys2QspkpWTjKcjNR3XQnPEWPV4ac7A+l
         QmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7w3jE69M/e5e/80kesqbMY/Z/0HVdXG9NSX8Y6W1xc4=;
        b=rUG04jYdYpLYd8QDGcb9OMeIHOrwVS+IiwbJILZJZd38UInCikiPzk1LRfwtq1K2Sd
         tf86Kf3ClSwEaRQTtkcmSRygA3pg/qgnIfwWyMRt297vwALF7JfFDBWPX8/tp93RGV5L
         50H15sPVAsu3OtTF7Jy93yZOK45sh9KJyZf24HvLenqQjuH0yhEa6exx/NTtAdEQUyQP
         tlU6Vli1sJEDBByo6HCvflVv/y5EoRGf+/8vzuxKsnb2YJlIHqMt3AXtbOxiSKDIqZLL
         soW2kvIwoRLuUHtSd3zTkrDhPgZYK37zrHpB/LNSNQW57gACgjLzV1AbVMdHzFYKW+ym
         /GhQ==
X-Gm-Message-State: AOAM531WT7N4aS9WnKppwv77qLrb4VN7b82sh1KtzbmcgRDhG8bB6yfM
        WcY2tFT+5Mwfg2AQsPByaaqCJg==
X-Google-Smtp-Source: ABdhPJxUSUDPq3M8uao0qRBxZAxzyyVIFHGzofqo5byjgpz1iO0yVuhN9yWqk9RI93Dz3W0ALi5HZA==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr1417390wrg.102.1597994240654;
        Fri, 21 Aug 2020 00:17:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 26/32] wireless: ath: wil6210: interrupt: Demote comment header which is clearly not kernel-doc
Date:   Fri, 21 Aug 2020 08:16:38 +0100
Message-Id: <20200821071644.109970-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/interrupt.c:652: warning: Function parameter or member 'irq' not described in 'wil6210_thread_irq'
 drivers/net/wireless/ath/wil6210/interrupt.c:652: warning: Function parameter or member 'cookie' not described in 'wil6210_thread_irq'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index b1480b41cd3a0..f685bb62fbe7a 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -645,7 +645,7 @@ static irqreturn_t wil6210_irq_misc_thread(int irq, void *cookie)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * thread IRQ handler
  */
 static irqreturn_t wil6210_thread_irq(int irq, void *cookie)
-- 
2.25.1

