Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542542A12D5
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgJaCWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 22:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgJaCWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 22:22:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13E4C0613D7
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so4459376wmf.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1pIiv6a1ZuCdegA7YtbhikD3yvgauY5vKag7uzOqxg=;
        b=znIKUbm6pcsh2kvWlrQPUiMw2DCdvdI2MuX112P9jBzTsR+WTiUVTnjxUVFHj8DHBP
         HZFwsMgpG8vKAzIG29IPz+DxG0eBklr6++ob5qjN9GfSqOpAV78DxYUyjBe1WgIYXdit
         ZD1ngwGN+ggSBHgWpwK1BdWizTT/seY2eii8bJCoJC5hKHf4F9po7eBF83sszNtqYova
         ziS2oSqf8g2IryAPqjvo4v81ze0ZQUWPEp1hLEsdOcPOxZA7fCjR2IwWRTQak+5/kcCP
         DigTyvR8RYPlpWeFcNCxTunO/sfFmPa5Sg+rBEc1QdeCFs1K8ZBEqm3m9YxA9hlaxvl6
         J9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1pIiv6a1ZuCdegA7YtbhikD3yvgauY5vKag7uzOqxg=;
        b=OmY1UiYbSEEF5DOVuJ3uF8kYRYkW8+OCecnpMwcztgVgrdQGYg3maVJN5QUNTGC06p
         DUFFRh2LzNQMMOfYHxfP0H9X+qXVG1JzUrmQFJlC3j4VHptDDFQZRhwceL33TG0xDQ/1
         c7vGNuGXq4V0Ey5VsF9bPcYwTgRTLtIEg09fPzWb7msGsmRCrBSxjeTRyNIK69bAd46e
         mlD6ZSsBxS0PER5GXaRxib0JFgvqBjJjQmEY+BVq5klZkwiOrYniKqRGRODnObVbAhrG
         VqnkGTTWG1cl6yO2CFS6nj4DnzIsGW0tIkTh0qxsLTub1Lhw2fBjE6WNmQDNrkWB9fQV
         ujtA==
X-Gm-Message-State: AOAM5315VTFvPz56VPjiktiTKbYj0b3KjazJoJDHSpijrzQ7OcUYugzg
        PobhguahVjvUYRrtWOlLA6J2PQ==
X-Google-Smtp-Source: ABdhPJzWVZhecb+9uXQskjrV52RgL5iIS9/PzlQCcUf1l5OxMIhnnchvniZXP5YNa7BhJo1ItKPHNw==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr5751760wme.0.1604110942525;
        Fri, 30 Oct 2020 19:22:22 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g4sm6663817wmh.13.2020.10.30.19.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 19:22:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH 3/3] wcn36xx: Enable firmware offloaded keepalive
Date:   Sat, 31 Oct 2020 02:23:11 +0000
Message-Id: <20201031022311.1677337-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch calls wcn36xx_smd_keep_alive_req() on the STA patch immediately
after associating with an AP.

This will cause the firmware to send a NULL packet out to the AP every 30
seconds, thus offloading keep-alive processing from the SoC to the
firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e924cc4acde0..b514a7b952df 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -910,6 +910,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 			 * place where AID is available.
 			 */
 			wcn36xx_smd_config_sta(wcn, vif, sta);
+			wcn36xx_smd_keep_alive_req(wcn, vif,
+					WCN36XX_HAL_KEEP_ALIVE_NULL_PKT);
 		} else {
 			wcn36xx_dbg(WCN36XX_DBG_MAC,
 				    "disassociated bss %pM vif %pM AID=%d\n",
-- 
2.28.0

