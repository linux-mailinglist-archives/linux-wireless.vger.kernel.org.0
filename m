Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95556342185
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCSQOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhCSQN4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC1C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e9so9670647wrw.10
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoM6r0aQNFv6P86Jh2bARDY3W042U1bUTvbdF/AjcU4=;
        b=TZNWcdmYEv08+34PvPBQAY7RzSTbI+8VlO6tgYiQz/firqfWoC21Sr1exlbRXbSMC1
         PT5xvNUQA69BcdlOL1JicFDS+93OlwUn74W7uMf1l/LsQaOjpDfJe3rYvagvJLLiP34+
         JELybyx8i332BlJkWIXi2f3xhzFWEFnfWGd4LiTqzeQpG6+jS3YdhE/f05KGgUuEJrei
         AK0tLBW8atzVt5Q49A2Kb6dZ0XnWIfITlEceMKVD5BbiyqrlWR07EoeflUWdjj3l6Xoh
         ubSWr54dVqjqzqBx4iXLm1nGUKotsVz98pd+AsJtB0hX0oHnf+Cd6j6B1PoF9zDWPo85
         CIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoM6r0aQNFv6P86Jh2bARDY3W042U1bUTvbdF/AjcU4=;
        b=K3uNYW67fX3o39Mfp/5ngSR572BDAQ3c3eVEWIhHPZqtBhs3L9tXUZYUQt/UqV3Rn3
         18Z7WA9gyMxFL32Jq0qYhOm6AYFF+GPC9BqZPVBZ47EFdxOTY9oS4sAEv67gYOGOCNUT
         nkglUyXLTMnCDNDbetGbbANsMKAK7ow2CE2sheX83E21AGWS4pOY+jg1LLdHRQngWB1T
         HhzonSfoWszYM5gaMiGVjfIS/ZzTGj7bWDCeAR1+t/8LmPMhWgQ3y1mrCCeJkZsjE4hC
         J7U5HDF+QdPFQRGXBggiU2vxirWje++xwZevfIMek0SGmb1OrYHKOr2+nhfB2+Ws6bMf
         xLWQ==
X-Gm-Message-State: AOAM532eOJqBikF0OQ/hS+dnc05VKC5DweZxCkkGj3nZCrdT+p11kiuc
        rnT0qMeePonMp1Oc4/M1KmVtgg==
X-Google-Smtp-Source: ABdhPJzYrZmf9RW3hmU3OaNum/J6g9xKjMwz91I8pwFgXBgjpbIJIe59c3qjU8kvIxM39cgfZY6GKA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr5360069wru.264.1616170434676;
        Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 03/12] wcn36xx: Add ipv4 ARP offload support in suspend
Date:   Fri, 19 Mar 2021 16:15:11 +0000
Message-Id: <20210319161520.3590510-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ARP offload support. Firmware is capable of responding to ARP requests
for a single ipv4 address only.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h  | 10 +++----
 drivers/net/wireless/ath/wcn36xx/main.c |  5 +++-
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  4 +++
 4 files changed, 51 insertions(+), 6 deletions(-)

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
index c0c1ea18864f..f95103706100 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1117,11 +1117,13 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		vif_priv = wcn36xx_vif_to_priv(vif);
 		if (!vif_priv->sta_assoc)
 			goto out;
+		ret = wcn36xx_smd_arp_offload(wcn, vif, true);
+		if (ret)
+			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
 	}
 out:
 	mutex_unlock(&wcn->conf_mutex);
-
 	return ret;
 }
 
@@ -1142,6 +1144,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 			goto out;
 
 		wcn36xx_smd_set_power_params(wcn, false);
+		wcn36xx_smd_arp_offload(wcn, vif, false);
 	}
 out:
 	mutex_unlock(&wcn->conf_mutex);
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

