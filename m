Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E407396B91
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhFACtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFACtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B6C061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f17so5759167wmf.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=FmNnnm8lmFjeLCGy1WiL2iD7uc1zwahc9GphBEZf4CtBa+2XLm9uF3QJ6Y58PupRUX
         cBI8Krv5BRJ1EVRnwJRv1tNS0W2UOSjUlnr9DK2xswpFgRwvl7XXedgSUTpa42T907zZ
         5vMjv59Xz6Z4HtmDosWdSSUHBx5ecCKzMALDviJIT/8tRuaDaBiCt7s4fma958cRJCwF
         VwtmcnewEFEqeS/MJ6wQNyVLSea9VrojUxE7oTu3UcgQqw6iJ72A592TPeCZKHyMlqRM
         QeVygx6kVWL3t0cc+XETVaniea+94iCeJeyWUixhAn21/GpOFDUOHpmLyrODTGriFQHP
         38ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=WQfUUltjLalkMC6G0hJ4ZwcgJ0n4t37yslg/NO5gVIiikBJBbX+W9WoeR8BYZT50wV
         QzzmIJSTPvuxQKLV1GkvdtWIpwNrpWAIazxmi81xnvOlTsvi6KEReSgT+QXQa7+W8KML
         eLkW3vUcUUPAlTenpuyojqJpVLDSdTDo/oN5xUC1WsBpmhPvgqrlzRtQG54+Vr7OQvaX
         YDCPHc0kicnHps/sqJtUNnt2L9xJFKuxqzKt2YbqQAIqmy93LdoaiJLa766Plw77vV5M
         Tj2MA0UN0WVI2ETri0uM4MSHohqi/FjyOEFh7IXsmt6dGrk8UiYLJpGCVELdlzDXH6QV
         z1Rw==
X-Gm-Message-State: AOAM531R9Kj8YIdFG9SA2Cj8G0IhIJaBg4pVQ51bBgYV/V6V+7QOKxmE
        YLfZufZD4yBolwUa6jQf8pNj7Q==
X-Google-Smtp-Source: ABdhPJyoKYZmbrpwPiToaIzSPbnzBDTt4W5jlTD64Q/bRTV8L85bGuYtjOZnzTHCZ7J6MTVd3DXSLQ==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr24117006wml.168.1622515662356;
        Mon, 31 May 2021 19:47:42 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 05/12] wcn36xx: Add ipv6 address tracking
Date:   Tue,  1 Jun 2021 03:49:13 +0100
Message-Id: <20210601024920.1424144-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
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

