Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506422E67AD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633529AbgL1Q2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633524AbgL1Q2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84816C061798
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so11732681wrm.11
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltohQzViTXov8BpVEXom7/dF0P1+ZXvRdo3+msQAQjk=;
        b=TNcq2zx3qOV1ztzjb/fZgvXmN9Yay15r1eWasNdPXf0Gsz2NbNj+WiXlN+qKpkvz4A
         gyFIz/uM1mjGlhXkEdL5aa2GPbY2gC2ybctZxYxVXj7LMVz7EPvDPJVlOb8N6sDjXSB8
         HwAcKjNnqj3A4QL9woyMPy3rS4266mz9Z5ADD01rfvg6yBcANGiqDpqrH9XlGO2dxVGj
         ia/KG4akeqWRm9Th43EqVJ/Myrk0+QL30isyyojsWEEt7uwctobz8KePxH+9IkjF5g3u
         HSoGTCI4oDtSZfP1j3wu0i/32QXRURDN4s51n1f/h4PRg/8yulovLR96aeVLY6nneSlg
         pVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltohQzViTXov8BpVEXom7/dF0P1+ZXvRdo3+msQAQjk=;
        b=C0QWL+4faV2UaMuBOuTEYWw6ioPtINC4lXHC5E7vtV4MAHv20hogk/NkcaWQMqKm/N
         qA9VPXSLXBRWZPtmMcr9MCb62C5rA61FbwlhEsJ6isMhSy2tnIORJGCmEtK+HpWT4dkw
         zAAllXHAUSEUHzrGxUkjdRWo+xOnh2ZFZe1okYGUFv8XdhTj43bD6QVFVjk1gfIdImCh
         WOS26uZ032g+WqK6O4I2ah+oVWf6x7B+nXPqi3CwpbmWUpaW8vUZ5n+MIMWPatnD4ZlO
         cupuV2GLEKuyUe1LFKa11tC16teNtQ9C5UbbuenrusWDsIFNSmnd5P0QOiNvEAqGs2Jq
         sNFw==
X-Gm-Message-State: AOAM530KN8l7PjvmkYdTITsRanMzMEOG4MHLqB3LBaqOX0hy6nG6hRhy
        qlRCkYhcb037rsU7dqYJnzkkZA==
X-Google-Smtp-Source: ABdhPJwQ23aLQC7lqtMKSVQL3gyH7EvlQFy6vLb7SyjyIW7MzaJDLR3X+LDAi4ormhDeaUKrOIaQhQ==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr50826921wru.398.1609172853329;
        Mon, 28 Dec 2020 08:27:33 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:32 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 03/13] wcn36xx: Add ipv4 ARP offload support in suspend
Date:   Mon, 28 Dec 2020 16:28:29 +0000
Message-Id: <20201228162839.369156-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds ARP offload support. Firmware is capable of responding to
ARP requests for a single ipv4 address only.

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
index b90664bdf6ee..c463ec7c1568 100644
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
index 5445277dd8de..4589c3d26027 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2757,6 +2757,43 @@ int wcn36xx_smd_set_mc_list(struct wcn36xx *wcn,
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
@@ -2805,6 +2842,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_8023_MULTICAST_LIST_RSP:
 	case WCN36XX_HAL_START_SCAN_OFFLOAD_RSP:
 	case WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP:
+	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index b1d8083d9d9d..1458682ee715 100644
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
2.29.2

