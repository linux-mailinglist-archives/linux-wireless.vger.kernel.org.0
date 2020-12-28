Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42E2E67CC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633586AbgL1Q2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441819AbgL1Q2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1817C06179B
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r4so10191624wmh.5
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eY+3wBeOdVNx7S6ZBSAwS1KofM7X7bObYB96unqy4iM=;
        b=ncQR+r9lZZkIE3sgyoMcN8o702yKXfL9OlBMszw4uGwYyuaT02B/AGYNFVE1czHUDD
         2Mgg5Zjc4a1SckslqrBQKnCpn4Y1nYx0apXcyagRp4XEzzQSJ62kryAAb0p9TqwQxFNh
         i1HChmy7yRkCJDeLYUhbzFTC3lxGLCtumc5ir7lJUhoHmWoDhlalqXPZyV1bZq6XagQg
         F+xc8+h9UXhXw5pjp6YhMrlvYkNxNEKh1chcNjLjvxqeQ5fM0tULWUNxXlPxfpilTD8l
         4x84es3irx4BEbTg20xqpweQfBqKYTdUnTCBtisoVoFTt40kBHIfKzkzz2/KrxObhboA
         cVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eY+3wBeOdVNx7S6ZBSAwS1KofM7X7bObYB96unqy4iM=;
        b=TPdeE/+jJMr6xFJsuRhZoV2cNPoGfK3vm/rdGOap2p+ooyfDrX/stQc/NtxuCwmbKY
         KG5FnpDLeBXCvYSoaftvqf/tRxJLcckRMy0eNzqa8g+cHOC+0YwGtnLCq+iIOuHlBKkj
         X5TBRMXi72UP1iCUGqGlZc/nFQt1X/tYf5Sa6hTXmbceSYtb4IZgVsDHGFRF1lTNJBen
         KSuqvFCTrnTR4wVZc5SdB4psu/r/uulH3HdIw4iJnlnc5VIcowtFDdeaxTj7c/X/iKga
         cv2b/LG4vG9y2gBuysG3eRvMkRM8nMKEFJRC4LG1tbnzsPgyL7gFQBB7Puuo3LGLNmj0
         cQ2g==
X-Gm-Message-State: AOAM532tzPbkhz9NvgbNCYf22YXPgMLYCMlNPS4arRMi9LL+mFpuJOtv
        KjSNIV5uZ8ffLcM+i/rc1eId5A==
X-Google-Smtp-Source: ABdhPJzmAZ8qPaSLtY8QMAZ13ERKFhT+1uEl9Smk3L3sWTmKBuWmjLFN8Zv2Kz0uI3i83dsJCboxdw==
X-Received: by 2002:a1c:3987:: with SMTP id g129mr20816495wma.86.1609172856720;
        Mon, 28 Dec 2020 08:27:36 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:36 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
Date:   Mon, 28 Dec 2020 16:28:32 +0000
Message-Id: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to respond to ipv6 namespace lookups when in suspend. This patch
adds the necessary changes to issue the appropriate firmware command on
suspend and resume to enter/exit firmware offloaded ns lookup.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  |  3 ++
 drivers/net/wireless/ath/wcn36xx/main.c |  4 ++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 55 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
 4 files changed, 65 insertions(+)

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
index af59638d696f..579bb7f4db9c 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1118,6 +1118,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		if (!vif_priv->sta_assoc)
 			goto out;
 		ret = wcn36xx_smd_arp_offload(wcn, vif, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_ipv6_ns_offload(wcn, vif, true);
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
@@ -1143,6 +1146,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 			goto out;
 
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
 		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
 out:
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4589c3d26027..b05f1e1f253a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2794,6 +2794,61 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
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
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 1458682ee715..380ea58b58ec 100644
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
2.29.2

