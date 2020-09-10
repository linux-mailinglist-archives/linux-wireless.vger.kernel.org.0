Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29B264F42
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgIJTjJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbgIJPmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:42:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A00C0617BA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so7029651wrn.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=o3eaOHXLlTKZVJQusL0agAIXoJElOD7EcgoIE6ivOCT1Sun7E0GZt9W3fdTKMY8CzL
         PoguPeVbDKi8qqcvowUP3Ph/qoH3RlydHakEvdpyRXiMw4zO8YAUPsbEuesjxVdDez5D
         81VxtJ8SeSzqJbsnhOr7YnakTET6/bpfWqScp8vb/nkC/VFxZ+Dtb3aeCcilgbQZTlr3
         C41VGj92BKqJXAljTkRylPuBlI2vSb6mWbMVoDo8DgBRrHiQuHpfhtbsrygWDpTtC+vp
         pRbJ/eDqqckprTFJmkazUgNCA4hOWj97gfBO0vCQUUtSMCzsFjuPi/s3BFOBZoZ1M1A3
         sAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=Fs5s7jWIRURUvRwsBwJn232YeCx//QsR3XeUR2QGTbf9+9rN/4JX9Zy+E2MCEuRrR2
         cZ+MfuVtT5MTdXHybWBDZdge/XjUCy8WE99piNIjEWsbvc3QaSow8/w8THNW8BDIpwUs
         Toq6janI56a9F9J8La9iedG+5qnsSxxrVDhj6VF66phtxnCSJM42fHnKkOTwDn8F+dLC
         gGBWWlYa6JTJNCz5uwq5aJQSuSpEJvcLM0gp8BorqcGoGPrBFRpI5oFAagMoNF4tvHOg
         RRkPNXvO9dz1RwLUkuZOtwzvsC+PD/658hvwqJBNWKUqa1wivlo30dgoCCRHIqRHv8ZI
         4Xtw==
X-Gm-Message-State: AOAM53092ndSEPf1vcdx5uibV292IkhKpXEybZPFjhOE/6DevZpNl7rm
        FoVApcraEJ9GSTriTcEuOVUysQ==
X-Google-Smtp-Source: ABdhPJwYTsgwCZnuttOmQtA2H+1urIT3Bo1184StLUIQmZXAjBZaZGhTvZwRbtRQxQ65wCGELWXX8Q==
X-Received: by 2002:a5d:4d8f:: with SMTP id b15mr9608394wru.341.1599750383661;
        Thu, 10 Sep 2020 08:06:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 3/5] wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
Date:   Thu, 10 Sep 2020 16:07:06 +0100
Message-Id: <20200910150708.2179043-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds HW_VALUE_PHY(hw_value) an access macro that will be used to
extract a hardware specific PHY setting for a given channel.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index ebce1ed7adf7..71fa9992b118 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -83,6 +83,8 @@ enum wcn36xx_ampdu_state {
 	WCN36XX_AMPDU_OPERATIONAL,
 };
 
+#define HW_VALUE_PHY_SHIFT 8
+#define HW_VALUE_PHY(hw_value) ((hw_value) >> HW_VALUE_PHY_SHIFT)
 #define HW_VALUE_CHANNEL(hw_value) ((hw_value) & 0xFF)
 #define WCN36XX_HW_CHANNEL(__wcn)\
 	HW_VALUE_CHANNEL(__wcn->hw->conf.chandef.chan->hw_value)
-- 
2.27.0

