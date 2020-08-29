Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5196025647D
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgH2DjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgH2Diw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74234C061237
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so895057wrm.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wSp9Uc31N+F391d+EwEdxeVPC+PHewHvyf7Qc4RkB8=;
        b=QLKHbzn/8D5DxiEtkzmemLHocLZctxdRUhXfO4Le6dGH/nXvxM3stqjNvSsvmdwBbW
         5LVKpiq7x/8KzY4/voVW43ErDPDJgyTmO3lcCXiUpncBP87i8dQLKbxfneui0m5LHgu0
         ZXDuIB0P31ZiuHWuYbb9gUKFx3fH4k9EaM50MAdhvh9ZR8h5tN7OznpPWRiQnEakwtL0
         wqHlE+LuVakeOV9e5pbQiOu8h/y9MG7P/8724a/YlEcOMBoXEKd15xgAKcreYT3MBofh
         5+/2/1f/6+D6dU6AKn22W/JQTbqpi+0pQHMi8/2LsaPAIq0T8hVtW0j3t4Tw2PMjZY0m
         +SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wSp9Uc31N+F391d+EwEdxeVPC+PHewHvyf7Qc4RkB8=;
        b=E6bq9hf2ESwNc1jNibIwExeTA9K2uruY8KSn2Hcx1vcB4VIygnvuIr1ZdI0mIPsrws
         c//9BUDwKMqcTE5fpi0RZTlgeck/TsLNKahhn7MrPC9Ci3A6kr/9u3O9eNwFhfkLAZby
         gSHrPBkOAYiT4CnzroZzc5602TPlaN/FEuBFxl6UQto9KathrNvAVcvt4hHV450PmJAv
         6h7JAtDgpnE2KR8qx1gk+dc51ryRvN2GQI1vjtYafGjJe6ZCLbbEReItkUDxU8fzYAMc
         keftkKSoWlqlGJevlazN++fBn7pNe9rpspSqGfjAw7io33B52q4ZWA96EhtHLQl9cUCM
         n6Vw==
X-Gm-Message-State: AOAM532hAbOSOwptxTqdE8bfeqgy9SOUvOgJVzNWObnjQNkI7YNR4WNl
        gVc91Nq61H9ONs858feYZ05o2g==
X-Google-Smtp-Source: ABdhPJxkALG/H6goUDu4JS6Y9HbRlkoW4GKocGchHw2UKtNh6pAaDn63s+Pu0T6KYEmvqXN6wkbi0w==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr1589985wrj.380.1598672331177;
        Fri, 28 Aug 2020 20:38:51 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 6/7] wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
Date:   Sat, 29 Aug 2020 04:39:28 +0100
Message-Id: <20200829033929.2167761-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A previous patch added wcn36xx_smd_config_bss_v0() this patch converts the
version 0 data-path in wcn36xx_smd_config_bss() to use
wcn36xx_smd_config_bss_v0().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 360348456070..9acf1af14c54 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1717,9 +1717,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
-		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
-
-		ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
 	}
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
-- 
2.27.0

