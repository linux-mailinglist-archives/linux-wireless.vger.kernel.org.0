Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36445239DA9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHCDK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHCDK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D567C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so32763733wrh.10
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knVm+8FLghu9qeE3O2LdjPgoZ5rDzBCB84wEr1o4m5c=;
        b=BZ+f6ng/a4OZA97iEXzb6sErO+K8D1XjsxYz6Vwqipe0V42i5almhxdR+UfaCG21F9
         0syUoyZsxS+YMpN1MuKUYI5cNrreBcHHLB6mzFQ6YpjfsscGAGYRPhRzkQjW/9So8OQo
         agL1h4SbS7FAi8Ueq31B2oSe9kg9b20e1p4rwuQkYhhydSk9J6nmQ05cR9pKkl1Iun/2
         eli5fgSo4d7Xj49Dy1LzkSN0asTbYbDfcs+ghsY0wApR5Uw6z1OtSLCCdc3BVg364F7e
         OQi1inVlU4P+JnDvFE8EoU8O2myjtzFll8EiU2XZ8/vj8scThYyWObbF+ynxOOn3x4Oq
         XJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knVm+8FLghu9qeE3O2LdjPgoZ5rDzBCB84wEr1o4m5c=;
        b=C6loVpiDEYCrz4rQPM7eqo9+FQUkEyOrrr2/tv4H/F06x1o3+QLF/LzmX2UKG/HCYz
         +1Z6wo4c5JWmLGJDbEDTEIS6NtDoJtuo+0HCyAHrWk49KOei2hNl2PmVjHRyWAP45f2N
         jLk9aa+kFUXnTFRQsBTY66uI13WKL5LBYrB0VLREquGGRhAd36IaveROZJxfJ6Lo7Kq9
         Sga3CJdBp30yTerXI7WWgTKLIcuyvpn1dsj5NPYqwTtPcIh8DyyzGIZxeeqKHD85gN5c
         3TD9i25rN/c1Yus8LoJkazCF0guHWwHcXJeEQG1tDU6rN6zEyLRr/wi4UwDf1TtIpF1T
         tZ/w==
X-Gm-Message-State: AOAM532049kY+yfZHAIiv9rQPHSjEOnx1o80q2khbTKzNvamIzbI0SWq
        k4qnmJXiwT5MKyVanMFgbw52tA==
X-Google-Smtp-Source: ABdhPJxTDONg5+dWgcta3ywSHKdZENZd0eW4Jz2LI0SUMT2PfNSlYvowMKQFjguQ+4K3ecOA03r6oA==
X-Received: by 2002:adf:f590:: with SMTP id f16mr12302790wro.98.1596424254997;
        Sun, 02 Aug 2020 20:10:54 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:54 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 08/36] wcn36xx: Set feature DOT11AC for wcn3680
Date:   Mon,  3 Aug 2020 04:11:04 +0100
Message-Id: <20200803031132.1427063-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order for the firmware to process extended V1 parameters with the
addtional VHT fields added we need to first enable the feature bit DOT11AC.
Once done the version number in the HAL message header will be acted upon
by the firmware.

Extended V1 parameters are a prerequisite for 802.11ac speeds since we
cannot communicate VHT parameters to the firmware absent the extended data
structures.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 05835cf6e409..661742cba1c0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2083,6 +2083,8 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
 
 	set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		set_feat_caps(msg_body.feat_caps, DOT11AC);
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
-- 
2.27.0

