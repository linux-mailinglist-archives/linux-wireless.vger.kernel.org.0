Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15EB2E67CF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441832AbgL1Q25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441828AbgL1Q24 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4323C0617A3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t30so11797840wrb.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFlxfdScJISQHEQPsvwi72V6FodBvi35qoUUckJzFhM=;
        b=VFpSv9qQLSaccEYxNBJkiNrTDCkfCsp9QuL+zJp0/MY99xqzkBMsvIiyPEX1rx8hC2
         jwYgblnt27v0Uz8yJblLwtM8z5QBumNrCBS+K9009X1wJjfqVwVyWQAU789vTbcR6rk2
         prU+AzGwMIhXHx3ifpjTFR6zchlHJTAKQcKeGZXzOHAxeVjUa5MIPDJe6FOwNSp4N4du
         7FUX6hdhIShN4jZkpMkVlF1u+IfiTgJ6QmnpBUOb+F3pUGMMPv7fRxcWONRBBl2ko7nA
         LwXrFOv0Qi4clbW3T1r8YlTBGCJCH1T6BJznt4xgLadEC06XFxwP6FzxVF6chhY2SKxK
         5yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFlxfdScJISQHEQPsvwi72V6FodBvi35qoUUckJzFhM=;
        b=Tz9U0pHO10LhbR5w3are7zHIdayZvYBiBy1RD74ZTz2yGiOoumPyUT2yFQLGT8I9TT
         E8BNrok3V10QDHnjwJvG4hHM4BEr0P1/nQb+kzMK8lREeXuMn9Y/0xakmziYL2yEvUaa
         LDG4J9GbX08XdSaeQIbxB5Yc6XgcZLYWHF9WwM1kngRrAgnmS3zE1TpVWMY7sQDbR71J
         5K0JW5syAUaNWQSAxLS9Hn0mIFO4AA+cSdzvyYF1Gk73A2rHfzuWGNf5V2mtPFAG2jyJ
         sLzQLFimCSVhaSgG9K/c+HT3DexEXwSihCh0EZB8mgsAz/JPYi4+McfJFcY4IyZumMQ/
         WpUw==
X-Gm-Message-State: AOAM533AdPfD50suRbn/Ms1jfdGW/8uFijcLPWYAUZ7T4sRtdYSUEpiq
        rMFBNfn2vRmZ02ETs1uPQ9ubmg==
X-Google-Smtp-Source: ABdhPJwepbMFQGxc+PqC1KFidu5n4XlIJb7rTUAPBJ030D5lsSliFNfaUxEvXRUNJf/iwxTfRolwfg==
X-Received: by 2002:adf:8184:: with SMTP id 4mr53093783wra.63.1609172864755;
        Mon, 28 Dec 2020 08:27:44 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:44 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 13/13] wcn36xx: Add host resume request support
Date:   Mon, 28 Dec 2020 16:28:39 +0000
Message-Id: <20201228162839.369156-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
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
index ec24b0cc5b8c..9a2a6399c8a0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1158,6 +1158,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 		if (!vif_priv->sta_assoc)
 			goto out;
 
+		wcn36xx_smd_host_resume(wcn);
 		wcn36xx_smd_set_power_params(wcn, false);
 		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 5450d56d8e1c..83452d7f4634 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2989,6 +2989,40 @@ int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn)
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
@@ -3040,6 +3074,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
+	case WCN36XX_HAL_HOST_RESUME_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 77efcfa145ec..6dfed8f386d9 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -163,4 +163,6 @@ bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn);
 
 int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
 
+int wcn36xx_smd_host_resume(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.29.2

