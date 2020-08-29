Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FDD256482
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH2DjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgH2DjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0CC061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o4so906549wrn.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=Okw/bFl+1QURlf+DlpmTVa0gvxD/RbzvJ429LMzioPWrxukuqEZ+O7njYJhTMnGMhV
         9wcB0ylpd69wM/+mKeIygft35AOcbZf5fPCqGtXFz2QDkmiw7JGcYoaPQBFDG8P0lEwJ
         PXzbaYgJApaUqhsxaSS1SrhxUA4cBVA9Y+81YBrceI8r7wPhkD+2EW2wf83oknGHAdr2
         dSDf6ZJyHsZFonYTnSE9C5gCozdITixue6FJE9O0cT4PCqgUGI4Sc4HCAW+nBpYLzj+u
         YVCFgHlhbPKPZmNm5GBfRh+2H8fbg0gz1SNj3BTtw3gh2CunmVxmONTC5tYUhvVSODGv
         vhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyyyc+eVVPBc5oNmWeDufnX8Vdj7EzlctFSImbJVqV4=;
        b=dBBNqaoYo6/Iz/nud1CmEHd3OXM7TCllBWZPaUiEAsoFc4uY8P5cH8ghWKYAAdAQov
         7mrBRfmFWA7qHkbI2PLIFSZjvr+/Q8NKA/3rKwtPJjsKCPCqCdxkFXQALrqb3BFbSvKz
         AKOHaEN2kunV0F01lA+zSO+aXC5lEiXFp2H3qppZ3UIGEElv7udIhAvJT5Bl7KhH/sOD
         EuzLP/ophX71GZMTaXTqzJPMOrCmIMT7hXq+fB2WjmCvJJVPCVrdz5G0f/c3xDeJxM5u
         Op3/99ZQB1DpaZs6N1/+oLz/MJ8goRpKHwWbXV8ptvGWlV3JEKSfIgjj7xZG1uXR/jy9
         dzag==
X-Gm-Message-State: AOAM531Pjv1XuB2bWbk7BYabZnNc8/4KwrQs8KYxLySy9pZiTU+XuPJ/
        J9WbWh9Yzca81EFLfd5romTxxA==
X-Google-Smtp-Source: ABdhPJzKK1yFZQfCoDXNkGeLzk28YxVjYNR6IvqNGqCBWPcrfMX/+cAOx1eV3BFErs5Bo6hvhRUuMQ==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr1150793wrj.92.1598672344017;
        Fri, 28 Aug 2020 20:39:04 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 3/5] wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
Date:   Sat, 29 Aug 2020 04:39:45 +0100
Message-Id: <20200829033947.2167817-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
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

