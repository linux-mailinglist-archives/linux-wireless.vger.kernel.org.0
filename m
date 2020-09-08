Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1298B261A48
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgIHSec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgIHScu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58946C0617A5
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so228558wrs.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkVQqcl8Y72suOLVUyDLPMVLmKcAEdEBQttsVtZoFdc=;
        b=y4UZqdFwkp8nFPNtkEBkwllKDqiZ5DJDPAoBQ1pt+AR0JBZGN4f7fZLScqvPdZ+5gN
         gEWX8+QDG7hzBMrEsrr/M1BMq6I3JpC6U/xpXHG/xXJv89+5qpaY/yP7fQB2B4CiI9hP
         eH0P2vw4VQ9OBXKugLSNBMx+PyHzV1lcwfkhYLAuXZleCoUzzWqFTc16v/3mN9Rbc+ty
         xLpxL4Yi88QCh3T2Tq52TctSGCM5ZE2PhazvxteoPr+PRL+RNyBSu+Lcqgp8oAzodc3R
         kp1g+v3j+qUF2O6OvhUw7D5px4thZ5TCnrgja/98Lk35Frp5n4Y9ur/+nbaqYt0Un1Za
         oOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkVQqcl8Y72suOLVUyDLPMVLmKcAEdEBQttsVtZoFdc=;
        b=OS6HQRrHLDlqIcNUYFzinxUCkoPLk2mMDrpLLzSYrswzKSnCSqCfU/c4ZtRH41Yo5+
         fVKqQ0uzLHoPOYNd0zr9oZdshdw2oinkQ9ZYbM0J/gsUQ9AbX3G44jZVSxy9VNoiSM7T
         ybhdZNUxoKUpTUxX6hrc2XVCGspwJf9/Q1RemaaUNv8aMkn90EuNbd2+B2MYqT6fNw51
         3WPXhtomnyj04b1KWWgBtqpPbJlFn0lFtRgJAxuHhFT/jo4WNypCCk72IYm4QIjBSggk
         m5lR4CjVH5NTGi9DU+Nze4qiMK+mb9KbWFj1TPm/QXnHvcs/LdPoNUKoibSxB8nTYd9s
         73vQ==
X-Gm-Message-State: AOAM532WehbOw939wBxQKFufA0kBynO1aLbhQjK/c0GBhrxRKoj73Sqr
        WevFePENQXyVWTFY5TvBIEA6BQ==
X-Google-Smtp-Source: ABdhPJzlLeVSm6L1QG/FzThUZL/hwPD73T9x+gfpdyG0srSg/leuNMuP7KqPVRpBq7TyfyZgP67tYQ==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr951320wrs.416.1599589455037;
        Tue, 08 Sep 2020 11:24:15 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 5/7] wcn36xx: Add wcn36xx_smd_config_bss_v0
Date:   Tue,  8 Sep 2020 19:24:53 +0100
Message-Id: <20200908182455.2870345-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_config_bss_v0() as a step along the road of
functionally decomposing wcn36xx_smd_config_bss().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 7e3302ba97fa..e603e2d3be16 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1584,6 +1584,47 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, const u8 *bssid,
+			      bool update)
+{
+	struct wcn36xx_hal_config_bss_req_msg *msg;
+	struct wcn36xx_hal_config_bss_params *bss;
+	struct wcn36xx_hal_config_sta_params *sta_params;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
+
+	bss = &msg->bss_params;
+	sta_params = &bss->sta;
+
+	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
+		    bss->bssid, bss->self_mac_addr, bss->bss_type,
+		    bss->oper_mode, bss->nw_type);
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
+		    sta_params->bssid, sta_params->action,
+		    sta_params->sta_index, sta_params->bssid_index,
+		    sta_params->aid, sta_params->type,
+		    sta_params->mac);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+	kfree(msg);
+
+	return ret;
+}
+
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-- 
2.27.0

