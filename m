Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5720397623
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhFAPKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhFAPKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90DBC061756
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c3so14696426wrp.8
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4tsdVSzTEyTW8xfDSUd84WZI63N7G22QirTh+/x9MM=;
        b=mnLdL50IkTgsJjnm4vQ9aWLdaMvL47oT5L5dllPfEYcigA/J3Zf8iLVPI+8eR8pIfR
         Fplo/+NinlspP8L6xzFJH2pA2Ez/DAFrxzhdesyMYcjRCLpOuUIXxOSvU1qLeluBA7sf
         +kG5MX72k+XqSpSEtsmcqIdW3c+qt+I+FBM0IpNRInrzeryqoGG5HD/DhOdwB6mMzszj
         MFEHb+kngSSP5u4NYPIDMZ9L6vcNWAjg76dKY5lu5tHolbpimawduIEmdMfE/x4iddXA
         jcQHocUwqkv77wOxOH+Sqh8kXxo96LL6r8QA2GI11XZ0TN1RvmvuuEX9N7svnBc1txci
         AnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4tsdVSzTEyTW8xfDSUd84WZI63N7G22QirTh+/x9MM=;
        b=X9EOGCUAlvUYTQWKfi7sAHxOWHUswJAdVuR38ppCubjRZ3tQPdkVyAuJCNZlmcGI9v
         tc4fNpb1hYZRgyP6Ky/vCijo1xWt8MVqQaKCO/KOeqf1iz6D7RjQh+QwLlOjcaIqydji
         unrtRlGctI3f2rGeG8kmQKDJ1B2jcT8T6wRUeHwy7rL6brUHmULFxNxSyHGh6uxnbLK3
         lJ+4lc3NFYeZVMgOq01+b/amVWVBy2aU/iL9z2rn4LBzxpWe9Sn9YH/p3DAFGp3eVMqu
         wWuh8pnyipBlYUcMo9AQYI/sVV00Ge7Q7lZfWz34Wc/2EVQBrTc80YVwNo923XgT3J/p
         /fVw==
X-Gm-Message-State: AOAM532F0mTXY5mPPAXUx8K4xSIndU7QAxdPqqSvg2hgS/70w2noolUM
        uBORA8RVnyjL0cPoGY/TTTgZxw==
X-Google-Smtp-Source: ABdhPJzLGVIhLIrURBOHVlcqOjstBQVodcP0S7Ptb2Gh612fuQBh7qKCcHvkusi8+tdmTboROHzBAQ==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr28374308wrs.264.1622560113485;
        Tue, 01 Jun 2021 08:08:33 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:33 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 11/12] wcn36xx: Add host resume request support
Date:   Tue,  1 Jun 2021 16:10:00 +0100
Message-Id: <20210601151001.1450540-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 35 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e4d5e4d597f9..c697b9f3633a 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1144,6 +1144,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
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

