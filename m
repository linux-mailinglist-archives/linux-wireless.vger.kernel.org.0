Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200F9396B92
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFACt1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhFACt0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08AC061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r13so6696043wmq.1
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RACFcUJtiWm8MN8W1vtslkiqbwIBEQgKrtcO2mZsrAw=;
        b=cOF0m11FkBVDzMfncBsd7LzLkKEZUYeWC0NvZV1RYRg0WgjmDo4aJMmBmHJY3zHyW0
         ld2wa+l9G6p7J4O741biGzu8PqhlWj9wF+gZqBl3B8eSlyB7AfcU3MpFugZHRgLKtMbX
         x1xo2rfup82dWaX+Mj/PpXzd1O2oz6SCursbIKwbRjxgWSzlZx7sZqCX7+E081v33tmM
         FfyFW7XSsfXnNZJDVwJBb0KARZiGp4vEDTaxMcQa8aCJ/x+DguyGvX6KsuDuK01W0lRT
         RI5hbNDsVn4dcCr02N4JqoShCzL1R/1ubsWCDK1pEshrA2kbN7uKJohulzzeH7jBhXgN
         oYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RACFcUJtiWm8MN8W1vtslkiqbwIBEQgKrtcO2mZsrAw=;
        b=p/dD7OM5/ThoiW1Xiqcg5fqtDUqmdYKJa7arYRFiMkx+R3ZN3JpbCg21RfvNSqd0sk
         0fUuNkb4qy4kj4jkOjuEn8bWv5lhPhir7TMC5LYtM5WT/DgTVxdSFtHLH+A/HuMA2io9
         wX934E0Jh/IPaytrbOBEzTUYkSA4Em8mP8vBpH59ztDOHm3AkmHqxKsRAwsjVDYNN9mF
         nE9/CrgWJ7ssABcPlRJB7GabGiCQhSk34SYwABV+C0I3o9xwIRXWWSypu6bb3LG7YHoD
         lGW5AvI/WUC17JdN694UUChi0K+ojrhuvj9eQMQbJ8g33MFBCot70nnhaCg6wu8grdmP
         cqTw==
X-Gm-Message-State: AOAM530U+umC7W7JOndidB5c7RNOlQ8zHdho3TpLKNqK9OtHwrvKHM7C
        AaK1+D9CQmQuMDwEeWS2BDo6Qg==
X-Google-Smtp-Source: ABdhPJwrNtNWcxeNlCNbjnolL1RZVAE+Rx6voOVfuZGyOsfde3M1UiTtQnR4XeItaiEomwzHDyBUMw==
X-Received: by 2002:a05:600c:4f95:: with SMTP id n21mr1836829wmq.74.1622515663462;
        Mon, 31 May 2021 19:47:43 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:43 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 06/12] wcn36xx: Add ipv6 namespace offload in suspend
Date:   Tue,  1 Jun 2021 03:49:14 +0100
Message-Id: <20210601024920.1424144-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to respond to ipv6 namespace lookups when in suspend. This patch
adds the necessary changes to issue the appropriate firmware command on
suspend and resume to enter/exit firmware offloaded ns lookup.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  3 ++
 drivers/net/wireless/ath/wcn36xx/main.c |  4 ++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 63 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 73 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 90333daed845..3b949b0b3792 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3464,6 +3464,9 @@ struct wcn36xx_hal_rem_bcn_filter_req {
 #define WCN36XX_HAL_OFFLOAD_DISABLE                         0
 #define WCN36XX_HAL_OFFLOAD_ENABLE                          1
 #define WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE             0x2
+#define WCN36XX_HAL_OFFLOAD_MCAST_FILTER_ENABLE             0x4
+#define WCN36XX_HAL_OFFLOAD_NS_AND_MCAST_FILTER_ENABLE	\
+	(WCN36XX_HAL_OFFLOAD_ENABLE | WCN36XX_HAL_OFFLOAD_MCAST_FILTER_ENABLE)
 #define WCN36XX_HAL_OFFLOAD_ARP_AND_BCAST_FILTER_ENABLE	\
 	(WCN36XX_HAL_OFFLOAD_ENABLE | WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE)
 #define WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX		0x02
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 240ecdd52f81..09e22f829682 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1116,6 +1116,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
 		ret = wcn36xx_smd_arp_offload(wcn, vif, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_ipv6_ns_offload(wcn, vif, true);
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
@@ -1136,6 +1139,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
 	mutex_unlock(&wcn->conf_mutex);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 478e363610e1..4a50e5f8456a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2793,6 +2793,69 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+				bool enable)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_host_offload_req_msg msg_body;
+	struct wcn36xx_hal_ns_offload_params *ns_params;
+	struct wcn36xx_hal_host_offload_req *ho_params;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_OFFLOAD_REQ);
+	ho_params = &msg_body.host_offload_params;
+	ns_params = &msg_body.ns_offload_params;
+
+	ho_params->offload_type = WCN36XX_HAL_IPV6_NS_OFFLOAD;
+	if (enable) {
+		ho_params->enable =
+			WCN36XX_HAL_OFFLOAD_NS_AND_MCAST_FILTER_ENABLE;
+		if (vif_priv->num_target_ipv6_addrs) {
+			memcpy(&ho_params->u,
+			       &vif_priv->target_ipv6_addrs[0].in6_u,
+			       sizeof(struct in6_addr));
+			memcpy(&ns_params->target_ipv6_addr1,
+			       &vif_priv->target_ipv6_addrs[0].in6_u,
+			       sizeof(struct in6_addr));
+			ns_params->target_ipv6_addr1_valid = 1;
+		}
+		if (vif_priv->num_target_ipv6_addrs > 1) {
+			memcpy(&ns_params->target_ipv6_addr2,
+			       &vif_priv->target_ipv6_addrs[1].in6_u,
+			       sizeof(struct in6_addr));
+			ns_params->target_ipv6_addr2_valid = 1;
+		}
+	}
+	memcpy(&ns_params->self_addr, vif->addr, ETH_ALEN);
+	ns_params->bss_index = vif_priv->bss_index;
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
+#else
+int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+				bool enable)
+{
+	return 0;
+}
+#endif
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 6492a628ea6a..e03ab7878432 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -150,4 +150,7 @@ int wcn36xx_smd_set_mc_list(struct wcn36xx *wcn,
 int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			    bool enable);
 
+int wcn36xx_smd_ipv6_ns_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+				bool enable);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

