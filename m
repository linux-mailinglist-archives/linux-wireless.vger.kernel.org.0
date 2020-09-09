Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3D263394
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIIPkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbgIIPgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B040CC061347
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so2730484wme.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=ryl0P748MZ8rG9TDba0ufAdoBfzNc1lAOrSkQpNfJGTGL1xxNXSKZEu7krXwZiErCo
         yz65cPyF7XXpl87SBMs3J7aZJKCzF1kcQGM19d4DBEDoHtgPJXQtxg5U2l8uAg97dtli
         krj4Ib0VH/5fdgT4WutCYHLWeV37MbgWCG32IDsAgV4tVQMrX1+2wuv4cNhBuAG4mDmb
         Nq6WFCqeO7EPuP/15IhkvAWY1eF2XRicU5RhhI0W8SDCPbseS/6Xzv808rApiJqB0TCT
         ZctVhcFvf96HqEehmvm8ihygjR75Hfom6qrE6CKgiizx0QL5q+sdZkrVXBdZBpFYkz4L
         Hcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=Jklf1H5HBGqH2tL91R1p7JBQKWpA3x0r5G4JvlkePwp4E6CuqSFafW096RgeY2WuJc
         Rkj895ZCF1TCWiDM/o1TFwmJoL7/l/SQy1WJrIwJU7a8gxLoMudInFqPxJcFIrBVEwOY
         fKxaqLdRlnvjkz516FiKR/FkzHRDp5w5YP5aNQxbEK++kpv8uB9Tv9i9CI+rjeF4sO/2
         GWzERM3T6vgveZCUuQhhouE8MabUUvXrGXb1629/jJ9ADsc6TC9+pXDnzAGxdtTZeooE
         5NtaIkgCs3smOo7ByZenvVnLxVMQ/cV7mVLVW+c/4dIzB0/7ZX6S3ntZLWVBBsLa+F42
         M/WQ==
X-Gm-Message-State: AOAM533j+tBo7aQzNKbs6y7seFn+iJPPSBKhjXU1EwZ9KuGzm2B8tZL/
        AuSNOWTBTvSI/CouN+GWXssfIg==
X-Google-Smtp-Source: ABdhPJwIywolo+xm8jMUXzeMTWkjtZ1rJbb5aBOpTZQ/K8pzRtWSp7SNK6PPWrw9JRNtlB2Z4kNTmg==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr4281537wmp.170.1599665772328;
        Wed, 09 Sep 2020 08:36:12 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
Date:   Wed,  9 Sep 2020 16:36:56 +0100
Message-Id: <20200909153700.2904977-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
References: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
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

