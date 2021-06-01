Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0739761E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhFAPKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhFAPKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC69C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so2150885wmq.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RACFcUJtiWm8MN8W1vtslkiqbwIBEQgKrtcO2mZsrAw=;
        b=AGgG0dQM96lT7J0dEkowXD307tZoS+094SJYDKI/TzLc5/Q069FbiA6HRnOFspT0ez
         Bc5wjShkKdYuGHGIrIknaeaevCA5ASWmeD5AZX8H4Auh/hQQDDh3o7EKt1q14iIIDFf/
         q4LfdQjcMTIrrmHZpMhmYbA/trluet0ZrDdU2wmu3le3dmqtWSV8KATmmLqTLUgBDBYE
         vVNGDZipgwtfXUmGMX5oXQ+i09z/sMcgNpU8EB/NddDNtKdVrPHdMIqvPB3/uj9+up4j
         JbGmb8ntS1IV8VG0daFYiSUbqX4wBUgYxGu3xrTVV3hMP0ptGahlfPo/ZLZ3tA9SDCYb
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RACFcUJtiWm8MN8W1vtslkiqbwIBEQgKrtcO2mZsrAw=;
        b=pn1n9neicdBlqRUcRKNGAheg0Mc750JIGVDA5FQbRgt9jJ1MJhakNrxX93Z0fet0PX
         nhqUhNdbPNkgtQEwEL50Nx+RvHOiE/WWOInayGkYawAwu9Zm+YQY80AmEQ2zbxPJ96L/
         fXTw9HL0Gphy+16cYayVKE1k4BOApEzorCs0D4BwV6LAZ8gvfv/8kDcykOgf/ByVT/6G
         PFWFqh6+0PbkmKXviyg0yCQBDxHQGFvH3aBtVSBsgbUd1O8yZJcvrabR99By5ZDnX9np
         007517UGVCcINhlBWr49i2Ng5mSHUfTzs72UemXiC1zIREd0w5heD7MV6UtaEHm5uUQB
         4vWA==
X-Gm-Message-State: AOAM53387FofvkgXHqrnGxCUiRpkSfZb4eQqBOqmGFw8cx12hrGdQXez
        yGUMviE8Wr34gPw21N5SrLSG6g==
X-Google-Smtp-Source: ABdhPJwbIyaKP7qE310FrUxYzSxkyA71OKDNlP9xtXINOH+B4BOgBBDJ0NEW5EIc+mpc0AvdLHesRw==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr26810852wmj.104.1622560107075;
        Tue, 01 Jun 2021 08:08:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v5 06/12] wcn36xx: Add ipv6 namespace offload in suspend
Date:   Tue,  1 Jun 2021 16:09:55 +0100
Message-Id: <20210601151001.1450540-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

