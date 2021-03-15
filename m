Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A172E33B235
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhCOMIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhCOMIS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89EC061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v11so5561440wro.7
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxxDO1NJ8u6G4hS3KD+56T8rWCBlJMNlPkegzoBkaT0=;
        b=MKhERGu2EsTCYzKCc5r6ZhvW0Oaepfw9gJeqV7i5zekg2QXNT8zs3q3srYgIfbn9GD
         9vnTiGYz/6xrskVEzMEJgra9W8jD+6FLwFvxt6sks70Rd73lWYEoTCesgTJdT5nZIQq+
         8XR2IEahoxpzSGbctEi5TbvU0MqbCzQW69W2mgcHR91ev1qoLv0A5yKJhodAXes1iBVg
         BtkvKM6xaae3f8CZUApVi2hxFNUOCUyc7vXX7Wec7zkiKXxEsjdHro1MgOjSLPJaO0Fo
         IQaBeie9ZMeNN+ExdxBMlTGi7gmZhzBHhsPLezGo7ZlGxTk8LugYQLQK7ayyPG9aIxkv
         7tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxxDO1NJ8u6G4hS3KD+56T8rWCBlJMNlPkegzoBkaT0=;
        b=me/Nys+vqMppCz6pItSe9cPQ7sPrqVq3xO/JH3zRL6SV4HxXWYUkMVmEo7tGc1xFEK
         hJCHjj2dWYlQuaBu7zHz2kpKiuqWFF9Pi0YohiwPUWAn/D0qU3VcQFVS28lZe8HJTDgl
         ksi1tYpPZTsuRoMkGLJUith54y819GbemsMTXywMPYsuY/zUj8gsqCzIY3oX4si/dvaB
         +HKqwxznD6L4fWTXF/25gJrhtmGYxq78sJLzqus4gy8Re2wKd3xOYUCWKUDtUwTQQzZE
         9LK/cYJnQGIlGhPixrcOjbTTHM2JoqEUGIQs7tcapeboC3frHIgg+9RUtNq08wDp5YO2
         QvbQ==
X-Gm-Message-State: AOAM532IOgRnXf/cb/l9hNO0K7X1+YNB9fUOJeOnksB5sUxyO3YMbYL0
        2kjHKejWy4mdkI4FgUIB5rdjNA==
X-Google-Smtp-Source: ABdhPJzHK0EJdcec8xY4O7mCldUdlnohULlQzJA0EM2ADUq4aBIBafvWHeUJWBwHGZd9c05b/g1UQQ==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr27641213wrr.161.1615810097236;
        Mon, 15 Mar 2021 05:08:17 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 08/12] wcn36xx: Add GTK offload to WoWLAN path
Date:   Mon, 15 Mar 2021 12:09:33 +0000
Message-Id: <20210315120937.2512341-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
index c3095d800c32..c3e384803141 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2848,6 +2848,43 @@ int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
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
@@ -2897,6 +2934,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
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

