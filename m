Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C632C5598
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbgKZNcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbgKZNcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A21FC061A04
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so2153487wrc.8
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=xBOLAMT2rxgj5d8ZVuygANtH/u7cqIQ2rtvXsxN80c1/PNXJdJuE9AHeYuk4sIxvv3
         qTwwKuam/qGYC1DCc6FmQ04FVDKi77XAw+D665o0Gr7JSzyerUsJPUwMUM+vrFEPMPeG
         Wdr266+x9VNUdOvWvukF8kT/hm3/HkIL1IoirrPMVNeJKDGMU+E3QlsY43rOkgsQs6U9
         Z3nNnponPf30Euwdd855q9CAUxoieKkGed0HvGZKvDHSytU73fZEnXu3tAfC4jenSXJT
         LoQVXsKBhb4YIMu9sIIV1/VwJAHxOFcDkBpTLvJXMX70Z0QyJZQMHM3tQwnW5jmv4OwX
         ES3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=ZKCCDWIe10uwa9RfkUFUDWYkHEk6x0WS+M8WPkLzN4A7Oz6z6zjW5oZ6nOvz+2j6Uo
         0475q31fOlh73/Dl8zcjaP6sh29imVuS9XTmN5rn3mHazBse3Uu49vE+NjL5S1ZynEnO
         wuI90vEdTW3BfqTTNTxvrSeN5/35tCqDHyDWBdrl2EtsKLrEONeiRRUghVe9f/xPIXeq
         t+huLcIdV8i6+nfpQ2JN6/rl8RA8K6hc+lGUr9aN1YJLwmq2f0lp2VRzHRNjBCrLPRY9
         dI7xZS9xmrFT8LbAwkvd0G+xmBWbW0c75ClQrE93Jn+CnhJcnQzXXoTQOjrSq5qwxG3Q
         7mNQ==
X-Gm-Message-State: AOAM531cm/vHSY86RzkN18wv86BrCbuV/un+6P96eJ9wRQIuAZF1MtLK
        TgBUV7fgogN1WvtO0dOexU1lGA==
X-Google-Smtp-Source: ABdhPJxU0k27+S9FFyEpO4PYw+TEqfEtY7HcfAz7bX3DOUuHdz/ZMMuwnj2b8t9DmNE6pxyhUoIWbA==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr3963541wrs.100.1606397520142;
        Thu, 26 Nov 2020 05:32:00 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:31:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 03/17] ath9k: ar9330_1p1_initvals: Remove unused const variable 'ar9331_common_tx_gain_offset1_1'
Date:   Thu, 26 Nov 2020 13:31:38 +0000
Message-Id: <20201126133152.3211309-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h:1013:18: warning: ‘ar9331_common_tx_gain_offset1_1’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
index 29479afbc4f10..3e783fc13553b 100644
--- a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
@@ -1010,11 +1010,4 @@ static const u32 ar9331_common_rx_gain_1p1[][2] = {
 	{0x0000a1fc, 0x00000296},
 };
 
-static const u32 ar9331_common_tx_gain_offset1_1[][1] = {
-	{0x00000000},
-	{0x00000003},
-	{0x00000000},
-	{0x00000000},
-};
-
 #endif /* INITVALS_9330_1P1_H */
-- 
2.25.1

