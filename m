Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E848256480
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH2DjU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgH2DjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56336C06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so878443wmj.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=Gqy8FQEzfLCKK3RYqITztwv3hYVU9XwW6KBNpURG362FGIVMqWZjtVMA3tJp792u4l
         UVPXhhdPT1l8u9u2RvZGx6AOpU1846V9WQAMMPM/aFJfzLQDdBk/wwBYXQxMQFGgYGG2
         MB8MnAEKdTlRFaPO29I14g7egmuRZKuAd/pjqJBD3xDnQkCiXJV4o+qWHv45fSoIaQMf
         PikAq3NwczwXu3g94C1nInAJBSbOMfvM8DFnor6CzQSjWtQRgWy8O+usIjgpVv/vy03t
         hRsTX8UirQQiQXnNnfr+1FsL/6h2RqDV8pCkM6PPLM4mBrjd5BqMiLM1Ee2FqgOAd36J
         MlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=evsPu6UxlUr/jJdxUE6eJYEslORq1NsQVO4bTIdbiHZVpSrslWd5GXG9s7ReeyyJmw
         IB8VO+93PSmmHpsxtQaO4hNoKljRcE8g9G5M0+upNZnwhUCfVhoM6HZUsko/P5YtlwJg
         H04AafDozQlVCGfzdrrMztEW4fXAEinF4rTVr55oh9bdA9ca3ekSlLtOCLltczLQnjcu
         T9LXkjYMqH7i9OVx8znLJee7Op+BoH1XmarBwlSbclBk6Ukd8qrSWjmJ0nm4T3NmMAOS
         HHvnZEd5/vv7vfH0WvGQPk1mtJglw7u/YHxw4LsfKRsqGIXhiZ9x82vs+Z4pM9UHKdpH
         UFkg==
X-Gm-Message-State: AOAM531UmGaYiHnAsi/ktWXwP/YPFLqB9lY8+s9JNN7vkkvI4/+Vur+2
        OzLyKyw8aGTVnQm3vXDr+baUcQ==
X-Google-Smtp-Source: ABdhPJyapHdv2qIe61vmaviGiJBqETlaT0LE8VeX0YyYsJOjcuzlhukaygv61QEECVgMluZefFufcQ==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr1511069wmi.147.1598672342068;
        Fri, 28 Aug 2020 20:39:02 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
Date:   Sat, 29 Aug 2020 04:39:43 +0100
Message-Id: <20200829033947.2167817-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds HW_VALUE_CHANNEL(hw_value) an access macro that will be used to
extract the channel number from struct ieee80211_channel->hw_value in
preparation for also storing PHY settings for 802.11ac in the upper bits of
hw_value.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 2da81d9926c4..ebce1ed7adf7 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -83,7 +83,9 @@ enum wcn36xx_ampdu_state {
 	WCN36XX_AMPDU_OPERATIONAL,
 };
 
-#define WCN36XX_HW_CHANNEL(__wcn) (__wcn->hw->conf.chandef.chan->hw_value)
+#define HW_VALUE_CHANNEL(hw_value) ((hw_value) & 0xFF)
+#define WCN36XX_HW_CHANNEL(__wcn)\
+	HW_VALUE_CHANNEL(__wcn->hw->conf.chandef.chan->hw_value)
 #define WCN36XX_BAND(__wcn) (__wcn->hw->conf.chandef.chan->band)
 #define WCN36XX_CENTER_FREQ(__wcn) (__wcn->hw->conf.chandef.chan->center_freq)
 #define WCN36XX_LISTEN_INTERVAL(__wcn) (__wcn->hw->conf.listen_interval)
-- 
2.27.0

