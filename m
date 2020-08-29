Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A36256461
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgH2DiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH2DiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD733C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so119528wmj.5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNiRhwwJnyA0HvHB3u89nvaZihjCiD7YGV/okY3OW5A=;
        b=me3BugrBOWQV+U6/VJGef1fddYUJf7bH3pdjQjOn/eOkhKniFHu7/9wc+zXVr4VN6G
         zyXO5OVMKbO7Fzuy0RjSKmXYu+RCCZ07S1ophjow7zYMVz8iHJ8LtKk5m11/tm2Zsdus
         nOX2ESe90GjPdhL4wFDRgDxg8/+k5JIJzRRdLiy9g+saIyeuMOLdyIATP+2noLvlWCtT
         lX1+mdOofQH900EC/JI3TPWVzs56niK+Kn16yFD4VpeR010xlvI65RXlSi+jzljsMlsh
         ImfzWUKYJ0D7qwP0MqmNzDqCFU+dPh72KVK5c5NnCD0NT1Rq6DqTv0WLCeJ0SzNFRlDF
         Vz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNiRhwwJnyA0HvHB3u89nvaZihjCiD7YGV/okY3OW5A=;
        b=B6N3z1CCGiE/CxheINwx4IXFQP+OUc6wpgweQOPS4bn2gqDgQG0+2X9ltZMeYcfakb
         WyzPhTOmHTYieDIgiUn4/3G/5OUltRpwCRF8Tm830q1ReWG5oBgI4f8nJsVuoeP6VJ6F
         IoqhkeXQzeTE+gTy8rifuoujvi0pAfHI7EAlh1hFRCOwGlkEM9ULaQIo9iPNDEBS0fbG
         seMwuGRrfNZvNFJdHd4T7iomLNHeu2AgsA8FGQm7+K5sHatXulYvIL8pHVn2vDlcocwU
         2dOpEXLHwCZHbWcnRRZGSPWGC7ceCoU8xt43rDI0wT7ok+iPjuKf2ffeWAOdS66ac4qt
         E9KA==
X-Gm-Message-State: AOAM531u0MVByufV6htvkeULgbMy3oRNp88O4mANQAhTodhiiIpEpi5k
        PSS9o3Tf94glxX4F3BeW1RBvzA==
X-Google-Smtp-Source: ABdhPJyND+NDLTAbJfnSUUiMt4Ke8v2HSWWNBrq/AMJojuRk+fkw+sQoc9c4C7VSOKbI0NyJ6gIxuw==
X-Received: by 2002:a1c:105:: with SMTP id 5mr1570159wmb.83.1598672284491;
        Fri, 28 Aug 2020 20:38:04 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 01/10] wcn36xx: Add a chip identifier for WCN3680
Date:   Sat, 29 Aug 2020 04:38:37 +0100
Message-Id: <20200829033846.2167619-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WCN3680 has some specific behaviours that we want to capture to
distinguish it from the WCN3620 and WCN3660 respectively.

Add an identifier for this purpose.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 719a6daf9298..342ca0ae7e28 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -92,6 +92,7 @@ enum wcn36xx_ampdu_state {
 
 #define RF_UNKNOWN	0x0000
 #define RF_IRIS_WCN3620	0x3620
+#define RF_IRIS_WCN3680	0x3680
 
 static inline void buff_to_be(u32 *buf, size_t len)
 {
-- 
2.27.0

