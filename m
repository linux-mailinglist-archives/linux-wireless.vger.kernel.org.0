Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3339C4C7
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFEBNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:13:04 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:45876 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhFEBND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:13:03 -0400
Received: by mail-wm1-f49.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so2234727wmg.4
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db0vrZDo7WsFlYNOBTLREku88rzLX5quvNYh++ykS44=;
        b=I1ThK3qbyRFc/NyNPS+zUxjP4cKXawg9XklKB3egJx9UYINBE8ypU4zDWmrazw7toe
         lI7Ktk3sYa1hx1aHhndNFbKzW19PeG7F+nZHeAUzlBevI2XzbUYye2N8W0LEDJ7Ls/2w
         l1ybYBypXsyJ0FHxKRCjxtqpMCYyAahPpwkRNDem1DvlPBrOrTj5WQAsad7jg7jIWFZs
         DudsZuXKZ/acgRPoVF28KjG8iNFqW+WlREZC8mzlGunNPsarwbXt3v5KiwDA0iU/ojEP
         MBnvVFz/tpSwvzE8s8utxLDomyewTTGaPQiGwXE4u2O8o8kplqcZKJjsFvtjnml8KQr7
         trdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db0vrZDo7WsFlYNOBTLREku88rzLX5quvNYh++ykS44=;
        b=rB7aRDLPGJQXPBGY1Nw3PE1FWQLNS7XAnhQyMBH9oQSeay2+id/RoPFh65VijM8H2V
         B6Aezejx+pPdtxYHEYWrukdzTk6OUYbxHDwybDLh6PPYhjLU90jhg6C6sfeMa7y1Xejd
         27slNxbCDlNJEL2B+yZ0Vbg3JflWdmLSMBb78jIc0pS3ozMBtR7tbIzHMRsNGK2+egK/
         lN7l3+xCsMeKRcOgOdK1rn4zMOmVn7vNZrFKguRlhLsIsru517IuqzScCHV2PrjNANmR
         1fkpEWkpuaHpv0DBaMiX5/1GzRHUe4V/hETyfrSYA9DLlcknOGToyHi0M1UOunekbqkQ
         TaPQ==
X-Gm-Message-State: AOAM530k+tJcSoW3tIpVfVlyN+b39yS7aeHBmvZpLYT/QWvTxLye0Isa
        iiCh8c4SICjYWwofIw0HK3tnbg==
X-Google-Smtp-Source: ABdhPJwK/ZfrpKoQD4me4kXZQMmUD6r9dTL6RqxT02J9oY7a74DFIjK/vpop5LUMKLZhFyft+2l5Eg==
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr5788339wme.173.1622855407378;
        Fri, 04 Jun 2021 18:10:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 11/12] wcn36xx: Add host resume request support
Date:   Sat,  5 Jun 2021 02:11:39 +0100
Message-Id: <20210605011140.2004643-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit is the corresponding resume() path request to the firmware when
resuming. Unlike the suspend() version which is a unidirectional
indication, the resume version is a standard request/response.

Once the resume() request completes ipv4 ARP, ipv6 NS and GTK rekey offload
stop working and can subsequently be rolled back.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 35 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e4d5e4d597f9..c697b9f3633a 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1144,6 +1144,7 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
+		wcn36xx_smd_host_resume(wcn);
 		wcn36xx_smd_set_power_params(wcn, false);
 		wcn36xx_smd_gtk_offload_get_info(wcn, vif);
 		wcn36xx_smd_gtk_offload(wcn, vif, false);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3b4ba6edd17a..cf8e52cbdd9b 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2985,6 +2985,40 @@ int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn)
 	return ret;
 }
 
+int wcn36xx_smd_host_resume(struct wcn36xx *wcn)
+{
+	struct wcn36xx_hal_wlan_host_resume_req_msg msg_body;
+	struct wcn36xx_hal_host_resume_rsp_msg *rsp;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_RESUME_REQ);
+	msg_body.configured_mcst_bcst_filter_setting = 0;
+
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
+	if (ret) {
+		wcn36xx_err("Sending wlan_host_resume failed\n");
+		goto out;
+	}
+	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	if (ret) {
+		wcn36xx_err("wlan_host_resume err=%d\n", ret);
+		goto out;
+	}
+
+	rsp = (struct wcn36xx_hal_host_resume_rsp_msg *)wcn->hal_buf;
+	if (rsp->status)
+		wcn36xx_warn("wlan_host_resume status=%d\n", rsp->status);
+
+out:
+	mutex_unlock(&wcn->hal_mutex);
+
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
@@ -3036,6 +3070,7 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_HOST_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_RSP:
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
+	case WCN36XX_HAL_HOST_RESUME_RSP:
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 2909facdb100..d8bded03945d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -161,4 +161,6 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 
 int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
 
+int wcn36xx_smd_host_resume(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

