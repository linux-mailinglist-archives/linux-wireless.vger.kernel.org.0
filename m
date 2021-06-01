Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE1396B94
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhFACt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhFACt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DCC061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so949770wmc.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJNEkd9odSJS4sHsW2fkqbqVW7PMvd2b9q+phGy9YsI=;
        b=WNY3d5b2XfAqZwc3npFOEnbJiCzmBkCHr8VspurAkD1f0X+3PN/TOYFXREcUnRZjOF
         4fkKEKrDvoof6HayMy0qswsVwMk2wpTRVGpA6oAwT+NjUiHKgNg/aRbq5gvKyiHnpZdc
         zuKLCRuAo9It7Lu3iwL5gIE+yo93XY9ux6l4rQlHhPia89wegVNHjDuJJmpd0uuR+nZQ
         C/5Eg/RYYlfYD1nFl0ZxCGgsIGyIO8Q3+I4hasav2BfN5TgnVFl+Mm3jn/C2rrbs/6hJ
         c8CXFvBopJxQ7hwqtcKC6S2GYFy9x4EIsN86p533XH01/S/4HSTV4ptl6zBCnNeItviO
         /CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJNEkd9odSJS4sHsW2fkqbqVW7PMvd2b9q+phGy9YsI=;
        b=cW1CzSoglgDHgZTvmIo1TbEVciTjPkv+0EcXdD3LH8wKHZDnQc7/pvv+arw8InBseJ
         XHl2i9949tIXjW4ENK3diVsJRsEI0vo8EeMT6wHD8bNr3tb0zSXBlR+6byF2Z6lj2xSo
         mTy8JNq4L8ykbxkv9rhvPeMn5OsC/kJ/w051QDEB/3iNvt435GZK/JltdQ5tBbd52mVn
         hv91VWbsaLFI7kYLRtXdNHKO5UVqP1XLFE+UwYTEu8TOfzmaAqQ23Yx75QpSt1KVgUzW
         wDjPCGA0RC1o/fGcn9B132GymXUc+itFIeonyiSYaYTFknCKefs4FwnMJDB2S7EwovFD
         PcWA==
X-Gm-Message-State: AOAM530YXSLQoTngw/3jWQ7h1CTNZz825B7FesvZAWANlqOYWlMVF/Ty
        bmc6Xk+O8tE6iFA7jddkVnwX6Q==
X-Google-Smtp-Source: ABdhPJxnqgRV+c2V7Detzoj1ffaFDil9+1RsoRcSXp30OfVyqegmFM9tav1dYYlRTHFKJS+QvYbVCA==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr3960939wml.51.1622515665432;
        Mon, 31 May 2021 19:47:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 08/12] wcn36xx: Add GTK offload to WoWLAN path
Date:   Tue,  1 Jun 2021 03:49:16 +0100
Message-Id: <20210601024920.1424144-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using previously set GTK KCK and KEK material this commit adds GTK rekeying
to the WoWLAN suspend/resume path. A small error in the packing of the
up to now unused command structure is fixed as we go.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
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
index ec32b8b0067d..db1528a14757 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1119,6 +1119,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_ipv6_ns_offload(wcn, vif, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_gtk_offload(wcn, vif, true);
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
@@ -1139,6 +1142,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
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

