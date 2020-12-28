Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35622E67CB
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633582AbgL1Q2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbgL1Q2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B8C06179A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k10so10718584wmi.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDdF3uI5gFdqmwiYK0tEjCdYV2ecZWcbZfnAQ4bZ1CA=;
        b=BoOU0ANX8yCDMe4XiOnt9LuvsQDVlam4Q/nxfCF1k7+Kk9LRsqNdl7KfphAdrXbyxO
         mdcbKdYjgPSSKwP7YjAdulk6A6l0YU3xHTuEnVor96EHNQhq7WtJholEDiR7dy6Lx+zW
         1/AIZHqITSqC0H/CGq77GCnY5m3BG0MC8C4wDJq+dWOc9Uk/ansp+rYXm8HDag76Xzvt
         n0QcJZje5RY6H69oNCZsMYjYwoNMM0VA6gQCwVdSM6+sClQpb/hB2hTCBvUETmpPIYFh
         fG1Z+mVomRO6KBnR77XWEMIj7iMmiYRwT8Bq/RiOhWNfp7vgXMmpGSWRJJLWlG0MTBDU
         tqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDdF3uI5gFdqmwiYK0tEjCdYV2ecZWcbZfnAQ4bZ1CA=;
        b=ReCOoa9JrytgmY9ckDI82sn8sBNmn1w40+A/3lgPFAECXjd7t9XbZr5hFb4OCeV88x
         pLPjrAgo4UZutNoTxBdOGlLECzIS/1wOCnKz86H2o04nQ6imgpFrdPGwHeheii5lExqX
         NJUTP5jDcVmawDNeUN3zD/nACEz0e6iBzhPl2cGqhuRBuc3cHLcx/tpv4ziZncqD1CrZ
         ZlCAokbOZm13hZ10YQJhuxYqvu1o43b1Q7527xcqcDsmz0O3E9zU8r4OsvGo5mUIYxtg
         htIqoms1iLgnM6JeSwQ++Zfi94kRyN56ifrBhST1miOYL8nLuX8tDin8RwFdf6lg1DSx
         RTJg==
X-Gm-Message-State: AOAM532KX4rp8J6ku2BguU9VQvNtYmwY2Ji/aYjowRiBhaHO9kSoMSn5
        pilUB+Rpv93DLy9B0hK2o40VmcmPThhErIR9
X-Google-Smtp-Source: ABdhPJw5D5Ej7JhrQi629e0UT7yMjRK02J86ESFQviNYbbqTXCkmGxSS7RRNXq3VplFfyHc/VBzGHA==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr21235738wmh.29.1609172855527;
        Mon, 28 Dec 2020 08:27:35 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:34 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 05/13] wcn36xx: Add ipv6 address tracking
Date:   Mon, 28 Dec 2020 16:28:31 +0000
Message-Id: <20201228162839.369156-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
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
index 745512a6ad83..af59638d696f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -25,6 +25,7 @@
 #include <linux/rpmsg.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/soc/qcom/wcnss_ctrl.h>
+#include <net/ipv6.h>
 #include "wcn36xx.h"
 #include "testmode.h"
 
@@ -1215,6 +1216,34 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
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
@@ -1238,6 +1267,9 @@ static const struct ieee80211_ops wcn36xx_ops = {
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
2.29.2

