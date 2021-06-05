Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950C739C4BF
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFEBMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFEBMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C2C061766
        for <linux-wireless@vger.kernel.org>; Fri,  4 Jun 2021 18:10:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t16-20020a05600c1990b02901a0d45ff03aso5317833wmq.2
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AUXLUY8VCW5F1ufkPQ70OsRXxkMZiVh0Lvonqi0Vbc=;
        b=jNWI1SB8NOYZ/KxhewKOxtAg75E+RbTDUlZnXKWs6H3/LGdUWe7uwNZo4IO51KVjPe
         HLrl7fDqODipp8jKrgoNcPCuW3Ks6qFwtQT2Fa4gHyokNIjTDoejLVSQhY2T1i3qDr3z
         baTgiSsAwF0zICXsgZuh9ZRdeMeguDb4c1t+KDIPgELmzJKDHRwp7KwdNVmyKajHChu6
         VgDJe4p87kpD6jcqTid2suoab6nxjb6m/lyfWkfRAaIuKwaouJWHdGm4gq8Y7XVgQbtZ
         2UZCu8rkpt7DV0isI4dxpaF2owlJ49cd9lEAj1oSZz3FhsFGrXsGdiZR+crZmLUFreUG
         UCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AUXLUY8VCW5F1ufkPQ70OsRXxkMZiVh0Lvonqi0Vbc=;
        b=NI8Lkc++t2rT1pQElC40lGpesC0AOeWMtZivRjxOXr0+NP1Xp2L4PRUbavZJqFCRu3
         g49568Ly6VoEtr7sDD2VuW2A9JhrnxFTnJV6Jf6dq6jyA1S+kHxQovN4lr9Qrdx0vNFM
         1iRc27KV86KshDxmcc+NjUvozAPdjX7VQULE0IIwPzCfNrb0d1qpXjCGyKYcpw1Ts2+m
         yUbq69gIymr7CmwZEii5rW3rj7OAFEm7QQVjzbwnuTfiviKDH/NYkH/iMCKEQzXyXID6
         Ih6oZ60vZv8W3dvXtwSolIhupkD0FvlIEA+K5zCK1VWHQUTAsynJb6ZbznbIPGUN9QOB
         i2Og==
X-Gm-Message-State: AOAM533P5sv29iJ7udDv1kKORYNTXpUjBnPRYN2xYiKIjqcX7N14CrGK
        BZTiP7dQ6Uyg2tHGuD1Gk2cv6YKMVgQemHyI
X-Google-Smtp-Source: ABdhPJwXNaK82/f7e1tePZq/fwtwKeUsz+pdIqN8HYzjZis8xzSOqooyTzOXAce20WET4UXS/X9fhA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr219831wmg.116.1622855399582;
        Fri, 04 Jun 2021 18:09:59 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:09:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 03/12] wcn36xx: Add ipv4 ARP offload support in suspend
Date:   Sat,  5 Jun 2021 02:11:31 +0100
Message-Id: <20210605011140.2004643-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ARP offload support. Firmware is capable of responding to ARP requests
for a single ipv4 address only.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  | 10 +++----
 drivers/net/wireless/ath/wcn36xx/main.c | 13 +++++++--
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  4 +++
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 65ef893f2736..b56c8292fa62 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3465,7 +3465,7 @@ struct wcn36xx_hal_rem_bcn_filter_req {
 #define WCN36XX_HAL_OFFLOAD_ENABLE                          1
 #define WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE             0x2
 #define WCN36XX_HAL_OFFLOAD_ARP_AND_BCAST_FILTER_ENABLE	\
-	(HAL_OFFLOAD_ENABLE|HAL_OFFLOAD_BCAST_FILTER_ENABLE)
+	(WCN36XX_HAL_OFFLOAD_ENABLE | WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE)
 
 struct wcn36xx_hal_ns_offload_params {
 	u8 src_ipv6_addr[WCN36XX_HAL_IPV6_ADDR_LEN];
@@ -3487,10 +3487,10 @@ struct wcn36xx_hal_ns_offload_params {
 	/* slot index for this offload */
 	u32 slot_index;
 	u8 bss_index;
-};
+} __packed;
 
 struct wcn36xx_hal_host_offload_req {
-	u8 offload_Type;
+	u8 offload_type;
 
 	/* enable or disable */
 	u8 enable;
@@ -3499,13 +3499,13 @@ struct wcn36xx_hal_host_offload_req {
 		u8 host_ipv4_addr[4];
 		u8 host_ipv6_addr[WCN36XX_HAL_IPV6_ADDR_LEN];
 	} u;
-};
+} __packed;
 
 struct wcn36xx_hal_host_offload_req_msg {
 	struct wcn36xx_hal_msg_header header;
 	struct wcn36xx_hal_host_offload_req host_offload_params;
 	struct wcn36xx_hal_ns_offload_params ns_offload_params;
-};
+} __packed;
 
 /* Packet Types. */
 #define WCN36XX_HAL_KEEP_ALIVE_NULL_PKT              1
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 9a97a288a96f..0da123660fa1 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1112,11 +1112,16 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 
 	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
+
 	vif = wcn36xx_get_first_assoc_vif(wcn);
-	if (vif)
+	if (vif) {
+		ret = wcn36xx_smd_arp_offload(wcn, vif, true);
+		if (ret)
+			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
+	}
+out:
 	mutex_unlock(&wcn->conf_mutex);
-
 	return ret;
 }
 
@@ -1130,8 +1135,10 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_assoc_vif(wcn);
-	if (vif)
+	if (vif) {
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_arp_offload(wcn, vif, false);
+	}
 	mutex_unlock(&wcn->conf_mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index d0c3a1557e8d..478e363610e1 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2756,6 +2756,43 @@ int wcn36xx_smd_set_mc_list(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_host_offload_req_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_OFFLOAD_REQ);
+	msg_body.host_offload_params.offload_type =
+		WCN36XX_HAL_IPV4_ARP_REPLY_OFFLOAD;
+	if (enable) {
+		msg_body.host_offload_params.enable =
+			WCN36XX_HAL_OFFLOAD_ARP_AND_BCAST_FILTER_ENABLE;
+		memcpy(&msg_body.host_offload_params.u,
+		       &vif->bss_conf.arp_addr_list[0], sizeof(__be32));
+	}
+	msg_body.ns_offload_params.bss_index = vif_priv->bss_index;
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
@@ -2804,6 +2841,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_8023_MULTICAST_LIST_RSP:
 	case WCN36XX_HAL_START_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
+	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 462860572e1f..6492a628ea6a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -146,4 +146,8 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 int wcn36xx_smd_set_mc_list(struct wcn36xx *wcn,
 			    struct ieee80211_vif *vif,
 			    struct wcn36xx_hal_rcv_flt_mc_addr_list_type *fp);
+
+int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			    bool enable);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

