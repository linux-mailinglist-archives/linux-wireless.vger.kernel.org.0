Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D6264BA9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIJRnG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIJRmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 13:42:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC83C0617A3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so7089102wrt.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2d2QAbaWN6PJb4MxG2jZFR8Dup0bgRXymEPCft+cEk=;
        b=XJRTNmuFkVTy99bAh3/QJevYHn/iaHeLI6pHIvsPy24gCoLFpqw/D0lJAdyJroV2kj
         mmclL5HorcC3D1FNkbvUGF7RM4c7xQmCl+P2ppmvvMCnBWmCzMpVvH4DMO8abzkMcnJw
         iaK2nGOepRPxGfA8d7Bvp4eFxpsKrkBSXmeQpXlTTegl3pTq48Hs6Khhrkr86v5D1mnp
         6Wp7qWMhjfFw4vkzWg9Fm/tIPCJzjuOS3Tw1L+wOf0xhoTDralDT6g+Ex6TLvtD/gCxY
         EXOt6LEP1qaNsVPxm7DCiNFeYlHYweC/bYG0AQixMQr3oMxwI29aW0Udf29A0907Vpry
         NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2d2QAbaWN6PJb4MxG2jZFR8Dup0bgRXymEPCft+cEk=;
        b=EbDJcJJyssYPd0DZHyuwhEJPqnaMW7ZQJzd8hheUZ88CyYiXnm74D3Ff5U2pFrpi55
         qxSPXgCO11lCY1S0u8mdLXlKRNcI9Pr04lZnjcfqwqU+iyKtDRXw8qqAZwx0BISI7NDk
         4n1vIwLN1dXZDUQdKTjAqTnzRTiL9GNROkb3KFn6xotzMzZI4vC3Zq8bZ/Osx5GSF2ZC
         4+ZlEZ1WSvyxQ0e/JYwYH4CUfX/QkOJBJeBJddgNhAQATr97qREz3J5N8M/dGdHTJWud
         kOcYfcGgKJM/e7dGpGsSZ4TMJZyHgL1JdTzXleJd2mKknGsONOLj8piG/Lx8ruix6xDT
         knpw==
X-Gm-Message-State: AOAM530t42LsC7KhHW0NUTDrbyLFd1ksvZWHFF95gLpXvU+LTbSdd06U
        z1rTfGfFYJL1S6h39UIH7EZGFw==
X-Google-Smtp-Source: ABdhPJxsNW1RrlTNM94g+Yj6nMxOB88SLLJn44sqRjUg2sXjVMMGC8PrQ2+IrzN3cb5mOp5Vk2AeVw==
X-Received: by 2002:adf:f808:: with SMTP id s8mr9505546wrp.268.1599750350396;
        Thu, 10 Sep 2020 08:05:50 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 7/7] wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
Date:   Thu, 10 Sep 2020 16:06:31 +0100
Message-Id: <20200910150631.2178970-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wcn36xx_smd_config_bss_v0() and wcn36xx_smd_config_bss_v1() have been
designed to operate in standalone fashion. As a result we can drop the
dead code now present in wcn36xx_smd_config_bss() and happily remove one
kzalloc from the BSS config path as we do so.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 39 ++++----------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 5ae6a2ccfebc..05e5e079dab3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1697,42 +1697,15 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, const u8 *bssid,
 			   bool update)
 {
-	struct wcn36xx_hal_config_bss_req_msg *msg;
-	struct wcn36xx_hal_config_bss_params *bss;
-	struct wcn36xx_hal_config_sta_params *sta_params;
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
-	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
-
-	bss = &msg->bss_params;
-	sta_params = &bss->sta;
-
-	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
-
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
-		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-		    bss->oper_mode, bss->nw_type);
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
-		    sta_params->bssid, sta_params->action,
-		    sta_params->sta_index, sta_params->bssid_index,
-		    sta_params->aid, sta_params->type,
-		    sta_params->mac);
-
-	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
+	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24))
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
-	} else {
+	else
 		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
-	}
+
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
 		goto out;
@@ -1742,12 +1715,10 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 					 sta,
 					 wcn->hal_buf,
 					 wcn->hal_rsp_len);
-	if (ret) {
+	if (ret)
 		wcn36xx_err("hal_config_bss response failed err=%d\n", ret);
-		goto out;
-	}
+
 out:
-	kfree(msg);
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
-- 
2.27.0

