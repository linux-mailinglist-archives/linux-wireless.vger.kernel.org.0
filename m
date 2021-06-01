Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836D39761D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhFAPKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhFAPKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036BC061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l2so7248295wrw.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=BMjxWAwuV2FvRB2/Aqc0rzWATZKNR+ROSIqpqLzf52Uh+tQ1wV/HLTqSSmIWzIMYQf
         /FpTAb7bChMf1jyWDjrufSLqXfwcH/d+R2J+qhiA5U7j5XB8me+0R3e8UZrHQnEc9h3Q
         WuCCjZbzUOlfkoMogwzg9umhhR297zPevOX8ptllx7/ARjgawLTIAurFcbkTWMkjSDUY
         xmkGifU99B0KZAGSWUhptALTbqXkKQAjkcFiK+A6xOi48nbZaPUbmYGMZ948AefIqkc7
         +uQ/LVObDRZoG9Ioo/sagjjsb7wpw+BaazT49CsLadxpjdQt13nLnQfDbvoo5hJpRQss
         +HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=oN6u+uSftZfch1+5v4QzKUnjgPpi35y0Rf9PgawaO91G1erRMkn8XScImHrAbS3Pvc
         SfKFpAIulP95qkDijvPNOq0J4EcH9sV9RfyGZrabe9Y2znjRJ0IYZmjQ7IzGyPza3YeN
         Ph1DA5MWvWQh5ER7FWuwx8cjTKe/oIA8Cr1h8MJXI1JP/dCIRkViYAhe9lYtMrfDw+3n
         0vCTZy2RupqETqxD64b2LFu9UzXZNO3MazJflpCQpiULdHZOWLVgwlLeI5ciHf6sXX+U
         VCvv+nllmQWqZjxGWp/RGNpnBaIGiEw1NiTYnmLuWkbm30ycVEvJdrIk500OZW9eHXy7
         hFNA==
X-Gm-Message-State: AOAM532pSssjYqDgYP9kJO++0/LaCWbB5U6R3rflLJ9zbeuLEiwSdZWE
        VojWTboH3zXCvMusZIkM2Xm6uW2U6z6cigJZ
X-Google-Smtp-Source: ABdhPJz2MY7ytHTy8lIFpnyrxyn/T+zLAA/9tKVWz4PIWGVpKLwX+V0KrVW6lw0xv1wwrGp4L0XOhA==
X-Received: by 2002:adf:f309:: with SMTP id i9mr29114688wro.307.1622560105161;
        Tue, 01 Jun 2021 08:08:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 05/12] wcn36xx: Add ipv6 address tracking
Date:   Tue,  1 Jun 2021 16:09:54 +0100
Message-Id: <20210601151001.1450540-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Taking code from iwlwifi this commit adds a standard callback for
ipv6_addr_change().

This callback allows wcn36xx to know the set of ipv6 addresses. Something
we need to know in order to get wowlan working with ipv6.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/hal.h     |  1 +
 drivers/net/wireless/ath/wcn36xx/main.c    | 32 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  8 ++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index b56c8292fa62..90333daed845 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3466,6 +3466,7 @@ struct wcn36xx_hal_rem_bcn_filter_req {
 #define WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE             0x2
 #define WCN36XX_HAL_OFFLOAD_ARP_AND_BCAST_FILTER_ENABLE	\
 	(WCN36XX_HAL_OFFLOAD_ENABLE | WCN36XX_HAL_OFFLOAD_BCAST_FILTER_ENABLE)
+#define WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX		0x02
 
 struct wcn36xx_hal_ns_offload_params {
 	u8 src_ipv6_addr[WCN36XX_HAL_IPV6_ADDR_LEN];
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 9731fcbe2e7f..240ecdd52f81 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -25,6 +25,7 @@
 #include <linux/rpmsg.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/soc/qcom/wcnss_ctrl.h>
+#include <net/ipv6.h>
 #include "wcn36xx.h"
 #include "testmode.h"
 
@@ -1208,6 +1209,34 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static void wcn36xx_ipv6_addr_change(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct inet6_dev *idev)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct inet6_ifaddr *ifa;
+	int idx = 0;
+
+	memset(vif_priv->tentative_addrs, 0, sizeof(vif_priv->tentative_addrs));
+
+	read_lock_bh(&idev->lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		vif_priv->target_ipv6_addrs[idx] = ifa->addr;
+		if (ifa->flags & IFA_F_TENTATIVE)
+			__set_bit(idx, vif_priv->tentative_addrs);
+		idx++;
+		if (idx >= WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX)
+			break;
+		wcn36xx_dbg(WCN36XX_DBG_MAC, "%pI6 %s\n", &ifa->addr,
+			    (ifa->flags & IFA_F_TENTATIVE) ? "tentative" : NULL);
+	}
+	read_unlock_bh(&idev->lock);
+
+	vif_priv->num_target_ipv6_addrs = idx;
+}
+#endif
+
 static const struct ieee80211_ops wcn36xx_ops = {
 	.start			= wcn36xx_start,
 	.stop			= wcn36xx_stop,
@@ -1231,6 +1260,9 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.sta_add		= wcn36xx_sta_add,
 	.sta_remove		= wcn36xx_sta_remove,
 	.ampdu_action		= wcn36xx_ampdu_action,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change	= wcn36xx_ipv6_addr_change,
+#endif
 
 	CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
 };
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 71fa9992b118..5a5114660b18 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -18,6 +18,7 @@
 #define _WCN36XX_H_
 
 #include <linux/completion.h>
+#include <linux/in6.h>
 #include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <net/mac80211.h>
@@ -136,6 +137,13 @@ struct wcn36xx_vif {
 	u8 self_dpu_desc_index;
 	u8 self_ucast_dpu_sign;
 
+#if IS_ENABLED(CONFIG_IPV6)
+	/* IPv6 addresses for WoWLAN */
+	struct in6_addr target_ipv6_addrs[WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX];
+	unsigned long tentative_addrs[BITS_TO_LONGS(WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX)];
+	int num_target_ipv6_addrs;
+#endif
+
 	struct list_head sta_list;
 };
 
-- 
2.30.1

