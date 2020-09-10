Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5E264908
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgIJPuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgIJPsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5DC061348
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:08:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so7072191wrm.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLFPvFT3j2ucUrOKv+CXZzEP/po/jvIwEnOoqRXFc6s=;
        b=zD3wpIpRmsJGa9vb5i2t8lVxubP9ExGeUWJVoxOZwW6zHYetHYrFFZznVdgk5jUNqf
         vFl3b8QWWeMUdL4a6qwFczTkxoWI6mDpfS91TwyNp49iqdQpuY9DX5AgfCFcxHPEA2/s
         rMgSOwPd1nBCKJaIChk45TMohRsS6ypb6Mebyvaft9x3M+HJdt6p1W1xE9mAh1fBO4o6
         rFsukhnIYd9LcXdFfoMomTUcme2NK2f2/0RH8OkxPCruf5kArwpMj8kLDEDJIx3MFDXY
         Xgwr4IyWX4zuZcywAqIOdXR3e069nLv2NT6twojlVD47U7k9MXdi9StBaG/FHwn+RkSs
         6eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLFPvFT3j2ucUrOKv+CXZzEP/po/jvIwEnOoqRXFc6s=;
        b=WJ4tGsu+cZnVwl+EWaN5tR6YNWZ6Ai8kYHzBHjv/iKjI+cz4uu35HaI8mTZeLDzCxt
         5cmnVLazrUzP4bTWoPIE9zV8oq694Yqj4Mj4KiUwW+XYyFINc2uUzj4vbd7XgidOvIi1
         nDI4+YmbRKN3ph7uCTC9qWvPbE7g4su2vPr1SJZp31f0vmH/uXfIbfxLtooSnb8DVbQS
         p1H8dAiy+quaQbUg73wqMT4rgtlD07w0n4PKKAqvRGGwlaW0vWeka7hgYon70rkYAJyQ
         0TMncpxfsTqCYWmeF/QiT8kD/GgcygkSYWG5N8U2E+giDdIaLj+wJbTTFPkPRYbGfBmg
         cnUA==
X-Gm-Message-State: AOAM531NWunfS/MLwUq+to4ltAz1mJCcK1WLgZ1lb5eiW/0ddXFUweEY
        8LhN/lKT1omM44NZYZ1516k51A==
X-Google-Smtp-Source: ABdhPJwrR5byj619IrTorj9k0YRpmbfDjUB9uVdEbOgAB9MuTGrpnDd1oAcCoNcal61hykMVSPF4+g==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr9424456wrw.348.1599750479241;
        Thu, 10 Sep 2020 08:07:59 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a17sm9732901wra.24.2020.09.10.08.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/2] wcn36xx: Ensure spaces between functions
Date:   Thu, 10 Sep 2020 16:08:45 +0100
Message-Id: <20200910150845.2179320-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a small update to fix an error I saw where a few functions do not
have a blank line in between them.

Affects smd.c and main.c - no logic is affected by this change.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 43596b919ed7..706728fba72d 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -775,6 +775,7 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 				sta->vht_cap.vht_mcs.tx_mcs_map;
 	}
 }
+
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 {
 	u16 ofdm_rates[WCN36XX_HAL_NUM_OFDM_RATES] = {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index bccdae62ffbc..766400f7b61c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -218,6 +218,7 @@ static inline u8 is_cap_supported(unsigned long caps, unsigned long flag)
 {
 	return caps & flag ? 1 : 0;
 }
+
 static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_bss_params *bss_params)
@@ -2191,6 +2192,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 {
 	struct wcn36xx_hal_set_power_params_req_msg msg_body;
@@ -2220,6 +2222,7 @@ int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 /* Notice: This function should be called after associated, or else it
  * will be invalid
  */
@@ -2899,6 +2902,7 @@ static void wcn36xx_ind_smd_work(struct work_struct *work)
 		kfree(hal_ind_msg);
 	}
 }
+
 int wcn36xx_smd_open(struct wcn36xx *wcn)
 {
 	wcn->hal_ind_wq = create_freezable_workqueue("wcn36xx_smd_ind");
-- 
2.27.0

