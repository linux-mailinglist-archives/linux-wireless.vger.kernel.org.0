Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6989D263E39
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgIJHNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgIJG7K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:59:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D758C061757
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:55:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so4485939wmj.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uh/4XLJuHqHnwRZLTq1ZUB9DkVVyoID5KW3qwMfLQX4=;
        b=b58biad/XGI7tZnOxpmXY1CLrJGO4deSAXnVhLBoQsbxJfJZ8c4jiF8EYJNHb5lHK2
         XQrjAQ1JIo2aE3OCezphq6f5NgvtG6Y2zPyhQgMEbshfya4UCrVtWy5fqFuw88BCJI8u
         uEyIgiDCY3RdhzbIRfQIjoAEIcTQRqks5yhDqkKOQzHcy2+Zdagk4l3XRY5vk8W6pi/W
         5Al6M8AZCE7wY6c9N58Nb48+JL/c7HEm+Mja2V8JcRUSrJgQU6SNxDklFys8QPlDBgmw
         w0voIjkDY/BmPz/FyH1As2oNe4vuNsKo/O1xtHlib33ptXIv+XsySM1H4hdarNCGA1P8
         cl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uh/4XLJuHqHnwRZLTq1ZUB9DkVVyoID5KW3qwMfLQX4=;
        b=Zv/EyW8Wh+ggzXHmArEKxTd0fAgYgWkHklsex9FgGOtR+tAEVPcukQMo+XEKNKln9+
         oytOteeAXk3NZWebnOMtX0ffHQP6jfB+duo/KEfqZ/s8LVQqT6TllolS+20Llp2dHNZ8
         nLMoGyBJwbDxrWS/An6uoJdRyNv91JywieIQM9XpLE9LFprVNHoifsGB89GEFExLMI/g
         O+jOva+TXnaA/OvEagOowp5J605Paqx3P27iiLS5KTr3ORlyQN6umwwr7ZURrnQkAoZY
         3jT/GZkj9Qw52DpxRVF9OoeJwT9f/M5jCLle/wo0rJ4QI8eNrkFcz583/nKkh689RFAN
         ZMXw==
X-Gm-Message-State: AOAM5304Szegr2I7ZcTw6P47wZ44MCiOgV12uBii2XM5QJHfNctbSYd+
        w4cys6/J5rorX2WYFv96rMeOVb36Z99dIA==
X-Google-Smtp-Source: ABdhPJyAHuPlm0h6lSyKmcxI8wakglC5O0OE4mjADtTWdtET1ee+5auZMS/hd6A//Know+QFpOOIKQ==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr6751162wmb.94.1599720917761;
        Wed, 09 Sep 2020 23:55:17 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 21/29] wil6210: wil_platform: Demote kernel-doc header to standard comment block
Date:   Thu, 10 Sep 2020 07:54:23 +0100
Message-Id: <20200910065431.657636-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There has been no attempt to document any of the function parameters
here.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'dev' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'ops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'rops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'wil_handle' not described in 'wil_platform_init'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wil_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.c b/drivers/net/wireless/ath/wil6210/wil_platform.c
index 10e10dc9fedfb..e152dc29d177b 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.c
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.c
@@ -15,8 +15,7 @@ void wil_platform_modexit(void)
 {
 }
 
-/**
- * wil_platform_init() - wil6210 platform module init
+/* wil_platform_init() - wil6210 platform module init
  *
  * The function must be called before all other functions in this module.
  * It returns a handle which is used with the rest of the API
-- 
2.25.1

