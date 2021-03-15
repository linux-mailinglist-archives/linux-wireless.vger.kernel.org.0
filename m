Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7233B238
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCOMIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhCOMIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB6C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so5561543wro.7
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJ1ZueOKyXwKXk4LQeIQW096JlG5XtA4DUY7VcQGNfg=;
        b=qEjK4AR8/bxurzgIl87bjus+vUgq+JYaQbBGFV3crA8jZ6aPYxY+KkHRx5rWG5JljV
         EF0TJGvunz82xbfyTUSmKGblFnJwB2pTk8Frdwjd8HI0K/vaO/yNdFlY5EjVAihddBca
         F97AJhE1qwbgiceFNGUFHbUWdAqYUkda/O2OcsCTrP+j+0Xm8uqrb5cYh7bMMtOGIm21
         +Y0W6ms5ulzvMt4nQBXHf0j2ZW2bCEICYifNCOlTxHiWEU6UIpm0k+J5u6Dqemz6uqlZ
         f1ts64W8bNzkQDN/p7Ap/Gy+z5SmTFYq93Drm+JTXC7J4YKK5zXL0LZZ5/eljloDiVOl
         zX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJ1ZueOKyXwKXk4LQeIQW096JlG5XtA4DUY7VcQGNfg=;
        b=LWx0KwT0dBd0irAq1nDByOM2TVe15yUHWiX906MAMhBaRPuPTz3jRQoBBVr12cYiHI
         XXOXQErAqZxhtf7O/V2g8S9DzMVK1QuCxdoBmXHfN01dlRfGeZawC7S483IqFcM07MIK
         ZWh5ggF2r1ly6vAxZVVbq77yRnZFsYrX1Fku0JgXpUupQQu6h4UDjMM5TSZkt6UT22KM
         nmvT5srw3hFZs+bBet/BHAVjcwVzJr6on87ong6aSikgMCTiF6+J+qFPSSeExDZoxuOM
         lEhX/Uu4ThibYIRXFQakxAlaLPeJ028JTS7aQoaPBztDlT7fMYzS/71tqbxkdLOfjRfR
         0ZRg==
X-Gm-Message-State: AOAM532/aSnaf1aWoFegg9XcNFzLmndTNAOxXMYMHcTkF03x/Yw1gMqT
        UcG1BIXlVeBk7wbLQVlc65VibQ==
X-Google-Smtp-Source: ABdhPJzhqGWFjVNco8CGb3VQVsxmxFQlKkELUu1gV8Lk6w359GrhfG3KegKvsYmJXxKsD5gmAovyXA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr26848364wrq.60.1615810100562;
        Mon, 15 Mar 2021 05:08:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 11/12] wcn36xx: Add host resume request support
Date:   Mon, 15 Mar 2021 12:09:36 +0000
Message-Id: <20210315120937.2512341-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
index dbc5c9902794..f222f3d4d5ce 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2975,6 +2975,40 @@ int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn)
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
@@ -3026,6 +3060,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
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

