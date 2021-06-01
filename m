Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8563D396B95
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhFACt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhFACt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182AC061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso542760wmh.4
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzCu0Os7QusVy/mnoUQrDSZnGR8B3iHYzezmZSLH1gs=;
        b=PlzwALJjIHlluBvG2dDSGygs7LmpdYu7BlvDDUHP/calXA4fQGs72CrewHwwbuCuPW
         5L1+m8H+BdaqqpYx+OM/gHhn0Jfso8WmwpcCE+pJmNuqG2aT4/e16hbG31UAYsK7IH/l
         +mkP0xRBiLiU5hL7WoKPY1UQAAJscGv5ycxCgqttwVCWl+ErnoZR0DtBStXr9hFrwmBy
         4k5wj+GYdgu8XJyX7tgB6EoBeqiYvzhc0pa3Ufl25FGN7CuNKB63+kISLWTnZwWVFFhP
         Sg5mgfboytDttJcVdDhIptktGxcMQlTbWwHsl4EOs+wj/AgFsXRK9pq5Z5MeItv4dqOC
         Rh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzCu0Os7QusVy/mnoUQrDSZnGR8B3iHYzezmZSLH1gs=;
        b=GSRvq332sTLP35PCyqbc4rgPOg10uvDRuNzAgqPxrUeKlh2xH3mfRhQK+AZ2VHZoWz
         E31HPE02vamFr8eUlrVDwRPlADaSDtL8ePgF4VoUnH8cv1AD/or+5rsoaVMljHdcoZI8
         b1O+fm3SSGgAIKP8a6u8It3km7esYuxjXivIAvuJ8NCbCsiWMuj2ORIkg4wzSNPPFTSC
         maqrzRSQNBmF9muC7hpUxcx2rLZU9dVf7wUc8F859Xjs34DHiOjCSS3imVp/jPQSKoEL
         txIKk7lScOmX4Ihr0mBRSTG2bUoS0/1LKIIGPjo/VrS2OR9v7Ei955YEyEIdByzqLxi2
         PqJA==
X-Gm-Message-State: AOAM5332g+vpSPraDV8FSXL0VmQr1Grl+dK4KFDF8YGa1pbB2xyTHCEx
        SBnumNEP5dXJQJdG5yIOVQgxyA==
X-Google-Smtp-Source: ABdhPJyA+0tk5b0OM6OUH07yTbpCS2i9GM7M0zf//r1VT+XwPJbYTAL43V9am2rI2ucY5HCl8cEY+w==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr23680953wmq.83.1622515666386;
        Mon, 31 May 2021 19:47:46 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 09/12] wcn36xx: Add GTK offload info to WoWLAN resume
Date:   Tue,  1 Jun 2021 03:49:17 +0100
Message-Id: <20210601024920.1424144-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
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

