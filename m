Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC539C4BD
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFEBLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEBLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:11:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2CFC061787
        for <linux-wireless@vger.kernel.org>; Fri,  4 Jun 2021 18:10:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u7so5499273wrs.10
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3H89zHbM2SYQrgk6HivojJohFqBPkR9Ued+JHm1aSQs=;
        b=ar/zezf8L4tPxxkRA8M5o5FVE+yZ6BINTRcAGDXDY39dj83DVU0/BwOpl3rp6sZcoH
         bGz0bzx/B7hS8qsmn9wivRFbPIWt250mtv2Vkv6VHMKWzcGUjoncvZA0UL7wYmpxcnWQ
         VRzI5HPyH0u23QVI3FmO6l5BxsDU5mbWN7E9fM/cVhYB3U/hNMa3Y5nuUo6PTDgyUbZI
         TOGLhnlAb587NQUdoCE8AQSgiG0WaKPHML2w/zX62F92bFC6rHU5ridMXqoaZgyRwJEa
         YRkfhjR2XY8OLIgnxHjkcSQcBG8JcFm9r42WQZycQqUGfNIWW9BPfUzi7DgIPKZFJ90L
         LteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3H89zHbM2SYQrgk6HivojJohFqBPkR9Ued+JHm1aSQs=;
        b=j2pxSXDLJ+wHRhIboezFTJmMX99sIJ7YeH3PXznMQZ7zsoXVOqA/5qT2W2G2EeGh31
         B/Q8MDQXZUuAMYOlZbrLtvRRo+kTfvkXAKYZcHqRSi3m3yU1TZ9EdnLsict0Lc7Hp6DY
         sVV/jNfy3xkLvcOJQI14qKkIT/36vBhxojkglK4eelfD2dE8dEFRwlb9Gsq4hTMwXrgj
         7gC4/rsA9ZGlVFZAfqm2faKhTqQASy8I7XvAlR/nisdecJKHBGwgazbJrE2M7zvrEQex
         +ixpjiclhs98EDnT0vYnaC69SgmxuPTXX+M3NJ40sUhFBKBPUPLPaGFOqtsHZUyV5iVR
         08ng==
X-Gm-Message-State: AOAM5336IRcDYBaAyjVSEF418jTo3m+LUS7O/xzcDjbJO8RPWx94Sxgn
        ULPznXBAkEp+zFdUXcGyhUVCfA==
X-Google-Smtp-Source: ABdhPJzAzi1AurHj393hfjaZCqNETcth6dwSue+ltOgb70jFh8VoDBqL51CyKg2cv318YzIIcpmjSw==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr6394321wrs.246.1622855405481;
        Fri, 04 Jun 2021 18:10:05 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 09/12] wcn36xx: Add GTK offload info to WoWLAN resume
Date:   Sat,  5 Jun 2021 02:11:37 +0100
Message-Id: <20210605011140.2004643-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  4 +-
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 73 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 +
 4 files changed, 79 insertions(+), 2 deletions(-)

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
index db1528a14757..8e5d8326d551 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1142,6 +1142,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4063888e3f03..13200a079bd0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2894,6 +2894,78 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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
+	if (vif_priv->rekey_data.replay_ctr != cpu_to_le64(rsp->key_replay_counter)) {
+		replay_ctr = cpu_to_be64(rsp->key_replay_counter);
+		vif_priv->rekey_data.replay_ctr =
+			cpu_to_le64(rsp->key_replay_counter);
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
@@ -2944,6 +3016,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
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

