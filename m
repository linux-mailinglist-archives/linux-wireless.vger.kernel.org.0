Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A212C55BB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgKZNcw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390282AbgKZNcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804DC061A4F
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so2184160wrt.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcBd80NlVbn3uGSdfGXvocYKOP7aRNETXFKMl2YiPGc=;
        b=Q8jkVen12XCoRGnL4iPurJx+25LwQnN4rkU8WQh9kxbtbsrgsycqNffe2qOGBYR+7C
         Svfqh6UT2eGQdJXGyNyslkVr/NuOXoGtaDzSUcNQ3uptyIFnbW+fO3wzISfc1qaQsjJi
         5vZlttAaVI5n5zE874WJack/ZatNl3cE9nZWW+B4v04noSvn3CuzseQtPkQTXoF5QSS9
         eVRsopl+s0zomc541bDr63PewFZ8NVmVKt8HuY1l1P5/DW/m1U8JXu/MWptu1wjCpjwR
         abJII0TpdSoGv/qiXv3CZY+vSNLU8netmmGJxdMR4phDapNWTVDvBCXciVvU75IRIFcM
         8i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcBd80NlVbn3uGSdfGXvocYKOP7aRNETXFKMl2YiPGc=;
        b=uIdgmwLuR/9y3jwYswri9w7EOq/v5bmm3ibov3VQvGlchTU4IMwp1ddSJjR95Ba0ci
         PabXDLh74Xz6TFN8ybC4dpTqMEsmnZtRFZcpLg+poxV7M8rvZi1XFP0pXapnfRBPGktf
         MTB6rNBTwN9wRWW5gVM5OR745nvGXIoriLyX2h+Q5AkuJFhRaqW/WeAE5TOO5zr2lZ1F
         R97w7zy+qHXda64gD6KRNIbnLp9hf6cMlkt5ZtFGPMU2wtFI7iP1gdbIV56PSzO5BtYI
         wScZbTLCLWzjGR7Kzpr1OzXLmg4fJtdP7v5njwMvpxZ4fZ5BiCOAdy+JvoKdleBCpLIA
         d5OQ==
X-Gm-Message-State: AOAM533xZ24jxq2BlxXEMr6SDLIx0NvWfQYg/Xwr0lKO3Io6gSuahrqw
        VFCloLH8bh26QAVrf4QERgXeYQ==
X-Google-Smtp-Source: ABdhPJwzkmAeb05I5tYzBStx7l2lOPLol3d3q+SROPVuSSvfSZQoLVYS2QldMxZ2jqVYNhsvFPWSTw==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr3872317wrs.31.1606397529940;
        Thu, 26 Nov 2020 05:32:09 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 11/17] ath: dfs_pattern_detector: Fix some function kernel-doc headers
Date:   Thu, 26 Nov 2020 13:31:46 +0000
Message-Id: <20201126133152.3211309-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/dfs_pattern_detector.c:34: warning: Function parameter or member 'region' not described in 'radar_types'
 drivers/net/wireless/ath/dfs_pattern_detector.c:141: warning: Function parameter or member 'region' not described in 'get_dfs_domain_radar_types'
 drivers/net/wireless/ath/dfs_pattern_detector.c:239: warning: Function parameter or member 'dpd' not described in 'channel_detector_get'
 drivers/net/wireless/ath/dfs_pattern_detector.c:239: warning: Function parameter or member 'freq' not described in 'channel_detector_get'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/dfs_pattern_detector.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
index 0813473793df1..80390495ea250 100644
--- a/drivers/net/wireless/ath/dfs_pattern_detector.c
+++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
@@ -23,7 +23,7 @@
 
 /**
  * struct radar_types - contains array of patterns defined for one DFS domain
- * @domain: DFS regulatory domain
+ * @region: regulatory DFS region
  * @num_radar_types: number of radar types to follow
  * @radar_types: radar types array
  */
@@ -133,8 +133,9 @@ static const struct radar_types *dfs_domains[] = {
 
 /**
  * get_dfs_domain_radar_types() - get radar types for a given DFS domain
- * @param domain DFS domain
- * @return radar_types ptr on success, NULL if DFS domain is not supported
+ * @region: regulatory DFS region
+ *
+ * Return value: radar_types ptr on success, NULL if DFS domain is not supported
  */
 static const struct radar_types *
 get_dfs_domain_radar_types(enum nl80211_dfs_regions region)
@@ -227,9 +228,10 @@ channel_detector_create(struct dfs_pattern_detector *dpd, u16 freq)
 
 /**
  * channel_detector_get() - get channel detector for given frequency
- * @param dpd instance pointer
- * @param freq frequency in MHz
- * @return pointer to channel detector on success, NULL otherwise
+ * @dpd: DPD instance pointer
+ * @freq: freq frequency in MHz
+ *
+ * Return value: pointer to channel detector on success, NULL otherwise
  *
  * Return existing channel detector for the given frequency or return a
  * newly create one.
-- 
2.25.1

