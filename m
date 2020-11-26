Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A042C55A8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbgKZNcP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390297AbgKZNcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187EC0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so2157539wrx.5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E25/s2pmN1jYHUWPVit1bHGpEi6jEbn1M/6HbkBpU14=;
        b=ghZh7I2ge1DGcrfEdOn9QQfpf2S4lE4sRCwhWNIAbqweD0VZJ5aW2MLrQ3M1U5QPS9
         T6pAJDHpuwlvjDev0DfaaajeTx6HZJNTfOUKd9jFcpLmhuAL4dw9pROU4JzLdRnr+nVS
         GnUTXR2iMIyQX0xlODvNhvrcaDWZD8EHhPCuwg89FEo57eHQygnDItIAA72Fld9+gV+1
         8WLRLNXAldZgbUbhiUezL1qzrhdRbQ+cTRwl24Y0m/rTKj4QLL50sW9hWgfCjD7MvwNZ
         j2IZghwRkM2WeoEJnPoevWQ08nPVeZexIBWrboKaB0SEJKV5hJRvhLLSaNf+h9QNydzJ
         0ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E25/s2pmN1jYHUWPVit1bHGpEi6jEbn1M/6HbkBpU14=;
        b=S5Im/cnChpM5LxNKJFVBmaeGyNBSRcq7kBNEiZS9Wp/xzMRwMR83cZfNPzib1B1fv7
         ogpyHhRYq6u2AHoh2hid49nUhbQGa6kCJtKW2bgEOJnAkpe+Gt5Uc+s+2yTBJDUk4lic
         OI1uHwjAQVhGd2iQYOe4ExKclOR+HqdkhaFB6RZzHVhtGYAfKS8pGBnOfP04VInoQL44
         W0wn5bLwZUMKKtU4QlCPSYj3OuLSkjO4Psm7c2/6/rX06FHyyJtPFWsKr7BgOsjeB+4e
         VpeeX+JOEEdczxaPGbqiSG2XspH73TiL5IPA6tXpCMy0UD4wEdxATaDPmp08Bl1kXwV5
         i4AA==
X-Gm-Message-State: AOAM530sfnscf1Dr1u0ckBlpX/dtRii9L1dYmcm8hkN4oq1g6pPRIWT7
        NykjlzkQr++9jkC1gYS9PHVayg==
X-Google-Smtp-Source: ABdhPJzGbGQMlN0MfvBGTz+3a9+vPyrAN5IP5cV1HGMaN8Z4XgGravGisSzs7eebgmtDEWS3ftsmfg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr3997659wru.260.1606397530996;
        Thu, 26 Nov 2020 05:32:10 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 12/17] ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
Date:   Thu, 26 Nov 2020 13:31:47 +0000
Message-Id: <20201126133152.3211309-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are only a couple of these and none of them are conformant.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/dfs_pri_detector.c:39: warning: Function parameter or member 'head' not described in 'pulse_elem'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'val' not described in 'pde_get_multiple'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'fraction' not described in 'pde_get_multiple'
 drivers/net/wireless/ath/dfs_pri_detector.c:46: warning: Function parameter or member 'tolerance' not described in 'pde_get_multiple'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/dfs_pri_detector.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pri_detector.c b/drivers/net/wireless/ath/dfs_pri_detector.c
index 05b0464c6b92c..d07c454c9c00d 100644
--- a/drivers/net/wireless/ath/dfs_pri_detector.c
+++ b/drivers/net/wireless/ath/dfs_pri_detector.c
@@ -29,18 +29,17 @@ struct ath_dfs_pool_stats global_dfs_pool_stats = {};
 	(MIN + PRI_TOLERANCE == MAX - PRI_TOLERANCE ? \
 	MIN + PRI_TOLERANCE : RUNTIME)
 
-/**
+/*
  * struct pulse_elem - elements in pulse queue
- * @ts: time stamp in usecs
  */
 struct pulse_elem {
 	struct list_head head;
 	u64 ts;
 };
 
-/**
+/*
  * pde_get_multiple() - get number of multiples considering a given tolerance
- * @return factor if abs(val - factor*fraction) <= tolerance, 0 otherwise
+ * Return value: factor if abs(val - factor*fraction) <= tolerance, 0 otherwise
  */
 static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
 {
@@ -70,7 +69,7 @@ static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
 	return factor;
 }
 
-/**
+/*
  * DOC: Singleton Pulse and Sequence Pools
  *
  * Instances of pri_sequence and pulse_elem are kept in singleton pools to
-- 
2.25.1

