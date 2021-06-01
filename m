Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87A539761B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhFAPKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhFAPKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4FC061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so14716504wrs.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AUXLUY8VCW5F1ufkPQ70OsRXxkMZiVh0Lvonqi0Vbc=;
        b=BwcUQSFdDVZwiClzBVYknuT6WPbQvCQo+KrbJxctKjjsOM9aVaoQHibAUBkCg2lKgB
         oDkrhdHnd2bpUjkwQuGGJCZv66wY7rPElSrfwHNuO/oNNaUkCmtzU16VgHjhJttn2r5I
         fTUxSE1FUuJJeZNXTmb3vHZgnS3H/mzGYCLsOu0l2Bbc3mtYSF2+ZgBpH+V/uqW88WMX
         6ac0MUP+jJsABvo6ZikfczOUGVYLHngl+Yi4l4jUXKJvak2liTGZ95hVN0j37g2NXlCa
         T19ROiC5H6czk1ggamHE4kv77UrjM0jWaHTUT5840E+iX8AwxaNDiClCZl8EJeEtsLms
         pI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AUXLUY8VCW5F1ufkPQ70OsRXxkMZiVh0Lvonqi0Vbc=;
        b=L03xq8pJmwifncKnVVeh26TyGG91EYVkd3J8DK4qpgzTY0VhhVvaqyla7Oz6h/mnH5
         Uyy5fIrw8CDHomm716po1aeyxW4wFjcbF2bqXzacPg/WE1+mBIKZEOsZ6VvS2iX2c7Px
         5qgXIFeW9W7xkwKYvDKewfnrGr2iM+ws/wzpK47tZDCNUrByUkRudX2TuY0HqCvX9CaF
         Axwr68QDW1TD5S+zxh9Po7GL4YFDMnRIGMdBDCpvaMxHh0N1KSDweaTI3ZNTekKSdOgX
         dquN9bYXpi4gbADupm/FTTM1CFMvqtRXyP80bmNGr/X35507iZpwacdCaM3Y/mp+8eqS
         MpPw==
X-Gm-Message-State: AOAM530tdw2AES6R10647cx+iIpJxQaABGYihoPm9OMiyJZNjRUTgmVr
        1R5dcIsPpQsGJM3OrihiPkp7j55cLs33amSo
X-Google-Smtp-Source: ABdhPJxeFG5GqHYUuwYkCjAEf6a4tx/J03XIaZs1ThagoSxgs6PTOfx5bLiFrUPXUnjIBJD3N8o86w==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr28373260wrs.264.1622560102576;
        Tue, 01 Jun 2021 08:08:22 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 03/12] wcn36xx: Add ipv4 ARP offload support in suspend
Date:   Tue,  1 Jun 2021 16:09:52 +0100
Message-Id: <20210601151001.1450540-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

