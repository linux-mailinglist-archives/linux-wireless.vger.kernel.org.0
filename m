Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A90249771
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHSHaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHSHYK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177BC061348
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so1119703wmi.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPyf3pY78NKZpAoCqUMShqns3N3Vter41E+TCH98irs=;
        b=pO/tZJ717SIL5qmd78VkicWaF6vFD6SXo8MiuqwrS81DIISf2fmFvV/0SNNkbW2fYi
         P/E8KCf7dPHNYE0+w2CKdB5QVkmTFfGZEWpHNaWULVE70e8UBxLR/33YDVYmQw0du/5q
         HG6eho9ClpzTuzi9w98+U1mvCcLbx9Arm0ONOAxw/nAMaSuuv+UN+bVrxXgqyO+zC5Aq
         8Suz3ZVpr4gBMxVhAIIT27NOUg/VIBE/yQYQoIrsr+ev90YMnUO3kWtJvvrTI9GrvoWD
         ZQ4aNofJmylhzMjyFGAZ9xx6EhXJDZ36DncwSc22Mtx0S9GNohnyY3Ja2QSPukE6B1xI
         F9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPyf3pY78NKZpAoCqUMShqns3N3Vter41E+TCH98irs=;
        b=biHhQa/55njQdcdSYuiZJDL0qaAvfkKomloocW2nfEzqUmEZQGawZrtbE9SqwYsOGM
         okqVQk22rRt75rSwlwlEs7mBDbqlzfCNzX6Tno/vKPKXj6I0BK1Y7CEYYpoIfWR4UBPi
         IeXrhs0CsR6xHsmcrV0ifkygQKYuJZvYATM+OowH6V2cm3rrHr/MROAL053HrNqfK50M
         y1jbDOcMU5YzOg/+xBpN1X9AuuwOldSMppIsqNSQ2LN5vKqXx5MYgVK+pqDEYuMciEVQ
         54lqQD54QWqNl52aFPQ8NJppXXeTTMW0sSYkdqBLdpao8J1BdQ+pakPSmKIo9IzIZon/
         hhgQ==
X-Gm-Message-State: AOAM533gFbhGTaHvpEHZX3mPOMJ3SRYAdsGuPCPtVCDZe4T23JWfRC/w
        q4wSo8N1jeMAPIItnEKjiAQCBw==
X-Google-Smtp-Source: ABdhPJwQbTJrfV/44Lpom+61UBCm4AdTRe3330us7wYdmYxtjAvw93xalHuDW23gup9fnULbIMEiVA==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14mr3537549wmf.54.1597821847752;
        Wed, 19 Aug 2020 00:24:07 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 02/28] wireless: rsi_91x_main: Fix some kernel-doc issues
Date:   Wed, 19 Aug 2020 08:23:36 +0100
Message-Id: <20200819072402.3085022-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The file header should not be kernel-doc.  Add missing 'rec_pkt'
description.  Update 'rsi_91x_init()'s parameter description.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_main.c:17: warning: Function parameter or member 'fmt' not described in 'pr_fmt'
 drivers/net/wireless/rsi/rsi_91x_main.c:156: warning: Function parameter or member 'rx_pkt' not described in 'rsi_read_pkt'
 drivers/net/wireless/rsi/rsi_91x_main.c:287: warning: Function parameter or member 'oper_mode' not described in 'rsi_91x_init'
 drivers/net/wireless/rsi/rsi_91x_main.c:287: warning: Excess function parameter 'void' description in 'rsi_91x_init'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 29d83049c5f56..576f51f9b4a7e 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
@@ -148,6 +148,7 @@ static struct sk_buff *rsi_prepare_skb(struct rsi_common *common,
 /**
  * rsi_read_pkt() - This function reads frames from the card.
  * @common: Pointer to the driver private structure.
+ * @rcv_pkt: Received pkt.
  * @rcv_pkt_len: Received pkt length. In case of USB it is 0.
  *
  * Return: 0 on success, -1 on failure.
@@ -279,7 +280,7 @@ void rsi_set_bt_context(void *priv, void *bt_context)
 
 /**
  * rsi_91x_init() - This function initializes os interface operations.
- * @void: Void.
+ * @oper_mode: One of DEV_OPMODE_*.
  *
  * Return: Pointer to the adapter structure on success, NULL on failure .
  */
-- 
2.25.1

