Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84786264F1F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIJTfL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgIJPnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:43:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C55C0617B1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so7053181wrw.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=oCOn9uu78jvK2Mxprh5yp4HQIcZPjab4XJthUN3hJp6aCzH1VASdy5T+C1nBdjXtAw
         dfMt4H3gindzAcYHdWnQVAPC+HFI5LtMqHLIkYmCK12Hr5LASFt/GtzUAyJ02dd3WBKg
         xTBW4RQDsLy6SugjCwHRhmVmL+tnW3Dq0ac+r1i8BXilFBFNw8/+rcVKL1UG+rd9SGoq
         5fSNzmgTdnjQJux7v+Ok1/bO8lDW/iCYDGZZTa79UYdkUknW6p9///gLBbvqeEHX6lbF
         2619aAQLrFk3Qc8pu3rFMhuim0FkpJ45I8ftAdxHlZYClI/byhPG2LFQZdM/CejfdE4l
         Ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=mhOwKd6KeJRybingLzturA00lAU4GLLyNZUzuwwJ3JBgjDDcnh8PIIVDID7ksIKrmu
         K+sGAaP6Agxz23otlyWA7QT1+Dn9BUvqGorZOvYv6TUp10mEIWGggw1m51TU/cQmczvZ
         uL/ICz8z6rfAEaqFJxLL6d/CEiTBJcrqEBQZXzJdq3sL1L17kjr58eBNDl2uD53M4mfD
         3Ill2OTiffwqiT06AZyeIHPkjN+JcyyT7Msk8fXXF8grfyfcIsnaIn6EiNU9/XWhBmxk
         uftaNekr57jB2UiMbtvwVIFxqfzgQLNgdYfrVA9USFbIUmU2aHDw1PQWxVLPx3Zeb/Da
         M1hg==
X-Gm-Message-State: AOAM531CA/RDYE5jd4o9aDw/FYFu72bJvoFptXsoy6D1Dkm8H4pGQciR
        IVZlShLPZwHs2Veb8iQhGlTfQPgClP3Dug==
X-Google-Smtp-Source: ABdhPJyOb5IJ9/etttDJSR+rJU06l+PWKyAWEaiXMyk7TxOq2tun4L0+cnZqjIyJXoI1AEwjHFahJQ==
X-Received: by 2002:adf:df05:: with SMTP id y5mr10361317wrl.39.1599750381737;
        Thu, 10 Sep 2020 08:06:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
Date:   Thu, 10 Sep 2020 16:07:04 +0100
Message-Id: <20200910150708.2179043-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
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

