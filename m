Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2D405A35
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhIIPcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhIIPck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 11:32:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE376C061574
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 08:31:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so3158541wrn.5
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bcT8H0XxYOwPfG/ex8rhH7MU/535fM35JAq8iCTSoM=;
        b=uanjnRZBU/oz1r5Bss7O464Ys4xNnm1ivBZYeLSt1FKixG552OIuOR/TMJMlPRW2zq
         Ku1X9WRpDHYYBcYCmmjKFpAEuWGuFPbTDrieqXILNiWBodrFAodlhmDy1hhyDfb1lttG
         euuDGfq5KnDcjrO7MwmcqibTM3949vQjo02/7uKSedftpFnoljmBrjvCn17RbxX2HjtA
         ppydnhTmanFQ0yMJJzoKwakwPq+ygUz+/DMLA/8CvQrfmbeekWmoxrNghtgk4cFZIQrJ
         Dps9mUBs/qjRDV5KHW+MRRNPZVLdixtUJnwtsMiLJDqctgwoXlbCxSBnD+0/npV7Ktlu
         2rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bcT8H0XxYOwPfG/ex8rhH7MU/535fM35JAq8iCTSoM=;
        b=0oX5TrtQibLpwC2xZgnk7yRMntvcdaU4c2p0rImHbNLsUQYyAbMRmZWe+2C/cHMw9M
         EoAsZ0o0i+9rJavBzjdARvnletzNNTHOTWS3XULRvmyNIA2n2p6GCXFdGt/PR5LU4+k2
         UGHGhqDuduv5FrJA7tAS/CFRxnUffMPVjIQ37yv7r/1Fsed3f0qtRBzV88zFy2HMKMeU
         mQ9nSJSicpbMggTk/loqkjhbn4ti41guSGHPVTJ6HA5eOgz+TLdCZhKwBMYXdgXMB8b1
         uzIADO85qEsxunP1ma8MTXxKq976iUzTBPcgR1/rtdD80um1aJBzB5QrUgjiI0H1bPTP
         HAbw==
X-Gm-Message-State: AOAM532sK2FZs9G+ivyyab53lAMt5eQMdKgePpnm7lSa2a8D3bYiWJfm
        /LXIJnyZMNAmF07rIyaLEtTaPw==
X-Google-Smtp-Source: ABdhPJyUnNw9AirgAmvpQ8XRmbjEUpZI4c2M4sJ/i2j4UvI5T2jG7XOQsen3aJhQHbJndCvCOwTpaQ==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr4549458wra.216.1631201487554;
        Thu, 09 Sep 2021 08:31:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f5sm1856536wmb.47.2021.09.09.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:31:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH] wcn36xx: Implement Idle Mode Power Save
Date:   Thu,  9 Sep 2021 16:33:20 +0100
Message-Id: <20210909153320.2624649-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Idle Mode Power Save (IMPS) is a power saving mechanism which when called
by wcn36xx will cause the radio hardware to enter power collapse.

This particular call maps nicely to a simple conjunction/disjunction around
IEEE80211_CONF_CHANGE_IDLE and IEEE80211_CONF_IDLE.

Here we enter idle when we are not associated with an AP. The kernel will
incrementally toggle idle on/off in the process of trying to establish a
connection, thus saving power until we are connected to the AP again, at
which point we give way to BMPS if power_save is on.

We've validated that with IMPS an apq8039 device which has the wcn36xx
module loaded but, has not authenticated with an AP will get to VMIN on
suspend and will not without IMPS.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  6 +--
 drivers/net/wireless/ath/wcn36xx/main.c |  7 ++++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 55 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 455143c4164e..5f1f2480459a 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3384,11 +3384,11 @@ struct tl_hal_flush_ac_rsp_msg {
 
 struct wcn36xx_hal_enter_imps_req_msg {
 	struct wcn36xx_hal_msg_header header;
-};
+} __packed;
 
-struct wcn36xx_hal_exit_imps_req {
+struct wcn36xx_hal_exit_imps_req_msg {
 	struct wcn36xx_hal_msg_header header;
-};
+} __packed;
 
 struct wcn36xx_hal_enter_bmps_req_msg {
 	struct wcn36xx_hal_msg_header header;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 2561ae9cde65..412c629705a6 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -443,6 +443,13 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_PS)
 		wcn36xx_change_ps(wcn, hw->conf.flags & IEEE80211_CONF_PS);
 
+	if (changed & IEEE80211_CONF_CHANGE_IDLE) {
+		if (hw->conf.flags & IEEE80211_CONF_IDLE)
+			wcn36xx_smd_enter_imps(wcn);
+		else
+			wcn36xx_smd_exit_imps(wcn);
+	}
+
 	mutex_unlock(&wcn->conf_mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 57fa857b290b..599cb220b150 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2184,6 +2184,59 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
 	return ret;
 }
 
+int wcn36xx_smd_enter_imps(struct wcn36xx *wcn)
+{
+	struct wcn36xx_hal_enter_imps_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_ENTER_IMPS_REQ);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending hal_enter_imps failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("hal_enter_imps response failed err=%d\n", ret);
+		goto out;
+	}
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL, "Entered idle mode\n");
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
+int wcn36xx_smd_exit_imps(struct wcn36xx *wcn)
+{
+	struct wcn36xx_hal_exit_imps_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_EXIT_IMPS_REQ);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending hal_exit_imps failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("hal_exit_imps response failed err=%d\n", ret);
+		goto out;
+	}
+	wcn36xx_dbg(WCN36XX_DBG_HAL, "Exited idle mode\n");
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 {
 	struct wcn36xx_hal_set_power_params_req_msg msg_body;
@@ -3060,6 +3113,8 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 	case WCN36XX_HAL_HOST_RESUME_RSP:
+	case WCN36XX_HAL_ENTER_IMPS_RSP:
+	case WCN36XX_HAL_EXIT_IMPS_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 75d1a6d663bb..dbca0bd1b6ae 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -165,4 +165,7 @@ int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
 
 int wcn36xx_smd_host_resume(struct wcn36xx *wcn);
 
+int wcn36xx_smd_enter_imps(struct wcn36xx *wcn);
+int wcn36xx_smd_exit_imps(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.33.0

