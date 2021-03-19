Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE2C34218B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCSQO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhCSQN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3AC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so9662070wro.7
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeymHFEw3VCwGiX+9p4pd8aUCryOvSHH6lc3lNOgB64=;
        b=BWmbhp4adjkCyZpeHNblIR9ZFApQJaR2+I03rojYwzpA62a+HMhwHi8xXJmcMPpXB1
         7muUNz0pWzV/Spg/sojKKtdEHwwieOU+Ha5vAqvFJ+UOMyplmbFz61GC9k88y6Ho92b6
         XlOc6JDNcOUegnp7RKvID+MZ4DblAdAbbw50ETIynE3aCmSwNnivLw7AxINhe6MusjZZ
         14POzNurt00BUBAYvt5MIz20ToXDu1JcQ6xnjrlhJL+kUWui3mogHimWJB4tJhkDcxvr
         Htf8RTfXfOAWziHs1okVWWWw/boNTKrJhZtXbfc3pNK33ofMeD3haoDAi+xsb8CdQG/d
         759g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeymHFEw3VCwGiX+9p4pd8aUCryOvSHH6lc3lNOgB64=;
        b=PWmbWp3Ixw2HKplU7irvaLT/6EisNgJQAYlsqR07di8RSFeSyi3Ooddep+9eXGrDze
         1T9apye8LrgjZEvy4BY6T/IAM5ueEHqpwCpTp9fVuDWaIB/LQfapqN2hJ68YWoX7uDwb
         5BKh3LqlUZMg8lostnYdvsTB9w/5Ay0evrTzmSN9hcN+E/jBr/BAcqQs+V7GysRiGbJu
         xavcWr6aHY+dTRVqZYSclBb1+ozG+aAZGJsraWuXLHxkO6f90hiSQbCH8fTcb7+MHhTX
         S6EKh72Oi2LEPcY77occye+iSE7cjAB+KoSocMOrT1m4UlVAHrKRFY0T8qkQyIz8/9HG
         odJQ==
X-Gm-Message-State: AOAM530FJK1bOwW/72zWupMpU5pEtnL/aWPd9ByBD/2lhEIPb7VMOcO7
        LUEV+f/7sc2KO5WQn0F7kpJinw==
X-Google-Smtp-Source: ABdhPJw1Y5pcpkhrcanIGSjAr4vDKqGGusURXx33wyEnCXKoHByyeV+wT+egwabSQtOS8APykGBO9w==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr5414790wrr.12.1616170437724;
        Fri, 19 Mar 2021 09:13:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v3 06/12] wcn36xx: Add ipv6 namespace offload in suspend
Date:   Fri, 19 Mar 2021 16:15:14 +0000
Message-Id: <20210319161520.3590510-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to respond to ipv6 namespace lookups when in suspend. This patch
adds the necessary changes to issue the appropriate firmware command on
suspend and resume to enter/exit firmware offloaded ns lookup.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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

