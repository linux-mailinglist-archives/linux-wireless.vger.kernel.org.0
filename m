Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDF342189
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhCSQO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhCSQOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E9C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5541267wmj.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfX1Ogv73uurEKmswylGOfrhr0B3EvW2dgqtNPTZVyA=;
        b=x6fhiApwghFo1P2OHZClb8jBXq6clJVd/jv+8668GVtKRifHQ5cJZIkTjYjC1+bqEJ
         9nHC5nciZRhNZRpl0E2T368UlWuete+VtHRO0k8/rbDdjc3jila9WqPXQzVSeEJ6ED8D
         yPUGx/dww5nAfdx+b1D5U2Bc/XY5Xi4Iih7UTmuwSvVmpDgggrv/rl1+93xqALbOXVs3
         WenkbQxpK34ECDxoPKXr6J9bCPBmDtC3ukcKvWKNEQ+6kY5t/QVjYTE0G6FilYcrd8tN
         tT8k8U7PSqBnDz27WmaxjpFFGLEdd5BPJJZ4ZXlf3mZUoCc2f3Hf2rvNh9TWDlPZ/iOJ
         Mj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfX1Ogv73uurEKmswylGOfrhr0B3EvW2dgqtNPTZVyA=;
        b=l1JLvII5mhTQWVnddtCeghuegnROQ2hCmfgDJ/td0zSAJ62lNxTOUyIoL4oUr3Wigd
         Syv5cPQ+B/UxIMbeh9A4BBr+0M67ef+FJI1VMqAigxNzBn9zVSqW4hWjck+LsBq7feWQ
         rADb1NqWsLAn0kqIRKtOSnd8arMqsxj9PVmvqYVZG++Xr7Zkq9aWPQLKq1pinkbyjdrP
         yj0wofgnD5avjUTgtb4ZnK8srpbyIFkSTP76Mft/tU/XPlX2FPlg1Mm9jRbygNocrZE9
         5If8rCjDVia0H3GTAfKlY1oZYlk3Hvq3TLQJiCoLXriidm/mReL/UOtHGDIG7Ou/1LAA
         Ku7A==
X-Gm-Message-State: AOAM530xwrWOpbyWRuetGJJQsp49bx2kpm74RlUUwFJfYkZUh2UQ0aWY
        9mZjx7OdzAPeHjlDgrUFB49Zng==
X-Google-Smtp-Source: ABdhPJxzwx+5QLvzDK8Ld/iTDKrjbjv3/CVUOoRXsCkFG0/QF5OcGKQpf5PRGGFXavrEyJrghv3ZxA==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr4477888wmm.149.1616170439786;
        Fri, 19 Mar 2021 09:13:59 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 08/12] wcn36xx: Add GTK offload to WoWLAN path
Date:   Fri, 19 Mar 2021 16:15:16 +0000
Message-Id: <20210319161520.3590510-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using previously set GTK KCK and KEK material this commit adds GTK rekeying
to the WoWLAN suspend/resume path. A small error in the packing of the
up to now unused command structure is fixed as we go.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c |  4 +++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 3b949b0b3792..1f3c2e840232 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -4905,7 +4905,7 @@ struct wcn36xx_hal_gtk_offload_req_msg {
 	u64 key_replay_counter;
 
 	u8 bss_index;
-};
+} __packed;
 
 struct wcn36xx_hal_gtk_offload_rsp_msg {
 	struct wcn36xx_hal_msg_header header;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 6b0deed23c5a..a138b84d0aec 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1121,6 +1121,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_ipv6_ns_offload(wcn, vif, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_gtk_offload(wcn, vif, true);
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
@@ -1146,6 +1149,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 			goto out;
 
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_gtk_offload(wcn, vif, false);
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4a50e5f8456a..f74cb16327d0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2856,6 +2856,43 @@ int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 }
 #endif
 
+int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_gtk_offload_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_GTK_OFFLOAD_REQ);
+
+	if (enable) {
+		memcpy(&msg_body.kek, vif_priv->rekey_data.kek, NL80211_KEK_LEN);
+		memcpy(&msg_body.kck, vif_priv->rekey_data.kck, NL80211_KCK_LEN);
+		msg_body.key_replay_counter = vif_priv->rekey_data.replay_ctr;
+		msg_body.bss_index = vif_priv->bss_index;
+	} else {
+		msg_body.flags = WCN36XX_HAL_GTK_OFFLOAD_FLAGS_DISABLE;
+	}
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending host_offload_arp failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("host_offload_arp failed err=%d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -2905,6 +2942,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_START_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
+	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index e03ab7878432..cdf4231efe26 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -153,4 +153,7 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 				bool enable);
 
+int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

