Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3939C4C5
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFEBM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:58 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38813 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhFEBM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:58 -0400
Received: by mail-wr1-f52.google.com with SMTP id c9so2258361wrt.5
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=lUgZ2Vpj2Brda+FbmjtFIEK/xDixQFlAhPTT+q79g6THgG9XmVW2JvzXvkUAjpWhjV
         8W7eyaN6HEt4dtnlnrLUL8vJlXMtjRFjRakC3TKCKcZjK5guSNSswUtOsDPWHPwd69dc
         3sG+tARr6tN8MIsscUStJes5VOawpg0OGClJqU5W4TSwyHsaZdryF6f3KS74rqcR3aPJ
         /vIwebWqstWuYFRCsp3PXbqjGf3jFLLvSpvxWwA4t/xrD66QNUycNMr1cOtbKakRGutp
         ilJ9nQ+j5ImIWfZ832+ns3RBenKi5kX8tYew0yaDAodHM6cl+qRy3QxRlDdWmfBH0XEs
         YIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+UYnqbXmGpOtA5im0JIGu1QFL9pMS49kWTkIpsAbWs=;
        b=gqJfd8gwrNccR7mL0IdaTplO8y/5w1j40wT0KotlfcFpMfc8AW6O1AjsD4jL/G3ern
         wUcAHLIKfQgMVtRIy3M+CbxQtXKGD//vdw1ftD+ELzFE4/L39eAItwL9YCImhB/uh9+n
         8iu7fhK4qEYd3BezpmBayZjuQiWEuvmVYuRInMTyFII8Q0QjrQrhnGuxmmkgbJeujYp6
         w65gz+Ilg37+Wtq4mO5AN5UiW86hAp5ckhDlKQ2/gbaraVoz3wWnZ/KNyniva3o8qQP/
         HV80EKvBCeALlSBtCMxZ7h8QK556pqOZbLkXkKVezpztz8S0x+CdEVfVoeJNSO0cmzlc
         Gneg==
X-Gm-Message-State: AOAM533zbGjrhJVRR9N0MRkKj+fcgINAW8KC4ZB8qJ7DZRjfNsuW9d2g
        0nQPFzzHpBkhSlCUsLQYFHkCCA==
X-Google-Smtp-Source: ABdhPJxAVFEBfMaWbclRmLcEd1vDaijbWt/QCIaaxyc5O142yT3RDHVZvJZvstMVtozLHx8ldK9jvw==
X-Received: by 2002:a5d:58c8:: with SMTP id o8mr6192780wrf.299.1622855401481;
        Fri, 04 Jun 2021 18:10:01 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 05/12] wcn36xx: Add ipv6 address tracking
Date:   Sat,  5 Jun 2021 02:11:33 +0100
Message-Id: <20210605011140.2004643-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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

