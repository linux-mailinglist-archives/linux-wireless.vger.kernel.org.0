Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8B342187
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhCSQO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSQN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EFC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so9671183wrs.9
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRRlji5EKWlYATK4Q/JjFfGsjamjpBflBNA00LfXmj0=;
        b=d3SeIC8wJZTagoTB0RFGAK7HDK09lcNW1Bh7Zfo400OX69PoRt2glsIsnPMPtRVCmk
         M/mrAJEMJFBmvyWlElPxUr77ACGpSyib91ayQuLmosg3mXNOAoCIjAcoa20sxZkIF0bh
         cuuCzmLjYBci4wojx7p0Xt5qiBw/ATN2HjM7BNMNCPA89hNQ+1whHHGJHLJ3tU4NHc3x
         JjEekT/8LosKPYt8+NeZ+72ZpXcNqZK9a8YyBtTY2zA106dADTwzW4us/sB4dM6B4XYW
         ljpOUVWQQEfji2xCbgMUCXL7WZgJWu4pq8vyG6H7o/WMK7JAXTrzEAliwJha7OV6E9JM
         y+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRRlji5EKWlYATK4Q/JjFfGsjamjpBflBNA00LfXmj0=;
        b=eLOpwaKVitrAVuAxmtWQMP+HPAyO4i9gDDmN6WvmDzTqI8z5RUv8leOKq6CF5xzjVc
         j1hs+RgLqvOVrpYfeeQXWR664v0STpGxE4k6UewqcTrTlovvbTAFT2pOeAl4ZuARQqvr
         uWEVTZplJqliXDtDGeGi8LLuQ+eD5TtJyESO51d1+BMG8Lp23orRj7bmqyNAuHkLgvDY
         kZxGRC0iSr2YXJcWgehNwJOwiVvQTtkc3ptOXavntR41Yhgzmu0+3wgYBS7XQF+fk/U7
         xFKjqezYVp3LXTtc0aYgKRut2HA5CGXST8ffPsZPuK7KKatFXc3T3fIbd5r5HhZWPqCd
         ybpg==
X-Gm-Message-State: AOAM531gwMucoq3B6Wu+UKZzWXMy1JCzfk5n5Om02S2/SzweiPML4zUT
        tAdLmwmkJP8Sfxi0X9WY8/FdbQ==
X-Google-Smtp-Source: ABdhPJw3haDdoRXL01IQpzMM/0KEbo8fGh+SzUyHnjJNA+k6vjH9dt8/XbMVAeCbrxqnWTFFHlBuYg==
X-Received: by 2002:adf:ab52:: with SMTP id r18mr5276285wrc.65.1616170436678;
        Fri, 19 Mar 2021 09:13:56 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 05/12] wcn36xx: Add ipv6 address tracking
Date:   Fri, 19 Mar 2021 16:15:13 +0000
Message-Id: <20210319161520.3590510-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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
index 029c9952b4fb..93eff6563187 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -25,6 +25,7 @@
 #include <linux/rpmsg.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/soc/qcom/wcnss_ctrl.h>
+#include <net/ipv6.h>
 #include "wcn36xx.h"
 #include "testmode.h"
 
@@ -1216,6 +1217,34 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+void wcn36xx_ipv6_addr_change(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct inet6_dev *idev)
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
@@ -1239,6 +1268,9 @@ static const struct ieee80211_ops wcn36xx_ops = {
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

