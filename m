Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250B62E67D2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633583AbgL1Q3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgL1Q2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D47C0617A0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so11753578wrp.6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3oMZ0XZXTwR2OTVYcKlJpwlfLbWhAGf9POHgc7WDlA=;
        b=gDY9SHDEwZjqC5Yd9qSLQtJPQfZoC4Dfg1PYZrp9vO7Ru4H2lyZlbeSkIfDarXy6/o
         PHZj0iSyKYOXRa+0HAuIKFrLubu0fEA+C6OB3hOfX33qLnsMpEYylxlUS6EThMlLALub
         iA5PLE6qgNwsEsRepf03KcLGzm75TgwLIGr/MGfY9bx9w87l2GUXnSQVTRY0PSv40GkY
         c42kvOthOu82NX8GmP3hpthn5fLW6nzpNzB8zs/kc12X7RKpjavNP+xOOsVyOfgDNwTa
         8fcUsgXO1KzJr993fIbtVjlmrakiIwrUNcG0riDzcbQzG+wnJfrXH3q7CLhUjtaEkTH7
         oRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3oMZ0XZXTwR2OTVYcKlJpwlfLbWhAGf9POHgc7WDlA=;
        b=XKVaIwvi9NA+2gBSjesgvEf43wIHpNoh4muHTWd2/vJPCUtM97+e8Mosn0foBdZxkV
         cchfZeYWgnagEOS8J+4Q7N94jCKAw8wkst5lvcjKyQlRWpXKFVOHqk5z2+KYKHsjBfwS
         ryXijve48vAGGWcKqFkH1/Z6UBoWZsoql8RTQyx5zPKLDjvfCvfoDk8dmuvkk1dkAwZS
         ndwxrCganG5KXGeAXPXocIwg5GfmXGOEDIqEr6GIFlQDWDHb/AM2M4Ck0S7LoT+7j37k
         VLeiZPz9LtLdchMKbpiM3m1zUZGI9m9cbTTFJ6fXqde+R5GezxvbmZdM5FjBL3w+u0vx
         JD+Q==
X-Gm-Message-State: AOAM5313kRMis2qQjzikFYKnNJu+o8o2s5MNZQgFskzN2+aNFXpZVau+
        U7vNowGpb6FyYDmEcx0DpHDigQ==
X-Google-Smtp-Source: ABdhPJx5MmXQ+qEjz4/+IjVySyJMm5lwSTkHa3may8g7KZQLAHq6Rn04e8PzHJZjAgXKHBWdcpc4VQ==
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr51447656wrw.297.1609172861427;
        Mon, 28 Dec 2020 08:27:41 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:40 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 10/13] wcn36xx: Add GTK offload info to WoWLAN resume
Date:   Mon, 28 Dec 2020 16:28:36 +0000
Message-Id: <20201228162839.369156-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Having enabled GTK rekey in suspend, we need to extract the replay counter
from the firmware on resume and perform a ieee80211_gtk_rekey_notify() so
that the STA remains verified from the perspective of the AP.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  4 +-
 drivers/net/wireless/ath/wcn36xx/main.c |  5 +-
 drivers/net/wireless/ath/wcn36xx/smd.c  | 72 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 81 insertions(+), 3 deletions(-)

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
index aa2a416daa7f..b48a3f0dcc0b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -173,7 +173,9 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
 #ifdef CONFIG_PM
 
 static const struct wiphy_wowlan_support wowlan_support = {
-	.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_MAGIC_PKT
+	.flags = WIPHY_WOWLAN_ANY |
+		 WIPHY_WOWLAN_MAGIC_PKT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY
 };
 
 #endif
@@ -1149,6 +1151,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 			goto out;
 
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
 		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index db7988176526..dd12575f33c3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2886,6 +2886,77 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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
@@ -2936,6 +3007,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
+	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index dd6710672db8..b225c805107c 100644
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
2.29.2

