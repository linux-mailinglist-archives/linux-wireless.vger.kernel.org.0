Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A162934218E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCSQO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCSQOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10937C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so5392339wmc.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWDQcCwP5xmFNCU8WV7XgYW43kOv4yOkxdnbhU++6lo=;
        b=BHfvpxbcOPIY/A0xOGaovHN8XLjdEjtPVvjfCw85NHFstblJDe3eJ8MOegilC7+P4h
         4he9nq6vWO1tlK/aGgwwBwraRm0vbFMeahI/LEgRnzT23BR8bULob53rhB9ivj2Heu3S
         PNbGPC2IzTyigt1onr6CttfX+jFlB0w6T2IXlZLHkb1c5TwZvtRoppdjeuySlMjph+74
         ImfZ36DZ+6BSG3b+c3muPfGvfGhDoBLnTE86+pW7qX2WqZlA2GZ9XyraTazX7bc+BjtW
         DEy08F0Y8C035Uky0JyelJTs+rzGc/qropXcgc9YfgktTFm5JRhZrekKEF6/SX9S7HpH
         SxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWDQcCwP5xmFNCU8WV7XgYW43kOv4yOkxdnbhU++6lo=;
        b=fX2SzPcltjE9FvMTWfZziNVeoMFfilPpDdvs0VkZzYi4mXLNBMgr5gJrVqPqkwI3j8
         1ippyQ5jZlbS2+f5C+mc4zdNFhydeGVU/IkTkeIsypeZz7y+fw1+5fIjwNQQpmzWT2CV
         cGQwEhV2q3hM6FwlBHw1e5rsicT+sfCQARN3NWGX8os0uitQm1J9b8pmLQASp7ASAbeu
         0sXYM13m75a2f0gcFRy0BLSjX7+SeHMR2+NNdKAV+H0wQVRVAoKzPWQ/+XGkrWXLuFrB
         xM+2wfcHnj32NKJN5Cu2LxVKUhjfKw0gUHT4qZkXrOAOuZUbxtvMKtWpBC/0n6eLwvia
         zJ0w==
X-Gm-Message-State: AOAM533Tw+bf6wJh0+HBl4WKKosmxUftexw4vv92sRg0HTHTziEb6GGa
        9RgyFZkUPX0q28V8rIyzwn4A/A==
X-Google-Smtp-Source: ABdhPJxRLXnR7X4ynrScSDeMLgq2oe+MiQn54uSyPEveTyLr7ZRy1+Xy5tL982RdCA+ISGBibNbp2Q==
X-Received: by 2002:a05:600c:4844:: with SMTP id j4mr4401141wmo.179.1616170440786;
        Fri, 19 Mar 2021 09:14:00 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:14:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 09/12] wcn36xx: Add GTK offload info to WoWLAN resume
Date:   Fri, 19 Mar 2021 16:15:17 +0000
Message-Id: <20210319161520.3590510-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Having enabled GTK rekey in suspend, we need to extract the replay counter
from the firmware on resume and perform a ieee80211_gtk_rekey_notify() so
that the STA remains verified from the perspective of the AP.

In order to enable the SMD command and response we need to pack the
existing command/response structures. Given these structures are currently
unused, there's no need to backport this as a fix.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  4 +-
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 72 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 1f3c2e840232..455143c4164e 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -4919,7 +4919,7 @@ struct wcn36xx_hal_gtk_offload_rsp_msg {
 struct wcn36xx_hal_gtk_offload_get_info_req_msg {
 	struct wcn36xx_hal_msg_header header;
 	u8 bss_index;
-};
+} __packed;
 
 struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
 	struct wcn36xx_hal_msg_header header;
@@ -4943,7 +4943,7 @@ struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
 	u32 igtk_rekey_count;
 
 	u8 bss_index;
-};
+} __packed;
 
 struct dhcp_info {
 	/* Indicates the device mode which indicates about the DHCP activity */
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index a138b84d0aec..a84128e04cc4 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1149,6 +1149,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 			goto out;
 
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index f74cb16327d0..e249971c4ef7 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2893,6 +2893,77 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static int wcn36xx_smd_gtk_offload_get_info_rsp(struct wcn36xx *wcn,
+						struct ieee80211_vif *vif)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *rsp;
+	__be64 replay_ctr;
+
+	if (wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len))
+		return -EIO;
+
+	rsp = (struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *)wcn->hal_buf;
+
+	if (rsp->bss_index != vif_priv->bss_index) {
+		wcn36xx_err("gtk_offload_info invalid response bss index %d\n",
+			    rsp->bss_index);
+		return -ENOENT;
+	}
+
+	replay_ctr = cpu_to_be64(le64_to_cpu(rsp->key_replay_counter));
+	if (vif_priv->rekey_data.replay_ctr != rsp->key_replay_counter) {
+		vif_priv->rekey_data.replay_ctr = rsp->key_replay_counter;
+		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
+					   (void *)&replay_ctr, GFP_KERNEL);
+		 wcn36xx_dbg(WCN36XX_DBG_HAL,
+			     "GTK replay counter increment %llu\n",
+			     rsp->key_replay_counter);
+	}
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "gtk offload info status %d last_rekey_status %d "
+		    "replay_counter %llu total_rekey_count %d gtk_rekey_count %d "
+		    "igtk_rekey_count %d bss_index %d\n",
+		    rsp->status, rsp->last_rekey_status,
+		    rsp->key_replay_counter, rsp->total_rekey_count,
+		    rsp->gtk_rekey_count, rsp->igtk_rekey_count,
+		    rsp->bss_index);
+
+	return 0;
+}
+
+int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
+				     struct ieee80211_vif *vif)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_gtk_offload_get_info_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_GTK_OFFLOAD_GETINFO_REQ);
+
+	msg_body.bss_index = vif_priv->bss_index;
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending gtk_offload_get_info failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("gtk_offload_get_info failed err=%d\n", ret);
+		goto out;
+	}
+	ret = wcn36xx_smd_gtk_offload_get_info_rsp(wcn, vif);
+out:
+	mutex_unlock(&wcn->hal_mutex);
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -2943,6 +3014,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
+	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index cdf4231efe26..90c7faea0ef6 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -156,4 +156,7 @@ int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			    bool enable);
 
+int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
+				     struct ieee80211_vif *vif);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

