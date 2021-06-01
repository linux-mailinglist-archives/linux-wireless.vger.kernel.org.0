Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91C9397620
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhFAPKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhFAPKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52741C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c3so14696197wrp.8
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJNEkd9odSJS4sHsW2fkqbqVW7PMvd2b9q+phGy9YsI=;
        b=Q6MfWM1ZK0fp5R9HisziCn2yGoVuRxfdorL07UBWpGI+U4uAt6GibtMrOm/Mmvzs9s
         T76+6mv0zQJrJWgAe5DBEHwR06TrGBajw3Q7rtmBy2Ttz4ylstS3YeyUxtf+/3LJEOLT
         saN/QxQd+yN6zVQzw+55KUxjRMbwHreBAkDET1+siLkYn4bYVgAlNAkcyaWDyPq5cZRR
         RlPGkHnEm0Q6o6C//1i1GjPp9uKL+6agofFO6etrUHCHioEnDWyVYq9rmS/XKIeOPJBs
         hL3fRzbyRNdSg/f1Ga1RGtPTfjM1IAosPuxXaboEqTZxxBZ/hynpWNkmvfQOx0ggdns7
         8OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJNEkd9odSJS4sHsW2fkqbqVW7PMvd2b9q+phGy9YsI=;
        b=OiikJHIT1pc0goR92bNO+CO0x/1+6+jC9IXjVKuHBFp7lq3hcaXHEgmsRAWcabJmDI
         6LWM+L/c1dek2v/EKrF/buYdEY4JV+XNK54SHOSkIe7tdewE1/OiiQOsZ6j+DRpuki2p
         iLT5nItpbHlYK5CW4deqF1k0tcYmnGalKnrgUeqoyZw//dvbkCwHZZXXAxc2LnlaZdY4
         FJUQ4AKUgqJ1Lgn+X4SkQVSZroWxOcOFNPCXBDAslpiUBHBZHwW7lWKbSN6tmhTEDcQO
         sJSDqs5i6LbclhOt1Exg78DUHzl0/Gg6NbrQyfsIXZVQxs7B6IT+WwTqGbqvL6c++JXJ
         hbIw==
X-Gm-Message-State: AOAM530wsgW/UwVAaJjIU2dEFG9pwPK+SSw/elolhOcOX7NxFWWgQpb3
        JXUpQizwGbvVZTHfGDNYDQPQbQ==
X-Google-Smtp-Source: ABdhPJxPbWKVrnIV0x/cs1AMm7Ts3fRrnwO8eOZ+MsUMZ2JUw5R4kNUuiq7exbTvsElNDHmOtEstTw==
X-Received: by 2002:a05:6000:2cb:: with SMTP id o11mr28623338wry.326.1622560109995;
        Tue, 01 Jun 2021 08:08:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 08/12] wcn36xx: Add GTK offload to WoWLAN path
Date:   Tue,  1 Jun 2021 16:09:57 +0100
Message-Id: <20210601151001.1450540-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

