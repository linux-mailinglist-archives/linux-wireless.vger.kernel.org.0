Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A433B234
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCOMIl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCOMIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEBC061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so5556790wrc.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qutEc60H9wCR07iM9g6HgTz+6eNxuy1VbVCy8wFcL8=;
        b=lVWFkG4CtrWtruhRHf33z0oTGi0K1eL2DuynyWjiDZkzfuZfd9q7fxwU+qk7hGkSIu
         8zOvcenVXhb8fPpITB/iMmJMbsydw9R5n7/Re4sS0IfDYxYej3DnS79bTKqzvFa0d0HF
         dCzPOhwtXETIltpRCn6tEhN9Z5f950nBUrbU87k78WrkvgalHjRzSBBKqYssUhLkBeQu
         nUZXANVEYuTtCZglAumrx8M8BQWDNrmT8vHbIitAhNnjGLDW0kK88xNF0P3FusB0sXh+
         shaPdFfc+hkBhw9b9B6ZrrhXOS1tTilnL28vCtxSdr3OeQH/6y29kkbXOmc6cJ3jPUSg
         nEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qutEc60H9wCR07iM9g6HgTz+6eNxuy1VbVCy8wFcL8=;
        b=MbuD0aKWdTm8ihsWJfeIQXrM85cFOpxr+b++tgUHnzquEWb1Xni9Z2/h6C6S3zsRVc
         4MsCrOv0mYeUVz5m8c9mQqJk5ygfk/XwAirCERFWPU9kQYZJsGbB87oz7M8aLDKwOruA
         RZ6plzZbGLbwr83JQEwqsAED3vnoVSG2GLC6dQ2o4HNupEYxeFH+HQZxmZVZM1wDqFo6
         Rpjw55OqS8nFXmqR32uhw5WZpDqhiq2fY2GI2UVuPjC4EugGCDzw2tdAPqW510wyQ57W
         MbQYFOL8qUQkj3KVnOftrIVJXswYEIQ2nO6ZWUZM9GUxdXvfBsauL5mWU6XUTZa4lUCJ
         xM3w==
X-Gm-Message-State: AOAM533/jZj6OzGLkddlsouxePf+9LT2K7IaHkKvZRdgl2hd+WLOb8Oc
        +A4LIe2zcwvj//grp4dox+oSLQ==
X-Google-Smtp-Source: ABdhPJyPS2giFp0pNoi9tHEjTgLYfUe2kVmSttPYMZpeeVrFm4rVHtNzz0bCCELtecdobxdNVy7d4Q==
X-Received: by 2002:adf:a1d8:: with SMTP id v24mr26212887wrv.378.1615810094932;
        Mon, 15 Mar 2021 05:08:14 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 06/12] wcn36xx: Add ipv6 namespace offload in suspend
Date:   Mon, 15 Mar 2021 12:09:31 +0000
Message-Id: <20210315120937.2512341-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
index 93eff6563187..36cf771d8a20 100644
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
index 478e363610e1..c3095d800c32 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2793,6 +2793,61 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

