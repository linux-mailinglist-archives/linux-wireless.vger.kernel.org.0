Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CE34218C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCSQO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhCSQOE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B37C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo5535386wmq.4
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhoTMgCF+XvAHv8UavGI2Q1mjtQ3p6Q77CqaQwfEbCI=;
        b=MbvTpQjD5IuW3Jhust42HF4Y1LXfxdhB4PJAMSzJz4+MlIRExIDqGVcllfQHG9I8gl
         c0iMSclQJAcHZl+bn00W/PnN2kfVOiMfGcwjpJPNbcFN/zMNYpli4MXIyud2BK1vsXn9
         W6mJrnGt9qIOTVZYIaT/z6Ia9Z2X7s/bEO9O4SbsWraWP2iDxQ7oqHEU7A5UU/N9pbsa
         xpKBd+r4Myp6tTbY54ypv4RACdsauOVzAo+jiQzbFa8hnosqStvEaMzlQSglxxFMecW1
         2cZ4gHs2OSGh2PSm4jjYpl/9ELuvdJwfjzxY56yyXh04ega5cXus5Nn+W0HiKQtEkJej
         dwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhoTMgCF+XvAHv8UavGI2Q1mjtQ3p6Q77CqaQwfEbCI=;
        b=V3BFAeebNLolh5qMic2lDLvPyqOAzqTgwVJoTT8QUUh4Y01tu2VRV+uZBIXnVuJnQt
         ndt+8Xv9qLOcfAnwaocP+Ch52J+3vFPaxjK1BFuG216i9IY06PNl3wa5T8IAfdL0/5lB
         ZvyJ0J1HMDUgX1buYJagqN6fZ5tSkIXvqIvZKxek3bBiQLwo/WgszOiGkjw81TOj4aPe
         kr03uE2iM0d6dCCPIqi8j+4WPqjuG1//BiZ1B78uJyi4jd04mjTUtyQiBMpBat6ExOry
         K2tdTp+Hwuuvm4MaLyWg07k88HwOUTEroYMejS5i3yx4GJI7Ti2MeVjoRxG5fCtG57sw
         7qyw==
X-Gm-Message-State: AOAM531z1TxPEEOHn0dyWfakI+AVvjq8YwIBzgk9kkhJMnxDkjAGpwg8
        M6RJ3tsDB+wZeFkyHAEwoCwtVw==
X-Google-Smtp-Source: ABdhPJx03/5c9lOEOHmiJcfDl3ipdEuajBmYlWXlrzS8mpKZ22Ml81lD9ZUgjedC1Pf+zJHbFf+pug==
X-Received: by 2002:a1c:804e:: with SMTP id b75mr4496759wmd.113.1616170442807;
        Fri, 19 Mar 2021 09:14:02 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:14:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 11/12] wcn36xx: Add host resume request support
Date:   Fri, 19 Mar 2021 16:15:19 +0000
Message-Id: <20210319161520.3590510-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit is the corresponding resume() path request to the firmware when
resuming. Unlike the suspend() version which is a unidirectional
indication, the resume version is a standard request/response.

Once the resume() request completes ipv4 ARP, ipv6 NS and GTK rekey offload
stop working and can subsequently be rolled back.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 35 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 535e0d4245c3..ddfc60e02389 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1151,6 +1151,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 		if (!vif_priv->sta_assoc)
 			goto out;
 
+		wcn36xx_smd_host_resume(wcn);
 		wcn36xx_smd_set_power_params(wcn, false);
 		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 302877d23ecf..de0f630a82be 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2983,6 +2983,40 @@ int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn)
 	return ret;
 }
 
+int wcn36xx_smd_host_resume(struct wcn36xx *wcn)
+{
+	struct wcn36xx_hal_wlan_host_resume_req_msg msg_body;
+	struct wcn36xx_hal_host_resume_rsp_msg *rsp;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_RESUME_REQ);
+	msg_body.configured_mcst_bcst_filter_setting = 0;
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending wlan_host_resume failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("wlan_host_resume err=%d\n", ret);
+		goto out;
+	}
+
+	rsp = (struct wcn36xx_hal_host_resume_rsp_msg *)wcn->hal_buf;
+	if (rsp->status)
+		wcn36xx_warn("wlan_host_resume status=%d\n", rsp->status);
+
+out:
+	mutex_unlock(&wcn->hal_mutex);
+
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -3034,6 +3068,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
+	case WCN36XX_HAL_HOST_RESUME_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 2909facdb100..d8bded03945d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -161,4 +161,6 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 
 int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
 
+int wcn36xx_smd_host_resume(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

